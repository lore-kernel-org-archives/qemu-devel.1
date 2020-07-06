Return-Path: <SRS0=h+Ky=AR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C09FC433E0
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 11:36:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 05D0B2073E
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 11:36:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jDG8N68r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05D0B2073E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36544 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jsPQH-0005hA-9z
	for qemu-devel@archiver.kernel.org; Mon, 06 Jul 2020 07:36:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44998)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jsPPE-0004xd-H7
 for qemu-devel@nongnu.org; Mon, 06 Jul 2020 07:35:28 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:56198
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jsPPD-0001sC-0R
 for qemu-devel@nongnu.org; Mon, 06 Jul 2020 07:35:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594035326;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2VM6xgr2TpTq7j6hgNHC/7zPJWhpwZrys47oK3kG4C8=;
 b=jDG8N68rkXwbpbazuYDwt01+zPUF4GjOrlC149z0GpRRW0NuEadkrt+OHoMWn6JIcB5caQ
 JmMZjcTCTtTakhP05/W6/nzNKCUPNmZ3G+Ua9FoCgMHIBoSm1P8WLzLSSxXKEMRBZd1Jjh
 PKGygOKRv2CwMfK1yHVaW0B+Po66DTA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-342-al4JtmqTNImFr4OYVHKdKw-1; Mon, 06 Jul 2020 07:35:22 -0400
X-MC-Unique: al4JtmqTNImFr4OYVHKdKw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6CA78800412;
 Mon,  6 Jul 2020 11:35:21 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-143.ams2.redhat.com
 [10.36.112.143])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id ED41A7B400;
 Mon,  6 Jul 2020 11:35:20 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 7A6791132FD2; Mon,  6 Jul 2020 13:35:19 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Greg Kurz <groug@kaod.org>
Subject: Re: [PATCH v3 03/44] qdev: Use returned bool to check for
 qdev_realize() etc. failure
References: <20200706080950.403087-1-armbru@redhat.com>
 <20200706080950.403087-4-armbru@redhat.com>
 <20200706120718.70c37bc0@bahia.lan>
Date: Mon, 06 Jul 2020 13:35:19 +0200
In-Reply-To: <20200706120718.70c37bc0@bahia.lan> (Greg Kurz's message of "Mon, 
 6 Jul 2020 12:08:16 +0200")
Message-ID: <87k0zganbc.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Received-SPF: pass client-ip=205.139.110.61; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/06 01:59:39
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: peter.maydell@linaro.org, vsementsov@virtuozzo.com, berrange@redhat.com,
 ehabkost@redhat.com, qemu-block@nongnu.org, qemu-devel@nongnu.org,
 pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Greg Kurz <groug@kaod.org> writes:

> On Mon,  6 Jul 2020 10:09:09 +0200
> Markus Armbruster <armbru@redhat.com> wrote:
>
>> Convert
>> 
>>     foo(..., &err);
>>     if (err) {
>>         ...
>>     }
>> 
>> to
>> 
>>     if (!foo(..., &err)) {
>>         ...
>>     }
>> 
>> for qdev_realize(), qdev_realize_and_unref(), qbus_realize() and their
>> wrappers isa_realize_and_unref(), pci_realize_and_unref(),
>> sysbus_realize(), sysbus_realize_and_unref(), usb_realize_and_unref().
>> Coccinelle script:
>> 
>>     @@
>>     identifier fun = {
>>         isa_realize_and_unref, pci_realize_and_unref, qbus_realize,
>>         qdev_realize, qdev_realize_and_unref, sysbus_realize,
>>         sysbus_realize_and_unref, usb_realize_and_unref
>>     };
>>     expression list args, args2;
>>     typedef Error;
>>     Error *err;
>>     @@
>>     -    fun(args, &err, args2);
>>     -    if (err)
>>     +    if (!fun(args, &err, args2))
>>          {
>>              ...
>>          }
>> 
>> Chokes on hw/arm/musicpal.c's lcd_refresh() with the unhelpful error
>> message "no position information".  Nothing to convert there; skipped.
>> 
>> Fails to convert hw/arm/armsse.c, because Coccinelle gets confused by
>> ARMSSE being used both as typedef and function-like macro there.
>> Converted manually.
>> 
>> A few line breaks tidied up manually.
>> 
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> Reviewed-by: Eric Blake <eblake@redhat.com>
>> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>> ---
>
> FWIW I had posted an R-b for this patch in v1 (20200629124037.2b9a269e@bahia.lan).

When I sliced and diced my patches for v2, I dropped R-bys for patches
substantially altered.  This one was borderline: the patch does strictly
less, and the work it no longer does us done by later patches.

Example: v1's first hunk

    diff --git a/hw/arm/allwinner-a10.c b/hw/arm/allwinner-a10.c
    index 52e0d83760..3e45aa4141 100644
    --- a/hw/arm/allwinner-a10.c
    +++ b/hw/arm/allwinner-a10.c
    @@ -72,17 +72,12 @@ static void aw_a10_realize(DeviceState *dev, Error **errp)
     {
         AwA10State *s = AW_A10(dev);
         SysBusDevice *sysbusdev;
    -    Error *err = NULL;

    -    qdev_realize(DEVICE(&s->cpu), NULL, &err);
    -    if (err != NULL) {
    -        error_propagate(errp, err);
    +    if (!qdev_realize(DEVICE(&s->cpu), NULL, errp)) {
             return;
         }

    -    sysbus_realize(SYS_BUS_DEVICE(&s->intc), &err);
    -    if (err != NULL) {
    -        error_propagate(errp, err);
    +    if (!sysbus_realize(SYS_BUS_DEVICE(&s->intc), errp)) {
             return;
         }
         sysbusdev = SYS_BUS_DEVICE(&s->intc);

became

    diff --git a/hw/arm/allwinner-a10.c b/hw/arm/allwinner-a10.c
    index 52e0d83760..e1acffe5f6 100644
    --- a/hw/arm/allwinner-a10.c
    +++ b/hw/arm/allwinner-a10.c
    @@ -74,14 +74,12 @@ static void aw_a10_realize(DeviceState *dev, Error **errp)
         SysBusDevice *sysbusdev;
         Error *err = NULL;

    -    qdev_realize(DEVICE(&s->cpu), NULL, &err);
    -    if (err != NULL) {
    +    if (!qdev_realize(DEVICE(&s->cpu), NULL, &err)) {
             error_propagate(errp, err);
             return;
         }

    -    sysbus_realize(SYS_BUS_DEVICE(&s->intc), &err);
    -    if (err != NULL) {
    +    if (!sysbus_realize(SYS_BUS_DEVICE(&s->intc), &err)) {
             error_propagate(errp, err);
             return;
         }


in v2 and v3.  The two error_propagate() and the local variable now go
away only in PATCH v3 33.

Would you like me to record your R-by for the patch's current version?


