Return-Path: <SRS0=QAbx=Z6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 083CCC43603
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Dec 2019 21:47:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B9CC8206D5
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Dec 2019 21:46:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XmecZQ0P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9CC8206D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33624 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ie4OI-0001SI-Qy
	for qemu-devel@archiver.kernel.org; Sun, 08 Dec 2019 16:46:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51137)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gshan@redhat.com>) id 1ie4NY-0000uu-U4
 for qemu-devel@nongnu.org; Sun, 08 Dec 2019 16:46:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <gshan@redhat.com>) id 1ie4NU-00066w-EV
 for qemu-devel@nongnu.org; Sun, 08 Dec 2019 16:46:09 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:50405
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <gshan@redhat.com>) id 1ie4NT-00060e-Eo
 for qemu-devel@nongnu.org; Sun, 08 Dec 2019 16:46:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575841565;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GzXATSvNIt3xTXUbLkno7z+Dv2yWloNWp5D67T0jvZA=;
 b=XmecZQ0PGxKz2/Qk+kUBKsI5RSdR8OonRIvAMP2yVXC1uNOaz/B6xE3TdSmab7cM4/8LDc
 vLNzujUTvewepxo+0pCPCqYJhyxTSTHqdC9JRTZyMD668ecnOye2rVGMhRX/ufOwWjtMt/
 rywl3Shi9PpxuOnat2MaPuxXN6DIIx8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-409-eBp9qEbhNeiMUeNfAeELkg-1; Sun, 08 Dec 2019 16:46:01 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BFC5C183B700;
 Sun,  8 Dec 2019 21:46:00 +0000 (UTC)
Received: from localhost.localdomain (vpn2-54-53.bne.redhat.com [10.64.54.53])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 01D035D9E5;
 Sun,  8 Dec 2019 21:45:59 +0000 (UTC)
Subject: Re: [PATCH] exec: Remove the duplicated check in parse_cpu_option()
To: Greg Kurz <groug@kaod.org>
References: <20191206063337.39764-1-gshan@redhat.com>
 <20191206175840.06507c32@bahia.w3ibm.bluemix.net>
 <be362efe-0174-ec14-f16f-87ecfda4203a@redhat.com>
 <20191207175101.2653e7b4@bahia.w3ibm.bluemix.net>
From: Gavin Shan <gshan@redhat.com>
Message-ID: <d1c2956d-d6c5-e44b-7926-9c7583d65697@redhat.com>
Date: Mon, 9 Dec 2019 08:45:56 +1100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <20191207175101.2653e7b4@bahia.w3ibm.bluemix.net>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: eBp9qEbhNeiMUeNfAeELkg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Reply-To: Gavin Shan <gshan@redhat.com>
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/8/19 3:51 AM, Greg Kurz wrote:
> On Sat, 7 Dec 2019 23:56:55 +1100
> Gavin Shan <gshan@redhat.com> wrote:
> 
>> On 12/7/19 3:58 AM, Greg Kurz wrote:
>>> On Fri,  6 Dec 2019 17:33:37 +1100
>>> Gavin Shan <gshan@redhat.com> wrote:
>>>
>>>> The @cpu_option shouldn't be NULL, otherwise assertion from g_strsplit()
>>>> should be raised as below message indicates. So it's meaningless to validate
>>>> @model_pices[0] in parse_cpu_option() as it shouldn't be NULL either.
>>>>
>>>>      qemu-system-aarch64: GLib: g_strsplit: assertion 'string != NULL' failed
>>>>
>>>> This just removes the check and unused message.
>>>>
>>>
>>> Hrm... the check isn't about @cpu_option being NULL. It is about filtering out
>>> invalid syntaxes like:
>>>
>>> -cpu ''
>>>
>>> or
>>>
>>> -cpu ,some-prop
>>>
>>
>> Greg, Thanks for your review on this trivial patch.
>>
>> @cpu_option[0] is NULL when we have "-cpu ''". We run into assertion raised
>> by subsequent cpu_class_by_name(). However, @cpu_option[0] isn't NULL with
>> something like "-cpu ,xxx", but the CPU model specific class can't be found
>> at last.
>>
> 
> You're right, the case with a leading ',' is caught by the other check.
> 
>> So the validation mostly relies on cpu_class_by_name() if I'm correct. It's
>> fine to remove the check. However, it provides explicit error message, which
>> isn't bad though:
>>
>>      error_report("-cpu option cannot be empty");
>>
> 
> It's definitely not fine to remove an error message that clearly explains
> to the user what he has done wrong in favor of QEMU aborting and printing
> something cryptic like:
> 
>      cpu_class_by_name: Assertion `cpu_model && cc->class_by_name' failed.
> 
> Assertions are for bugs, not for bad command line usage.
> 

Yes, Agree as explained previously. The explicit message is a bonus at least.
So please ignore this trivial patch and sorry for the noise.

>>>> Signed-off-by: Gavin Shan <gshan@redhat.com>
>>>> ---
>>>>    exec.c | 5 -----
>>>>    1 file changed, 5 deletions(-)
>>>>
>>>> diff --git a/exec.c b/exec.c
>>>> index ffdb518535..3cff459e43 100644
>>>> --- a/exec.c
>>>> +++ b/exec.c
>>>> @@ -963,11 +963,6 @@ const char *parse_cpu_option(const char *cpu_option)
>>>>        const char *cpu_type;
>>>>    
>>>>        model_pieces = g_strsplit(cpu_option, ",", 2);
>>>> -    if (!model_pieces[0]) {
>>>> -        error_report("-cpu option cannot be empty");
>>>> -        exit(1);
>>>> -    }
>>>> -
>>>>        oc = cpu_class_by_name(CPU_RESOLVING_TYPE, model_pieces[0]);
>>>>        if (oc == NULL) {
>>>>            error_report("unable to find CPU model '%s'", model_pieces[0]);
>>>

Regards,
Gavin


