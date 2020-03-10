Return-Path: <SRS0=ZRpO=43=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4476DC10F27
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 08:05:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1612724673
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 08:05:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1612724673
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54960 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBZtf-0005b1-9r
	for qemu-devel@archiver.kernel.org; Tue, 10 Mar 2020 04:05:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52725)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <longpeng2@huawei.com>) id 1jBZsn-0004ci-3x
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 04:04:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <longpeng2@huawei.com>) id 1jBZsl-00031a-Lw
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 04:04:56 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:35422 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <longpeng2@huawei.com>)
 id 1jBZsl-0002fc-8y
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 04:04:55 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id 3D46ACD806B58C211F28;
 Tue, 10 Mar 2020 16:04:46 +0800 (CST)
Received: from [10.173.228.124] (10.173.228.124) by smtp.huawei.com
 (10.3.19.209) with Microsoft SMTP Server (TLS) id 14.3.487.0; Tue, 10 Mar
 2020 16:04:35 +0800
Subject: Re: [PATCH RESEND 2/3] vhost: fix a null pointer reference of
 vhost_log
To: "Michael S. Tsirkin" <mst@redhat.com>
References: <20200224064219.1434-1-longpeng2@huawei.com>
 <20200224064219.1434-3-longpeng2@huawei.com>
 <20200310014623-mutt-send-email-mst@kernel.org>
From: "Longpeng (Mike, Cloud Infrastructure Service Product Dept.)"
 <longpeng2@huawei.com>
Message-ID: <7da2b8b6-afe7-7f1f-9252-925b6bc543d8@huawei.com>
Date: Tue, 10 Mar 2020 16:04:35 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20200310014623-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.173.228.124]
X-CFilter-Loop: Reflected
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 45.249.212.32
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
Cc: weifuqiang@huawei.com, Jason Wang <jasowang@redhat.com>,
 qemu-devel@nongnu.org, alex.williamson@redhat.com, arei.gonglei@huawei.com,
 huangzhichao@huawei.com,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 2020/3/10 13:57, Michael S. Tsirkin wrote:
> On Mon, Feb 24, 2020 at 02:42:18PM +0800, Longpeng(Mike) wrote:
>> From: Longpeng <longpeng2@huawei.com>
>>
>> vhost_log_alloc() may fails and returned pointer of log is null.
>> However there're two places derefernce the return pointer without
>> check.
>>
>> Signed-off-by: Longpeng <longpeng2@huawei.com>
>> ---
>>  hw/virtio/vhost.c | 19 +++++++++++++++++--
>>  1 file changed, 17 insertions(+), 2 deletions(-)
>>
>> diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
>> index 9edfadc..c7ad6e5 100644
>> --- a/hw/virtio/vhost.c
>> +++ b/hw/virtio/vhost.c
>> @@ -219,6 +219,10 @@ static struct vhost_log *vhost_log_get(uint64_t size, bool share)
>>  
>>      if (!log || log->size != size) {
>>          log = vhost_log_alloc(size, share);
>> +        if (!log) {
>> +            return NULL;
>> +        }
>> +
>>          if (share) {
>>              vhost_log_shm = log;
>>          } else {
>> @@ -270,10 +274,17 @@ static bool vhost_dev_log_is_shared(struct vhost_dev *dev)
>>  
>>  static inline void vhost_dev_log_resize(struct vhost_dev *dev, uint64_t size)
>>  {
>> -    struct vhost_log *log = vhost_log_get(size, vhost_dev_log_is_shared(dev));
>> -    uint64_t log_base = (uintptr_t)log->log;
>> +    struct vhost_log *log;
>> +    uint64_t log_base;
>>      int r;
>>  
>> +    log = vhost_log_get(size, vhost_dev_log_is_shared(dev));
>> +    if (!log) {
>> +        return;
>> +    }
>> +
> 
> I'm not sure silently failing like this is safe. Callers assume
> log can be resized. What can be done? I suspect not much
> beside exiting ...
> Speaking of which, lots of other failures in log resizing
> path seem to be silently ignored.
> I guess we should propagate them, and fix callers to check
> the return code?
> 
How about to let the callers treat the failure of log_resize as a fatal error ?

-static inline void vhost_dev_log_resize(struct vhost_dev *dev, uint64_t size)
+static inline int vhost_dev_log_resize(struct vhost_dev *dev, uint64_t size)
 {
-    struct vhost_log *log = vhost_log_get(size, vhost_dev_log_is_shared(dev));
-    uint64_t log_base = (uintptr_t)log->log;
+    struct vhost_log *log;
+    uint64_t log_base;
     int r;

+    log = vhost_log_get(size, vhost_dev_log_is_shared(dev));
+    if (!log) {
+        r = -1;
+        goto out;
+    }
+
+    log_base = (uintptr_t)log->log;
+
     /* inform backend of log switching, this must be done before
        releasing the current log, to ensure no logging is lost */
     r = dev->vhost_ops->vhost_set_log_base(dev, log_base, log);
@@ -284,6 +296,9 @@ static inline void vhost_dev_log_resize(struct vhost_dev
*dev, uint64_t size)
     vhost_log_put(dev, true);
     dev->log = log;
     dev->log_size = size;
+
+out:
+    return 0;
 }


@@ -510,7 +525,9 @@ static void vhost_commit(MemoryListener *listener)
 #define VHOST_LOG_BUFFER (0x1000 / sizeof *dev->log)
     /* To log more, must increase log size before table update. */
     if (dev->log_size < log_size) {
-        vhost_dev_log_resize(dev, log_size + VHOST_LOG_BUFFER);
+        if (vhost_dev_log_resize(dev, log_size + VHOST_LOG_BUFFER) < 0) {
+            abort();
+        }
     }
     r = dev->vhost_ops->vhost_set_mem_table(dev, dev->mem);
     if (r < 0) {
@@ -518,7 +535,9 @@ static void vhost_commit(MemoryListener *listener)
     }
     /* To log less, can only decrease log size after table update. */
     if (dev->log_size > log_size + VHOST_LOG_BUFFER) {
-        vhost_dev_log_resize(dev, log_size);
+        if (vhost_dev_log_resize(dev, log_size + VHOST_LOG_BUFFER) < 0) {
+            abort();
+        }
     }

 out:
@@ -818,7 +837,11 @@ static int vhost_migration_log(MemoryListener *listener,
int enable)
         }
         vhost_log_put(dev, false);
     } else {
-        vhost_dev_log_resize(dev, vhost_get_log_size(dev));
+        r = vhost_dev_log_resize(dev, vhost_get_log_size(dev));
+        if (r < 0) {
+            return r;
+        }
+
         r = vhost_dev_set_log(dev, true);
         if (r < 0) {
             return r;


> 
> .
> 

-- 
---
Regards,
Longpeng(Mike)

