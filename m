Received: from eggs.gnu.org ([2001:4830:134:3::10]:54913)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liran.alon@oracle.com>) id 1gIlHH-0005p6-3t
	for qemu-devel@nongnu.org; Fri, 02 Nov 2018 22:03:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liran.alon@oracle.com>) id 1gIlH9-0001be-RZ
	for qemu-devel@nongnu.org; Fri, 02 Nov 2018 22:03:05 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:38678)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <liran.alon@oracle.com>)
	id 1gIlH9-0001D7-3V
	for qemu-devel@nongnu.org; Fri, 02 Nov 2018 22:02:59 -0400
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 11.1 \(3445.4.7\))
From: Liran Alon <liran.alon@oracle.com>
In-Reply-To: <CALMp9eRk=a1FEyr78NRGBBZ2iFCo5s2n5N=bM4zR=YF56oob3A@mail.gmail.com>
Date: Sat, 3 Nov 2018 04:02:37 +0200
Content-Transfer-Encoding: quoted-printable
Message-Id: <1C803EF0-9E1B-4E1B-A4DD-4BE788A7A1FF@oracle.com>
References: <CALMp9eQ5zWxb2N9fyYz=WcQshwk0L6qQ4D6L6+p_dzMo4H=txA@mail.gmail.com>
	<20181102034649.43559-1-liran.alon@oracle.com>
	<CALMp9eRk=a1FEyr78NRGBBZ2iFCo5s2n5N=bM4zR=YF56oob3A@mail.gmail.com>
Subject: Re: [Qemu-devel] [QEMU PATCH v2 0/2]: KVM: i386: Add support for
 save and restore nested state
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jim Mattson <jmattson@google.com>
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, kvm list <kvm@vger.kernel.org>, mtosatti@redhat.com, rth@twiddle.net, qemu-devel@nongnu.org



> On 2 Nov 2018, at 18:39, Jim Mattson <jmattson@google.com> wrote:
>=20
> On Thu, Nov 1, 2018 at 8:46 PM, Liran Alon <liran.alon@oracle.com> =
wrote:
>=20
>> Hmm this makes sense.
>>=20
>> This means though that the patch I have submitted here isn't good =
enough.
>> My patch currently assumes that when it attempts to get nested state =
from KVM,
>> QEMU should always set nested_state->size to max size supported by =
KVM as received
>> from kvm_check_extension(s, KVM_CAP_NESTED_STATE);
>> (See kvm_get_nested_state() introduced on my patch).
>> This indeed won't allow migration from host with new KVM to host with =
old KVM if
>> nested_state size was enlarged between these KVM versions.
>> Which is obviously an issue.
>>=20
>> Jim, I think that my confusion was created from the fact that there =
is no clear documentation
>> on how KVM_{GET,SET}_NESTED_STATE should be changed once we will need =
to add more state to
>> nested_state in future KVM versions. I think it's worth adding that =
to IOCTLs documentation.
>=20
> The nested state IOCTLs aren't unique in this respect. Any changes to
> the state saved by any of this whole family of state-saving ioctls
> require opt-in from userspace.
>=20
>> For example, let's assume we have a new KVM_CAP_NESTED_STATE_V2.
>> In this scenario, does kvm_check_extension(s, KVM_CAP_NESTED_STATE) =
still returns the
>> size of nested_state v1 and kvm_check_extension(s, =
KVM_CAP_NESTED_STATE_V2) returns the
>> size of the nested_state v2?
>=20
> Hmm...I don't recall kvm_check_extension(s, KVM_CAP_NESTED_STATE)
> being part of my original design. The way I had envisioned it,
> the set of capabilities enabled by userspace would be sufficient to
> infer the maximum data size.

If the set of capabilities should be sufficient to infer the max size of =
nested_state,
why did we code kvm_vm_ioctl_check_extension() such that on =
KVM_CAP_NESTED_STATE
it returns the max size of nested_state?

>=20
> If, for example, we add a field to stash the time remaining for the
> VMCS12 VMX preemption timer, then presumably, userspace will enable it
> by enabling KVM_CAP_SAVE_VMX_PREEMPTION_TIMER (or something like
> that), and then userspace will know that the maximum nested state data
> is 4 bytes larger.

In that case, why did we defined struct kvm_nested_state to hold a blob =
of data[] instead
of separating the blob into well defined blobs? (e.g. Currently one blob =
for vmcs12 and another one for shadow vmcs12).
Then when we add a new component which is opt-in by a new KVM_CAP, we =
will add another well defined blob
to struct kvm_nested_state.

