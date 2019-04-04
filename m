Received: from eggs.gnu.org ([209.51.188.92]:43559)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1hC1sF-0005LA-Du
	for qemu-devel@nongnu.org; Thu, 04 Apr 2019 08:53:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1hC1sE-0007dZ-64
	for qemu-devel@nongnu.org; Thu, 04 Apr 2019 08:53:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43600)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1hC1sD-0007ax-Tj
	for qemu-devel@nongnu.org; Thu, 04 Apr 2019 08:53:42 -0400
Date: Thu, 4 Apr 2019 13:53:01 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20190404125301.GX10471@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20190322134447.14831-1-jfreimann@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190322134447.14831-1-jfreimann@redhat.com>
Subject: Re: [Qemu-devel] [RFC PATCH 0/2] implement the failover feature for
 assigned network devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jens Freimann <jfreimann@redhat.com>
Cc: qemu-devel@nongnu.org, ehabkost@redhat.com, mst@redhat.com, mdroth@linux.vnet.ibm.com, pkrempa@redhat.com, laine@redhat.com, liran.alon@oracle.com, ogerlitz@mellanox.com, ailan@redhat.com

On Fri, Mar 22, 2019 at 02:44:45PM +0100, Jens Freimann wrote:
> Commandline: There is a dependency between vfio-pci and virtio-net
> devices. One points to the other via new parameters
> primar=<primary qdev id> and standby='<standby qdev id>'. This means
> that the primary device needs to be specified after standby device on 
> the qemu command line. Not sure how to solve this.

So we hae this pair of args

>         -device virtio-net-pci,netdev=hostnet1,id=net1,mac=52:54:00:6f:55:cc,bus=root2,primary=hostdev0 \                                                                                     
>         -device vfio-pci,host=5e:00.2,id=hostdev0,bus=root1,standby=net1 \

In this you have denoted the "vfio-pci" device as the primary and
"virtio-net-pci" as the standby.

There's no need for the user to specify the "primary" property for for
the "virtio-net-pci" NIC though. We only need to tell QEMU the relationship
in one direction and it can set the relationship in the reverse direction
automatically.

In fact it is undesirable for the user to specify "primary" property, as
they should be able to start QEMU with only the virtio-net-pci device
present and then hot-plug a vfio-pci on the fly when it is available.

So I think the "virtio-net-pci" merely needs a flag to indicate that it
should be prepared to take part in a failover pair, but *not* take any
device ID from the user.

eg we should be able to start with just

  -device virtio-net-pci,netdev=hostnet1,id=net1,\
          mac=52:54:00:6f:55:cc,bus=root2,failover=on

When vfio-pci is then created, either via a further -device arg on later
in QMP via device_add, it only needs to specify standby=net1.

When vfio-pci is realized it can lookup the virtio-net-pci device
in the QOM tree and set its "primary" property to point back to its
own device ID. There should never be any need for the user to tell
virtio-net-pci what the device ID of the vfio-pci is.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
