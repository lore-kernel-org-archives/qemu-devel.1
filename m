Return-Path: <SRS0=TEh4=AD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9938EC433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 16:02:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 61ABB2075A
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 16:02:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P+iRkAzf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61ABB2075A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55346 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnOtf-0003fN-GP
	for qemu-devel@archiver.kernel.org; Mon, 22 Jun 2020 12:02:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35384)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1jnOrI-0001mF-Mz
 for qemu-devel@nongnu.org; Mon, 22 Jun 2020 11:59:45 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:45539
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1jnOrF-00079i-Pl
 for qemu-devel@nongnu.org; Mon, 22 Jun 2020 11:59:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592841580;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6PVCKkcKJxbXNsl0OJAIJ7/wKv/lQ+jwl9IOpG3ZBVo=;
 b=P+iRkAzfPkVzt6NlI8YBn8sMYy8H03utmYRrwC0TXjpeiqEfqMH12LsKwerhlusCazXDXg
 rHlER4+i/vyX1sZVKEu0uat14UIO7iuFY7zKtkP8j2+QBzr4m/n++A9EUzlVhqe7Pb9sh9
 DX54cGHg3coFOC2S+Ho2JPqy/CW11kk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-87-HVr94gJBOOaAMEStF8kVBg-1; Mon, 22 Jun 2020 11:59:38 -0400
X-MC-Unique: HVr94gJBOOaAMEStF8kVBg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 99C71107B11A;
 Mon, 22 Jun 2020 15:59:37 +0000 (UTC)
Received: from lacos-laptop-7.usersys.redhat.com (ovpn-115-246.ams2.redhat.com
 [10.36.115.246])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 899CB7C216;
 Mon, 22 Jun 2020 15:59:11 +0000 (UTC)
Subject: Re: [PATCH RFC 1/3] gitlab: introduce explicit "container" and
 "build" stages
To: =?UTF-8?Q?Daniel_P._Berrang=c3=a9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
References: <20200622153318.751107-1-berrange@redhat.com>
 <20200622153318.751107-2-berrange@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <4fb4d9b7-046c-f9ab-6398-ce76867f8ecc@redhat.com>
Date: Mon, 22 Jun 2020 17:59:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Firefox/52.0 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20200622153318.751107-2-berrange@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=lersek@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=lersek@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/22 02:57:26
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 06/22/20 17:33, Daniel P. Berrangé wrote:
> If no stage is listed, jobs get put in an implicit "test" stage.
> Some jobs which create container images to be used by later stages
> are currently listed as in a "build" stages.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>  .gitlab-ci.d/edk2.yml    |  3 ++-
>  .gitlab-ci.d/opensbi.yml |  3 ++-
>  .gitlab-ci.yml           | 11 +++++++++++
>  3 files changed, 15 insertions(+), 2 deletions(-)
> 
> diff --git a/.gitlab-ci.d/edk2.yml b/.gitlab-ci.d/edk2.yml
> index 088ba4b43a..d4e7dfcba6 100644
> --- a/.gitlab-ci.d/edk2.yml
> +++ b/.gitlab-ci.d/edk2.yml
> @@ -1,5 +1,5 @@
>  docker-edk2:
> - stage: build
> + stage: containers
>   rules: # Only run this job when the Dockerfile is modified
>   - changes:
>     - .gitlab-ci-edk2.yml
> @@ -24,6 +24,7 @@ docker-edk2:
>   - docker push $IMAGE_TAG
>  
>  build-edk2:
> + stage: build
>   rules: # Only run this job when ...
>   - changes: # ... roms/edk2/ is modified (submodule updated)
>     - roms/edk2/*
> diff --git a/.gitlab-ci.d/opensbi.yml b/.gitlab-ci.d/opensbi.yml
> index dd051c0124..ec1c1f4cab 100644
> --- a/.gitlab-ci.d/opensbi.yml
> +++ b/.gitlab-ci.d/opensbi.yml
> @@ -1,5 +1,5 @@
>  docker-opensbi:
> - stage: build
> + stage: containers
>   rules: # Only run this job when the Dockerfile is modified
>   - changes:
>     - .gitlab-ci-opensbi.yml
> @@ -24,6 +24,7 @@ docker-opensbi:
>   - docker push $IMAGE_TAG
>  
>  build-opensbi:
> + stage: build
>   rules: # Only run this job when ...
>   - changes: # ... roms/opensbi/ is modified (submodule updated)
>     - roms/opensbi/*
> diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
> index 349c77aa58..9fdc752ea6 100644
> --- a/.gitlab-ci.yml
> +++ b/.gitlab-ci.yml
> @@ -1,3 +1,7 @@
> +stages:
> +  - containers
> +  - build
> +
>  include:
>    - local: '/.gitlab-ci.d/edk2.yml'
>    - local: '/.gitlab-ci.d/opensbi.yml'
> @@ -17,6 +21,7 @@ include:
>    - JOBS=$(expr $(nproc) + 1)
>  
>  build-system1:
> + stage: build
>   image: ubuntu:19.10
>   <<: *before_script_apt
>   script:
> @@ -31,6 +36,7 @@ build-system1:
>   - make -j"$JOBS" check
>  
>  build-system2:
> + stage: build
>   image: fedora:latest
>   <<: *before_script_dnf
>   script:
> @@ -46,6 +52,7 @@ build-system2:
>   - make -j"$JOBS" check
>  
>  build-disabled:
> + stage: build
>   image: fedora:latest
>   <<: *before_script_dnf
>   script:
> @@ -62,6 +69,7 @@ build-disabled:
>   - make -j"$JOBS" check-qtest SPEED=slow
>  
>  build-tcg-disabled:
> + stage: build
>   image: centos:8
>   <<: *before_script_dnf
>   script:
> @@ -82,6 +90,7 @@ build-tcg-disabled:
>              260 261 262 263 264 270 272 273 277 279
>  
>  build-user:
> + stage: build
>   <<: *before_script_apt
>   script:
>   - mkdir build
> @@ -92,6 +101,7 @@ build-user:
>   - make run-tcg-tests-i386-linux-user run-tcg-tests-x86_64-linux-user
>  
>  build-clang:
> + stage: build
>   image: fedora:latest
>   <<: *before_script_dnf
>   script:
> @@ -106,6 +116,7 @@ build-clang:
>   - make -j"$JOBS" check
>  
>  build-tci:
> + stage: build
>   image: centos:8
>   <<: *before_script_dnf
>   script:
> 

Acked-by: Laszlo Ersek <lersek@redhat.com>


