Received: from eggs.gnu.org ([2001:4830:134:3::10]:45180)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gWBD8-0005lU-Ua
	for qemu-devel@nongnu.org; Sun, 09 Dec 2018 21:22:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gWBD5-0008O4-7d
	for qemu-devel@nongnu.org; Sun, 09 Dec 2018 21:22:18 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49984)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1gWBD4-0008NA-Uk
	for qemu-devel@nongnu.org; Sun, 09 Dec 2018 21:22:15 -0500
Date: Sun, 9 Dec 2018 21:22:08 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20181209211730-mutt-send-email-mst@kernel.org>
References: <7CECC2DFC21538489F72729DF5EFB4D908ABD3A4@dggemm521-mbs.china.huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7CECC2DFC21538489F72729DF5EFB4D908ABD3A4@dggemm521-mbs.china.huawei.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [BUG]Unassigned mem write during pci device
 hot-plug
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: xuyandong <xuyandong2@huawei.com>
Cc: "marcel@redhat.com" <marcel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Zhanghailiang <zhang.zhanghailiang@huawei.com>, "wangxin (U)" <wangxinxin.wang@huawei.com>, "Huangweidong (C)" <weidong.huang@huawei.com>

On Sat, Dec 08, 2018 at 11:58:59AM +0000, xuyandong wrote:
> Hi all,
>=20
> =20
>=20
> In our test, we configured VM with several pci-bridges and a virtio-net=
 nic
> been attached with bus 4,
>=20
> After VM is startup, We ping this nic from host to judge if it is worki=
ng
> normally. Then, we hot add pci devices to this VM with bus 0.
>=20
> We  found the virtio-net NIC in bus 4 is not working (can not connect)
> occasionally, as it kick virtio backend failure with error below:
>=20
>     Unassigned mem write 00000000fc803004 =3D 0x1
>=20
> =20
>=20
> memory-region: pci_bridge_pci
>=20
>   0000000000000000-ffffffffffffffff (prio 0, RW): pci_bridge_pci
>=20
>     00000000fc800000-00000000fc803fff (prio 1, RW): virtio-pci
>=20
>       00000000fc800000-00000000fc800fff (prio 0, RW): virtio-pci-common
>=20
>       00000000fc801000-00000000fc801fff (prio 0, RW): virtio-pci-isr
>=20
>       00000000fc802000-00000000fc802fff (prio 0, RW): virtio-pci-device
>=20
>       00000000fc803000-00000000fc803fff (prio 0, RW): virtio-pci-notify=
  <- io
> mem unassigned
>=20
>       =E2=80=A6
>=20
> =20
>=20
> We caught an exceptional address changing while this problem happened, =
show as
> follow:
>=20
> Before pci_bridge_update_mappings=EF=BC=9A
>=20
>       00000000fc000000-00000000fc1fffff (prio 1, RW): alias pci_bridge_=
pref_mem
> @pci_bridge_pci 00000000fc000000-00000000fc1fffff
>=20
>       00000000fc200000-00000000fc3fffff (prio 1, RW): alias pci_bridge_=
pref_mem
> @pci_bridge_pci 00000000fc200000-00000000fc3fffff
>=20
>       00000000fc400000-00000000fc5fffff (prio 1, RW): alias pci_bridge_=
pref_mem
> @pci_bridge_pci 00000000fc400000-00000000fc5fffff
>=20
>       00000000fc600000-00000000fc7fffff (prio 1, RW): alias pci_bridge_=
pref_mem
> @pci_bridge_pci 00000000fc600000-00000000fc7fffff
>=20
>       00000000fc800000-00000000fc9fffff (prio 1, RW): alias pci_bridge_=
pref_mem
> @pci_bridge_pci 00000000fc800000-00000000fc9fffff <- correct Adress Spc=
e
>=20
>       00000000fca00000-00000000fcbfffff (prio 1, RW): alias pci_bridge_=
pref_mem
> @pci_bridge_pci 00000000fca00000-00000000fcbfffff
>=20
>       00000000fcc00000-00000000fcdfffff (prio 1, RW): alias pci_bridge_=
pref_mem
> @pci_bridge_pci 00000000fcc00000-00000000fcdfffff
>=20
>       00000000fce00000-00000000fcffffff (prio 1, RW): alias pci_bridge_=
pref_mem
> @pci_bridge_pci 00000000fce00000-00000000fcffffff
>=20
> =20
>=20
> After pci_bridge_update_mappings=EF=BC=9A
>=20
>       00000000fda00000-00000000fdbfffff (prio 1, RW): alias pci_bridge_=
mem
> @pci_bridge_pci 00000000fda00000-00000000fdbfffff
>=20
>       00000000fdc00000-00000000fddfffff (prio 1, RW): alias pci_bridge_=
mem
> @pci_bridge_pci 00000000fdc00000-00000000fddfffff
>=20
>       00000000fde00000-00000000fdffffff (prio 1, RW): alias pci_bridge_=
mem
> @pci_bridge_pci 00000000fde00000-00000000fdffffff
>=20
>       00000000fe000000-00000000fe1fffff (prio 1, RW): alias pci_bridge_=
mem
> @pci_bridge_pci 00000000fe000000-00000000fe1fffff
>=20
>       00000000fe200000-00000000fe3fffff (prio 1, RW): alias pci_bridge_=
mem
> @pci_bridge_pci 00000000fe200000-00000000fe3fffff
>=20
>       00000000fe400000-00000000fe5fffff (prio 1, RW): alias pci_bridge_=
mem
> @pci_bridge_pci 00000000fe400000-00000000fe5fffff
>=20
>       00000000fe600000-00000000fe7fffff (prio 1, RW): alias pci_bridge_=
mem
> @pci_bridge_pci 00000000fe600000-00000000fe7fffff
>=20
>       00000000fe800000-00000000fe9fffff (prio 1, RW): alias pci_bridge_=
mem
> @pci_bridge_pci 00000000fe800000-00000000fe9fffff
>=20
>       fffffffffc800000-fffffffffc800000 (prio 1, RW): alias pci_bridge_=
pref_mem
> @pci_bridge_pci fffffffffc800000-fffffffffc800000   <- Exceptional Adre=
ss Space

