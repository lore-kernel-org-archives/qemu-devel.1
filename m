Return-Path: <SRS0=Oie8=3L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60158C33CAF
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2020 13:33:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2DBB120678
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2020 13:33:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RSLskVoE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DBB120678
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42174 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuG8c-0000g3-Ue
	for qemu-devel@archiver.kernel.org; Wed, 22 Jan 2020 08:33:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52387)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iuG3k-0004s3-F1
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 08:28:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iuG3i-0004qs-1a
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 08:28:40 -0500
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:44376)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iuG3h-0004qK-SC
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 08:28:37 -0500
Received: by mail-oi1-x242.google.com with SMTP id d62so6006083oia.11
 for <qemu-devel@nongnu.org>; Wed, 22 Jan 2020 05:28:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=nj5/JFGkuNmhbYNJI2neFZKn/iL1lGFSBQotaijA4vg=;
 b=RSLskVoEqzmAygTNAnF7szhzvI1jnEzyhxfbAtlCOO59WuoA5VjTJ0Jq6g6GJQCGpe
 CSmh18PFLxbCA/vEKms6YjVm/6J7hMNqqr2K/lLOhJ00Q2Lnrc1BZ5gPkzQA4Uu+dqh/
 HnnmnD9UAnKt4lrNj/+3TdO77LLG5ZrYo1lz0v0Z7k9eZmeC+TX5ssEiqbPL681NXIAy
 D4fYwdii7s81zH069NPSCUiljZ8gybiJuyir6EwIGBO7QVlQO08veRYOySNBVnd7OQJc
 RcDeZ8FFUrl5cYi7sfVSY9RdQzvHjRdlvaNNoRmP0uNIu65zIM5Xg6Z4YMP1Zz0dg96k
 caYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=nj5/JFGkuNmhbYNJI2neFZKn/iL1lGFSBQotaijA4vg=;
 b=MJEtpLhpd2AzCCv1GBY3IRDL33EqU9GFn+ALVw2yC3hUbxkgLlArQSUsr6Qqc2pNot
 o2vcsfNej15KpGIWKWbW4HX+YJeJa2TQ5P9gxPtjZz4vFl682x0+4yYZA3/e/0Y8sQjH
 pexI9uUJELZv4H4z+xrBQIOIjznNJeTQi36e//eNYxo5hTRgbq4J7dnQ4cWJB5293175
 p1BWGriz3/lH91RHiIkBcf+xmYTVbs+vKdXm6u09OKFcbQh7iDjRRZZmdHwwXACfWDwa
 H1PRzHvhq9Sn/ADFJxypEDc2Q1C8fjcvRwgsDoZr3/8P4ULKcKmoQV+30cYxTDOJj/Ho
 P4mQ==
X-Gm-Message-State: APjAAAUbcedkCkkijy2tw3HThtqUm2IkzFGFKmXhi3LQHhlHgYIP9z1X
 2IPIHnbh2eAYhaxam5BzVJqQEBV6Pc4MQB9NnuRT1w==
X-Google-Smtp-Source: APXvYqziGgg9O/ldhnjpF2XyhL5GcrV4yroK4s5uMTrdVx1BVSmgsYatxq1M/0cPTA2tR4i/IwNAdcSlinC6jAGlxF8=
X-Received: by 2002:aca:3d7:: with SMTP id 206mr6982046oid.98.1579699716028;
 Wed, 22 Jan 2020 05:28:36 -0800 (PST)
MIME-Version: 1.0
References: <87d0bmchq0.fsf@dusky.pond.sub.org>
 <1B253197-5592-472A-AA26-E0614A13C91A@redhat.com>
 <87o8v52hz9.fsf@dusky.pond.sub.org>
 <8CF8359B-1E52-4F7A-944E-C1C14FEC4F92@redhat.com>
 <87r200zzje.fsf@dusky.pond.sub.org>
 <20200120100849.GB345995@stefanha-x1.localdomain>
 <871rrtmkko.fsf@dusky.pond.sub.org>
 <20200121113224.GD630615@stefanha-x1.localdomain>
 <CAJ+F1C+anMuBE6pOu8JNOoaNnDw8a47Dc1f6MhnxH=rRNqMF=Q@mail.gmail.com>
 <87wo9lc4oe.fsf_-_@dusky.pond.sub.org> <20200121143658.GB597037@redhat.com>
 <871rrs97ld.fsf@dusky.pond.sub.org>
 <CAJ+F1CJ68_QM7zhqoL-bom3vFSNprN3zOV5FUBtrJWg4nAai5g@mail.gmail.com>
 <87y2tzzrwo.fsf@linaro.org> <87wo9ju19n.fsf@dusky.pond.sub.org>
 <CAJ+F1CLu6xNJ834qWpJ6Bx1PHhv5QutdK2-Nzp+J2q80YV5tzA@mail.gmail.com>
In-Reply-To: <CAJ+F1CLu6xNJ834qWpJ6Bx1PHhv5QutdK2-Nzp+J2q80YV5tzA@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 22 Jan 2020 13:28:24 +0000
Message-ID: <CAFEAcA8az0CWubXqm5i+HhAukg1GYwaiazLw97d5tKGzjKjqwg@mail.gmail.com>
Subject: Re: Integrating QOM into QAPI
To: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::242
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 "Denis V. Lunev" <den@virtuozzo.com>, Stefan Hajnoczi <stefanha@gmail.com>,
 Markus Armbruster <armbru@redhat.com>, QEMU <qemu-devel@nongnu.org>,
 John Snow <jsnow@redhat.com>, Christophe de Dinechin <dinechin@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 Dominik Csapak <d.csapak@proxmox.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 22 Jan 2020 at 12:42, Marc-Andr=C3=A9 Lureau
<marcandre.lureau@gmail.com> wrote:
> From the top of my mind, this is the pain point when trying to use GObjec=
t:
> - static/inlined object, not supported by GObject, unlikely to ever be
> - few users in qemu, transition possible.

Isn't there lots of use of this in the device emulation, or am I
misunderstanding what the restriction is?

thanks
-- PMM

