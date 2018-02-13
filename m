Received: from eggs.gnu.org ([2001:4830:134:3::10]:48535)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1eldoW-0006zm-OE
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 11:52:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1eldoT-0004MI-Mq
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 11:52:16 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:56308 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1eldoT-0004MA-Gk
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 11:52:13 -0500
Date: Tue, 13 Feb 2018 18:52:04 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180213184729-mutt-send-email-mst@kernel.org>
References: <1518116908-10852-1-git-send-email-mst@redhat.com>
	<CAFEAcA8kvkfoxnQbqZ4Y44uWtbsirCKdmTcnZJzu=ege9YRfTg@mail.gmail.com>
	<20180209190703-mutt-send-email-mst@kernel.org>
	<CAFEAcA_CL6P31EJyzxom1oh6j8LNDD2+OXjJ65hKsB=zBw6tWQ@mail.gmail.com>
	<CAFEAcA_z25p0NrRuH3vJm9mJJzHZXbgct2GwyojuHXKqejc8JA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA_z25p0NrRuH3vJm9mJJzHZXbgct2GwyojuHXKqejc8JA@mail.gmail.com>
Subject: Re: [Qemu-devel] [PULL 00/26] virtio, vhost, pci, pc: features,
 fixes and cleanups
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On Tue, Feb 13, 2018 at 04:33:14PM +0000, Peter Maydell wrote:
> On 12 February 2018 at 09:35, Peter Maydell <peter.maydell@linaro.org> wrote:
> > This asserts in 'make check' for NetBSD, FreeBSD, OpenBSD, OSX:
> >
> > TEST: tests/device-introspect-test... (pid=19530)
> >   /aarch64/device/introspect/list:                                     OK
> >   /aarch64/device/introspect/list-fields:                              OK
> >   /aarch64/device/introspect/none:                                     OK
> >   /aarch64/device/introspect/abstract:                                 OK
> >   /aarch64/device/introspect/concrete:                                 **
> > ERROR:/root/qemu/qom/object.c:372:object_initialize_with_type:
> > assertion failed: (type != NULL)
> > Broken pipe
> > FAIL
> > GTester: last random seed: R02Sd4e2c04f6ac00d843a31ccac4de0d914
> > (pid=12686)
> >   /aarch64/device/introspect/abstract-interfaces:                      OK
> > FAIL: tests/device-introspect-test
> >
> > (other archs fail too, aarch64 is just the first one we hit). This
> > error is often "device A instantiates device B, but device B is
> > conditionally compiled in and A is always compiled; so test fails
> > trying to create device A on hosts where device B isn't built" I think.
> 
> This part is indeed that problem -- the 'virtio-crypto-device' object
> is built only if CONFIG_LINUX, but 'virtio-crypto-pci' is built if
> CONFIG_VIRTIO_PCI, so on systems where the latter is true but not the
> former you get a virtio-crypto-pci device that crashes when instantiated.
> 
> The fix should be
> --- a/hw/virtio/Makefile.objs
> +++ b/hw/virtio/Makefile.objs
> @@ -8,7 +8,7 @@ obj-y += virtio.o virtio-balloon.o
>  obj-$(CONFIG_LINUX) += vhost.o vhost-backend.o vhost-user.o
>  obj-$(CONFIG_VHOST_VSOCK) += vhost-vsock.o
>  obj-$(CONFIG_LINUX) += virtio-crypto.o
> -obj-$(CONFIG_VIRTIO_PCI) += virtio-crypto-pci.o
> +obj-$(call land,$(CONFIG_LINUX),$(CONFIG_VIRTIO_PCI)) += virtio-crypto-pci.o
>  endif
> 
>  common-obj-$(call lnot,$(CONFIG_LINUX)) += vhost-stub.o
> 
> 
> thanks
> -- PMM

Thanks for your help with this!

I think the root cause is that one of the patches disables
virtio-crypto build on non linux which used to be enabled.

This has been silently done by a patch which was supposed to
merely add a vhost crypto device, I'm sorry I missed that
in the review.

I've dropped the crypto vhost patches from the pull request for now.

Pushed with the same name - should be fine now.

-- 
MST
