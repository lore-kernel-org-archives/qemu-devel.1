Return-Path: <SRS0=KdPs=AG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C458C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 08:55:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B5E72072E
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 08:55:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ilidVBTw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B5E72072E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49882 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joNfc-0000dU-L8
	for qemu-devel@archiver.kernel.org; Thu, 25 Jun 2020 04:55:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43898)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1joNew-0008GG-R2
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 04:55:02 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:21086
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1joNeu-0007Gl-JO
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 04:55:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593075298;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=z6G4XWxfMjf+H32/FGpSoo6ncAKGelbzrfIrYGwzdis=;
 b=ilidVBTw/OKpMHAwGA3EXXRjiEydMYJ6PFcFEsf7QUeYdWZW+/jUg1foucmv+PmhnW7uCE
 IYlevAtQgtMUpqI7iRtTHxnLYKSl3d0lN9A3zgndcY1YqggbGmiM1k52QNqTRhXVcW263D
 3HtlJMDhw5b7SHR5OBBdpQu2W77UTLw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-464-URaLGGGaNWWjXrVq3LVBeg-1; Thu, 25 Jun 2020 04:54:54 -0400
X-MC-Unique: URaLGGGaNWWjXrVq3LVBeg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 71240804002;
 Thu, 25 Jun 2020 08:54:53 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-112-150.ams2.redhat.com [10.36.112.150])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id CBA5D5BAC0;
 Thu, 25 Jun 2020 08:54:48 +0000 (UTC)
Subject: Re: [PATCH RFC 1/3] gitlab: introduce explicit "container" and
 "build" stages
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
References: <20200622153318.751107-1-berrange@redhat.com>
 <20200622153318.751107-2-berrange@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <bd889cd5-7088-84f8-85f6-85c6b7d6e049@redhat.com>
Date: Thu, 25 Jun 2020 10:54:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200622153318.751107-2-berrange@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=thuth@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/25 00:45:15
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
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Laszlo Ersek <lersek@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 22/06/2020 17.33, Daniel P. Berrangé wrote:
> If no stage is listed, jobs get put in an implicit "test" stage.
> Some jobs which create container images to be used by later stages
> are currently listed as in a "build" stages.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>   .gitlab-ci.d/edk2.yml    |  3 ++-
>   .gitlab-ci.d/opensbi.yml |  3 ++-
>   .gitlab-ci.yml           | 11 +++++++++++
>   3 files changed, 15 insertions(+), 2 deletions(-)
> 
> diff --git a/.gitlab-ci.d/edk2.yml b/.gitlab-ci.d/edk2.yml
> index 088ba4b43a..d4e7dfcba6 100644
> --- a/.gitlab-ci.d/edk2.yml
> +++ b/.gitlab-ci.d/edk2.yml
> @@ -1,5 +1,5 @@
>   docker-edk2:
> - stage: build
> + stage: containers
>    rules: # Only run this job when the Dockerfile is modified
>    - changes:
>      - .gitlab-ci-edk2.yml

Uh, oh, I guess I should have changed that line to .gitlab-ci.d/edk2.yml 
when I renamed that file .... will send a patch...

> @@ -24,6 +24,7 @@ docker-edk2:
>    - docker push $IMAGE_TAG
>   
>   build-edk2:
> + stage: build
>    rules: # Only run this job when ...
>    - changes: # ... roms/edk2/ is modified (submodule updated)
>      - roms/edk2/*
> diff --git a/.gitlab-ci.d/opensbi.yml b/.gitlab-ci.d/opensbi.yml
> index dd051c0124..ec1c1f4cab 100644
> --- a/.gitlab-ci.d/opensbi.yml
> +++ b/.gitlab-ci.d/opensbi.yml
> @@ -1,5 +1,5 @@
>   docker-opensbi:
> - stage: build
> + stage: containers
>    rules: # Only run this job when the Dockerfile is modified
>    - changes:
>      - .gitlab-ci-opensbi.yml

dito

> @@ -24,6 +24,7 @@ docker-opensbi:
>    - docker push $IMAGE_TAG
>   
>   build-opensbi:
> + stage: build
>    rules: # Only run this job when ...
>    - changes: # ... roms/opensbi/ is modified (submodule updated)
>      - roms/opensbi/*
> diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
> index 349c77aa58..9fdc752ea6 100644
> --- a/.gitlab-ci.yml
> +++ b/.gitlab-ci.yml
> @@ -1,3 +1,7 @@
> +stages:
> +  - containers
> +  - build
> +
>   include:
>     - local: '/.gitlab-ci.d/edk2.yml'
>     - local: '/.gitlab-ci.d/opensbi.yml'
> @@ -17,6 +21,7 @@ include:
>     - JOBS=$(expr $(nproc) + 1)
>   
>   build-system1:
> + stage: build
>    image: ubuntu:19.10
>    <<: *before_script_apt
>    script:
> @@ -31,6 +36,7 @@ build-system1:
>    - make -j"$JOBS" check
>   
>   build-system2:
> + stage: build
>    image: fedora:latest
>    <<: *before_script_dnf
>    script:
> @@ -46,6 +52,7 @@ build-system2:
>    - make -j"$JOBS" check
>   
>   build-disabled:
> + stage: build
>    image: fedora:latest
>    <<: *before_script_dnf
>    script:
> @@ -62,6 +69,7 @@ build-disabled:
>    - make -j"$JOBS" check-qtest SPEED=slow
>   
>   build-tcg-disabled:
> + stage: build
>    image: centos:8
>    <<: *before_script_dnf
>    script:
> @@ -82,6 +90,7 @@ build-tcg-disabled:
>               260 261 262 263 264 270 272 273 277 279
>   
>   build-user:
> + stage: build
>    <<: *before_script_apt
>    script:
>    - mkdir build
> @@ -92,6 +101,7 @@ build-user:
>    - make run-tcg-tests-i386-linux-user run-tcg-tests-x86_64-linux-user
>   
>   build-clang:
> + stage: build
>    image: fedora:latest
>    <<: *before_script_dnf
>    script:
> @@ -106,6 +116,7 @@ build-clang:
>    - make -j"$JOBS" check
>   
>   build-tci:
> + stage: build
>    image: centos:8
>    <<: *before_script_dnf
>    script:
> 

Reviewed-by: Thomas Huth <thuth@redhat.com>


