Return-Path: <SRS0=qpXq=5Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 759ABC2D0EA
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2020 07:11:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D926F2072F
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2020 07:11:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VQHqFIK4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D926F2072F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44278 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jMRLh-00052p-3S
	for qemu-devel@archiver.kernel.org; Thu, 09 Apr 2020 03:11:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40836)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jwsu1986@gmail.com>) id 1jMRL2-0004e5-8Z
 for qemu-devel@nongnu.org; Thu, 09 Apr 2020 03:11:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jwsu1986@gmail.com>) id 1jMRL1-0003V7-1i
 for qemu-devel@nongnu.org; Thu, 09 Apr 2020 03:11:00 -0400
Received: from mail-ot1-x331.google.com ([2607:f8b0:4864:20::331]:45478)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <jwsu1986@gmail.com>) id 1jMRL0-0003Uh-RI
 for qemu-devel@nongnu.org; Thu, 09 Apr 2020 03:10:59 -0400
Received: by mail-ot1-x331.google.com with SMTP id 60so6595254otl.12
 for <qemu-devel@nongnu.org>; Thu, 09 Apr 2020 00:10:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=HZLzfzV2S5puOtCbekxiCNDU77l6CaWpRCXT3OrFe6o=;
 b=VQHqFIK4nlzYFXXNyEi8BWJtdlgJWUCwnTrEVa9J+TZQ74ln18XMxix0bCQbdRiVF9
 IlVxowCYIk0wow2Fjj3fGsAKrAmjcTaB8hUCIQSZhGColMFFNLcoKP37RbU3v9umHyNs
 GsWsxF4P4AnDl5+nKP4QFD025gsS1raa00dAz+3CLeuXoIJg2e3bt8SThg2ADkGOGTS0
 Wq3EV1oZW9W6js9W4KKMGuYteE74X2pHbDHFCwDpDb+PKjpFPdNek4pW3HCG1JHz15lR
 o5qwSTBJbnRE+ALmgShofo0kwZeqBc7OWp1razCDDXPvj3xZTw3wJU9cZ1whqbwKLQAD
 pMcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=HZLzfzV2S5puOtCbekxiCNDU77l6CaWpRCXT3OrFe6o=;
 b=kxQONnhvyA7aIT41tl4au78DxJBXkRnN1dBKWZdf15TCpBqr6HHFB3GPIdOttRi3Rr
 LnCjrzts6PiHpFNhCVPaJh0vwfaFd6T2Cqw9HzB4/aZ9/u2o0LQrWsrb4kNFnBzcILod
 crClGRS+z8mx5yvDr3QX/XVm1MKubGR5blPQzaENju5inNmo81vG2We4dbXpPesAQvPS
 fhjSsg4KkY+swHkJhqj7bPdkYLCUz7FJJ2Cf6hLkcBqK/r/WbIp5mmQwV6e5e7L3g5Sw
 iyfKEJkfaUiFcTUiSHYfPh7hN9Ucs+mfghFgYZVzZCwlylAfPvoWJo/r61ELQlWsOJhF
 uw+Q==
X-Gm-Message-State: AGi0PuZlSsQ7Y9BJYUCLjCkRfJg9mo1LaAFtPjnr/JZoLQ8AyocU2m3i
 BF5SPwtZGMSCK7k9HOiUFLLDSXpJiASZjg1zoAI=
X-Google-Smtp-Source: APiQypKkr3QfukKjl6+HZvyQO9QgfD9EF3qm7Ul0wElDzjZO281sf87SWN95Nq95O4/9CW3seOO+BvcxhFn0SZZh0Ps=
X-Received: by 2002:a05:6830:4b7:: with SMTP id
 l23mr3062122otd.99.1586416257641; 
 Thu, 09 Apr 2020 00:10:57 -0700 (PDT)
MIME-Version: 1.0
References: <20200328124646.7778-1-dereksu@qnap.com>
 <20200328124646.7778-3-dereksu@qnap.com>
 <20200408211842.2c0f1e4a@luklap> <3f0534dbaa744ee4bff9f11615a3b964@intel.com>