I think this is important because it allows us to specify in =
nested_state->flags which components are saved
and create multiple VMState subsections with needed() methods for the =
various saved components.

Thus allowing for example to easily still migrate from a new QEMU which =
does stash the time remaining for the VMCS12 VMX preemption timer
to an old QEMU which doesn=E2=80=99t stash it in case =
nested_state->flags specify that this component is not saved (Because L1 =
don=E2=80=99t use VMX preemption timer for example).

This seems to behave more nicely with how QEMU migration mechanism is =
defined and the purpose of VMState subsections.

In addition, if we will define struct kvm_nested_state like this, we =
will also not need the =E2=80=9Csize=E2=80=9D field which needs to be =
carefully handled to avoid buffer overflows.
(We will just define large enough buffers (with padding) for each opaque =
component such as vmcs12 and shadow vmcs12).

>=20
>> Also note that the approach suggested by Jim requires mgmt-layer at =
dest
>> to be able to specify to QEMU which KVM_CAP_NESTED_STATE_V* =
capabilities it should enable on kvm_init().
>> When we know we are migrating from a host which supports v1 to a host =
which supports v2,
>> we should make sure that dest QEMU doesn't enable =
KVM_CAP_NESTED_STATE_V2.
>> However, when we are just launching a new machine on the host which =
supports v2, we do want
>> QEMU to enable KVM_CAP_NESTED_STATE_V2 enabled for that VM.
>=20
> No, no, no. Even when launching a new VM on a host that supports v2,
> you cannot enable v2 until you have passed rollback horizon. Should
> you decide to roll back the kernel with v2 support, you must be able
> to move that new VM to a host with an old kernel.

If we use VMState subsections as I described above, QEMU should be able =
to know which components of nested_state are
actively saved by KVM and therefore are *required* to be restored on =
dest host in order to migrate without guest issues after it is resumed =
on dest.
Therefore, still allowing migration from new hosts to old hosts in case =
guest didn=E2=80=99t enter a state which makes new saved state required =
in order
for migration to succeed.

If the mechanism will work like this, nested_state KVM_CAPs enabled on =
QEMU launch are only used to inform KVM which
struct kvm_nested_state is used by userspace. Not what is actually sent =
as part of migration stream.

What are your thoughts on this?

-Liran

>=20
>> But on second thought, I'm not sure that this is the right approach =
as-well.
>> We don't really want the used version of nested_state to be =
determined on kvm_init().
>> * On source QEMU, we actually want to determine it when preparing for =
migration based
>> on to the support given by our destination host. If it's an old host, =
we would like to
>> save an old version nested_state and if it's a new host, we will like =
to save our newest
>> supported nested_state.
>> * On dest QEMU, we will want to just be able to set received =
nested_state in KVM.
>>=20
>> Therefore, I don't think that we want this versioning to be based on =
KVM_CAP at all.
>> It seems that we would want the process to behave as follows:
>> 1) Mgmt-layer at dest queries dest host max supported nested_state =
size.
>>   (Which should be returned from =
kvm_check_extension(KVM_CAP_NESTED_STATE))
>> 2) Mgmt-layer at source initiate migration to dest with requesting =
QEMU to send nested_state
>>   matching dest max supported nested_state size.
>>   When saving nested state using KVM_GET_NESTED_STATE IOCTL, QEMU =
will specify in nested_state->size
>>   the *requested* size to be saved and KVM should be able to save =
only the information which matches
>>   the version that worked with that size.
>> 3) After some sanity checks on received migration stream, dest host =
use KVM_SET_NESTED_STATE IOCTL.
>>   This IOCTL should deduce which information it should deploy based =
on given nested_state->size.
>>=20
>> This also makes me wonder if it's not just nicer to use =
nested_state->flags to specify which
>> information is actually present on nested_state instead of managing =
versioning with nested_state->size.
>=20
> Yes, you can use nested_state->flags to determine what the data
> payload is, but you cannot enable new flags unless userspace opts in.
> This is just like KVM_CAP_EXCEPTION_PAYLOAD for kvm_vcpu_events. The
> flag, KVM_VCPUEVENT_VALID_PAYLOAD, can only be set on the saved vcpu
> events if userspace has opted-in with KVM_CAP_EXCEPTION_PAYLOAD. This
> is because older kernels will reject kvm_vcpu_events that have the
> KVM_VCPUEVENT_VALID_PAYLOAD flag set.
>=20
> You don't need a new KVM_CAP_NESTED_STATE_V2 ioctl. You just need
> buy-in from userspace for any new data payload. Explicitly enumerating
> the payload components in the flags field makes perfect sense.
