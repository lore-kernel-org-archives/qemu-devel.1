Return-Path: <SRS0=3KIA=4V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F4E4C3F2CD
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2020 10:48:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EEDDC20732
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2020 10:48:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="da7h7ZcU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EEDDC20732
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60820 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9RZi-00063Y-4Q
	for qemu-devel@archiver.kernel.org; Wed, 04 Mar 2020 05:48:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59390)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1j9RYy-0005XL-6Y
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 05:47:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1j9RYv-0001Ig-QT
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 05:47:39 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:20638
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1j9RYv-0001H4-Fn
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 05:47:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583318856;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=L7lZsKpMspFfC93ICZYw9dJQjEmo2lRCgzmB5AhbM64=;
 b=da7h7ZcUYYreJRLUa6yARaXhDqRtpqxdSdPCPwrh0e3PUjjh0l4doc+hIWsozXcPegTsbw
 C/0jbmsxydrktCFbJTXOkOmhZVadpmiK0eiBumZLs/lFRIvrY6ioHLE7Hx27WR0eu5qhfB
 rsV9a0sZ/YlKOSTcxsdK4JzUfc6q5No=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-244-6cMRmpCIOMuE-HGB2z8tZQ-1; Wed, 04 Mar 2020 05:47:32 -0500
X-MC-Unique: 6cMRmpCIOMuE-HGB2z8tZQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 98E5F13E2;
 Wed,  4 Mar 2020 10:47:30 +0000 (UTC)
Received: from work-vm (ovpn-116-225.ams2.redhat.com [10.36.116.225])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1CABA1001B3F;
 Wed,  4 Mar 2020 10:47:17 +0000 (UTC)
Date: Wed, 4 Mar 2020 10:47:15 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Jagannathan Raman <jag.raman@oracle.com>
Subject: Re: [PATCH v5 15/50] multi-process: PCI BAR read/write handling for
 proxy & remote endpoints
Message-ID: <20200304104715.GC4104@work-vm>
References: <cover.1582576372.git.jag.raman@oracle.com>
 <28d7426190d8a88c7b93f5f5daf8cd1c6e017a76.1582576372.git.jag.raman@oracle.com>
MIME-Version: 1.0
In-Reply-To: <28d7426190d8a88c7b93f5f5daf8cd1c6e017a76.1582576372.git.jag.raman@oracle.com>
User-Agent: Mutt/1.13.3 (2020-01-12)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
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
Cc: elena.ufimtseva@oracle.com, fam@euphon.net, swapnil.ingle@nutanix.com,
 john.g.johnson@oracle.com, qemu-devel@nongnu.org, kraxel@redhat.com,
 quintela@redhat.com, mst@redhat.com, armbru@redhat.com,
 kanth.ghatraju@oracle.com, felipe@nutanix.com, thuth@redhat.com,
 ehabkost@redhat.com, konrad.wilk@oracle.com, liran.alon@oracle.com,
 stefanha@redhat.com, thanos.makatos@nutanix.com, rth@twiddle.net,
 kwolf@redhat.com, berrange@redhat.com, mreitz@redhat.com,
 ross.lagerwall@citrix.com, marcandre.lureau@gmail.com, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Jagannathan Raman (jag.raman@oracle.com) wrote:
> Proxy device object implements handler for PCI BAR writes and reads. The =
handler
> uses BAR_WRITE/BAR_READ message to communicate to the remote process with=
 the BAR address and
> value to be written/read.
> The remote process implements handler for BAR_WRITE/BAR_READ message.
>=20
> Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
> Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
> Signed-off-by: John G Johnson <john.g.johnson@oracle.com>
> ---
>  hw/proxy/qemu-proxy.c         | 65 +++++++++++++++++++++++++++++++++++++=
+
>  include/hw/proxy/qemu-proxy.h | 22 +++++++++++--
>  include/io/mpqemu-link.h      | 12 +++++++
>  remote/remote-main.c          | 73 +++++++++++++++++++++++++++++++++++++=
++++++
>  4 files changed, 170 insertions(+), 2 deletions(-)
>=20
> diff --git a/hw/proxy/qemu-proxy.c b/hw/proxy/qemu-proxy.c
> index d792e86..b17d9bb 100644
> --- a/hw/proxy/qemu-proxy.c
> +++ b/hw/proxy/qemu-proxy.c
> @@ -262,3 +262,68 @@ static void pci_proxy_dev_realize(PCIDevice *device,=
 Error **errp)
