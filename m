Return-Path: <SRS0=eTrL=2V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C99A2C2D0C2
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Dec 2019 16:26:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F92F206D9
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Dec 2019 16:26:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M/LhOi1u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F92F206D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44246 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1imKLL-0001io-Lo
	for qemu-devel@archiver.kernel.org; Tue, 31 Dec 2019 11:26:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58000)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1imKKb-0001Bl-Mo
 for qemu-devel@nongnu.org; Tue, 31 Dec 2019 11:25:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1imKKa-0004yq-6l
 for qemu-devel@nongnu.org; Tue, 31 Dec 2019 11:25:17 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:34655
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1imKKa-0004ts-2Y
 for qemu-devel@nongnu.org; Tue, 31 Dec 2019 11:25:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1577809515;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+oaO9uYOsU0tpRJ/OewCRA6pfkVMW2oHTOZpuwm+E80=;
 b=M/LhOi1uOuVtHvfbZgza8QaZQw4j0H6XjrnKApqTbZ20uF7KJPf0pWK7nfqYWsYzjl/mgY
 aXd12jDGQ4RJ4OpxYS2iUh+OYmmGjnbeWJT/Ojq6HJOeeB4MRO0ayPpaZHHjIjZ5+jAthS
 KMcw1oBMmKNr6N6sAIUsKloyVAJlVvE=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-223-X_AMzVR2O_-VxsAg8B4kpQ-1; Tue, 31 Dec 2019 11:25:13 -0500
Received: by mail-wr1-f71.google.com with SMTP id u18so19222734wrn.11
 for <qemu-devel@nongnu.org>; Tue, 31 Dec 2019 08:25:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=vGA8v9Duf9iELa1+NrF4NDme4S8klDbTw25sN1O3rkI=;
 b=hCOIK2acWAczAypL+/4Q+rThDtmdIDweyJFYVWxC4Eyu0SDUC8A4OZ73Dl4xSFR8Lh
 gZE1YlOg4D+T/jdeqOv7GZHAtUvbKOHh+4v55+GcSsIa0n5aGSzO+fabYc4ntQdXy1H0
 OuSjW198FesWud/l2OtqU8FzmPPSmVdOvbx+cBemigLzGTeC57vvkqAWAmfkpmFoFSm1
 EqVlYvuHHZdUSmrwU+WqXqMolwcUtVPmSjf7xqo4dTTDz3s8vjk/O7W7PtWmAgjrTjQN
 L+HiNKB/HzMAAjinjSEtHbDbXE5YveyyHjh3lkt0qcgh2A/c0UwPyTdZ7vEQOKHhwCXo
 uhvQ==
X-Gm-Message-State: APjAAAW5VrVuozq3HM9Jv8jXlWygnzgtxSJquKFnJqaVPWXeehw0tuxk
 +10fX1DgNKR/vYrWmAYcn1TjUOgbmy6r+hDbhAxQIdTNVBfen6NBC/t7zGjOLfZhpEF3DFdTwtV
 dK2juuv6Mbk8heds=
X-Received: by 2002:a1c:6588:: with SMTP id z130mr5182747wmb.0.1577809512059; 
 Tue, 31 Dec 2019 08:25:12 -0800 (PST)
X-Google-Smtp-Source: APXvYqxhUdfPgToXZKczHqCzjdZp9FKiEuUjLLzDVnaHJp8cFJoC2Mlez35z+X6L8EafcLOu4ExCWg==
X-Received: by 2002:a1c:6588:: with SMTP id z130mr5182726wmb.0.1577809511856; 
 Tue, 31 Dec 2019 08:25:11 -0800 (PST)
Received: from ?IPv6:2a01:cb18:8372:6b00:691b:aac5:8837:d4da?
 ([2a01:cb18:8372:6b00:691b:aac5:8837:d4da])
 by smtp.gmail.com with ESMTPSA id f1sm49906439wru.6.2019.12.31.08.25.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 31 Dec 2019 08:25:11 -0800 (PST)
Subject: Re: [PATCH] tests/vm: update openbsd to release 6.6
To: Brad Smith <brad@comstyle.com>, Gerd Hoffmann <kraxel@redhat.com>,
 qemu-devel@nongnu.org
References: <20191018102443.26469-1-kraxel@redhat.com>
 <ca7e9094-bb0b-08f5-7523-778f89c4b333@comstyle.com>
 <7dd63098-305e-331a-08c3-63c58366d7f1@comstyle.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <56fbbb75-e9a9-b18a-9432-1c44d4a60f4b@redhat.com>
Date: Tue, 31 Dec 2019 17:25:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <7dd63098-305e-331a-08c3-63c58366d7f1@comstyle.com>
Content-Language: en-US
X-MC-Unique: X_AMzVR2O_-VxsAg8B4kpQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: Fam Zheng <fam@euphon.net>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/19/19 11:11 PM, Brad Smith wrote:
> ping.
>=20
> On 11/13/2019 10:33 PM, Brad Smith wrote:
>> Thanks.
>>
>> Reviewed-by: Brad Smith<brad@comstyle.com>

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

>> On 10/18/2019 6:24 AM, Gerd Hoffmann wrote:
>>> Signed-off-by: Gerd Hoffmann<kraxel@redhat.com>
>>> ---
>>>   tests/vm/openbsd | 4 ++--
>>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/tests/vm/openbsd b/tests/vm/openbsd
>>> index b92c39f89a6f..9f82cd459fde 100755
>>> --- a/tests/vm/openbsd
>>> +++ b/tests/vm/openbsd
>>> @@ -22,8 +22,8 @@ class OpenBSDVM(basevm.BaseVM):
>>>       name =3D "openbsd"
>>>       arch =3D "x86_64"
>>>  =20
>>> -    link =3D"https://cdn.openbsd.org/pub/OpenBSD/6.5/amd64/install65.i=
so"
>>> -    csum =3D "38d1f8cadd502f1c27bf05c5abde6cc505dd28f3f34f8a941048ff9a=
54f9f608"
>>> +    link =3D"https://cdn.openbsd.org/pub/OpenBSD/6.6/amd64/install66.i=
so"
>>> +    csum =3D "b22e63df56e6266de6bbeed8e9be0fbe9ee2291551c5bc03f3cc2e4a=
b9436ee3"
>>>       size =3D "20G"
>>>       pkgs =3D [
>>>           # tools


