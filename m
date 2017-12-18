Received: from eggs.gnu.org ([2001:4830:134:3::10]:48150)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1eQxY1-0001EM-MD
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 10:41:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1eQxY0-0000dB-I4
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 10:41:45 -0500
References: <20171218151244.9975-1-f4bug@amsat.org>
	<20171218151244.9975-3-f4bug@amsat.org>
From: Marcel Apfelbaum <marcel@redhat.com>
Message-ID: <96cb2464-97e0-56ae-d732-eb63d21cad8f@redhat.com>
Date: Mon, 18 Dec 2017 17:41:30 +0200
MIME-Version: 1.0
In-Reply-To: <20171218151244.9975-3-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 2/4] hw/pci-host/piix: QOM'ify the IGD
 Passthrough host bridge
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, "Michael S. Tsirkin" <mst@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org

On 18/12/2017 17:12, Philippe Mathieu-Daud=C3=A9 wrote:
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
> v2: use g_strdup_printf(), use 'pci_dev' variable.
>=20
>   hw/pci-host/piix.c | 45 ++++++++++++++++++++-------------------------
>   1 file changed, 20 insertions(+), 25 deletions(-)
>=20
> diff --git a/hw/pci-host/piix.c b/hw/pci-host/piix.c
> index a684a7cca9..bb6560f815 100644
> --- a/hw/pci-host/piix.c
> +++ b/hw/pci-host/piix.c
> @@ -804,60 +804,55 @@ static const IGDHostInfo igd_host_bridge_infos[] =
=3D {
>       {0xa8, 4},  /* SNB: base of GTT stolen memory */
>   };
>  =20
> -static int host_pci_config_read(int pos, int len, uint32_t *val)
> +static void host_pci_config_read(int pos, int len, uint32_t *val, Erro=
r **errp)
>   {
> -    char path[PATH_MAX];
> -    int config_fd;
> -    ssize_t size =3D sizeof(path);
> +    int rc, config_fd;
>       /* Access real host bridge. */
> -    int rc =3D snprintf(path, size, "/sys/bus/pci/devices/%04x:%02x:%0=
2x.%d/%s",
> -                      0, 0, 0, 0, "config");
> -    int ret =3D 0;
> -
> -    if (rc >=3D size || rc < 0) {
> -        return -ENODEV;
> -    }
> +    char *path =3D g_strdup_printf("/sys/bus/pci/devices/%04x:%02x:%02=
x.%d/%s",
> +                                 0, 0, 0, 0, "config");
>  =20
>       config_fd =3D open(path, O_RDWR);
>       if (config_fd < 0) {
> -        return -ENODEV;
> +        error_setg_errno(errp, errno, "Failed to open: %s", path);
> +        goto out;
>       }
>  =20
>       if (lseek(config_fd, pos, SEEK_SET) !=3D pos) {
> -        ret =3D -errno;
> -        goto out;
> +        error_setg_errno(errp, errno, "Failed to seek: %s", path);
> +        goto out_close_fd;
>       }
>  =20
>       do {
>           rc =3D read(config_fd, (uint8_t *)val, len);
>       } while (rc < 0 && (errno =3D=3D EINTR || errno =3D=3D EAGAIN));
>       if (rc !=3D len) {
> -        ret =3D -errno;
> +        error_setg_errno(errp, errno, "Failed to read: %s", path);
>       }
>  =20
> -out:
> +out_close_fd:
>       close(config_fd);
> -    return ret;
> +out:
> +    g_free(path);
>   }
>  =20
> -static int igd_pt_i440fx_initfn(struct PCIDevice *pci_dev)
> +static void igd_pt_i440fx_realize(PCIDevice *pci_dev, Error **errp)
>   {
>       uint32_t val =3D 0;
> -    int rc, i, num;
> +    int i, num;
>       int pos, len;
> +    Error *local_err =3D NULL;
>  =20
>       num =3D ARRAY_SIZE(igd_host_bridge_infos);
>       for (i =3D 0; i < num; i++) {
>           pos =3D igd_host_bridge_infos[i].offset;
>           len =3D igd_host_bridge_infos[i].len;
> -        rc =3D host_pci_config_read(pos, len, &val);
> -        if (rc) {
> -            return -ENODEV;
> +        host_pci_config_read(pos, len, &val, &local_err);
> +        if (local_err) {
> +            error_propagate(errp, local_err);
> +            return;
>           }
>           pci_default_write_config(pci_dev, pos, val, len);
>       }
> -
> -    return 0;
>   }
>  =20
>   static void igd_passthrough_i440fx_class_init(ObjectClass *klass, voi=
d *data)
> @@ -865,7 +860,7 @@ static void igd_passthrough_i440fx_class_init(Objec=
tClass *klass, void *data)
>       DeviceClass *dc =3D DEVICE_CLASS(klass);
>       PCIDeviceClass *k =3D PCI_DEVICE_CLASS(klass);
>  =20
> -    k->init =3D igd_pt_i440fx_initfn;
> +    k->realize =3D igd_pt_i440fx_realize;
>       dc->desc =3D "IGD Passthrough Host bridge";
>   }
>    >

Reviewed-by: Marcel Apfelbaum <marcel@redhat.com>

Thanks,
Marcel
