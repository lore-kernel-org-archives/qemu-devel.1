Received: from eggs.gnu.org ([2001:4830:134:3::10]:34222)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fhr3o-00040P-S0
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 02:44:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fhr3l-0000rH-So
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 02:44:40 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:39414 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1fhr3l-0000r2-Mc
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 02:44:37 -0400
References: <20180723193530.20891-1-eblake@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <a040b798-b864-c48a-2a8c-c19565f262ca@redhat.com>
Date: Tue, 24 Jul 2018 08:44:33 +0200
MIME-Version: 1.0
In-Reply-To: <20180723193530.20891-1-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 for-3.0] tests/libqtest: Improve
 kill_qemu()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, rth@twiddle.net, alex.bennee@linaro.org, f4bug@amsat.org, mst@redhat.com

On 23.07.2018 21:35, Eric Blake wrote:
> In kill_qemu() we have an assert that checks that the QEMU process
> didn't dump core:
>             assert(!WCOREDUMP(wstatus));
> 
> Unfortunately the WCOREDUMP macro here means the resulting message
> is not very easy to comprehend on at least some systems:
> 
> ahci-test: tests/libqtest.c:113: kill_qemu: Assertion `!(((__extension__ (((union { __typeof(wstatus) __in; int __i; }) { .__in = (wstatus) }).__i))) & 0x80)' failed.
> 
> and it doesn't identify what signal the process took.
> 
> Furthermore, we are NOT detecting EINTR (while EINTR shouldn't be
> happening if we didn't install signal handlers, it's still better
> to always be robust), and also want to log unexpected non-zero status
> that was not accompanied by a core dump.
> 
> Instead of using a raw assert, print the information in an
> easier to understand way:
> 
> /i386/ahci/sanity: tests/libqtest.c:119: kill_qemu() detected QEMU death with core dump from signal 11 (Segmentation fault)
> Aborted (core dumped)
> 
> (Of course, the really useful information would be why the QEMU
> process dumped core in the first place, but we don't have that
> by the time the test program has picked up the exit status.)
> 
> Suggested-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
> 
> I've taken the ideas from Peter's patch:
> https://lists.gnu.org/archive/html/qemu-devel/2018-07/msg04430.html
> as well as fixing a related issue brought up last time this was touched:
> https://lists.gnu.org/archive/html/qemu-devel/2018-05/msg05710.html
> 
>  tests/libqtest.c | 39 +++++++++++++++++++++++++++++++++++++--
>  1 file changed, 37 insertions(+), 2 deletions(-)
> 
> diff --git a/tests/libqtest.c b/tests/libqtest.c
> index 098af6aec44..f3dabfadd78 100644
> --- a/tests/libqtest.c
> +++ b/tests/libqtest.c
> @@ -105,12 +105,47 @@ static void kill_qemu(QTestState *s)
>      if (s->qemu_pid != -1) {
>          int wstatus = 0;
>          pid_t pid;
> +        bool die = false;
> 
>          kill(s->qemu_pid, SIGTERM);
> +    retry:
>          pid = waitpid(s->qemu_pid, &wstatus, 0);
> +        if (pid == -1 && errno == EINTR) {
> +            goto retry;
> +        }

    do {
        pid = waitpid(s->qemu_pid, &wstatus, 0);
    } while (pid == -1 && errno == EINTR);

?

Or use the TFR macro from include/qemu-common.h ?

 Thomas
