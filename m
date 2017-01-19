Received: from eggs.gnu.org ([2001:4830:134:3::10]:36443)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1cU8hd-0003sD-Qm
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 04:08:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1cU8hb-00014G-Nw
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 04:08:17 -0500
Received: from mail-yw0-x242.google.com ([2607:f8b0:4002:c05::242]:33150)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1cU8hb-00013z-Hi
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 04:08:15 -0500
Received: by mail-yw0-x242.google.com with SMTP id u68so3285354ywg.0
	for <qemu-devel@nongnu.org>; Thu, 19 Jan 2017 01:08:15 -0800 (PST)
MIME-Version: 1.0
References: <20170118161653.19296-1-eblake@redhat.com>
	<20170118161653.19296-2-eblake@redhat.com>
In-Reply-To: <20170118161653.19296-2-eblake@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Thu, 19 Jan 2017 09:08:04 +0000
Message-ID: <CAJ+F1C+R1G2UijUGkpo35jBchCoR6tQLqfPbm4n7svCayLKy=A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 1/6] pci: Use struct instead of QDict to
 pass back parameters
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: Marcel Apfelbaum <marcel@redhat.com>, armbru@redhat.com, "Michael S. Tsirkin" <mst@redhat.com>

On Wed, Jan 18, 2017 at 8:58 PM Eric Blake <eblake@redhat.com> wrote:

> It's simpler to just use a C struct than it is to bundle things
> into a QDict in one function just to pull them back out in the
> caller.  Plus, doing this gets rid of one more user of dynamic
> JSON through qobject_from_jsonf().
>

and it looks like it removes a leak

>
> Signed-off-by: Eric Blake <eblake@redhat.com>
> Acked-by: Michael S. Tsirkin <mst@redhat.com>
>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


> ---
>  hw/pci/pcie_aer.c | 36 +++++++++++++++++-------------------
>  1 file changed, 17 insertions(+), 19 deletions(-)
>
> diff --git a/hw/pci/pcie_aer.c b/hw/pci/pcie_aer.c
> index daf1f65..78fd2c3 100644
> --- a/hw/pci/pcie_aer.c
> +++ b/hw/pci/pcie_aer.c
> @@ -44,6 +44,13 @@
>  #define PCI_ERR_SRC_COR_OFFS    0
>  #define PCI_ERR_SRC_UNCOR_OFFS  2
>
> +typedef struct PCIEErrorInject {
> +    const char *id;
> +    const char *root_bus;
> +    int bus;
> +    int devfn;
> +} PCIEErrorInject;
> +
>  /* From 6.2.7 Error Listing and Rules. Table 6-2, 6-3 and 6-4 */
>  static uint32_t pcie_aer_uncor_default_severity(uint32_t status)
>  {
> @@ -943,7 +950,8 @@ static int pcie_aer_parse_error_string(const char
> *error_name,
>  }
>
>  static int do_pcie_aer_inject_error(Monitor *mon,
> -                                    const QDict *qdict, QObject
> **ret_data)
> +                                    const QDict *qdict,
> +                                    PCIEErrorInject *ret_data)
>  {
>      const char *id =3D qdict_get_str(qdict, "id");
>      const char *error_name;
> @@ -1004,34 +1012,24 @@ static int do_pcie_aer_inject_error(Monitor *mon,
>      err.prefix[2] =3D qdict_get_try_int(qdict, "prefix2", 0);
>      err.prefix[3] =3D qdict_get_try_int(qdict, "prefix3", 0);
>
> -    ret =3D pcie_aer_inject_error(dev, &err);
> -    *ret_data =3D qobject_from_jsonf("{'id': %s, "
> -                                   "'root_bus': %s, 'bus': %d, 'devfn':
> %d, "
> -                                   "'ret': %d}",
> -                                   id, pci_root_bus_path(dev),
> -                                   pci_bus_num(dev->bus), dev->devfn,
> -                                   ret);
> -    assert(*ret_data);
> +    pcie_aer_inject_error(dev, &err);
> +    ret_data->id =3D id;
> +    ret_data->root_bus =3D pci_root_bus_path(dev);
> +    ret_data->bus =3D pci_bus_num(dev->bus);
> +    ret_data->devfn =3D dev->devfn;
>
>      return 0;
>  }
>
>  void hmp_pcie_aer_inject_error(Monitor *mon, const QDict *qdict)
>  {
> -    QObject *data;
> -    int devfn;
> +    PCIEErrorInject data;
>
>      if (do_pcie_aer_inject_error(mon, qdict, &data) < 0) {
>          return;
>      }
>
> -    assert(qobject_type(data) =3D=3D QTYPE_QDICT);
> -    qdict =3D qobject_to_qdict(data);
> -
> -    devfn =3D (int)qdict_get_int(qdict, "devfn");
>      monitor_printf(mon, "OK id: %s root bus: %s, bus: %x devfn: %x.%x\n"=
,
> -                   qdict_get_str(qdict, "id"),
> -                   qdict_get_str(qdict, "root_bus"),
> -                   (int) qdict_get_int(qdict, "bus"),
> -                   PCI_SLOT(devfn), PCI_FUNC(devfn));
> +                   data.id, data.root_bus, data.bus,
> +                   PCI_SLOT(data.devfn), PCI_FUNC(data.devfn));
>  }
> --
> 2.9.3
>
>
> --
Marc-Andr=C3=A9 Lureau
