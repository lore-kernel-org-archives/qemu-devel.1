Return-Path: <SRS0=/cID=ZR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83296C432C3
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2019 18:53:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 559DF20748
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2019 18:53:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TWt2tDu5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 559DF20748
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47454 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZJUM-0006kY-EN
	for qemu-devel@archiver.kernel.org; Mon, 25 Nov 2019 13:53:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40301)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1iZJSV-0005uG-VF
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 13:51:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1iZJSU-0002KT-OO
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 13:51:39 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:32033
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1iZJSU-0002Ju-Ko
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 13:51:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574707897;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp:autocrypt:autocrypt;
 bh=Gf3rVB3JnHWiRiGkSl6PZZwVfSoCM8W4N1WtxLCLo/8=;
 b=TWt2tDu5hb2KjZ4XY1ydYddtNzvPGqWYjJpRZSBhBbqia4rZ82UjjptLd/6yKhaEqfbJ4Q
 mwaeSNapDNsIGDe5raRcT+Cpz/s9WRo60Ykx59Nb6QOgXo/RZjgxZAmZQHGkiD9I5xiMK2
 Q6/9Z2DkiLEncKAAWD9XqL88USFQaC0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-281-Ep-9eOM6MTWqtKNHEXMa0w-1; Mon, 25 Nov 2019 13:51:34 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B7F87107B280;
 Mon, 25 Nov 2019 18:51:32 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-116-20.ams2.redhat.com [10.36.116.20])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8E1E35D9CA;
 Mon, 25 Nov 2019 18:51:27 +0000 (UTC)
Subject: Re: [PATCH v36 01/17] target/avr: Add outward facing interfaces and
 core CPU logic
To: Aleksandar Markovic <aleksandar.m.mail@gmail.com>,
 Michael Rolnik <mrolnik@gmail.com>, Peter Maydell <peter.maydell@linaro.org>
References: <20191124050225.30351-1-mrolnik@gmail.com>
 <20191124050225.30351-2-mrolnik@gmail.com>
 <CAL1e-=iiu+8a60SY=83CTSQfPZ+aOsGoZhJNMOLGtmLq8a90OA@mail.gmail.com>
From: Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=thuth@redhat.com; prefer-encrypt=mutual; keydata=
 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
Organization: Red Hat
Message-ID: <4ac75c83-ee30-e93c-c8f1-5f83df588e0d@redhat.com>
Date: Mon, 25 Nov 2019 19:51:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CAL1e-=iiu+8a60SY=83CTSQfPZ+aOsGoZhJNMOLGtmLq8a90OA@mail.gmail.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: Ep-9eOM6MTWqtKNHEXMa0w-1
X-Mimecast-Spam-Score: 0
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
Cc: Sarah Harris <S.E.Harris@kent.ac.uk>,
 "richard.henderson@linaro.org" <richard.henderson@linaro.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "dovgaluk@ispras.ru" <dovgaluk@ispras.ru>,
 "imammedo@redhat.com" <imammedo@redhat.com>,
 "philmd@redhat.com" <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 24/11/2019 16.17, Aleksandar Markovic wrote:
>=20
>=20
> On Sunday, November 24, 2019, Michael Rolnik <mrolnik@gmail.com
> <mailto:mrolnik@gmail.com>> wrote:
>=20
>     This includes:
>     - CPU data structures
>     - object model classes and functions
>     - migration functions
>     - GDB hooks
>=20
>     Co-developed-by: Michael Rolnik <mrolnik@gmail.com
>     <mailto:mrolnik@gmail.com>>
>     Co-developed-by: Sarah Harris <S.E.Harris@kent.ac.uk
>     <mailto:S.E.Harris@kent.ac.uk>>
>     Signed-off-by: Michael Rolnik <mrolnik@gmail.com
>     <mailto:mrolnik@gmail.com>>
>     Signed-off-by: Sarah Harris <S.E.Harris@kent.ac.uk
>     <mailto:S.E.Harris@kent.ac.uk>>
>     Signed-off-by: Michael Rolnik <mrolnik@gmail.com
>     <mailto:mrolnik@gmail.com>>
>     Acked-by: Igor Mammedov <imammedo@redhat.com
>     <mailto:imammedo@redhat.com>>
>     ---
>     =C2=A0target/avr/cpu-param.h |=C2=A0 37 +++
>     =C2=A0target/avr/cpu-qom.h=C2=A0 =C2=A0|=C2=A0 54 ++++
>     =C2=A0target/avr/cpu.h=C2=A0 =C2=A0 =C2=A0 =C2=A0| 253 ++++++++++++++=
++++
>     =C2=A0target/avr/cpu.c=C2=A0 =C2=A0 =C2=A0 =C2=A0| 576 ++++++++++++++=
+++++++++++++++++++++++++++
>     =C2=A0target/avr/gdbstub.c=C2=A0 =C2=A0|=C2=A0 85 ++++++
>     =C2=A0target/avr/machine.c=C2=A0 =C2=A0| 121 +++++++++
>     =C2=A0gdb-xml/avr-cpu.xml=C2=A0 =C2=A0 |=C2=A0 49 ++++
>     =C2=A07 files changed, 1175 insertions(+)
>     =C2=A0create mode 100644 target/avr/cpu-param.h
>     =C2=A0create mode 100644 target/avr/cpu-qom.h
>     =C2=A0create mode 100644 target/avr/cpu.h
>     =C2=A0create mode 100644 target/avr/cpu.c
>     =C2=A0create mode 100644 target/avr/gdbstub.c
>     =C2=A0create mode 100644 target/avr/machine.c
>     =C2=A0create mode 100644 gdb-xml/avr-cpu.xml
>=20
>     diff --git a/target/avr/cpu-param.h b/target/avr/cpu-param.h
>     new file mode 100644
>     index 0000000000..ccd1ea3429
>     --- /dev/null
>     +++ b/target/avr/cpu-param.h
>     @@ -0,0 +1,37 @@
>     +/*
>     + * QEMU AVR CPU
>     + *
>     + * Copyright (c) 2019 Michael Rolnik
>     + *
>     + * This library is free software; you can redistribute it and/or
>     + * modify it under the terms of the GNU Lesser General Public
>     + * License as published by the Free Software Foundation; either
>     + * version 2.1 of the License, or (at your option) any later version=
.
>     + *
>=20
>=20
> I think version 2 would be more fitting to QEMU ovarall license than 2.1
> (see LICENCE file in QEMU root dir).
>=20
> Peter, am I right or wrong regarding GPL 2 vs. 2.1 (My interpretation is
> that 2 is the best "default" for new files)? The wording in "LICENSE" is
> frankly not entirely clear, and I see many new files using 2.1.

 Hi Aleksandar,

I think you mix up GPL and LGPL here. This file is licensed under the
LGPL, so version 2.1 is perfectly fine here (see COPYING.LIB in the root
directory). For the GPL, there was never a 2.1, so if it would be GPL,
version 2 would be appropriate. Bit since it's LGPL, 2.1 is better indeed.

 Thomas


