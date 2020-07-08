Return-Path: <SRS0=/TnL=AT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A680C433E0
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2020 22:37:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1195420775
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2020 22:37:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LaAf99VA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1195420775
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45836 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtIh0-0000zw-SB
	for qemu-devel@archiver.kernel.org; Wed, 08 Jul 2020 18:37:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48138)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jtIQO-00086t-Hy
 for qemu-devel@nongnu.org; Wed, 08 Jul 2020 18:20:20 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:48085
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jtIQL-0000pS-Eq
 for qemu-devel@nongnu.org; Wed, 08 Jul 2020 18:20:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594246816;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SAU8guv0EnKtdIROgounwh5ZS9K5pAHDQ7nVyrdiKP4=;
 b=LaAf99VAVvOWxZuwhhLqxfiFZz32iHfTMmvh7mDGkH+GwNNaWmDKywdWYNJ87IAw2IF9WX
 5o9vajNkt/5lViG0L4cQrRU4Pm0PMiSrHhIWTsJ9CVdEh6c54eKlP39LCHxhWSns524eYR
 tQHoaz/AEfQjiBfTusSTSBHgGOVJtSY=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-402-uWWc8G6VPMmXkR9GQGP65g-1; Wed, 08 Jul 2020 07:17:15 -0400
X-MC-Unique: uWWc8G6VPMmXkR9GQGP65g-1
Received: by mail-wm1-f70.google.com with SMTP id 65so2535431wmd.8
 for <qemu-devel@nongnu.org>; Wed, 08 Jul 2020 04:17:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=SAU8guv0EnKtdIROgounwh5ZS9K5pAHDQ7nVyrdiKP4=;
 b=tYqDyssINO/qQxCfrPoH/dLoFstm05ntf7PVJNCqhhhNgn7LHkyldKaK8W0ci79vPB
 dOG17M91VFlFAcGSK7WIZ4SB/FAAIbLHu2K4MPgYKMZruYiiFcRIJuksNhhqzW3GwrQY
 aWSNhUn8KwIBfS+lhd2DKE3pcyDpJVpgdsc0ValkTGhx/OujqMokFhe0R4mBP0utvY/a
 bjhEC5DNH14aigAb6kQIY9hXt4rVxrk8n9MrIZuhGiX2BmXrrTbaWB53dnMCkk5eP3Y8
 pTSn/f2qwPPGP+uLdvMzVPvGG0+bLegJM1f5/ZLhEJkC1D16fFFe3h8WDpC1r1EaZz3d
 rMig==
X-Gm-Message-State: AOAM532OLd4PSV9I1TQbp2INpaZgYo3EcJL59dt/VfffcxgXskK8x8ke
 WYst+3VF8yIhZc4tTyb4CSSaZN+r55dCCC6vMMaZeBflgDX15LQfvxBwCPTtw0XffdDxGq4DePO
 /GHQ0A2RZ8WOi0u4=
X-Received: by 2002:a1c:48d:: with SMTP id 135mr9124868wme.102.1594207033776; 
 Wed, 08 Jul 2020 04:17:13 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz/BRvLGQ+jgBLqvCSTx08SoEP8wYmVwK8vCHdhUQFRd0zI2zhoIFS7llgbZ0kkZ6lRvg7qoA==
X-Received: by 2002:a1c:48d:: with SMTP id 135mr9124798wme.102.1594207032986; 
 Wed, 08 Jul 2020 04:17:12 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:9541:9439:cb0f:89c?
 ([2001:b07:6468:f312:9541:9439:cb0f:89c])
 by smtp.gmail.com with ESMTPSA id u1sm6865840wrb.78.2020.07.08.04.17.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Jul 2020 04:17:12 -0700 (PDT)
Subject: Re: Migrating custom qemu.org infrastructure to GitLab
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Stefan Hajnoczi <stefanha@gmail.com>
References: <CAJSP0QV3uB4QY6mzw2JFDedr0PJhGkU5FdmLF5PbjMPyxiYSuw@mail.gmail.com>
 <20200708105353.GE3229307@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <92e71916-0cf2-2833-6852-de76749c101d@redhat.com>
Date: Wed, 8 Jul 2020 13:17:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200708105353.GE3229307@redhat.com>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/07 17:25:10
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Cleber Rosa <cleber@redhat.com>, Jeff Cody <codyprime@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>, Michael Roth <mdroth@linux.vnet.ibm.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 08/07/20 12:53, Daniel P. Berrangé wrote:
> Consider if qemu-web.git is hosted on gitlab, using GitLab CI to
> generate the static site content, and GitLab pages to host the
> website. If a user wants to contribute to qemu-web, they can fork
> the repo and be confident that the CI jobs in their fork are going
> to work in the exact same way as in the master repo. They can use
> GitLab Pages to browse the generated content for their fork to
> see exactly how it will look.
> 
> This eliminates the big pain point in qemu-web contribution. Many
> times I was tripped up with the problem of qemu-web.git requiring
> a version of Jekyll that is incompatible with the version that
> ships on my distro.

I would have no issue with using a pull request workflow for qemu-web.
The lack of "git range-diff" functionality for gitlab is an absolute
showstopper for using it in QEMU, though.

>> GitLab's Continuous Integration (CI) system provides a powerful way to
>> perform actions defined in yaml files in qemu.git. This includes
>> running scripts, builds, publishing build artifacts, etc. We have
>> already begun using it for automated builds and tests:
>> https://gitlab.com/qemu-project/qemu/-/blob/master/.gitlab-ci.yml
> 
> The CI integration has probably been the single best thing about
> libvirt's switch to GitLab.

How do you handle non-x86 platforms?  Has there been any progress in
gitlab runner support for s390 and PPC?

> The Documentation/Platforms content arguably should be part of
> the main qemu.git docs.
> 
> Many of the feature pages are probably better as part of the formal
> QEMU documentation too.

Yes, definitely; but someone has to do the work.  At least the obsolete
features are clearly marked as so.


