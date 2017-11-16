Received: from eggs.gnu.org ([2001:4830:134:3::10]:43030)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1eFMPW-0005sz-3a
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 10:49:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1eFMPR-0000TY-7g
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 10:49:02 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49268)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1eFMPR-0000SO-0x
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 10:48:57 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 168F85BDC3
	for <qemu-devel@nongnu.org>; Thu, 16 Nov 2017 15:48:56 +0000 (UTC)
Date: Thu, 16 Nov 2017 17:48:55 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20171116174731-mutt-send-email-mst@kernel.org>
References: <20171018131529.19453-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171018131529.19453-1-berrange@redhat.com>
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
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Igor Mammedov <imammedo@redhat.com>

On Wed, Oct 18, 2017 at 02:15:28PM +0100, Daniel P. Berrange wrote:
> If iasl exits with non-zero status, the test unhelpfully just reports
> that the AML did not match, because the data files it thought iasl
> generated do not exist. This adds an explicit check for the exit status
> of iasl and prints stderr if it was non-zero. Thus gives us a fighting
> chance of diagnosing why iasl failed.
> 
> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>

Given the state of iasl, I'm not sure this will not
give false positives where iasl returns an error status
but does produce a valid input.

I propose this is reworked to just add a warning about the
bad status, but still attempt to process the file.


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
> -- 
> 2.13.6
