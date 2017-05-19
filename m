Received: from eggs.gnu.org ([2001:4830:134:3::10]:45512)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dBcDX-0005CU-MR
	for qemu-devel@nongnu.org; Fri, 19 May 2017 03:20:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dBcDU-0008If-FN
	for qemu-devel@nongnu.org; Fri, 19 May 2017 03:20:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54056)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dBcDU-0008IS-07
	for qemu-devel@nongnu.org; Fri, 19 May 2017 03:20:52 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <cover.1495018956.git.maozy.fnst@cn.fujitsu.com>
	<645c1b3e6fc23605365c0685d94ec50df7a7fd2b.1495018956.git.maozy.fnst@cn.fujitsu.com>
Date: Fri, 19 May 2017 09:20:48 +0200
In-Reply-To: <645c1b3e6fc23605365c0685d94ec50df7a7fd2b.1495018956.git.maozy.fnst@cn.fujitsu.com>
	(Mao Zhongyi's message of "Wed, 17 May 2017 19:12:25 +0800")
Message-ID: <87y3ttgvn3.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v4 3/3] net/rocker: Convert to realize()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>
Cc: qemu-devel@nongnu.org, jasowang@redhat.com, jiri@resnulli.us, f4bug@amsat.org

Mao Zhongyi <maozy.fnst@cn.fujitsu.com> writes:

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
> Cc: jasowang@redhat.com
> Cc: jiri@resnulli.us
> Cc: f4bug@amsat.org
> Cc: armbru@redhat.com
> Signed-off-by: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>

The conversion to realize() looks good to me, therefore
Reviewed-by: Markus Armbruster <armbru@redhat.com>

However, I spotted a few issues not related to this patch.

1. Unusual macro names

    #define ROCKER "rocker"

    #define to_rocker(obj) \
        OBJECT_CHECK(Rocker, (obj), ROCKER)

   Please clean up to

    #define TYPE_ROCKER "rocker"

    #define ROCKER(obj) \
        OBJECT_CHECK(Rocker, (obj), TYPE_ROCKER)

   in a separate patch.

2. Memory leaks on error and unplug

   Explained inline below.

> ---
>  hw/net/rocker/rocker.c | 27 +++++++++++----------------
>  1 file changed, 11 insertions(+), 16 deletions(-)
>
> diff --git a/hw/net/rocker/rocker.c b/hw/net/rocker/rocker.c
> index a382a6f..b9a77f1 100644
> --- a/hw/net/rocker/rocker.c
> +++ b/hw/net/rocker/rocker.c
> @@ -1252,20 +1252,18 @@ rollback:
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
> @@ -1301,7 +1299,7 @@ static World *rocker_world_type_by_name(Rocker *r, const char *name)
>      return NULL;
>  }
>  
> -static int pci_rocker_init(PCIDevice *dev)
> +static void pci_rocker_realize(PCIDevice *dev, Error **errp)
>  {
>      Rocker *r = to_rocker(dev);
>      const MACAddr zero = { .a = { 0, 0, 0, 0, 0, 0 } };
> @@ -1319,10 +1317,9 @@ static int pci_rocker_init(PCIDevice *dev)
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
> @@ -1342,7 +1339,7 @@ static int pci_rocker_init(PCIDevice *dev)
>  
>      /* MSI-X init */
>  
> -    err = rocker_msix_init(r);
> +    err = rocker_msix_init(r, errp);
>      if (err) {
>          goto err_msix_init;
>      }
> @@ -1354,7 +1351,7 @@ static int pci_rocker_init(PCIDevice *dev)
>      }
>  
>      if (rocker_find(r->name)) {
> -        err = -EEXIST;
> +        error_setg(errp, "%s already exists", r->name);
>          goto err_duplicate;
>      }
>  
> @@ -1368,10 +1365,9 @@ static int pci_rocker_init(PCIDevice *dev)
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
> @@ -1429,7 +1425,7 @@ static int pci_rocker_init(PCIDevice *dev)
>  
>      QLIST_INSERT_HEAD(&rockers, r, next);
>  
> -    return 0;
> +    return;
>  
>  err_name_too_long:
>  err_duplicate:
       rocker_msix_uninit(r);
   err_msix_init:
       object_unparent(OBJECT(&r->msix_bar));
       object_unparent(OBJECT(&r->mmio));
   err_world_type_by_name:
       for (i = 0; i < ROCKER_WORLD_TYPE_MAX; i++) {
           if (r->worlds[i]) {
> @@ -1443,7 +1439,6 @@ err_world_type_by_name:
>              world_free(r->worlds[i]);
>          }
>      }
> -    return err;
>  }
>  

Does this leak r->world_name and r->name?

If yes, can you delay their allocation until after the last thing that
can fail?  That way, you don't have to free them on failure.  Simplifies
the error paths.  Keeping them as simple as practical is desireable,
because they're hard to test.

Simlarly, if you can delay allocation of r->worlds[], you can remove its
cleanup here.  Same for the other things you clean up here; I trust you
get the idea.

If substantial cleanup work remains, you could try to make
pci_rocker_uninit() usable here: ensure each of its steps does nothing
when the corresponding step in pci_rocker_realize() hasn't been
executed.  For a simple g_free() that's automatic, because g_free(P)
does nothing when P is null.  More complicated steps you might need to
wrap in a suitable conditional.

>  static void pci_rocker_uninit(PCIDevice *dev)
   {
       Rocker *r = to_rocker(dev);
       int i;

       QLIST_REMOVE(r, next);

       for (i = 0; i < r->fp_ports; i++) {
           FpPort *port = r->fp_port[i];

           fp_port_free(port);
           r->fp_port[i] = NULL;
       }

       for (i = 0; i < rocker_pci_ring_count(r); i++) {
           if (r->rings[i]) {
               desc_ring_free(r->rings[i]);
           }
       }
       g_free(r->rings);

       rocker_msix_uninit(r);
       object_unparent(OBJECT(&r->msix_bar));
       object_unparent(OBJECT(&r->mmio));

       for (i = 0; i < ROCKER_WORLD_TYPE_MAX; i++) {
           if (r->worlds[i]) {
               world_free(r->worlds[i]);
           }
       }
       g_free(r->fp_ports_peers);
   }

Does this leak r->world_name and r->name?

Suggest to run a hot unplug under valgrind to check for leaks.  Best run
it before fixing the leaks you can see to make sure you're using it
correctly.

Fixes could be squashed into PATCH 2.  If you don't want to do that, a
separate patch would also be okay.

> @@ -1528,7 +1523,7 @@ static void rocker_class_init(ObjectClass *klass, void *data)
>      DeviceClass *dc = DEVICE_CLASS(klass);
>      PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
>  
> -    k->init = pci_rocker_init;
> +    k->realize = pci_rocker_realize;
>      k->exit = pci_rocker_uninit;
>      k->vendor_id = PCI_VENDOR_ID_REDHAT;
>      k->device_id = PCI_DEVICE_ID_REDHAT_ROCKER;
