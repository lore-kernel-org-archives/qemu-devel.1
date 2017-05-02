Received: from eggs.gnu.org ([2001:4830:134:3::10]:50362)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1d5Ytj-0007kb-PL
	for qemu-devel@nongnu.org; Tue, 02 May 2017 10:35:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1d5Yte-0003Pm-NT
	for qemu-devel@nongnu.org; Tue, 02 May 2017 10:35:27 -0400
Received: from mail-wr0-x241.google.com ([2a00:1450:400c:c0c::241]:34792)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1d5Yte-0003Pg-CE
	for qemu-devel@nongnu.org; Tue, 02 May 2017 10:35:22 -0400
Received: by mail-wr0-x241.google.com with SMTP id 6so17908855wrb.1
	for <qemu-devel@nongnu.org>; Tue, 02 May 2017 07:35:22 -0700 (PDT)
Date: Tue, 2 May 2017 15:35:19 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170502143518.GK22502@stefanha-x1.localdomain>
References: <1493692691-30801-1-git-send-email-lu.zhipeng@zte.com.cn>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="x+RZeZVNR8VILNfK"
Content-Disposition: inline
In-Reply-To: <1493692691-30801-1-git-send-email-lu.zhipeng@zte.com.cn>
Subject: Re: [Qemu-devel] [PATCH] hmp: add 'info virtio-pci-status id'
 command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: ZhiPeng Lu <lu.zhipeng@zte.com.cn>
Cc: dgilbert@redhat.com, mst@redhat.com, marcel@redhat.com, qemu-devel@nongnu.org


--x+RZeZVNR8VILNfK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 02, 2017 at 10:38:11AM +0800, ZhiPeng Lu wrote:
> Add command to  query a virtio pci device status.
> we can get id of the virtio pci device by 'info pci' command.
> HMP Test case:
>     =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>     virsh # qemu-monitor-command --hmp 3 info pci
>       Bus  0, device   3, function 0:
>         Ethernet controller: PCI device 1af4:1000
>           IRQ 11.
>           BAR0: I/O at 0xc000 [0xc03f].
>           BAR1: 32 bit memory at 0xfebd1000 [0xfebd1fff].
>           BAR4: 64 bit prefetchable memory at 0xfe000000 [0xfe003fff].
>           BAR6: 32 bit memory at 0xffffffffffffffff [0x0003fffe].
>           id "net0"
>       Bus  0, device   4, function 0:
>         USB controller: PCI device 8086:24cd
>           IRQ 11.
>           BAR0: 32 bit memory at 0xfebd2000 [0xfebd2fff].
>           id "usb"
>     virsh # qemu-monitor-command 3  --hmp "info virtio-pci-status net0"
>     status=3D15
>=20
>     virsh # qemu-monitor-command 3  --hmp "info virtio-pci-status usb"
>     the 'info virtio_pci_status' command only supports virtio pci devices

This information can be useful for troubleshooting virtio devices, but
I'm concerned about adding new ad-hoc HMP commands.

Adding new commands for one specific field of device state lead to
inconsistent user interfaces.  It adds a maintenance burden because all
future versions of QEMU must continue to support this command for
compatibility.

QMP should also be supported by new commands unless there is a reason to
make the command HMP-only.

There is already a trace event called "virtio_set_status" so you can
observe status changes from the host without adding a new monitor
command.  Unfortunately tracing does not allow you to query the current
value so it might not be possible to trigger the trace event at the
appropriate time.

One option is to make the virtio status a QOM property so the existing
qom-get command can be used to fetch the value without adding a new
monitor command.

Does anyone have other ideas?

