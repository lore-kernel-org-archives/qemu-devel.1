Received: from eggs.gnu.org ([2001:4830:134:3::10]:47119)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liran.alon@oracle.com>) id 1gIQQO-0005XA-Hb
	for qemu-devel@nongnu.org; Thu, 01 Nov 2018 23:47:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liran.alon@oracle.com>) id 1gIQQK-0001jO-HI
	for qemu-devel@nongnu.org; Thu, 01 Nov 2018 23:47:08 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:58510)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <liran.alon@oracle.com>)
	id 1gIQQK-0001iX-6q
	for qemu-devel@nongnu.org; Thu, 01 Nov 2018 23:47:04 -0400
From: Liran Alon <liran.alon@oracle.com>
Date: Fri,  2 Nov 2018 05:46:49 +0200
Message-Id: <20181102034649.43559-1-liran.alon@oracle.com>
In-Reply-To: <CALMp9eQ5zWxb2N9fyYz=WcQshwk0L6qQ4D6L6+p_dzMo4H=txA@mail.gmail.com>
References: <CALMp9eQ5zWxb2N9fyYz=WcQshwk0L6qQ4D6L6+p_dzMo4H=txA@mail.gmail.com>
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
To: jmattson@google.com
Cc: dgilbert@redhat.com, pbonzini@redhat.com, ehabkost@redhat.com, kvm@vger.kernel.org, mtosatti@redhat.com, rth@twiddle.net, qemu-devel@nongnu.org, Liran Alon <liran.alon@oracle.com>

> On Thu, Nov1, 2018 at 09:45 AM, Jim Mattson <jmattson@google.com> wrote:

>> On Thu, Nov 1, 2018 at 8:56 AM, Dr. David Alan Gilbert <dgilbert@redhat.com> wrote:

>> So if I have matching host kernels it should always work?
>> What happens if I upgrade the source kernel to increase it's maximum
>> nested size, can I force it to keep things small for some VMs?

> Any change to the format of the nested state should be gated by a
> KVM_CAP set by userspace. (Unlike, say, how the
> KVM_VCPUEVENT_VALID_SMM flag was added to the saved VCPU events state
> in commit f077825a8758d.) KVM has traditionally been quite bad about
> maintaining backwards compatibility, but I hope the community is more
> cognizant of the issues now.

> As a cloud provider, one would only enable the new capability from
> userspace once all hosts in the pool have a kernel that supports it.
> During the transition, the capability would not be enabled on the
> hosts with a new kernel, and these hosts would continue to provide
> nested state that could be consumed by hosts running the older kernel.

Hmm this makes sense.

This means though that the patch I have submitted here isn't good enough.
My patch currently assumes that when it attempts to get nested state from KVM,
QEMU should always set nested_state->size to max size supported by KVM as received
from kvm_check_extension(s, KVM_CAP_NESTED_STATE);
(See kvm_get_nested_state() introduced on my patch).
This indeed won't allow migration from host with new KVM to host with old KVM if
nested_state size was enlarged between these KVM versions.
Which is obviously an issue.

Jim, I think that my confusion was created from the fact that there is no clear documentation
on how KVM_{GET,SET}_NESTED_STATE should be changed once we will need to add more state to
nested_state in future KVM versions. I think it's worth adding that to IOCTLs documentation.

For example, let's assume we have a new KVM_CAP_NESTED_STATE_V2.
In this scenario, does kvm_check_extension(s, KVM_CAP_NESTED_STATE) still returns the
size of nested_state v1 and kvm_check_extension(s, KVM_CAP_NESTED_STATE_V2) returns the
size of the nested_state v2?

Also note that the approach suggested by Jim requires mgmt-layer at dest
to be able to specify to QEMU which KVM_CAP_NESTED_STATE_V* capabilities it should enable on kvm_init().
When we know we are migrating from a host which supports v1 to a host which supports v2,
we should make sure that dest QEMU doesn't enable KVM_CAP_NESTED_STATE_V2.
However, when we are just launching a new machine on the host which supports v2, we do want
QEMU to enable KVM_CAP_NESTED_STATE_V2 enabled for that VM.

But on second thought, I'm not sure that this is the right approach as-well.
We don't really want the used version of nested_state to be determined on kvm_init().
* On source QEMU, we actually want to determine it when preparing for migration based
on to the support given by our destination host. If it's an old host, we would like to
save an old version nested_state and if it's a new host, we will like to save our newest
supported nested_state.
* On dest QEMU, we will want to just be able to set received nested_state in KVM.

Therefore, I don't think that we want this versioning to be based on KVM_CAP at all.
It seems that we would want the process to behave as follows:
1) Mgmt-layer at dest queries dest host max supported nested_state size.
   (Which should be returned from kvm_check_extension(KVM_CAP_NESTED_STATE))
2) Mgmt-layer at source initiate migration to dest with requesting QEMU to send nested_state 
   matching dest max supported nested_state size.
   When saving nested state using KVM_GET_NESTED_STATE IOCTL, QEMU will specify in nested_state->size
   the *requested* size to be saved and KVM should be able to save only the information which matches
   the version that worked with that size.
3) After some sanity checks on received migration stream, dest host use KVM_SET_NESTED_STATE IOCTL.
   This IOCTL should deduce which information it should deploy based on given nested_state->size.

This also makes me wonder if it's not just nicer to use nested_state->flags to specify which
information is actually present on nested_state instead of managing versioning with nested_state->size.

What are your opinions on this?

-Liran
