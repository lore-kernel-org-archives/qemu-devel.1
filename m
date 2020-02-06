Return-Path: <SRS0=rlpO=32=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02A69C2D0B1
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 14:14:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C5538214AF
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 14:14:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TdBdqWLP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5538214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39790 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izhv7-0005eh-1c
	for qemu-devel@archiver.kernel.org; Thu, 06 Feb 2020 09:14:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47807)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1izhuH-0004pm-WA
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 09:13:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1izhuH-0007sm-1u
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 09:13:25 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:54708
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1izhuG-0007sW-Uu
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 09:13:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580998404;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qEVMEaSBb12SqZtJg5kIkc6CAP0AQcx1eu9FeIHbUDg=;
 b=TdBdqWLPSQl7Fc4E/rTTx7TBHZeXIV119IBqMvmg16Mn93gMiemDbDMAlyO1mdDhykTRSl
 84mGuOzzNDLla5jcQpejzM0ZLDCI4N3W6U0GsGZ26Us64BQSM6D7HAKAW6tZEMWsYyi3ZJ
 oJ8W7eofYURPkNimThJgesNe3q/4JTU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-403-Pj4NYIUwOvWOe0osu4Ev6g-1; Thu, 06 Feb 2020 09:13:22 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4A4A91336560;
 Thu,  6 Feb 2020 14:13:21 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-136.ams2.redhat.com
 [10.36.116.136])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1FA3460BEC;
 Thu,  6 Feb 2020 14:13:16 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 9D2E311386A7; Thu,  6 Feb 2020 15:13:14 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Kamil Rytarowski <n54@gmx.com>
Subject: Re: [PATCH v2 4/4] Add the NVMM acceleration enlightenments
References: <20200107124903.16505-1-n54@gmx.com>
 <20200128140945.929-1-n54@gmx.com> <20200128140945.929-5-n54@gmx.com>
 <0ed12efa-eee4-b3ff-8f02-f9c3b80d0e21@redhat.com>
 <2ae4caf9-05fd-b740-2612-e1c1ecafe277@gmx.com>
 <87o8ubuapr.fsf@dusky.pond.sub.org>
 <CAP+75-VnwDz0My7p5Zy3SN2gPeACW0z02MUgrdFnSGiZm6xGXg@mail.gmail.com>
 <e87ac5e1-749e-84a2-2c9e-89ac1c69fcdc@gmx.com>
Date: Thu, 06 Feb 2020 15:13:14 +0100
In-Reply-To: <e87ac5e1-749e-84a2-2c9e-89ac1c69fcdc@gmx.com> (Kamil
 Rytarowski's message of "Thu, 6 Feb 2020 14:31:08 +0100")
Message-ID: <87v9ojst1h.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: Pj4NYIUwOvWOe0osu4Ev6g-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>, Sergio Lopez <slp@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>, max@m00nbsd.net,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Kamil Rytarowski <n54@gmx.com> writes:

> On 06.02.2020 14:09, Philippe Mathieu-Daud=C3=A9 wrote:
>> On Thu, Feb 6, 2020 at 2:06 PM Markus Armbruster <armbru@redhat.com> wro=
te:
>>> Kamil Rytarowski <n54@gmx.com> writes:
>>>
>>>> On 03.02.2020 12:54, Philippe Mathieu-Daud=C3=A9 wrote:
>>>>>> @@ -2029,6 +2072,19 @@ static void qemu_whpx_start_vcpu(CPUState *cp=
u)
>>>>>>   #endif
>>>>>>   }
>>>>>>
>>>>>> +static void qemu_nvmm_start_vcpu(CPUState *cpu)
>>>>>> +{
>>>>>> +    char thread_name[VCPU_THREAD_NAME_SIZE];
>>>>>> +
>>>>>> +    cpu->thread =3D g_malloc0(sizeof(QemuThread));
>>>>>> +    cpu->halt_cond =3D g_malloc0(sizeof(QemuCond));
>>>>>
>>>>> Nitpick, we prefer g_new0().
>>>>
>>>> In this file other qemu_*_start_vcpu() use  g_malloc0().
>>>>
>>>> I will leave this part unchanged and defer tor future style fixups if
>>>> someone is interested.
>>>
>>> Time to re-run Coccinelle with the semantic patch from commit
>>> b45c03f585e.
>>
>> I thought about it, but then noticed it would be clever to modify
>> checkpatch to refuse 'g_malloc0?(.*sizeof.*);'
>>
>>
>
> As the patchset was reviewed, could we please merge it in the current
> (v3) form (*) please?

No objection.  If I wanted you to clean this up before we accept your
work, I would've told you :)

[...]


