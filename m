Received: from eggs.gnu.org ([2001:4830:134:3::10]:52421)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1gOddK-0003aV-J1
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 02:06:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1gOddH-0007bQ-DB
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 02:06:10 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33316)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1gOddH-0007au-5n
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 02:06:07 -0500
Date: Mon, 19 Nov 2018 15:05:58 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20181119070558.GB1901@xz-x1>
References: <20181030191620.32168-1-armbru@redhat.com>
	<CAFEAcA8RdNrbCLL7tXY=e95N2Y0LcZdCPr3EuQo1_hu08qJuaQ@mail.gmail.com>
	<87sh0eyzb0.fsf@dusky.pond.sub.org> <20181107025628.GB17134@xz-x1>
	<CAFEAcA_FhkA_1DiDM2PWDw27dupsAdP==kBUxRrw5rGDnLzMwg@mail.gmail.com>
	<20181108024406.GB3170@xz-x1> <20181119061727.GA1901@xz-x1>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181119061727.GA1901@xz-x1>
Subject: Re: [Qemu-devel] [PULL 0/8] Monitor patches for 2018-10-30
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, Markus Armbruster <armbru@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

On Mon, Nov 19, 2018 at 02:17:27PM +0800, Peter Xu wrote:
> On Thu, Nov 08, 2018 at 10:44:06AM +0800, Peter Xu wrote:
> > On Wed, Nov 07, 2018 at 11:21:32AM +0000, Peter Maydell wrote:
> > > On 7 November 2018 at 02:56, Peter Xu <peterx@redhat.com> wrote:
> > > > Strange, "make check -j8" failed on my hosts (I tried two) with either
> > > > Markus's pull tree or qemu master:
> > > >
> > > > hw/core/ptimer.o: In function `timer_new_tl':
> > > > /home/xz/git/qemu/include/qemu/timer.h:536: undefined reference to `timer_init_tl'
> > > > collect2: error: ld returned 1 exit status
> > > > make: *** [/home/xz/git/qemu/rules.mak:124: tests/ptimer-test] Error 1
> > > >
> > > > Is that only happening on my hosts?
> > > 
> > > Commit 89a603a0c80ae3 changed things so that there is no
> > > timer_new_tl() or timer_init_tl() any more, so if you have
> > > an object file that's referring to it then it's probably
> > > stale. Try a make clean.
> > 
> > Yeh it worked for me, thanks Peter.
> > 
> > Though after running a few more rounds of "configure --enable-debug &&
> > make check -j8" I still cannot see anything wrong with Markus's tree.
> > I'll see whether there's any news from Markus and then I'll consider
> > whether I should install a FreeBSD.
> 
> I reproduced the error with a FreeBSD guest and this change (which
> possibly can be squashed into "tests: qmp-test: add queue full test")
> worked for me:
> 
> diff --git a/tests/qmp-test.c b/tests/qmp-test.c
> index 6989acbca4..83f353db4f 100644
> --- a/tests/qmp-test.c
> +++ b/tests/qmp-test.c
> @@ -281,8 +281,15 @@ static void test_qmp_oob(void)
>       * will only be able to be handled after the queue is shrinked, so
>       * it'll be processed only after one existing in-band command
>       * finishes.
> +     *
> +     * NOTE: we need to feed the queue with one extra request to make
> +     * sure it'll be stuck since when we have sent the Nth request
> +     * it's possible that we have already popped and processing the
> +     * 1st request so the Nth request (which could potentially be the
> +     * [N-1]th element on the queue) might not trigger the
> +     * monitor-full condition deterministically.
>       */
> -    for (i = 1; i <= QMP_REQ_QUEUE_LEN_MAX; i++) {
> +    for (i = 1; i <= QMP_REQ_QUEUE_LEN_MAX + 1; i++) {
>          id = g_strdup_printf("queue-blocks-%d", i);
>          send_cmd_that_blocks(qts, id);
>          g_free(id);
> @@ -291,7 +298,7 @@ static void test_qmp_oob(void)
>      unblock_blocked_cmd();
>      recv_cmd_id(qts, "queue-blocks-1");
>      recv_cmd_id(qts, "oob-1");
> -    for (i = 2; i <= QMP_REQ_QUEUE_LEN_MAX; i++) {
> +    for (i = 2; i <= QMP_REQ_QUEUE_LEN_MAX + 1; i++) {
>          unblock_blocked_cmd();
>          id = g_strdup_printf("queue-blocks-%d", i);
>          recv_cmd_id(qts, id);
> 
> So the problem here is that the queue-block-N command might not really
> suspend the monitor everytime if we already popped the 1st request,
> which will let the N-th request to be (N-1)th, then the parser will
> continue to eat the oob command and it could "preempt" the previous
> commands.
> 
> Maybe FreeBSD is scheduling the threads in some pattern so it happens
> only on FreeBSD and very constantly, but anyway it should be a general
> fix to the test program.

Markus, do you want me to repost a new version with this change?  Is
it still possible to have the oob-default series for 3.1?

-- 
Peter Xu
