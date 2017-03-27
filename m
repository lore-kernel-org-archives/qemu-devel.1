Received: from eggs.gnu.org ([2001:4830:134:3::10]:44322)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1csZfd-0000Ca-K6
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 14:47:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1csZfY-0006Yw-T3
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 14:47:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42402)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1csZfY-0006Ym-KU
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 14:47:08 -0400
Date: Mon, 27 Mar 2017 21:47:03 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20170327214256-mutt-send-email-mst@kernel.org>
References: <1490638725-19939-1-git-send-email-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1490638725-19939-1-git-send-email-peter.maydell@linaro.org>
Subject: Re: [Qemu-devel] [PATCH for-2.9] tests/bios-tables-test: Don't pass
 addresses of packed struct fields
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, patches@linaro.org, Igor Mammedov <imammedo@redhat.com>

On Mon, Mar 27, 2017 at 07:18:45PM +0100, Peter Maydell wrote:
> Passing the address of a field in a packed struct to a function
> that expects a pointer to normally aligned data will result in
> a SEGBUS on architectures like SPARC that have strict alignment
> requirements.
> 
> Pass addresses of local variables rather than addresses of packed
> structure fields to glib functions like g_file_get_contents() to
> avoid this bug.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

I wonder why do we pack the sdt structure. some more comments below.


> ---
>  tests/bios-tables-test.c | 24 ++++++++++++++++++------
>  1 file changed, 18 insertions(+), 6 deletions(-)
> 
> diff --git a/tests/bios-tables-test.c b/tests/bios-tables-test.c
> index 88dbf97..e9a5092 100644
> --- a/tests/bios-tables-test.c
> +++ b/tests/bios-tables-test.c
> @@ -261,7 +261,10 @@ static void dump_aml_files(test_data *data, bool rebuild)
>              fd = g_open(aml_file, O_WRONLY|O_TRUNC|O_CREAT,
>                          S_IRUSR|S_IWUSR|S_IRGRP|S_IWGRP|S_IROTH);
>          } else {
> -            fd = g_file_open_tmp("aml-XXXXXX", &sdt->aml_file, &error);
> +            gchar *name;
> +
> +            fd = g_file_open_tmp("aml-XXXXXX", &name, &error);
> +            sdt->aml_file = name;
>              g_assert_no_error(error);
>          }
>          g_assert(fd >= 0);

Let's move these assignments to after we tested the ret value?
Same with all other cases.

> @@ -291,8 +294,10 @@ static bool load_asl(GArray *sdts, AcpiSdtTable *sdt)
>      gchar *out, *out_err;
>      gboolean ret;
>      int i;
> +    gchar *name;
>  
> -    fd = g_file_open_tmp("asl-XXXXXX.dsl", &sdt->asl_file, &error);
> +    fd = g_file_open_tmp("asl-XXXXXX.dsl", &name, &error);
> +    sdt->asl_file = name;
>      g_assert_no_error(error);
>      close(fd);
>  
> @@ -314,8 +319,12 @@ static bool load_asl(GArray *sdts, AcpiSdtTable *sdt)
>      ret = g_spawn_command_line_sync(command_line->str, &out, &out_err, NULL, &error);
>      g_assert_no_error(error);
>      if (ret) {
> -        ret = g_file_get_contents(sdt->asl_file, (gchar **)&sdt->asl,
> -                                  &sdt->asl_len, &error);
> +        gchar *contents;
> +        gsize len;
> +
> +        ret = g_file_get_contents(sdt->asl_file, &contents, &len, &error);
> +        sdt->asl = contents;
> +        sdt->asl_len = len;
>          g_assert(ret);
>          g_assert_no_error(error);
>          ret = (sdt->asl_len > 0);
> @@ -371,6 +380,8 @@ static GArray *load_expected_aml(test_data *data)
>          uint32_t signature;
>          gchar *aml_file = NULL;
>          const char *ext = data->variant ? data->variant : "";
> +        gchar *aml_contents;
> +        gsize aml_length;
>  
>          sdt = &g_array_index(data->tables, AcpiSdtTable, i);
>  
> @@ -397,8 +408,9 @@ try_again:
>          if (getenv("V")) {
>              fprintf(stderr, "\nUsing expected file '%s'\n", aml_file);
>          }
> -        ret = g_file_get_contents(aml_file, &exp_sdt.aml,
> -                                  &exp_sdt.aml_len, &error);
> +        ret = g_file_get_contents(aml_file, &aml_contents, &aml_length, &error);
> +        exp_sdt.aml = aml_contents;
> +        exp_sdt.aml_len = aml_length;
>          g_assert(ret);
>          g_assert_no_error(error);
>          g_assert(exp_sdt.aml);
> -- 
> 2.7.4
