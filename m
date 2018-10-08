Received: from eggs.gnu.org ([2001:4830:134:3::10]:46891)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1g9Kf4-0004sj-AP
	for qemu-devel@nongnu.org; Sun, 07 Oct 2018 21:48:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1g9Kf1-0002Qh-1V
	for qemu-devel@nongnu.org; Sun, 07 Oct 2018 21:48:42 -0400
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:53735)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1g9Kf0-0002P6-LN
	for qemu-devel@nongnu.org; Sun, 07 Oct 2018 21:48:38 -0400
Date: Sun, 7 Oct 2018 21:48:34 -0400
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20181008014834.GA21299@flamenco>
References: <20181006214508.5331-1-cota@braap.org>
	<20181006214508.5331-7-cota@braap.org>
	<197b7649-0bc7-4a9a-021b-a308a1755cf1@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <197b7649-0bc7-4a9a-021b-a308a1755cf1@amsat.org>
Subject: Re: [Qemu-devel] [RFC 6/6] cputlb: dynamically resize TLBs based on
 use rate
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>
Cc: qemu-devel@nongnu.org, Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>, Pranith Kumar <bobby.prani@gmail.com>, Richard Henderson <richard.henderson@linaro.org>

On Sun, Oct 07, 2018 at 19:37:50 +0200, Philippe Mathieu-Daudé wrote:
> On 10/6/18 11:45 PM, Emilio G. Cota wrote:
> > 2. System boot + shutdown, ubuntu 18.04 x86_64:
> 
> You can also run the VM tests to build QEMU:
> 
> $ make vm-test

Thanks, will give that a look.

> > +    if (rate == 100) {
> > +        new_size = MIN(desc->size << 2, 1 << TCG_TARGET_TLB_MAX_INDEX_BITS);
> > +    } else if (rate > 70) {
> > +        new_size = MIN(desc->size << 1, 1 << TCG_TARGET_TLB_MAX_INDEX_BITS);
> > +    } else if (rate < 30) {
> 
> I wonder if those thresholds might be per TCG_TARGET.

Do you mean to tune the growth rate based on each TCG target?
(max and min are already determined by the TCG target).
The optimal growth rate is mostly dependent on the guest
workload, so I wouldn't expect the TCG target to matter
much.

That said, we could spend quite some time tweaking the
TLB sizing algorithm. But with this RFC I wanted to see
(a) whether this approach is a good idea at all, and (b) show
what 'easy' speedups might look like (because converting
all TCG targets is a pain, so it better be justified).

> Btw the paper used 40% here, did you tried it too?

Yes, I tried several alternatives including what the
paper describes, i.e. (skipping the min/max checks
for simplicity):

	if (rate > 70) {
		new_size = 2 * old_size;
	} else if (rate < 40) {
		new_size = old_size / 2;
	}

But that didn't give great speedups (see "resizing-paper"
set):
  https://imgur.com/a/w3AqHP7

A few points stand out to me:

- We get very different speedups even if we implement
  the algorithm they describe (not sure that's exactly
  what they implemented though). But there are many
  variables that could explain that, e.g. different guest
  images (and therefore different TLB flush rates) and
  different QEMU baselines (ours is faster than the paper's,
  so getting speedups is harder).

- 70/40% use rate for growing/shrinking the TLB does not
  seem a great choice, if one wants to avoid a pathological
  case that can induce constant resizing. Imagine we got
  exactly 70% use rate, and all TLB misses were compulsory
  (i.e. a direct-mapped TLB would have not prevented a
  single miss). We'd then double the TLB size:
    size_new = 2*size_old
  But then the use rate will halve:
    use_new = 0.7/2 = 0.35
  So we'd then end up in a grow-shrink loop!
  Picking a "shrink threshold" below 0.70/2=0.35 avoids this.

- Aggressively increasing the TLB size when usage is high
  makes sense. However, reducing the size at the same
  rate does not make much sense. Imagine the following
  scenario with two processes being scheduled: one process
  uses a lot of memory, and the other one uses little, but
  both are CPU-intensive and therefore being assigned similar
  time slices by the scheduler. Ideally you'd resize the TLB
  to meet each process' memory demands. However, at flush
  time we don't even know what process is running or about
  to run, so we have to size the TLB exclusively based on
  recent use rates. In this scenario you're probably close
  to optimal if you size the TLB to meet the demands of the
  most memory-hungry process. You'll lose some extra time
  flushing the (now larger) TLB, but your net gain is likely
  to be positive given the TLB fills you won't have to do
  when the memory-heavy process is scheduled in.

So to me it's quite likely that in the paper they
could have gotten even better results by reducing the
shrink rate, like we did.

Thanks,

		Emilio
