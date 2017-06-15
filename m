Received: from eggs.gnu.org ([2001:4830:134:3::10]:46665)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dLUYD-0000Rs-OZ
	for qemu-devel@nongnu.org; Thu, 15 Jun 2017 09:11:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dLUY8-0001im-N8
	for qemu-devel@nongnu.org; Thu, 15 Jun 2017 09:11:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:20595)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1dLUY8-0001iX-7W
	for qemu-devel@nongnu.org; Thu, 15 Jun 2017 09:11:00 -0400
References: <20170615055356.20684-1-rth@twiddle.net>
	<20170615055356.20684-3-rth@twiddle.net>
	<20170615070122.z44mdwhe25wlrn6q@aurel32.net>
	<97f3a8c2-5fc4-4df9-2372-f5b258ca7808@redhat.com>
	<20170615125312.nlzx37tfduoakceg@aurel32.net>
From: David Hildenbrand <david@redhat.com>
Message-ID: <a01099f8-9d81-6dbc-0985-d177da0ff61a@redhat.com>
Date: Thu, 15 Jun 2017 15:10:57 +0200
MIME-Version: 1.0
In-Reply-To: <20170615125312.nlzx37tfduoakceg@aurel32.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
To: Aurelien Jarno <aurelien@aurel32.net>
Cc: Richard Henderson <rth@twiddle.net>, qemu-devel@nongnu.org


>> A "sane" guest (e.g. Linux) will only use an instruction if the
>> corresponding stfl(e) bit is set. So in my opinion, this should be just
>> fine. If the bit is not set currently, the guest will not use it == dead
>> code.
> 
> Not necessarily. Depending on the distribution, gcc and hence binaries
> default to a different ISA. Over the time people have added the
> corresponding instructions to QEMU so that these binaries work. Now
> given that GCC does not necessarily use all the instructions from a
> given facility, we end up with missing instructions.

That's true, glibc sometimes assumes a certain architecture level
without checking. So you're right, maybe we should defer this "big
hammer" change until we have all facilities as part of the qemu CPU
model. Then, e.g. runnning -cpu qemu will not break such stuff, however
e.g. -cpu z900 could correctly simulate that architecture level.

One option would be:

/* for now, we don't fake absence of features for the qemu model */
if (!object_dynamic_cast(cpu, "qemu-s390x-cpu") {
	dc.features = cpu->model->features;
}


...

if (s->features && !test_bit(insn->fac, s->features)) {
    gen_program_exception(s, PGM_OPERATION);
    return EXIT_NORETURN;
}

> 
> Taking this to its logical extreme, given we don't fully implement the Z
> facility (for example the HFP instructions are missing), we should
> prevent all the programs to run until that is fixed.

I think we don't even implement the PLO, so we're not even pre-z complete ;)


-- 

Thanks,

David
