Return-Path: <SRS0=192v=3S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB825C33CB2
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2020 07:28:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 85A0620708
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2020 07:28:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cw6f+LfO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85A0620708
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42182 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwhli-00012X-If
	for qemu-devel@archiver.kernel.org; Wed, 29 Jan 2020 02:28:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59371)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iwhkq-0000aX-5g
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 02:27:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iwhko-0004BI-VB
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 02:27:16 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:27692
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iwhko-00048b-RP
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 02:27:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580282834;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aEfPLnMpLwP3fwyk9o0Z+fhRL6QeIM2jLzbyg+iVUaQ=;
 b=cw6f+LfOS+5XJUZcEKf7FgLraRB/OrMN1QonXshCCSOTp4VDDYvxlh7tzQl2+M2xyIUbA/
 pk/J3UUwrpInOjeiOwgiWCxmkJ/acCJGLlcIzl+DriRc35hLQlAHuXekyybDj/rk6zaBp2
 Q6qSm1nHtBxvOb3JZ0aY/w3KQ3xS3G8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-422-pccB3kswNhaC2O4I1cYSTA-1; Wed, 29 Jan 2020 02:27:11 -0500
Received: by mail-wm1-f70.google.com with SMTP id o193so2214125wme.8
 for <qemu-devel@nongnu.org>; Tue, 28 Jan 2020 23:27:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ZTZVutQ7wyVt6UJkU7fKWnW1/EDbzE9ALc/XIREe4TU=;
 b=rWs+bXh2UipHLW9aal7GiEkQRKDggfw8OSHXvopJnvSGdtrttGbAsoNv+kpZE2gHk0
 yCdY8+Ms0ZGIFMq4hk7hJ0BovwNlRvg1RoWpuytlY1W77b/9iR4gOt4RugK16221VseL
 3QuhV247E2CPRjwB5/PrtCtIOxGwYpxVRsJYDEO3WxHAN9sdSfoDoh79gLngY1QEejfa
 zKnd4k0UzYVVSRhe6lxarTMwReLWAR9JSqNstPclyD/DxTWkiYCV3PGasU2KiX8VdJHM
 WaqsOgeihyef91wXsiRTyczy9vTRBBKdyktHKxqpXDb83i26UiWBsq6gvtrVAL604eLH
 EkqA==
X-Gm-Message-State: APjAAAWV+5WhmXSdrpnNdGMzhV1Wv0cQ86yG3Lyim1tajXeyniVcKIp9
 +fXziRyJ+M4yOecAay4jJH8VcHHu9dM4PlQIC/FZydDjhNJVvsV0p8xK0ahg+5pAyPvfdFfe1gU
 JDwAs+5FjLuQbeqU=
X-Received: by 2002:adf:e9d2:: with SMTP id l18mr3766675wrn.344.1580282830023; 
 Tue, 28 Jan 2020 23:27:10 -0800 (PST)
X-Google-Smtp-Source: APXvYqyPpEQ9J2lYAM3qSLE7VyU6jmeo7Q/XZIqsQ/coNY8amiyePVL+6CRBwATqrQRp0ML1diNI1Q==
X-Received: by 2002:adf:e9d2:: with SMTP id l18mr3766628wrn.344.1580282829598; 
 Tue, 28 Jan 2020 23:27:09 -0800 (PST)
Received: from [192.168.1.35] (113.red-83-57-172.dynamicip.rima-tde.net.
 [83.57.172.113])
 by smtp.gmail.com with ESMTPSA id k7sm1196582wmi.19.2020.01.28.23.27.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 Jan 2020 23:27:09 -0800 (PST)
Subject: Re: [PATCH] .travis.yml: Add description to each job
To: Thomas Huth <thuth@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
References: <20200125183135.28317-1-f4bug@amsat.org>
 <79c2d168-498c-88eb-0857-4c3b195f7e32@redhat.com> <874kwfg2qh.fsf@linaro.org>
 <CAP+75-U0XZe31+QSv7t3oDwmy9fPxgQ7U165w=HU0UN_h2Jc5Q@mail.gmail.com>
 <266be40c-6f5c-ad76-d326-bb174ebf047f@redhat.com>
 <411567d3-2a32-eaf8-7689-3649aad4267c@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <6b298da8-8694-35ba-7822-d8de86487674@redhat.com>
