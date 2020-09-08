Return-Path: <SRS0=2IDT=CR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3427C43461
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 19:55:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5144C207DE
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 19:55:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="akwV4OKt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5144C207DE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44372 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFji8-0002Tv-F4
	for qemu-devel@archiver.kernel.org; Tue, 08 Sep 2020 15:55:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41774)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kFjhG-0000m6-Gi
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 15:54:30 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:38850
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kFjhE-0003As-3M
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 15:54:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599594866;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pvq7oikw8hfN9MGvVX02Lr8Kdsy7hGpA2yqVY9nmFec=;
 b=akwV4OKtx/fpLK0tNRWAVAe7q9+7+bDyQtX9gKzuKGcBDp8vusq/V6qxVAy2W+oWIkTTV0
 vgkGC1lm7TZJEv2W9Rc9Uot84UOOkCV8muhQ+OdLQY6O9VRephIqHE8MFJAqwoyl6VR8es
 Z13bxu0YSiaiiHcTofoW7/1/Y5dlgSU=
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-560-krwLt5zCOYSu__c7y07uuA-1; Tue, 08 Sep 2020 15:54:25 -0400
X-MC-Unique: krwLt5zCOYSu__c7y07uuA-1
Received: by mail-oi1-f197.google.com with SMTP id 6so107514oix.6
 for <qemu-devel@nongnu.org>; Tue, 08 Sep 2020 12:54:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=pvq7oikw8hfN9MGvVX02Lr8Kdsy7hGpA2yqVY9nmFec=;
 b=KXpWdP3e214nvMBzVc726sqtbMVcQSgzvRMZPbMGwEukZM37+CHo/suWkaZKMjydxI
 akVQ+mUvvKq+XBbwxdyWFWSfUTzU7e2pEeX3bLpckYYCvbr/F9GMFUpJlfw9MbDZeSUz
 OExtWJxVT6BINhkXGL7GqxwLUbijyT8lww58BP0U4lqUvMw+iMnQpUDXLHQjYGp8HO4Q
 c+1AHviQsLlOfDHBsaI0UdJVylSdYeidtq3KRHS/Nzy/1SW5q6VCbVdllpd595sNF7tE
 gw6UOOudqIQIdSzGRZq7f6jDBmyuwODE6vEK9tKzfPWYlZINbrLrq38847CMrXYHVlQD
 xv3A==
X-Gm-Message-State: AOAM5305C/WGs/nsfPrB5rx5g1BdCbZ5jvYLkGukrp5igiZdOfPlVhHH
 U2Rm7FcbyZKCNRHL9kkg/tsT2DHdtscAmc04xqeFH0KSIfDuV8GKbBn/hbIxjP1agMDYFoVJ1M+
 +u2SPbvhDrIPGhcqHVuREDE4VK12Tujg=
X-Received: by 2002:aca:53d7:: with SMTP id h206mr409616oib.118.1599594864751; 
 Tue, 08 Sep 2020 12:54:24 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxTbpkCTGUGwFKiQ7PPgAWIjRmfZpbGaBahpKTtYTqeeyQk4tzpRuZXxhRorX5b3cS5cbLiIHJ/8kvki44fpjI=
X-Received: by 2002:aca:53d7:: with SMTP id h206mr409608oib.118.1599594864487; 
 Tue, 08 Sep 2020 12:54:24 -0700 (PDT)
MIME-Version: 1.0
References: <20200707070858.6622-1-alex.bennee@linaro.org>
 <20200707070858.6622-29-alex.bennee@linaro.org>
In-Reply-To: <20200707070858.6622-29-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Date: Tue, 8 Sep 2020 21:54:13 +0200
Message-ID: <CAP+75-UoUzUoTjxxg-VcdQ0Bd+KDs1eb96tD-4adECeaa5qzug@mail.gmail.com>
Subject: Re: [PULL 28/41] gitlab: add acceptance testing to system builds
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/08 02:10:53
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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
Cc: Fam Zheng <fam@euphon.net>, Peter Maydell <peter.maydell@linaro.org>,
 Thomas Huth <thuth@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>, Cleber Rosa <crosa@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Jul 7, 2020 at 9:14 AM Alex Benn=C3=A9e <alex.bennee@linaro.org> wr=
