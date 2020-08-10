Return-Path: <SRS0=QvPl=BU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42F82C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2020 19:37:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0C2C0207FF
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2020 19:37:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GSLdC9E8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C2C0207FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36436 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5Dbi-00086s-8z
	for qemu-devel@archiver.kernel.org; Mon, 10 Aug 2020 15:37:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48612)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k5Dak-0007FJ-Es
 for qemu-devel@nongnu.org; Mon, 10 Aug 2020 15:36:18 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:57734
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k5Dai-0003KB-MF
 for qemu-devel@nongnu.org; Mon, 10 Aug 2020 15:36:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597088175;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rbjWomPj0Mj9h8XZfx8RKSPUQKTtMwW46ad+ubh8VtA=;
 b=GSLdC9E8NoUjCSnhAbMJo9zf7k1xUpPAvl/YFV7JLFyQGdIUz9/ECCV8hFsft0vIUGXUED
 io5a7mY84GZecMYrrkPoZeFYap4GP3yVit5u5i86vJMb7uNRuoX5va1/HMyzO3N+WZnoKr
 ZAMFfYkhPO/mGAQvXROCeJaHjmWZzcc=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-244-VjE9FKmTNpKx3ey4dMT79A-1; Mon, 10 Aug 2020 15:36:11 -0400
X-MC-Unique: VjE9FKmTNpKx3ey4dMT79A-1
Received: by mail-wm1-f72.google.com with SMTP id z1so154298wmf.9
 for <qemu-devel@nongnu.org>; Mon, 10 Aug 2020 12:36:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=rbjWomPj0Mj9h8XZfx8RKSPUQKTtMwW46ad+ubh8VtA=;
 b=OwATH8WKXz3J9XWTVgsyeHKFAS18T1bNfa1C6qSS4APjTIHoGF1aT2ROmej+bljgZj
 KrHgEQY0XoylCgWKHAOgZTCWQs27jCMHMoqLc2tzFPlfUBcHBUN9w38HGgY0Bmn8e+k4
 7wdlLwdOQpZWUJn2U79qNJlQ92JI3ZvqH+H4+sNcFmcxgW05WjwTbfALLLsA7CXKB0Cz
 vfl9iFE+eTuiQ1baXckg/C/bOe2dfSB+ldjk1s0DbrwJT5yTzMkA2QDnMaD/9rRBi/rx
 0SRtahZg2sxDfzddavat+Ub4A42zavcIEFU4un4We5GiBtEI0ghNf/RhAB2RWO7g/ICH
 9+ww==
X-Gm-Message-State: AOAM530E9kdkC0KvU++ZFrRNU9mVn6CLIvIecdOZdpdsN9sUUVk8IBu+
 CJ4gWHJaRLtK3AMQvPHx1DwgyEfM7H7ClQIYL10b3agARiMeKRP2KOqqkRtCDAOl22dkTWfTPEz
 XuZF1dnW7q4rXNGE=
X-Received: by 2002:a1c:2e07:: with SMTP id u7mr778737wmu.52.1597088170101;
 Mon, 10 Aug 2020 12:36:10 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz4siscZ1YFtNXjQ2RBa+Sfr5b3XLYzZWRU4hNhWr5Fcvn6QMghzPFVVH6KwqRH+yHHbgc0Kw==
X-Received: by 2002:a1c:2e07:: with SMTP id u7mr778715wmu.52.1597088169840;
 Mon, 10 Aug 2020 12:36:09 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:5d6c:f50:4462:5103?
 ([2001:b07:6468:f312:5d6c:f50:4462:5103])
 by smtp.gmail.com with ESMTPSA id v8sm954669wmb.24.2020.08.10.12.36.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Aug 2020 12:36:09 -0700 (PDT)
Subject: Re: [PATCH 000/147] Meson integration for 5.2
To: Peter Maydell <peter.maydell@linaro.org>
References: <1597079345-42801-1-git-send-email-pbonzini@redhat.com>
 <CAFEAcA_icj94N6eotg9W7FutXTY_6U-Ak6pJMyYH0n9eggunrg@mail.gmail.com>
 <CAFEAcA8smstwpQUD9UJzMuE6Cq2WutQzBPrKLLs=3wvfXUmpUg@mail.gmail.com>
 <b710345e-1644-782a-44a9-537493b85d95@redhat.com>
 <CAFEAcA9v7jv=SYZ0NLeSkjoM3da-apeu4OC5BMmorxMue0-viQ@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <6a82c3b5-037f-7cd7-68fd-0fffd8eff192@redhat.com>
Date: Mon, 10 Aug 2020 21:36:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9v7jv=SYZ0NLeSkjoM3da-apeu4OC5BMmorxMue0-viQ@mail.gmail.com>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/10 03:29:25
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
Cc: Thomas Huth <thuth@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>, John Snow <jsnow@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Markus Armbruster <armbru@redhat.com>,
 Alexander Bulekov <alxndr@bu.edu>, Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/08/20 21:26, Peter Maydell wrote:
>> This is a real warning.  I'll see if we can add a configure option to
>> disable the translations bug it's fairly low priority.
> Is there a package that we could install on these VM configs
> that would provide gettext in a way that satisfies Meson?

Note that if you don't install it, you just get the previous behavior
(plus a warning).  But if you want that, it would be simply "gettext" I
guess.  You're using tests/vm/*bsd right?

(BTW tests/vm/freebsd is also an interesting configuration because  it
tests --python=python3.7 so it fails if /usr/bin/env python3 is used by
mistake instead of $PYTHON.  I added a paragraph about that to the build
system doc patch, because Meson has some magic to make that simple).

Paolo


