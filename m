Return-Path: <SRS0=NBT7=6W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C01C1C54E7E
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 06:34:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 91E9F207DD
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 06:34:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OY5sd55L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91E9F207DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57542 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWwaX-0008M1-NH
	for qemu-devel@archiver.kernel.org; Fri, 08 May 2020 02:34:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49198)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jWwZi-0007kO-7I
 for qemu-devel@nongnu.org; Fri, 08 May 2020 02:33:34 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:58765
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jWwZh-0005VY-3W
 for qemu-devel@nongnu.org; Fri, 08 May 2020 02:33:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588919611;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jwwfqYn37ZuuA2XRfHT8No2IRghgmxoJoLrdND3kOeo=;
 b=OY5sd55L8+CStaBbHvmVn2J0wbutV8idTNAHOv91tcknSIehYE9WxEtMeqmUd1OPoVjdTb
 4k5KnRf3bAnHlDrqpcJ+kwqRkQx4V3tdB4aNp1kBWx6VKm7Sv6D70Bb9CJS7mGXOyMgmfW
 vtgUKg2n8J5qSwnT4lV+NOs3z4UV49A=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-92-DVl2Ko1AMJmPyaU1CnMItQ-1; Fri, 08 May 2020 02:33:30 -0400
X-MC-Unique: DVl2Ko1AMJmPyaU1CnMItQ-1
Received: by mail-wm1-f72.google.com with SMTP id l21so4721322wmh.2
 for <qemu-devel@nongnu.org>; Thu, 07 May 2020 23:33:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=kINlKotLXZTdgtrcxlOO9cYoJFDWW0LLP3PX1RNmEic=;
 b=RrungtqEZJA6Jz0WEvqLB+LvGt3L7VuREp2pIVyfc6xqWxjfDwe7oPP3IMmyiBbHCK
 cYDz+3X05T/WYFEb3oSTD5SS9DXlOCimypD1oSuMWnhzdaTbT/Ons7sWdceq8I9DOZNd
 d+2cupEQTMuXqkxJbCVIs0zmMtYnDNHJx9MQ8ARgJPmyU7iMa89c1Iwa0I/Psvh+oTVr
 Ll3pPKdDynrIoycQmxuhLC4aqqZSXfhSyCVEDkhCCVZg7z+I6sSAyHBy7tgJHEjP8nIR
 pxjimZ0Jhe/rV/BbWfYc5ISdirb1sNLImbzCAOglqmJ4vt9EaQS9CWGNrTyeP0oXYm3T
 Vhzg==
X-Gm-Message-State: AGi0PuZJn6UB0v5A5lmoRx+LzzxvbddfEORxwzA06uFqlFToCKbtOmgD
 /usdn0TYCFaRwIlAMGsNIKs0SYrXFLqo7UvslGd+dRwUVOZE6WKI6/7f4kNFdNToBEZ1SBCRMUL
 2NJlthmAfNkvMO5w=
X-Received: by 2002:a5d:4704:: with SMTP id y4mr1090918wrq.96.1588919608751;
 Thu, 07 May 2020 23:33:28 -0700 (PDT)
X-Google-Smtp-Source: APiQypIf9Bd6HSMy9hq/Y35lTyykyOZ2h2IAtS0c2Wv/zM9xvXe+XCw14W6kvylD/le7wW8x8J42uQ==
X-Received: by 2002:a5d:4704:: with SMTP id y4mr1090892wrq.96.1588919608463;
 Thu, 07 May 2020 23:33:28 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:20ea:bae4:47a7:31db?
 ([2001:b07:6468:f312:20ea:bae4:47a7:31db])
 by smtp.gmail.com with ESMTPSA id r2sm1323945wrg.84.2020.05.07.23.33.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 07 May 2020 23:33:28 -0700 (PDT)
Subject: Re: [PATCH 0/4] memory: Add memory_region_msync() & make NVMe
 emulated device generic
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20200508062456.23344-1-philmd@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <9396e0cb-388a-e08e-c066-82a60708ecdc@redhat.com>
Date: Fri, 8 May 2020 08:33:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200508062456.23344-1-philmd@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.120; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/08 02:25:09
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Beata Michalska <beata.michalska@linaro.org>, qemu-block@nongnu.org,
 Max Reitz <mreitz@redhat.com>, qemu-arm@nongnu.org,
 Keith Busch <kbusch@kernel.org>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 08/05/20 08:24, Philippe Mathieu-Daud=C3=A9 wrote:
> It is not clear if dccvap_writefn() really needs
> memory_region_writeback() or could use memory_region_msync().

Indeed, I don't understand the code and why it matters that
mr->dirty_log_mask is nonzero.

mr->dirty_log_mask tells if dirty tracking has been enabled, not if the
page is dirty.  It would always be true during live migration and when
running on TCG, but otherwise it would always be false.

Beata, can you explain what you had in mind? :)

Paolo