ote:
>
> As part of migrating things from Travis to GitLab add the acceptance
> tests. To do this:
>
>   - rename system1 to system-ubuntu-main
>   - rename system2 to system-fedora-misc
>   - split into build/check/acceptance
>   - remove -j from check stages
>   - use artifacts to save build stage
>   - add post acceptance template and use
>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> Message-Id: <20200701135652.1366-31-alex.bennee@linaro.org>
>
> diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
> index a7abc55a5c6a..93baf98232d7 100644
> --- a/.gitlab-ci.yml
> +++ b/.gitlab-ci.yml
> @@ -1,8 +1,12 @@
> +# Currently we have two build stages after our containers are built:
> +#  - build (for traditional build and test or first stage build)
> +#  - test (for test stages, using build artefacts from a build stage)
>  stages:
>    - containers
>    - containers-layer2
>    - containers-layer3
>    - build
> +  - test
>
>  include:
>    - local: '/.gitlab-ci.d/edk2.yml'
> @@ -24,26 +28,85 @@ include:
>          ../configure --enable-werror $CONFIGURE_ARGS ;
>        fi
>      - make -j"$JOBS"
> -    - make -j"$JOBS" $MAKE_CHECK_ARGS
> +    - if test -n "$MAKE_CHECK_ARGS";
> +      then
> +        make $MAKE_CHECK_ARGS ;
> +      fi
> +
> +.native_test_job_template: &native_test_job_definition
> +  stage: test
> +  image: $CI_REGISTRY_IMAGE/qemu/$IMAGE:latest
> +  script:
> +    - cd build
> +    - find . -type f -exec touch {} +
> +    - make $MAKE_CHECK_ARGS
> +
> +.post_acceptance_template: &post_acceptance
> +  after_script:
> +    - cd build
> +    - python3 -c 'import json; r =3D json.load(open("tests/results/lates=
t/results.json")); [print(t["logfile"]) for t in r["tests"] if t["status"] =
not in ("PASS", "SKIP")]' | xargs cat
> +    - du -chs $HOME/avocado/data/cache
>
> -build-system1:
> +build-system-ubuntu-main:
>    <<: *native_build_job_definition
>    variables:
>      IMAGE: ubuntu2004
>      TARGETS: aarch64-softmmu alpha-softmmu cris-softmmu hppa-softmmu lm3=
2-softmmu
>        moxie-softmmu microblazeel-softmmu mips64el-softmmu m68k-softmmu p=
pc-softmmu
>        riscv64-softmmu sparc-softmmu
> +  artifacts:
> +    paths:
> +      - build
> +
> +check-system-ubuntu-main:
> +  <<: *native_test_job_definition
> +  needs:
> +    - job: build-system-ubuntu-main
> +      artifacts: true
> +  variables:
> +    IMAGE: ubuntu2004
>      MAKE_CHECK_ARGS: check
>
> -build-system2:
> +acceptance-system-ubuntu-main:
> +  <<: *native_test_job_definition
> +  needs:
> +    - job: build-system-ubuntu-main
> +      artifacts: true
> +  variables:
> +    IMAGE: ubuntu2004
> +    MAKE_CHECK_ARGS: check-acceptance
> +  <<: *post_acceptance
> +
> +build-system-fedora-alt:
>    <<: *native_build_job_definition
>    variables:
>      IMAGE: fedora
>      TARGETS: tricore-softmmu unicore32-softmmu microblaze-softmmu mips-s=
oftmmu
>        riscv32-softmmu s390x-softmmu sh4-softmmu sparc64-softmmu x86_64-s=
oftmmu
>        xtensa-softmmu nios2-softmmu or1k-softmmu
> +  artifacts:
> +    paths:
> +      - build
> +
> +check-system-fedora-alt:
> +  <<: *native_test_job_definition
> +  needs:
> +    - job: build-system-fedora-alt
> +      artifacts: true
> +  variables:
> +    IMAGE: fedora
>      MAKE_CHECK_ARGS: check
>
> +acceptance-system-fedora-alt:
> +  <<: *native_test_job_definition
> +  needs:
> +    - job: build-system-fedora-alt
> +      artifacts: true
> +  variables:
> +    IMAGE: fedora
> +    MAKE_CHECK_ARGS: check-acceptance
> +  <<: *post_acceptance

Apparently our acceptance image misses netcat:
(22/45) tests/acceptance/migration.py:Migration.test_migration_with_exec:
SKIP: 'nc' command not found


