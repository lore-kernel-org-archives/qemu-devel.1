Received: from eggs.gnu.org ([2001:4830:134:3::10]:49927)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dNxnh-0005XO-1x
	for qemu-devel@nongnu.org; Thu, 22 Jun 2017 04:49:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dNxne-0000Nt-0n
	for qemu-devel@nongnu.org; Thu, 22 Jun 2017 04:49:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50100)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1dNxnd-0000MC-Qb
	for qemu-devel@nongnu.org; Thu, 22 Jun 2017 04:49:13 -0400
References: <20170620123553.16186-1-david@redhat.com>
	<20170620123553.16186-4-david@redhat.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <e38e5712-65c1-c135-15b8-dfc87e42869a@redhat.com>
Date: Thu, 22 Jun 2017 10:49:09 +0200
MIME-Version: 1.0
In-Reply-To: <20170620123553.16186-4-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 3/3] target/s390x: Implement idte
 instruction
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: rth@twiddle.net, agraf@suse.de, Aurelien Jarno <aurelien@aurel32.net>, thuth@redhat.com


>  
> +void HELPER(idte)(CPUS390XState *env, uint64_t r1, uint64_t r2, uint32_t m4)
> +{
> +    CPUState *cs = CPU(s390_env_get_cpu(env));
> +    const uintptr_t ra = GETPC();
> +    uint64_t table, entry, raddr;
> +    uint16_t entries, i, index = 0;
> +
> +    if (r2 & 0xff000ul) {
> +        cpu_restore_state(cs, ra);
> +        program_interrupt(env, PGM_SPECIFICATION, 4);
> +    }
> +
> +    if (!(r1 & 0x800u)) {

Turning this into

if (!(r2 & 0x800u)) {

allows me to boot an upstream linux guest compiled for z9, using
dat-enhancement.

Linux, however seems to never use it for invalidation, only for flushing
in my setup.


-- 

Thanks,

David
