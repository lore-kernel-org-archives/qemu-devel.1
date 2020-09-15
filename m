Return-Path: <SRS0=sZ46=CY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0722C433E2
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 08:57:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 857302078D
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 08:57:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PZOkbdnt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 857302078D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46134 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kI6mD-0002CW-JJ
	for qemu-devel@archiver.kernel.org; Tue, 15 Sep 2020 04:57:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57822)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nsoffer@redhat.com>)
 id 1kI6ki-0001eS-Hj
 for qemu-devel@nongnu.org; Tue, 15 Sep 2020 04:55:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:58644)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <nsoffer@redhat.com>)
 id 1kI6kc-0007Zt-7Z
 for qemu-devel@nongnu.org; Tue, 15 Sep 2020 04:55:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600160144;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SBQ1LTwfHgooJZ4henluDSAV84+F+Bz0lmuWkH4fzGQ=;
 b=PZOkbdntKydxDj0/dIrEjZ5l2LnbbnEUzmxC6Y5TtImis0tZ4hR0KK+HmM2+o1Fvp+kgVK
 CJn++5JZJ4RGbQGetDq6AjNJzrEiuc1cOn4rP3GjjGicV6WTPvzA+CQGq25+5gmt70G4sz
 FDAv14k6iJbn+dXl3bovOuItSMlrIF4=
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com
 [209.85.210.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-44-P-IbdzD_OyWK6VxfabPr8Q-1; Tue, 15 Sep 2020 04:55:36 -0400
X-MC-Unique: P-IbdzD_OyWK6VxfabPr8Q-1
Received: by mail-ot1-f69.google.com with SMTP id s3so821421otp.18
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2020 01:55:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=SBQ1LTwfHgooJZ4henluDSAV84+F+Bz0lmuWkH4fzGQ=;
 b=peE/RLe4CVjzOgTVl9pRWZFgOCJfKGpgZEQY7svxiZ1ZJv7hlKNzsEvL9v1dMKgbd2
 1v09fDEpfsQ/0E0P41lLcv/Y9z6+KUSFPuNZ25qwDVsl0g81nT1JPJWh1/7d3SM5UvfA
 9q1kIqUnH1JwsK8IZ0Xvn3viYisEJ3xTEKuVHKlKbUnG5EV3kfsHRngS9ufTENvuRrg7
 OvXQAMBWiABvHsp88cDaFJZqQm8u4RcxiOsFnWar2SWmFppWtOyKIKgoG6oD7s9DtUwi
 Mki87bvYs70ciJhvUGzQsq7hMSNcQCIkVPOIAAifU0n+37Ns+Wm5ZmPL/M6FARkgeJXC
 2UtA==
X-Gm-Message-State: AOAM533850cCovu5BrKO3FCoJDEQ2lbidJYGDcVkDiNszeh+SfjjCYAm
 JtHlT00LPMrXbNnyojtkvaoI37hutXCa18Ppik6i0f3tHu5ubdjcZS4TCU2YFOHyVyP/gbRAR6f
 DZfaDaolqa3n+lAqXdYFR9rXvyeK+wMU=
X-Received: by 2002:a4a:bd90:: with SMTP id k16mr13513398oop.16.1600160134806; 
 Tue, 15 Sep 2020 01:55:34 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx2tu7cm2QgW6WddRfLIN+ghpoVQpBV5dOSyZ2hq0lhiwkuMa5kLzl15xPeyS3h6eAKfCFBPPHOapLc5P5LRFw=
X-Received: by 2002:a4a:bd90:: with SMTP id k16mr13513388oop.16.1600160134504; 
 Tue, 15 Sep 2020 01:55:34 -0700 (PDT)
MIME-Version: 1.0
References: <20200831140127.657134-1-nsoffer@redhat.com>
 <20200831140127.657134-3-nsoffer@redhat.com>
 <20200914173201.GR1252186@redhat.com>
In-Reply-To: <20200914173201.GR1252186@redhat.com>
From: Nir Soffer <nsoffer@redhat.com>
Date: Tue, 15 Sep 2020 11:55:18 +0300
Message-ID: <CAMRbyysRun-nkgugLuxHcBv3HJ2QqVs2rw9HO3CjgZEE5ftGjQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] block: file-posix: Replace posix_fallocate with
 fallocate
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=nsoffer@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=63.128.21.124; envelope-from=nsoffer@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/15 02:23:19
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.792,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
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
Cc: Kevin Wolf <kwolf@redhat.com>, Nir Soffer <nirsof@gmail.com>,
 qemu-block <qemu-block@nongnu.org>, Markus Armbruster <armbru@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Sep 14, 2020 at 8:32 PM Daniel P. Berrang=C3=A9 <berrange@redhat.co=
m> wrote:
>
> On Mon, Aug 31, 2020 at 05:01:27PM +0300, Nir Soffer wrote:
> > If fallocate() is not supported, posix_fallocate() falls back to
> > inefficient allocation, writing one byte for every 4k bytes[1]. This is
> > very slow compared with writing zeros. In oVirt we measured ~400%
> > improvement in allocation time when replacing posix_fallocate() with
> > manually writing zeroes[2].
> >
> > We also know that posix_fallocated() does not work well when using OFD
> > locks[3]. We don't know the reason yet for this issue yet.
> >
> > Change preallocate_falloc() to use fallocate() instead of
> > posix_falloate(), and fall back to full preallocation if not supported.
> >
> > Here are quick test results with this change.
> >
> > Before (qemu-img-5.1.0-2.fc32.x86_64):
> >
> > $ time qemu-img create -f raw -o preallocation=3Dfalloc /tmp/nfs3/test.=
raw 6g
> > Formatting '/tmp/nfs3/test.raw', fmt=3Draw size=3D6442450944 preallocat=
ion=3Dfalloc
> >
> > real 0m42.100s
> > user 0m0.602s
> > sys 0m4.137s
> >
> > NFS stats:
> > calls      retrans    authrefrsh    write
> > 1571583    0          1572205       1571321
> >
> > After:
> >
> > $ time ./qemu-img create -f raw -o preallocation=3Dfalloc /tmp/nfs3/tes=
t.raw 6g
> > Formatting '/tmp/nfs3/test.raw', fmt=3Draw size=3D6442450944 preallocat=
ion=3Dfalloc
> >
> > real 0m15.551s
> > user 0m0.070s
> > sys 0m2.623s
> >
> > NFS stats:
> > calls      retrans    authrefrsh    write
> > 24620      0          24624         24567
> >
> > [1] https://code.woboq.org/userspace/glibc/sysdeps/posix/posix_fallocat=
e.c.html#96
> > [2] https://bugzilla.redhat.com/1850267#c25
> > [3] https://bugzilla.redhat.com/1851097
>
> This bug appears to be private to RH employees only, so rather than link
> to it, please summarize any important facts in it for benefit of nonn-RH
> QEMU contributors.

Thanks, I missed that detail when linking to the bug. The bug is public now=
.

> > Signed-off-by: Nir Soffer <nsoffer@redhat.com>
> > ---
> >  block/file-posix.c                     | 32 +++++++++-----------------
> >  docs/system/qemu-block-drivers.rst.inc | 11 +++++----
> >  docs/tools/qemu-img.rst                | 11 +++++----
> >  qapi/block-core.json                   |  4 ++--
> >  4 files changed, 25 insertions(+), 33 deletions(-)
>
> Regards,
> Daniel
> --
> |: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
> |: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
> |: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
>


