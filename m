Received: from eggs.gnu.org ([2001:4830:134:3::10]:50268)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dDOE5-0006oL-81
	for qemu-devel@nongnu.org; Wed, 24 May 2017 00:48:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dDOE2-000560-3z
	for qemu-devel@nongnu.org; Wed, 24 May 2017 00:48:49 -0400
Received: from mail-oi0-x242.google.com ([2607:f8b0:4003:c06::242]:36745)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dDOE1-00055t-U9
	for qemu-devel@nongnu.org; Wed, 24 May 2017 00:48:46 -0400
Received: by mail-oi0-x242.google.com with SMTP id w138so30972000oiw.3
	for <qemu-devel@nongnu.org>; Tue, 23 May 2017 21:48:45 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <cover.1495508197.git.maozy.fnst@cn.fujitsu.com>
	<9c83a8920af8a2e4ab4077dc5ae1b74622bba871.1495508197.git.maozy.fnst@cn.fujitsu.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <fa9a3e1f-4cd3-25bf-f996-8edfb7c532ef@amsat.org>
Date: Wed, 24 May 2017 01:48:43 -0300
MIME-Version: 1.0
In-Reply-To: <9c83a8920af8a2e4ab4077dc5ae1b74622bba871.1495508197.git.maozy.fnst@cn.fujitsu.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v5 3/4] net/rocker: Convert to realize()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>, qemu-devel@nongnu.org
Cc: armbru@redhat.com, jasowang@redhat.com, jiri@resnulli.us

On 05/23/2017 01:04 AM, Mao Zhongyi wrote:
> The rocker device still implements the old PCIDeviceClass .init()
> instead of the new .realize(). All devices need to be converted to
> .realize().
>
> .init() reports errors with fprintf() and return 0 on success, negative
> number on failure. Meanwhile, when -device rocker fails, it first report
> a specific error, then a generic one, like this:
>
>     $ x86_64-softmmu/qemu-system-x86_64 -device rocker,name=qemu-rocker
>     rocker: name too long; please shorten to at most 9 chars
>     qemu-system-x86_64: -device rocker,name=qemu-rocker: Device initialization failed
>
> Now, convert it to .realize() that passes errors to its callers via its
> errp argument. Also avoid the superfluous second error message. After
> the patch, effect like this:
>
>     $ x86_64-softmmu/qemu-system-x86_64 -device rocker,name=qemu-rocker
>     qemu-system-x86_64: -device rocker,name=qemu-rocker: name too long; please shorten to at most 9 chars
>
> Signed-off-by: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>
> Reviewed-by: Markus Armbruster <armbru@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  hw/net/rocker/rocker.c | 27 +++++++++++----------------
>  1 file changed, 11 insertions(+), 16 deletions(-)
>
> diff --git a/hw/net/rocker/rocker.c b/hw/net/rocker/rocker.c
> index 6d44f37..2764529 100644
> --- a/hw/net/rocker/rocker.c
> +++ b/hw/net/rocker/rocker.c
> @@ -1238,20 +1238,18 @@ rollback:
>      return err;
>  }
>
> -static int rocker_msix_init(Rocker *r)
> +static int rocker_msix_init(Rocker *r, Error **errp)
>  {
>      PCIDevice *dev = PCI_DEVICE(r);
>      int err;
> -    Error *local_err = NULL;
>
>      err = msix_init(dev, ROCKER_MSIX_VEC_COUNT(r->fp_ports),
>                      &r->msix_bar,
>                      ROCKER_PCI_MSIX_BAR_IDX, ROCKER_PCI_MSIX_TABLE_OFFSET,
>                      &r->msix_bar,
>                      ROCKER_PCI_MSIX_BAR_IDX, ROCKER_PCI_MSIX_PBA_OFFSET,
> -                    0, &local_err);
> +                    0, errp);
>      if (err) {
> -        error_report_err(local_err);
>          return err;
>      }
>
> @@ -1287,7 +1285,7 @@ static World *rocker_world_type_by_name(Rocker *r, const char *name)
>      return NULL;
>  }
>
> -static int pci_rocker_init(PCIDevice *dev)
> +static void pci_rocker_realize(PCIDevice *dev, Error **errp)
>  {
>      Rocker *r = to_rocker(dev);
>      const MACAddr zero = { .a = { 0, 0, 0, 0, 0, 0 } };
> @@ -1305,10 +1303,9 @@ static int pci_rocker_init(PCIDevice *dev)
>
>      r->world_dflt = rocker_world_type_by_name(r, r->world_name);
>      if (!r->world_dflt) {
> -        fprintf(stderr,
> -                "rocker: requested world \"%s\" does not exist\n",
> +        error_setg(errp,
> +                "invalid argument requested world %s does not exist",
>                  r->world_name);
> -        err = -EINVAL;
>          goto err_world_type_by_name;
>      }
>
> @@ -1328,7 +1325,7 @@ static int pci_rocker_init(PCIDevice *dev)
>
>      /* MSI-X init */
>
> -    err = rocker_msix_init(r);
> +    err = rocker_msix_init(r, errp);
>      if (err) {
>          goto err_msix_init;
>      }
> @@ -1340,7 +1337,7 @@ static int pci_rocker_init(PCIDevice *dev)
>      }
>
>      if (rocker_find(r->name)) {
> -        err = -EEXIST;
> +        error_setg(errp, "%s already exists", r->name);
>          goto err_duplicate;
>      }
>
> @@ -1354,10 +1351,9 @@ static int pci_rocker_init(PCIDevice *dev)
>  #define ROCKER_IFNAMSIZ 16
>  #define MAX_ROCKER_NAME_LEN  (ROCKER_IFNAMSIZ - 1 - 3 - 3)
>      if (strlen(r->name) > MAX_ROCKER_NAME_LEN) {
> -        fprintf(stderr,
> -                "rocker: name too long; please shorten to at most %d chars\n",
> +        error_setg(errp,
> +                "name too long; please shorten to at most %d chars",
>                  MAX_ROCKER_NAME_LEN);
> -        err = -EINVAL;
>          goto err_name_too_long;
>      }
>
> @@ -1415,7 +1411,7 @@ static int pci_rocker_init(PCIDevice *dev)
>
>      QLIST_INSERT_HEAD(&rockers, r, next);
>
> -    return 0;
> +    return;
>
>  err_name_too_long:
>  err_duplicate:
> @@ -1429,7 +1425,6 @@ err_world_type_by_name:
>              world_free(r->worlds[i]);
>          }
>      }
> -    return err;
>  }
>
>  static void pci_rocker_uninit(PCIDevice *dev)
> @@ -1514,7 +1509,7 @@ static void rocker_class_init(ObjectClass *klass, void *data)
>      DeviceClass *dc = DEVICE_CLASS(klass);
>      PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
>
> -    k->init = pci_rocker_init;
> +    k->realize = pci_rocker_realize;
>      k->exit = pci_rocker_uninit;
>      k->vendor_id = PCI_VENDOR_ID_REDHAT;
>      k->device_id = PCI_DEVICE_ID_REDHAT_ROCKER;
>
