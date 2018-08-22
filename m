Received: from eggs.gnu.org ([2001:4830:134:3::10]:55556)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fsNgu-0008GW-Tv
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 03:36:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fsNgq-0000bv-Rm
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 03:36:32 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:33396 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1fsNgk-0000Xw-5V
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 03:36:25 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 5641840201C0
	for <qemu-devel@nongnu.org>; Wed, 22 Aug 2018 07:36:20 +0000 (UTC)
References: <20180821190516.264411-1-eblake@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <2cbe2b1d-d2e8-beec-94b0-3e8c93955588@redhat.com>
Date: Wed, 22 Aug 2018 09:36:18 +0200
MIME-Version: 1.0
In-Reply-To: <20180821190516.264411-1-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] tests/libqos: Utilize newer glib spawn
 check
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <lvivier@redhat.com>

On 2018-08-21 21:05, Eric Blake wrote:
> During development, I got a 'make check' failure that claimed:
> 
> qemu-img returned status code 32512
> **
> ERROR:tests/libqos/libqos.c:202:mkimg: assertion failed: (!rc)
> 
> But 32512 is too big for a normal exit status value, which means we
> failed to use WEXITSTATUS() to shift the bits to the desired value
> for printing.  However, instead of worrying about how to portably
> parse g_spawn()'s rc in the proper platform-dependent manner, it's
> better to just rely on the fact that we now require glib 2.40 (since
> commit e7b3af815) and can therefore use glib's portable checker
> instead, where the message under my same condition improves to:
> 
> Child process exited with code 127
> **
> ERROR:tests/libqos/libqos.c:192:mkimg: assertion failed: (ret && !err)
> 
> Signed-off-by: Eric Blake <eblake@redhat.com>
> 
> ---
> This appears to be the only remaining vestige of a comment mentioning
> glib < 2.40.
> ---
>  tests/libqos/libqos.c | 12 +-----------
>  1 file changed, 1 insertion(+), 11 deletions(-)
> 
> diff --git a/tests/libqos/libqos.c b/tests/libqos/libqos.c
> index 013ca68581c..c5141873448 100644
> --- a/tests/libqos/libqos.c
> +++ b/tests/libqos/libqos.c
> @@ -185,22 +185,12 @@ void mkimg(const char *file, const char *fmt, unsigned size_mb)
>      cli = g_strdup_printf("%s create -f %s %s %uM", qemu_img_abs_path,
>                            fmt, file, size_mb);
>      ret = g_spawn_command_line_sync(cli, &out, &out2, &rc, &err);
> -    if (err) {
> +    if (err || !g_spawn_check_exit_status(rc, &err)) {
>          fprintf(stderr, "%s\n", err->message);
>          g_error_free(err);
>      }
>      g_assert(ret && !err);
> 
> -    /* In glib 2.34, we have g_spawn_check_exit_status. in 2.12, we don't.
> -     * glib 2.43.91 implementation assumes that any non-zero is an error for
> -     * windows, but uses extra precautions for Linux. However,
> -     * 0 is only possible if the program exited normally, so that should be
> -     * sufficient for our purposes on all platforms, here. */
> -    if (rc) {
> -        fprintf(stderr, "qemu-img returned status code %d\n", rc);
> -    }
> -    g_assert(!rc);
> -
>      g_free(out);
>      g_free(out2);
>      g_free(cli);
> 

Reviewed-by: Thomas Huth <thuth@redhat.com>
