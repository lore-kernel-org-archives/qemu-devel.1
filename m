Received: from eggs.gnu.org ([209.51.188.92]:36238)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1gluHM-0006uL-MY
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 06:31:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1gluHJ-0004Qf-Oo
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 06:31:40 -0500
Received: from mail.ispras.ru ([83.149.199.45]:51002)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1gluHA-0004Ke-VZ
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 06:31:32 -0500
From: "Pavel Dovgalyuk" <dovgaluk@ispras.ru>
References: <000601d4b222$323d0900$96b71b00$@ru>
	<bf5401c8-20b3-6774-fd9e-56ffe25e7431@redhat.com>
In-Reply-To: <bf5401c8-20b3-6774-fd9e-56ffe25e7431@redhat.com>
Date: Tue, 22 Jan 2019 14:31:25 +0300
Message-ID: <001701d4b246$02928a80$07b79f80$@ru>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Language: ru
Subject: Re: [Qemu-devel] Bottom halves VS timers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: 'Paolo Bonzini' <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, stefanha@redhat.com, famz@redhat.com, kwolf@redhat.com

> From: Paolo Bonzini [mailto:pbonzini@redhat.com]
> On 22/01/19 08:15, Pavel Dovgalyuk wrote:
> > Scheduling new BH does not create a signal for the vCPU to suspend the
> > execution and process the main loop events (in record/replay we
> > synchronize these two threads).
> 
> I think the bug is that in rr mode it should do so and cause a cpu_exit.

Right. I combined adding cpu_exit (into our private version) and increasing
an icount command-line parameter.

>  If replace these bottom halves with timers, other bottom halves from
> the block layer may have the same issue; if you replace _all_ bottom
> halves with timers you have performance issues because bottom halves try
> very hard to avoid locks.

I see.

> Unfortunately this is getting really ugly...  Basically, rr is
> reintroducing all the complications with iothread_requesting_mutex that
> were removed with mtTCG.

True. There are too many non-synchronized entities: bottom halves,
worker threads, iothreads, timers...
But RR is only possible when we have kind of synchronization objects for them.

Pavel Dovgalyuk
