Received: from eggs.gnu.org ([2001:4830:134:3::10]:46809)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cj6t5-0003SB-Ia
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 11:14:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cj6t2-0004Zu-8G
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 11:13:59 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39862)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1cj6t1-0004Zb-Vm
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 11:13:56 -0500
Date: Wed, 1 Mar 2017 16:13:48 +0000
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170301161348.GH10160@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <575E92DB.3080904@linux.vnet.ibm.com>
	<20160615193019.GB7300@work-vm>
	<5761C092.5070702@linux.vnet.ibm.com>
	<20160616080520.GA2249@work-vm> <20160616082517.GC11426@redhat.com>
	<5075d390-a1d1-b707-6b57-deb0154c2e37@linux.vnet.ibm.com>
	<20170301125414.GD10160@redhat.com>
	<OF00CA88E0.A7212243-ON002580D6.00498E3C-852580D6.0049CA7A@notes.na.collabserv.com>
	<20170301151803.GF10160@redhat.com>
	<2a01a2ed-0588-81ff-03d8-f0e86ae5d440@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2a01a2ed-0588-81ff-03d8-f0e86ae5d440@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v5 1/4] Provide support for the CUSE TPM
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Berger <stefanb@linux.vnet.ibm.com>
Cc: Stefan Berger <stefanb@us.ibm.com>, "mst@redhat.com" <mst@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, "hagen.lauer@huawei.com" <hagen.lauer@huawei.com>, "Xu, Quan" <quan.xu@intel.com>, "silviu.vlasceanu@gmail.com" <silviu.vlasceanu@gmail.com>, "SERBAN, CRISTINA" <cs1731@att.com>, "SHIH, CHING C" <cs1815@att.com>

On Wed, Mar 01, 2017 at 10:40:13AM -0500, Stefan Berger wrote:
> On 03/01/2017 10:18 AM, Daniel P. Berrange wrote:
> > This goes back to the question Dave mentions above ? Ignoring the control
> > channel aspect temporarily, can the CUSE TPM support the exact same ioctl
> > interface as the existing kernel TPM device ? It feels like this should
> > be possible, and if so, then this virtal TPM feature can be considered to
> > have two separate pieces.
> 
> The existing kernel device has not ioctl interface. If it had one, it
> wouldn't have the same since the control channel implemented on the ioctl
> interface is related to low level commands such as resetting the device when
> the platform resets, etc.

Ok, well what I meant is the CUSE TPM device should implement the same
API/ABI as the existing kernel TPM and vTPM devices.

> > First enabling basic CUSE TPM device support would not require QEMU changes,
> > as we could just use the existing tpm-passthrough driver against the CUSE
> > device, albeit with the limitations around migration, snapshot etc.
> 
> ... and device reset upon VM reset. You want to have at least that since
> otherwise the PCRs will not be in the correct state once the firmware with
> TPM support startes extending them. They need to be reset and the only way
> to do that is through some control channel command.

How does that work with real TPM device passthrough ?  Is it simply broken
if the VM is reset ?

> > Second we could consider the question of supporting a control channel as
> > a separate topic. IIUC, QEMU essentially needs a way to trigger various
> > operations in the underlying TPM implementation, when certain lifecycle
> > operations are performed on the VM. I could see this being done as a
> > simple network protocol over a UNIX socket. So, you could then add a
> > new 'chardev' property to the tpm-passthrough device, which gives the
> > ID of a character device that provides the control channel.
> 
> Why would that other control channel need to be a device rather than an
> ioctl on the device? Or maybe entirely access the emulated TPM through
> UnixIO ?

I'm not suggesting another device - I'm saying use a QEMU chardev
backend API - which lets you use multipl transports, one of which
is UNIX sockets.

> > This way QEMU does not need to have any special code to deal with CUSE
> > directly. QEMU could be used with a real TPM device, a vTPM device or
> > a CUSE TPM device, with the same driver. With both the vTPM and the
> > CUSE TPM device, QEMU would have the ability to use a out of band
> > control channel when migration/snapshot/etc take place.
> > 
> > This cleanly isolates QEMU from the particular design & implementation
> > that is currently used by the current swtpm code.
> 
> Someone needs to define the control channel commands.My definition is here:
> 
> https://github.com/stefanberger/qemu-tpm/commit/27d6cd856d5a14061955df7a93ee490697a7a174#diff-5cc0e46d3ec33a3f4262db773c193dfe
> 
> 
>  This won't go away even if we changed the transport for the commands.
> ioctl's seem to be one way of achieving this with a character device. The
> socket based control channels of 'swtpm' use the same commands.

Essentially the control channel is an RPC interface to an external
process managing virtual TPM. By common agreement, ioctl() is one
of the worst parts of the UNIX ABI, and thus so I'm loathe to see
us an RPC interface between QEMU & an external process, using ioctl.
The exception would be if this was for interoperability with an
existing standard, but this isn't the case here - the ioctl proposal
is a green-field design. I can't help thinking it'd be better from
QEMU's POV to just use QAPI for the RPC.

Regards,
Daniel
-- 
|: http://berrange.com      -o-    http://www.flickr.com/photos/dberrange/ :|
|: http://libvirt.org              -o-             http://virt-manager.org :|
|: http://entangle-photo.org       -o-    http://search.cpan.org/~danberr/ :|
