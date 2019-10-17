Return-Path: <SRS0=yZS3=YK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC2C6CA9EB3
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 23:09:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B779D21D80
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 23:09:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ps2T5BI6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B779D21D80
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34038 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iLEtT-0004Uc-VX
	for qemu-devel@archiver.kernel.org; Thu, 17 Oct 2019 19:09:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41946)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <casantos@redhat.com>) id 1iLEqb-0001Ep-1W
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 19:06:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <casantos@redhat.com>) id 1iLEqY-0007cl-Nj
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 19:06:20 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:33438
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <casantos@redhat.com>) id 1iLEqW-0007ZK-Pm
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 19:06:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1571353574;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=M4hcM/3ucfVcKSG4ieNbwTmsJORr8Gu7gNgR5xZwsKo=;
 b=Ps2T5BI6W/D7sdIbBLHsQrJ8bUqvo1YLpmzp7/Z+e+aciVPcWLdAmvhHfkvE8DEMmwsevb
 Tzijzp1e+sK67JzWg2+vDb3fkGnEblcIPCOQ76efBxr4El03xmqrQbBHGENJz+nV+NY6St
 ywfVsBY454arNyr6n/BhToRkI0cHGag=
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com
 [209.85.166.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-243-m6gEIKujM0mgwPy_7I1v1Q-1; Thu, 17 Oct 2019 19:06:12 -0400
Received: by mail-il1-f199.google.com with SMTP id d15so993802iln.15
 for <qemu-devel@nongnu.org>; Thu, 17 Oct 2019 16:06:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=QLS/rsq5niySfU9MNSfF1ftES/1x1J+6G0ZgLJlvg1o=;
 b=pjvfWe17TwesIZHA8gL1fOEfTws4cKWsG2HKh39a9RnvlDqqtQUQf//LfHw9MfW+II
 QhWmftfTEwj2YLv0bYW5gnCSCZcysZKKjB8AjkXhE/eGb/DV1SeIIqv4HqKLVvEaxX9y
 sR/qy024Rb6VyYg+Wk3jvaf+Q9KTJ6Aj7i/ePPne88Pk1UOpc0N7+iFLJNtCcMKeBKMp
 i/4eK8ZrE4A8RXLd7AKEQYBu3VbAWJLmFttGWNo0d17gvNck5L+6ChFBALMt9q/7JJjL
 v9O0CfnQhROsWO85PGy7XUEt/6Wk6IVY0vg2Oz+J9eBPms+frSFzx6IaVHeV0ryPG1Ih
 NtFA==
X-Gm-Message-State: APjAAAXlpznOEeaobTuTCtddUEYBhTyjl7JrKqZfgGJn7kbDOV/RGrm8
 xe8e2ACn2Q5a71ePsjZ3NbTQNaH09PB2r7aypnOhFLmzlle7wMERGhzipYDLN2AYhyFsf2tAtO1
 Qc1CwcM4BlhK7s/ym4l/VRKyMTphv0Qg=
X-Received: by 2002:a92:98d8:: with SMTP id a85mr6492107ill.98.1571353571803; 
 Thu, 17 Oct 2019 16:06:11 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzJszAKD3Ug0MCS3O4Bqd8okmaqrjDT8/BLoLsijUaMLEzijOYnXoWom96Qpd9Q8XFEQ3ufiZ6xaLp58KGr8LU=
X-Received: by 2002:a92:98d8:: with SMTP id a85mr6492082ill.98.1571353571522; 
 Thu, 17 Oct 2019 16:06:11 -0700 (PDT)
MIME-Version: 1.0
References: <20191017123713.30192-1-casantos@redhat.com>
 <CAFEAcA9dMRBtDs6QSXGVv_bNhtu5wnGKLvMxr2YuoWM=yomGDg@mail.gmail.com>
In-Reply-To: <CAFEAcA9dMRBtDs6QSXGVv_bNhtu5wnGKLvMxr2YuoWM=yomGDg@mail.gmail.com>
From: Carlos Santos <casantos@redhat.com>
Date: Thu, 17 Oct 2019 20:06:00 -0300
Message-ID: <CAC1VKkNr8jN_0qVLtX5-YVH1dgN0fGAvnVZJXUpa+UfG_34ooQ@mail.gmail.com>
Subject: Re: [PATCH] util/cacheinfo: fix crash when compiling with uClibc
To: Peter Maydell <peter.maydell@linaro.org>
X-MC-Unique: m6gEIKujM0mgwPy_7I1v1Q-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Oct 17, 2019 at 9:47 AM Peter Maydell <peter.maydell@linaro.org> wr=
ote:
>
> On Thu, 17 Oct 2019 at 13:39, <casantos@redhat.com> wrote:
> >
> > From: Carlos Santos <casantos@redhat.com>
> >
> > uClibc defines _SC_LEVEL1_ICACHE_LINESIZE and _SC_LEVEL1_DCACHE_LINESIZ=
E
> > but the corresponding sysconf calls returns -1, which is a valid result=
,
> > meaning that the limit is indeterminate.
> >
> > Handle this situation using the fallback values instead of crashing due
> > to an assertion failure.
> >
> > Signed-off-by: Carlos Santos <casantos@redhat.com>
> > ---
> >  util/cacheinfo.c | 10 ++++++++--
> >  1 file changed, 8 insertions(+), 2 deletions(-)
> >
> > diff --git a/util/cacheinfo.c b/util/cacheinfo.c
> > index ea6f3e99bf..d94dc6adc8 100644
> > --- a/util/cacheinfo.c
> > +++ b/util/cacheinfo.c
> > @@ -93,10 +93,16 @@ static void sys_cache_info(int *isize, int *dsize)
> >  static void sys_cache_info(int *isize, int *dsize)
> >  {
> >  # ifdef _SC_LEVEL1_ICACHE_LINESIZE
> > -    *isize =3D sysconf(_SC_LEVEL1_ICACHE_LINESIZE);
> > +    int tmp_isize =3D (int) sysconf(_SC_LEVEL1_ICACHE_LINESIZE);
>
> Do we need the cast here ?

It's there to remind the reader that a type coercion may occur, since
sysconf() returns a long and isize is an int.

> > +    if (tmp_isize > 0) {
> > +        *isize =3D tmp_isize;
> > +    }
> >  # endif
> >  # ifdef _SC_LEVEL1_DCACHE_LINESIZE
> > -    *dsize =3D sysconf(_SC_LEVEL1_DCACHE_LINESIZE);
> > +    int tmp_dsize =3D (int) sysconf(_SC_LEVEL1_DCACHE_LINESIZE);
> > +    if (tmp_dsize > 0) {
> > +        *dsize =3D tmp_dsize;
> > +    }
> >  # endif
> >  }
> >  #endif /* sys_cache_info */
> > --
>
> thanks
> -- PMM

--=20
Carlos Santos
Senior Software Maintenance Engineer
Red Hat
casantos@redhat.com    T: +55-11-3534-6186


