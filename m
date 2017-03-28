Received: from eggs.gnu.org ([2001:4830:134:3::10]:58151)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1csrCL-0000Ta-6E
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 09:30:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1csrCI-00010A-31
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 09:30:09 -0400
Received: from mail-qt0-x241.google.com ([2607:f8b0:400d:c0d::241]:33026)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1csrCH-000100-UV
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 09:30:06 -0400
Received: by mail-qt0-x241.google.com with SMTP id r45so12041428qte.0
	for <qemu-devel@nongnu.org>; Tue, 28 Mar 2017 06:30:05 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1490694017-7532-1-git-send-email-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <a08258bf-9da9-7d90-bcfd-5e4156805557@amsat.org>
Date: Tue, 28 Mar 2017 10:30:01 -0300
MIME-Version: 1.0
In-Reply-To: <1490694017-7532-1-git-send-email-peter.maydell@linaro.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH for-2.9 v2] tests/bios-tables-test: Don't
 pass addresses of packed struct fields
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Igor Mammedov <imammedo@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, patches@linaro.org

Hi Peter,

On 03/28/2017 06:40 AM, Peter Maydell wrote:
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

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
> v1->v2 changes: put the assignments after we check the error
> status of the glib function, rather than before (makes no
> practical difference since we will just assert out anyway,
> but logically the right way round.)
>
>  tests/bios-tables-test.c | 28 ++++++++++++++++++++--------
>  1 file changed, 20 insertions(+), 8 deletions(-)
>
> diff --git a/tests/bios-tables-test.c b/tests/bios-tables-test.c
> index 88dbf97..a519921 100644
> --- a/tests/bios-tables-test.c
> +++ b/tests/bios-tables-test.c
> @@ -261,8 +261,11 @@ static void dump_aml_files(test_data *data, bool rebuild)
>              fd = g_open(aml_file, O_WRONLY|O_TRUNC|O_CREAT,
>                          S_IRUSR|S_IWUSR|S_IRGRP|S_IWGRP|S_IROTH);
>          } else {
> -            fd = g_file_open_tmp("aml-XXXXXX", &sdt->aml_file, &error);
> +            gchar *name;

should we add some comment like /* local variable used to avoid 
alignment issues */ in case later one find it clever to save few bytes 
on stack without reading git history?

> +
> +            fd = g_file_open_tmp("aml-XXXXXX", &name, &error);
>              g_assert_no_error(error);
> +            sdt->aml_file = name;
>          }
>          g_assert(fd >= 0);
>
> @@ -291,9 +294,11 @@ static bool load_asl(GArray *sdts, AcpiSdtTable *sdt)
>      gchar *out, *out_err;
>      gboolean ret;
>      int i;
> +    gchar *name;
>
> -    fd = g_file_open_tmp("asl-XXXXXX.dsl", &sdt->asl_file, &error);
> +    fd = g_file_open_tmp("asl-XXXXXX.dsl", &name, &error);
>      g_assert_no_error(error);
> +    sdt->asl_file = name;
>      close(fd);
>
>      /* build command line */
> @@ -314,10 +319,14 @@ static bool load_asl(GArray *sdts, AcpiSdtTable *sdt)
>      ret = g_spawn_command_line_sync(command_line->str, &out, &out_err, NULL, &error);
>      g_assert_no_error(error);
>      if (ret) {
> -        ret = g_file_get_contents(sdt->asl_file, (gchar **)&sdt->asl,
> -                                  &sdt->asl_len, &error);
> +        gchar *contents;
> +        gsize len;
> +
> +        ret = g_file_get_contents(sdt->asl_file, &contents, &len, &error);
>          g_assert(ret);
>          g_assert_no_error(error);
> +        sdt->asl = contents;
> +        sdt->asl_len = len;
>          ret = (sdt->asl_len > 0);
>      }
>
> @@ -371,6 +380,8 @@ static GArray *load_expected_aml(test_data *data)
>          uint32_t signature;
>          gchar *aml_file = NULL;
>          const char *ext = data->variant ? data->variant : "";
> +        gchar *aml_contents;
> +        gsize aml_length;
>
>          sdt = &g_array_index(data->tables, AcpiSdtTable, i);
>
> @@ -397,12 +408,13 @@ try_again:
>          if (getenv("V")) {
>              fprintf(stderr, "\nUsing expected file '%s'\n", aml_file);
>          }
> -        ret = g_file_get_contents(aml_file, &exp_sdt.aml,
> -                                  &exp_sdt.aml_len, &error);
> +        ret = g_file_get_contents(aml_file, &aml_contents, &aml_length, &error);
>          g_assert(ret);
>          g_assert_no_error(error);
> -        g_assert(exp_sdt.aml);
> -        g_assert(exp_sdt.aml_len);
> +        g_assert(aml_contents);
> +        g_assert(aml_length);
> +        exp_sdt.aml = aml_contents;
> +        exp_sdt.aml_len = aml_length;
>
>          g_array_append_val(exp_tables, exp_sdt);
>      }
>
