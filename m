Return-Path: <SRS0=cs6B=3X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3236CC35247
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 15:27:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F2AC820721
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 15:27:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LXjIxQV5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2AC820721
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43332 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iyddZ-0000nW-39
	for qemu-devel@archiver.kernel.org; Mon, 03 Feb 2020 10:27:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58337)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <wainersm@redhat.com>) id 1iydcs-0000Lh-Gz
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 10:27:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <wainersm@redhat.com>) id 1iydcr-0000Kz-FQ
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 10:27:02 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:33578
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <wainersm@redhat.com>) id 1iydcr-0000Iq-BD
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 10:27:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580743620;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ciZc/Lln2oNN0Be9pSMWhebU0QkWmNpbjQ9rkjNKBbM=;
 b=LXjIxQV5V57HNQYxz5Jf5q+kE3OD9tDc68BeaUqoB/+1vequlFQZLwWUnT/1/UzZEwOF1K
 UdFXHvWnbtE9vxCj6DyyfcPekAwiU/uZSpFt0ykElF1vuKtBHPKBZki3SoNfghLpln2Xnw
 Vr0b78pwRAYKBQFKQIOa7WsjH4BUimk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-1-iJhS-J9jOM6V4-TASd6Hfw-1; Mon, 03 Feb 2020 10:26:57 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 60E71107ACC9;
 Mon,  3 Feb 2020 15:26:56 +0000 (UTC)
Received: from localhost.localdomain (ovpn-116-90.gru2.redhat.com
 [10.97.116.90])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 345745D9CA;
 Mon,  3 Feb 2020 15:26:55 +0000 (UTC)
Subject: Re: [RFC PATCH 1/2] GitLab CI: avoid calling before_scripts on
 unintended jobs
To: Cleber Rosa <crosa@redhat.com>, qemu-devel@nongnu.org
References: <20200203032328.12051-1-crosa@redhat.com>
From: Wainer dos Santos Moschetta <wainersm@redhat.com>
Message-ID: <de890084-701a-9f6a-bff6-94ef3d60e9f1@redhat.com>
Date: Mon, 3 Feb 2020 13:26:53 -0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20200203032328.12051-1-crosa@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: iJhS-J9jOM6V4-TASd6Hfw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 2/3/20 1:23 AM, Cleber Rosa wrote:
> At this point it seems that all jobs depend on those steps, with
> maybe the EDK2 jobs as exceptions.
>
> The jobs that will be added will not want those scripts to be
> run, so let's move these steps to the appropriate jobs, while
> still trying to avoid repetition.
>
> Signed-off-by: Cleber Rosa <crosa@redhat.com>
> ---
>   .gitlab-ci.yml | 17 ++++++++++++++---
>   1 file changed, 14 insertions(+), 3 deletions(-)


Reviewed-by: Wainer dos Santos Moschetta <wainersm@redhat.com>


>
> diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
> index 228783993e..d2c7d2198e 100644
> --- a/.gitlab-ci.yml
> +++ b/.gitlab-ci.yml
> @@ -1,11 +1,10 @@
>   include:
>     - local: '/.gitlab-ci-edk2.yml'
>   
> -before_script:
> +build-system1:
> + before_script: &before_scr_apt
>    - apt-get update -qq
>    - apt-get install -y -qq flex bison libglib2.0-dev libpixman-1-dev genisoimage
> -
> -build-system1:
>    script:
>    - apt-get install -y -qq libgtk-3-dev libvte-dev nettle-dev libcacard-dev
>         libusb-dev libvde-dev libspice-protocol-dev libgl1-mesa-dev libvdeplug-dev
> @@ -18,6 +17,8 @@ build-system1:
>    - make -j2 check
>   
>   build-system2:
> + before_script:
> +  *before_scr_apt
>    script:
>    - apt-get install -y -qq libsdl2-dev libgcrypt-dev libbrlapi-dev libaio-dev
>         libfdt-dev liblzo2-dev librdmacm-dev libibverbs-dev libibumad-dev
> @@ -30,6 +31,8 @@ build-system2:
>    - make -j2 check
>   
>   build-disabled:
> + before_script:
> +  *before_scr_apt
>    script:
>    - mkdir build
>    - cd build
> @@ -44,6 +47,8 @@ build-disabled:
>    - make -j2 check-qtest SPEED=slow
>   
>   build-tcg-disabled:
> + before_script:
> +  *before_scr_apt
>    script:
>    - apt-get install -y -qq clang libgtk-3-dev libusb-dev
>    - mkdir build
> @@ -62,6 +67,8 @@ build-tcg-disabled:
>               248 250 254 255 256
>   
>   build-user:
> + before_script:
> +  *before_scr_apt
>    script:
>    - mkdir build
>    - cd build
> @@ -71,6 +78,8 @@ build-user:
>    - make run-tcg-tests-i386-linux-user run-tcg-tests-x86_64-linux-user
>   
>   build-clang:
> + before_script:
> +  *before_scr_apt
>    script:
>    - apt-get install -y -qq clang libsdl2-dev libattr1-dev libcap-ng-dev
>         xfslibs-dev libiscsi-dev libnfs-dev libseccomp-dev gnutls-dev librbd-dev
> @@ -83,6 +92,8 @@ build-clang:
>    - make -j2 check
>   
>   build-tci:
> + before_script:
> +  *before_scr_apt
>    script:
>    - TARGETS="aarch64 alpha arm hppa m68k microblaze moxie ppc64 s390x x86_64"
>    - mkdir build