In-Reply-To: <3f0534dbaa744ee4bff9f11615a3b964@intel.com>
From: Derek Su <jwsu1986@gmail.com>
Date: Thu, 9 Apr 2020 15:10:46 +0800
Message-ID: <CAFKS8hV_FKUj2Dg76UwP49JcmnoDgAQcBVCNdj2SizMfckYxVw@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] net/colo-compare.c: handling of the full primary
 or secondary queue
To: "Zhang, Chen" <chen.zhang@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::331
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
Cc: Lukas Straub <lukasstraub2@web.de>,
 "lizhijian@cn.fujitsu.com" <lizhijian@cn.fujitsu.com>,
 "chyang@qnap.com" <chyang@qnap.com>, Derek Su <dereksu@qnap.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "ctcheng@qnap.com" <ctcheng@qnap.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hello, Zhang and Lukas

Sure, after my re-test, the performance is hurt. Will update it later.

By the way, could I also move the "error_report("colo compare
primary/secondary queue size too big, drop packet");" to trace?
The use of error_report is a little strange and make a flood in log.

May I  also make "MAX_QUEUE_SIZE"  be user-configurable in this series?

Thanks,
Derek Su




Zhang, Chen <chen.zhang@intel.com> =E6=96=BC 2020=E5=B9=B44=E6=9C=889=E6=97=
=A5 =E9=80=B1=E5=9B=9B =E4=B8=8B=E5=8D=882:59=E5=AF=AB=E9=81=93=EF=BC=9A
>
>
>
> > -----Original Message-----
> > From: Lukas Straub <lukasstraub2@web.de>
> > Sent: Thursday, April 9, 2020 3:19 AM
> > To: Derek Su <dereksu@qnap.com>
> > Cc: qemu-devel@nongnu.org; lizhijian@cn.fujitsu.com; chyang@qnap.com;
> > jasowang@redhat.com; ctcheng@qnap.com; Zhang, Chen
> > <chen.zhang@intel.com>; jwsu1986@gmail.com
> > Subject: Re: [PATCH v4 2/2] net/colo-compare.c: handling of the full pr=
imary
> > or secondary queue
> >
> > On Sat, 28 Mar 2020 20:46:46 +0800
> > Derek Su <dereksu@qnap.com> wrote:
> >
> > > The pervious handling of the full primary or queue is only dropping
> > > the packet. If there are lots of clients to the guest VM, the "drop"
> > > will lead to the lost of the networking connection until next
> > > checkpoint.
> > >
> > > To address the issue, this patch drops the packet firstly.
> > > Then, do checkpoint and flush packets.
> > >
> > > Signed-off-by: Derek Su <dereksu@qnap.com>
> >
> > Hello,
> > I had a look at this again and did some benchmarking.
> > First just qemu 5.0-rc1 with my bugfixes
> > ( https://lists.nongnu.org/archive/html/qemu-devel/2020-
> > 04/msg01432.html ) Then qemu 5.0-rc1 with my bugfixes and this patch
> > series.
> >
> > This commit hurts performance too much:
> > Client-to-server bandwidth falls from ~45.9 Mbit/s to 22.9 Mbit/s.
> > Server-to-client bandwidth falls from ~6.3 Mbit/s to just ~674 Kbit/s.
> > Average latency rises from ~197ms to ~397ms.
> >
> > Meanwhile the packet loss without this commit is negligible, only 1-2 p=
ing
> > packets got lost during each test run.
> >
> > Instead I think we should just turn the error message into a trace so i=
t
> > doesn't flood the logs.
>
> We re-test this patch, Lukas is right.
> Sorry for the original idea, looks like it did not show better performanc=
e in the test.
> Agree with Lukas's comments. Derek, can you please change it?
>
> Thanks
> Zhang Chen
>
>
> >
> > Regards,
> > Lukas Straub

