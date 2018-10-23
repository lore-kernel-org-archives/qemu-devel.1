Received: from eggs.gnu.org ([2001:4830:134:3::10]:57278)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lfy@google.com>) id 1gEyDh-0002WS-26
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 11:03:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lfy@google.com>) id 1gEyDe-00072Q-LD
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 11:03:44 -0400
Received: from mail-qk1-x735.google.com ([2607:f8b0:4864:20::735]:33771)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <lfy@google.com>) id 1gEyDe-0006KP-CS
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 11:03:42 -0400
Received: by mail-qk1-x735.google.com with SMTP id o89so1026447qko.0
	for <qemu-devel@nongnu.org>; Tue, 23 Oct 2018 08:03:03 -0700 (PDT)
MIME-Version: 1.0
References: <CAEkmjvWv=CCf-Y4kDqG=Z-Fb2jPBUBVzHzy69rTxDinPZQ72YQ@mail.gmail.com>
	<cc2c7265-193c-257f-6594-6d538133b8b2@redhat.com>
In-Reply-To: <cc2c7265-193c-257f-6594-6d538133b8b2@redhat.com>
From: Frank Yang <lfy@google.com>
Date: Tue, 23 Oct 2018 08:02:51 -0700
Message-ID: <CAEkmjvWGiCoQDXxdNXAsbZOkmxo-H6-yw10nYp3ffGt6cVCEtQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] QEMU hangs in main_loop_wait
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>

We don't yet have visibility into that, but is there a way to enumerate
what callbacks are running? We see that sometimes, actually qemu_poll_ns
takes much, much longer than the specified timeout to return:

    qemu_mutex_unlock_iothread();
    replay_mutex_unlock();

    struct timeval tv;
    gettimeofday(&tv, NULL);

    uint64_t start_us = tv.tv_usec + tv.tv_sec * 1000000LL;
    uint64_t duration = 0;
        ret = qemu_poll_ns((GPollFD *)gpollfds->data, gpollfds->len,
timeout);
        gettimeofday(&tv, NULL);
        uint64_t end_us = tv.tv_usec + tv.tv_sec * 1000000LL;
        duration = end_us - start_us;

    if (duration > 100000LL) {
        fprintf(stderr, "%s: polled for %f ms (timeout: %f ms) ret: %d
nfds: %d\n", __func__, duration / 1000.0f, timeout / 1000000.0f, ret,
gpollfds->len);
    }

prints:

os_host_main_loop_wait: polled for 580.517029 ms (timeout: 6.150904 ms)
ret: 1 nfds: 50
os_host_main_loop_wait: polled for 10001.063477 ms (timeout: 1.277816 ms)
ret: 0 nfds: 50
os_host_main_loop_wait: polled for 792.466003 ms (timeout: 0.149536 ms)
ret: 1 nfds: 47
os_host_main_loop_wait: polled for 8359.308594 ms (timeout: 1.791392 ms)
ret: 1 nfds: 47
os_host_main_loop_wait: polled for 2478.096924 ms (timeout: 5.850920 ms)
ret: 1 nfds: 47
os_host_main_loop_wait: polled for 139.272995 ms (timeout: 5.442976 ms)
ret: 1 nfds: 47
os_host_main_loop_wait: polled for 10001.864258 ms (timeout: 1.946600 ms)
ret: 0 nfds: 47


On Wed, Oct 17, 2018 at 10:03 AM Paolo Bonzini <pbonzini@redhat.com> wrote:

> On 17/10/2018 17:44, Frank Yang wrote:
> >
> > we are not seeing hangs in flatview_do_translate, but are still getting
> > hangs in main-loop:
> >
> >     qemu_mutex_unlock_iothread();
> >     replay_mutex_unlock();
> >
> >     ret = qemu_poll_ns((GPollFD *)gpollfds->data, gpollfds->len,
> > timeout); <-------------this seems to be the hanging part
> >
> >     replay_mutex_lock();
> >     qemu_mutex_lock_iothread();
> >
> > Any idea how to diagnose the cause of taking too much time in g_poll in
> > qemu_poll_ns?
>
> Is there any event (timer or file descriptor) that you know should be
> ready, but is not causing a wakeup?
>
> Paolo
>
