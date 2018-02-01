Received: from eggs.gnu.org ([2001:4830:134:3::10]:43600)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1ehESV-0006fl-2N
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 07:59:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1ehESS-0002tX-Rl
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 07:59:19 -0500
References: <20180131181742.2037-1-cohuck@redhat.com>
	<20180131181742.2037-2-cohuck@redhat.com>
	<de34c0e5-002e-f461-bc4d-498548424177@redhat.com>
	<20180201134803.78ef2b65.cohuck@redhat.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <240bb71f-7d10-bc54-1bb7-23df6bc51081@redhat.com>
Date: Thu, 1 Feb 2018 13:59:13 +0100
MIME-Version: 1.0
In-Reply-To: <20180201134803.78ef2b65.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 1/2] s390x/tcg: wire up pci instructions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, rth@twiddle.net, agraf@suse.de

On 01.02.2018 13:48, Cornelia Huck wrote:
> On Thu, 1 Feb 2018 13:42:52 +0100
> David Hildenbrand <david@redhat.com> wrote:
>=20
>> On 31.01.2018 19:17, Cornelia Huck wrote:
>=20
>>> +#ifndef CONFIG_USER_ONLY
>>> +void HELPER(clp)(CPUS390XState *env, uint32_t r2)
>>> +{
>>> +    S390CPU *cpu =3D s390_env_get_cpu(env);
>>> +    int r;
>>> +
>>> +    qemu_mutex_lock_iothread();
>>> +    r =3D clp_service_call(cpu, r2, GETPC());
>>> +    qemu_mutex_unlock_iothread();
>>> +    if (r) {
>>> +        s390_program_interrupt(env, PGM_OPERATION, 4, GETPC());
>>> +    } =20
>>
>> We don't need the if (r) ... so I suggest dropping all these. (as I
>> said, will be handled later via the generic flag checking in translati=
on
>> code). We can ignore any error from these functions.
>=20
> I did not check the instruction implementations in detail... was the
> error really only for the !CONFIG_PCI case?

!FEATURE_ZPCI (which includes !CONFIG_PCI)

Yes, that's how I remember.

>=20
> (I really should know that...)
>=20
>> A sane guest will newer trigger this. (if we have no CONFIG_PCI, the
>> also the ZPCI feature will not be available)
>=20
> Hopefully we can also handle non-sane guests correctly...

Usually, if you call instructions that are not indicated via STFL, there
is no guarantee what will happen. Some time in the future, we will
handle this globally (but haven't done so to allow new applications to
run with old CPU models - which was necessary before we bumped the CPU
model to a z12).

If you don't want to wait until that support is added, you should be
save with something like this:


diff --git a/target/s390x/translate.c b/target/s390x/translate.c
index 02cd4b2627..a5db014730 100644
--- a/target/s390x/translate.c
+++ b/target/s390x/translate.c
@@ -5907,6 +5907,10 @@ static ExitStatus translate_one(CPUS390XState
*env, DisasContext *s)
         gen_illegal_opcode(s);
         return EXIT_NORETURN;
     }
+    if (insn->fac =3D=3D FAC_PCI && !s390_has_feat(FAC_PCI)) {
+        gen_illegal_opcode(s);
+        return EXIT_NORETURN;
+    }

 #ifndef CONFIG_USER_ONLY
     if (s->tb->flags & FLAG_MASK_PER) {

--=20

Thanks,

David / dhildenb
