Received: from eggs.gnu.org ([2001:4830:134:3::10]:60017)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e4wFZ-0006ph-H2
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 17:51:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e4wFW-0005MQ-EY
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 17:51:41 -0400
Received: from mail-qk0-x244.google.com ([2607:f8b0:400d:c09::244]:48819)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e4wFW-0005MD-9S
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 17:51:38 -0400
Received: by mail-qk0-x244.google.com with SMTP id d67so8130069qkg.5
	for <qemu-devel@nongnu.org>; Wed, 18 Oct 2017 14:51:38 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20171018131529.19453-1-berrange@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <bac792f1-bd27-f93c-6f95-32eb3db284fb@amsat.org>
Date: Wed, 18 Oct 2017 18:51:34 -0300
MIME-Version: 1.0
In-Reply-To: <20171018131529.19453-1-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] tests: report errors when iasl exits with
 non-zero status
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: Igor Mammedov <imammedo@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>

On 10/18/2017 10:15 AM, Daniel P. Berrange wrote:
> If iasl exits with non-zero status, the test unhelpfully just reports
> that the AML did not match, because the data files it thought iasl
> generated do not exist. This adds an explicit check for the exit status
> of iasl and prints stderr if it was non-zero. Thus gives us a fighting
> chance of diagnosing why iasl failed.
> 
> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  tests/bios-tables-test.c | 24 ++++++++++++++++++------
>  1 file changed, 18 insertions(+), 6 deletions(-)
> 
> diff --git a/tests/bios-tables-test.c b/tests/bios-tables-test.c
> index 564da45f65..ee441f1e17 100644
> --- a/tests/bios-tables-test.c
> +++ b/tests/bios-tables-test.c
> @@ -304,6 +304,7 @@ static bool load_asl(GArray *sdts, AcpiSdtTable *sdt)
>      gchar *out, *out_err;
>      gboolean ret;
>      int i;
> +    int status;
>  
>      fd = g_file_open_tmp("asl-XXXXXX.dsl", &sdt->asl_file, &error);
>      g_assert_no_error(error);
> @@ -324,14 +325,25 @@ static bool load_asl(GArray *sdts, AcpiSdtTable *sdt)
>      g_string_append_printf(command_line, "-d %s", sdt->aml_file);
>  
>      /* pass 'out' and 'out_err' in order to be redirected */
> -    ret = g_spawn_command_line_sync(command_line->str, &out, &out_err, NULL, &error);
> +    ret = g_spawn_command_line_sync(command_line->str, &out, &out_err, &status, &error);
>      g_assert_no_error(error);
>      if (ret) {
> -        ret = g_file_get_contents(sdt->asl_file, (gchar **)&sdt->asl,
> -                                  &sdt->asl_len, &error);
> -        g_assert(ret);
> -        g_assert_no_error(error);
> -        ret = (sdt->asl_len > 0);
> +        if (status != 0) {
> +            g_printerr("'%s' exited with status %d", command_line->str, status);
> +            if (!g_str_equal(out, "")) {
> +                g_printerr("%s", out);
> +            }
> +            if (!g_str_equal(out_err, "")) {
> +                g_printerr("%s", out_err);
> +            }
> +            ret = FALSE;
> +        } else {
> +            ret = g_file_get_contents(sdt->asl_file, (gchar **)&sdt->asl,
> +                                      &sdt->asl_len, &error);
> +            g_assert(ret);
> +            g_assert_no_error(error);
> +            ret = (sdt->asl_len > 0);
> +        }
>      }
>  
>      g_free(out);
> 
