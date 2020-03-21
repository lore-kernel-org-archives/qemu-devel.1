Return-Path: <SRS0=wc0w=5G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E602C4332B
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Mar 2020 13:09:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C57020724
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Mar 2020 13:09:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Yf+jkxhR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C57020724
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36598 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jFdsw-0000iI-8r
	for qemu-devel@archiver.kernel.org; Sat, 21 Mar 2020 09:09:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46624)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jFds5-0008Nc-Vv
 for qemu-devel@nongnu.org; Sat, 21 Mar 2020 09:09:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1jFds4-0002tO-DR
 for qemu-devel@nongnu.org; Sat, 21 Mar 2020 09:09:01 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:44751)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1jFds3-0002lt-M5
 for qemu-devel@nongnu.org; Sat, 21 Mar 2020 09:09:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584796139;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mLpk1L/99JViTkEUYYE0DZVtIlVgitHx82b+fab8/6w=;
 b=Yf+jkxhRLWHrmsNdABldSeEH82+O0tpwEb7sg4MierSI7dGNYU7LId/CLZuoOexqhThPog
 8aeLLlFjPjxg9vt8rNUM+/PH/jIbIXStLqdGwBVPDffAKlcA0SBPKXbbb3vf/D6vt8M0yu
 V6YJ8sk68QhFD+yAzJoSKs6NPji8WgQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-98-bHF7MhVMNraFWACXUQrg8A-1; Sat, 21 Mar 2020 09:08:57 -0400
X-MC-Unique: bHF7MhVMNraFWACXUQrg8A-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 34F1A800D4E;
 Sat, 21 Mar 2020 13:08:51 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-130.ams2.redhat.com
 [10.36.112.130])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id BCA946EFB9;
 Sat, 21 Mar 2020 13:08:41 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 379F212E76B2; Sat, 21 Mar 2020 14:08:40 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Laurent Vivier <laurent@vivier.eu>
Subject: Re: [PATCH-for-5.0 01/11] block: Remove dead assignment
References: <20200321114615.5360-1-philmd@redhat.com>
 <20200321114615.5360-2-philmd@redhat.com>
 <d58a82c0-7f6c-531e-bd95-9cb6fd830f17@vivier.eu>
Date: Sat, 21 Mar 2020 14:08:40 +0100
In-Reply-To: <d58a82c0-7f6c-531e-bd95-9cb6fd830f17@vivier.eu> (Laurent
 Vivier's message of "Sat, 21 Mar 2020 12:58:23 +0100")
Message-ID: <877dzd97on.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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
Cc: Fam Zheng <fam@euphon.net>, Peter Maydell <peter.maydell@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org, qemu-trivial@nongnu.org,
 =?utf-8?Q?Herv=C3=A9?= Poussineau <hpoussin@reactos.org>,
 Joel Stanley <joel@jms.id.au>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>, Alistair Francis <alistair@alistair23.me>,
 qemu-arm@nongnu.org, =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>,
 John Snow <jsnow@redhat.com>, David Gibson <david@gibson.dropbear.id.au>,
 Kevin Wolf <kwolf@redhat.com>, Igor Mitsyanko <i.mitsyanko@gmail.com>,
 Max Reitz <mreitz@redhat.com>, Andrew Jeffery <andrew@aj.id.au>,
 qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Laurent Vivier <laurent@vivier.eu> writes:

> Le 21/03/2020 =C3=A0 12:46, Philippe Mathieu-Daud=C3=A9 a =C3=A9crit=C2=
=A0:
>> Fix warning reported by Clang static code analyzer:
>>=20
>>   block.c:3167:5: warning: Value stored to 'ret' is never read
>>       ret =3D bdrv_fill_options(&options, filename, &flags, &local_err);
>>       ^     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>=20
>> Reported-by: Clang Static Analyzer
>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>> ---
>>  block.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>=20
>> diff --git a/block.c b/block.c
>> index a2542c977b..908c109a8c 100644
>> --- a/block.c
>> +++ b/block.c
>> @@ -3164,7 +3164,7 @@ static BlockDriverState *bdrv_open_inherit(const c=
har *filename,
>>                                      parent->open_flags, parent->options=
);
>>      }
>> =20
>> -    ret =3D bdrv_fill_options(&options, filename, &flags, &local_err);
>> +    bdrv_fill_options(&options, filename, &flags, &local_err);
>>      if (local_err) {
>>          goto fail;
>>      }
>>=20
>
> I would be sruprised if coverity doesn't warn about an unused return valu=
e.

Coverity recognizes the fact that some return values can be safely
ignored, and reports only ignored return values it sees commonly checked
elsewhere.

This function is used called nowhere else.  Coverity won't complain.

However, I'd prefer

        ret =3D bdrv_fill_options(&options, filename, &flags, &local_err);
   -    if (local_err) {
   +    if (ret < 0) {
            goto fail;
        }


