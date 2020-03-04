Return-Path: <SRS0=3KIA=4V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C85FC3F2D1
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2020 11:54:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A22A21741
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2020 11:54:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YEotVPiO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A22A21741
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33186 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9Sbx-0008P9-DO
	for qemu-devel@archiver.kernel.org; Wed, 04 Mar 2020 06:54:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48636)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1j9Sb0-0007TL-Gg
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 06:53:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1j9Sax-00070a-KV
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 06:53:49 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:57780
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1j9Sax-0006zr-6x
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 06:53:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583322826;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GP0/FlrPAEOVodypZkVM7eZYORPGJP5nCgW3rVkkSgs=;
 b=YEotVPiOAwp+CM9oPfGMjzNUkTSjB0IkoevpxMDXG4koRoIQDXcarKHGC6pWZIDMY3nSQ3
 ejBxEBju9Dly77lnl4u3FlcMeFiEJ5A4/fIqp9/WzX71pFI4EtY6C0mUQbryShPKFFy1dr
 bUwrHeZMfz8scLcKf/n85gsXeAFF4VQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-193-8m96rh6YMEqCrgjbCjLW6w-1; Wed, 04 Mar 2020 06:53:43 -0500
X-MC-Unique: 8m96rh6YMEqCrgjbCjLW6w-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C5A65800D48;
 Wed,  4 Mar 2020 11:53:40 +0000 (UTC)
Received: from work-vm (ovpn-116-225.ams2.redhat.com [10.36.116.225])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 08ADF5DA89;
 Wed,  4 Mar 2020 11:53:25 +0000 (UTC)
Date: Wed, 4 Mar 2020 11:53:23 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Jagannathan Raman <jag.raman@oracle.com>
Subject: Re: [PATCH v5 16/50] multi-process: Synchronize remote memory
Message-ID: <20200304115323.GD4104@work-vm>
References: <cover.1582576372.git.jag.raman@oracle.com>
 <52bdcfdf44bcc4cd8a1a707b9c22f545fe0f1491.1582576372.git.jag.raman@oracle.com>
