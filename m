Received: from eggs.gnu.org ([2001:4830:134:3::10]:47485)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liran.alon@oracle.com>) id 1g0p8T-00043n-Sd
	for qemu-devel@nongnu.org; Fri, 14 Sep 2018 10:31:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liran.alon@oracle.com>) id 1g0p8P-0002ZV-NY
	for qemu-devel@nongnu.org; Fri, 14 Sep 2018 10:31:53 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:49716)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <liran.alon@oracle.com>)
	id 1g0p8P-0002Z7-Cu
	for qemu-devel@nongnu.org; Fri, 14 Sep 2018 10:31:49 -0400
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 11.1 \(3445.4.7\))
From: Liran Alon <liran.alon@oracle.com>
In-Reply-To: <3122370e-7f41-5aed-b26e-2aba32ce3889@redhat.com>
Date: Fri, 14 Sep 2018 17:31:37 +0300
Content-Transfer-Encoding: quoted-printable
Message-Id: <B8ABB04A-A6F5-4409-8E05-9E8D7CE124F5@oracle.com>
References: <CF1FBDB7-62D3-4743-8FE8-0F0CB78938C6@oracle.com>
	<3122370e-7f41-5aed-b26e-2aba32ce3889@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 2/2] KVM: i386: Add support for save and
 restore nested state
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, rth@twiddle.net, ehabkost@redhat.com, mtosatti@redhat.com, kvm list <kvm@vger.kernel.org>, Jim Mattson <jmattson@google.com>, Idan Brown <idan.brown@oracle.com>


> On 14 Sep 2018, at 13:59, Paolo Bonzini <pbonzini@redhat.com> wrote:
>=20
> On 14/09/2018 11:54, Liran Alon wrote:
>>> On 14/09/2018 09:16, Paolo Bonzini wrote:
>>> Heh, I was going to send a similar patch.  However, things are a bit
>>> more complex for two reason.
>>>=20
>>> First, I'd prefer to reuse the hflags and hflags2 fields that we =
already
>>> have, and only store the VMCS blob in the subsection.  For example,
>>> HF_SVMI_MASK is really the same as HF_GUEST_MASK in KVM source code =
and
>>> KVM_STATE_NESTED_GUEST_MODE in the nested virt state.
>>>=20
>>=20
>> Do you mean you intend to only save/restore the =E2=80=9Cvmx=E2=80=9D =
field in struct kvm_nested_state?
>> (That is, struct kvm_vmx_nested_state)
>> If yes, that is problematic as kvm_nested_state.flags also hold other =
flags besides KVM_STATE_NESTED_GUEST_MODE.
>> How do you expect to save/restore for example the =
vmx->nested.nested_run_pending flag that is specified in =
KVM_STATE_NESTED_RUN_PENDING?
>=20
> By defining more HF flags.  I'd rather avoid having multiple ways to
> store the same thing, in case for example in the future HVF implements
> nested virt.

I agree it is possible to define more hflags and to translate =
kvm_nested_flags->flags to flags in hflags and vice-versa.
However, I am not sure I understand the extra value provided by doing =
so.
I think it makes more sense to rename struct kvm_nested_state to struct =
nested_state and
use this as a generic interface to get/set nested_state for all =
hypervisors.
If a given hypervisor, such as HVF, needs to store different blob than =
KVM VMX, it can just add another struct field to
the union-part of struct kvm_nested_state.
This way, the code that handles the save/restore of nested_state can =
remain generic for all hypervisors.

>=20
>> In addition, why is it important to avoid save/restore the entire =
kvm_nested_state struct?
>> It seems to simplify things to just save/restore the entire struct.
>=20
> It is indeed simpler, but it adds unnecessary KVM specificities.

I=E2=80=99m not sure I understand this argument.

>=20
>>>> +static int nested_state_post_load(void *opaque, int version_id)
>>>> +{
>>>> +    X86CPU *cpu =3D opaque;
>>>> +    CPUX86State *env =3D &cpu->env;
>>>> +
>>>> +    /*
>>>> +     * Verify that the size specified in given struct is set
>>>> +     * to no more than the size that our kernel support
>>>> +     */
>>>> +    if (env->nested_state->size > env->nested_state_len) {
>>>> +        return -EINVAL;
>>>> +    }
>>>> +
>>>> +    return 0;
>>>> +}
>>>> +
>>>> +static bool nested_state_needed(void *opaque)
>>>=20
>>> doesn't work if nested_state_len differs between source and =
destination,
>>> and could overflow the nested_state buffer if nested_state_len is =
larger
>>> on the source.
>>=20
>> This is not accurate.
>> I have actually given a lot of thought to this aspect in the patch.
>>=20
>> The above post_load() method actually prevents an overflow to happen =
on dest.
>> Note that env->nested_state_len is not passed as part of migration =
stream.
>> It is only set by local kernel KVM_CAP_NESTED_STATE.
>>=20
>> Therefore, we allow the following migrations to execute successfully:
>> 1) Migration from a source with smaller KVM_CAP_NESTED_STATE to dest =
with a bigger one.
>> The above post_load() check will succeed as size specified in =
migrated nested_state->size
>> is smaller than dest KVM_CAP_NESTED_STATE (stored in =
env->nested_state_len).
>> 2) Migration from source to dest when they both have same =
KVM_CAP_NESTED_STATE size.
>> Obvious.
>> 3) Migration from source to dest when source have a bigger =
KVM_CAP_NESTED_STATE than dest.
>> This will only succeed in case size specified in nested_state->size =
is smaller than dest KVM_CAP_NESTED_STATE.
>=20
> You're right (I got confused with my implementation).
>=20
> There is still a problem, however, in that the same input stream would
> be parsed differently depending on the kernel version.  In particular,
> if in the future the maximum nested state size grows, you break all
> existing save files.

I=E2=80=99m not sure I agree with this.
1) Newer kernels should change struct only by utilizing unused fields in =
current struct
or enlarging it with extra fields. It should not change the meaning of =
existing fields.
2) Newer kernel need to be able to parse and generate structs of sizes =
of older kernels.
Otherwise, you won=E2=80=99t be able to migrate from older kernels to =
newer kernels and vice-versa.
3) The thing that is really missing here in my patch is: Source don=E2=80=99=
t know which version
of the struct it should ask kernel to generate in order for dest to be =
able to parse it.
For that, there is a need that source will somehow know what is the dest =
max compatible struct size
and request kernel to generate a struct of that size.
Is there any mechanism in QEMU which I can use to utilize to do such =
logic?

-Liran

>=20
> Paolo
