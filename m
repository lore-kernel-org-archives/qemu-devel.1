Return-Path: <SRS0=hH57=EK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61A98C2D0A3
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 13:48:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C4E5221556
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 13:48:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CmHcWzuy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4E5221556
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60486 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaJ8o-000472-4K
	for qemu-devel@archiver.kernel.org; Wed, 04 Nov 2020 08:47:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59774)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kaJ87-0003Jd-C4
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 08:47:15 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:57717)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kaJ85-0003ji-NW
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 08:47:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604497632;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XswLobcq4zX7iqoKiR0EPnCxps5pis2KOmuTREZRFBM=;
 b=CmHcWzuyy79XF3boQjcT+vScMJbh4ALZCQDfG8TPL5LDzNoU+pEBt4W1zNsTXJB0EE0FVE
 /aw92fSrkTGUpjd7Eol8zOS1ICD9iGjH3dPXoJenXk7JthUuJNwtC5xvTJA7c4uKka/WrK
 Cz59ozm2B/Bx/bUbIjDzt/5Cp6ebctY=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-401-s-3ofevGOUGRsYANVCjeMg-1; Wed, 04 Nov 2020 08:47:09 -0500
X-MC-Unique: s-3ofevGOUGRsYANVCjeMg-1
Received: by mail-wm1-f72.google.com with SMTP id b68so642325wme.5
 for <qemu-devel@nongnu.org>; Wed, 04 Nov 2020 05:47:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=XswLobcq4zX7iqoKiR0EPnCxps5pis2KOmuTREZRFBM=;
 b=pcjOZRs6Ubf2X50GPePaGL5zViN2ap2U5wFajelxqxN/mvsKLTxYKeqzHq4HMXVlhl
 iR1LQWqQmBBhNhEtZTy0DAOJOWew98UfboIKide9xpa92sUd8noSaJ5uV2ImiW/elIpi
 AJ+S0j5upvg4zIcWJxuDKXpy3dZepbD3sEjhj+0ddgDDEe1U2mGaENbOZ2s7VclLrPZO
 mPit9t5sjZwhxeUYnlQbVxy54CmuQCFqvR4e1tF32cO6H83AG/7X4SaWgehqUC6OA2CH
 Wf46Abm/kBbms72jZRU1IjJb5NJUFvDGBoCcYFfzdUEb5KDL+U63UhSkfKueIq/sQaSI
 eZmw==
X-Gm-Message-State: AOAM533OcDHEgchF4SCY01xBdyqC5VOOPJBtc+LMz5Vy0Iza/XwoIi51
 N16mebppVNdlalYI48YL0GkyNDSIKd2sGRWGw0pbwWFHIAlXd8u4nSYlG4Ye9ozcy4KvrZ6dFoK
 d5uRzEBZDnmQ4oxE=
X-Received: by 2002:adf:f3c7:: with SMTP id g7mr34397901wrp.394.1604497627704; 
 Wed, 04 Nov 2020 05:47:07 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzVwNbZWTalqwb/54ubRp7QknosAd52dTgpU/frWeZk2ZBaoU2e7nk1FV9l+NgYyeykg42hVA==
X-Received: by 2002:adf:f3c7:: with SMTP id g7mr34397877wrp.394.1604497627491; 
 Wed, 04 Nov 2020 05:47:07 -0800 (PST)
Received: from [192.168.1.36] (234.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.234])
 by smtp.gmail.com with ESMTPSA id k81sm6818159wma.2.2020.11.04.05.47.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 04 Nov 2020 05:47:06 -0800 (PST)
Subject: Re: [PATCH 1/3] hw/usb/ccid: remove references to NSS
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
References: <20201104131924.593522-1-berrange@redhat.com>
 <20201104131924.593522-2-berrange@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <48e24f80-1198-c101-28a8-3bec0318b482@redhat.com>
Date: Wed, 4 Nov 2020 14:47:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201104131924.593522-2-berrange@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/03 00:03:41
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
Cc: Fam Zheng <fam@euphon.net>, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/4/20 2:19 PM, Daniel P. Berrangé wrote:
> The NSS package was previously pre-requisite for building CCID related
> features, however, this became obsolete when the libcacard library was
> spun off to a separate project:
> 
>     commit 7b02f5447c64d1854468f758398c9f6fe9e5721f
>     Author: Marc-André Lureau <marcandre.lureau@redhat.com>
>     Date:   Sun Aug 30 11:48:40 2015 +0200
> 
>         libcacard: use the standalone project
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>  .travis.yml                                | 14 +++++++-------
>  docs/ccid.txt                              | 15 +++++++--------
>  scripts/coverity-scan/coverity-scan.docker |  1 -
>  tests/docker/dockerfiles/centos7.docker    |  1 +
>  tests/docker/dockerfiles/centos8.docker    |  1 +
>  tests/docker/dockerfiles/fedora.docker     |  2 +-
>  6 files changed, 17 insertions(+), 17 deletions(-)
...

> diff --git a/docs/ccid.txt b/docs/ccid.txt
> index c7fda6d07d..1baf03e29b 100644
> --- a/docs/ccid.txt
> +++ b/docs/ccid.txt
> @@ -34,15 +34,14 @@ reader and smart card (i.e. not backed by a physical device) using this device.
>  
>  2. Building
>  
> -The cryptographic functions and access to the physical card is done via NSS.
> -
> -Installing NSS:
> +The cryptographic functions and access to the physical card is done via the
> +libcacard library, whose development package must be installed prior to
> +building QEMU:
>  
>  In redhat/fedora:
> -    yum install nss-devel
> -In ubuntu/debian:
> -    apt-get install libnss3-dev
> -    (not tested on ubuntu)
> +    yum install libcacard-devel
> +In ubuntu:
> +    apt-get install libcacard-dev
>  
>  Configuring and building:
>      ./configure --enable-smartcard && make
> @@ -51,7 +50,7 @@ Configuring and building:
>  3. Using ccid-card-emulated with hardware
>  
>  Assuming you have a working smartcard on the host with the current
> -user, using NSS, qemu acts as another NSS client using ccid-card-emulated:
> +user, using libcacard, qemu acts as another client using ccid-card-emulated:

Maybe replace 'qemu' by 'QEMU' (another instance line 125).

Otherwise:

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

Thanks.


