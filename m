Return-Path: <SRS0=hH57=EK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDB28C2D0A3
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 14:23:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 17A15221E2
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 14:23:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QyrJIbTw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17A15221E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48344 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaJh7-0006km-Te
	for qemu-devel@archiver.kernel.org; Wed, 04 Nov 2020 09:23:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39636)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kaJfm-0005iN-GI
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 09:22:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:37815)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kaJfj-0007v3-OY
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 09:22:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604499718;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FSIi/h17ZshACz/36qKnbVG9HVap3iNpAlekfHalIgo=;
 b=QyrJIbTwUnzyk9kgo+XtYjAV0oiWE+/WqpylxnEXBuwtQrgLTDA2Yeyv6y25IKPViewuOQ
 3uOqNhPSd81JKBQl/AHqp6BLihy3pJtCFsAxSTUN/GCg51jv5BcGBKQkVlFHwrUKDYqfSh
 GyR7cGIuuai+qAZtqoqnCO1BW9t+PjE=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-173-0dAsecH8Po2V-C3E6GkOKQ-1; Wed, 04 Nov 2020 09:21:56 -0500
X-MC-Unique: 0dAsecH8Po2V-C3E6GkOKQ-1
Received: by mail-wr1-f72.google.com with SMTP id i1so9296897wrb.18
 for <qemu-devel@nongnu.org>; Wed, 04 Nov 2020 06:21:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=FSIi/h17ZshACz/36qKnbVG9HVap3iNpAlekfHalIgo=;
 b=ShYttF0l9Vnmn9Bmp4EdjA/ZbFujMHJNEc0QcCt/ldcsACj2Os/md+zcJI82cHHBFZ
 xO9LATnzT72CJwLCUV8P8pa2EVS44FdCm2QKP6fTFQyklGDk66HnswAzu0ECW9B66n4l
 9ZXTi4U++ee+9m+RQ3SGxvi1xZAg0DWn0HkBoYI0LUVXb+eX899za86UAZaR7Ydo45IA
 y+XyDv9O2HDnhbkVQFwkdtZwMar8Rddsc61i8S4GGAjH6Txm6iHor2aFiHr/mHpRYYWe
 +QQEWlx5YywncsKAn2Axzo+jj6EXyuzLHBwt6F0u6Teff66VMnb5y7SYaRBTusZJTBZ4
 UhMA==
X-Gm-Message-State: AOAM532vHzXVRmNKrxIgtVQ4dgwaIwUhv369SnMZx7AA2pHM9W2f/ShX
 emGyiatbT8k+lzfAVeMELRAe8OgboDWThQw52ba367UZu8zNH74O5lcG93cTMQd+/DyWaTEApmn
 ovRZ5D34SMPyIigk=
X-Received: by 2002:adf:8484:: with SMTP id 4mr33290609wrg.334.1604499715437; 
 Wed, 04 Nov 2020 06:21:55 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw5vKWcAtdFHU0fGTQrz18307uEBd1LTfNQRJwvOfIBGEZ48TjgTSkmh7EfBSYIOo13/IZA1Q==
X-Received: by 2002:adf:8484:: with SMTP id 4mr33290582wrg.334.1604499715112; 
 Wed, 04 Nov 2020 06:21:55 -0800 (PST)
Received: from [192.168.1.36] (234.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.234])
 by smtp.gmail.com with ESMTPSA id h4sm2523825wrp.52.2020.11.04.06.21.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 04 Nov 2020 06:21:54 -0800 (PST)
Subject: Re: [PATCH] Prefer 'on' | 'off' over 'yes' | 'no' for bool options
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
References: <20201104140528.608015-1-berrange@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <cf0a822f-4f25-ebbd-311e-b7deaf127ffb@redhat.com>
Date: Wed, 4 Nov 2020 15:21:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201104140528.608015-1-berrange@redhat.com>
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
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, qemu-block@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/4/20 3:05 PM, Daniel P. Berrangé wrote:
> Update some docs and test cases to use 'on' | 'off' as the preferred
> value for bool options.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>  docs/system/vnc-security.rst | 6 +++---
>  include/authz/listfile.h     | 2 +-
>  qemu-options.hx              | 4 ++--
>  tests/qemu-iotests/233       | 4 ++--
>  4 files changed, 8 insertions(+), 8 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>


