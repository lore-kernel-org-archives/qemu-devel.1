Return-Path: <SRS0=uFRu=5R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37278C43331
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2020 16:39:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B7EF1206F8
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2020 16:39:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GxLiahx+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7EF1206F8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34694 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJgOJ-0001yQ-Qg
	for qemu-devel@archiver.kernel.org; Wed, 01 Apr 2020 12:38:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35376)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jJgNB-0000es-4q
 for qemu-devel@nongnu.org; Wed, 01 Apr 2020 12:37:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jJgN9-0000NC-Tv
 for qemu-devel@nongnu.org; Wed, 01 Apr 2020 12:37:49 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:43966
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jJgN8-0000Mj-F4
 for qemu-devel@nongnu.org; Wed, 01 Apr 2020 12:37:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585759066;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=9y5fU18jjRcB3Fd/Wvtqk6LcZv3Qmj6cJUUbwE7nMs4=;
 b=GxLiahx+JhVu77NAQMJ0Y84SK8EPRBQoULX1nrYq2cTTSuYGaQhwTm00zmSCtlwqH0UaJQ
 QIx3JQ37IIPpd3iiqcFkdgaSKPlG7JnuCrehv7WoO+yP6Dd04GiIsgEHJmrJF1POtqfwj8
 hGhiMhAvD4+HMyFTdCQ7qUbIFDjCpDo=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-153-Ro8ZIo5hOrWbGiShdoZByQ-1; Wed, 01 Apr 2020 12:37:43 -0400
X-MC-Unique: Ro8ZIo5hOrWbGiShdoZByQ-1
Received: by mail-wm1-f72.google.com with SMTP id l13so187332wme.7
 for <qemu-devel@nongnu.org>; Wed, 01 Apr 2020 09:37:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
 :mime-version:content-language:content-transfer-encoding;
 bh=rMon53WdUivr+a0D6UX19RNKmQdbToiKDDpZ+Ttukrg=;
 b=DzsTTfAQeSjDFi6agSgXenxshJQy2qMUZFvEvZhPYpYODyhOntZuVh2utjzr5ulHzw
 Pd6HqSRiPpP+CiuYsWx6yrtKNEjjNkbST3/lWipjG+IBHA18++LoH7AqsS5hFVwuaE2k
 Whu3xIXZMv1wdhGhtdyIa5mufVDM0Vx4v3UsuTnDJNMuLPydL4bDbWgYuIc0W3ekbvxV
 TSJlgYxMZJ0xBDTwDISe/5QZiYzdbUo+cyjjeTyw146hHIsGFQt7tjKUAK1wYfn9awrN
 YZIZC2pZWP9rBeAsKw7S+ubahcAdBrtarRZorTGiIpdy/n1rK5FEGCfV18PCfhd9Qh3v
 0cXw==
X-Gm-Message-State: ANhLgQ1ErRP9fa+jrE0F9bmUInSvBX0xwmt/jpem47UNYJBYrMU10YVc
 Wm6C9ifvjy229ZoQunmM1Ld8UOwZ9cJM8mMbCa5q2OLsjfbFlZ8z0X5UzRPSajw3xwLhMTed1hf
 /H5nskz31h204U4I=
X-Received: by 2002:adf:f042:: with SMTP id t2mr28137732wro.255.1585759061118; 
 Wed, 01 Apr 2020 09:37:41 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vtw3iN7HNAHdEHFTXqkju2qPY92KCQnDZxibJqqG/7hOJK3SuHJvHslD74ti1Q2K+9egW/M5Q==
X-Received: by 2002:adf:f042:: with SMTP id t2mr28137698wro.255.1585759060737; 
 Wed, 01 Apr 2020 09:37:40 -0700 (PDT)
Received: from [192.168.1.39] (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id w67sm3305121wmb.41.2020.04.01.09.37.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 01 Apr 2020 09:37:40 -0700 (PDT)
To: Markus Armbruster <armbru@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 John Snow <jsnow@redhat.com>, Stefan Weil <sw@weilnetz.de>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Subject: QEMU participation to Google Season of Docs
Message-ID: <de92e66d-c474-dd1b-ddab-194b2f92d1dd@redhat.com>
Date: Wed, 1 Apr 2020 18:37:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel <qemu-devel@nongnu.org>,
 qemu-discuss@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,

Google recently announced their 'Season of Docs' project:
https://developers.google.com/season-of-docs

QEMU project seems to fit all the requirements.

Who is interested in [co-]mentoring?

Relevant links:
https://developers.google.com/season-of-docs/docs/admin-guide
https://developers.google.com/season-of-docs/docs/timeline

[Following is extracted from the previous links:]

Example projects:

* Build a documentation site on a platform to be decided
   by the technical writer and open source mentor, and publish
   an initial set of basic documents on the site. Examples of
   platforms include:

   - A static site generator such as Hugo, Jekyll, Sphinx, ...

* Refactor the open source project's existing documentation to
   provide an improved user experience or a more accessible
   information architecture.

* Write a conceptual overview of, or introduction to, a product
   or feature. Often a team creates their technical documentation
   from the bottom up, with the result that there's a lot of
   detail but it's hard to understand the product as a whole. A
   technical writer can fix this.

* Create a tutorial for a high-profile use case.

* Create a set of focused how-to guides for specific tasks.

* Create a contributor=E2=80=99s guide that includes basic information
   about getting started as a contributor to the open source
   project, as well as any rules around licence agreements,
   processes for pull requests and reviews, building the project,
   and so on.

Previous experience with similar programs, such as Google Summer
of Code or others: If you or any of your mentors have taken part
in Google Summer of Code or a similar program, mention this in
your application. Describe your achievements in that program.
Explain how this experience may influence the way you work in
Season of Docs.

The 2020 season of Season of Docs is limited to a maximum of
50 technical writing projects in total.
As a guideline, we expect to accept a maximum of 2 projects
per organization, so that we don't end up with too many
accepted projects. However, if the free selection process
doesn't fill all the slots, the Google program administrators
may allocate additional slots to some organizations.