Date: Wed, 29 Jan 2020 08:27:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <411567d3-2a32-eaf8-7689-3649aad4267c@redhat.com>
Content-Language: en-US
X-MC-Unique: pccB3kswNhaC2O4I1cYSTA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: Fam Zheng <fam@euphon.net>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/29/20 8:20 AM, Thomas Huth wrote:
> On 28/01/2020 14.33, Wainer dos Santos Moschetta wrote:
>>
>> On 1/28/20 11:18 AM, Philippe Mathieu-Daud=C3=A9 wrote:
>>> On Tue, Jan 28, 2020 at 1:55 PM Alex Benn=C3=A9e <alex.bennee@linaro.or=
g>
>>> wrote:
>>>> Thomas Huth <thuth@redhat.com> writes:
>>>>> On 25/01/2020 19.31, Philippe Mathieu-Daud=C3=A9 wrote:
>>>>>> The NAME variable can be used to describe nicely a job (see [*]).
>>>>>> As we currently have 32 jobs, use it. This helps for quickly
>>>>>> finding a particular job.
>>>>>>
>>>>>>  =C2=A0=C2=A0 before: https://travis-ci.org/qemu/qemu/builds/6398876=
46
>>>>>>  =C2=A0=C2=A0 after: https://travis-ci.org/philmd/qemu/builds/641795=
043
>>>>> Very good idea, correlating a job in the GUI to an entry in the yml
>>>>> file
>>>>> was really a pain, so far.
>>>>>
>>>>>> [*]
>>>>>> https://docs.travis-ci.com/user/customizing-the-build/#naming-jobs-w=
ithin-matrices
>>>>>>
>>>>>>
>>>>>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>>>>>> ---
>>>>>>  =C2=A0 .travis.yml | 101
>>>>>> ++++++++++++++++++++++++++++++++++------------------
>>>>>>  =C2=A0 1 file changed, 67 insertions(+), 34 deletions(-)
>>>>>>
>>>>>> diff --git a/.travis.yml b/.travis.yml
>>>>>> index 6c1038a0f1..d68e35a2c5 100644
>>>>>> --- a/.travis.yml
>>>>>> +++ b/.travis.yml
>>>>>> @@ -94,24 +94,28 @@ after_script:
>>>>>>
>>>>>>  =C2=A0 matrix:
>>>>>>  =C2=A0=C2=A0=C2=A0 include:
>>>>>> -=C2=A0=C2=A0=C2=A0 - env:
>>>>>> +=C2=A0=C2=A0=C2=A0 - name: "[x86] GCC static (user)"
>>>>> Could you please drop the [x86] and other architectures from the name=
s?
>>>>> Travis already lists the build architecture in the job status page, s=
o
>>>>> this information is redundant.
>>>> Hmm for me the Travis page mis-renders the architecture (on firefox) s=
o
>>>> I do find the arch in the text fairly handy.
>>> This might be a font problem, I can't see the architecture on neither
>>> Firefox nor Chrome:
>>>
>>> https://pasteboard.co/IS3O358.png
>>
>>
>> It is the partially hidden column between the job number and the penguin
>> (or apple if MacOS).
>>
>> Funny, I can see the arch on Philippe's dashboard
>> (https://travis-ci.org/philmd/qemu) but it disappears on my own
>> (https://travis-ci.org/wainersm/qemu).
>=20
> I've never had problems here, for me the column shows up correctly
> everywhere. It looks like this:
>=20
>   http://people.redhat.com/~thuth/travis.png

OK now I understand better your comment :)

>=20
>> Anyway, most of the jobs run on x86_64. So perhaps mark only the non-x86
>> ones?
>=20
> Sounds like a good compromise to me!

I'd rather use one style, rather ARCH explicit on all, or not used at all.


