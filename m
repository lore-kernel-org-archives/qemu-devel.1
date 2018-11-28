Received: from eggs.gnu.org ([2001:4830:134:3::10]:44250)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gRzLu-0000RC-Px
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 07:54:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gRzLp-0000gL-P5
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 07:54:02 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58108)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gRzLp-0000fP-Gt
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 07:53:57 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <20181128103308.26755-1-fli@suse.com>
	<20181128103308.26755-2-fli@suse.com>
Date: Wed, 28 Nov 2018 13:53:52 +0100
In-Reply-To: <20181128103308.26755-2-fli@suse.com> (Fei Li's message of "Wed,
	28 Nov 2018 18:33:04 +0800")
Message-ID: <87sgzle527.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH RFC 1/5] Fix segmentation fault when
 qemu_signal_init fails
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fei Li <fli@suse.com>
Cc: qemu-devel@nongnu.org, Fam Zheng <famz@redhat.com>

Fei Li <fli@suse.com> writes:

> When qemu_signal_init() fails in qemu_init_main_loop(), we return
> without setting an error.  Its callers crash then when they try to
> report the error with error_report_err().

Yes, that's a bug.  Broken in 2f78e491d7b, v2.2.0.  Has escaped notice
since qemu_signalfd() is quite unlikely to fail.  Could go into 3.1 as a
bug fix, but I think punting it to the next release is just fine.

> To avoid such segmentation fault, add a new Error parameter to make
> the call trace to propagate the err to the final caller.
>

Let's add:

  Fixes: 2f78e491d7b46542158ce0b8132ee4e05bc0ade4

> Cc: Markus Armbruster <armbru@redhat.com>
> Cc: Fam Zheng <famz@redhat.com>
> Signed-off-by: Fei Li <fli@suse.com>
> Reviewed-by: Fam Zheng <famz@redhat.com>
> ---
>  util/main-loop.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/util/main-loop.c b/util/main-loop.c
> index affe0403c5..443cb4cfe8 100644
> --- a/util/main-loop.c
> +++ b/util/main-loop.c
> @@ -71,7 +71,7 @@ static void sigfd_handler(void *opaque)
>      }
>  }
>  
> -static int qemu_signal_init(void)
> +static int qemu_signal_init(Error **errp)
>  {
>      int sigfd;
>      sigset_t set;
> @@ -96,7 +96,7 @@ static int qemu_signal_init(void)
>      sigdelset(&set, SIG_IPI);
>      sigfd = qemu_signalfd(&set);
>      if (sigfd == -1) {
> -        fprintf(stderr, "failed to create signalfd\n");
> +        error_setg_errno(errp, errno, "failed to create signalfd");
>          return -errno;
>      }
>  
> @@ -109,7 +109,7 @@ static int qemu_signal_init(void)
>  
>  #else /* _WIN32 */
>  
> -static int qemu_signal_init(void)
> +static int qemu_signal_init(Error **errp)
>  {
>      return 0;
>  }
> @@ -148,7 +148,7 @@ int qemu_init_main_loop(Error **errp)
>  
>      init_clocks(qemu_timer_notify_cb);
>  
> -    ret = qemu_signal_init();
> +    ret = qemu_signal_init(errp);
>      if (ret) {
>          return ret;
>      }

Reviewed-by: Markus Armbruster <armbru@redhat.com>
