Return-Path: <SRS0=qpXq=5Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9004C2BA19
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2020 18:59:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 903A020757
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2020 18:59:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FLPCK1H9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 903A020757
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54232 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jMcOI-0008Sa-Pw
	for qemu-devel@archiver.kernel.org; Thu, 09 Apr 2020 14:59:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54845)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1jMcLf-0006YY-6q
 for qemu-devel@nongnu.org; Thu, 09 Apr 2020 14:56:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1jMcLa-0007Tz-DY
 for qemu-devel@nongnu.org; Thu, 09 Apr 2020 14:56:23 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:37631
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1jMcLa-0007Tq-8M
 for qemu-devel@nongnu.org; Thu, 09 Apr 2020 14:56:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586458577;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JISnn51LSbMY9sSqEY+/kJVJ59Qy/HvozOB0tcgR4w4=;
 b=FLPCK1H9QXgfi9VJXbyRzLhi1TfD7WkpWBWd6oQfXHtRKL5hy9suXL3DPoHKcup0noRGJA
 hzbxze+rFfArIG7xhYorIFcLJPo0sBhErYGWeXoDIaKF7Lx2ExA4/6dv3RtkQsf9AmnhDP
 wcg6Qd/XODAp3CEhZ+LIOjdIGgKSs6g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-474-YzDniK6EPsiq6B5nMASmIQ-1; Thu, 09 Apr 2020 14:56:13 -0400
X-MC-Unique: YzDniK6EPsiq6B5nMASmIQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 10007149C2;
 Thu,  9 Apr 2020 18:56:11 +0000 (UTC)
Received: from work-vm (ovpn-114-117.ams2.redhat.com [10.36.114.117])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8CC5C118F5A;
 Thu,  9 Apr 2020 18:55:54 +0000 (UTC)
Date: Thu, 9 Apr 2020 19:55:52 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: elena.ufimtseva@oracle.com
Subject: Re: [PATCH v6 21/36] multi-process: PCI BAR read/write handling for
 proxy & remote endpoints
Message-ID: <20200409185552.GH3065@work-vm>
References: <cover.1586165555.git.elena.ufimtseva@oracle.com>
 <848b7213d9c1de43f5f5c8518a4f5bcd46faec7e.1586165556.git.elena.ufimtseva@oracle.com>
