Return-Path: <SRS0=Qbil=AU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3020C433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 10:34:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8CC56206DF
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 10:34:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BCJRpgCz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CC56206DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52414 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtTt5-0007Ht-TM
	for qemu-devel@archiver.kernel.org; Thu, 09 Jul 2020 06:34:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59828)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jtTsW-0006t3-SX
 for qemu-devel@nongnu.org; Thu, 09 Jul 2020 06:34:08 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:56641
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jtTsV-0000Sg-5m
 for qemu-devel@nongnu.org; Thu, 09 Jul 2020 06:34:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594290846;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Y9fWIJ+N8v/V8Ct/80zkj5gEg9jRjngBrD9vNZ96Mug=;
 b=BCJRpgCzHItdVXVK4iOhq47+mzhV/U6QO7w7G5cti7laDzzEVKDmQiGKwUWRLvzlt7elnU
 x67gW4u0a19+Oa1+ffB1S1HpOPYbPmOTiMmxtOO6EUKnvcFi3gJEsG0vrvKxO8NyrAamc3
 70l5B4I1rz1btUJHAdXRipgZ8mTcGJ0=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-128-XgjaSldzP1GKM0lN-W5TRg-1; Thu, 09 Jul 2020 06:34:02 -0400
X-MC-Unique: XgjaSldzP1GKM0lN-W5TRg-1
Received: by mail-wm1-f70.google.com with SMTP id c124so1828663wme.0
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2020 03:34:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Y9fWIJ+N8v/V8Ct/80zkj5gEg9jRjngBrD9vNZ96Mug=;
 b=YscSI2hgGv1e597LniyQtQR74qUksb8wsAhQ/DemAY80+ElvvHDPmuNlwggp8ItiDT
 5M3oWt2sNYgATY4Wu/S1KXGVWViS1W5lJ7KBqSNr67rrx76aPR9R7JJ3kfCFoEEl2usS
 Tkj2s4MWZWtaQgOPxrW6NEYlLPg1E0cXo22COQBuIMAPp/EYGs/KfV4v+eTEuGUjko1g
 PyJVLuURVSvtFtRXkMM+fo4Ueci9Hh59v18pby4jp35SVBJpqcHSNacHVvIj+MUfrF3y
 cdgNMl2ABg5OfR8RXnqLSp9SCuy0jZ6sewPZiJJqQFBzVjY9OhP1pBpyE+k9PxFJtOYe
 dfFw==
X-Gm-Message-State: AOAM532wLnUU0h9uCV/2ZuRopN1MEWC/GgFqSWU2nYP3JbVv2uP4mQTw
 9b3tjyMP9mslzj2TGHq5W/I7gkSrZB0eMETJd5u04R6nFLAyAj2F9rDfSk22S1U6uz0pv5tPZpT
 NE4b+yhIk+6F2FvI=
X-Received: by 2002:a7b:c841:: with SMTP id c1mr14395539wml.25.1594290840748; 
 Thu, 09 Jul 2020 03:34:00 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx9snx/4NYx5+f/8JtBBEXUW7LeOvlAKhCmvOA0gkal9WeJtD1A//HcBzuFvYUs8+HEQP6d+w==
X-Received: by 2002:a7b:c841:: with SMTP id c1mr14395517wml.25.1594290840505; 
 Thu, 09 Jul 2020 03:34:00 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:9541:9439:cb0f:89c?
 ([2001:b07:6468:f312:9541:9439:cb0f:89c])
 by smtp.gmail.com with ESMTPSA id k126sm4599641wme.17.2020.07.09.03.33.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 Jul 2020 03:33:59 -0700 (PDT)
Subject: Re: Migrating custom qemu.org infrastructure to GitLab
To: Thomas Huth <thuth@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
References: <CAJSP0QV3uB4QY6mzw2JFDedr0PJhGkU5FdmLF5PbjMPyxiYSuw@mail.gmail.com>
 <20200708105353.GE3229307@redhat.com>
 <20200709101602.lc2uipjlxobjvjn3@sirius.home.kraxel.org>
 <3dacddaa-c739-445b-a24a-02f9e51b9b0e@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <8e1276e2-8957-49db-0409-e85ab2f09739@redhat.com>
Date: Thu, 9 Jul 2020 12:33:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <3dacddaa-c739-445b-a24a-02f9e51b9b0e@redhat.com>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/09 04:20:09
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Cleber Rosa <cleber@redhat.com>,
 Jeff Cody <codyprime@gmail.com>, Stefan Hajnoczi <stefanha@gmail.com>,
 qemu-devel <qemu-devel@nongnu.org>, Michael Roth <mdroth@linux.vnet.ibm.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 09/07/20 12:22, Thomas Huth wrote:
> FWIW, seems like we could use the "pandoc" tool to convert Mediawiki
> (our old Wiki) to Markdown (Gitlab wiki). I've done a quick test and
> converted https://wiki.qemu.org/Contribute/MailingLists into
> https://gitlab.com/huth/qemu/-/wikis/Contribute/MailingLists with some
> few clicks.
> 
> But the longer I look at most Wiki pages, the more I think that we
> should convert the important pages rather into a part of qemu-web
> instead. I'll have a closer look and will suggest some patches when time
> permits...

The wiki was cleaned up more or less at the same time as the
qemu-web.git repo was created (actually as a prerequisite), it's
actually not in a bad shape.  The idea was that the wiki kept:

- stuff that really belonged in documentation (such as completed
features and developer information)

- stuff that needs to be edited quickly (such as feature pages or or
internship ideas)

- developer-targeted information that doesn't belong in documentation
(such as CI status), even if it's linked from qemu.org (e.g.
https://www.qemu.org/contribute/

while qemu-web got the more user-targeted information.  This is because
updating qemu-web is a bit slower, requiring review and all that.

We can certainly move some wiki pages to qemu-web, like we did for
"report a bug" in the past and like Alex did recently for the
Conservancy page.  But I think there aren't that many left, most of them
are in the first category above and should be moved to docs/devel (for
example https://wiki.qemu.org/Contribute/SubmitAPatch).

Once we have docs CI on GitLab we can easily link to them from
qemu-web.git, so setting up docs CI is probably a good first step
towards relying more on GitLab and also cleaning up the wiki.

Paolo


