Return-Path: <SRS0=2niX=33=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3950DC2BA83
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 16:28:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 02A7420720
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 16:28:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Xs1uY8ZI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02A7420720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60320 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j06Us-0000A6-7e
	for qemu-devel@archiver.kernel.org; Fri, 07 Feb 2020 11:28:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55995)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j06TD-0006te-Sg
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 11:27:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j06TC-0002NJ-LD
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 11:27:07 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:53131
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j06TC-0002M0-HQ
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 11:27:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581092826;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NRew0WM9/hguVVDiQByA4rcgt0exsoGjc2th1JNhHPk=;
 b=Xs1uY8ZIrt/au9kAItB6hw4D15wp2//DR/YMkpU7o5vFCJGpFJkkF/DKiDrrA6sDdPlnT9
 X8bhwZfSYqdV6CGeor0lHclJndBCKaEw+8YqjctYWTzYvSyZWeUJ0zYsrrexJcp2R/xFv9
 J5t2ZEKodcnXcn8PttKm/TKDy3JR7sY=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-374-Eib08X-yP7eCdcCmnJE0Cw-1; Fri, 07 Feb 2020 11:27:03 -0500
Received: by mail-wm1-f69.google.com with SMTP id g26so931164wmk.6
 for <qemu-devel@nongnu.org>; Fri, 07 Feb 2020 08:27:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=2k/2EJp51nHK080TIi/E0WhhVolewYmzVbUQJs/efd4=;
 b=J9V6ZTsxxEHZO125j1J6VejcWQgBTgwf7fxEAEQI0pRRwF2Miz80RHF5c1unH/3SbQ
 keRvp7BmxsCDvmF2wQ1L9TyljT3r17a4S0Ww0McbgDkzthMYbCtJLvNpTQ375TMfkG7N
 vhUN1AkxSm3YUvcuCkItzn1cE6ob2b/qfdL33XZ3d4vlxfJxMHoCX16xdPTozL/yoSm1
 CwhIWKqwJsIg7MOXfa1c4/m7jruhpq++bfLsFCZogaCy/4plZlCJSXLpUG1DFL1FY8nA
 /pNeWZTnwXyoDqTAVGYJv0jy6ICeJ1UrI6QPBh/xIVGov929OhW8vCn1HWDAR2uynL1c
 EicQ==
X-Gm-Message-State: APjAAAWDYXkFU2W4Xn+HsOrsIjtlWBmgmlU3oqZEdMt6lxTCBLZ/YwuD
 iAPHHpzjA+v3SkM7bmmSk/yITJtyAHOtoC1Ci0iyKcptlGKBKaKmAXU3DkCp4ZTcwYcF9YA57P7
 g65yu/DlVpu9YY1Q=
X-Received: by 2002:a1c:4d18:: with SMTP id o24mr5090933wmh.35.1581092822801; 
 Fri, 07 Feb 2020 08:27:02 -0800 (PST)
X-Google-Smtp-Source: APXvYqxok2Nx4s3cjmNK/Gj6cuVv1QGJ68HxLfccaqMLYtgRHntobkykNKitwaJM5TUN/vQdEQAlpw==
X-Received: by 2002:a1c:4d18:: with SMTP id o24mr5090905wmh.35.1581092822570; 
 Fri, 07 Feb 2020 08:27:02 -0800 (PST)
Received: from [192.168.254.233] (66.red-217-126-125.staticip.rima-tde.net.
 [217.126.125.66])
 by smtp.gmail.com with ESMTPSA id r1sm3919271wrx.11.2020.02.07.08.27.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 07 Feb 2020 08:27:02 -0800 (PST)
Subject: Re: [PATCH 2/3] MAINTAINERS: Cover qapi/block{-core}.json in 'Block
 layer core' section
To: Markus Armbruster <armbru@redhat.com>, Kevin Wolf <kwolf@redhat.com>
References: <20200207103012.27049-1-philmd@redhat.com>
 <20200207103012.27049-3-philmd@redhat.com>
 <87blqaqyxi.fsf@dusky.pond.sub.org> <20200207142146.GF6031@linux.fritz.box>
 <87blqapej2.fsf@dusky.pond.sub.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <6f20c34f-f96e-ad7d-e91c-0863471406d8@redhat.com>
Date: Fri, 7 Feb 2020 17:27:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <87blqapej2.fsf@dusky.pond.sub.org>
Content-Language: en-US
X-MC-Unique: Eib08X-yP7eCdcCmnJE0Cw-1
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
Cc: qemu-trivial@nongnu.org, John Snow <jsnow@redhat.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/7/20 5:07 PM, Markus Armbruster wrote:
> Kevin Wolf <kwolf@redhat.com> writes:
>=20
>> Am 07.02.2020 um 15:01 hat Markus Armbruster geschrieben:
>>> Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:
>>>
>>>> List this file in the proper section, so maintainers get
>>>> notified when it is modified.
>>>>
>>>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>>>> ---
>>>> Cc: Kevin Wolf <kwolf@redhat.com>
>>>> Cc: Max Reitz <mreitz@redhat.com>
>>>> Cc: qemu-block@nongnu.org
>>>> ---
>>>>   MAINTAINERS | 2 ++
>>>>   1 file changed, 2 insertions(+)
>>>>
>>>> diff --git a/MAINTAINERS b/MAINTAINERS
>>>> index 903831e0a4..e269e9092c 100644
>>>> --- a/MAINTAINERS
>>>> +++ b/MAINTAINERS
>>>> @@ -1842,6 +1842,8 @@ S: Supported
>>>     Block layer core
>>>     M: Kevin Wolf <kwolf@redhat.com>
>>>     M: Max Reitz <mreitz@redhat.com>
>>>     L: qemu-block@nongnu.org
>>>     S: Supported
>>>>   F: block*
>>>>   F: block/
>>>>   F: hw/block/
>>>> +F: qapi/block.json
>>>> +F: qapi/block-core.json
>>>>   F: include/block/
>>>>   F: qemu-img*
>>>>   F: docs/interop/qemu-img.rst
>>>
>>> This is in addition to
>>>
>>>      Block QAPI, monitor, command line
>>>      M: Markus Armbruster <armbru@redhat.com>
>>>      S: Supported
>>>      F: blockdev.c
>>>      F: block/qapi.c
>>>      F: qapi/block*.json
>>>      F: qapi/transaction.json
>>>      T: git https://repo.or.cz/qemu/armbru.git block-next
>>>
>>> I'm not sure this section makes much sense anymore.
>>
>> This is probably for you to decide.
>>
>> Though the block-next branch from the T: line doesn't even exist any
>> more...
>=20
> I have the questionable habit to delete my -next branches when they're
> empty.

Having dangling -next branches pointing to something very previous is=20
also questionable...


