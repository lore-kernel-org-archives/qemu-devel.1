Received: from eggs.gnu.org ([2001:4830:134:3::10]:39182)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cU8wa-0005CZ-0J
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 04:23:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cU8wV-00073L-WC
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 04:23:44 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38044)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1cU8wV-00072w-Nm
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 04:23:39 -0500
Received: from smtp.corp.redhat.com (int-mx16.intmail.prod.int.phx2.redhat.com
	[10.5.11.28])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B282B76EF
	for <qemu-devel@nongnu.org>; Thu, 19 Jan 2017 09:23:39 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20170118161653.19296-1-eblake@redhat.com>
	<20170118161653.19296-2-eblake@redhat.com>
Date: Thu, 19 Jan 2017 10:23:36 +0100
In-Reply-To: <20170118161653.19296-2-eblake@redhat.com> (Eric Blake's message
	of "Wed, 18 Jan 2017 10:16:48 -0600")
Message-ID: <87pojjflnr.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
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
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, Marcel Apfelbaum <marcel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>

Eric Blake <eblake@redhat.com> writes:

> It's simpler to just use a C struct than it is to bundle things
> into a QDict in one function just to pull them back out in the
> caller.  Plus, doing this gets rid of one more user of dynamic
> JSON through qobject_from_jsonf().
>
> Signed-off-by: Eric Blake <eblake@redhat.com>
> Acked-by: Michael S. Tsirkin <mst@redhat.com>
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

Aside: both pcie_aer_inject_error() and pcie_aer_msg() could be made
static.

> @@ -943,7 +950,8 @@ static int pcie_aer_parse_error_string(const char *error_name,
>  }
>
>  static int do_pcie_aer_inject_error(Monitor *mon,
> -                                    const QDict *qdict, QObject **ret_data)
> +                                    const QDict *qdict,
> +                                    PCIEErrorInject *ret_data)

Your chance to pick a better name than @ret_data, if you like.

>  {
>      const char *id = qdict_get_str(qdict, "id");
>      const char *error_name;
> @@ -1004,34 +1012,24 @@ static int do_pcie_aer_inject_error(Monitor *mon,
>      err.prefix[2] = qdict_get_try_int(qdict, "prefix2", 0);
>      err.prefix[3] = qdict_get_try_int(qdict, "prefix3", 0);
>
> -    ret = pcie_aer_inject_error(dev, &err);
> -    *ret_data = qobject_from_jsonf("{'id': %s, "
> -                                   "'root_bus': %s, 'bus': %d, 'devfn': %d, "
> -                                   "'ret': %d}",
> -                                   id, pci_root_bus_path(dev),
> -                                   pci_bus_num(dev->bus), dev->devfn,
> -                                   ret);
> -    assert(*ret_data);
> +    pcie_aer_inject_error(dev, &err);

Ignores failure (assuming it can happen here).

Turns out this is no change: before, we passed the return code to the
caller, and ignored it there.  So this is an improvement of sorts.

Still, is ignoring errors correct?  For what it's worth, the other
caller of pcie_aer_inject_error() asserts it succeeds.

> +    ret_data->id = id;
> +    ret_data->root_bus = pci_root_bus_path(dev);
> +    ret_data->bus = pci_bus_num(dev->bus);
> +    ret_data->devfn = dev->devfn;
>
>      return 0;
>  }
>
>  void hmp_pcie_aer_inject_error(Monitor *mon, const QDict *qdict)
>  {
> -    QObject *data;
> -    int devfn;
> +    PCIEErrorInject data;

Your chance to pick a better name than @data, if you like.

>
>      if (do_pcie_aer_inject_error(mon, qdict, &data) < 0) {
>          return;
>      }
>
> -    assert(qobject_type(data) == QTYPE_QDICT);
> -    qdict = qobject_to_qdict(data);
> -
> -    devfn = (int)qdict_get_int(qdict, "devfn");
>      monitor_printf(mon, "OK id: %s root bus: %s, bus: %x devfn: %x.%x\n",
> -                   qdict_get_str(qdict, "id"),
> -                   qdict_get_str(qdict, "root_bus"),
> -                   (int) qdict_get_int(qdict, "bus"),
> -                   PCI_SLOT(devfn), PCI_FUNC(devfn));

Here's where we ignore the return code.

> +                   data.id, data.root_bus, data.bus,
> +                   PCI_SLOT(data.devfn), PCI_FUNC(data.devfn));
>  }

Since the fishy error ignore is pre-existing:
Reviewed-by: Markus Armbruster <armbru@redhat.com>
