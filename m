Return-Path: <SRS0=BVCf=4W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72379C3F2D1
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 17:05:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B37820870
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 17:05:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="lqS8aGdN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B37820870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53460 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9tw6-0002VU-8Q
	for qemu-devel@archiver.kernel.org; Thu, 05 Mar 2020 12:05:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34379)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jag.raman@oracle.com>) id 1j9tiT-00031q-LO
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 11:51:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jag.raman@oracle.com>) id 1j9tiR-0006OK-JP
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 11:51:21 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:44698)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jag.raman@oracle.com>)
 id 1j9tiR-0006Mx-9i
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 11:51:19 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
 by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 025GYZi3171688;
 Thu, 5 Mar 2020 16:50:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=URNTxkcZnHvDn1RBygfglAB3zHT12ydMNPhGAktl4yU=;
 b=lqS8aGdNRTLi4zYe8QlwKBZOaO0eFBQ0lhwL6uYYB+/r66iv6pfCYhPL9WlXf/PQ0uNT
 Dwgp3KCJlsEPLPysGTpf7S1PZYH69ihT3FWs+yq5Qa8ajgKwxPLD/PUbkLbB6+kq3G7U
 DPA75qVGe51NCcRHOBtJitGh4CGAP8nLPa/pfLS6y0WLJYg2PKYpYulkaaRB6rAWduBG
 dZgL/qGwrvahaGAlflWbhmbLGHO4EGi2rJMeIzf36LC8NGpE7epTy/7u34/2zWn5vrra
 WMKgeufmv8Oq/2/oKZcheO7f/I/WXDTahdG+F1GhotaSZzbX75b5fZH/gm2PyTJVWtp3 cQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
 by aserp2120.oracle.com with ESMTP id 2yffwr6d5d-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 05 Mar 2020 16:50:58 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
 by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 025Gh1L7147143;
 Thu, 5 Mar 2020 16:48:57 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
 by userp3030.oracle.com with ESMTP id 2yjuf1euhg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 05 Mar 2020 16:48:57 +0000
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
 by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 025GmsjS026935;
 Thu, 5 Mar 2020 16:48:54 GMT
Received: from [10.152.34.2] (/10.152.34.2)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Thu, 05 Mar 2020 08:48:53 -0800
Subject: Re: [PATCH v5 41/50] multi-process/mig: Enable VMSD save in the Proxy
 object
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
References: <cover.1582576372.git.jag.raman@oracle.com>
 <f056d73bb7f749171626cb8abc5a317b0ec17845.1582576372.git.jag.raman@oracle.com>
 <20200305123155.GH3130@work-vm>
From: Jag Raman <jag.raman@oracle.com>
Organization: Oracle Corporation
Message-ID: <566485f3-bc78-991a-5ff7-b0f99977d0e8@oracle.com>
Date: Thu, 5 Mar 2020 11:48:51 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200305123155.GH3130@work-vm>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9550
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 spamscore=0 malwarescore=0
 bulkscore=0 adultscore=0 suspectscore=2 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2003050105
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9550
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 lowpriorityscore=0 spamscore=0
 impostorscore=0 malwarescore=0 mlxlogscore=999 mlxscore=0 suspectscore=2
 phishscore=0 clxscore=1015 bulkscore=0 adultscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2003050105
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
X-Received-From: 141.146.126.78
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



