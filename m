Received: from eggs.gnu.org ([2001:4830:134:3::10]:36972)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fLrUo-0002Je-Fw
	for qemu-devel@nongnu.org; Thu, 24 May 2018 10:45:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fLrUl-00046O-B7
	for qemu-devel@nongnu.org; Thu, 24 May 2018 10:45:38 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:56784 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1fLrUl-00045z-6e
	for qemu-devel@nongnu.org; Thu, 24 May 2018 10:45:35 -0400
References: <1527172175-129517-1-git-send-email-mst@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <6b3cad0d-b849-6ba9-64cb-6a36a37cd19d@redhat.com>
Date: Thu, 24 May 2018 16:45:31 +0200
MIME-Version: 1.0
In-Reply-To: <1527172175-129517-1-git-send-email-mst@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] libqtest: fail if child coredumps
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org
Cc: Eric Blake <eblake@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Markus Armbruster <armbru@redhat.com>, Tiwei Bie <tiwei.bie@intel.com>

On 24.05.2018 16:30, Michael S. Tsirkin wrote:
> Right now tests report OK status if QEMU crashes during cleanup.
> Let's catch that case and fail the test.
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  tests/libqtest.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/tests/libqtest.c b/tests/libqtest.c
> index 43fb97e..f869854 100644
> --- a/tests/libqtest.c
> +++ b/tests/libqtest.c
> @@ -103,8 +103,15 @@ static int socket_accept(int sock)
>  static void kill_qemu(QTestState *s)
>  {
>      if (s->qemu_pid != -1) {
> +        int wstatus = 0;
> +        pid_t pid;
> +
>          kill(s->qemu_pid, SIGTERM);
> -        waitpid(s->qemu_pid, NULL, 0);
> +        pid = waitpid(s->qemu_pid, &wstatus, 0);
> +
> +        if (pid == s->qemu_pid && WIFSIGNALED(wstatus)) {
> +            assert(!WCOREDUMP(wstatus));
> +        }
>      }
>  }

That's basically a good idea ... but I've already seen yet another issue
in the past already: QEMU sometimes simply hangs in an endless loop
during clean up and never terminates. I think we should detect that
situation, too.

So instead of killing QEMU at the end of the testing, I think we should
rather try to terminate it with the QMP "quit" command. If QEMU does not
terminate with an exit code of 0, then the test should be flagged a
failed (and only if QEMU did not terminate at all, it should be killed
with SIGKILL).

 Thomas
