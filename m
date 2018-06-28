Received: from eggs.gnu.org ([2001:4830:134:3::10]:34939)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fYSFJ-0000uv-AX
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 04:25:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fYSFF-0002Qr-JX
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 04:25:41 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:40556 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1fYSFF-0002Q2-DU
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 04:25:37 -0400
Date: Thu, 28 Jun 2018 09:25:32 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180628082532.GB17326@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180627034935.20276-1-venu.busireddy@oracle.com>
	<20180627034935.20276-4-venu.busireddy@oracle.com>
	<20180627065943-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180627065943-mutt-send-email-mst@kernel.org>
Subject: Re: [Qemu-devel] [PATCH v2 3/4] Add "Group Identifier" support to
 Red Hat PCI bridge.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Venu Busireddy <venu.busireddy@oracle.com>, Marcel Apfelbaum <marcel@redhat.com>, virtio-dev@lists.oasis-open.org, qemu-devel@nongnu.org

On Wed, Jun 27, 2018 at 07:02:36AM +0300, Michael S. Tsirkin wrote:
> On Tue, Jun 26, 2018 at 10:49:33PM -0500, Venu Busireddy wrote:
> > Add the "Vendor-Specific" capability to the Red Hat PCI bridge device
> > "pci-bridge", to contain the "Group Identifier" (UUID) that will be
> > used to pair a virtio device with the passthrough device attached to
> > that bridge.
> > 
> > This capability is added to the bridge iff the "uuid" option is specified
> > for the bridge.
> 
> I think the name should be more explicit. How about "failover-group-id"?
> 
> > 
> > Signed-off-by: Venu Busireddy <venu.busireddy@oracle.com>
> 
> I'd like to also tweak the device id in this case,
> to make it easier for guests to know it's a grouping bridge.

I tend to think this proposal is rather too narrow. The need to tell
the guest OS about the intended usage of devices is a pretty common use
case, of which setting up bonding NIC pair is just one example.

OpenStack already has this problem & took the approach of providing some
structured JSON metadata to the guest that lists all devices  (well NICs
and disks at least) with identifying metadata (eg PCI address, MAC addr,
disk serial and anything else relevant), and also assigns freeform string
"tags" against each.  eg the host admin could specify tags "lanA" and "lanB"
for two NICs, so the guest knows which NIC to use for which purpose. This
kind of tagging could easily cover setting up bonded pairs. Or for a disk
they could tag it  "oracledata" or "apachecache" to indicate what kind of
data to use on the disk, etc

  https://specs.openstack.org/openstack/nova-specs/specs/mitaka/approved/virt-device-role-tagging.html

I'm not suggesting the impl used in OpenStack is perfect - there's a number
of pain points in it, but I think it shows the need for a general solution
to the problem of the host admin informing the guest OS about the intended
usage of devices being provided. I think freeform string tags do this
pretty well. The key problem is how to expose such tags - openstack took
approach of an out of band JSON doc exposed from its metadata service and
or cloud init config drive, because that was its only viable option.

Perhaps there is a way to expose tags at a low level though if we can
integrate with QEMU somehow ?

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
