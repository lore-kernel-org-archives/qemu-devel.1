Return-Path: <SRS0=EylP=Y6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1FAAC5DF64
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2019 16:08:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 637752075C
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2019 16:08:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="d7d5Dw9n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 637752075C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60674 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iSNqh-0003d1-UV
	for qemu-devel@archiver.kernel.org; Wed, 06 Nov 2019 11:07:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54134)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iSNoE-0001Mb-7v
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 11:05:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iSNo9-0002K9-QU
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 11:05:25 -0500
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:33203)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iSNo8-0002GP-6T
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 11:05:21 -0500
Received: by mail-oi1-x244.google.com with SMTP id m193so21461206oig.0
 for <qemu-devel@nongnu.org>; Wed, 06 Nov 2019 08:05:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=64hrqu/vQ7OGvSnY8/7zVhi3gVactcah6O2vkBSklxU=;
 b=d7d5Dw9nF/6TQzt9V1ffLuSjskOslEzvqNlh1RpFiAeB2bkuGo7IggeGunMLB+gfKq
 WXzLJaIgWmVGVl4v0NAO9pDw6MqnDIB9cWsdxF4cIvCD1D2vk1W74+WiSivAZ9UrTwJs
 MCEmvOwWKc3nZZgrKRkekhxpXX9XY+TbLfh0Tpi7+1TtUrxYgXnvC8JuX+8M3b09BUT8
 7dnl7QbjcmjQxw5NhA6h4JfwZf3uv7gFWd8FhQHTeYnaZKFLiOO40x1wqGtsH1VH0yNE
 40cT/+J42y9Fohw2egk+Mn2hiXtOjKjeJMIhZR1yAJEl9p/IvQXA0T3gaASxpMZnMkCJ
 21Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=64hrqu/vQ7OGvSnY8/7zVhi3gVactcah6O2vkBSklxU=;
 b=juDCDdALyiQsjIsvxbrIUvG7kUH1rf/R5MPG/Pv4of5ZQnOHwcxEGTzV/KVkEuvw1o
 RQoB9qoH0jC24SXzCQzN4xDHQMvsC8qtFBvEjVDfcVWVBCEKss4p5crbIrkUEmPxSvte
 zFr+02tdZ0CcAD1Rkmddi1FvdTCnEJE61t8tc+kZNIE6h36PHBeWjQWnnpEMoyh15tLx
 EbgfTbMpqgovZjPY839aaLLLbt6IULhYzMVZSz6bUTiZmXIlS/E9XNqZOXo4Qv370LRq
 OShQoLkATzgUjc6bZUEP+Ric9mjAUBjhRCe+3eHBa7S6MO+oakQG2fmWzDG7r73vT5C1
 ddYQ==
X-Gm-Message-State: APjAAAX5t/L814waakcWw+IqKLUmS2ocb7bxtjBs93cvRAK2sd+Gi3J2
 67AntKLe1WxmZC6+ajSJOg3tiVTiTMU6ITjgxfh+MA==
X-Google-Smtp-Source: APXvYqzaP+yWEF70z/KqKnujAWBTvm5aQj4wddRKM2S8f+/Ktf47uuMJ2MIJorOjYeG4oii0EHkQg647ftJDLFR3dII=
X-Received: by 2002:aca:3e8a:: with SMTP id l132mr2762720oia.146.1573056319217; 
 Wed, 06 Nov 2019 08:05:19 -0800 (PST)
MIME-Version: 1.0
References: <157298160814.27285.16893877491189017648@37313f22b938>
 <73852c81-87b7-e5f5-4041-d24f078cc7fa@vivier.eu>
In-Reply-To: <73852c81-87b7-e5f5-4041-d24f078cc7fa@vivier.eu>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 6 Nov 2019 16:05:08 +0000
Message-ID: <CAFEAcA8SvSGCZsYT1LmN1cP1BjVDPqLP90yW9TCbvVA=kmyqBw@mail.gmail.com>
Subject: Re: [Xen-devel] [PULL v2 0/3] Trivial branch patches
To: Laurent Vivier <laurent@vivier.eu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::244
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
Cc: Stefano Stabellini <sstabellini@kernel.org>,
 Eduardo Habkost <ehabkost@redhat.com>, Paul Durrant <paul@xen.org>,
 QEMU Trivial <qemu-trivial@nongnu.org>, Michael Tokarev <mjt@tls.msk.ru>,
 Claudio Fontana <claudio.fontana@huawei.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Fabien Chouteau <chouteau@adacore.com>,
 "open list:X86" <xen-devel@lists.xenproject.org>,
 KONRAD Frederic <frederic.konrad@adacore.com>, qemu-arm <qemu-arm@nongnu.org>,
 qemu-ppc <qemu-ppc@nongnu.org>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 Cleber Rosa <crosa@redhat.com>, Anthony PERARD <anthony.perard@citrix.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 5 Nov 2019 at 20:06, Laurent Vivier <laurent@vivier.eu> wrote:
>
> Le 05/11/2019 =C3=A0 20:20, no-reply@patchew.org a =C3=A9crit :
> > Patchew URL: https://patchew.org/QEMU/20191105175010.2591-1-laurent@viv=
ier.eu/
> >
> >
> >
> > Hi,
> >
> > This series seems to have some coding style problems. See output below =
for
> > more information:
> >
> > Subject: [Xen-devel] [PULL v2 0/3] Trivial branch patches
> > Type: series
> > Message-id: 20191105175010.2591-1-laurent@vivier.eu
> >
> > =3D=3D=3D TEST SCRIPT BEGIN =3D=3D=3D
> > #!/bin/bash
> > git rev-parse base > /dev/null || exit 0
> > git config --local diff.renamelimit 0
> > git config --local diff.renames True
> > git config --local diff.algorithm histogram
> > ./scripts/checkpatch.pl --mailback base..
> > =3D=3D=3D TEST SCRIPT END =3D=3D=3D
> >
> > Switched to a new branch 'test'
> > 49a55f7 global: Squash 'the the'
> > c0b5513 hw/misc/grlib_ahb_apb_pnp: Fix 8-bit accesses
> > eb43395 hw/misc/grlib_ahb_apb_pnp: Avoid crash when writing to PnP regi=
sters
> >
> > =3D=3D=3D OUTPUT BEGIN =3D=3D=3D
> > 1/3 Checking commit eb43395bf8f1 (hw/misc/grlib_ahb_apb_pnp: Avoid cras=
h when writing to PnP registers)
> > 2/3 Checking commit c0b5513f971a (hw/misc/grlib_ahb_apb_pnp: Fix 8-bit =
accesses)
> > 3/3 Checking commit 49a55f7feb19 (global: Squash 'the the')
> > ERROR: do not use C99 // comments
> > #26: FILE: disas/libvixl/vixl/invalset.h:105:
> > +  // Note that this does not mean the backing storage is empty: it can=
 still
>
> As reported by David Gilbert, this is a false positive as this file is a
> C++ file.

True, but it's also a third-party dependency that we have
taken a copy of. If we care about fixing its typos in comments
we should do that by submitting the fixes upstream. We should
avoid making changes to our local copy of this code because
it just makes it unnecessarily more difficult to do updates to
newer versions.

Could you drop that change, please? (Sorry I didn't notice
it going by when the patch was originally on list.)

thanks
-- PMM

