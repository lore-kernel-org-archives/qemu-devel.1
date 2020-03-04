Return-Path: <SRS0=3KIA=4V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D96B9C3F2CE
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2020 19:06:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 97C112146E
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2020 19:06:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="st7zmvbf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97C112146E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38542 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9ZLc-0005wf-Rj
	for qemu-devel@archiver.kernel.org; Wed, 04 Mar 2020 14:06:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39132)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jag.raman@oracle.com>) id 1j9ZKm-0004kf-0F
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 14:05:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jag.raman@oracle.com>) id 1j9ZKk-0003ko-1l
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 14:05:31 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:38088)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jag.raman@oracle.com>)
 id 1j9ZKj-0003g3-MQ
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 14:05:29 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
 by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 024Ix0Fn092175;
 Wed, 4 Mar 2020 19:05:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=nt8b0oo5ucFb2b7R/x4jHifEPtJSjM2W4/CURo+u2w4=;
 b=st7zmvbfONoxNe1enU0wb1qCdAHCTt1rQFrcvVIO9og54Jg5nc5hkIFu5vEYX28+ZxJv
 2z42xLvCLeviryWjMQNUm+sGjr4JIM4d6kh1DPOt2bBc/cglG4s1PRncfYj7XoFGUjSt
 o/Uo0jqunixnde2+6ti04AmYTlZXf80uZBiblF8bYIRYc+BQFsJyeb1sDJ3HPQ6ALiS2
 P3q5ZKJhrw+54dzzaY+BkFqa/Jgy27i7vd0+smoq2AoOJnNyOxveaQzJ64SFLu2MHs7F
 jHTAgc/l/kHkV2oQfNBNL9KGVmTbTn0Kh3SKt2UYcGKRk8nlqgsR0yvId58Fy0mmEnPz MA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
 by userp2120.oracle.com with ESMTP id 2yghn3c4kd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 04 Mar 2020 19:05:20 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
 by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 024IuWeE086444;
 Wed, 4 Mar 2020 19:05:19 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
 by userp3020.oracle.com with ESMTP id 2yg1p882bq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 04 Mar 2020 19:05:19 +0000
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
 by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 024J5HPH026604;
 Wed, 4 Mar 2020 19:05:17 GMT
Received: from [10.152.34.2] (/10.152.34.2)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Wed, 04 Mar 2020 11:05:16 -0800
Subject: Re: [PATCH v5 15/50] multi-process: PCI BAR read/write handling for
 proxy & remote endpoints
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
References: <cover.1582576372.git.jag.raman@oracle.com>
 <28d7426190d8a88c7b93f5f5daf8cd1c6e017a76.1582576372.git.jag.raman@oracle.com>
 <20200304104715.GC4104@work-vm>
From: Jag Raman <jag.raman@oracle.com>
Organization: Oracle Corporation
Message-ID: <24c68722-a82d-7de9-41dd-866393917113@oracle.com>
Date: Wed, 4 Mar 2020 14:05:14 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200304104715.GC4104@work-vm>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9550
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 malwarescore=0
 mlxlogscore=999 mlxscore=0 spamscore=0 adultscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2003040126
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9550
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 phishscore=0 spamscore=0
 impostorscore=0 mlxscore=0 adultscore=0 mlxlogscore=999 lowpriorityscore=0
 priorityscore=1501 bulkscore=0 clxscore=1015 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2003040126
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



