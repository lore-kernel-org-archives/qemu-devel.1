Return-Path: <SRS0=hU7S=42=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA169C10F25
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 04:26:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF1A920674
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 04:26:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF1A920674
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36008 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBA04-0004dX-Rr
	for qemu-devel@archiver.kernel.org; Mon, 09 Mar 2020 00:26:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42333)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <longpeng2@huawei.com>) id 1jB9zO-0004DN-FE
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 00:26:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <longpeng2@huawei.com>) id 1jB9zN-0005j6-Ed
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 00:26:02 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:2076 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <longpeng2@huawei.com>)
 id 1jB9zN-0005is-3B
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 00:26:01 -0400
Received: from DGGEMM402-HUB.china.huawei.com (unknown [172.30.72.54])
 by Forcepoint Email with ESMTP id EEEFA67530A6CB7968FC;
 Mon,  9 Mar 2020 12:25:50 +0800 (CST)
Received: from dggeme712-chm.china.huawei.com (10.1.199.108) by
 DGGEMM402-HUB.china.huawei.com (10.3.20.210) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 9 Mar 2020 12:25:50 +0800
Received: from [10.173.228.124] (10.173.228.124) by
 dggeme712-chm.china.huawei.com (10.1.199.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1713.5; Mon, 9 Mar 2020 12:25:50 +0800
From: "Longpeng (Mike, Cloud Infrastructure Service Product Dept.)"
 <longpeng2@huawei.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Subject: [Question] An issue when repeat reboot in guest during migration
Message-ID: <64a64b63-a270-cb72-cc9a-e447cbe516cd@huawei.com>
Date: Mon, 9 Mar 2020 12:25:49 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.173.228.124]
X-ClientProxiedBy: dggeme713-chm.china.huawei.com (10.1.199.109) To
 dggeme712-chm.china.huawei.com (10.1.199.108)
X-CFilter-Loop: Reflected
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 45.249.212.189
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
Cc: "Gonglei \(Arei\)" <arei.gonglei@huawei.com>, huangzhichao@huawei.com,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi guys,

We find an issue when repeat reboot in guest during migration, it cause the
migration thread never be waken up again.

<main loop>                        |<migration_thread>
                                   |
main_loop_should_exit [BQL LOCK]   |
 pause_all_vcpus                   |
  1. set all cpus ->stop=true      |
     and then kick                 |
  2. return if all cpus is paused  |
     (by '->stopped == true'), else|
  3. qemu_cond_wait [BQL UNLOCK]   |
                                   |LOCK BQL
                                   |...
                                   |do_vm_stop
                                   | pause_all_vcpus
                                   |  (A)set all cpus ->stop=true
                                   |     and then kick
                                   |  (B)return if all cpus is paused
                                   |     (by '->stopped == true'), else
                                   |  (C)qemu_cond_wait [BQL UNLOCK]
  4. be waken up and LOCK BQL      |  (D)be waken up BUT wait for  BQL
  5. goto 2.                       |
 (BQL is still LOCKed)             |
 resume_all_vcpus                  |
  1. set all cpus ->stop=false     |
     and ->stopped=false           |
...                                |
BQL UNLOCK                         |  (E)LOCK BQL
                                   |  (F)goto B. [but stopped is false now!]
                                   |Finally, sleep at step 3 forever.

I've not test the latest QEMU yet, but after take a quick look at codes, it
seems also has this issue.

Currently I just find two potential approaches to fix it:

1. Just retry. Check if all vcpus are paused before (F), if not then goto (A) to
send the stop request again. It's very simple and safe but it just reduce the
probability.

2. To support nest pause. Use a refcount to instead of the 'bool stop', switch
the 'stopped' to false only when the refcount reduce to zero. Maybe this can
completely solve the problem but it seems easy to introduce other bugs if
imprudence.

Any suggestions ?

Thanks.

---
Regards,
Longpeng(Mike)

