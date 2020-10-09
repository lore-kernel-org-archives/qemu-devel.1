Return-Path: <SRS0=T5iq=DQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BDADC43457
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 17:14:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D18D22258
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 17:14:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YVEt/nfN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D18D22258
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41830 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQvy8-00040A-JZ
	for qemu-devel@archiver.kernel.org; Fri, 09 Oct 2020 13:14:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47316)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kQvum-0008Rt-NX
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 13:10:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:43418)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kQvuc-0001bK-Rv
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 13:10:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602263430;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eBdp0r2SMHQVM6vHLqba+AgtgWEvRrOcgtedA5Cysy0=;
 b=YVEt/nfNLX5TyFCtGjoCwFIPZdaepmnj3glrHjakCSswJ/7RWVjJK2Vi4FORcLM691UT1Z
 Q/VFlJkCLSX98mDUZUDZ9Hb7BnqpLZJulGXi8ENQ/LJgV3e3ZuY30lmUhoH5hO5pwhUmvY
 Obupbu+6Cxdcdd4p6KZfHFR3ug2tdhQ=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-522-TAt9pMYBMRqT9wocLT1SBw-1; Fri, 09 Oct 2020 13:10:29 -0400
X-MC-Unique: TAt9pMYBMRqT9wocLT1SBw-1
Received: by mail-wm1-f71.google.com with SMTP id o198so21111wme.8
 for <qemu-devel@nongnu.org>; Fri, 09 Oct 2020 10:10:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=eBdp0r2SMHQVM6vHLqba+AgtgWEvRrOcgtedA5Cysy0=;
 b=EH1bF0L77oF4qMpi1vsYVIOrJPB8GrrBog5xg7lK855frxfYvJHz1ZFOz3MkyC7Mfx
 YNoYl+HK/GPVPrJZ6XYL29jDyx8MtIljHkF47Tkr7AfmpblSSS0fnihTj3TG08vm6bfo
 sKpYFBtskHoKu+g40fLFCmSEpsBakXOJyTalOHtabWP3kl8WoKtfmRD8Ov70U8+GXK5q
 sSMkscZEpADSF/jvvHh6AKevLx6QBcPE4NWszqj/PYEzJo34jZYeS+YkIBeBvXnC/dK8
 J0zNuBnO4FtM0yUBzg7C+JcIav9TBDpCsZkG/CBd6/I2MIKsRg6pYC6BNBj4Iir+4ZZX
 4wJQ==
X-Gm-Message-State: AOAM531vcRAbuE8j6pJL5e2p/mMIpO1Mp8pdWCXxPwV2VlraUb4kytVv
 zw+GN1KqaJgrHkjBx+AAIwMG792Hv+ztMQGEhrjpCFZQA0FVyQj2hlpw8t/M1uDKw+wItKbcyuk
 S4lJi+TWReP51Uug=
X-Received: by 2002:a7b:cf13:: with SMTP id l19mr15190077wmg.74.1602263427240; 
 Fri, 09 Oct 2020 10:10:27 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzbBWvUpKtn9yBxMrApXKjRnbS5NM4v8lk7mpZxgJXX7Rg/7ule0+f7en6AO0pEG524i5uUKA==
X-Received: by 2002:a7b:cf13:: with SMTP id l19mr15190053wmg.74.1602263426967; 
 Fri, 09 Oct 2020 10:10:26 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:cee1:4797:6958:7698?
 ([2001:b07:6468:f312:cee1:4797:6958:7698])
 by smtp.gmail.com with ESMTPSA id v4sm12427953wmg.35.2020.10.09.10.10.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 09 Oct 2020 10:10:25 -0700 (PDT)
Subject: Re: [RFC v1 1/4] tests/Makefile.include: unbreak non-tcg builds
To: Claudio Fontana <cfontana@suse.de>
References: <20201009152108.16120-1-cfontana@suse.de>
 <20201009152108.16120-2-cfontana@suse.de>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <d6c154aa-03f3-77a0-0af1-90e2f33390fa@redhat.com>
Date: Fri, 9 Oct 2020 19:10:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20201009152108.16120-2-cfontana@suse.de>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/09 02:34:40
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.208, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org,
 Pavel Dovgalyuk <dovgaluk@ispras.ru>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 09/10/20 17:21, Claudio Fontana wrote:
> From: Paolo Bonzini <pbonzini@redhat.com>
> 
> XXX known to be wrong, this breaks other non-native builds
> 
> remove dependency of check-block from non-native archs
> 
> 
> ---
>  tests/Makefile.include | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tests/Makefile.include b/tests/Makefile.include
> index 5aca98e60c..1ca70d88ce 100644
> --- a/tests/Makefile.include
> +++ b/tests/Makefile.include
> @@ -140,7 +140,7 @@ QEMU_IOTESTS_HELPERS-$(CONFIG_LINUX) = tests/qemu-iotests/socket_scm_helper$(EXE
>  check: check-block
>  check-block: $(SRC_PATH)/tests/check-block.sh qemu-img$(EXESUF) \
>  		qemu-io$(EXESUF) qemu-nbd$(EXESUF) $(QEMU_IOTESTS_HELPERS-y) \
> -		$(patsubst %-softmmu,qemu-system-%,$(filter %-softmmu,$(TARGET_DIRS)))
> +		qemu-system-$(patsubst ppc64%,ppc64, $(shell uname -m))
>  	@$<
>  endif
>  
> 

This is a better one:

diff --git a/tests/Makefile.include b/tests/Makefile.include
index 5aca98e60c..ceeda65da2 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -140,7 +140,7 @@ QEMU_IOTESTS_HELPERS-$(CONFIG_LINUX) = tests/qemu-iotests/socket_scm_helper$(EXE
 check: check-block
 check-block: $(SRC_PATH)/tests/check-block.sh qemu-img$(EXESUF) \
 		qemu-io$(EXESUF) qemu-nbd$(EXESUF) $(QEMU_IOTESTS_HELPERS-y) \
-		$(patsubst %-softmmu,qemu-system-%,$(filter %-softmmu,$(TARGET_DIRS)))
+		$(filter qemu-system-%, $(ninja-targets-c_LINKER) $(ninja-targets-cpp_LINKER))
 	@$<
 endif
 


