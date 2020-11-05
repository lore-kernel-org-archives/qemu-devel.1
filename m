Return-Path: <SRS0=LLOU=EL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B97FC00A89
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 07:23:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 890CC20825
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 07:23:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Drc61JKg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 890CC20825
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49740 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaZc9-0008Im-HM
	for qemu-devel@archiver.kernel.org; Thu, 05 Nov 2020 02:23:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45532)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kaZb9-0007TU-IF
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 02:22:19 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:20198)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kaZb6-0003vV-2Q
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 02:22:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604560933;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4l8t6Nx0waKCdm5I28P6c7xRRE927pLlak2NAsvVui8=;
 b=Drc61JKgw+ZMeDag5979lSKbLEudjMsWwUfZThfpE/wJQHSP9VISDcbZpDRGF4TlhglK70
 dHniVoHQjpSnvAW7Ahna/exfq5QF8wzfj5kHpqrUJnOn3gm1mtpaS4n+u1WwdghJdzDWA1
 6nI4v3WmwG35Q0Zma3TyKsSecB24BI8=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-359-h3SHgdAjPbilINe51YxtzA-1; Thu, 05 Nov 2020 02:22:11 -0500
X-MC-Unique: h3SHgdAjPbilINe51YxtzA-1
Received: by mail-wr1-f71.google.com with SMTP id v14so316090wro.12
 for <qemu-devel@nongnu.org>; Wed, 04 Nov 2020 23:22:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=4l8t6Nx0waKCdm5I28P6c7xRRE927pLlak2NAsvVui8=;
 b=Bu1/MMLJSq/1dz6k6yXEh0RB6O3CTqRd2eYClcIURnWYv2f2nncJPsZaCbHR970kTy
 zXRpZJuCSaH2f5zM7MfBB18kP6A15rNNAS09caJrukJkhstTdXVOVzeKwEaiNafLmk8h
 Wr4TMrSOpSFA95Mpl9oM/PL50bQH8xdZjyv7GYhzmQVzPXBz5jktCleWM1l0Ma5X0ghm
 6Erabl5j/hYA4feBI7CRw7Zoo5aM2DH/E+DieFJ7s1J2QVHU0cuRngrqiGsqUJRCfNm+
 OG5x2+DGSSrjMELNaRibezvB9kEVJzdKsXC+mj4YWFmVhgwE9eBSh+R2jCkVDOWj/EII
 G3hQ==
X-Gm-Message-State: AOAM532RykR/admoZOCCojsYNL+BiLYFEkK4SttZf5qq6ke9zUT1MI9n
 NtEEjPo2o40/FvGX6AItsjxc8o5s7RslkQFqTqIZiGDUGo/QX7JdbPlaVq2c3+NksR7EkmqXYm8
 lGMpHHgueAMM4AkI=
X-Received: by 2002:a1c:67d5:: with SMTP id b204mr1163081wmc.92.1604560930349; 
 Wed, 04 Nov 2020 23:22:10 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxyjP/lPWKRLisr81k74cu34BncF+Z5HRz7UjeixhAe1Q7pAvnMAw2mKeTccYPlQPxe+iVqWg==
X-Received: by 2002:a1c:67d5:: with SMTP id b204mr1163057wmc.92.1604560930115; 
 Wed, 04 Nov 2020 23:22:10 -0800 (PST)
Received: from [192.168.1.36] (234.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.234])
 by smtp.gmail.com with ESMTPSA id c9sm1045924wrp.65.2020.11.04.23.22.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 04 Nov 2020 23:22:09 -0800 (PST)
Subject: Re: [RFC PATCH 0/9] gitlab-ci: Allow forks to skip some build jobs
To: qemu-devel@nongnu.org
References: <20201104224558.3384595-1-philmd@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <e5416a27-af97-765e-afc4-e7309820ff9d@redhat.com>
Date: Thu, 5 Nov 2020 08:22:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201104224558.3384595-1-philmd@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/05 01:14:53
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
 "Daniel P . Berrange" <berrange@redhat.com>, John Snow <jsnow@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/4/20 11:45 PM, Philippe Mathieu-Daudé wrote:
> Hi,
> 
> 2 months ago GitLab added time limit to their free CI offer [1].
> This series provide developers with the possibility to not run
> all jobs. By default all jobs are started, but we can disable
> a subset of them.
> 
> I think this should be the other way around (enable features one
> wants to test, with a default to the "all" keyword), but I didn't
> want to disrupt the current workflow.

I was a bit too focused on getting the YAML right to not realize
it is simpler to do:

QEMU_JOBS=all          # default, overwritable
QEMU_JOBS=system,fuzz  # only build those jobs
                       # can be set in fork UI config (see [2])
                       # can be set with git-push option (see below)

> I'm not sure supporting both ("SKIP_BUILD=3Dall INCLUDE_BUILD=3Dsystem")
> options is easy to implement, or to maintain (unlikely).
> 
> In the next iteration I'll add the possibility to use a project-
> wide environment variable [2] to set the default set of enabled /
> disabled features a fork is interested in. User will still be
> able to overload using git-push on the command line. A friendly
> way to use this feature is with git aliases [3]:
> 
>  $ git config alias.pushci_system \
>     'push -o ci.variable=3D"SKIP_BUILD=3Duser"'
>  $ git config alias.pushci_debian \
>     'push -o ci.variable=3D"SKIP_BUILD=3Dcentos,fedora,ubuntu"'
> 
> Then you can run the jobs based on Debian images (only) using:
> 
>  $ git pushci_debian gitlab_repo my_branch_for_debian
> 
> Or run all system-mode emulation jobs only using:
> 
>   $ git pushci_system my_gitlab_repo branch_with_system_feature
> 
> Comments welcomed!
> 
> Regards,
> 
> Phil.
> 
> [1] https://about.gitlab.com/releases/2020/09/01/ci-minutes-update-free-users/
> [2] https://docs.gitlab.com/ee/ci/variables/README.html#create-a-custom-varia=
> ble-in-the-ui
> [3] https://docs.gitlab.com/ee/user/project/push_options.html#useful-git-alia=
> ses
> 
> Philippe Mathieu-Daud=C3=A9 (9):
>   gitlab-ci: Replace YAML anchors by extends (cross_system_build_job)
>   gitlab-ci: Replace YAML anchors by extends (native_build_job)
>   gitlab-ci: Replace YAML anchors by extends (native_test_job)
>   gitlab-ci: Replace YAML anchors by extends (acceptance_test_job)
>   gitlab-ci: Rename acceptance_test_job -> integration_test_job
>   gitlab-ci: Extract common job definition as 'cross_common_job'
>   gitlab-ci: Extract common job definition as 'native_common_job'
>   gitlab-ci: Add rules to skip building cross-jobs
>   gitlab-ci: Add rules to skip building/testing native jobs
> 
>  .gitlab-ci.d/crossbuilds.yml |  57 +++++++++++--------
>  .gitlab-ci.yml               | 104 +++++++++++++++++++++--------------
>  2 files changed, 98 insertions(+), 63 deletions(-)
> 
> --=20
> 2.26.2
> 


