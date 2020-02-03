Return-Path: <SRS0=cs6B=3X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB17AC35247
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 16:10:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 83D112080D
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 16:10:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J7VW1n5m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83D112080D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44096 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iyeIc-0005mv-My
	for qemu-devel@archiver.kernel.org; Mon, 03 Feb 2020 11:10:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41885)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1iyeHb-0004ji-Mk
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 11:09:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1iyeHa-0004Ft-KY
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 11:09:07 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:47198
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1iyeHa-0004FJ-Gb
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 11:09:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580746146;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=gpQt48KTKp45zBQA3ynT1g4VHoAwiwSyI5/3Mz7O02E=;
 b=J7VW1n5mvPOfVX4xKsq70LnIyDO7IDXQMGiJ/ZexqTKiSR0WOFRonjReC5gqFGmtUm1geq
 i3tHrBq+EB/SPte41rCBulQnCJljTohMzVynNlYpIGmvL+dpLYpTsH7InAUsZVlOiwDOVp
 KUjej4cT7J1Ryz8LbUXPBN/8fq7Tfrk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-404-Cu2KmsTZPk-569MC-oR6jw-1; Mon, 03 Feb 2020 11:09:02 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D56338F2A84;
 Mon,  3 Feb 2020 16:09:00 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-116-129.ams2.redhat.com [10.36.116.129])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C828A60BE0;
 Mon,  3 Feb 2020 16:08:59 +0000 (UTC)
Subject: Re: [RFC PATCH 1/2] GitLab CI: avoid calling before_scripts on
 unintended jobs
To: Cleber Rosa <crosa@redhat.com>, qemu-devel@nongnu.org
References: <20200203032328.12051-1-crosa@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <c1e15e42-a155-6aea-35fc-72bcde0229bd@redhat.com>
Date: Mon, 3 Feb 2020 17:08:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200203032328.12051-1-crosa@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: Cu2KmsTZPk-569MC-oR6jw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: Peter Maydell <peter.maydell@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 03/02/2020 04.23, Cleber Rosa wrote:
> At this point it seems that all jobs depend on those steps, with
> maybe the EDK2 jobs as exceptions.
> 
> The jobs that will be added will not want those scripts to be
> run, so let's move these steps to the appropriate jobs, while
> still trying to avoid repetition.
> 
> Signed-off-by: Cleber Rosa <crosa@redhat.com>
> ---
>  .gitlab-ci.yml | 17 ++++++++++++++---
>  1 file changed, 14 insertions(+), 3 deletions(-)
> 
> diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
> index 228783993e..d2c7d2198e 100644
> --- a/.gitlab-ci.yml
> +++ b/.gitlab-ci.yml
> @@ -1,11 +1,10 @@
>  include:
>    - local: '/.gitlab-ci-edk2.yml'
>  
> -before_script:
> +build-system1:
> + before_script: &before_scr_apt
>   - apt-get update -qq
>   - apt-get install -y -qq flex bison libglib2.0-dev libpixman-1-dev genisoimage
> -
> -build-system1:
>   script:
>   - apt-get install -y -qq libgtk-3-dev libvte-dev nettle-dev libcacard-dev
>        libusb-dev libvde-dev libspice-protocol-dev libgl1-mesa-dev libvdeplug-dev

I'm not very familiar with these anchors yet, but would it maybe be
possible to keep the "template" out of build-system1 ? Something like
they show on https://docs.gitlab.com/ee/ci/yaml/#anchors ?

Anyway, patch is also fine for me in its current shape, so FWIW:

Acked-by: Thomas Huth <thuth@redhat.com>


