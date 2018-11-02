Received: from eggs.gnu.org ([2001:4830:134:3::10]:58561)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gIVwg-0007M2-Ny
	for qemu-devel@nongnu.org; Fri, 02 Nov 2018 05:40:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gIVwb-0001qF-Lr
	for qemu-devel@nongnu.org; Fri, 02 Nov 2018 05:40:50 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:38750)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1gIVwZ-0001mF-Kv
	for qemu-devel@nongnu.org; Fri, 02 Nov 2018 05:40:43 -0400
Received: by mail-wm1-x342.google.com with SMTP id l2-v6so1337385wmh.3
	for <qemu-devel@nongnu.org>; Fri, 02 Nov 2018 02:40:41 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
References: <CALMp9eQ5zWxb2N9fyYz=WcQshwk0L6qQ4D6L6+p_dzMo4H=txA@mail.gmail.com>
	<20181102034649.43559-1-liran.alon@oracle.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <12c26c34-8dd1-a442-7826-86b93ff978f8@redhat.com>
Date: Fri, 2 Nov 2018 10:40:35 +0100
MIME-Version: 1.0
In-Reply-To: <20181102034649.43559-1-liran.alon@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
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
To: Liran Alon <liran.alon@oracle.com>, jmattson@google.com
Cc: dgilbert@redhat.com, ehabkost@redhat.com, kvm@vger.kernel.org, mtosatti@redhat.com, rth@twiddle.net, qemu-devel@nongnu.org

On 02/11/2018 04:46, Liran Alon wrote:
>> On Thu, Nov1, 2018 at 09:45 AM, Jim Mattson <jmattson@google.com> wrote:
> 
>>> On Thu, Nov 1, 2018 at 8:56 AM, Dr. David Alan Gilbert <dgilbert@redhat.com> wrote:
> 
>>> So if I have matching host kernels it should always work?
>>> What happens if I upgrade the source kernel to increase it's maximum
>>> nested size, can I force it to keep things small for some VMs?
> 
>> Any change to the format of the nested state should be gated by a
>> KVM_CAP set by userspace. (Unlike, say, how the
>> KVM_VCPUEVENT_VALID_SMM flag was added to the saved VCPU events state
>> in commit f077825a8758d.) KVM has traditionally been quite bad about
>> maintaining backwards compatibility, but I hope the community is more
>> cognizant of the issues now.
> 
>> As a cloud provider, one would only enable the new capability from
>> userspace once all hosts in the pool have a kernel that supports it.
>> During the transition, the capability would not be enabled on the
>> hosts with a new kernel, and these hosts would continue to provide
>> nested state that could be consumed by hosts running the older kernel.
> 
> Hmm this makes sense.
> 
> This means though that the patch I have submitted here isn't good enough.
> My patch currently assumes that when it attempts to get nested state from KVM,
> QEMU should always set nested_state->size to max size supported by KVM as received
> from kvm_check_extension(s, KVM_CAP_NESTED_STATE);
> (See kvm_get_nested_state() introduced on my patch).
> This indeed won't allow migration from host with new KVM to host with old KVM if
> nested_state size was enlarged between these KVM versions.
> Which is obviously an issue.

Actually I think this is okay, because unlike the "new" capability was
enabled, KVM would always reduce nested_state->size to a value that is
compatible with current kernels.

> But on second thought, I'm not sure that this is the right approach as-well.
> We don't really want the used version of nested_state to be determined on kvm_init().
> * On source QEMU, we actually want to determine it when preparing for migration based
> on to the support given by our destination host. If it's an old host, we would like to
> save an old version nested_state and if it's a new host, we will like to save our newest
> supported nested_state.

No, that's wrong because it would lead to losing state.  If the source
QEMU supports more state than the destination QEMU, and the current VM
state needs to transmit it for migration to be _correct_, then migration
to that destination QEMU must fail.

In particular, enabling the new KVM capability needs to be gated by a
new machine type and/or -cpu flag, if migration compatibility is needed.
 (In particular, this is one reason why I haven't considered this series
for 3.1.  Right now, migration of nested hypervisors is completely
busted but if we make it "almost" work, pre-3.1 machine types would not
ever be able to add support for KVM_CAP_EXCEPTION_PAYLOAD.  Therefore,
it's better for users if we wait for one release more, and add support
for KVM_CAP_NESTED_STATE and KVM_CAP_EXCEPTION_PAYLOAD at the same time).

Personally, I would like to say that, starting from QEMU 3.2, enabling
nested VMX requires a 4.20 kernel.  It's a bit bold, but I think it's a
good way to keep some sanity.  Any opinions on that?

Paolo

> Therefore, I don't think that we want this versioning to be based on KVM_CAP at all.
> It seems that we would want the process to behave as follows:
> 1) Mgmt-layer at dest queries dest host max supported nested_state size.
>    (Which should be returned from kvm_check_extension(KVM_CAP_NESTED_STATE))
> 2) Mgmt-layer at source initiate migration to dest with requesting QEMU to send nested_state 
>    matching dest max supported nested_state size.
>    When saving nested state using KVM_GET_NESTED_STATE IOCTL, QEMU will specify in nested_state->size
>    the *requested* size to be saved and KVM should be able to save only the information which matches
>    the version that worked with that size.
> 3) After some sanity checks on received migration stream, dest host use KVM_SET_NESTED_STATE IOCTL.
>    This IOCTL should deduce which information it should deploy based on given nested_state->size.
> 
> This also makes me wonder if it's not just nicer to use nested_state->flags to specify which
> information is actually present on nested_state instead of managing versioning with nested_state->size.
> 
> What are your opinions on this?
> 
> -Liran
> 
