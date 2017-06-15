Received: from eggs.gnu.org ([2001:4830:134:3::10]:45502)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1dLbnq-00023g-Sq
	for qemu-devel@nongnu.org; Thu, 15 Jun 2017 16:55:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1dLbnp-0001ad-Sq
	for qemu-devel@nongnu.org; Thu, 15 Jun 2017 16:55:42 -0400
Received: from hall.aurel32.net ([2001:bc8:30d7:100::1]:57376)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aurelien@aurel32.net>)
	id 1dLbnp-0001ZT-La
	for qemu-devel@nongnu.org; Thu, 15 Jun 2017 16:55:41 -0400
Date: Thu, 15 Jun 2017 22:55:37 +0200
From: Aurelien Jarno <aurelien@aurel32.net>
Message-ID: <20170615205537.32nsoi75esd7zdp6@aurel32.net>
References: <20170615055356.20684-1-rth@twiddle.net>
	<20170615055356.20684-3-rth@twiddle.net>
	<20170615070122.z44mdwhe25wlrn6q@aurel32.net>
	<97f3a8c2-5fc4-4df9-2372-f5b258ca7808@redhat.com>
	<20170615125312.nlzx37tfduoakceg@aurel32.net>
	<a01099f8-9d81-6dbc-0985-d177da0ff61a@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a01099f8-9d81-6dbc-0985-d177da0ff61a@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 2/5] target/s390x: Enforce instruction
 features
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>
Cc: Richard Henderson <rth@twiddle.net>, qemu-devel@nongnu.org

On 2017-06-15 15:10, David Hildenbrand wrote:
> 
> >> A "sane" guest (e.g. Linux) will only use an instruction if the
> >> corresponding stfl(e) bit is set. So in my opinion, this should be just
> >> fine. If the bit is not set currently, the guest will not use it == dead
> >> code.
> > 
> > Not necessarily. Depending on the distribution, gcc and hence binaries
> > default to a different ISA. Over the time people have added the
> > corresponding instructions to QEMU so that these binaries work. Now
> > given that GCC does not necessarily use all the instructions from a
> > given facility, we end up with missing instructions.
> 
> That's true, glibc sometimes assumes a certain architecture level
> without checking. So you're right, maybe we should defer this "big
> hammer" change until we have all facilities as part of the qemu CPU

Well the GNU libc itself correctly probe the facilities with stfl/stfle.
What happens is that newer instructions might be generated directly by
GCC if told to do so (with -march=xxx or the default architecture).


> model. Then, e.g. runnning -cpu qemu will not break such stuff, however
> e.g. -cpu z900 could correctly simulate that architecture level.
> 
> One option would be:
> 
> /* for now, we don't fake absence of features for the qemu model */
> if (!object_dynamic_cast(cpu, "qemu-s390x-cpu") {
> 	dc.features = cpu->model->features;
> }
> 
> 
> ...
> 
> if (s->features && !test_bit(insn->fac, s->features)) {
>     gen_program_exception(s, PGM_OPERATION);
>     return EXIT_NORETURN;
> }

I don't know that part of the code enough to tell if it is the good way
to do that, but certainly having a "qemu" CPU that supports all
instructions look like the way to go, especially for the linux-user
emulation.

Aurelien

-- 
Aurelien Jarno                          GPG: 4096R/1DDD8C9B
aurelien@aurel32.net                 http://www.aurel32.net
