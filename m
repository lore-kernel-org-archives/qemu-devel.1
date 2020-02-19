Return-Path: <SRS0=HiY9=4H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A2BAC34022
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 05:31:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D341B208E4
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 05:31:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D341B208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45940 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4HxO-00029X-2B
	for qemu-devel@archiver.kernel.org; Wed, 19 Feb 2020 00:31:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44695)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <zhukeqian1@huawei.com>) id 1j4HwU-0001NE-Jl
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 00:30:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <zhukeqian1@huawei.com>) id 1j4HwT-0003L9-DR
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 00:30:38 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:49080 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <zhukeqian1@huawei.com>)
 id 1j4HwQ-0003Fw-GI; Wed, 19 Feb 2020 00:30:34 -0500
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id 73F9B8421C6E85ABCF1F;
 Wed, 19 Feb 2020 13:30:26 +0800 (CST)
Received: from [127.0.0.1] (10.173.221.230) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.439.0;
 Wed, 19 Feb 2020 13:30:17 +0800
Subject: Re: [PATCH] migration/throttle: Make throttle slower at tail stage
To: <quintela@redhat.com>
References: <20200214032700.25011-1-zhukeqian1@huawei.com>
 <87o8u1gx9a.fsf@secure.laptop>
From: zhukeqian <zhukeqian1@huawei.com>
Message-ID: <2ad3a87a-0390-bd1e-d86d-b6bf11a41b12@huawei.com>
Date: Wed, 19 Feb 2020 13:30:15 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <87o8u1gx9a.fsf@secure.laptop>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.173.221.230]
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
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 qemu-arm@nongnu.org, wanghaibin.wang@huawei.com,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi, Juan

On 2020/2/14 20:37, Juan Quintela wrote:
> Keqian Zhu <zhukeqian1@huawei.com> wrote:
>> At the tail stage of throttle, VM is very sensitive to
>> CPU percentage. We just throttle 30% of remaining CPU
>> when throttle is more than 80 percentage.
> 
> Why?
> 
My original idea is that if we throttle a fixed percentage of CPU every time,
then the VM is more and more sensitive to performance decrease.

For example, if the initial throttle is 10% and we throttle 10% every time. At the
beginning, the performance changes from 100% to 90%, which makes little effect on VM.
However, if the dirty rate is very high and it is not enough even throttle 80%, then
the performance changes from 20% to 10%, which half the performance and makes heavy
effect on VM.

In the example above, if throttle 85% is enough, then throttle 90% makes unnecessary
performance loss on VM. So this is the reason for slowdown throttling when we are about
to reach the best throttle.

> If we really think that this is better that current approarch, just do
> this _always_.  And throothre 30% of remaining CPU.  So we go:
> 
> 30%
> 30% + 0.3(70%)
> ...
> 
> Or anything else.
> 

This should not be a new approach, instead it is an optional enhancement to

current approach. However, after my deeper thinking, the way that throttle
30% of remaining CPU is unusual and not suitable. We should use another way
to slowdown the tail stage.

When dirty bytes is is 50% more than the approx. bytes xfer, we start or increase
throttling. My idea is that we can calculate the throttle increment expected.
When dirty rate is about to reach the 50% of bandwidth, the throttle increment
expected will smaller than "cpu_throttle_increment" at tail stage.

Maybe the core code likes this:

-static void mig_throttle_guest_down(void)
+static void mig_throttle_guest_down(uint64_t bytes_dirty, uint64_t bytes_xfer)
 {
     MigrationState *s = migrate_get_current();
     uint64_t pct_initial = s->parameters.cpu_throttle_initial;
-    uint64_t pct_icrement = s->parameters.cpu_throttle_increment;
+    uint64_t pct_increment = s->parameters.cpu_throttle_increment;
+    bool pct_tailslow = s->parameters.cpu_throttle_tailslow;
     int pct_max = s->parameters.max_cpu_throttle;

+    uint64_t cpu_throttle_now = cpu_throttle_get_percentage();
+    uint64_t cpu_now, cpu_target, cpu_throttle_expect;
+    uint64_t cpu_throttle_inc;
+
     /* We have not started throttling yet. Let's start it. */
     if (!cpu_throttle_active()) {
         cpu_throttle_set(pct_initial);
     } else {
         /* Throttling already on, just increase the rate */
-        cpu_throttle_set(MIN(cpu_throttle_get_percentage() + pct_icrement,
+        cpu_throttle_inc = pct_increment;
+        if (pct_tailslow) {
+            cpu_now = 100 - cpu_throttle_now;
+            cpu_target = ((bytes_xfer / 2.0) / bytes_dirty) * cpu_now;
+            cpu_throttle_expect = cpu_now - cpu_target;
+            if (cpu_throttle_expect < pct_increment) {
+                cpu_throttle_inc = cpu_throttle_expect;
+            }
+        }
+        cpu_throttle_set(MIN(cpu_throttle_now + cpu_throttle_inc,
                          pct_max));
     }
 }
__________________________________________________________________________

-            if ((rs->num_dirty_pages_period * TARGET_PAGE_SIZE >
-                   (bytes_xfer_now - rs->bytes_xfer_prev) / 2) &&
+            bytes_dirty_period = rs->num_dirty_pages_period * TARGET_PAGE_SIZE;
+            bytes_xfer_period = bytes_xfer_now - rs->bytes_xfer_prev;
+            if ((bytes_dirty_period > bytes_xfer_period / 2) &&
                 (++rs->dirty_rate_high_cnt >= 2)) {
                     trace_migration_throttle();
                     rs->dirty_rate_high_cnt = 0;
-                    mig_throttle_guest_down();
+                    mig_throttle_guest_down(bytes_dirty_period,
+                                            bytes_xfer_period);
             }
> My experience is:
> - you really need to go to very high throothle to make migration happens
>   (more than 70% or so usually).
> - The way that we throotle is not completely exact.
> 
>> This doesn't conflict with cpu_throttle_increment.
>>
>> This may make migration time longer, and is disabled
>> by default.
> 
> 
> What do you think?
> I think that it is better to change method and improve documentation
> that yet adding another parameter.
> 
> Later, Juan.
> 
> 
> .
> 
Thanks,
Keqian


