Received: from eggs.gnu.org ([2001:4830:134:3::10]:57508)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1cQRCh-00061x-FV
	for qemu-devel@nongnu.org; Sun, 08 Jan 2017 23:05:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1cQRCe-0002SV-VO
	for qemu-devel@nongnu.org; Sun, 08 Jan 2017 23:05:03 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50444)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1cQRCe-0002SJ-Q3
	for qemu-devel@nongnu.org; Sun, 08 Jan 2017 23:05:00 -0500
References: <CALoWxX_-+dBexpVzy2MKVN10b94vaZC50y+vxbZtqXi+S_Urmg@mail.gmail.com>
	<20170108055940-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <8c2e2a9c-b675-f229-ec55-59fcd4132188@redhat.com>
Date: Mon, 9 Jan 2017 12:04:52 +0800
MIME-Version: 1.0
In-Reply-To: <20170108055940-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
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
To: "Michael S. Tsirkin" <mst@redhat.com>, Alex Kompel <barbos@gmail.com>
Cc: qemu-devel@nongnu.org, Marcel Apfelbaum <marcel@redhat.com>



On 2017=E5=B9=B401=E6=9C=8808=E6=97=A5 12:00, Michael S. Tsirkin wrote:
> On Fri, Jan 06, 2017 at 03:48:27PM -0800, Alex Kompel wrote:
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
>> #4  0x00005555557519cb in main (argc=3D<optimized out>, argv=3D<optimi=
zed
>> out>, envp=3D<optimized out>) at vl.c:4481
>>
>> Signed-off-by: Alex Kompel <barbos@gmail.com>
> More a nic thing than pci really ...
>
> Jason, could you pls merge this?
>
> Acked-by: Michael S. Tsirkin <mst@redhat.com>
>

Ok, will pick.

Thanks