> Signed-off-by: ZhiPeng Lu <lu.zhipeng@zte.com.cn>
> ---
>  hmp-commands-info.hx    | 14 ++++++++++++++
>  hw/pci/pci-stub.c       |  6 ++++++
>  hw/virtio/virtio-pci.c  | 47 +++++++++++++++++++++++++++++++++++++++++++=
++++
>  include/sysemu/sysemu.h |  1 +
>  4 files changed, 68 insertions(+)
>=20
> diff --git a/hmp-commands-info.hx b/hmp-commands-info.hx
> index a53f105..7b9c4db 100644
> --- a/hmp-commands-info.hx
> +++ b/hmp-commands-info.hx
> @@ -815,6 +815,20 @@ ETEXI
>          .cmd =3D hmp_info_vm_generation_id,
>      },
> =20
> +    {
> +        .name       =3D "virtio-pci-status",
> +        .args_type  =3D "id:s",
> +        .params     =3D "id",
> +        .help       =3D "show virtio pci device  status",
> +        .cmd        =3D hmp_info_virtio_pci_status,
> +    },
> +
> +STEXI
> +@item info virtio-pci-status  @var{id}
> +@findex virtio-pci-status
> +Show status about virtio pci device
> +ETEXI
> +
>  STEXI
>  @end table
>  ETEXI
> diff --git a/hw/pci/pci-stub.c b/hw/pci/pci-stub.c
> index 36d2c43..3609a52 100644
> --- a/hw/pci/pci-stub.c
> +++ b/hw/pci/pci-stub.c
> @@ -35,3 +35,9 @@ void hmp_pcie_aer_inject_error(Monitor *mon, const QDic=
t *qdict)
>  {
>      monitor_printf(mon, "PCI devices not supported\n");
>  }
> +
> +void hmp_info_virtio_pci_status(Monitor *mon, const QDict *qdict)
> +{
> +    monitor_printf(mon, "PCI devices not supported\n");
> +}
> +
> diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
> index f9b7244..5fa862b 100644
> --- a/hw/virtio/virtio-pci.c
> +++ b/hw/virtio/virtio-pci.c
> @@ -37,6 +37,7 @@
>  #include "qemu/range.h"
>  #include "hw/virtio/virtio-bus.h"
>  #include "qapi/visitor.h"
> +#include "monitor/monitor.h"
> =20
>  #define VIRTIO_PCI_REGION_SIZE(dev)     VIRTIO_PCI_CONFIG_OFF(msix_prese=
nt(dev))
> =20
> @@ -50,6 +51,7 @@ static void virtio_pci_bus_new(VirtioBusState *bus, siz=
e_t bus_size,
>                                 VirtIOPCIProxy *dev);
>  static void virtio_pci_reset(DeviceState *qdev);
> =20
> +static void query_virtio_pci_status(Monitor *mon, const char *id);
>  /* virtio device */
>  /* DeviceState to VirtIOPCIProxy. For use off data-path. TODO: use QOM. =
*/
>  static inline VirtIOPCIProxy *to_virtio_pci_proxy(DeviceState *d)
> @@ -2556,6 +2558,51 @@ static void virtio_pci_bus_new(VirtioBusState *bus=
, size_t bus_size,
>                          virtio_bus_name);
>  }
> =20
> +static void query_virtio_pci_status(Monitor *mon, const char *id)
> +{
> +    int ret =3D 0, i =3D 0;
> +    PCIDevice *dev =3D NULL;
> +    hwaddr addr =3D 0;
> +    uint8_t val =3D 0;
> +    const char *devtype =3D NULL;
> +
> +    ret =3D pci_qdev_find_device(id, &dev);
> +    if (ret) {
> +        monitor_printf(mon, "Can not find device %s\n", id);
> +        return;
> +    }
> +    devtype =3D object_get_typename(OBJECT(dev));
> +    if (strncmp("virtio-", devtype, 7) =3D=3D 0) {
> +        for (i =3D 0; i < PCI_NUM_REGIONS; i++) {
> +            if (dev->io_regions[i].type =3D=3D PCI_BASE_ADDRESS_SPACE_IO=
) {
> +                addr =3D dev->io_regions[i].addr;
> +                break;
> +            }
> +        }
> +        if (addr !=3D -1 && addr !=3D 0) {
> +            address_space_rw(&address_space_io, addr + VIRTIO_PCI_STATUS,
> +            MEMTXATTRS_UNSPECIFIED, &val, 1, 0);
> +            if (val & VIRTIO_CONFIG_S_DRIVER_OK) {
> +                fprintf(stderr, "driver is ok\n");
> +            } else {
> +                fprintf(stderr, "driver is not ok\n");
> +            }
> +            monitor_printf(mon, "status=3D%d", val);
> +        } else {
> +            monitor_printf(mon, "status=3D%d", val);
> +        }
> +    } else {
> +        monitor_printf(mon, "the 'info virtio_pci_status' command "
> +           "only supports virtio pci devices");
> +    }
> +}
> +
> +void hmp_info_virtio_pci_status(Monitor *mon, const QDict *qdict)
> +{
> +    const char *id =3D qdict_get_try_str(qdict, "id");
> +    query_virtio_pci_status(mon, id);
> +}
> +
>  static void virtio_pci_bus_class_init(ObjectClass *klass, void *data)
>  {
>      BusClass *bus_class =3D BUS_CLASS(klass);
> diff --git a/include/sysemu/sysemu.h b/include/sysemu/sysemu.h
> index 576c7ce..de66cc0 100644
> --- a/include/sysemu/sysemu.h
> +++ b/include/sysemu/sysemu.h
> @@ -238,4 +238,5 @@ extern QemuOptsList qemu_net_opts;
>  extern QemuOptsList qemu_global_opts;
>  extern QemuOptsList qemu_mon_opts;
> =20
> +extern void hmp_info_virtio_pci_status(Monitor *mon, const QDict *qdict);
>  #endif
> --=20
> 1.8.3.1
>=20
>=20
>=20

--x+RZeZVNR8VILNfK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZCJkmAAoJEJykq7OBq3PI0NIIALMcX2diGlg6ArhwoqmUqiSq
AX2ZD+wgMdOcZd5DNrV/hCKwvtR1Vx8IE872+Va+niSOup2P6JXHclWPnQUwEwy2
HJOQJcXMG1Vm48XJY7WLyb6kIzcKdEla+SpeELJHWouTYmgkpM7FT2mEjNluFLvQ
kpFqqF5aUQb6VRzYF6mHXbf1lmXAsGC7u4K6rBuDPcqeaSfuzRImP5UlumYgvGWJ
seyvYBj1jDsFquNszgsleoe+vJrUrb69INJeG9CP2H/03Ie5Jq9apYCyuRdlTJ1F
XvFmV1L0g6bROcwI+lT7lPYKBGPMRHi6ttasIzOJQinXPHdpuFYSFAL6cqltoFc=
=lwBw
-----END PGP SIGNATURE-----

--x+RZeZVNR8VILNfK--
