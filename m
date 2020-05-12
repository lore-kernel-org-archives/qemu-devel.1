Return-Path: <SRS0=ZOtl=62=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53347C54E4A
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 13:52:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1721D206F5
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 13:52:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZbC5tXzZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1721D206F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47038 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYVL5-0004rz-9v
	for qemu-devel@archiver.kernel.org; Tue, 12 May 2020 09:52:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50740)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jYVIu-00026e-Qe
 for qemu-devel@nongnu.org; Tue, 12 May 2020 09:50:40 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:46075
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jYVIt-00058A-MZ
 for qemu-devel@nongnu.org; Tue, 12 May 2020 09:50:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589291438;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xGRauslwFUg833b7D9DBRu4W+hgJbf5F5A0uTffe+2E=;
 b=ZbC5tXzZWLwObAwPrWgtFexq3HOCJpRPtx7UHYfDtjUxyfaXypUAvxQJu1kig9/g/3BjGd
 QOrly0zwR2XSJ9iF+VugEDHeATiJ8WcF1bNJObWPZV9x+bLMPtMmNSJQeZWQ2LX7Wt8s1i
 iEUuwELfI/8GpQ68J+Q2zLVmVD/tNxw=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-275-oubVVX41P8CG-VYSisS-WQ-1; Tue, 12 May 2020 09:50:35 -0400
X-MC-Unique: oubVVX41P8CG-VYSisS-WQ-1
Received: by mail-wm1-f70.google.com with SMTP id g10so3042686wme.0
 for <qemu-devel@nongnu.org>; Tue, 12 May 2020 06:50:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=xGRauslwFUg833b7D9DBRu4W+hgJbf5F5A0uTffe+2E=;
 b=JYetHkyyKpR6UeO5KlS3PcaSQILUvszXlx0ieLx2OVOpEyAXJP64Ro6WU9qJIS14zw
 LZhMQXOrmapF/3A0J18KfjcJ755LJySpPPLbsrQkk5GiG737YLHgbpq/FZwSl/eWxlvM
 KzBrkDddJ7fFf7i0NEonumXqSnlgThmjAdglCXDpu77B/qBlxlAx6zb4usJDT1SPZdrM
 Am6HCcIqd8Ok1Sz73bIiBnV7+K2IKsKM+qO1266oqV4NNeOQov9hpOzYWINec6QbbCPl
 yligsIw0kD4y6noppiv820Q/EGQ1h4bdyx0G/5xdHUKWfHARDbd7SUu7/RH/lvqzeEsj
 iBAg==
X-Gm-Message-State: AGi0PubML+GcWPMjVflIN0/PrjByXDsIrk6yO1eq/WMlUS3D4RxN2DbN
 Oc71c+442REHZoiJ1hNgmP0RCfX4+PKR/ycrG3p1RPYDTDw+1HODVk8JnLifubETYINg/sAHT9s
 u4YsJ8liOvwMNbiA=
X-Received: by 2002:a1c:9604:: with SMTP id y4mr35375709wmd.153.1589291434778; 
 Tue, 12 May 2020 06:50:34 -0700 (PDT)
X-Google-Smtp-Source: APiQypLmNP0Ka69i5Xo7SjxWa+Gw6tdkqJRSbdnCnVZ4cPEtyvfPVwooXuLePYxDJ0KfCNnf9vUjsg==
X-Received: by 2002:a1c:9604:: with SMTP id y4mr35375679wmd.153.1589291434410; 
 Tue, 12 May 2020 06:50:34 -0700 (PDT)
Received: from [192.168.1.38] (17.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.17])
 by smtp.gmail.com with ESMTPSA id t2sm32750539wmt.15.2020.05.12.06.50.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 May 2020 06:50:33 -0700 (PDT)
Subject: Re: [PATCH] travis.yml: Improve the --disable-tcg test on s390x
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
References: <20200512133849.10624-1-thuth@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <31b6d6b7-ec28-ecd0-aadc-2a371f6be0c9@redhat.com>
Date: Tue, 12 May 2020 15:50:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200512133849.10624-1-thuth@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/12 01:41:59
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
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
Cc: qemu-s390x@nongnu.org, Cornelia Huck <cohuck@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/12/20 3:38 PM, Thomas Huth wrote:
> Since the s390x containers do not allow KVM, we only compile-test
> the --disable-tcg build on s390x and do not run the qtests. Thus,
> it does not make sense to install genisoimage here, and it also does
> not make sense to build the s390-ccw.img here again - it is simply
> not used without the qtests.
> On the other hand, if we do not build the s390-ccw.img anymore, we
> can also compile with Clang - so let's use that compiler here to
> get some additional test coverage.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   .travis.yml | 18 ++++--------------
>   1 file changed, 4 insertions(+), 14 deletions(-)
> 
> diff --git a/.travis.yml b/.travis.yml
> index fe708792ca..1ec8a7b465 100644
> --- a/.travis.yml
> +++ b/.travis.yml
> @@ -502,9 +502,10 @@ jobs:
>                 $(exit $BUILD_RC);
>             fi
>   
> -    - name: "[s390x] GCC check (KVM)"
> +    - name: "[s390x] Clang (disable-tcg)"

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

>         arch: s390x
>         dist: bionic
> +      compiler: clang
>         addons:
>           apt_packages:
>             - libaio-dev
> @@ -528,21 +529,10 @@ jobs:
>             - libusb-1.0-0-dev
>             - libvdeplug-dev
>             - libvte-2.91-dev
> -          # Tests dependencies
> -          - genisoimage
>         env:
>           - TEST_CMD="make check-unit"
> -        - CONFIG="--disable-containers --disable-tcg --enable-kvm --disable-tools"
> -      script:
> -        - ( cd ${SRC_DIR} ; git submodule update --init roms/SLOF )
> -        - BUILD_RC=0 && make -j${JOBS} || BUILD_RC=$?
> -        - |
> -          if [ "$BUILD_RC" -eq 0 ] ; then
> -              mv pc-bios/s390-ccw/*.img pc-bios/ ;
> -              ${TEST_CMD} ;
> -          else
> -              $(exit $BUILD_RC);
> -          fi
> +        - CONFIG="--disable-containers --disable-tcg --enable-kvm
> +                  --disable-tools --host-cc=clang --cxx=clang++"
>   
>       # Release builds
>       # The make-release script expect a QEMU version, so our tag must start with a 'v'.
> 


