Return-Path: <SRS0=QLzr=44=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,LOTS_OF_MONEY,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A625BC18E5A
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 15:03:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 96EEB206C0
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 15:03:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XCY2ikmi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96EEB206C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53882 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jC2th-0002BJ-J7
	for qemu-devel@archiver.kernel.org; Wed, 11 Mar 2020 11:03:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52659)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <marcandre.lureau@gmail.com>) id 1jC2sd-0000y2-LI
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 11:02:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcandre.lureau@gmail.com>) id 1jC2sc-00073T-FT
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 11:02:43 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:52214)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
 id 1jC2sc-00071S-8M
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 11:02:42 -0400
Received: by mail-wm1-x342.google.com with SMTP id a132so2474544wme.1
 for <qemu-devel@nongnu.org>; Wed, 11 Mar 2020 08:02:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=Qx5lNT7aIw02/u8GpdYyGy/xlXCFEWtAxHMe6GppCmM=;
 b=XCY2ikmimdsgjXjP2fYw9zgn2HpVRfrclJfpnpMVyiJisk45TlrNXAOykZ7O4Y5l8z
 Yl9WLsrvztghx0lfxJ6YFi9H2OXHp+ACtWICuF8i9QJOofdy3BEQ/WTNG0kcknT8ocog
 du1MQzOf7BdS30xzXxb+qD1o5Tw2KxonHvnfkrej5jys/i9ApP9z8pd44F2tXlmKaHnC
 JxKVwZB2vzORYP2CjTnmH00D8KbkyLotTYGr5g7JuWJ4zXE4zy0bPt2bHs0yOL5ttre1
 O7wmEs1ah98pMgk5UX+bfAcQ1S+SYFCE+xb7gSeIqiImR8zfbZOAIe7tCZmF1RcvDMFW
 U9kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=Qx5lNT7aIw02/u8GpdYyGy/xlXCFEWtAxHMe6GppCmM=;
 b=Py/iEAqHRJrEsrXXZavqfiJXq7CkTXjAJhf7swHAnLObTNPFWZNEoPYGaPxMpt0jWt
 m7tkoHhBjqgedx+7ESkjqFkGKZGeRGGDqsSjWpWgUT5pIdHlmacblsVRqmLn9c5KGRtf
 Pz0/1O3WqXNq8nxJBr4SnHafmGlw/EpJTMubIMxgwkpyWBv4/cvbzOUZbJ02q3/1dGvG
 wvxwCVcPEeBbHDTaBu+VHAzsFtjrbewclxV/4iKdbKM5LB4/0VkdIijKlUNt/E+IYuZ9
 ZoPGxP5rbSnQiT3BcTzMgTqtoHQV3hAxvcA/slxpaEDoTFk/QMFzqGlEHDCzShT16B4P
 AHTg==
X-Gm-Message-State: ANhLgQ2fHeEhp9moC21o/Plv7liEsSHR83+wwormkV82T3w6Kho55l/w
 HORFUBPzxiEHck8M7OY8RByCj+oQs5IkwbA2ydE=
X-Google-Smtp-Source: ADFU+vtzKPHcsI2kR8rpKfVofRUe3T4Y6pOyszYTG6iVMs1xEAFkoYI7X+8c2d5WX5VIydmpWRmYjsJ8mo4ucbhQFE0=
X-Received: by 2002:a05:600c:204a:: with SMTP id
 p10mr4186841wmg.55.1583938960503; 
 Wed, 11 Mar 2020 08:02:40 -0700 (PDT)
MIME-Version: 1.0
References: <20200224182454.24610-1-sebastien.boeuf@intel.com>
 <20200306123453.GI1335569@stefanha-x1.localdomain>
 <CAJ+F1CJpMzra8VSYWKgtwZJkxvEX_HTqT=Sr9yvmX=NMH=9MSg@mail.gmail.com>
 <717f4005879504627a0bff4dd55ec0e166dfeb88.camel@intel.com>
In-Reply-To: <717f4005879504627a0bff4dd55ec0e166dfeb88.camel@intel.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Wed, 11 Mar 2020 16:02:28 +0100
Message-ID: <CAJ+F1CJhxQ9Gk15QUhbGV+HGdjr2-9DaR4C0Namw9jcSKwX96A@mail.gmail.com>
Subject: Re: [PATCH v2] docs: Update vhost-user spec regarding backend program
 conventions
To: "Boeuf, Sebastien" <sebastien.boeuf@intel.com>,
 Markus Armbruster <armbru@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
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
Cc: "stefanha@gmail.com" <stefanha@gmail.com>,
 "berrange@redhat.com" <berrange@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "stefanha@redhat.com" <stefanha@redhat.com>, "mst@redhat.com" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi

On Wed, Mar 11, 2020 at 3:19 PM Boeuf, Sebastien
<sebastien.boeuf@intel.com> wrote:
>
> Hi!
>
> On Fri, 2020-03-06 at 13:52 +0100, Marc-Andr=C3=A9 Lureau wrote:
> > Hi
> >
> > On Fri, Mar 6, 2020 at 1:35 PM Stefan Hajnoczi <stefanha@gmail.com>
> > wrote:
> > > On Mon, Feb 24, 2020 at 07:24:54PM +0100, Sebastien Boeuf wrote:
> > > > The vhost-user specification is not clearly stating the expected
> > > > behavior from a backend program whenever the client disconnects.
> > > >
> > > > This patch addresses the issue by defining the default behavior
> > > > and
> > > > proposing an alternative through a command line option.
> > > >
> > > > By default, a backend program will terminate whenever the client
> > > > disconnects, unless told otherwise through the newly introduced
> > > > option --keep-listening.
> > > >
> > > > Signed-off-by: Sebastien Boeuf <sebastien.boeuf@intel.com>
> > > > Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> > > > ---
> > > >  docs/interop/vhost-user.rst | 12 ++++++++++++
> > > >  1 file changed, 12 insertions(+)
> > >
> > > Perhaps --keep-listening should be optional?
> >
> > I think it should be optional, and flagged by a capability.
>
> Could you please elaborate on that? How can I do that?

Some backend options or behavior are optional, and advertised through
--print-capabilities.

Say --foo (optional),

--print-capabilities should have something like:

{ ...
  "features": [
     "foo",
     ...
   ]
}

The list of capabilities is documented in vhost-user.json,
VHostUserBackendCapabilities.

We lack common enum such as @VHostUserBackendCommonFeature at this
point, but it can be added.

Although we don't currently parse this file through qapi, I don't know
how to express that
VHostUserBackendGPUFeature/VHostUserBackendCapabilitiesInput inherits
from another enum. Markus, any idea?



>
> Thanks,
> Sebastien
> >
> > > If the maintainers are happy with the patch as is then so am I:
> > >
> > > Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> >
> >
> ---------------------------------------------------------------------
> Intel Corporation SAS (French simplified joint stock company)
> Registered headquarters: "Les Montalets"- 2, rue de Paris,
> 92196 Meudon Cedex, France
> Registration Number:  302 456 199 R.C.S. NANTERRE
> Capital: 4,572,000 Euros
>
> This e-mail and any attachments may contain confidential material for
> the sole use of the intended recipient(s). Any review or distribution
> by others is strictly prohibited. If you are not the intended
> recipient, please contact the sender and delete all copies.



--=20
Marc-Andr=C3=A9 Lureau

