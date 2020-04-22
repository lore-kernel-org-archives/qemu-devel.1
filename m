Return-Path: <SRS0=gSpC=6G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED144C55185
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 17:45:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B947C2075A
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 17:45:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DKc7O0QV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B947C2075A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55194 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRJR8-00050d-JT
	for qemu-devel@archiver.kernel.org; Wed, 22 Apr 2020 13:45:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39698)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jRJPR-0003QH-ON
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 13:43:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jRJPR-00072h-Bb
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 13:43:41 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:38722
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jRJPQ-00070E-Lh
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 13:43:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587577419;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hHXTQbHTk/GqfkhzXqY9YnXuAZpapaywKPSFwdmxyTg=;
 b=DKc7O0QVv6kI2UuePwT5wNWlaMDiZ4IW8xKg9Bp+LCunth1d7V8lHSnkS3W9WomZ7wZrVq
 cqY6Y2U5xz4r7y9NVCp7ZkVVCWMicRUxcyB0Jvp4yh6gdekxf3kEKFElMLB0/kDfqU0O8k
 zGetGnE24GpkkATyghI3h+YfL35YYkg=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-456-FoXZ856OOf6DKArPIps_Mg-1; Wed, 22 Apr 2020 13:43:34 -0400
X-MC-Unique: FoXZ856OOf6DKArPIps_Mg-1
Received: by mail-wr1-f70.google.com with SMTP id j22so1439862wrb.4
 for <qemu-devel@nongnu.org>; Wed, 22 Apr 2020 10:43:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=hHXTQbHTk/GqfkhzXqY9YnXuAZpapaywKPSFwdmxyTg=;
 b=f9LQPEHznRhiFbZgB/0kBrsxwlWDuR0NNeYAnkRQftyISXOf0vtoy7GOk1xKhoX7fC
 ohNzM2F3Yg/G4SWCCfvR5ci5BHdD/hCF2rR5aSxlnvjGuA3SvbBWzkZJu87HpEIU/lMw
 moCDOvquUncjw5hZqg2a0roGhKt/q+9ivKcmi4cLmdBEakRXSzlwwWOfqA+C5Ab6SRe+
 hfa5Dj2V1a5nS7Cz/PtjMPt5i2RWAF4NEK/rkM/YSFGSrd6qp0soQRodJCJk7L2wGnsB
 y3Vx0i8Xk2pOHGEGncTP7lmH7OHu2VKWwlNxENiQbE5SmN1hLt6aMCkrxEsh4KwX4VLf
 ct0A==
X-Gm-Message-State: AGi0PuY72F9rlZjurdMSglR6O04gf7JYKHZgVLwA+zto+YY0pS6Ed3d3
 OrgePgEt3QiKiTw2QMztzFydMTQ9z7MRDaCTVQsgJFqjqPBzXcgryJXgXoktKbBL0m6OHdyMnyk
 aNf6Qfs1QAomZPsM80DaafKNVxhbtJVU=
X-Received: by 2002:adf:9d8d:: with SMTP id p13mr169764wre.17.1587577412864;
 Wed, 22 Apr 2020 10:43:32 -0700 (PDT)
X-Google-Smtp-Source: APiQypLHIdZNTA5Qo+6qhgM1s9lyQlpGuMsfi4PD4zsnP047Ln0xS15IabvKhmK0Xti7hmzli09KMbXlB7GzQhF2S4A=
X-Received: by 2002:adf:9d8d:: with SMTP id p13mr169751wre.17.1587577412671;
 Wed, 22 Apr 2020 10:43:32 -0700 (PDT)
MIME-Version: 1.0
References: <20200422124501.28015-1-peter.maydell@linaro.org>
 <b6dd8d4a-ec38-84c5-eb94-cf25bfa4cf4a@redhat.com>
In-Reply-To: <b6dd8d4a-ec38-84c5-eb94-cf25bfa4cf4a@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Date: Wed, 22 Apr 2020 19:43:21 +0200
Message-ID: <CAP+75-XS1Xo0HCEADP6ppKNbKNz6Se9n_8vWQ9OaoNDtGw0D0A@mail.gmail.com>
Subject: Re: [PATCH for-5.0?] target/arm: Fix ID_MMFR4 value on AArch64 'max'
 CPU
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm <qemu-arm@nongnu.org>, 
 QEMU Developers <qemu-devel@nongnu.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/22 04:15:03
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
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
Cc: Laurent Desnogues <laurent.desnogues@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Apr 22, 2020 at 7:41 PM Philippe Mathieu-Daud=C3=A9
<philmd@redhat.com> wrote:
>
> On 4/22/20 2:45 PM, Peter Maydell wrote:
> > In commit 41a4bf1feab098da4cd the added code to set the CNP
> > field in ID_MMFR4 for the AArch64 'max' CPU had a typo
> > where it used the wrong variable name, resulting in ID_MMFR4
> > fields AC2, XNX and LSM being wrong. Fix the typo.
> >
> > Fixes: 41a4bf1feab098da4cd
> > Reported-by: Laurent Desnogues <laurent.desnogues@gmail.com>
>
> Nice testing/catch Laurent!
>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>
> > Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> > ---
> > maybe 5.0 just because it's so trivial. I dunno...

BTW FWIW LGTM...

> >
> > There's also an error where we use the uint32_t u variable
> > to update the 64-bit ID_AA64DFR0 register, but that's harmless
> > because as it happens the top 32 bits of that register are
> > all zeroes anyway, so we can just fix that in 5.1.
> >
> >   target/arm/cpu64.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
> > index 62d36f9e8d3..95d0c8c101a 100644
> > --- a/target/arm/cpu64.c
> > +++ b/target/arm/cpu64.c
> > @@ -705,7 +705,7 @@ static void aarch64_max_initfn(Object *obj)
> >           u =3D cpu->isar.id_mmfr4;
> >           u =3D FIELD_DP32(u, ID_MMFR4, HPDS, 1); /* AA32HPD */
> >           u =3D FIELD_DP32(u, ID_MMFR4, AC2, 1); /* ACTLR2, HACTLR2 */
> > -        u =3D FIELD_DP32(t, ID_MMFR4, CNP, 1); /* TTCNP */
> > +        u =3D FIELD_DP32(u, ID_MMFR4, CNP, 1); /* TTCNP */
> >           cpu->isar.id_mmfr4 =3D u;
> >
> >           u =3D cpu->isar.id_aa64dfr0;
> >


