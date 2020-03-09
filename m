Return-Path: <SRS0=hU7S=42=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 884CCC10F27
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 10:18:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D0352072A
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 10:18:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D0352072A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40132 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBFUe-0006N9-KP
	for qemu-devel@archiver.kernel.org; Mon, 09 Mar 2020 06:18:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36931)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pannengyuan@huawei.com>) id 1jBFTZ-0005h2-F2
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 06:17:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pannengyuan@huawei.com>) id 1jBFTY-0005uB-2X
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 06:17:33 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:50568 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pannengyuan@huawei.com>)
 id 1jBFTX-0005sI-NR
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 06:17:32 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id C9B96E27DC0525687534;
 Mon,  9 Mar 2020 18:17:26 +0800 (CST)
Received: from [10.184.39.213] (10.184.39.213) by smtp.huawei.com
 (10.3.19.209) with Microsoft SMTP Server (TLS) id 14.3.487.0; Mon, 9 Mar 2020
 18:17:20 +0800
Subject: Re: [PATCH] qom-qmp-cmds: fix two memleaks in qmp_object_add
To: Igor Mammedov <imammedo@redhat.com>
References: <20200309092212.3249-1-pannengyuan@huawei.com>
 <20200309105145.2f3f6a81@redhat.com>
From: Pan Nengyuan <pannengyuan@huawei.com>
Message-ID: <0c4a1383-f0a1-fe89-df3d-ae802a1d2a25@huawei.com>
Date: Mon, 9 Mar 2020 18:17:17 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200309105145.2f3f6a81@redhat.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.184.39.213]
X-CFilter-Loop: Reflected
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 45.249.212.35
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
Cc: berrange@redhat.com, ehabkost@redhat.com, qemu-devel@nongnu.org,
 euler.robot@huawei.com, pbonzini@redhat.com, zhang.zhanghailiang@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 3/9/2020 5:51 PM, Igor Mammedov wrote:
> On Mon, 9 Mar 2020 17:22:12 +0800
> Pan Nengyuan <pannengyuan@huawei.com> wrote:
> 
>> 'type/id' forgot to free in qmp_object_add, this patch fix that.
>>
>> The leak stack:
>> Direct leak of 84 byte(s) in 6 object(s) allocated from:
>>     #0 0x7fe2a5ebf768 in __interceptor_malloc (/lib64/libasan.so.5+0xef768)
>>     #1 0x7fe2a5044445 in g_malloc (/lib64/libglib-2.0.so.0+0x52445)
>>     #2 0x7fe2a505dd92 in g_strdup (/lib64/libglib-2.0.so.0+0x6bd92)
>>     #3 0x56344954e692 in qmp_object_add /mnt/sdb/qemu-new/qemu_test/qemu/qom/qom-qmp-cmds.c:258
>>     #4 0x563449960f5a in do_qmp_dispatch /mnt/sdb/qemu-new/qemu_test/qemu/qapi/qmp-dispatch.c:132
>>     #5 0x563449960f5a in qmp_dispatch /mnt/sdb/qemu-new/qemu_test/qemu/qapi/qmp-dispatch.c:175
>>     #6 0x563449498a30 in monitor_qmp_dispatch /mnt/sdb/qemu-new/qemu_test/qemu/monitor/qmp.c:145
>>     #7 0x56344949a64f in monitor_qmp_bh_dispatcher /mnt/sdb/qemu-new/qemu_test/qemu/monitor/qmp.c:234
>>     #8 0x563449a92a3a in aio_bh_call /mnt/sdb/qemu-new/qemu_test/qemu/util/async.c:136
>>
>> Direct leak of 54 byte(s) in 6 object(s) allocated from:
>>     #0 0x7fe2a5ebf768 in __interceptor_malloc (/lib64/libasan.so.5+0xef768)
>>     #1 0x7fe2a5044445 in g_malloc (/lib64/libglib-2.0.so.0+0x52445)
>>     #2 0x7fe2a505dd92 in g_strdup (/lib64/libglib-2.0.so.0+0x6bd92)
>>     #3 0x56344954e6c4 in qmp_object_add /mnt/sdb/qemu-new/qemu_test/qemu/qom/qom-qmp-cmds.c:267
>>     #4 0x563449960f5a in do_qmp_dispatch /mnt/sdb/qemu-new/qemu_test/qemu/qapi/qmp-dispatch.c:132
>>     #5 0x563449960f5a in qmp_dispatch /mnt/sdb/qemu-new/qemu_test/qemu/qapi/qmp-dispatch.c:175
>>     #6 0x563449498a30 in monitor_qmp_dispatch /mnt/sdb/qemu-new/qemu_test/qemu/monitor/qmp.c:145
>>     #7 0x56344949a64f in monitor_qmp_bh_dispatcher /mnt/sdb/qemu-new/qemu_test/qemu/monitor/qmp.c:234
>>     #8 0x563449a92a3a in aio_bh_call /mnt/sdb/qemu-new/qemu_test/qemu/util/async.c:136
>>
>> Fixes: 5f07c4d60d091320186e7b0edaf9ed2cc16b2d1e
>> Reported-by: Euler Robot <euler.robot@huawei.com>
>> Signed-off-by: Pan Nengyuan <pannengyuan@huawei.com>
>> ---
>>  qom/qom-qmp-cmds.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/qom/qom-qmp-cmds.c b/qom/qom-qmp-cmds.c
>> index 49db926fcc..ac59ba1aa8 100644
>> --- a/qom/qom-qmp-cmds.c
>> +++ b/qom/qom-qmp-cmds.c
>> @@ -247,8 +247,8 @@ void qmp_object_add(QDict *qdict, QObject **ret_data, Error **errp)
>>      QDict *pdict;
>>      Visitor *v;
>>      Object *obj;
>> -    const char *type;
>> -    const char *id;
>> +    g_autofree const char *type = NULL;
>> +    g_autofree const char *id = NULL;
> 
> not sure that's it's correct
> 
> qdict_get_try_str() returns the reference to a string within
> the QDict, so caller who provided qdict should take care of
> freeing it.
> 
>>  
>>      type = qdict_get_try_str(qdict, "qom-type");
>>      if (!type) {
> 

    type = qdict_get_try_str(qdict, "qom-type");
    if (!type) {
        error_setg(errp, QERR_MISSING_PARAMETER, "qom-type");
        return;
    } else {
        type = g_strdup(type);
        qdict_del(qdict, "qom-type");
    }

If type is not NULL, it will go to the else branch, type re-assign immediately.
And it's aslo in the scope, so the string within the QDict will not be freed.

> .
> 

