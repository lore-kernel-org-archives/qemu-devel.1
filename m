Received: from eggs.gnu.org ([2001:4830:134:3::10]:43430)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eldWS-0006xt-LK
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 11:33:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eldWR-0000sW-KX
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 11:33:36 -0500
Received: from mail-oi0-x22c.google.com ([2607:f8b0:4003:c06::22c]:44570)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eldWR-0000qJ-E7
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 11:33:35 -0500
Received: by mail-oi0-x22c.google.com with SMTP id b3so14296414oib.11
	for <qemu-devel@nongnu.org>; Tue, 13 Feb 2018 08:33:35 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_CL6P31EJyzxom1oh6j8LNDD2+OXjJ65hKsB=zBw6tWQ@mail.gmail.com>
References: <1518116908-10852-1-git-send-email-mst@redhat.com>
	<CAFEAcA8kvkfoxnQbqZ4Y44uWtbsirCKdmTcnZJzu=ege9YRfTg@mail.gmail.com>
	<20180209190703-mutt-send-email-mst@kernel.org>
	<CAFEAcA_CL6P31EJyzxom1oh6j8LNDD2+OXjJ65hKsB=zBw6tWQ@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 13 Feb 2018 16:33:14 +0000
Message-ID: <CAFEAcA_z25p0NrRuH3vJm9mJJzHZXbgct2GwyojuHXKqejc8JA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 12 February 2018 at 09:35, Peter Maydell <peter.maydell@linaro.org> wrote:
> This asserts in 'make check' for NetBSD, FreeBSD, OpenBSD, OSX:
>
> TEST: tests/device-introspect-test... (pid=19530)
>   /aarch64/device/introspect/list:                                     OK
>   /aarch64/device/introspect/list-fields:                              OK
>   /aarch64/device/introspect/none:                                     OK
>   /aarch64/device/introspect/abstract:                                 OK
>   /aarch64/device/introspect/concrete:                                 **
> ERROR:/root/qemu/qom/object.c:372:object_initialize_with_type:
> assertion failed: (type != NULL)
> Broken pipe
> FAIL
> GTester: last random seed: R02Sd4e2c04f6ac00d843a31ccac4de0d914
> (pid=12686)
>   /aarch64/device/introspect/abstract-interfaces:                      OK
> FAIL: tests/device-introspect-test
>
> (other archs fail too, aarch64 is just the first one we hit). This
> error is often "device A instantiates device B, but device B is
> conditionally compiled in and A is always compiled; so test fails
> trying to create device A on hosts where device B isn't built" I think.

This part is indeed that problem -- the 'virtio-crypto-device' object
is built only if CONFIG_LINUX, but 'virtio-crypto-pci' is built if
CONFIG_VIRTIO_PCI, so on systems where the latter is true but not the
former you get a virtio-crypto-pci device that crashes when instantiated.

The fix should be
--- a/hw/virtio/Makefile.objs
+++ b/hw/virtio/Makefile.objs
@@ -8,7 +8,7 @@ obj-y += virtio.o virtio-balloon.o
 obj-$(CONFIG_LINUX) += vhost.o vhost-backend.o vhost-user.o
 obj-$(CONFIG_VHOST_VSOCK) += vhost-vsock.o
 obj-$(CONFIG_LINUX) += virtio-crypto.o
-obj-$(CONFIG_VIRTIO_PCI) += virtio-crypto-pci.o
+obj-$(call land,$(CONFIG_LINUX),$(CONFIG_VIRTIO_PCI)) += virtio-crypto-pci.o
 endif

 common-obj-$(call lnot,$(CONFIG_LINUX)) += vhost-stub.o


thanks
-- PMM