On 3/5/2020 7:31 AM, Dr. David Alan Gilbert wrote:
> * Jagannathan Raman (jag.raman@oracle.com) wrote:
>> Collect the VMSD from remote process on the source and save
>> it to the channel leading to the destination
>>
>> Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
>> Signed-off-by: John G Johnson <john.g.johnson@oracle.com>
>> Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
>> ---
>>   v4 -> v5:
>>    - Using qemu_file_shutdown() instead of qemu_thread_cancel(). Removed patch
>>      which introduced qemu_thread_cancel()
>>
>>   hw/proxy/qemu-proxy.c         | 135 ++++++++++++++++++++++++++++++++++++++++++
>>   include/hw/proxy/qemu-proxy.h |   2 +
>>   include/io/mpqemu-link.h      |   1 +
>>   3 files changed, 138 insertions(+)
>>
>> diff --git a/hw/proxy/qemu-proxy.c b/hw/proxy/qemu-proxy.c
>> index b1b9282..19f0dbb 100644
>> --- a/hw/proxy/qemu-proxy.c
>> +++ b/hw/proxy/qemu-proxy.c
>> @@ -23,6 +23,14 @@
>>   #include "util/event_notifier-posix.c"
>>   #include "hw/boards.h"
>>   #include "include/qemu/log.h"
>> +#include "io/channel.h"
>> +#include "migration/qemu-file-types.h"
>> +#include "qapi/error.h"
>> +#include "io/channel-util.h"
>> +#include "migration/qemu-file-channel.h"
>> +#include "migration/qemu-file.h"
>> +#include "migration/migration.h"
>> +#include "migration/vmstate.h"
>>   
>>   QEMUTimer *hb_timer;
>>   static void pci_proxy_dev_realize(PCIDevice *dev, Error **errp);
>> @@ -35,6 +43,9 @@ static void broadcast_init(void);
>>   static int config_op_send(PCIProxyDev *dev, uint32_t addr, uint32_t *val, int l,
>>                             unsigned int op);
>>   
>> +#define PAGE_SIZE qemu_real_host_page_size
>> +uint8_t *mig_data;
>> +
>>   static void childsig_handler(int sig, siginfo_t *siginfo, void *ctx)
>>   {
>>       /* TODO: Add proper handler. */
>> @@ -460,6 +471,129 @@ static void pci_proxy_dev_inst_init(Object *obj)
>>       dev->mem_init = false;
>>   }
>>   
>> +typedef struct {
>> +    QEMUFile *rem;
>> +    PCIProxyDev *dev;
>> +} proxy_mig_data;
>> +
>> +static void *proxy_mig_out(void *opaque)
>> +{
>> +    proxy_mig_data *data = opaque;
>> +    PCIProxyDev *dev = data->dev;
>> +    uint8_t byte;
>> +    uint64_t data_size = PAGE_SIZE;
>> +
>> +    mig_data = g_malloc(data_size);
>> +
>> +    while (true) {
>> +        byte = qemu_get_byte(data->rem);
>> +
>> +        if (qemu_file_get_error(data->rem)) {
>> +            break;
>> +        }
>> +
>> +        mig_data[dev->migsize++] = byte;
>> +        if (dev->migsize == data_size) {
>> +            data_size += PAGE_SIZE;
>> +            mig_data = g_realloc(mig_data, data_size);
>> +        }
>> +    }
>> +
>> +    return NULL;
>> +}
>> +
>> +static int proxy_pre_save(void *opaque)
>> +{
>> +    PCIProxyDev *pdev = opaque;
>> +    proxy_mig_data *mig_data;
>> +    QEMUFile *f_remote;
>> +    MPQemuMsg msg = {0};
>> +    QemuThread thread;
>> +    Error *err = NULL;
>> +    QIOChannel *ioc;
>> +    uint64_t size;
>> +    int fd[2];
>> +
>> +    if (socketpair(AF_UNIX, SOCK_STREAM, 0, fd)) {
>> +        return -1;
>> +    }
>> +
>> +    ioc = qio_channel_new_fd(fd[0], &err);
>> +    if (err) {
>> +        error_report_err(err);
>> +        return -1;
>> +    }
>> +
>> +    qio_channel_set_name(QIO_CHANNEL(ioc), "PCIProxyDevice-mig");
>> +
>> +    f_remote = qemu_fopen_channel_input(ioc);
>> +
>> +    pdev->migsize = 0;
>> +
>> +    mig_data = g_malloc0(sizeof(proxy_mig_data));
>> +    mig_data->rem = f_remote;
> 
> This feels way too complicated.   Since we know f_remote is always just
> a simple fd we're getting we don't need to use qio or qemu_file here;
> just use the fd - nice and simple.
> 
> Then the code to read it can just use read(2) with a sensible size chunk
> rather than reading a byte at a time.

Hi Dave,

Upon closer inspection, we found that the migration code on the remote
(which uses QEMUFile) could sometimes set an error on the channel using
qemu_file_set_error(). We needed to use qemu_file_get_error() to catch
these errors and abort migration. So we had to stick with QEMUFile at
the receiving end as well.

> 
>> +    mig_data->dev = pdev;
>> +
>> +    qemu_thread_create(&thread, "Proxy MIG_OUT", proxy_mig_out, mig_data,
>> +                       QEMU_THREAD_DETACHED);
> 
> I'm just checking why a thread is necessary; is this because you need to
> be able to start reading before you block waiting for the remote to tell
> you the size - worrying that if you don't start reading then the remote
> might block waiting for us?

Yes, Dave. That is correct.

> 
>> +    msg.cmd = START_MIG_OUT;
>> +    msg.bytestream = 0;
>> +    msg.num_fds = 2;
>> +    msg.fds[0] = fd[1];
>> +    msg.fds[1] = GET_REMOTE_WAIT;
>> +
>> +    mpqemu_msg_send(&msg, pdev->mpqemu_link->com);
>> +    size = wait_for_remote(msg.fds[1]);
>> +    PUT_REMOTE_WAIT(msg.fds[1]);
>> +
>> +    assert(size != ULLONG_MAX);
>> +
>> +    /*
>> +     * migsize is being update by a separate thread. Using volatile to
>> +     * instruct the compiler to fetch the value of this variable from
>> +     * memory during every read
>> +     */
>> +    while (*((volatile uint64_t *)&pdev->migsize) < size) {
>> +    }
> 
> Hmm.  I suggest the following:
> 
>    a) You create a shared 'size' variable;  and initialize it to
>      UINT64_MAX.
>    b) The thread uses atomic_read(shared_size) to read that value.
>    c) When you receive the size from the remote you do
>       atomic_set(&shared_size, size);
>    d) The thread does:
>       while (received_size < atomic_read(&shared_size))
> 
>       so the thread will quit either on EOF or it hitting the size.
> 
>    e) We pthread_join here to wait for the thread
>    f) We then check a received size to make sure it matches what we
> expect.
> 
> That removes the tight loop.

