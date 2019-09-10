Return-Path: <SRS0=PbUj=XF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E22BC3A5A2
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 08:11:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D5012067B
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 08:11:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="c8aAYOeT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D5012067B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34940 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7bFG-0005XM-8r
	for qemu-devel@archiver.kernel.org; Tue, 10 Sep 2019 04:11:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57249)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1i7bEQ-0004t9-EJ
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 04:10:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1i7bEL-0008CK-FD
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 04:10:34 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:45530)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1i7bEL-0008CC-8w
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 04:10:29 -0400
Received: by mail-ot1-x341.google.com with SMTP id 41so13315120oti.12
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2019 01:10:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=5aZZHaOR/q1ew560tIOVXX/K5sdO4XPq6kuj4HUPH88=;
 b=c8aAYOeTziPQYijE9Y2HBqRoFTQMFMliNKVL8JWXfu0GQ8Vd5fyk39KT+i1+wpvxG5
 AkcFtGuOfoMzh67yefpk2S09s0ldmZOAgd/x9o8EJRMUzeMI6P3Mt38kr+PL89J3TNpT
 EvY1LgQO7GrSGZKdIZwJlstNORMGM2SqZBvDFNtAlQXSCnejb92td6wVWnsZVs1KHOEn
 ICkC2Bi3fGomm+8E79jswhFh9e2ZVQsLDWv4x6gYYp5tAdH4p4DGVTRVa19pp8hDnIMv
 iZwq+I25NcYK51Bnw8ZhfrM+C/yjzVzMqNii3xK1YysIBdH2UQWNrHArOVNOUr/zjeXR
 s/3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=5aZZHaOR/q1ew560tIOVXX/K5sdO4XPq6kuj4HUPH88=;
 b=iThR3cygCBfUzv63sL3Is/a1gsGK7Tvi9qJjpnwZoWPsAY1y+v8rlY7GnA/AaZvQ1w
 NIMNJwnYHTrtNIP2dVJilzfw3/ZsihzjimyitcIGlx+77QU+5vJjc2y+7un8fb9UrdcN
 jF6kpgqfdPLYVusdOjmL98Pdki5qzjMBggU0rzvTt8qJ8JUGMxmQPvLn0nyCeH4UEq9P
 KuPnVwBYoa8g6SE0YTvcEXPjyaTdwhboQTJEPt1NEo6jW8AsPVc7zB6fORgE58Y0hVVJ
 T4YXxZsGsdJZgF2jCF//hLwYm7lqYW6v1Ldjn2BpEMqX1fH5rSmghK0QTAFy9YehDLOb
 w/Nw==
X-Gm-Message-State: APjAAAVlx0lXj+2ir8YQOIVBuNAbno/Ehs1yMFGRJ+Buk4+4Yyxrymhr
 tsIyr0zcWc8z/9dkHRJBeNzs+wq15AX8jMKsuK0hBg==
X-Google-Smtp-Source: APXvYqwLeVdNqE1cRA/gAmHTnxJoWYJKa1dlvRqty+z0xDS8EDuz+PUYB+c8bmwFgLqmpZQqgt87GsjjS0T0xKg/DQE=
X-Received: by 2002:a9d:5e11:: with SMTP id d17mr1385459oti.135.1568103028277; 
 Tue, 10 Sep 2019 01:10:28 -0700 (PDT)
MIME-Version: 1.0
References: <20190815183039.4264-1-eblake@redhat.com>
 <20190815183039.4264-2-eblake@redhat.com>
 <CAFEAcA-ic=jdSvzOiNCEWmuhXythc2MQGYZYgV=3CBBT2RkEoQ@mail.gmail.com>
 <1722e8ab-1a2b-311e-63fb-d89387b72c2f@virtuozzo.com>
In-Reply-To: <1722e8ab-1a2b-311e-63fb-d89387b72c2f@virtuozzo.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 10 Sep 2019 09:10:17 +0100
Message-ID: <CAFEAcA_rUx8XJ5W0qGJ+-HDQ+B=3i4uK+u50AN-VZt3gSauCrQ@mail.gmail.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::341
Subject: Re: [Qemu-devel] [PULL 1/9] qapi: Add InetSocketAddress member
 keep-alive
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
Cc: =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 10 Sep 2019 at 08:56, Vladimir Sementsov-Ogievskiy
<vsementsov@virtuozzo.com> wrote:
>
> 09.09.2019 20:32, Peter Maydell wrote:
> > On Thu, 15 Aug 2019 at 19:34, Eric Blake <eblake@redhat.com> wrote:
> >>
> >> From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> >>
> >> It's needed to provide keepalive for nbd client to track server
> >> availability.
> >>
> >> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> >> Message-Id: <20190725094937.32454-1-vsementsov@virtuozzo.com>
> >> Reviewed-by: Markus Armbruster <armbru@redhat.com>
> >> Acked-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> >> [eblake: Fix error message typo]
> >> Signed-off-by: Eric Blake <eblake@redhat.com>
> >
> > Hi; Coverity spots a bug in this change (CID 1405300):
>
> Two coverity bugs on my patches, I'm sorry :(
>
> How can I run this coverity locally?

You can't -- it's the online free 'Coverity Scan' service
that Coverity provide for open source projects, and it
only runs on master once patches have been committed.
So we sort of expect that it will catch some of these minor
things after the fact -- it's not a problem.

(I guess if you happen to own a copy of the commercial
Coverity product it is possible to do a local scan but I
wouldn't know how.)

thanks
-- PMM