>      dev->get_proxy_sock =3D get_proxy_sock;
>      dev->init_proxy =3D init_proxy;
>  }
> +
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
> +    mpqemu_msg_send(&msg, mpqemu_link->com);
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
> index 29fa2e9..44e370e 100644
> --- a/include/hw/proxy/qemu-proxy.h
> +++ b/include/hw/proxy/qemu-proxy.h
> @@ -22,7 +22,19 @@
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
> +extern const MemoryRegionOps proxy_default_ops;
> +
> +struct PCIProxyDev {
>      PCIDevice parent_dev;
> =20
>      MPQemuLinkState *mpqemu_link;
> @@ -41,7 +53,8 @@ typedef struct PCIProxyDev {
>      void (*init_proxy) (PCIDevice *dev, char *command, char *exec_name,
>                          bool need_spawn, Error **errp);
> =20
> -} PCIProxyDev;
> +    ProxyMemoryRegion region[PCI_NUM_REGIONS];
> +};
> =20
>  typedef struct PCIProxyDevClass {
>      PCIDeviceClass parent_class;
> @@ -51,4 +64,9 @@ typedef struct PCIProxyDevClass {
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
> index 5a2be48..1a7738e 100644
> --- a/include/io/mpqemu-link.h
> +++ b/include/io/mpqemu-link.h
> @@ -38,6 +38,8 @@
>   * PCI_CONFIG_READ        PCI configuration space read
>   * PCI_CONFIG_WRITE       PCI configuration space write
>   * SYNC_SYSMEM      Shares QEMU's RAM with remote device's RAM
> + * BAR_WRITE        Writes to PCI BAR region
> + * BAR_READ         Reads from PCI BAR region
>   *
>   * proc_cmd_t enum type to specify the command to be executed on the rem=
ote
>   * device.
> @@ -47,6 +49,8 @@ typedef enum {
>      PCI_CONFIG_READ,
>      PCI_CONFIG_WRITE,
>      SYNC_SYSMEM,
> +    BAR_WRITE,
> +    BAR_READ,
>      MAX,
>  } mpqemu_cmd_t;
> =20
> @@ -70,6 +74,13 @@ typedef struct {
>  } sync_sysmem_msg_t;
> =20
>  typedef struct {
> +    hwaddr addr;
> +    uint64_t val;
> +    unsigned size;
> +    bool memory;
> +} bar_access_msg_t;
> +
> +typedef struct {
>      mpqemu_cmd_t cmd;
>      int bytestream;
>      size_t size;
> @@ -77,6 +88,7 @@ typedef struct {
>      union {
>          uint64_t u64;
>          sync_sysmem_msg_t sync_sysmem;
> +        bar_access_msg_t bar_access;
>      } data1;
> =20
>      int fds[REMOTE_MAX_FDS];
> diff --git a/remote/remote-main.c b/remote/remote-main.c
> index 7b4cf2f..acd8daf 100644
> --- a/remote/remote-main.c
> +++ b/remote/remote-main.c
> @@ -33,6 +33,7 @@
>  #include "sysemu/sysemu.h"
>  #include "block/block.h"
>  #include "exec/ramlist.h"
> +#include "exec/memattrs.h"
> =20
>  static MPQemuLinkState *mpqemu_link;
>  PCIDevice *remote_pci_dev;
> @@ -63,6 +64,66 @@ static void process_config_read(MPQemuMsg *msg)
>      PUT_REMOTE_WAIT(wait);
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

Note you don't have that check on the write function above.
Do you actually want something like:
   assert(is_power_of_2(bar_access->size) && bar_access->size <=3D sizeof(u=
int64_t));

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

No case 8 ?

Dave

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
>  static void process_msg(GIOCondition cond, MPQemuChannel *chan)
>  {
>      MPQemuMsg *msg =3D NULL;
> @@ -88,6 +149,18 @@ static void process_msg(GIOCondition cond, MPQemuChan=
nel *chan)
>      case PCI_CONFIG_READ:
>          process_config_read(msg);
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
> 1.8.3.1
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


