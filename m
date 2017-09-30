Received: from eggs.gnu.org ([2001:4830:134:3::10]:44373)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dyMCx-0006Ps-LX
	for qemu-devel@nongnu.org; Sat, 30 Sep 2017 14:09:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dyMCu-0004vY-Pb
	for qemu-devel@nongnu.org; Sat, 30 Sep 2017 14:09:47 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:52727)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1dyMCu-0004u3-KA
	for qemu-devel@nongnu.org; Sat, 30 Sep 2017 14:09:44 -0400
Date: Sat, 30 Sep 2017 14:09:41 -0400
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20170930180941.GA22048@flamenco>
References: <150529666493.10902.14830445134051381968.stgit@frigg.lan>
	<CAFEAcA9p9B8AFaaSaSOOSsFsEhHW=XPLBFs5MrozWq=7p4_9Zg@mail.gmail.com>
	<87poasgjyh.fsf@frigg.lan>
	<CAFEAcA8XP+8Jz9Dn-mEQ3CCrVj00t3HA0praQ-OSggtQGAmQ5Q@mail.gmail.com>
	<87d16o53xr.fsf@frigg.lan>
	<CAFEAcA9FhXKVKe1E_pVDWX3u0W7WuKQmO54Z1Jgj-iL980yPew@mail.gmail.com>
	<87o9pywt8k.fsf@frigg.lan> <87shf5zlty.fsf@frigg.lan>
	<20170929175943.GA25038@flamenco> <87vak1w53a.fsf@frigg.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87vak1w53a.fsf@frigg.lan>
Subject: Re: [Qemu-devel] [PATCH v6 01/22] instrument: Add documentation
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>, Markus Armbruster <armbru@redhat.com>
List-ID: <qemu-devel.nongnu.org>

On Sat, Sep 30, 2017 at 00:46:33 +0300, Lluís Vilanova wrote:
> Emilio G Cota writes:
> > I'm not sure I understand this concept of filtering. Are you saying that in
> > the first case, all memory accesses are instrumented, and then in the
> > "access helper" we only call the user's callback if it's a memory write?
> > And in the second case, we simply just generate a "write helper" instead
> > of an "access helper". Am I understanding this correctly?
> 
> In the previous case (no filtering), the user callback is always called when a
> memory access is *executed*, and the user then checks if the access mode is a
> write to decide whether to increment a counter.
> 
> In this case (with filtering), a user callback is called when a memory access is
> *translated*, and if the access mode is a write, the user generates a call to a
> second callback that is executed every time a memory access is executed (only
> that it is only generated for memory writes, the ones we care about).
> 
> Is this clearer?

I get it now, thanks!

> > FWIW my experiments so far show similar numbers for instrumenting each
> > instruction (haven't done the per-tb yet). The difference is that I'm
> > exposing to instrumenters a copy of the guest instructions (const void *data,
> > size_t size). These copies are kept around until TB's are flushed.
> > Luckily there seems to be very little overhead in keeping these around,
> > apart from the memory overhead -- but in terms of performance, the
> > necessary allocations do not induce significant overhead.
> 
> To keep this use-case simpler, I added the memory access API I posted in this
> series, where instrumenters can read guest memory (more general than passing a
> copy of the current instruction).

I see some potential problems with this:
1. Instrumenters' accesses could generate exceptions. I presume we'd want to avoid
   this, or leave it as a debug-only kind of option.
2. Instrumenters won't know where the end of an instruction (for variable-length
  ISAs) or of a TB is (TB != basic block). For instructions one could have a loop
  where we read byte-by-byte and pass it to the decoder, something similar to
  what we have in the capstone code recently posted to the list (v4). For TBs,
  we really should have a way to delimit the length of the TB. This is further
  complicated if we want instrumentation to be inserted *before* a TB is
  translated.

Some thoughts on the latter problem: if we want a tb_trans_pre callback, like
Pin/DynamoRIO provide, instead of doing two passes (one to delimit the TB and
call the tb_trans_pre callback, to then generate the translated TB), we could:
  - have a tb_trans_pre callback. This callback inserts an exec-time callback
    with a user-defined pointer (let's call it **tb_info). The callback has
    no arguments, perhaps just the pc.
  - have a tb_trans_post callback. This one passes a copy of the guest
    instructions. The instrumenter then can allocate whatever data structure
    to represent the TB (*tb_info), and copies this pointer to **tb_info, so
    that at execution time, we can obtain tb_info _before_ the TB is executed.
    After the callback returns, the copy of the guest instructions can be freed.
  This has two disadvantages:
  - We have an extra dereference to find tb_info
  - If it turns out that the TB should not be instrumented, we have generated
    a callback for nothing.

		Emilio
