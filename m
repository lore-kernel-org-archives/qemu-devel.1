Received: from eggs.gnu.org ([2001:4830:134:3::10]:40765)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1d7nXF-0005rd-JH
	for qemu-devel@nongnu.org; Mon, 08 May 2017 14:37:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1d7nXC-0006qk-Fs
	for qemu-devel@nongnu.org; Mon, 08 May 2017 14:37:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47486)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1d7nXC-0006pJ-9h
	for qemu-devel@nongnu.org; Mon, 08 May 2017 14:37:26 -0400
Date: Mon, 8 May 2017 19:37:19 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170508183718.GL2120@work-vm>
References: <20170505173507.74077-1-pasic@linux.vnet.ibm.com>
	<20170505173507.74077-10-pasic@linux.vnet.ibm.com>
	<20170508172757.GI2120@work-vm>
	<f0c6584a-1cd9-9aca-8eee-ef5cac26c613@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f0c6584a-1cd9-9aca-8eee-ef5cac26c613@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH 09/10] s390x/css: turn on channel subsystem
 migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Halil Pasic <pasic@linux.vnet.ibm.com>
Cc: Cornelia Huck <cornelia.huck@de.ibm.com>, qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>

* Halil Pasic (pasic@linux.vnet.ibm.com) wrote:
> 
> 
> On 05/08/2017 07:27 PM, Dr. David Alan Gilbert wrote:
> > * Halil Pasic (pasic@linux.vnet.ibm.com) wrote:
> >> Turn on migration for the channel subsystem and the new scheme for
> >> migrating virtio-ccw proxy devices (instead of letting the transport
> >> independent child device migrate it's proxy, use the usual
> >> DeviceClass.vmsd mechanism) for future machine versions.
> 
> [..]
> 
> >> +void css_register_vmstate(void)
> >> +{
> >> +    vmstate_register(NULL, 0, &vmstate_css, &channel_subsys);
> >> +}
> >> +
> > 
> > Why isn't that attached to a device vmsd? 
> 
> Because there is no device. The channel subsystem is not modeled 
> as a QEMU device but it does have state which needs to be
> migrated.

Ah OK.

> [..]
> 
> >> @@ -1365,6 +1373,11 @@ static void virtio_ccw_device_plugged(DeviceState *d, Error **errp)
> >>      sch->id.cu_model = virtio_bus_get_vdev_id(&dev->bus);
> >>  
> >>  
> >> +    /* Avoid generating unknown section for legacy migration target. */
> >> +    if (!css_migration_enabled()) {
> >> +        DEVICE_GET_CLASS(ccw_dev)->vmsd = NULL;
> >> +    }
> >> +
> > 
> > That's a very odd thing to do; can't you use a .needed at the
> > top level of the vmstate_virtio_ccw_dev to avoid having to
> > set it to NULL like this?
> > 
> 
> I agree it's odd. As far as I remember I can't use .needed but
> I will double check.

You can have top level .needed's - both vmstate_globalstate in
migration.c and colo's colo_state use them.

Dave

> Many thanks for your review!
> 
> Halil
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
