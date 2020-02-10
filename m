Return-Path: <SRS0=Q7uJ=36=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9176EC352A4
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2020 06:16:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6779620870
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2020 06:16:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6779620870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57300 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j12Mv-0003h5-Kr
	for qemu-devel@archiver.kernel.org; Mon, 10 Feb 2020 01:16:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55270)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <zhukeqian1@huawei.com>) id 1j12Lh-0002aF-Q8
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 01:15:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <zhukeqian1@huawei.com>) id 1j12Lg-000056-IQ
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 01:15:13 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:2759 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <zhukeqian1@huawei.com>)
 id 1j12Ld-0008Ir-Qy; Mon, 10 Feb 2020 01:15:10 -0500
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id D981BEF02B095D22878D;
 Mon, 10 Feb 2020 14:15:06 +0800 (CST)
Received: from [127.0.0.1] (10.173.221.230) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.439.0;
 Mon, 10 Feb 2020 14:14:59 +0800
Subject: Re: [PATCH] migration: Optimization about wait-unplug migration state
To: Jens Freimann <jfreimann@redhat.com>
References: <20200204050841.44453-1-zhukeqian1@huawei.com>
 <20200205144027.55qsz3j7qf26pzfd@jenstp.localdomain>
From: zhukeqian <zhukeqian1@huawei.com>
Message-ID: <dc6a6b77-5513-d0fe-f167-42987c266920@huawei.com>
Date: Mon, 10 Feb 2020 14:14:58 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <20200205144027.55qsz3j7qf26pzfd@jenstp.localdomain>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.173.221.230]
X-CFilter-Loop: Reflected
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 45.249.212.191
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
Cc: wanghaibin.wang@huawei.com, qemu-arm@nongnu.org, qemu-devel@nongnu.org,
 "Dr. David Alan
 Gilbert" <dgilbert@redhat.com>, Juan Quintela <quintela@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 2020/2/5 22:40, Jens Freimann wrote:
> On Tue, Feb 04, 2020 at 01:08:41PM +0800, Keqian Zhu wrote:
>> qemu_savevm_nr_failover_devices() is originally designed to
>> get the number of failover devices, but it actually returns
>> the number of "unplug-pending" failover devices now. Moreover,
>> what drives migration state to wait-unplug should be the number
>> of "unplug-pending" failover devices, not all failover devices.
>>
>> We can also notice that qemu_savevm_state_guest_unplug_pending()
>> and qemu_savevm_nr_failover_devices() is equivalent almost (from
>> the code view). So the latter is incorrect semantically and
>> useless, just delete it.
>>
>> In the qemu_savevm_state_guest_unplug_pending(), once hit a
>> unplug-pending failover device, then it can return true right
>> now to save cpu time.
>>
>> Signed-off-by: Keqian Zhu <zhukeqian1@huawei.com>
>> ---
>> Cc: jfreimann@redhat.com
>> Cc: Juan Quintela <quintela@redhat.com>
>> Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
>> ---
>> migration/migration.c |  2 +-
>> migration/savevm.c    | 24 +++---------------------
>> migration/savevm.h    |  1 -
>> 3 files changed, 4 insertions(+), 23 deletions(-)
>>
>> diff --git a/migration/migration.c b/migration/migration.c
>> index 3a21a4686c..deedc968cf 100644
>> --- a/migration/migration.c
>> +++ b/migration/migration.c
>> @@ -3333,7 +3333,7 @@ static void *migration_thread(void *opaque)
>>
>>     qemu_savevm_state_setup(s->to_dst_file);
>>
>> -    if (qemu_savevm_nr_failover_devices()) {
>> +    if (qemu_savevm_state_guest_unplug_pending()) {
>>         migrate_set_state(&s->state, MIGRATION_STATUS_SETUP,
>>                           MIGRATION_STATUS_WAIT_UNPLUG);
>>
>> diff --git a/migration/savevm.c b/migration/savevm.c
>> index f19cb9ec7a..1d4220ece8 100644
>> --- a/migration/savevm.c
>> +++ b/migration/savevm.c
>> @@ -1140,36 +1140,18 @@ void qemu_savevm_state_header(QEMUFile *f)
>>     }
>> }
>>
>> -int qemu_savevm_nr_failover_devices(void)
>> +bool qemu_savevm_state_guest_unplug_pending(void)
>> {
>>     SaveStateEntry *se;
>> -    int n = 0;
>>
>>     QTAILQ_FOREACH(se, &savevm_state.handlers, entry) {
>>         if (se->vmsd && se->vmsd->dev_unplug_pending &&
>>             se->vmsd->dev_unplug_pending(se->opaque)) {
>> -            n++;
>> -        }
>> -    }
>> -
>> -    return n;
>> -}
>> -
>> -bool qemu_savevm_state_guest_unplug_pending(void)
>> -{
>> -    SaveStateEntry *se;
>> -    int n = 0;
>> -
>> -    QTAILQ_FOREACH(se, &savevm_state.handlers, entry) {
>> -        if (!se->vmsd || !se->vmsd->dev_unplug_pending) {
>> -            continue;
>> -        }
>> -        if (se->vmsd->dev_unplug_pending(se->opaque)) {
>> -            n++;
>> +            return true;
>>         }
>>     }
>>
>> -    return n > 0;
>> +    return false;
>> }
>>
>> void qemu_savevm_state_setup(QEMUFile *f)
>> diff --git a/migration/savevm.h b/migration/savevm.h
>> index c42b9c80ee..ba64a7e271 100644
>> --- a/migration/savevm.h
>> +++ b/migration/savevm.h
>> @@ -31,7 +31,6 @@
>>
>> bool qemu_savevm_state_blocked(Error **errp);
>> void qemu_savevm_state_setup(QEMUFile *f);
>> -int qemu_savevm_nr_failover_devices(void);
>> bool qemu_savevm_state_guest_unplug_pending(void);
>> int qemu_savevm_state_resume_prepare(MigrationState *s);
>> void qemu_savevm_state_header(QEMUFile *f);
>> -- 
>> 2.19.1
> 
> Looks good to me. I tested it and it still works, so
> Tested-by: Jens Freimann <jfreimann@redhat.com>
> Reviewed-by: Jens Freimann <jfreimann@redhat.com>
> regards
> Jens
> 
> 
> .
> 
Thanks,
Keqian.


