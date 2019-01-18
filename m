Received: from eggs.gnu.org ([209.51.188.92]:48630)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gkRGz-0002BN-Hh
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 05:21:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gkRGt-0007Te-U8
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 05:21:13 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34876)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1gkRGt-0007TC-OC
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 05:21:07 -0500
Date: Fri, 18 Jan 2019 10:21:02 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20190118102102.GH20660@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <CALm7yL1oob_T+--=iW-iOQfEzJjP7reX9KrozEL2c4mYyX51jA@mail.gmail.com>
	<20190118100159.GA2483@work-vm>
	<8f0f7339-5f47-46d0-20a9-343badad4d0f@redhat.com>
	<20190118101633.GC2146@work-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190118101633.GC2146@work-vm>
Subject: Re: [Qemu-devel] Live migration from Qemu 2.12 hosts to Qemu 3.2
 hosts, with VMX flag enabled in the guest?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Mark Mielke <mark.mielke@gmail.com>, qemu-devel@nongnu.org, christian.ehrhardt@canonical.com

On Fri, Jan 18, 2019 at 10:16:34AM +0000, Dr. David Alan Gilbert wrote:
> * Paolo Bonzini (pbonzini@redhat.com) wrote:
> > On 18/01/19 11:02, Dr. David Alan Gilbert wrote:
> > >>
> > >> It fails if the flag is set, rather than if any nested virtualization has
> > >> been used before.
> > >>
> > >> I'm concerned I will end up with a requirement for *all* guests to be
> > >> restarted in order to migrate them to the new hosts, rather than just the
> > >> ones that would have a problem.
> > > I think you should be able to migrate from 2.12->3.1 like this, but
> > > you'd hit the problem when you then try and migrate again between your
> > > new QEMUs.
> > > 
> > > I guess we could modify it to wire it to machine type, so that
> > > older machine types didn't block.
> > 
> > That would also be wrong.  The old machine types _could_ be using KVM
> > and they have no way to block the live migration.
> > 
> > The solution is to restart the VM using "-cpu host,-vmx".
> 
> The problem as Christian explained in that thread is that it was common
> for them to start VMs with vmx enabled but for people not to use it
> on most of the VMs, so we break migration for most VMs even though most
> don't use it.
> 
> It might not be robust, but it worked for a lot of people most of the
> time.

Yes, this is exactly why I said we should make the migration blocker
be conditional on any L2 guest having been started. I vaguely recall
someone saying there wasn't any way to detect this situation from
QEMU though ?

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