Sure, will do.

> 
>> +    qemu_file_shutdown(f_remote);
>> +
>> +    qemu_fclose(f_remote);
>> +    close(fd[1]);
>> +
>> +    return 0;
>> +}
>> +
>> +static int proxy_post_save(void *opaque)
>> +{
>> +    MigrationState *ms = migrate_get_current();
>> +    PCIProxyDev *pdev = opaque;
>> +    uint64_t pos = 0;
>> +
>> +    while (pos < pdev->migsize) {
>> +        qemu_put_byte(ms->to_dst_file, mig_data[pos]);
>> +        pos++;
>> +    }
>> +
>> +    qemu_fflush(ms->to_dst_file);
>> +
>> +    return 0;
> 
> I don't think you need that.
> 
>> +}
>> +
>> +const VMStateDescription vmstate_pci_proxy_device = {
>> +    .name = "PCIProxyDevice",
>> +    .version_id = 2,
>> +    .minimum_version_id = 1,
>> +    .pre_save = proxy_pre_save,
>> +    .post_save = proxy_post_save,
>> +    .fields = (VMStateField[]) {
>> +        VMSTATE_PCI_DEVICE(parent_dev, PCIProxyDev),
>> +        VMSTATE_UINT64(migsize, PCIProxyDev),
> 
> I think instead you should use a VMSTATE_VBUFFER here to save
> the mig_data.
> What we should do is the post_save should g_free the buffer.
> (mig_data should be a field in proxy).

We noticed that VMSTATE_BUFFER requires that the buffer be part of a
"struct" and that the buffer is an array. Since the buffer we're using
is neither an array nor part of a "struct", we decided to go with
writing the buffer directly to the migration stream in proxy_post_save()
instead of using VMSTATE_BUFFER.

I think we should nevertheless g_free this buffer in post_save like you
pointed out.

Thank you!
--
Jag

> 
> Dave
> 
> 
>> +        VMSTATE_END_OF_LIST()
>> +    }
>> +};
>> +
>>   static void pci_proxy_dev_class_init(ObjectClass *klass, void *data)
>>   {
>>       PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
>> @@ -471,6 +605,7 @@ static void pci_proxy_dev_class_init(ObjectClass *klass, void *data)
>>       k->config_write = pci_proxy_write_config;
>>   
>>       dc->reset = proxy_device_reset;
>> +    dc->vmsd = &vmstate_pci_proxy_device;
>>   }
>>   
>>   static const TypeInfo pci_proxy_dev_type_info = {
>> diff --git a/include/hw/proxy/qemu-proxy.h b/include/hw/proxy/qemu-proxy.h
>> index 5de8129..537c227 100644
>> --- a/include/hw/proxy/qemu-proxy.h
>> +++ b/include/hw/proxy/qemu-proxy.h
>> @@ -75,6 +75,8 @@ struct PCIProxyDev {
>>                           bool need_spawn, Error **errp);
>>   
>>       ProxyMemoryRegion region[PCI_NUM_REGIONS];
>> +
>> +    uint64_t migsize;
>>   };
>>   
>>   typedef struct PCIProxyDevClass {
>> diff --git a/include/io/mpqemu-link.h b/include/io/mpqemu-link.h
>> index d2234ca..b42c003 100644
>> --- a/include/io/mpqemu-link.h
>> +++ b/include/io/mpqemu-link.h
>> @@ -63,6 +63,7 @@ typedef enum {
>>       PROXY_PING,
>>       MMIO_RETURN,
>>       DEVICE_RESET,
>> +    START_MIG_OUT,
>>       MAX,
>>   } mpqemu_cmd_t;
>>   
>> -- 
>> 1.8.3.1
>>
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
> 

