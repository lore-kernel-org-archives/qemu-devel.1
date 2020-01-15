Return-Path: <SRS0=2fDQ=3E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D90CC33CB1
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2020 09:34:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 421FD207FF
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2020 09:34:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QpcdzuJe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 421FD207FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51368 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1irf4j-00015p-DV
	for qemu-devel@archiver.kernel.org; Wed, 15 Jan 2020 04:34:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54497)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dinechin@redhat.com>) id 1irf46-0000QY-GD
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 04:34:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dinechin@redhat.com>) id 1irf45-000826-03
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 04:34:18 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:20757
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dinechin@redhat.com>) id 1irf44-00081D-8R
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 04:34:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579080855;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/5R/EM7+8oZzm6emlCywCxQA+jQ4Yf8dujRC1xZDrD8=;
 b=QpcdzuJeBoKdMBGRudQs5tnglo6V3v5bjvp8TTbBTCk/rXvlQQIm7RAR3hW6ETMfHlbXAr
 9fNkT1tQFt0dcYRVzvljlW81Sru5EmComdS6QRrUOXHy2grGWaRn0gYzgEXyzVeEp9yO7+
 FF5TPMafOjFe7MUOwe674fOuNfQ/kg4=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-103-200IvHKWMAmhCbYNmQKmDg-1; Wed, 15 Jan 2020 04:34:12 -0500
Received: by mail-wm1-f72.google.com with SMTP id f25so4368941wmb.1
 for <qemu-devel@nongnu.org>; Wed, 15 Jan 2020 01:34:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
 :content-transfer-encoding:message-id:references:to;
 bh=345KThtqDvTbht6FqGlcLVspOdtI/b+EbFj3AIf2biA=;
 b=gD3q1f92fRBdUCx0VdRxSRvrrzLF9j+aw/7nsdo/FkVvo2GJd9pZuJeL+D87GpT02Y
 wYB60NP1PWP2l0iqOk0179aXxnpp0qeF841LEtBnvHdpyD2NzbamcnWxeWtmdvfPWr7z
 GPF+Rmn9zIFTvnuah4UmELMHb4Rz5gfvkfYKOQpwvumxa0xf4G1Sf5LNGzTt7gYyuqgK
 2n/sSBHOpaFT40rWWcQfFHMMul/voGPM87zEcPBv4Mz7+AI05DXJ564m+q0oRjV1Yd+l
 rKTvR+FxQDYHE7vrjl5JqgzAXFkNvHbDG7sh9BrZh1tOdL6vjkpIvXjUZPva5NBNjFYj
 Hvlw==
X-Gm-Message-State: APjAAAXuiHT5ZLKlCDmXjlW1bNNp6gwOkixGVn4iwfp9tGlMITT6ffCD
 eBUG+VzYhKx1RQrr8ZoLFxo4A1M5reuhcGqkf/egFhoYmJy0cxv0W15zoJWM5JP7Yj4oF4+Q73K
 DzMr6ct3L8+qH9R4=
X-Received: by 2002:a7b:c10f:: with SMTP id w15mr31408264wmi.69.1579080851141; 
 Wed, 15 Jan 2020 01:34:11 -0800 (PST)
X-Google-Smtp-Source: APXvYqzAVGjxyuvEyvnpetIfl1dMYFTUpzyT4IIfDw2R2aM9EmHU4oM7b3d3ZctUWEbn5ioSKBqC9A==
X-Received: by 2002:a7b:c10f:: with SMTP id w15mr31408244wmi.69.1579080850934; 
 Wed, 15 Jan 2020 01:34:10 -0800 (PST)
Received: from ?IPv6:2a01:e0a:466:71c0:7440:4d06:49b0:1f79?
 ([2a01:e0a:466:71c0:7440:4d06:49b0:1f79])
 by smtp.gmail.com with ESMTPSA id 2sm23268821wrq.31.2020.01.15.01.34.09
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 15 Jan 2020 01:34:10 -0800 (PST)
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3608.40.2.2.4\))
Subject: Re: Making QEMU easier for management tools and applications
From: Christophe de Dinechin <dinechin@redhat.com>
In-Reply-To: <87o8v52hz9.fsf@dusky.pond.sub.org>
Date: Wed, 15 Jan 2020 10:34:09 +0100
Message-Id: <8CF8359B-1E52-4F7A-944E-C1C14FEC4F92@redhat.com>
References: <CAJSP0QUk=4co-nqk8fv2n-T2_W40rE3r_5OMoxD7otAV993mCA@mail.gmail.com>
 <1EFEF446-AFEA-429F-B6BA-3206A7C41836@redhat.com>
 <20200108104306.GC5057@dhcp-200-226.str.redhat.com>
 <97F153BD-FB8A-46C7-90D0-9E894B9E0292@redhat.com>
 <20200108133842.GE5057@dhcp-200-226.str.redhat.com>
 <87d0bmchq0.fsf@dusky.pond.sub.org>
 <1B253197-5592-472A-AA26-E0614A13C91A@redhat.com>
 <87o8v52hz9.fsf@dusky.pond.sub.org>
To: Markus Armbruster <armbru@redhat.com>
X-Mailer: Apple Mail (2.3608.40.2.2.4)
X-MC-Unique: 200IvHKWMAmhCbYNmQKmDg-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain;
	charset=utf-8
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 "Denis V. Lunev" <den@virtuozzo.com>, Stefan Hajnoczi <stefanha@gmail.com>,
 qemu-devel <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 John Snow <jsnow@redhat.com>, Dominik Csapak <d.csapak@proxmox.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Thanks a bunch. This clarifies a number of my misconceptions about
how this is currently used. Most notably this one:

> On 15 Jan 2020, at 10:20, Markus Armbruster <armbru@redhat.com> wrote:
>=20
>> We don=E2=80=99t want the QAPI to let arbitrary fields of a QOM object
>> be modified, do we?
>=20
> We already do: QMP command qom-set.  If it breaks your guest, you get to
> keep the pieces.

Ouch. I certainly did not expect that.

"It is not what you don=E2=80=99t know that kills you, it is what you know =
that ain=E2=80=99t so".

>=20
>>> http://dreamsongs.com/RiseOfWorseIsBetter.html
>>=20
>> You know that I positively hate this ;-)
>=20
> It's been a tough lesson for me, too.

Not sure I can call it a =E2=80=9Clesson=E2=80=9D. Much like a philosophy t=
o fight against, IMO.


>> Well, I guess we can expand the schema. #ILoveJSON.
>=20
> Basing the QAPI language on JSON was a poor choice.  Not sure that's
> fixable at a reasonable cost.

Well, at least now I have a slightly better understanding of the related co=
sts
and trade-offs. Thanks a lot for explaining.


Christophe