On 3/4/2020 5:47 AM, Dr. David Alan Gilbert wrote:
> * Jagannathan Raman (jag.raman@oracle.com) wrote:
>> Proxy device object implements handler for PCI BAR writes and reads. The handler
>> uses BAR_WRITE/BAR_READ message to communicate to the remote process with the BAR address and
>> value to be written/read.
>> The remote process implements handler for BAR_WRITE/BAR_READ message.
>>
>> Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
>> Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
>> Signed-off-by: John G Johnson <john.g.johnson@oracle.com>
>> ---
>>   hw/proxy/qemu-proxy.c         | 65 ++++++++++++++++++++++++++++++++++++++
>>   include/hw/proxy/qemu-proxy.h | 22 +++++++++++--
>>   include/io/mpqemu-link.h      | 12 +++++++
>>   remote/remote-main.c          | 73 +++++++++++++++++++++++++++++++++++++++++++
>>   4 files changed, 170 insertions(+), 2 deletions(-)
>>
>> diff --git a/hw/proxy/qemu-proxy.c b/hw/proxy/qemu-proxy.c
>> index d792e86..b17d9bb 100644
>> --- a/hw/proxy/qemu-proxy.c
>> +++ b/hw/proxy/qemu-proxy.c
>> @@ -262,3 +262,68 @@ static void pci_proxy_dev_realize(PCIDevice *device, Error **errp)
>>       dev->get_proxy_sock = get_proxy_sock;
>>       dev->init_proxy = init_proxy;
>>   }
>> +
>> +static void send_bar_access_msg(PCIProxyDev *dev, MemoryRegion *mr,
>> +                                bool write, hwaddr addr, uint64_t *val,
>> +                                unsigned size, bool memory)
>> +{
>> +    MPQemuLinkState *mpqemu_link = dev->mpqemu_link;
>> +    MPQemuMsg msg;
>> +    int wait;
>> +
>> +    memset(&msg, 0, sizeof(MPQemuMsg));
>> +
>> +    msg.bytestream = 0;
>> +    msg.size = sizeof(msg.data1);
>> +    msg.data1.bar_access.addr = mr->addr + addr;
>> +    msg.data1.bar_access.size = size;
>> +    msg.data1.bar_access.memory = memory;
>> +
>> +    if (write) {
>> +        msg.cmd = BAR_WRITE;
>> +        msg.data1.bar_access.val = *val;
>> +    } else {
>> +        wait = GET_REMOTE_WAIT;
>> +
>> +        msg.cmd = BAR_READ;
>> +        msg.num_fds = 1;
>> +        msg.fds[0] = wait;
>> +    }
>> +
>> +    mpqemu_msg_send(&msg, mpqemu_link->com);
>> +
>> +    if (!write) {
>> +        *val = wait_for_remote(wait);
>> +        PUT_REMOTE_WAIT(wait);
>> +    }
>> +}
>> +
>> +void proxy_default_bar_write(void *opaque, hwaddr addr, uint64_t val,
>> +                             unsigned size)
>> +{
>> +    ProxyMemoryRegion *pmr = opaque;
>> +
>> +    send_bar_access_msg(pmr->dev, &pmr->mr, true, addr, &val, size,
>> +                        pmr->memory);
>> +}
>> +
>> +uint64_t proxy_default_bar_read(void *opaque, hwaddr addr, unsigned size)
>> +{
>> +    ProxyMemoryRegion *pmr = opaque;
>> +    uint64_t val;
>> +
>> +    send_bar_access_msg(pmr->dev, &pmr->mr, false, addr, &val, size,
>> +                        pmr->memory);
>> +
>> +     return val;
>> +}
>> +
>> +const MemoryRegionOps proxy_default_ops = {
>> +    .read = proxy_default_bar_read,
>> +    .write = proxy_default_bar_write,
>> +    .endianness = DEVICE_NATIVE_ENDIAN,
>> +    .impl = {
>> +        .min_access_size = 1,
>> +        .max_access_size = 1,
>> +    },
>> +};
>> diff --git a/include/hw/proxy/qemu-proxy.h b/include/hw/proxy/qemu-proxy.h
>> index 29fa2e9..44e370e 100644
>> --- a/include/hw/proxy/qemu-proxy.h
>> +++ b/include/hw/proxy/qemu-proxy.h
>> @@ -22,7 +22,19 @@
>>   #define PCI_PROXY_DEV_GET_CLASS(obj) \
>>               OBJECT_GET_CLASS(PCIProxyDevClass, (obj), TYPE_PCI_PROXY_DEV)
>>   
>> -typedef struct PCIProxyDev {
>> +typedef struct PCIProxyDev PCIProxyDev;
>> +
>> +typedef struct ProxyMemoryRegion {
>> +    PCIProxyDev *dev;
>> +    MemoryRegion mr;
>> +    bool memory;
>> +    bool present;
>> +    uint8_t type;
>> +} ProxyMemoryRegion;
>> +
>> +extern const MemoryRegionOps proxy_default_ops;
>> +
>> +struct PCIProxyDev {
>>       PCIDevice parent_dev;
>>   
>>       MPQemuLinkState *mpqemu_link;
>> @@ -41,7 +53,8 @@ typedef struct PCIProxyDev {
>>       void (*init_proxy) (PCIDevice *dev, char *command, char *exec_name,
>>                           bool need_spawn, Error **errp);
>>   
>> -} PCIProxyDev;
>> +    ProxyMemoryRegion region[PCI_NUM_REGIONS];
>> +};
>>   
>>   typedef struct PCIProxyDevClass {
>>       PCIDeviceClass parent_class;
>> @@ -51,4 +64,9 @@ typedef struct PCIProxyDevClass {
>>       char *command;
>>   } PCIProxyDevClass;
>>   
>> +void proxy_default_bar_write(void *opaque, hwaddr addr, uint64_t val,
>> +                             unsigned size);
>> +
>> +uint64_t proxy_default_bar_read(void *opaque, hwaddr addr, unsigned size);
>> +
>>   #endif /* QEMU_PROXY_H */
>> diff --git a/include/io/mpqemu-link.h b/include/io/mpqemu-link.h
>> index 5a2be48..1a7738e 100644
>> --- a/include/io/mpqemu-link.h
>> +++ b/include/io/mpqemu-link.h
>> @@ -38,6 +38,8 @@
>>    * PCI_CONFIG_READ        PCI configuration space read
>>    * PCI_CONFIG_WRITE       PCI configuration space write
>>    * SYNC_SYSMEM      Shares QEMU's RAM with remote device's RAM
>> + * BAR_WRITE        Writes to PCI BAR region
>> + * BAR_READ         Reads from PCI BAR region
>>    *
>>    * proc_cmd_t enum type to specify the command to be executed on the remote
>>    * device.
>> @@ -47,6 +49,8 @@ typedef enum {
>>       PCI_CONFIG_READ,
>>       PCI_CONFIG_WRITE,
>>       SYNC_SYSMEM,
>> +    BAR_WRITE,
>> +    BAR_READ,
>>       MAX,
>>   } mpqemu_cmd_t;
>>   
>> @@ -70,6 +74,13 @@ typedef struct {
>>   } sync_sysmem_msg_t;
>>   
>>   typedef struct {
>> +    hwaddr addr;
>> +    uint64_t val;
>> +    unsigned size;
>> +    bool memory;
>> +} bar_access_msg_t;
>> +
>> +typedef struct {
>>       mpqemu_cmd_t cmd;
>>       int bytestream;
>>       size_t size;
>> @@ -77,6 +88,7 @@ typedef struct {
>>       union {
>>           uint64_t u64;
>>           sync_sysmem_msg_t sync_sysmem;
>> +        bar_access_msg_t bar_access;
>>       } data1;
>>   
>>       int fds[REMOTE_MAX_FDS];
>> diff --git a/remote/remote-main.c b/remote/remote-main.c
>> index 7b4cf2f..acd8daf 100644
>> --- a/remote/remote-main.c
>> +++ b/remote/remote-main.c
>> @@ -33,6 +33,7 @@
>>   #include "sysemu/sysemu.h"
>>   #include "block/block.h"
>>   #include "exec/ramlist.h"
>> +#include "exec/memattrs.h"
>>   
>>   static MPQemuLinkState *mpqemu_link;
>>   PCIDevice *remote_pci_dev;
>> @@ -63,6 +64,66 @@ static void process_config_read(MPQemuMsg *msg)
>>       PUT_REMOTE_WAIT(wait);
>>   }
>>   
>> +/* TODO: confirm memtx attrs. */
>> +static void process_bar_write(MPQemuMsg *msg, Error **errp)
>> +{
>> +    bar_access_msg_t *bar_access = &msg->data1.bar_access;
>> +    AddressSpace *as =
>> +        bar_access->memory ? &address_space_memory : &address_space_io;
>> +    MemTxResult res;
>> +
>> +    res = address_space_rw(as, bar_access->addr, MEMTXATTRS_UNSPECIFIED,
>> +                           (uint8_t *)&bar_access->val, bar_access->size, true);
>> +
>> +    if (res != MEMTX_OK) {
>> +        error_setg(errp, "Could not perform address space write operation,"
>> +                   " inaccessible address: %lx.", bar_access->addr);
>> +    }
>> +}
>> +
>> +static void process_bar_read(MPQemuMsg *msg, Error **errp)
>> +{
>> +    bar_access_msg_t *bar_access = &msg->data1.bar_access;
>> +    AddressSpace *as;
>> +    int wait = msg->fds[0];
>> +    MemTxResult res;
>> +    uint64_t val = 0;
>> +
>> +    as = bar_access->memory ? &address_space_memory : &address_space_io;
>> +
>> +    assert(bar_access->size <= sizeof(uint64_t));
> 
> Note you don't have that check on the write function above.
> Do you actually want something like:
>     assert(is_power_of_2(bar_access->size) && bar_access->size <= sizeof(uint64_t));

Thanks, Dave! I think we should add this check to the write function as
well.

> 
>> +    res = address_space_rw(as, bar_access->addr, MEMTXATTRS_UNSPECIFIED,
>> +                           (uint8_t *)&val, bar_access->size, false);
>> +
>> +    if (res != MEMTX_OK) {
>> +        error_setg(errp, "Could not perform address space read operation,"
>> +                   " inaccessible address: %lx.", bar_access->addr);
>> +        val = (uint64_t)-1;
>> +        goto fail;
>> +    }
>> +
>> +    switch (bar_access->size) {
> 
> No case 8 ?

You're correct; we need case 8 in this case.

We don't need to do an explicit typecast for case 8, as the variable
"val" is already 8 bytes long. However, if we don't have case 8, then
all 8-byte reads would get picked up as "default" and report an error.

We initially didn't have the "default" case. But checkpatch complained
about switch-case without default, and this bug got introduced
unwittingly.

Thank you!
--
Jag

> 
> Dave
> 
>> +    case 4:
>> +        val = *((uint32_t *)&val);
>> +        break;
>> +    case 2:
>> +        val = *((uint16_t *)&val);
>> +        break;
>> +    case 1:
>> +        val = *((uint8_t *)&val);
>> +        break;
>> +    default:
>> +        error_setg(errp, "Invalid PCI BAR read size");
>> +        return;
>> +    }
>> +
>> +fail:
>> +    notify_proxy(wait, val);
>> +
>> +    PUT_REMOTE_WAIT(wait);
>> +}
>> +
>>   static void process_msg(GIOCondition cond, MPQemuChannel *chan)
>>   {
>>       MPQemuMsg *msg = NULL;
>> @@ -88,6 +149,18 @@ static void process_msg(GIOCondition cond, MPQemuChannel *chan)
>>       case PCI_CONFIG_READ:
>>           process_config_read(msg);
>>           break;
>> +    case BAR_WRITE:
>> +        process_bar_write(msg, &err);
>> +        if (err) {
>> +            goto finalize_loop;
>> +        }
>> +        break;
>> +    case BAR_READ:
>> +        process_bar_read(msg, &err);
>> +        if (err) {
>> +            goto finalize_loop;
>> +        }
>> +        break;
>>       default:
>>           error_setg(&err, "Unknown command");
>>           goto finalize_loop;
>> -- 
>> 1.8.3.1
>>
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
> 