MIME-Version: 1.0
In-Reply-To: <848b7213d9c1de43f5f5c8518a4f5bcd46faec7e.1586165556.git.elena.ufimtseva@oracle.com>
User-Agent: Mutt/1.13.4 (2020-02-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: fam@euphon.net, john.g.johnson@oracle.com, swapnil.ingle@nutanix.com,
 mst@redhat.com, qemu-devel@nongnu.org, kraxel@redhat.com, jag.raman@oracle.com,
 quintela@redhat.com, armbru@redhat.com, kanth.ghatraju@oracle.com,
 felipe@nutanix.com, thuth@redhat.com, ehabkost@redhat.com,
 konrad.wilk@oracle.com, liran.alon@oracle.com, stefanha@redhat.com,
 thanos.makatos@nutanix.com, rth@twiddle.net, kwolf@redhat.com,
 berrange@redhat.com, mreitz@redhat.com, ross.lagerwall@citrix.com,
 marcandre.lureau@gmail.com, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* elena.ufimtseva@oracle.com (elena.ufimtseva@oracle.com) wrote:
> From: Jagannathan Raman <jag.raman@oracle.com>
>=20
> Proxy device object implements handler for PCI BAR writes and reads.
> The handler uses BAR_WRITE/BAR_READ message to communicate to the
> remote process with the BAR address and value to be written/read.
> The remote process implements handler for BAR_WRITE/BAR_READ
> message.
>=20
> Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
> Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
> Signed-off-by: John G Johnson <john.g.johnson@oracle.com>

Again please see my comments on v5

> ---
>  hw/proxy/qemu-proxy.c         | 64 ++++++++++++++++++++++++++++++
>  include/hw/proxy/qemu-proxy.h | 20 +++++++++-
>  include/io/mpqemu-link.h      | 12 ++++++
>  io/mpqemu-link.c              |  6 +++
>  remote/remote-main.c          | 73 +++++++++++++++++++++++++++++++++++
>  5 files changed, 173 insertions(+), 2 deletions(-)
>=20
> diff --git a/hw/proxy/qemu-proxy.c b/hw/proxy/qemu-proxy.c
> index 87cf39c672..7fd0a312a5 100644
> --- a/hw/proxy/qemu-proxy.c
> +++ b/hw/proxy/qemu-proxy.c
> @@ -169,3 +169,67 @@ static void pci_proxy_dev_register_types(void)
> =20
>  type_init(pci_proxy_dev_register_types)
> =20
> +static void send_bar_access_msg(PCIProxyDev *dev, MemoryRegion *mr,
> +                                bool write, hwaddr addr, uint64_t *val,
> +                                unsigned size, bool memory)
> +{
> +    MPQemuLinkState *mpqemu_link =3D dev->mpqemu_link;
> +    MPQemuMsg msg;
> +    int wait;
> +
> +    memset(&msg, 0, sizeof(MPQemuMsg));
> +
> +    msg.bytestream =3D 0;
> +    msg.size =3D sizeof(msg.data1);
> +    msg.data1.bar_access.addr =3D mr->addr + addr;
> +    msg.data1.bar_access.size =3D size;
> +    msg.data1.bar_access.memory =3D memory;
> +
> +    if (write) {
> +        msg.cmd =3D BAR_WRITE;
> +        msg.data1.bar_access.val =3D *val;
> +    } else {
> +        wait =3D GET_REMOTE_WAIT;
> +
> +        msg.cmd =3D BAR_READ;
> +        msg.num_fds =3D 1;
> +        msg.fds[0] =3D wait;
> +    }
> +
> +    mpqemu_msg_send(&msg, mpqemu_link->dev);
> +
> +    if (!write) {
> +        *val =3D wait_for_remote(wait);
> +        PUT_REMOTE_WAIT(wait);
> +    }
> +}
> +
> +void proxy_default_bar_write(void *opaque, hwaddr addr, uint64_t val,
> +                             unsigned size)
> +{
> +    ProxyMemoryRegion *pmr =3D opaque;
> +
> +    send_bar_access_msg(pmr->dev, &pmr->mr, true, addr, &val, size,
> +                        pmr->memory);
> +}
> +
> +uint64_t proxy_default_bar_read(void *opaque, hwaddr addr, unsigned size=
)
> +{
> +    ProxyMemoryRegion *pmr =3D opaque;
> +    uint64_t val;
> +
> +    send_bar_access_msg(pmr->dev, &pmr->mr, false, addr, &val, size,
> +                        pmr->memory);
> +
> +     return val;
> +}
> +
> +const MemoryRegionOps proxy_default_ops =3D {
> +    .read =3D proxy_default_bar_read,
> +    .write =3D proxy_default_bar_write,
> +    .endianness =3D DEVICE_NATIVE_ENDIAN,
> +    .impl =3D {
> +        .min_access_size =3D 1,
> +        .max_access_size =3D 1,
> +    },
> +};
> diff --git a/include/hw/proxy/qemu-proxy.h b/include/hw/proxy/qemu-proxy.=
h
> index d7eaf26f29..9e4127eccb 100644
> --- a/include/hw/proxy/qemu-proxy.h
> +++ b/include/hw/proxy/qemu-proxy.h
> @@ -26,14 +26,25 @@
>  #define PCI_PROXY_DEV_GET_CLASS(obj) \
>              OBJECT_GET_CLASS(PCIProxyDevClass, (obj), TYPE_PCI_PROXY_DEV=
)
> =20
> -typedef struct PCIProxyDev {
> +typedef struct PCIProxyDev PCIProxyDev;
> +
> +typedef struct ProxyMemoryRegion {
> +    PCIProxyDev *dev;
> +    MemoryRegion mr;
> +    bool memory;
> +    bool present;
> +    uint8_t type;
> +} ProxyMemoryRegion;
> +
> +struct PCIProxyDev {
>      PCIDevice parent_dev;
> =20
>      MPQemuLinkState *mpqemu_link;
> =20
>      int socket;
> =20
> -} PCIProxyDev;
> +    ProxyMemoryRegion region[PCI_NUM_REGIONS];
> +};
> =20
>  typedef struct PCIProxyDevClass {
>      PCIDeviceClass parent_class;
> @@ -43,4 +54,9 @@ typedef struct PCIProxyDevClass {
>      char *command;
>  } PCIProxyDevClass;
> =20
> +void proxy_default_bar_write(void *opaque, hwaddr addr, uint64_t val,
> +                             unsigned size);
> +
> +uint64_t proxy_default_bar_read(void *opaque, hwaddr addr, unsigned size=
);
> +
>  #endif /* QEMU_PROXY_H */
> diff --git a/include/io/mpqemu-link.h b/include/io/mpqemu-link.h
> index 7228a1915e..41cf092f9e 100644
> --- a/include/io/mpqemu-link.h
> +++ b/include/io/mpqemu-link.h
> @@ -31,6 +31,8 @@
>  /**
>   * mpqemu_cmd_t:
>   * SYNC_SYSMEM      Shares QEMU's RAM with remote device's RAM
> + * BAR_WRITE        Writes to PCI BAR region
> + * BAR_READ         Reads from PCI BAR region
>   *
>   * proc_cmd_t enum type to specify the command to be executed on the rem=
ote
>   * device.
> @@ -41,6 +43,8 @@ typedef enum {
>      CONNECT_DEV,
>      PCI_CONFIG_WRITE,
>      PCI_CONFIG_READ,
> +    BAR_WRITE,
> +    BAR_READ,
>      MAX,
>  } mpqemu_cmd_t;
> =20
> @@ -56,6 +60,13 @@ typedef struct {
>      ram_addr_t offsets[REMOTE_MAX_FDS];
>  } sync_sysmem_msg_t;
> =20
> +typedef struct {
> +    hwaddr addr;
> +    uint64_t val;
> +    unsigned size;
> +    bool memory;
> +} bar_access_msg_t;
> +
>  /**
>   * MPQemuMsg:
>   * @cmd: The remote command
> @@ -78,6 +89,7 @@ typedef struct {
>      union {
>          uint64_t u64;
>          sync_sysmem_msg_t sync_sysmem;
> +        bar_access_msg_t bar_access;
>      } data1;
> =20
>      int fds[REMOTE_MAX_FDS];
> diff --git a/io/mpqemu-link.c b/io/mpqemu-link.c
> index 643c0588ce..2b67ef6410 100644
> --- a/io/mpqemu-link.c
> +++ b/io/mpqemu-link.c
> @@ -367,6 +367,12 @@ bool mpqemu_msg_valid(MPQemuMsg *msg)
>              return false;
>          }
>          break;
> +    case BAR_WRITE:
> +    case BAR_READ:
> +        if (msg->size !=3D sizeof(msg->data1)) {
> +            return false;
> +        }
> +        break;
>      default:
>          break;
>      }
> diff --git a/remote/remote-main.c b/remote/remote-main.c
> index b5ed31f63b..4f512aa5a8 100644
> --- a/remote/remote-main.c
> +++ b/remote/remote-main.c
> @@ -33,6 +33,7 @@
>  #include "sysemu/sysemu.h"
>  #include "block/block.h"
>  #include "exec/ramlist.h"
> +#include "exec/memattrs.h"
> =20
>  static void process_msg(GIOCondition cond, MPQemuLinkState *link,
>                          MPQemuChannel *chan);
> @@ -102,6 +103,66 @@ exit:
>      notify_proxy(wait, ret);
>  }
> =20
> +/* TODO: confirm memtx attrs. */
> +static void process_bar_write(MPQemuMsg *msg, Error **errp)
> +{
> +    bar_access_msg_t *bar_access =3D &msg->data1.bar_access;
> +    AddressSpace *as =3D
> +        bar_access->memory ? &address_space_memory : &address_space_io;
> +    MemTxResult res;
> +
> +    res =3D address_space_rw(as, bar_access->addr, MEMTXATTRS_UNSPECIFIE=
D,
> +                           (uint8_t *)&bar_access->val, bar_access->size=
, true);
> +
> +    if (res !=3D MEMTX_OK) {
> +        error_setg(errp, "Could not perform address space write operatio=
n,"
> +                   " inaccessible address: %lx.", bar_access->addr);
> +    }
> +}
> +
> +static void process_bar_read(MPQemuMsg *msg, Error **errp)
> +{
> +    bar_access_msg_t *bar_access =3D &msg->data1.bar_access;
> +    AddressSpace *as;
> +    int wait =3D msg->fds[0];
> +    MemTxResult res;
> +    uint64_t val =3D 0;
> +
> +    as =3D bar_access->memory ? &address_space_memory : &address_space_i=
o;
> +
> +    assert(bar_access->size <=3D sizeof(uint64_t));
> +
> +    res =3D address_space_rw(as, bar_access->addr, MEMTXATTRS_UNSPECIFIE=
D,
> +                           (uint8_t *)&val, bar_access->size, false);
> +
> +    if (res !=3D MEMTX_OK) {
> +        error_setg(errp, "Could not perform address space read operation=
,"
> +                   " inaccessible address: %lx.", bar_access->addr);
> +        val =3D (uint64_t)-1;
> +        goto fail;
> +    }
> +
> +    switch (bar_access->size) {
> +    case 4:
> +        val =3D *((uint32_t *)&val);
> +        break;
> +    case 2:
> +        val =3D *((uint16_t *)&val);
> +        break;
> +    case 1:
> +        val =3D *((uint8_t *)&val);
> +        break;
> +    default:
> +        error_setg(errp, "Invalid PCI BAR read size");
> +        return;
> +    }
> +
> +fail:
> +    notify_proxy(wait, val);
> +
> +    PUT_REMOTE_WAIT(wait);
> +}
> +
>  static void process_msg(GIOCondition cond, MPQemuLinkState *link,
>                          MPQemuChannel *chan)
>  {
> @@ -131,6 +192,18 @@ static void process_msg(GIOCondition cond, MPQemuLin=
kState *link,
>      case PCI_CONFIG_READ:
>          process_config_read(LINK_TO_DEV(link), msg);
>          break;
> +    case BAR_WRITE:
> +        process_bar_write(msg, &err);
> +        if (err) {
> +            goto finalize_loop;
> +        }
> +        break;
> +    case BAR_READ:
> +        process_bar_read(msg, &err);
> +        if (err) {
> +            goto finalize_loop;
> +        }
> +        break;
>      default:
>          error_setg(&err, "Unknown command");
>          goto finalize_loop;
> --=20
> 2.25.GIT
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


