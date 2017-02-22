Received: from eggs.gnu.org ([2001:4830:134:3::10]:45387)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cgUYa-00069c-Vk
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 05:54:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cgUYW-00062k-45
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 05:54:01 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36592)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1cgUYV-00062a-Rs
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 05:53:56 -0500
References: <1487659615-15820-1-git-send-email-xyjxie@linux.vnet.ibm.com>
	<20170221092137.5b6cecbb@t450s.home>
	<27972408-a43b-60f9-86ad-e4e47f4f8f14@redhat.com>
	<CAFEAcA-L-ofsPmyOMhnAxUnkhHy0Zs1j2uCbUVRHV6a+WG0Thw@mail.gmail.com>
	<20170221114435.2025350d@t450s.home>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <9e7adeae-1360-82e4-8c98-86e70efc3881@redhat.com>
Date: Wed, 22 Feb 2017 11:53:52 +0100
MIME-Version: 1.0
In-Reply-To: <20170221114435.2025350d@t450s.home>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] memory: make ram device read/write endian
 sensitive
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex Williamson <alex.williamson@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: Yongji Xie <xyjxie@linux.vnet.ibm.com>, Alexey Kardashevskiy <aik@ozlabs.ru>, QEMU Developers <qemu-devel@nongnu.org>, zhong@linux.vnet.ibm.com



On 21/02/2017 19:44, Alex Williamson wrote:
>>> In other words, would Yongji's patch just work if it used
>>> DEVICE_BIG_ENDIAN and beNN_to_cpu/cpu_to_beNN?  If so, then I think t=
he
>>> patch is okay. =20
>
> The part where I get lost is that if PPC64 always sets the target
> to big endian, then adjust_endianness() we will always bswap after a
> read and before a write.  I don't follow how that bswap necessarily
> gets us to QEMU CPU endian such that the cpu_to_leXX/leXX_to_cpu in the
> access functions always do the right thing.  I know we do this
> elsewhere in vfio, perhaps I've deferred to someone convincing me it
> was the right thing at the time, but I'm not able to derive it myself
> currently.
>=20
> To answer Paolo's question, if PPC64 sets TARGET_WORDS_BIGENDIAN, which
> is a compile time setting, then using DEVICE_BIG_ENDIAN would
> deterministically remove the bswap from adjust_endianness(),=20

And beNN_to_cpu/cpu_to_beNN would add a swap in=20
memory_region_ram_device_read/write, so it would work just as well.

KVM expects data in host endianness:

static inline bool kvmppc_need_byteswap(struct kvm_vcpu *vcpu)
{
        return (kvmppc_get_msr(vcpu) & MSR_LE) !=3D (MSR_KERNEL & MSR_LE)=
;
                ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^      ^^^^^^^^^^^^^^^^^^^
                 endianness of the target              endianness of
                                                      struct kvm_run
}

while QEMU hardcodes bigendian for DEVICE_NATIVE_ENDIAN, even if=20
running on PPC64LE host.

However, I'm confused as to what would happen with TCG. :(  The best=20
thing to do, IMO, is to add a RAM device MR to pc-testdev (e.g. at 0xec)

diff --git a/hw/misc/pc-testdev.c b/hw/misc/pc-testdev.c
index b81d820..5ea444f 100644
--- a/hw/misc/pc-testdev.c
+++ b/hw/misc/pc-testdev.c
@@ -47,11 +47,13 @@ typedef struct PCTestdev {
=20
     MemoryRegion ioport;
     MemoryRegion ioport_byte;
+    MemoryRegion ioport_ramd;
     MemoryRegion flush;
     MemoryRegion irq;
     MemoryRegion iomem;
     uint32_t ioport_data;
     char iomem_buf[IOMEM_LEN];
+    char ioport_ramd_bytes[4];
 } PCTestdev;
=20
 #define TYPE_TESTDEV "pc-testdev"
@@ -167,6 +169,10 @@ static void testdev_realizefn(DeviceState *d, Error =
**errp)
     memory_region_init_io(&dev->ioport_byte, OBJECT(dev),
                           &test_ioport_byte_ops, dev,
                           "pc-testdev-ioport-byte", 4);
+    memory_region_init_ram_device_ptr(&dev->ioport_ramd, OBJECT(dev),
+                                      "pc-testdev-ioport-ramd",
+                                      ARRAY_SIZE(dev->ioport_ramd_bytes)=
,
+                                      &dev->ioport_ramd_bytes);
     memory_region_init_io(&dev->flush, OBJECT(dev), &test_flush_ops, dev=
,
                           "pc-testdev-flush-page", 4);
     memory_region_init_io(&dev->irq, OBJECT(dev), &test_irq_ops, dev,
@@ -177,6 +183,7 @@ static void testdev_realizefn(DeviceState *d, Error *=
*errp)
     memory_region_add_subregion(io,  0xe0,       &dev->ioport);
     memory_region_add_subregion(io,  0xe4,       &dev->flush);
     memory_region_add_subregion(io,  0xe8,       &dev->ioport_byte);
+    memory_region_add_subregion(io,  0xec,       &dev->ioport_ramd);
     memory_region_add_subregion(io,  0x2000,     &dev->irq);
     memory_region_add_subregion(mem, 0xff000000, &dev->iomem);
 }

and a testcase to tests/endianness-test.c.

Paolo
