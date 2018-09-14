Received: from eggs.gnu.org ([2001:4830:134:3::10]:53255)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liran.alon@oracle.com>) id 1g0koT-0007Hm-6Q
	for qemu-devel@nongnu.org; Fri, 14 Sep 2018 05:54:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liran.alon@oracle.com>) id 1g0koP-0003xx-6P
	for qemu-devel@nongnu.org; Fri, 14 Sep 2018 05:54:57 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:41610)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <liran.alon@oracle.com>)
	id 1g0koO-0003wi-Sb
	for qemu-devel@nongnu.org; Fri, 14 Sep 2018 05:54:53 -0400
From: Liran Alon <liran.alon@oracle.com>
Content-Type: text/plain;
	charset=utf-8
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 11.1 \(3445.4.7\))
Message-Id: <CF1FBDB7-62D3-4743-8FE8-0F0CB78938C6@oracle.com>
Date: Fri, 14 Sep 2018 12:54:41 +0300
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

>On 14/09/2018 09:16, Paolo Bonzini wrote:
>Heh, I was going to send a similar patch.  However, things are a bit
>more complex for two reason.
>
>First, I'd prefer to reuse the hflags and hflags2 fields that we =
already
>have, and only store the VMCS blob in the subsection.  For example,
>HF_SVMI_MASK is really the same as HF_GUEST_MASK in KVM source code and
>KVM_STATE_NESTED_GUEST_MODE in the nested virt state.
>

Do you mean you intend to only save/restore the =E2=80=9Cvmx=E2=80=9D =
field in struct kvm_nested_state?
(That is, struct kvm_vmx_nested_state)
If yes, that is problematic as kvm_nested_state.flags also hold other =
flags besides KVM_STATE_NESTED_GUEST_MODE.
How do you expect to save/restore for example the =
vmx->nested.nested_run_pending flag that is specified in =
KVM_STATE_NESTED_RUN_PENDING?

In addition, why is it important to avoid save/restore the entire =
kvm_nested_state struct?
It seems to simplify things to just save/restore the entire struct.

>More important, this:
>
>>
>> +static int nested_state_post_load(void *opaque, int version_id)
>> +{
>> +    X86CPU *cpu =3D opaque;
>> +    CPUX86State *env =3D &cpu->env;
>> +
>> +    /*
>> +     * Verify that the size specified in given struct is set
>> +     * to no more than the size that our kernel support
>> +     */
>> +    if (env->nested_state->size > env->nested_state_len) {
>> +        return -EINVAL;
>> +    }
>> +
>> +    return 0;
>> +}
>> +
>> +static bool nested_state_needed(void *opaque)
>
>doesn't work if nested_state_len differs between source and =
destination,
>and could overflow the nested_state buffer if nested_state_len is =
larger
>on the source.

This is not accurate.
I have actually given a lot of thought to this aspect in the patch.

The above post_load() method actually prevents an overflow to happen on =
dest.
Note that env->nested_state_len is not passed as part of migration =
stream.
It is only set by local kernel KVM_CAP_NESTED_STATE.

Therefore, we allow the following migrations to execute successfully:
1) Migration from a source with smaller KVM_CAP_NESTED_STATE to dest =
with a bigger one.
The above post_load() check will succeed as size specified in migrated =
nested_state->size
is smaller than dest KVM_CAP_NESTED_STATE (stored in =
env->nested_state_len).
2) Migration from source to dest when they both have same =
KVM_CAP_NESTED_STATE size.
Obvious.
3) Migration from source to dest when source have a bigger =
KVM_CAP_NESTED_STATE than dest.
This will only succeed in case size specified in nested_state->size is =
smaller than dest KVM_CAP_NESTED_STATE.

-Liran

>
>I'll send my version today or next Monday.
>
>Thanks,
>
>Paolo
>
