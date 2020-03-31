Return-Path: <SRS0=xFA2=5Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32F2FC43331
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 11:47:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F296E206DB
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 11:47:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=livius-net.20150623.gappssmtp.com header.i=@livius-net.20150623.gappssmtp.com header.b="WItcqqZd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F296E206DB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=livius.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36512 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJFMs-0004Rk-4x
	for qemu-devel@archiver.kernel.org; Tue, 31 Mar 2020 07:47:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58858)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ilg@livius.net>) id 1jJFLu-0003ZA-2d
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 07:46:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ilg@livius.net>) id 1jJFLt-0006NZ-5k
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 07:46:42 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f]:40471)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <ilg@livius.net>) id 1jJFLs-0006MF-PT
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 07:46:41 -0400
Received: by mail-wr1-x42f.google.com with SMTP id u10so25507223wro.7
 for <qemu-devel@nongnu.org>; Tue, 31 Mar 2020 04:46:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=livius-net.20150623.gappssmtp.com; s=20150623;
 h=mime-version:subject:from:in-reply-to:date:cc
 :content-transfer-encoding:message-id:references:to;
 bh=ID3OF0D7ksoHqFgY29umU/92ptoRUrooX986nqcNHRo=;
 b=WItcqqZdIN+yYDqqclnmcJKbMvaCj0g0V3aqQnQ72vSixPX1G9vYNOM2JpkW7/C/ha
 9Jz2dMWe7C9Sm97qVqbhVIHG42WG/vsFh64qh+3O09WExcMgnI49suZZhVoPDFrMYlAc
 niUtcBSqUpT8A56KdFzr1/hajIu/w52Cu8FYWZ0l8wFRnqm+sqv54z+p4nqOzw/ubPSk
 xue4e1yaAWkXkffstOXaoDmXZ9W8iVp+R/42/QGsIGOO3qB5IjyZccLJXJFOV8l+KIds
 RedZhIj/sIh20fmOHg4AIhc468uNMnjP88ZkKJBlUbd+/W5V08S+npEOPSehhqN9XOGP
 nnPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
 :content-transfer-encoding:message-id:references:to;
 bh=ID3OF0D7ksoHqFgY29umU/92ptoRUrooX986nqcNHRo=;
 b=GsSswsjNUaHetgJbhgwBWqHmU2LlHssXyuw/KLWGHBzcvmkGz/J9Ymvqd+lwARJN1S
 vaiEGCqKc1WRUFvdpXeH5KEa7re2fXHU34uq/eK8fiQN+YhsjGCxscK2fCHaNwQGPzYw
 //VACGoI2m8UK2ylUbpOIf/dHtvURnLR2XVjmKL90RG23/Jnnqbk9us417wX2swE7lJu
 kKM+nUguNTYiEgDeRpkyjWdOyK4vvEdqC34A8I8aNQW1UtJ8rqoZaQhLzy+lNyJyhh3w
 bRjJPTLDSJ94bwmFEteG/qGTYdLl04QaaPA6M0LEJ6rfVwuaIBpxMOsix32S4BiXgj8w
 xYZg==
X-Gm-Message-State: ANhLgQ0q17gjKE3lYGBL0Gl7vbCz/dXnh430ArmODNmHmOEBFSj3RDL0
 n2MElvie+q78qMGXGv4G9Sj9Tg==
X-Google-Smtp-Source: ADFU+vuye+wfO7Nei+k0bwJFhn4WaKMm1ONm2e5AU2T6rr9OAYIQgOrXH/Q6V7zXU8u8DsltyauFwA==
X-Received: by 2002:a5d:510d:: with SMTP id s13mr19724307wrt.110.1585655199422; 
 Tue, 31 Mar 2020 04:46:39 -0700 (PDT)
Received: from wks.local (5-12-53-142.residential.rdsnet.ro. [5.12.53.142])
 by smtp.gmail.com with ESMTPSA id a13sm18940699wrt.64.2020.03.31.04.46.38
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 31 Mar 2020 04:46:38 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: deprecation of in-tree builds
From: Liviu Ionescu <ilg@livius.net>
In-Reply-To: <CAFEAcA-KKd0bjE17MPPFv45=S+x3jUj9uA6_UQmb7ts-yu5Ong@mail.gmail.com>
Date: Tue, 31 Mar 2020 14:46:37 +0300
Content-Transfer-Encoding: quoted-printable
Message-Id: <C0360478-EBDE-419B-9917-2EFAC580BEF3@livius.net>
References: <CAFEAcA8E6goDHb-7kKCTp=wSpBsuJcfjMmLP0EgymiEL348r4A@mail.gmail.com>
 <87v9mmug73.fsf@dusky.pond.sub.org>
 <CAFEAcA-9U=EAXAtPDh_AnO3eUbM_jcRBuf4x=0Rec0EC-v2mNA@mail.gmail.com>
 <20200330134212.GO236854@redhat.com> <20200330143759.GD6139@linux.fritz.box>
 <c0a1dc94-c3f2-696e-743f-aa15ef995094@redhat.com>
 <2D490715-F32F-4A34-A31F-5709B28FB6CA@livius.net>
 <CAFEAcA-KKd0bjE17MPPFv45=S+x3jUj9uA6_UQmb7ts-yu5Ong@mail.gmail.com>
To: Peter Maydell <peter.maydell@linaro.org>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42f
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
Cc: Kevin Wolf <kwolf@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?utf-8?B?IkRhbmllbCBQLiBCZXJyYW5nw6ki?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



> On 31 Mar 2020, at 13:19, Peter Maydell <peter.maydell@linaro.org> =
wrote:
>=20
>=20
> ... the behaviour
> if they're run from some other (manually created) build directory
> would remain as it is today.

Great!

Then for now a strongly worded warning displayed at the end of the build =
(to be clearly visible) should do it, and after a while a possible =
change to meson or any other solution that uses a separate build folder =
would not surprise anyone.

The latest version of the xPack Build Box (v3.1) includes Python 3, =
meson, ninja, cmake, gcc 9, and generally all modern tools, so I guess =
building an updated QEMU would not be a problem.


Regards,

Liviu


