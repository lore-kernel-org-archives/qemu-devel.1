Received: from eggs.gnu.org ([2001:4830:134:3::10]:42843)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gIcmp-0000n9-Bv
	for qemu-devel@nongnu.org; Fri, 02 Nov 2018 12:59:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gIcmk-0007fo-JG
	for qemu-devel@nongnu.org; Fri, 02 Nov 2018 12:59:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51226)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1gIcmi-0007Mx-JF
	for qemu-devel@nongnu.org; Fri, 02 Nov 2018 12:59:00 -0400
Date: Fri, 2 Nov 2018 16:58:07 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20181102165807.GG21191@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <CALMp9eQ5zWxb2N9fyYz=WcQshwk0L6qQ4D6L6+p_dzMo4H=txA@mail.gmail.com>
	<20181102034649.43559-1-liran.alon@oracle.com>
	<12c26c34-8dd1-a442-7826-86b93ff978f8@redhat.com>
	<95850543-FE41-404F-9775-23E792F6428E@oracle.com>
	<CALMp9eSSe2ZBQrAsyLDfOSiWydXhphcj6xe0x1yZ8Dg_yXnpUQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CALMp9eSSe2ZBQrAsyLDfOSiWydXhphcj6xe0x1yZ8Dg_yXnpUQ@mail.gmail.com>
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
Cc: Liran Alon <liran.alon@oracle.com>, Eduardo Habkost <ehabkost@redhat.com>, kvm list <kvm@vger.kernel.org>, mtosatti@redhat.com, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, rth@twiddle.net

On Fri, Nov 02, 2018 at 09:44:54AM -0700, Jim Mattson via Qemu-devel wrote:
> On Fri, Nov 2, 2018 at 5:59 AM, Liran Alon <liran.alon@oracle.com> wrote:
> >
> 
> >>> Therefore, I don't think that we want this versioning to be based on KVM_CAP at all.
> >>> It seems that we would want the process to behave as follows:
> >>> 1) Mgmt-layer at dest queries dest host max supported nested_state size.
> >>>   (Which should be returned from kvm_check_extension(KVM_CAP_NESTED_STATE))
> >>> 2) Mgmt-layer at source initiate migration to dest with requesting QEMU to send nested_state
> >>>   matching dest max supported nested_state size.
> >>>   When saving nested state using KVM_GET_NESTED_STATE IOCTL, QEMU will specify in nested_state->size
> >>>   the *requested* size to be saved and KVM should be able to save only the information which matches
> >>>   the version that worked with that size.
> >>> 3) After some sanity checks on received migration stream, dest host use KVM_SET_NESTED_STATE IOCTL.
> >>>   This IOCTL should deduce which information it should deploy based on given nested_state->size.
> 
> I have to object to any proposal which requires the management later
> to communicate with the source and the destination to determine what
> should be done.

Can you elaborate on why you object ?

There are a bunch of features in QEMU's migration code which require
the mgmt layer to look at source + dest to determine what should be
done. Admittedly the cases we have had so far are generic migration
features (compression, multifd, postcopy, TLS, etc), while this is
a host kernel feature. I don't think it is that far outside the
normal practice wrt migration feature usage decision making though.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
