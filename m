Received: from eggs.gnu.org ([2001:4830:134:3::10]:48799)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dB1Ru-0004Gi-Ar
	for qemu-devel@nongnu.org; Wed, 17 May 2017 12:05:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dB1Ro-0007Wy-8R
	for qemu-devel@nongnu.org; Wed, 17 May 2017 12:05:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55170)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1dB1Ro-0007WV-2h
	for qemu-devel@nongnu.org; Wed, 17 May 2017 12:05:12 -0400
References: <1494926884-10118-1-git-send-email-thuth@redhat.com>
	<24feaa40-93e3-600e-fa00-0d1e00117c41@twiddle.net>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <53fcf39a-026c-bd18-da5d-48442b6570b9@redhat.com>
Date: Wed, 17 May 2017 18:05:03 +0200
MIME-Version: 1.0
In-Reply-To: <24feaa40-93e3-600e-fa00-0d1e00117c41@twiddle.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v1] target/s390x: Add support for the TEST
 BLOCK instruction
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>, qemu-devel@nongnu.org, Alexander Graf <agraf@suse.de>
Cc: David Hildenbrand <david@redhat.com>, mmarek@suse.com, mbenes@suse.cz

On 16.05.2017 21:06, Richard Henderson wrote:
> On 05/16/2017 02:28 AM, Thomas Huth wrote:
>> +void HELPER(testblock)(CPUS390XState *env, uint64_t addr)
>> +{
>> +    CPUState *cs =3D CPU(s390_env_get_cpu(env));
>> +    int i;
>> +
>> +    addr =3D get_address(env, 0, 0, addr) & ~0xfffULL;
>> +    for (i =3D 0; i < TARGET_PAGE_SIZE; i +=3D 8) {
>> +        stq_phys(cs->as, addr + i, 0);
>> +    }
>> +    env->cc_op =3D 0;
>> +}
>=20
> This needs several changes: check that the physical page does indeed
> exist, "low address protection", return the cc code.

Ok, ... but if we care about "low address protection", shouldn't we also
add that to the other CPU instructions, too? (As far as I can see, it is
not supported by the TCG code at all yet)

>> +DEF_HELPER_2(testblock, void, env, i64)
>=20
> With cc returned, this becomes
>=20
>   DEF_HELPER_FLAGS_2(testblock, TCG_CALL_NO_RWG, i32, env, i64)

Ok, thanks ... I'm still learning the details of writing TCG code ... ;-)

 Thomas
