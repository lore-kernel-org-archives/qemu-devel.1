Received: from eggs.gnu.org ([2001:4830:134:3::10]:54057)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fg7NF-0003we-6J
	for qemu-devel@nongnu.org; Thu, 19 Jul 2018 07:45:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fg7NA-00049c-49
	for qemu-devel@nongnu.org; Thu, 19 Jul 2018 07:45:33 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:41732 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1fg7N9-00048z-Oj
	for qemu-devel@nongnu.org; Thu, 19 Jul 2018 07:45:28 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 44EED402B03F
	for <qemu-devel@nongnu.org>; Thu, 19 Jul 2018 11:45:27 +0000 (UTC)
Date: Thu, 19 Jul 2018 13:45:22 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180719134522.5de53f8f.cohuck@redhat.com>
In-Reply-To: <2767a97a-006d-46cd-ce16-7cfedc93ef29@redhat.com>
References: <20180717120414.5852-1-quintela@redhat.com>
	<eb90a7b9-5a02-b9f7-c989-f646a272c4f3@redhat.com>
	<87601dztj3.fsf@secure.mitica>
	<2767a97a-006d-46cd-ce16-7cfedc93ef29@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC 00/14] More patches to disable stuff
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: quintela@redhat.com, lvivier@redhat.com, qemu-devel@nongnu.org, peterx@redhat.com, dgilbert@redhat.com

On Thu, 19 Jul 2018 13:06:59 +0200
Thomas Huth <thuth@redhat.com> wrote:

> On 17.07.2018 19:00, Juan Quintela wrote:

> > So far so good, but look at virtio-pci.c:
> > 
> > static void virtio_rng_pci_realize(VirtIOPCIProxy *vpci_dev, Error **errp)
> > {
> >    ...
> > }
> > 
> > static void virtio_rng_pci_class_init(ObjectClass *klass, void *data)
> > {
> >    ....
> > }
> > 
> > static void virtio_rng_initfn(Object *obj)
> > {
> >    ...
> > }
> > 
> > static const TypeInfo virtio_rng_pci_info = {
> >     .name          = TYPE_VIRTIO_RNG_PCI,
> >     .parent        = TYPE_VIRTIO_PCI,
> >     .instance_size = sizeof(VirtIORngPCI),
> >     .instance_init = virtio_rng_initfn,
> >     .class_init    = virtio_rng_pci_class_init,
> > };
> > 
> > static void virtio_pci_register_types(void)
> > {
> >     type_register_static(&virtio_rng_pci_info);
> > ...
> > }
> > 
> > See, we have defined the device "virtio-rng-pci", but there is no
> > implementation.  WHen I run device-intronspection-test on that qemu with
> > CONFIG_VIRTIO_RNG, it fails to run.  If we can agree that something is
> > wrong, then we can search for a solution.  
> 
> I agree with you that the current situation with virtio-pci. c is bad. I
> think we should split it up into individual files instead
> (virtio-pci-rng.c etc.).

We should then do the same thing for virtio-ccw as well.
