Return-Path: <SRS0=Qmby=6N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89035C83003
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 07:51:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 522782076B
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 07:51:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BUJ4M40K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 522782076B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37122 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jThVO-0002i8-Eq
	for qemu-devel@archiver.kernel.org; Wed, 29 Apr 2020 03:51:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46932)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jTh8A-0002rn-BP
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 03:27:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jTh88-0000jj-DF
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 03:27:41 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:43395
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jTh86-0000PN-CP
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 03:27:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588145256;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RzuqMdQe/809M7Rx0MUJ+9lSGhW1ibHtH2DKCeZNun0=;
 b=BUJ4M40Kctw2S39c8GqtjkuXAZo/sZFBNGYN/OZYkiwrndtr0b+ocSiBSfZPjSDJRoTQFF
 vW5GEgRGrR7Wsec5tc9wvwd1pS+CYPc0xZZtHGybmueSslIOzjwzO0xd41a9ZvRAnxL2f9
 /06t0Khfd6iCUZTtRdCD/h8eSfNsIS0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-361-PhD_TkVLOhCNqhbcQDTw8A-1; Wed, 29 Apr 2020 03:27:33 -0400
X-MC-Unique: PhD_TkVLOhCNqhbcQDTw8A-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 12503872FE0;
 Wed, 29 Apr 2020 07:27:32 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-113-6.ams2.redhat.com [10.36.113.6])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 861121000329;
 Wed, 29 Apr 2020 07:27:31 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 0B41911358BC; Wed, 29 Apr 2020 09:27:30 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Subject: Re: [PATCH 07/11] mips/malta: Fix create_cps() error handling
References: <20200424192027.11404-1-armbru@redhat.com>
 <20200424192027.11404-8-armbru@redhat.com>
 <75dc4fbc-2b39-c8ef-8030-370672621c2f@amsat.org>
 <871ro6x26g.fsf@dusky.pond.sub.org>
 <d9a17752-6a8d-a59e-f661-a9e6c59b670f@amsat.org>
Date: Wed, 29 Apr 2020 09:27:29 +0200
In-Reply-To: <d9a17752-6a8d-a59e-f661-a9e6c59b670f@amsat.org> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Wed, 29 Apr 2020 09:13:10
 +0200")
Message-ID: <87sggmrbtq.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.120; envelope-from=armbru@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/29 01:18:10
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> writes:

> +Peter for crediting his advice.
>
> On 4/29/20 7:59 AM, Markus Armbruster wrote:
>> Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> writes:
>>
>>> On 4/24/20 9:20 PM, Markus Armbruster wrote:
>>>> The Error ** argument must be NULL, &error_abort, &error_fatal, or a
>>>> pointer to a variable containing NULL.  Passing an argument of the
>>>> latter kind twice without clearing it in between is wrong: if the
>>>> first call sets an error, it no longer points to NULL for the second
>>>>
>>>> create_cps() is wrong that way.  The last calls treats an error as
>>>> fatal.  Do that for the prior ones, too.
>>>>
>>>> Fixes: bff384a4fbd5d0e86939092e74e766ef0f5f592c
>>>> Cc: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
>>>> Cc: "Philippe Mathieu-Daud=C3=A9" <philmd@redhat.com>
>>>> Cc: Aurelien Jarno <aurelien@aurel32.net>
>>>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>>>> ---
>>>>   hw/mips/mips_malta.c | 15 ++++++---------
>>>>   1 file changed, 6 insertions(+), 9 deletions(-)
>>>>
>>>> diff --git a/hw/mips/mips_malta.c b/hw/mips/mips_malta.c
>>>> index e4c4de1b4e..17bf41616b 100644
>>>> --- a/hw/mips/mips_malta.c
>>>> +++ b/hw/mips/mips_malta.c
>>>> @@ -1185,17 +1185,14 @@ static void create_cpu_without_cps(MachineStat=
e *ms,
>>>>   static void create_cps(MachineState *ms, MaltaState *s,
>>>>                          qemu_irq *cbus_irq, qemu_irq *i8259_irq)
>>>>   {
>>>> -    Error *err =3D NULL;
>>>> -
>>>>       sysbus_init_child_obj(OBJECT(s), "cps", OBJECT(&s->cps), sizeof(=
s->cps),
>>>>                             TYPE_MIPS_CPS);
>>>> -    object_property_set_str(OBJECT(&s->cps), ms->cpu_type, "cpu-type"=
, &err);
>>>> -    object_property_set_int(OBJECT(&s->cps), ms->smp.cpus, "num-vp", =
&err);
>>>> -    object_property_set_bool(OBJECT(&s->cps), true, "realized", &err)=
;
>>>> -    if (err !=3D NULL) {
>>>> -        error_report("%s", error_get_pretty(err));
>>>
>>> In https://www.mail-archive.com/qemu-devel@nongnu.org/msg695645.html I
>>> also remove "qemu/error-report.h" which is not needed once you remove
>>> this call.
>>
>> Missed it, sorry.  I only reviewed the Coccinelle scripts [PATCH 1+3/7].
>
> My bad for not Cc'ing you on the whole series, which is Error related,
> and use the default get_maintainer.pl selection.
>
>> I'd replace my patch by yours to give you proper credit, but your commit
>> message mentions "the coccinelle script", presumably the one from PATCH
>> 1/7, and that patch isn't quite ready in my opinion.
>
> I'm not worried about credit, but duplicating effort or wasting time.
>
> Peter once warned the problem with Coccinelle scripts is finding the
> correct balance between time spent to improve QEMU codebase, and time
> spent learning Coccinelle and improving a script that is often used
> only once in a lifetime.
> If the script is not provided, we ask for the script. If the script is
> embedded in various patch descriptions, we ask to add it independently
> for reuse or as example. Then the script must be almost
> perfect. Meanwhile all the following patches referencing it, while
> reviewed, are stuck.

True.  I try not to ask for undue perfection, but perfection eludes me
in that, too :)

For PATCH 1/7, I only asked you to explain the script's limitations in
the script and the commit message.  Her's a bit of inspiration from the
kernel's scripts/coccinelle/misc/doubleinit.cocci (picked almost at
random):

    /// Find duplicate field initializations.  This has a high rate of fals=
e
    /// positives due to #ifdefs, which Coccinelle is not aware of in a str=
ucture
    /// initialization.
    ///
    // Confidence: Low

I like the Confidence: tag.  It should come with an explanation, as it
does here.

For PATCH 3/7, I had a question.

> Anyway back to your patch:
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> Tested-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Thanks!


