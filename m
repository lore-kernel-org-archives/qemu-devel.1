Received: from eggs.gnu.org ([2001:4830:134:3::10]:60452)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1d47oA-0007Af-HM
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 11:27:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1d47o7-00061B-9U
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 11:27:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39052)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1d47o6-0005zp-V7
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 11:27:43 -0400
Date: Fri, 28 Apr 2017 16:27:29 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170428152729.GI2085@work-vm>
References: <20170428021317.24711-1-eblake@redhat.com>
	<20170428021317.24711-3-eblake@redhat.com>
	<20170428080821.GB2085@work-vm>
	<3a8d9f68-f30c-1191-ca80-a93f0050f011@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3a8d9f68-f30c-1191-ca80-a93f0050f011@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v5 2/4] shutdown: Prepare for use of an
 enum in reset/shutdown_request
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, armbru@redhat.com, berrange@redhat.com, alistair.francis@xilinx.com, Stefano Stabellini <sstabellini@kernel.org>, Anthony Perard <anthony.perard@citrix.com>, "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, zhanghailiang <zhang.zhanghailiang@huawei.com>, Juan Quintela <quintela@redhat.com>, "open list:X86" <xen-devel@lists.xenproject.org>

* Eric Blake (eblake@redhat.com) wrote:
> On 04/28/2017 03:08 AM, Dr. David Alan Gilbert wrote:
> > * Eric Blake (eblake@redhat.com) wrote:
> >> We want to track why a guest was shutdown; in particular, being able
> >> to tell the difference between a guest request (such as ACPI request)
> >> and host request (such as SIGINT) will prove useful to libvirt.
> >> Since all requests eventually end up changing shutdown_requested in
> >> vl.c, the logical change is to make that value track the reason,
> >> rather than its current 0/1 contents.
> >>
> 
> >>  ##
> >> +# @ShutdownCause:
> >> +#
> >> +# Enumeration of various causes for shutdown.
> >> +#
> >> +# @host-qmp: Reaction to a QMP command, such as 'quit'
> >> +# @host-signal: Reaction to a signal, such as SIGINT
> >> +# @host-ui: Reaction to a UI event, such as closing the window
> >> +# @host-replay: The host is replaying an earlier shutdown event
> >> +# @host-error: Qemu encountered an error that prevents further use of the guest
> >> +# @guest-shutdown: The guest requested a shutdown, such as via ACPI or
> >> +#                  other hardware-specific action
> >> +# @guest-reset: The guest requested a reset, and the command line
> >> +#               response to a reset is to instead trigger a shutdown
> >> +# @guest-panic: The guest panicked, and the command line response to
> >> +#               a panic is to trigger a shutdown
> > 
> > It's a little coarse grained;  is there anyway to pass platform specific information
> > for debug?  I ask because I spent a while debugging a few bugs with unexpected
> > resets and had to figure out which of x86's many reset causes triggered it.
> 
> I'm open to any followup patches that add further enum values and
> adjusts the various callers (patch 3 shows how MANY callers use
> qemu_system_shutdown_request).  But I don't think it's necessarily in
> scope for this series - remember, my goal here was merely to distinguish
> between host- and guest-triggered resets (which libvirt and higher
> management tasks want to know)

Yep, that's fine.

> rather than which of multiple reset
> paths was taken (I agree that it is useful during a qemu debug session -
> but that's a different audience).  I also don't consider myself an
> expert in the many ways that x86 can reset - it was easy to blindly
> rewrite qemu_system_shutdown_request() into
> qemu_system_shutdown_request(SHUTDOWN_CAUSE_GUEST_SHUTDOWN) based solely
> on directory, but it would be harder to distinguish which of the
> multiple files should have which finer-grained cause.

Yes, I'm also not an expert on x86 resets - but when I was debugging
I just added a tag in every place it called the reset code.

At a higher level, using your tags, I'm not sure where a reset triggered
by a fault detected by the hypervisor lives - e.g. an x86 triple fault
where the guest screws up so badly that it just gets reset.  Is
that a guest-reset or a guest-panic or what - neither case
was actually asked for by the guest itself.

Dave


> 
> -- 
> Eric Blake, Principal Software Engineer
> Red Hat, Inc.           +1-919-301-3266
> Virtualization:  qemu.org | libvirt.org
> 



--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