This one is empty though right?

> =20
>=20
> We have figured out why this address becomes this value,  according to =
pci
> spec,  pci driver can get BAR address size by writing 0xffffffff to
>=20
> the pci register firstly, and then read back the value from this regist=
er.


OK however as you show below the BAR being sized is the BAR
if a bridge. Are you then adding a bridge device by hotplug?



> We didn't handle this value  specially while process pci write in qemu,=
 the
> function call stack is:
>=20
> Pci_bridge_dev_write_config
>=20
> -> pci_bridge_write_config
>=20
> -> pci_default_write_config (we update the config[address] value here t=
o
> fffffffffc800000, which should be 0xfc800000 )
>
> -> pci_bridge_update_mappings
>=20
>                 ->pci_bridge_region_del(br, br->windows);
>=20
> -> pci_bridge_region_init
>=20
>                                                                 ->
> pci_bridge_init_alias (here pci_bridge_get_base, we use the wrong value
> fffffffffc800000)
>=20
>                                                 ->
> memory_region_transaction_commit
>=20
> =20
>=20
> So, as we can see, we use the wrong base address in qemu to update the =
memory
> regions, though, we update the base address to
>=20
> The correct value after pci driver in VM write the original value back,=
 the
> virtio NIC in bus 4 may still sends net packets concurrently with
>=20
> The wrong memory region address.
>=20
> =20
>=20
> We have tried to skip the memory region update action in qemu while det=
ect pci
> write with 0xffffffff value, and it does work, but
>=20
> This seems to be not gently.

For sure. But I'm still puzzled as to why does Linux try to
size the BAR of the bridge while a device behind it is
used.

Can you pls post your QEMU command line?



> =20
>=20
> diff --git a/hw/pci/pci_bridge.c b/hw/pci/pci_bridge.c
>=20
> index b2e50c3..84b405d 100644
>=20
> --- a/hw/pci/pci_bridge.c
>=20
> +++ b/hw/pci/pci_bridge.c
>=20
> @@ -256,7 +256,8 @@ void pci_bridge_write_config(PCIDevice *d,
>=20
>      pci_default_write_config(d, address, val, len);
>=20
> -    if (ranges_overlap(address, len, PCI_COMMAND, 2) ||
>=20
> +    if ( (val !=3D 0xffffffff) &&
>=20
> +        (ranges_overlap(address, len, PCI_COMMAND, 2) ||
>=20
>          /* io base/limit */
>=20
>          ranges_overlap(address, len, PCI_IO_BASE, 2) ||
>=20
> @@ -266,7 +267,7 @@ void pci_bridge_write_config(PCIDevice *d,
>=20
>          ranges_overlap(address, len, PCI_MEMORY_BASE, 20) ||
>=20
>          /* vga enable */
>=20
> -        ranges_overlap(address, len, PCI_BRIDGE_CONTROL, 2)) {
>=20
> +        ranges_overlap(address, len, PCI_BRIDGE_CONTROL, 2))) {
>=20
>          pci_bridge_update_mappings(s);
>=20
>      }
>=20
> =20
>=20
> Thinks,
>=20
> Xu
>=20
