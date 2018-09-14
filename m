Received: from eggs.gnu.org ([2001:4830:134:3::10]:42059)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1g0lpT-0006CV-N2
	for qemu-devel@nongnu.org; Fri, 14 Sep 2018 07:00:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1g0lpQ-0004vi-GX
	for qemu-devel@nongnu.org; Fri, 14 Sep 2018 07:00:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41008)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1g0lpQ-0004vR-4j
	for qemu-devel@nongnu.org; Fri, 14 Sep 2018 07:00:00 -0400
References: <CF1FBDB7-62D3-4743-8FE8-0F0CB78938C6@oracle.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <3122370e-7f41-5aed-b26e-2aba32ce3889@redhat.com>
Date: Fri, 14 Sep 2018 12:59:55 +0200
MIME-Version: 1.0
In-Reply-To: <CF1FBDB7-62D3-4743-8FE8-0F0CB78938C6@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
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
To: Liran Alon <liran.alon@oracle.com>
Cc: qemu-devel@nongnu.org, rth@twiddle.net, ehabkost@redhat.com, mtosatti@redhat.com, kvm list <kvm@vger.kernel.org>, Jim Mattson <jmattson@google.com>, Idan Brown <idan.brown@oracle.com>

On 14/09/2018 11:54, Liran Alon wrote:
>> On 14/09/2018 09:16, Paolo Bonzini wrote:
>> Heh, I was going to send a similar patch.  However, things are a bit
>> more complex for two reason.
>>
>> First, I'd prefer to reuse the hflags and hflags2 fields that we alrea=
dy
>> have, and only store the VMCS blob in the subsection.  For example,
>> HF_SVMI_MASK is really the same as HF_GUEST_MASK in KVM source code an=
d
>> KVM_STATE_NESTED_GUEST_MODE in the nested virt state.
>>
>=20
> Do you mean you intend to only save/restore the =E2=80=9Cvmx=E2=80=9D f=
ield in struct kvm_nested_state?
> (That is, struct kvm_vmx_nested_state)
> If yes, that is problematic as kvm_nested_state.flags also hold other f=
lags besides KVM_STATE_NESTED_GUEST_MODE.
> How do you expect to save/restore for example the vmx->nested.nested_ru=
n_pending flag that is specified in KVM_STATE_NESTED_RUN_PENDING?

By defining more HF flags.  I'd rather avoid having multiple ways to
store the same thing, in case for example in the future HVF implements
nested virt.

> In addition, why is it important to avoid save/restore the entire kvm_n=
ested_state struct?
> It seems to simplify things to just save/restore the entire struct.

It is indeed simpler, but it adds unnecessary KVM specificities.

>>> +static int nested_state_post_load(void *opaque, int version_id)
>>> +{
>>> +    X86CPU *cpu =3D opaque;
>>> +    CPUX86State *env =3D &cpu->env;
>>> +
>>> +    /*
>>> +     * Verify that the size specified in given struct is set
>>> +     * to no more than the size that our kernel support
>>> +     */
>>> +    if (env->nested_state->size > env->nested_state_len) {
>>> +        return -EINVAL;
>>> +    }
>>> +
>>> +    return 0;
>>> +}
>>> +
>>> +static bool nested_state_needed(void *opaque)
>>
>> doesn't work if nested_state_len differs between source and destinatio=
n,
>> and could overflow the nested_state buffer if nested_state_len is larg=
er
>> on the source.
>=20
> This is not accurate.
> I have actually given a lot of thought to this aspect in the patch.
>=20
> The above post_load() method actually prevents an overflow to happen on=
 dest.
> Note that env->nested_state_len is not passed as part of migration stre=
am.
> It is only set by local kernel KVM_CAP_NESTED_STATE.
>=20
> Therefore, we allow the following migrations to execute successfully:
> 1) Migration from a source with smaller KVM_CAP_NESTED_STATE to dest wi=
th a bigger one.
> The above post_load() check will succeed as size specified in migrated =
nested_state->size
> is smaller than dest KVM_CAP_NESTED_STATE (stored in env->nested_state_=
len).
> 2) Migration from source to dest when they both have same KVM_CAP_NESTE=
D_STATE size.
> Obvious.
> 3) Migration from source to dest when source have a bigger KVM_CAP_NEST=
ED_STATE than dest.
> This will only succeed in case size specified in nested_state->size is =
smaller than dest KVM_CAP_NESTED_STATE.

You're right (I got confused with my implementation).

There is still a problem, however, in that the same input stream would
be parsed differently depending on the kernel version.  In particular,
if in the future the maximum nested state size grows, you break all
existing save files.

Paolo
