Return-Path: <SRS0=6OCO=YI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.2 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15112C10F14
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2019 09:03:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CAF1420659
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2019 09:03:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ayyGywGm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CAF1420659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38046 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iKIkD-0000hM-Tq
	for qemu-devel@archiver.kernel.org; Tue, 15 Oct 2019 05:03:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34226)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <marcandre.lureau@gmail.com>) id 1iKIjL-0000DG-Ix
 for qemu-devel@nongnu.org; Tue, 15 Oct 2019 05:03:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcandre.lureau@gmail.com>) id 1iKIjK-00012J-2O
 for qemu-devel@nongnu.org; Tue, 15 Oct 2019 05:02:59 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:37607)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
 id 1iKIjJ-00011H-Qt
 for qemu-devel@nongnu.org; Tue, 15 Oct 2019 05:02:58 -0400
Received: by mail-wm1-x341.google.com with SMTP id f22so19377939wmc.2
 for <qemu-devel@nongnu.org>; Tue, 15 Oct 2019 02:02:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=Ikz63hKXJFAavngMtRsz875yRuwWOF8eQJx4CGhwIsA=;
 b=ayyGywGmsSA159l6vn/Ot3dfbfw4ptamDKlbpC/0wZhPR4GcZCdI2upRhmB3zYXrxa
 17Q0fVvfL3MXcyQsA/JTuZsDtTKfWcqtNp0SbMFJo1t4q2DeWrSwr6ZRkLTYEN/iTeub
 5myn77++gH1gFBQPVI0r8OTwmdSvVTTx7TupZkrHocQCYuYg76vCJXo/eFdjHtSrX6EG
 rMsc1QoAiRVGcWOk0cozsRFn8Vh4Kyd/okcUz5llVzLv6oFIH59ggnO32e8E6QKOpUR0
 PxUD7HxyUQHFB8AMu4fX/P2IiTIjTi980/26Z/JANnRLNLLr1rHrDqeKlYQ8nwJBRfy+
 JtZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=Ikz63hKXJFAavngMtRsz875yRuwWOF8eQJx4CGhwIsA=;
 b=JbEqqnOxySJ4d1Hir7kBWS41bj8fcQcQI+87ahO/noWd2M44LKsGcQEKSDfhWLxu+y
 5Cd+RRBTlE8JsnmqALRADnPx1zKRbrABoyWa167HHWWeHijwTvM0XGfT1TAqRxjIrAaP
 aPreEC6Xd9XRv0Dfgb09zY9sszFqQnuILVRHqJU2HfAcAWaekHe41RSY7oMjRD7ll7KV
 g31kBWDSHUVTRNzGtjUqgR1/k8aini2Oyvwuh+65rW899copPTH885dtm7OfJiYBzS5B
 pLfE/uoazjVrbwPpBKHlUFu5SLsNa8F1LyMtCVKBgeeF6Hj1oL8j1Bq0+d+eDxJA8K2J
 Xupg==
X-Gm-Message-State: APjAAAVh+JuoTjYgdOsIx3N81Pop3s64abwJccHKZarYs26ZxGuIhGNc
 tfQrzOClR8BCgrpIFKZQiDrQR5ieZ/mwqFGJIi8=
X-Google-Smtp-Source: APXvYqyqKXs1xJttlcYFmq/50pGkXDPPDp03ZsyVU06UUJT+MQ/dmqXZBQyFrGW7QJGYuxPCfXx/sgQMFCj5QV00blk=
X-Received: by 2002:a1c:9a43:: with SMTP id c64mr18028454wme.20.1571130176371; 
 Tue, 15 Oct 2019 02:02:56 -0700 (PDT)
MIME-Version: 1.0
References: <CALvKS=E-t1c+BVDn=0RbM8nBry8GcYOXh-PrziQO7XhS7W2NUw@mail.gmail.com>
 <CALvKS=GB1-zDnkKxei6Dn5MNyr5kwj+vEtD_3MZyVNfzqQuRZg@mail.gmail.com>
 <CAFEAcA-gLHm0D6vR0Rvpbi_bbVWpKspvm8YLSVPHpCVP6HmDUg@mail.gmail.com>
 <20191015082708.GB22859@redhat.com>
 <0a4262f8-df07-e83e-0928-b6cf4e12800d@redhat.com>
 <20191015084722.GD22859@redhat.com>
In-Reply-To: <20191015084722.GD22859@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 15 Oct 2019 11:02:43 +0200
Message-ID: <CAJ+F1CJACARosH6agtDQoyo6VoubYfrRm5z6DpiiV+fdw0U8aQ@mail.gmail.com>
Subject: Re: RFC: Why dont we move to newer capstone?
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Lucien Murray-Pitts <lucienmp.qemu@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi

On Tue, Oct 15, 2019 at 10:48 AM Daniel P. Berrang=C3=A9 <berrange@redhat.c=
om> wrote:
>
> On Tue, Oct 15, 2019 at 10:36:40AM +0200, Thomas Huth wrote:
> > On 15/10/2019 10.27, Daniel P. Berrang=C3=A9 wrote:
> > > On Sat, Oct 05, 2019 at 02:33:34PM +0100, Peter Maydell wrote:
> > >> On Sat, 5 Oct 2019 at 11:21, Lucien Murray-Pitts
> > >> <lucienmp.qemu@gmail.com> wrote:
> > >>> Whilst working on a m68k patch I noticed that the capstone in use
> > >>> today (3.0) doesnt support the M68K and thus a hand turned disasm
> > >>> function is used.
> > >>>
> > >>> The newer capstone (5.0) appears to support a few more CPU, inc. m6=
8k.
> > >>>
> > >>> Why we move to this newer capstone?
> > >>
> > >> Moving to a newer capstone sounds like a good idea. The only
> > >> reason we haven't moved forward as far as I'm aware is that
> > >> nobody has done the work to send a patch to do that move
> > >> forward to the newer version. Richard Henderson would
> > >> probably know if there was any other blocker.
> > >
> > > Bearing in mind our distro support policy, we need to continue to
> > > support 3.0 series of capstone for a while yet based on what I
> > > see in various distros. eg Ubuntu 18.04 LTS has 3.0.4, as does
> > > Fedora 29.  Version 4.0 is only in a few very new distros:
> > >
> > >    https://repology.org/project/capstone/versions
> > >
> > > We can of course use features from newer capstone, *provided* we corr=
ectly
> > > do conditional compilation so that we can still build against 3.0 ser=
ies
> > > on distros that have that version.
> >
> > We're embedding the capstone submodule in the release tarballs, so I
> > think we're independent from the distro release, aren't we? So this
> > should not be an issue, as far as I can see.
>
> It is an issue for people/distros who don't want to building with bundled
> 3rd party code.
>
> I'd suggest it is probably time we could drop the capstone git submodule.
> We originally added it because capstone wasn't widely present in distros
> we care about. AFAICT, it is now present in all the distros, so could be
> treated the same way as any other 3rd party library dep we have.

I suppose the same applies to dtc (1.4.2 required by qemu, but xenial
has 1.4.0... so we have to wait until April 26, 2020? 18.04 LTS
release date + 2y).

libslirp will take even longer.

