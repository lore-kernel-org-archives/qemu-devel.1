Received: from eggs.gnu.org ([2001:4830:134:3::10]:43074)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <barbos@gmail.com>) id 1cQSTd-0007nU-G8
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 00:26:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <barbos@gmail.com>) id 1cQSTc-0003lf-Bu
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 00:26:37 -0500
Received: from mail-ua0-x241.google.com ([2607:f8b0:400c:c08::241]:35863)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <barbos@gmail.com>) id 1cQSTc-0003ky-6b
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 00:26:36 -0500
Received: by mail-ua0-x241.google.com with SMTP id f2so6729898uaf.3
	for <qemu-devel@nongnu.org>; Sun, 08 Jan 2017 21:26:34 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <0bfb55a2-08a0-2264-c2cd-ce566d08b0f4@redhat.com>
References: <CALoWxX_-+dBexpVzy2MKVN10b94vaZC50y+vxbZtqXi+S_Urmg@mail.gmail.com>
	<0bfb55a2-08a0-2264-c2cd-ce566d08b0f4@redhat.com>
From: Alex Kompel <barbos@gmail.com>
Date: Sun, 8 Jan 2017 21:26:33 -0800
Message-ID: <CALoWxX8OM3SurQWzGAgVfUzjydHm9OkFZGytstuBk0n0R=KgaA@mail.gmail.com>
Content-Type: multipart/mixed; boundary=94eb2c040a88607a0d0545a29cc9
Subject: Re: [Qemu-devel] [PATCH] hw/pci: use-after-free in
 pci_nic_init_nofail when nic device fails to initialize
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jason Wang <jasowang@redhat.com>
Cc: qemu-devel@nongnu.org, Marcel Apfelbaum <marcel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>

--94eb2c040a88607a0d0545a29cc9
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Looks like this line got wrapped: "@@ -1805,13 +1805,7 @@ PCIDevice
*pci_nic_init_nofail(NICInfo *nd, PCIBus *rootbus,"
Sorry about that. Could you unwrap it or use the attached text file?

Thanks,
-Alex

On Sun, Jan 8, 2017 at 8:06 PM, Jason Wang <jasowang@redhat.com> wrote:
>
>
> On 2017=E5=B9=B401=E6=9C=8807=E6=97=A5 07:48, Alex Kompel wrote:
>>
>> object_property_set_bool(OBJECT(dev), true, "realized", &err) in
>> pci_nic_init_nofail may release the object if device fails to
>> initialize which leads to use-after-free in error handling block.
>> qdev_init_nofail does the same thing while holding the reference.
>>
>> (gdb) run -net nic
>> qemu-system-x86_64: failed to find romfile "efi-e1000.rom"
>>
>> Program received signal SIGSEGV, Segmentation fault.
>> object_unparent (obj=3D0x7fffe96a0010) at qom/object.c:440
>> 440     in qom/object.c
>> (gdb) bt
>> #0  object_unparent (obj=3D0x7fffe96a0010) at qom/object.c:440
>> #1  0x000055555598c30d in pci_nic_init_nofail (nd=3D0x55555616b460
>> <nd_table>, rootbus=3D0x5555567ed990, default_model=3D<optimized out>,
>> default_devaddr=3D<optimized out>) at hw/pci/pci.c:1812
>> #2  0x00005555557ff52c in pc_nic_init (isa_bus=3D0x55555733c610,
>> pci_bus=3D0x5555567ed990) at hw/i386/pc.c:1634
>> #3  0x00005555558021ad in pc_init1 (machine=3D0x55555661ee10,
>> pci_type=3D0x555555c1a523 "i440FX", host_type=3D0x555555ba564e
>> "i440FX-pcihost") at hw/i386/pc_piix.c:241
>> #4  0x00005555557519cb in main (argc=3D<optimized out>, argv=3D<optimize=
d
>> out>, envp=3D<optimized out>) at vl.c:4481
>>
>> Signed-off-by: Alex Kompel <barbos@gmail.com>
>> ---
>>   hw/pci/pci.c | 8 +-------
>>   1 file changed, 1 insertion(+), 7 deletions(-)
>>
>> diff --git a/hw/pci/pci.c b/hw/pci/pci.c
>> index 24fae16..2fd1b9e 100644
>> --- a/hw/pci/pci.c
>> +++ b/hw/pci/pci.c
>> @@ -1805,13 +1805,7 @@ PCIDevice *pci_nic_init_nofail(NICInfo *nd,
>> PCIBus *rootbus,
>
>
> Hello, looks like the patch were corrupted possibly by your email client.
> Please check, we usually send patch through git send-email.
>
> Thanks
>
>
>>       pci_dev =3D pci_create(bus, devfn, pci_nic_names[i]);
>>       dev =3D &pci_dev->qdev;
>>       qdev_set_nic_properties(dev, nd);
>> -
>> -    object_property_set_bool(OBJECT(dev), true, "realized", &err);
>> -    if (err) {
>> -        error_report_err(err);
>> -        object_unparent(OBJECT(dev));
>> -        exit(1);
>> -    }
>> +    qdev_init_nofail(dev);
>>
>>       return pci_dev;
>>   }
>> --
>> 2.8.3
>>
>

--94eb2c040a88607a0d0545a29cc9
Content-Type: text/plain; charset=US-ASCII; name="qemu_pci_nic_init_nofail.txt"
Content-Disposition: attachment; filename="qemu_pci_nic_init_nofail.txt"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_ixpn9e8u0

U2lnbmVkLW9mZi1ieTogQWxleCBLb21wZWwgPGJhcmJvc0BnbWFpbC5jb20+Ci0tLQogaHcvcGNp
L3BjaS5jIHwgOCArLS0tLS0tLQogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCA3IGRl
bGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2h3L3BjaS9wY2kuYyBiL2h3L3BjaS9wY2kuYwppbmRl
eCAyNGZhZTE2Li4yZmQxYjllIDEwMDY0NAotLS0gYS9ody9wY2kvcGNpLmMKKysrIGIvaHcvcGNp
L3BjaS5jCkBAIC0xODA1LDEzICsxODA1LDcgQEAgUENJRGV2aWNlICpwY2lfbmljX2luaXRfbm9m
YWlsKE5JQ0luZm8gKm5kLCBQQ0lCdXMgKnJvb3RidXMsCiAgICAgcGNpX2RldiA9IHBjaV9jcmVh
dGUoYnVzLCBkZXZmbiwgcGNpX25pY19uYW1lc1tpXSk7CiAgICAgZGV2ID0gJnBjaV9kZXYtPnFk
ZXY7CiAgICAgcWRldl9zZXRfbmljX3Byb3BlcnRpZXMoZGV2LCBuZCk7Ci0KLSAgICBvYmplY3Rf
cHJvcGVydHlfc2V0X2Jvb2woT0JKRUNUKGRldiksIHRydWUsICJyZWFsaXplZCIsICZlcnIpOwot
ICAgIGlmIChlcnIpIHsKLSAgICAgICAgZXJyb3JfcmVwb3J0X2VycihlcnIpOwotICAgICAgICBv
YmplY3RfdW5wYXJlbnQoT0JKRUNUKGRldikpOwotICAgICAgICBleGl0KDEpOwotICAgIH0KKyAg
ICBxZGV2X2luaXRfbm9mYWlsKGRldik7CiAKICAgICByZXR1cm4gcGNpX2RldjsKIH0KLS0gCjIu
OC4zCgo=
--94eb2c040a88607a0d0545a29cc9--
