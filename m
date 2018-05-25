Received: from eggs.gnu.org ([2001:4830:134:3::10]:41318)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fMDNj-00027f-IO
	for qemu-devel@nongnu.org; Fri, 25 May 2018 10:07:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fMDNe-00031l-Gg
	for qemu-devel@nongnu.org; Fri, 25 May 2018 10:07:47 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:50814 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1fMDNe-00031X-C2
	for qemu-devel@nongnu.org; Fri, 25 May 2018 10:07:42 -0400
Date: Fri, 25 May 2018 17:07:41 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180525170512-mutt-send-email-mst@kernel.org>
References: <1527186303-192100-1-git-send-email-mst@redhat.com>
	<1527186303-192100-4-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1527186303-192100-4-git-send-email-mst@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v4 3/3] libqtest: add more exit status
 checks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Eric Blake <eblake@redhat.com>, Thomas Huth <thuth@redhat.com>, Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>, Markus Armbruster <armbru@redhat.com>

On Thu, May 24, 2018 at 09:25:28PM +0300, Michael S. Tsirkin wrote:
> Add more checks on how did QEMU exit.
> 
> Legal ways to exit right now:
> - exit(0) or return from main
> - kill(SIGTERM) - sent by testing infrastructure
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---

This turned out to be messy since
- abort itself might trigger a signal
- waitpid might in theory get interrupted

I'll drop this patch for now, and merge just patches 1 and 2
in my tree.

>  tests/libqtest.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/tests/libqtest.c b/tests/libqtest.c
> index f869854..36ca859 100644
> --- a/tests/libqtest.c
> +++ b/tests/libqtest.c
> @@ -109,9 +109,19 @@ static void kill_qemu(QTestState *s)
>          kill(s->qemu_pid, SIGTERM);
>          pid = waitpid(s->qemu_pid, &wstatus, 0);
>  
> -        if (pid == s->qemu_pid && WIFSIGNALED(wstatus)) {
> +        /* waitpid returns child PID on success */
> +        assert(pid == s->qemu_pid);
> +
> +        /* If exited on signal - check the reason: core dump is never OK */
> +        if (WIFSIGNALED(wstatus)) {
>              assert(!WCOREDUMP(wstatus));
>          }
> +        /* If exited normally - check exit status */
> +        if (WIFEXITED(wstatus)) {
> +            assert(!WEXITSTATUS(wstatus));
> +        }
> +        /* Valid ways to exit: right now only return from main or exit */
> +        assert(WIFEXITED(wstatus));
>      }
>  }
>  
> -- 
> MST
> 
