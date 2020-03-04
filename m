Return-Path: <SRS0=3KIA=4V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E37E1C3F2D1
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2020 19:36:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B85320870
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2020 19:36:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Xldx+47h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B85320870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38880 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9Zoc-0004jQ-RX
	for qemu-devel@archiver.kernel.org; Wed, 04 Mar 2020 14:36:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45770)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jag.raman@oracle.com>) id 1j9Znk-0004IV-6F
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 14:35:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jag.raman@oracle.com>) id 1j9Znh-0005Wj-Jh
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 14:35:27 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:42912)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jag.raman@oracle.com>)
 id 1j9Znh-0005Q1-92
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 14:35:25 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
 by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 024JWv9X010026;
 Wed, 4 Mar 2020 19:35:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=gc41JBEo8gM0JRmLV3N52vdHf7VYQQKuX5/mLrlqips=;
 b=Xldx+47hRMKDelHW2zhbGyXzTmSLxgNrliSntco8XdrcBYXZa1tZRG9UIzjvBTiFZEjV
 pz0MEhFt8LHlhA02HSRtV71R5c6Q3rb46Vpsn67UEGMv2wAgrF/T3dSm2VOhxhYpQ1JY
 8RJDi00uZ/WaTrJECxHH5oncD528yUy7PM0YwrS5PTFHUf0RAmKI9gDcWv5LtrCw8aXI
 3auY+KCU+VF3X6HNpildf89kFi3IkMJuVasRA7XoklmMLtLzy6y3JiPZR/EPyPdtnHW1
 yh3UX0FtuKJ6srU8x250zuveSsDLSBGwZWec15UxbssL2LtsojpPY+tu7YxXNJYjUJiJ Lg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
 by userp2120.oracle.com with ESMTP id 2yghn3c9fc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 04 Mar 2020 19:35:14 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
 by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 024JQmxh117131;
 Wed, 4 Mar 2020 19:35:13 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
 by aserp3020.oracle.com with ESMTP id 2yg1rs0hgd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 04 Mar 2020 19:35:13 +0000
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
 by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 024JZBeM015697;
 Wed, 4 Mar 2020 19:35:11 GMT
Received: from [10.152.34.2] (/10.152.34.2)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Wed, 04 Mar 2020 11:35:11 -0800
Subject: Re: [PATCH v5 16/50] multi-process: Synchronize remote memory
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
References: <cover.1582576372.git.jag.raman@oracle.com>
 <52bdcfdf44bcc4cd8a1a707b9c22f545fe0f1491.1582576372.git.jag.raman@oracle.com>
 <20200304115323.GD4104@work-vm>
From: Jag Raman <jag.raman@oracle.com>
Organization: Oracle Corporation
Message-ID: <d8e11ec7-cae9-a7e9-76d4-6df09e6f836e@oracle.com>
Date: Wed, 4 Mar 2020 14:35:08 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200304115323.GD4104@work-vm>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9550
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 mlxlogscore=999
 suspectscore=2 malwarescore=0 adultscore=0 spamscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2003040128
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9550
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 phishscore=0 spamscore=0
 impostorscore=0 mlxscore=0 adultscore=0 mlxlogscore=999 lowpriorityscore=0
 priorityscore=1501 bulkscore=0 clxscore=1015 suspectscore=2
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2003040128
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by userp2120.oracle.com id
 024JWv9X010026
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
X-Received-From: 156.151.31.85
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



