Received: from eggs.gnu.org ([2001:4830:134:3::10]:49261)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1fzEsi-0006pF-DW
	for qemu-devel@nongnu.org; Mon, 10 Sep 2018 01:37:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1fzEse-00022X-9j
	for qemu-devel@nongnu.org; Mon, 10 Sep 2018 01:37:04 -0400
Received: from mail.ispras.ru ([83.149.199.45]:52028)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1fzEse-0001zg-0V
	for qemu-devel@nongnu.org; Mon, 10 Sep 2018 01:37:00 -0400
From: "Pavel Dovgalyuk" <dovgaluk@ispras.ru>
References: <20180820150903.1224-4-pbonzini@redhat.com>
	<000001d43ea0$02146ed0$063d4c70$@ru>
	<5b9a85eb-cefd-925c-b24b-95b93bbbfce8@redhat.com>
In-Reply-To: <5b9a85eb-cefd-925c-b24b-95b93bbbfce8@redhat.com>
Date: Mon, 10 Sep 2018 08:36:57 +0300
Message-ID: <000a01d448c8$4a55c0e0$df0142a0$@ru>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Language: ru
Subject: Re: [Qemu-devel] [3/4] cpus: protect TimerState writes with a
 spinlock
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: 'Paolo Bonzini' <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: "'Emilio G . Cota'" <cota@braap.org>

> From: Paolo Bonzini [mailto:pbonzini@redhat.com]
> On 28/08/2018 09:23, Pavel Dovgalyuk wrote:
> > Hi, Paolo!
> >
> > Seems that this one breaks the record/replay.
> 
> What are the symptoms?

Please look below.

> >> From: Paolo Bonzini [mailto:pbonzini@redhat.com]
> >> In the next patch, we will need to write cpu_ticks_offset from any
> >> thread, even outside the BQL.  Currently, it is protected by the BQL
> >> just because cpu_enable_ticks and cpu_disable_ticks happen to hold it,
> >> but the critical sections are well delimited and it's easy to remove
> >> the BQL dependency.
> >>
> >> Add a spinlock that matches vm_clock_seqlock, and hold it when writing
> >> to the TimerState.  This also lets us fix cpu_update_icount when 64-bit
> >> atomics are not available.
> >>
> >> Fields of TiemrState are reordered to avoid padding.
> >>
> >> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> >> ---
> >>  cpus.c | 72 ++++++++++++++++++++++++++++++++++++++--------------------
> >>  1 file changed, 47 insertions(+), 25 deletions(-)
> >>


Here is the description:

> >>  static void icount_adjust_rt(void *opaque)
> >> @@ -480,7 +494,8 @@ static void icount_warp_rt(void)
> >>          return;
> >>      }
> >>
> >> -    seqlock_write_begin(&timers_state.vm_clock_seqlock);
> >> +    seqlock_write_lock(&timers_state.vm_clock_seqlock,
> >> +                       &timers_state.vm_clock_lock);
> >
> > After locking here,
> >
> >>      if (runstate_is_running()) {
> >>          int64_t clock = REPLAY_CLOCK(REPLAY_CLOCK_VIRTUAL_RT,
> >>                                       cpu_get_clock_locked());
> >
> > REPLAY_CLOCK can't request icount with cpu_get_icount_raw, because
> > it loops infinitely here:
> >
> >     do {
> >         start = seqlock_read_begin(&timers_state.vm_clock_seqlock);
> >         icount = cpu_get_icount_raw_locked();
> >     } while (seqlock_read_retry(&timers_state.vm_clock_seqlock, start));
> >
> >



Pavel Dovgalyuk
