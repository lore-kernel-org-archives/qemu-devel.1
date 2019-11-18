Return-Path: <SRS0=QE2o=ZK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03311C432C0
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2019 09:30:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 079A020727
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2019 09:30:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J/4SPSmF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 079A020727
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59810 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iWdMZ-0007ET-2N
	for qemu-devel@archiver.kernel.org; Mon, 18 Nov 2019 04:30:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57820)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1iWdKy-0005d5-VN
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 04:28:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1iWdKw-0002Es-SM
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 04:28:48 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:43544
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1iWdKv-0002Dv-0v
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 04:28:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574069323;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6Kze7EjqHz2x8M5LJP/hDy14ZIsaUbWcT6huNuAPxCQ=;
 b=J/4SPSmFkp1Wv34NtDz7reLZmmYLrqSoWMuZoJrdHz84Y+5X9Kkr1yLNJuT4qo/KYWmJ7J
 /xaEr9LW0497rrhIp607LyhPE2KX1x3NdIg24PqDMcn7zgYpnQB0LqwWfLCoH3UELe/KHb
 MBl7AOD47NDXxFXuCaauTiEUmHoMqEA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-226-9OzgfVruMH-UTtAaPUxInQ-1; Mon, 18 Nov 2019 04:28:42 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5F9681800D7D;
 Mon, 18 Nov 2019 09:28:41 +0000 (UTC)
Received: from localhost.localdomain (ovpn-116-200.ams2.redhat.com
 [10.36.116.200])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A736E19C6A;
 Mon, 18 Nov 2019 09:28:31 +0000 (UTC)
Subject: Re: [PATCH for-4.2] hw/i386: Fix compiler warning when CONFIG_IDE_ISA
 is disabled
To: Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
References: <20191115145049.26868-1-thuth@redhat.com>
 <CAFEAcA-EuQVBtr=BCE5sdHo+LMv8XchHUSPM=CgSYxPVryWKZg@mail.gmail.com>
 <273a3123-9eef-c78e-5b83-833a21e3988c@redhat.com>
 <CAFEAcA9N+T=M=5-xb3ahRMqD6oxhm5Lx55-1Mtk1vXsRJEomwA@mail.gmail.com>
 <85b5fbcc-e06b-7ce2-0a97-7fdc156915cd@redhat.com>
 <21520139-af31-6ca7-c505-9252ca2bacde@redhat.com>
 <874kz1y1sj.fsf@dusky.pond.sub.org>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <585e0317-d172-1bc9-e724-1cab2c7d2d63@redhat.com>
Date: Mon, 18 Nov 2019 10:28:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <874kz1y1sj.fsf@dusky.pond.sub.org>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: 9OzgfVruMH-UTtAaPUxInQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
 Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 QEMU Trivial <qemu-trivial@nongnu.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 18/11/2019 10.25, Markus Armbruster wrote:
> Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:
>=20
> [...]
>> The related question is, is it OK to use size_t to iterate over an array=
?
>>
>>   for (size_t i =3D 0; i < ARRAY_SIZE(array); i++) {
>>     ...
>>   }
>=20
> My rule of thumb on integer types is "whatever lets me avoid
> not-obviously-safe conversions (implicit ones in particular) with the
> least type cast clutter.
>=20
> Quite often, int fits the bill.  But not always.
>=20
> To reply to your example: depends on what's hiding in the ... :)

The problem here is that ARRAY_SIZE() gives you an size_t, so the
compiler might complain about comparing signed int with unsigned size_t.

Thus if i is only used as array index in the "..." part, I think it's
fine to use size_t for i here.

 Thomas


