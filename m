Received: from eggs.gnu.org ([2001:4830:134:3::10]:43425)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gIYw2-0005NI-Rb
	for qemu-devel@nongnu.org; Fri, 02 Nov 2018 08:52:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gIYl5-0006y3-7Y
	for qemu-devel@nongnu.org; Fri, 02 Nov 2018 08:41:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33572)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1gIYl4-0006xj-VY
	for qemu-devel@nongnu.org; Fri, 02 Nov 2018 08:41:03 -0400
Date: Fri, 2 Nov 2018 12:40:48 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20181102124048.GE21191@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <CALMp9eQ5zWxb2N9fyYz=WcQshwk0L6qQ4D6L6+p_dzMo4H=txA@mail.gmail.com>
	<20181102034649.43559-1-liran.alon@oracle.com>
	<12c26c34-8dd1-a442-7826-86b93ff978f8@redhat.com>
	<20181102123504.GA2387@work-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181102123504.GA2387@work-vm>
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
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, ehabkost@redhat.com, kvm@vger.kernel.org, mtosatti@redhat.com, qemu-devel@nongnu.org, Liran Alon <liran.alon@oracle.com>, jmattson@google.com, rth@twiddle.net

On Fri, Nov 02, 2018 at 12:35:05PM +0000, Dr. David Alan Gilbert wrote:
> * Paolo Bonzini (pbonzini@redhat.com) wrote:
> > On 02/11/2018 04:46, Liran Alon wrote:
> > >> On Thu, Nov1, 2018 at 09:45 AM, Jim Mattson <jmattson@google.com> wrote:
> > > 
> > >>> On Thu, Nov 1, 2018 at 8:56 AM, Dr. David Alan Gilbert <dgilbert@redhat.com> wrote:
> > > 
> > >>> So if I have matching host kernels it should always work?
> > >>> What happens if I upgrade the source kernel to increase it's maximum
> > >>> nested size, can I force it to keep things small for some VMs?
> > > 
> > >> Any change to the format of the nested state should be gated by a
> > >> KVM_CAP set by userspace. (Unlike, say, how the
> > >> KVM_VCPUEVENT_VALID_SMM flag was added to the saved VCPU events state
> > >> in commit f077825a8758d.) KVM has traditionally been quite bad about
> > >> maintaining backwards compatibility, but I hope the community is more
> > >> cognizant of the issues now.
> > > 
> > >> As a cloud provider, one would only enable the new capability from
> > >> userspace once all hosts in the pool have a kernel that supports it.
> > >> During the transition, the capability would not be enabled on the
> > >> hosts with a new kernel, and these hosts would continue to provide
> > >> nested state that could be consumed by hosts running the older kernel.
> > > 
> > > Hmm this makes sense.
> > > 
> > > This means though that the patch I have submitted here isn't good enough.
> > > My patch currently assumes that when it attempts to get nested state from KVM,
> > > QEMU should always set nested_state->size to max size supported by KVM as received
> > > from kvm_check_extension(s, KVM_CAP_NESTED_STATE);
> > > (See kvm_get_nested_state() introduced on my patch).
> > > This indeed won't allow migration from host with new KVM to host with old KVM if
> > > nested_state size was enlarged between these KVM versions.
> > > Which is obviously an issue.
> > 
> > Actually I think this is okay, because unlike the "new" capability was
> > enabled, KVM would always reduce nested_state->size to a value that is
> > compatible with current kernels.
> > 
> > > But on second thought, I'm not sure that this is the right approach as-well.
> > > We don't really want the used version of nested_state to be determined on kvm_init().
> > > * On source QEMU, we actually want to determine it when preparing for migration based
> > > on to the support given by our destination host. If it's an old host, we would like to
> > > save an old version nested_state and if it's a new host, we will like to save our newest
> > > supported nested_state.
> > 
> > No, that's wrong because it would lead to losing state.  If the source
> > QEMU supports more state than the destination QEMU, and the current VM
> > state needs to transmit it for migration to be _correct_, then migration
> > to that destination QEMU must fail.
> > 
> > In particular, enabling the new KVM capability needs to be gated by a
> > new machine type and/or -cpu flag, if migration compatibility is needed.
> >  (In particular, this is one reason why I haven't considered this series
> > for 3.1.  Right now, migration of nested hypervisors is completely
> > busted but if we make it "almost" work, pre-3.1 machine types would not
> > ever be able to add support for KVM_CAP_EXCEPTION_PAYLOAD.  Therefore,
> > it's better for users if we wait for one release more, and add support
> > for KVM_CAP_NESTED_STATE and KVM_CAP_EXCEPTION_PAYLOAD at the same time).
> > 
> > Personally, I would like to say that, starting from QEMU 3.2, enabling
> > nested VMX requires a 4.20 kernel.  It's a bit bold, but I think it's a
> > good way to keep some sanity.  Any opinions on that?
> 
> That seems a bit mean; there's a lot of people already using nested.

Agreed, it would be a significant regression for people. They may not
even care about migration, so we should not block its use with old
kernels just for the sake of working migration that they won't use.


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
