Return-Path: <SRS0=Qmby=6N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51EB4C83003
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 06:00:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F756206D6
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 06:00:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y3rDCjzj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F756206D6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34862 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTfll-00087E-83
	for qemu-devel@archiver.kernel.org; Wed, 29 Apr 2020 02:00:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38450)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jTfkp-0007by-CK
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 01:59:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jTfkn-0003f3-9M
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 01:59:31 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:55599
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jTfkm-0003Tk-SO
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 01:59:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588139967;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kFQ7QRi3nFYNRl/LD1ZeFgvqOAO12pmBe0ANKHN40ZE=;
 b=Y3rDCjzjZkC7wgcVmIFZ5LFDmd0uohgEcl0/4QrsYM3tsQr+8IkscRnlT4Jqj/no4h33b3
 BOdJhehYyIUCj5efSSexw5Lo9tBV1NynrQqCLAZ05P7V/5dFqRCyXTJx31ASoEjStfXAg/
 z8sTT09WSmHzLM5Z2ubdqZkKXePB3bg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-505-TNV_N5UIOC27umId6u_n-Q-1; Wed, 29 Apr 2020 01:59:23 -0400
X-MC-Unique: TNV_N5UIOC27umId6u_n-Q-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 050E780058A;
 Wed, 29 Apr 2020 05:59:22 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-113-6.ams2.redhat.com [10.36.113.6])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8B3A05EDE0;
 Wed, 29 Apr 2020 05:59:21 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 0865411358BC; Wed, 29 Apr 2020 07:59:20 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Subject: Re: [PATCH 07/11] mips/malta: Fix create_cps() error handling
References: <20200424192027.11404-1-armbru@redhat.com>
 <20200424192027.11404-8-armbru@redhat.com>
 <75dc4fbc-2b39-c8ef-8030-370672621c2f@amsat.org>
Date: Wed, 29 Apr 2020 07:59:19 +0200
In-Reply-To: <75dc4fbc-2b39-c8ef-8030-370672621c2f@amsat.org> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Mon, 27 Apr 2020 11:20:53
 +0200")
Message-ID: <871ro6x26g.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.81; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/29 01:28:11
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> writes:

> On 4/24/20 9:20 PM, Markus Armbruster wrote:
>> The Error ** argument must be NULL, &error_abort, &error_fatal, or a
>> pointer to a variable containing NULL.  Passing an argument of the
>> latter kind twice without clearing it in between is wrong: if the
>> first call sets an error, it no longer points to NULL for the second
>>=20
>> create_cps() is wrong that way.  The last calls treats an error as
>> fatal.  Do that for the prior ones, too.
>>=20
>> Fixes: bff384a4fbd5d0e86939092e74e766ef0f5f592c
>> Cc: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
>> Cc: "Philippe Mathieu-Daud=C3=A9" <philmd@redhat.com>
>> Cc: Aurelien Jarno <aurelien@aurel32.net>
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>>  hw/mips/mips_malta.c | 15 ++++++---------
>>  1 file changed, 6 insertions(+), 9 deletions(-)
>>=20
>> diff --git a/hw/mips/mips_malta.c b/hw/mips/mips_malta.c
>> index e4c4de1b4e..17bf41616b 100644
>> --- a/hw/mips/mips_malta.c
>> +++ b/hw/mips/mips_malta.c
>> @@ -1185,17 +1185,14 @@ static void create_cpu_without_cps(MachineState =
*ms,
>>  static void create_cps(MachineState *ms, MaltaState *s,
>>                         qemu_irq *cbus_irq, qemu_irq *i8259_irq)
>>  {
>> -    Error *err =3D NULL;
>> -
>>      sysbus_init_child_obj(OBJECT(s), "cps", OBJECT(&s->cps), sizeof(s->=
cps),
>>                            TYPE_MIPS_CPS);
>> -    object_property_set_str(OBJECT(&s->cps), ms->cpu_type, "cpu-type", =
&err);
>> -    object_property_set_int(OBJECT(&s->cps), ms->smp.cpus, "num-vp", &e=
rr);
>> -    object_property_set_bool(OBJECT(&s->cps), true, "realized", &err);
>> -    if (err !=3D NULL) {
>> -        error_report("%s", error_get_pretty(err));
>
> In https://www.mail-archive.com/qemu-devel@nongnu.org/msg695645.html I
> also remove "qemu/error-report.h" which is not needed once you remove
> this call.

Missed it, sorry.  I only reviewed the Coccinelle scripts [PATCH 1+3/7].

I'd replace my patch by yours to give you proper credit, but your commit
message mentions "the coccinelle script", presumably the one from PATCH
1/7, and that patch isn't quite ready in my opinion.

>> -        exit(1);
>> -    }
>> +    object_property_set_str(OBJECT(&s->cps), ms->cpu_type, "cpu-type",
>> +                            &error_fatal);
>> +    object_property_set_int(OBJECT(&s->cps), ms->smp.cpus, "num-vp",
>> +                            &error_fatal);
>> +    object_property_set_bool(OBJECT(&s->cps), true, "realized",
>> +                             &error_fatal);
>> =20
>>      sysbus_mmio_map_overlap(SYS_BUS_DEVICE(&s->cps), 0, 0, 1);
>> =20
>>=20


