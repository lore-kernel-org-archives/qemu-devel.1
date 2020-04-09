Return-Path: <SRS0=qpXq=5Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4658CC2BA2B
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2020 14:42:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0CE892078E
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2020 14:42:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EMkPn5RQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0CE892078E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50940 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jMYOF-0006YD-7Q
	for qemu-devel@archiver.kernel.org; Thu, 09 Apr 2020 10:42:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41788)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alexander.duyck@gmail.com>) id 1jMYNe-00069E-Qh
 for qemu-devel@nongnu.org; Thu, 09 Apr 2020 10:42:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alexander.duyck@gmail.com>) id 1jMYNd-0004aW-Lv
 for qemu-devel@nongnu.org; Thu, 09 Apr 2020 10:42:10 -0400
Received: from mail-il1-x142.google.com ([2607:f8b0:4864:20::142]:32786)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alexander.duyck@gmail.com>)
 id 1jMYNd-0004XV-HX
 for qemu-devel@nongnu.org; Thu, 09 Apr 2020 10:42:09 -0400
Received: by mail-il1-x142.google.com with SMTP id k29so10427618ilg.0
 for <qemu-devel@nongnu.org>; Thu, 09 Apr 2020 07:42:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=wVf7fPuCIEtf0kDOiLCwbrCo9SqTEhF4iHy+M6G1GGE=;
 b=EMkPn5RQyd2XH+AZhbRc6ydaiAfRGviSr5OFz3HUJI2AHi1UKjboH8F2f4vRfR8MwC
 QKX8JnkdW40xE9iUeBDoI7sMsVVoCmSVZuSaeVSdS93dQ6vuuYaob7gSSwpTSnQG0t9M
 2eo5/jvaag5v5GJioKBC70WTi4aSEYnbr88GShVG9Iai6klh92EMPWowQtOwOaPOy7YC
 U2ipg0MMivKpQEZXE9kce680b34feNVR7/NoW6aUB0cWaBsglclTc5bO+Vn5eLAeGDC1
 d0uuXeTNfgI6MItBw0FeC4wj358pete+5XctNbmCuG3s2PYBfhusNoZUzQZb0fZY81FM
 tYMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=wVf7fPuCIEtf0kDOiLCwbrCo9SqTEhF4iHy+M6G1GGE=;
 b=G4oiDV8pDTK80N7qzkOmFTD3ZUiKn+PWciSB35yT9GJjmnAYe+9d7cmZu7qnG7AZsk
 hP6VWERYGiI6HFvTc/CMor075plWCprmz+DpxIzgscuB4oigkJiiaq11km+Uskd/QOmK
 JshA5+ndp3GOPY8UudQDkUMPtRx4JOsxbxn2nyPhGNS1wCKzRZITDmtEvPO3mPgdP85P
 svyCvTPeSNuqzp+etnWK3AhOYHLSZcOpT61dUZZgwkSnlBHcY21l72up5kVRFGe2IeOi
 DQJAgQ/6oJ/7ir7/UdXychz05npvPnv+FVmpMA97hY9HbJxeReVouDfVy4NLJ+CRKQjg
 oE4g==
X-Gm-Message-State: AGi0Pub783gT4jx1xVETGQH7Evv3aq9sTyYFA1Oi4OF2latPU9VX0tBn
 LoECGK5h51FxMAH5WJAeDSTpj0aFKb2KndCS/Ic=
X-Google-Smtp-Source: APiQypKRvGnHs/eE1zmtEP/nUagDXLRHfH5hHDsAUNQ6fIrYLlSDfUHs+HvyO+BXPLKTGeUEDmlxvDX9tcenx7YtaKM=
X-Received: by 2002:a92:9fc2:: with SMTP id z63mr44076ilk.64.1586443328304;
 Thu, 09 Apr 2020 07:42:08 -0700 (PDT)
MIME-Version: 1.0
References: <20200408225302.18764.209.stgit@localhost.localdomain>
 <20200408225523.18764.86514.stgit@localhost.localdomain>
 <a461c334-79f0-a638-962e-d6b136707ce3@redhat.com>
In-Reply-To: <a461c334-79f0-a638-962e-d6b136707ce3@redhat.com>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Thu, 9 Apr 2020 07:41:57 -0700
Message-ID: <CAKgT0Ueu4P4Z-fNZiEnHDV2nCSrW7qJWVD17=VLHt_Le00NSWg@mail.gmail.com>
Subject: Re: [PATCH v18 QEMU 2/3] virtio-balloon: Add support for providing
 free page reports to host
To: David Hildenbrand <david@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::142
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
Cc: virtio-dev@lists.oasis-open.org, qemu-devel@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Apr 9, 2020 at 12:36 AM David Hildenbrand <david@redhat.com> wrote:
>
> On 09.04.20 00:55, Alexander Duyck wrote:
> > From: Alexander Duyck <alexander.h.duyck@linux.intel.com>
> >
> > Add support for the page reporting feature provided by virtio-balloon.
> > Reporting differs from the regular balloon functionality in that is is
> > much less durable than a standard memory balloon. Instead of creating a
> > list of pages that cannot be accessed the pages are only inaccessible
> > while they are being indicated to the virtio interface. Once the
> > interface has acknowledged them they are placed back into their respective
> > free lists and are once again accessible by the guest system.
> >
> > Unlike a standard balloon we don't inflate and deflate the pages. Instead
> > we perform the reporting, and once the reporting is completed it is
> > assumed that the page has been dropped from the guest and will be faulted
> > back in the next time the page is accessed.
> >
> > This patch is a subset of the UAPI patch that was submitted for the Linux
> > kernel. The original patch can be found at:
> > https://lore.kernel.org/lkml/20200211224657.29318.68624.stgit@localhost.localdomain/
>
> You don't need all these comments.

Sorry about that. Those are basically the same comments from the
original upstream patch. I just wasn't aware of the process so I just
copied that over and added the comment/link to the original patch.

> Usually we do
>
> "linux-headers: update to contain virito-balloon free page reporting
>
> Let's sync the latest upstream changes for free page reporting. To be
> replaced by a full linux header sync.
>
> Signed-off-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>
> "
>
> mst will replace this by a full header sync (if necessary) when sending
> it upstream

I will update the patch description.

Thanks.

- Alex