MIME-Version: 1.0
In-Reply-To: <52bdcfdf44bcc4cd8a1a707b9c22f545fe0f1491.1582576372.git.jag.raman@oracle.com>
User-Agent: Mutt/1.13.3 (2020-01-12)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
> Add memory-listener object which is used to keep the view of the RAM
> in sync between QEMU and remote process.
> A MemoryListener is registered for system-memory AddressSpace. The
> listener sends SYNC_SYSMEM message to the remote process when memory
> listener commits the changes to memory, the remote process receives
> the message and processes it in the handler for SYNC_SYSMEM message.
>=20
> TODO: No need to create object for remote memory listener.
>=20
> Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
> Signed-off-by: John G Johnson <john.g.johnson@oracle.com>
> Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
> ---
>  Makefile.target                |   3 +
>  hw/proxy/memory-sync.c         | 212 +++++++++++++++++++++++++++++++++++=
++++++
>  hw/proxy/qemu-proxy.c          |   5 +
>  include/hw/proxy/memory-sync.h |  37 +++++++
>  include/hw/proxy/qemu-proxy.h  |   5 +
>  remote/remote-main.c           |  11 +++
>  6 files changed, 273 insertions(+)
>  create mode 100644 hw/proxy/memory-sync.c
>  create mode 100644 include/hw/proxy/memory-sync.h
>=20
> diff --git a/Makefile.target b/Makefile.target
> index cfd36c1..271d883 100644
> --- a/Makefile.target
> +++ b/Makefile.target
> @@ -127,6 +127,9 @@ obj-$(CONFIG_TCG) +=3D fpu/softfloat.o
>  obj-y +=3D target/$(TARGET_BASE_ARCH)/
>  obj-y +=3D disas.o
>  obj-$(call notempty,$(TARGET_XML_FILES)) +=3D gdbstub-xml.o
> +ifeq ($(TARGET_NAME)-$(CONFIG_MPQEMU)-$(CONFIG_USER_ONLY), x86_64-y-)
> +obj-$(CONFIG_MPQEMU) +=3D hw/proxy/memory-sync.o
> +endif
>  LIBS :=3D $(libs_cpu) $(LIBS)
> =20
>  obj-$(CONFIG_PLUGIN) +=3D plugins/
> diff --git a/hw/proxy/memory-sync.c b/hw/proxy/memory-sync.c
> new file mode 100644
> index 0000000..3edbb19
> --- /dev/null
> +++ b/hw/proxy/memory-sync.c
> @@ -0,0 +1,212 @@
> +/*
> + * Copyright =A9 2018, 2020 Oracle and/or its affiliates.
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or la=
ter.
> + * See the COPYING file in the top-level directory.
> + *
> + */
> +
> +#include <sys/types.h>
> +#include <stdio.h>
> +#include <string.h>
> +
> +#include "qemu/osdep.h"
> +#include "qemu/compiler.h"
> +#include "qemu/int128.h"
> +#include "qemu/range.h"
> +#include "exec/memory.h"
> +#include "exec/cpu-common.h"
> +#include "cpu.h"
> +#include "exec/ram_addr.h"
> +#include "exec/address-spaces.h"
> +#include "io/mpqemu-link.h"
> +#include "hw/proxy/memory-sync.h"
> +
> +static const TypeInfo remote_mem_sync_type_info =3D {
> +    .name          =3D TYPE_MEMORY_LISTENER,
> +    .parent        =3D TYPE_OBJECT,
> +    .instance_size =3D sizeof(RemoteMemSync),
> +};
> +
> +static void remote_mem_sync_register_types(void)
> +{
> +    type_register_static(&remote_mem_sync_type_info);
> +}
> +
> +type_init(remote_mem_sync_register_types)
> +
> +static void proxy_ml_begin(MemoryListener *listener)
> +{
> +    RemoteMemSync *sync =3D container_of(listener, RemoteMemSync, listen=
er);
> +    int mrs;
> +
> +    for (mrs =3D 0; mrs < sync->n_mr_sections; mrs++) {
> +        memory_region_unref(sync->mr_sections[mrs].mr);
> +    }
> +
> +    g_free(sync->mr_sections);
> +    sync->mr_sections =3D NULL;
> +    sync->n_mr_sections =3D 0;
> +}
> +
> +static int get_fd_from_hostaddr(uint64_t host, ram_addr_t *offset)
> +{
> +    MemoryRegion *mr;
> +    ram_addr_t off;
> +
> +    mr =3D memory_region_from_host((void *)(uintptr_t)host, &off);

Do you need to just check we found an 'mr' ?

> +    if (offset) {
> +        *offset =3D off;
> +    }
> +
> +    return memory_region_get_fd(mr);
> +}
> +
> +static bool proxy_mrs_can_merge(uint64_t host, uint64_t prev_host, size_=
t size)
> +{
> +    bool merge;
> +    int fd1, fd2;
> +
> +    fd1 =3D get_fd_from_hostaddr(host, NULL);
> +
> +    fd2 =3D get_fd_from_hostaddr(prev_host, NULL);
> +
> +    merge =3D (fd1 =3D=3D fd2);
> +
> +    merge &=3D ((prev_host + size) =3D=3D host);

It's interesting; I think the vhost code checks that the two mr's are
the same where you are checking for the same underlying fd - but I think
that's OK.
(I wonder if we need to check offset's within the fd's match up when
they're merged - since you added that offset feature in an earlier
patch?
That would also need checking in vhost_region_add_section)

> +    return merge;
> +}
> +
> +static void proxy_ml_region_addnop(MemoryListener *listener,
> +                                   MemoryRegionSection *section)
> +{
> +    RemoteMemSync *sync =3D container_of(listener, RemoteMemSync, listen=
er);
> +    bool need_add =3D true;
> +    uint64_t mrs_size, mrs_gpa, mrs_page;
> +    uintptr_t mrs_host;
> +    RAMBlock *mrs_rb;
> +    MemoryRegionSection *prev_sec;
> +
> +    if (!(memory_region_is_ram(section->mr) &&
> +          !memory_region_is_rom(section->mr))) {
> +        return;
> +    }
> +
> +    mrs_rb =3D section->mr->ram_block;
> +    mrs_page =3D (uint64_t)qemu_ram_pagesize(mrs_rb);
> +    mrs_size =3D int128_get64(section->size);
> +    mrs_gpa =3D section->offset_within_address_space;
> +    mrs_host =3D (uintptr_t)memory_region_get_ram_ptr(section->mr) +
> +               section->offset_within_region;
> +
> +    if (get_fd_from_hostaddr(mrs_host, NULL) <=3D 0) {
> +        return;
> +    }
> +
> +    mrs_host =3D mrs_host & ~(mrs_page - 1);
> +    mrs_gpa =3D mrs_gpa & ~(mrs_page - 1);
> +    mrs_size =3D ROUND_UP(mrs_size, mrs_page);

OK, just note the more complex code in vhost_region_add_section for page
aligning regions that are needed for postcopy; I think that would be the
same if you wanted to do postcopy with remote processes.

> +    if (sync->n_mr_sections) {
> +        prev_sec =3D sync->mr_sections + (sync->n_mr_sections - 1);
> +        uint64_t prev_gpa_start =3D prev_sec->offset_within_address_spac=
e;
> +        uint64_t prev_size =3D int128_get64(prev_sec->size);
> +        uint64_t prev_gpa_end   =3D range_get_last(prev_gpa_start, prev_=
size);
> +        uint64_t prev_host_start =3D
> +            (uintptr_t)memory_region_get_ram_ptr(prev_sec->mr) +
> +            prev_sec->offset_within_region;
> +        uint64_t prev_host_end =3D range_get_last(prev_host_start, prev_=
size);
> +
> +        if (mrs_gpa <=3D (prev_gpa_end + 1)) {
> +            if (mrs_gpa < prev_gpa_start) {
> +                assert(0);
> +            }

g_assert(mrs_gpa < prev_gpa_start);


> +            if ((section->mr =3D=3D prev_sec->mr) &&
> +                proxy_mrs_can_merge(mrs_host, prev_host_start,
> +                                    (mrs_gpa - prev_gpa_start))) {
> +                uint64_t max_end =3D MAX(prev_host_end, mrs_host + mrs_s=
ize);
> +                need_add =3D false;
> +                prev_sec->offset_within_address_space =3D
> +                    MIN(prev_gpa_start, mrs_gpa);
> +                prev_sec->offset_within_region =3D
> +                    MIN(prev_host_start, mrs_host) -
> +                    (uintptr_t)memory_region_get_ram_ptr(prev_sec->mr);
> +                prev_sec->size =3D int128_make64(max_end - MIN(prev_host=
_start,
> +                                                             mrs_host));
> +            }
> +        }
> +    }
> +
> +    if (need_add) {
> +        ++sync->n_mr_sections;
> +        sync->mr_sections =3D g_renew(MemoryRegionSection, sync->mr_sect=
ions,
> +                                    sync->n_mr_sections);
> +        sync->mr_sections[sync->n_mr_sections - 1] =3D *section;
> +        sync->mr_sections[sync->n_mr_sections - 1].fv =3D NULL;
> +        memory_region_ref(section->mr);
> +    }

I'd add some tracing in this function; it's a nightmare to debug when it
does something unexpected.

> +}
> +
> +static void proxy_ml_commit(MemoryListener *listener)
> +{
> +    RemoteMemSync *sync =3D container_of(listener, RemoteMemSync, listen=
er);
> +    MPQemuMsg msg;
> +    MemoryRegionSection section;
> +    ram_addr_t offset;
> +    uintptr_t host_addr;
> +    int region;
> +
> +    memset(&msg, 0, sizeof(MPQemuMsg));
> +
> +    msg.cmd =3D SYNC_SYSMEM;
> +    msg.bytestream =3D 0;
> +    msg.num_fds =3D sync->n_mr_sections;
> +    msg.size =3D sizeof(msg.data1);
> +    assert(msg.num_fds <=3D REMOTE_MAX_FDS);
> +
> +    for (region =3D 0; region < sync->n_mr_sections; region++) {
> +        section =3D sync->mr_sections[region];
> +        msg.data1.sync_sysmem.gpas[region] =3D
> +            section.offset_within_address_space;
> +        msg.data1.sync_sysmem.sizes[region] =3D int128_get64(section.siz=
e);
> +        host_addr =3D (uintptr_t)memory_region_get_ram_ptr(section.mr) +
> +                    section.offset_within_region;
> +        msg.fds[region] =3D get_fd_from_hostaddr(host_addr, &offset);

Since you already have section.mr you cna use memory_region_get_fd.

> +        msg.data1.sync_sysmem.offsets[region] =3D offset;
> +    }
> +    mpqemu_msg_send(&msg, sync->mpqemu_link->com);
> +}
> +
> +void deconfigure_memory_sync(RemoteMemSync *sync)
> +{
> +    memory_listener_unregister(&sync->listener);
> +}
> +
> +/*
> + * TODO: Memory Sync need not be instantianted once per every proxy devi=
ce.
> + *       All remote devices are going to get the exact same updates at t=
he
> + *       same time. It therefore makes sense to have a broadcast model.
> + *
> + *       Broadcast model would involve running the MemorySync object in =
a
> + *       thread. MemorySync would contain a list of mpqemu-link objects
> + *       that need notification. proxy_ml_commit() could send the same
> + *       message to all the links at the same time.
> + */
> +void configure_memory_sync(RemoteMemSync *sync, MPQemuLinkState *mpqemu_=
link)
> +{
> +    sync->n_mr_sections =3D 0;
> +    sync->mr_sections =3D NULL;
> +
> +    sync->mpqemu_link =3D mpqemu_link;
> +
> +    sync->listener.begin =3D proxy_ml_begin;
> +    sync->listener.commit =3D proxy_ml_commit;
> +    sync->listener.region_add =3D proxy_ml_region_addnop;
> +    sync->listener.region_nop =3D proxy_ml_region_addnop;
> +    sync->listener.priority =3D 10;
> +
> +    memory_listener_register(&sync->listener, &address_space_memory);
> +}
> diff --git a/hw/proxy/qemu-proxy.c b/hw/proxy/qemu-proxy.c
> index b17d9bb..d3a9d38 100644
> --- a/hw/proxy/qemu-proxy.c
> +++ b/hw/proxy/qemu-proxy.c
> @@ -16,6 +16,8 @@
>  #include "qapi/qmp/qjson.h"
>  #include "qapi/qmp/qstring.h"
>  #include "hw/proxy/qemu-proxy.h"
> +#include "hw/proxy/memory-sync.h"
> +#include "qom/object.h"
> =20
>  static void pci_proxy_dev_realize(PCIDevice *dev, Error **errp);
> =20
> @@ -243,6 +245,8 @@ static void init_proxy(PCIDevice *dev, char *command,=
 char *exec_name,
> =20
>      mpqemu_init_channel(pdev->mpqemu_link, &pdev->mpqemu_link->com,
>                          pdev->socket);
> +
> +    configure_memory_sync(pdev->sync, pdev->mpqemu_link);
>  }
> =20
>  static void pci_proxy_dev_realize(PCIDevice *device, Error **errp)
> @@ -261,6 +265,7 @@ static void pci_proxy_dev_realize(PCIDevice *device, =
Error **errp)
>      dev->set_proxy_sock =3D set_proxy_sock;
>      dev->get_proxy_sock =3D get_proxy_sock;
>      dev->init_proxy =3D init_proxy;
> +    dev->sync =3D REMOTE_MEM_SYNC(object_new(TYPE_MEMORY_LISTENER));
>  }
> =20
>  static void send_bar_access_msg(PCIProxyDev *dev, MemoryRegion *mr,
> diff --git a/include/hw/proxy/memory-sync.h b/include/hw/proxy/memory-syn=
c.h
> new file mode 100644
> index 0000000..d8329c9
> --- /dev/null
> +++ b/include/hw/proxy/memory-sync.h
> @@ -0,0 +1,37 @@
> +/*
> + * Copyright =A9 2018, 2020 Oracle and/or its affiliates.
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or la=
ter.
> + * See the COPYING file in the top-level directory.
> + *
> + */
> +
> +#ifndef MEMORY_SYNC_H
> +#define MEMORY_SYNC_H
> +
> +#include <sys/types.h>
> +
> +#include "qemu/osdep.h"
> +#include "qom/object.h"
> +#include "exec/memory.h"
> +#include "io/mpqemu-link.h"
> +
> +#define TYPE_MEMORY_LISTENER "memory-listener"
> +#define REMOTE_MEM_SYNC(obj) \
> +            OBJECT_CHECK(RemoteMemSync, (obj), TYPE_MEMORY_LISTENER)
> +
> +typedef struct RemoteMemSync {
> +    Object obj;
> +
> +    MemoryListener listener;
> +
> +    int n_mr_sections;
> +    MemoryRegionSection *mr_sections;
> +
> +    MPQemuLinkState *mpqemu_link;
> +} RemoteMemSync;
> +
> +void configure_memory_sync(RemoteMemSync *sync, MPQemuLinkState *mpqemu_=
link);
> +void deconfigure_memory_sync(RemoteMemSync *sync);
> +
> +#endif
> diff --git a/include/hw/proxy/qemu-proxy.h b/include/hw/proxy/qemu-proxy.=
h
> index 44e370e..c93ffe3 100644
> --- a/include/hw/proxy/qemu-proxy.h
> +++ b/include/hw/proxy/qemu-proxy.h
> @@ -10,6 +10,7 @@
>  #define QEMU_PROXY_H
> =20
>  #include "io/mpqemu-link.h"
> +#include "hw/proxy/memory-sync.h"
> =20
>  #define TYPE_PCI_PROXY_DEV "pci-proxy-dev"
> =20
> @@ -37,8 +38,12 @@ extern const MemoryRegionOps proxy_default_ops;
>  struct PCIProxyDev {
>      PCIDevice parent_dev;
> =20
> +    int n_mr_sections;
> +    MemoryRegionSection *mr_sections;
> +
>      MPQemuLinkState *mpqemu_link;
> =20
> +    RemoteMemSync *sync;
>      pid_t remote_pid;
>      int socket;
> =20
> diff --git a/remote/remote-main.c b/remote/remote-main.c
> index acd8daf..9512a3b 100644
> --- a/remote/remote-main.c
> +++ b/remote/remote-main.c
> @@ -34,6 +34,7 @@
>  #include "block/block.h"
>  #include "exec/ramlist.h"
>  #include "exec/memattrs.h"
> +#include "exec/address-spaces.h"
> =20
>  static MPQemuLinkState *mpqemu_link;
>  PCIDevice *remote_pci_dev;
> @@ -161,6 +162,16 @@ static void process_msg(GIOCondition cond, MPQemuCha=
nnel *chan)
>              goto finalize_loop;
>          }
>          break;
> +    case SYNC_SYSMEM:
> +        /*
> +         * TODO: ensure no active DMA is happening when
> +         * sysmem is being updated

In practice this turns out to be hard!

Dave

> +         */
> +        remote_sysmem_reconfig(msg, &err);
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


