Received: from eggs.gnu.org ([2001:4830:134:3::10]:48105)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1dGnC7-0002pB-Di
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 10:04:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1dGnC6-0006xK-ET
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 10:04:51 -0400
Received: from hall.aurel32.net ([2001:bc8:30d7:100::1]:51778)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aurelien@aurel32.net>)
	id 1dGnC6-0006xA-8k
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 10:04:50 -0400
Date: Fri, 2 Jun 2017 16:04:48 +0200
From: Aurelien Jarno <aurelien@aurel32.net>
Message-ID: <20170602140448.r4e2evvpm76kcshe@aurel32.net>
References: <20170601101438.28732-1-david@redhat.com>
	<20170601192011.crq6igwuln4hyjw5@aurel32.net>
	<714c789a-a8e9-b1d4-07ca-b7f36b657984@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <714c789a-a8e9-b1d4-07ca-b7f36b657984@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v1] s390x/cpumodel: wire up cpu type + id
 for TCG
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>
Cc: qemu-devel@nongnu.org, rth@twiddle.net, agraf@suse.de, thuth@redhat.com

On 2017-06-02 12:52, David Hildenbrand wrote:
> 
> >> +
> >> +#ifndef CONFIG_USER_ONLY
> >> +void HELPER(stidp)(CPUS390XState *env, uint64_t addr)
> >> +{
> >> +    S390CPU *cpu = s390_env_get_cpu(env);
> >> +    uint64_t cpuid = s390_cpuid_from_cpu_model(cpu->model);
> >> +
> >> +    if (addr & 0x7) {
> >> +        program_interrupt(env, PGM_SPECIFICATION, ILEN_LATER_INC);
> >> +        return;
> >> +    }
> >> +
> >> +    /* basic mode, write the cpu address into the first 4 bit of the ID */
> >> +    cpuid |= ((uint64_t)env->cpu_num & 0xf) << 54;
> >> +    cpu_stq_data(env, addr, cpuid);
> >> +}
> >> +#endif
> > 
> > I don't really see the point of using an helper instead of just updating
> > the existing code. From what I understand the cpuid does not change at
> > runtime, so the s390_cpuid_from_cpu_model function can also be called 
> > from translate.c.
> > 
> > Aurelien
> > 
> 
> From what I can see, conditional exceptions are more complicated to
> implement without helpers (involves generating compares, jumps and so

In that case you don't need to do any compare an jump. It's a standard
load/store alignement check, you can just specify the MO_ALIGN flag to
the tcg_gen_qemu_st_i64 function.


> on). As this function is not expected to be executed on hot paths, I
> think moving it into a helper is the right thing to do.

This is not only about performance, but also avoiding code that is
spread in many files. Well theoretically increasing the number of
entries in the helper hash table has a performance impact, but i don't
think it is measurable.

Aurelien	

-- 
Aurelien Jarno                          GPG: 4096R/1DDD8C9B
aurelien@aurel32.net                 http://www.aurel32.net