On 3/4/2020 6:53 AM, Dr. David Alan Gilbert wrote:
> * Jagannathan Raman (jag.raman@oracle.com) wrote:
>> Add memory-listener object which is used to keep the view of the RAM
>> in sync between QEMU and remote process.
>> A MemoryListener is registered for system-memory AddressSpace. The
>> listener sends SYNC_SYSMEM message to the remote process when memory
>> listener commits the changes to memory, the remote process receives
>> the message and processes it in the handler for SYNC_SYSMEM message.
>>
>> TODO: No need to create object for remote memory listener.
>>
>> Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
>> Signed-off-by: John G Johnson <john.g.johnson@oracle.com>
>> Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
>> ---
>>   Makefile.target                |   3 +
>>   hw/proxy/memory-sync.c         | 212 +++++++++++++++++++++++++++++++=
++++++++++
>>   hw/proxy/qemu-proxy.c          |   5 +
>>   include/hw/proxy/memory-sync.h |  37 +++++++
>>   include/hw/proxy/qemu-proxy.h  |   5 +
>>   remote/remote-main.c           |  11 +++
>>   6 files changed, 273 insertions(+)
>>   create mode 100644 hw/proxy/memory-sync.c
>>   create mode 100644 include/hw/proxy/memory-sync.h
>>
>> diff --git a/Makefile.target b/Makefile.target
>> index cfd36c1..271d883 100644
>> --- a/Makefile.target
>> +++ b/Makefile.target
>> @@ -127,6 +127,9 @@ obj-$(CONFIG_TCG) +=3D fpu/softfloat.o
>>   obj-y +=3D target/$(TARGET_BASE_ARCH)/
>>   obj-y +=3D disas.o
>>   obj-$(call notempty,$(TARGET_XML_FILES)) +=3D gdbstub-xml.o
>> +ifeq ($(TARGET_NAME)-$(CONFIG_MPQEMU)-$(CONFIG_USER_ONLY), x86_64-y-)
>> +obj-$(CONFIG_MPQEMU) +=3D hw/proxy/memory-sync.o
>> +endif
>>   LIBS :=3D $(libs_cpu) $(LIBS)
>>  =20
>>   obj-$(CONFIG_PLUGIN) +=3D plugins/
>> diff --git a/hw/proxy/memory-sync.c b/hw/proxy/memory-sync.c
>> new file mode 100644
>> index 0000000..3edbb19
>> --- /dev/null
>> +++ b/hw/proxy/memory-sync.c
>> @@ -0,0 +1,212 @@
>> +/*
>> + * Copyright =C2=A9 2018, 2020 Oracle and/or its affiliates.
>> + *
>> + * This work is licensed under the terms of the GNU GPL, version 2 or=
 later.
>> + * See the COPYING file in the top-level directory.
>> + *
>> + */
>> +
>> +#include <sys/types.h>
>> +#include <stdio.h>
>> +#include <string.h>
>> +
>> +#include "qemu/osdep.h"
>> +#include "qemu/compiler.h"
>> +#include "qemu/int128.h"
>> +#include "qemu/range.h"
>> +#include "exec/memory.h"
>> +#include "exec/cpu-common.h"
>> +#include "cpu.h"
>> +#include "exec/ram_addr.h"
>> +#include "exec/address-spaces.h"
>> +#include "io/mpqemu-link.h"
>> +#include "hw/proxy/memory-sync.h"
>> +
>> +static const TypeInfo remote_mem_sync_type_info =3D {
>> +    .name          =3D TYPE_MEMORY_LISTENER,
>> +    .parent        =3D TYPE_OBJECT,
>> +    .instance_size =3D sizeof(RemoteMemSync),
>> +};
>> +
>> +static void remote_mem_sync_register_types(void)
>> +{
>> +    type_register_static(&remote_mem_sync_type_info);
>> +}
>> +
>> +type_init(remote_mem_sync_register_types)
>> +
>> +static void proxy_ml_begin(MemoryListener *listener)
>> +{
>> +    RemoteMemSync *sync =3D container_of(listener, RemoteMemSync, lis=
tener);
>> +    int mrs;
>> +
>> +    for (mrs =3D 0; mrs < sync->n_mr_sections; mrs++) {
>> +        memory_region_unref(sync->mr_sections[mrs].mr);
>> +    }
>> +
>> +    g_free(sync->mr_sections);
>> +    sync->mr_sections =3D NULL;
>> +    sync->n_mr_sections =3D 0;
>> +}
>> +
>> +static int get_fd_from_hostaddr(uint64_t host, ram_addr_t *offset)
>> +{
>> +    MemoryRegion *mr;
>> +    ram_addr_t off;
>> +
>> +    mr =3D memory_region_from_host((void *)(uintptr_t)host, &off);
>=20
> Do you need to just check we found an 'mr' ?

OK, we'll add this check.

>=20
>> +    if (offset) {
>> +        *offset =3D off;
>> +    }
>> +
>> +    return memory_region_get_fd(mr);
>> +}
>> +
>> +static bool proxy_mrs_can_merge(uint64_t host, uint64_t prev_host, si=
ze_t size)
>> +{
>> +    bool merge;
>> +    int fd1, fd2;
>> +
>> +    fd1 =3D get_fd_from_hostaddr(host, NULL);
>> +
>> +    fd2 =3D get_fd_from_hostaddr(prev_host, NULL);
>> +
>> +    merge =3D (fd1 =3D=3D fd2);
>> +
>> +    merge &=3D ((prev_host + size) =3D=3D host);
>=20
> It's interesting; I think the vhost code checks that the two mr's are
> the same where you are checking for the same underlying fd - but I thin=
k
> that's OK.
> (I wonder if we need to check offset's within the fd's match up when
> they're merged - since you added that offset feature in an earlier
> patch?
> That would also need checking in vhost_region_add_section)

If the fds are the same, and the subsequent check ((prev_host + size) =3D=
=3D
host) passes, then I believe the offsets would match as well.

>=20
>> +    return merge;
>> +}
>> +
>> +static void proxy_ml_region_addnop(MemoryListener *listener,
>> +                                   MemoryRegionSection *section)
>> +{
>> +    RemoteMemSync *sync =3D container_of(listener, RemoteMemSync, lis=
tener);
>> +    bool need_add =3D true;
>> +    uint64_t mrs_size, mrs_gpa, mrs_page;
>> +    uintptr_t mrs_host;
>> +    RAMBlock *mrs_rb;
>> +    MemoryRegionSection *prev_sec;
>> +
>> +    if (!(memory_region_is_ram(section->mr) &&
>> +          !memory_region_is_rom(section->mr))) {
>> +        return;
>> +    }
>> +
>> +    mrs_rb =3D section->mr->ram_block;
>> +    mrs_page =3D (uint64_t)qemu_ram_pagesize(mrs_rb);
>> +    mrs_size =3D int128_get64(section->size);
>> +    mrs_gpa =3D section->offset_within_address_space;
>> +    mrs_host =3D (uintptr_t)memory_region_get_ram_ptr(section->mr) +
>> +               section->offset_within_region;
>> +
>> +    if (get_fd_from_hostaddr(mrs_host, NULL) <=3D 0) {
>> +        return;
>> +    }
>> +
>> +    mrs_host =3D mrs_host & ~(mrs_page - 1);
>> +    mrs_gpa =3D mrs_gpa & ~(mrs_page - 1);
>> +    mrs_size =3D ROUND_UP(mrs_size, mrs_page);
>=20
> OK, just note the more complex code in vhost_region_add_section for pag=
e
> aligning regions that are needed for postcopy; I think that would be th=
e
> same if you wanted to do postcopy with remote processes.

Since mmap requires the addresses to be aligned with a page boundry, we
added these checks. We are essentially doing the same with alignage as
compared with vhost user. So we should be compliant with postcopy I
believe.

>=20
>> +    if (sync->n_mr_sections) {
>> +        prev_sec =3D sync->mr_sections + (sync->n_mr_sections - 1);
>> +        uint64_t prev_gpa_start =3D prev_sec->offset_within_address_s=
pace;
>> +        uint64_t prev_size =3D int128_get64(prev_sec->size);
>> +        uint64_t prev_gpa_end   =3D range_get_last(prev_gpa_start, pr=
ev_size);
>> +        uint64_t prev_host_start =3D
>> +            (uintptr_t)memory_region_get_ram_ptr(prev_sec->mr) +
>> +            prev_sec->offset_within_region;
>> +        uint64_t prev_host_end =3D range_get_last(prev_host_start, pr=
ev_size);
>> +
>> +        if (mrs_gpa <=3D (prev_gpa_end + 1)) {
>> +            if (mrs_gpa < prev_gpa_start) {
>> +                assert(0);
>> +            }
>=20
> g_assert(mrs_gpa < prev_gpa_start);

Thank you, we'll update the above check with the version you proposed.

>=20
>=20
>> +            if ((section->mr =3D=3D prev_sec->mr) &&
>> +                proxy_mrs_can_merge(mrs_host, prev_host_start,
>> +                                    (mrs_gpa - prev_gpa_start))) {
>> +                uint64_t max_end =3D MAX(prev_host_end, mrs_host + mr=
s_size);
>> +                need_add =3D false;
>> +                prev_sec->offset_within_address_space =3D
>> +                    MIN(prev_gpa_start, mrs_gpa);
>> +                prev_sec->offset_within_region =3D
>> +                    MIN(prev_host_start, mrs_host) -
>> +                    (uintptr_t)memory_region_get_ram_ptr(prev_sec->mr=
);
>> +                prev_sec->size =3D int128_make64(max_end - MIN(prev_h=
ost_start,
>> +                                                             mrs_host=
));
>> +            }
>> +        }
>> +    }
>> +
>> +    if (need_add) {
>> +        ++sync->n_mr_sections;
>> +        sync->mr_sections =3D g_renew(MemoryRegionSection, sync->mr_s=
ections,
>> +                                    sync->n_mr_sections);
>> +        sync->mr_sections[sync->n_mr_sections - 1] =3D *section;
>> +        sync->mr_sections[sync->n_mr_sections - 1].fv =3D NULL;
>> +        memory_region_ref(section->mr);
>> +    }
>=20
> I'd add some tracing in this function; it's a nightmare to debug when i=
t
> does something unexpected.

Thank you, we'll add the tracing.

>=20
>> +}
>> +
>> +static void proxy_ml_commit(MemoryListener *listener)
>> +{
>> +    RemoteMemSync *sync =3D container_of(listener, RemoteMemSync, lis=
tener);
>> +    MPQemuMsg msg;
>> +    MemoryRegionSection section;
>> +    ram_addr_t offset;
>> +    uintptr_t host_addr;
>> +    int region;
>> +
>> +    memset(&msg, 0, sizeof(MPQemuMsg));
>> +
>> +    msg.cmd =3D SYNC_SYSMEM;
>> +    msg.bytestream =3D 0;
>> +    msg.num_fds =3D sync->n_mr_sections;
>> +    msg.size =3D sizeof(msg.data1);
>> +    assert(msg.num_fds <=3D REMOTE_MAX_FDS);
>> +
>> +    for (region =3D 0; region < sync->n_mr_sections; region++) {
>> +        section =3D sync->mr_sections[region];
>> +        msg.data1.sync_sysmem.gpas[region] =3D
>> +            section.offset_within_address_space;
>> +        msg.data1.sync_sysmem.sizes[region] =3D int128_get64(section.=
size);
>> +        host_addr =3D (uintptr_t)memory_region_get_ram_ptr(section.mr=
) +
>> +                    section.offset_within_region;
>> +        msg.fds[region] =3D get_fd_from_hostaddr(host_addr, &offset);
>=20
> Since you already have section.mr you cna use memory_region_get_fd.

OK.

Thank you!
--
Jag

>=20
>> +        msg.data1.sync_sysmem.offsets[region] =3D offset;
>> +    }
>> +    mpqemu_msg_send(&msg, sync->mpqemu_link->com);
>> +}
>> +
>> +void deconfigure_memory_sync(RemoteMemSync *sync)
>> +{
>> +    memory_listener_unregister(&sync->listener);
>> +}
>> +
>> +/*
>> + * TODO: Memory Sync need not be instantianted once per every proxy d=
evice.
>> + *       All remote devices are going to get the exact same updates a=
t the
>> + *       same time. It therefore makes sense to have a broadcast mode=
l.
>> + *
>> + *       Broadcast model would involve running the MemorySync object =
in a
>> + *       thread. MemorySync would contain a list of mpqemu-link objec=
ts
>> + *       that need notification. proxy_ml_commit() could send the sam=
e
>> + *       message to all the links at the same time.
>> + */
>> +void configure_memory_sync(RemoteMemSync *sync, MPQemuLinkState *mpqe=
mu_link)
>> +{
>> +    sync->n_mr_sections =3D 0;
>> +    sync->mr_sections =3D NULL;
>> +
>> +    sync->mpqemu_link =3D mpqemu_link;
>> +
>> +    sync->listener.begin =3D proxy_ml_begin;
>> +    sync->listener.commit =3D proxy_ml_commit;
>> +    sync->listener.region_add =3D proxy_ml_region_addnop;
>> +    sync->listener.region_nop =3D proxy_ml_region_addnop;
>> +    sync->listener.priority =3D 10;
>> +
>> +    memory_listener_register(&sync->listener, &address_space_memory);
>> +}
>> diff --git a/hw/proxy/qemu-proxy.c b/hw/proxy/qemu-proxy.c
>> index b17d9bb..d3a9d38 100644
>> --- a/hw/proxy/qemu-proxy.c
>> +++ b/hw/proxy/qemu-proxy.c
>> @@ -16,6 +16,8 @@
>>   #include "qapi/qmp/qjson.h"
>>   #include "qapi/qmp/qstring.h"
>>   #include "hw/proxy/qemu-proxy.h"
>> +#include "hw/proxy/memory-sync.h"
>> +#include "qom/object.h"
>>  =20
>>   static void pci_proxy_dev_realize(PCIDevice *dev, Error **errp);
>>  =20
>> @@ -243,6 +245,8 @@ static void init_proxy(PCIDevice *dev, char *comma=
nd, char *exec_name,
>>  =20
>>       mpqemu_init_channel(pdev->mpqemu_link, &pdev->mpqemu_link->com,
>>                           pdev->socket);
>> +
>> +    configure_memory_sync(pdev->sync, pdev->mpqemu_link);
>>   }
>>  =20
>>   static void pci_proxy_dev_realize(PCIDevice *device, Error **errp)
>> @@ -261,6 +265,7 @@ static void pci_proxy_dev_realize(PCIDevice *devic=
e, Error **errp)
>>       dev->set_proxy_sock =3D set_proxy_sock;
>>       dev->get_proxy_sock =3D get_proxy_sock;
>>       dev->init_proxy =3D init_proxy;
>> +    dev->sync =3D REMOTE_MEM_SYNC(object_new(TYPE_MEMORY_LISTENER));
>>   }
>>  =20
>>   static void send_bar_access_msg(PCIProxyDev *dev, MemoryRegion *mr,
>> diff --git a/include/hw/proxy/memory-sync.h b/include/hw/proxy/memory-=
sync.h
>> new file mode 100644
>> index 0000000..d8329c9
>> --- /dev/null
>> +++ b/include/hw/proxy/memory-sync.h
>> @@ -0,0 +1,37 @@
>> +/*
>> + * Copyright =C2=A9 2018, 2020 Oracle and/or its affiliates.
>> + *
>> + * This work is licensed under the terms of the GNU GPL, version 2 or=
 later.
>> + * See the COPYING file in the top-level directory.
>> + *
>> + */
>> +
>> +#ifndef MEMORY_SYNC_H
>> +#define MEMORY_SYNC_H
>> +
>> +#include <sys/types.h>
>> +
>> +#include "qemu/osdep.h"
>> +#include "qom/object.h"
>> +#include "exec/memory.h"
>> +#include "io/mpqemu-link.h"
>> +
>> +#define TYPE_MEMORY_LISTENER "memory-listener"
>> +#define REMOTE_MEM_SYNC(obj) \
>> +            OBJECT_CHECK(RemoteMemSync, (obj), TYPE_MEMORY_LISTENER)
>> +
>> +typedef struct RemoteMemSync {
>> +    Object obj;
>> +
>> +    MemoryListener listener;
>> +
>> +    int n_mr_sections;
>> +    MemoryRegionSection *mr_sections;
>> +
>> +    MPQemuLinkState *mpqemu_link;
>> +} RemoteMemSync;
>> +
>> +void configure_memory_sync(RemoteMemSync *sync, MPQemuLinkState *mpqe=
mu_link);
>> +void deconfigure_memory_sync(RemoteMemSync *sync);
>> +
>> +#endif
>> diff --git a/include/hw/proxy/qemu-proxy.h b/include/hw/proxy/qemu-pro=
xy.h
>> index 44e370e..c93ffe3 100644
>> --- a/include/hw/proxy/qemu-proxy.h
>> +++ b/include/hw/proxy/qemu-proxy.h
>> @@ -10,6 +10,7 @@
>>   #define QEMU_PROXY_H
>>  =20
>>   #include "io/mpqemu-link.h"
>> +#include "hw/proxy/memory-sync.h"
>>  =20
>>   #define TYPE_PCI_PROXY_DEV "pci-proxy-dev"
>>  =20
>> @@ -37,8 +38,12 @@ extern const MemoryRegionOps proxy_default_ops;
>>   struct PCIProxyDev {
>>       PCIDevice parent_dev;
>>  =20
>> +    int n_mr_sections;
>> +    MemoryRegionSection *mr_sections;
>> +
>>       MPQemuLinkState *mpqemu_link;
>>  =20
>> +    RemoteMemSync *sync;
>>       pid_t remote_pid;
>>       int socket;
>>  =20
>> diff --git a/remote/remote-main.c b/remote/remote-main.c
>> index acd8daf..9512a3b 100644
>> --- a/remote/remote-main.c
>> +++ b/remote/remote-main.c
>> @@ -34,6 +34,7 @@
>>   #include "block/block.h"
>>   #include "exec/ramlist.h"
>>   #include "exec/memattrs.h"
>> +#include "exec/address-spaces.h"
>>  =20
>>   static MPQemuLinkState *mpqemu_link;
>>   PCIDevice *remote_pci_dev;
>> @@ -161,6 +162,16 @@ static void process_msg(GIOCondition cond, MPQemu=
Channel *chan)
>>               goto finalize_loop;
>>           }
>>           break;
>> +    case SYNC_SYSMEM:
>> +        /*
>> +         * TODO: ensure no active DMA is happening when
>> +         * sysmem is being updated
>=20
> In practice this turns out to be hard!
>=20
> Dave
>=20
>> +         */
>> +        remote_sysmem_reconfig(msg, &err);
>> +        if (err) {
>> +            goto finalize_loop;
>> +        }
>> +        break;
>>       default:
>>           error_setg(&err, "Unknown command");
>>           goto finalize_loop;
>> --=20
>> 1.8.3.1
>>
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
>=20

