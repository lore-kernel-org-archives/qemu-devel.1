Return-Path: <SRS0=Dndf=B6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37C7BC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2020 11:53:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 051E82078B
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2020 11:53:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fuRBEIxV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 051E82078B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59076 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k8j7y-00057i-AQ
	for qemu-devel@archiver.kernel.org; Thu, 20 Aug 2020 07:53:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37750)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k8j7R-0004ie-Em
 for qemu-devel@nongnu.org; Thu, 20 Aug 2020 07:52:33 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:54416
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k8j7O-00051f-L2
 for qemu-devel@nongnu.org; Thu, 20 Aug 2020 07:52:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597924349;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DhsfkHPJhj1qFIEJR+38+Bl8S2u3FoReVRbKK2WRG2E=;
 b=fuRBEIxVdarK4Ak/tmsxhfAoeTFvT9yLZxnrlEE7BJ0aWz37mtWud4srR4+s7v1eN/w8hn
 TuoiZGsqO0yN8EHHcrTJwDSdqD7V9EoK2eEkX+FuRhjfWfgU5B3RcZszspqP5vSrAz7HON
 FcrV6y/wA/5yx1WJeRZN2Xi/C1ygxXY=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-429-OYSlYCs1P4yU0D74EO-qvQ-1; Thu, 20 Aug 2020 07:52:27 -0400
X-MC-Unique: OYSlYCs1P4yU0D74EO-qvQ-1
Received: by mail-wm1-f69.google.com with SMTP id z10so693103wmi.8
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2020 04:52:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=DhsfkHPJhj1qFIEJR+38+Bl8S2u3FoReVRbKK2WRG2E=;
 b=I79++IpL1b+o9Fnsxk46HUL9mvUD5TnnsH//CKYCEtkMcw/RxDdkAyFvo50GFtWWXr
 OTzm46J60w+IlGjQi1hFc2KGW1Tvy5avLsCc0NzDsF3yFV6EINj4aMtrrEUEmeTcrl81
 oUs+df8IJbFzEn7OLCSo4Hem1+xCrvrRoXNyny+dqxudU1Pl41hopWEXmbNoIMRYBmCj
 srW7Tm96jzKs9f/Y94o+EqW/MZFbouOUft9kqy3QGqlgQuoBkiUUdxMk7+Bt2OgjhHDV
 63ht2UBJ1Kqae94IZeJWtwVSW4k6oXAPI8sUCFyXEU/cLWP+xxztIA7hC7BneokfI9XB
 cu+g==
X-Gm-Message-State: AOAM531VSb2S1glCNlbNeAaPme/JwWDkhJ5tCZY7XKjRmJ481+SY46j7
 elOKe/Frtbpw5SmsaA82VuoKHHDev8ZITJ0EMFn+DvFMvWnccjDvxgYVBWhEbSbtOe5Y4KR0nax
 PVU7I4RtxJs1eung=
X-Received: by 2002:a5d:5084:: with SMTP id a4mr2984556wrt.191.1597924346303; 
 Thu, 20 Aug 2020 04:52:26 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw40qHw12SQYsz5bjgB5o0C+PpL4le6MFshuvKVSHUAa6mQ5yYV32cAr8ONi+WniBpHNT08lw==
X-Received: by 2002:a5d:5084:: with SMTP id a4mr2984539wrt.191.1597924346020; 
 Thu, 20 Aug 2020 04:52:26 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:1cc0:4e4e:f1a9:1745?
 ([2001:b07:6468:f312:1cc0:4e4e:f1a9:1745])
 by smtp.gmail.com with ESMTPSA id c17sm3913058wrc.42.2020.08.20.04.52.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 20 Aug 2020 04:52:25 -0700 (PDT)
Subject: Re: [PULL v7 000/151] Meson-based build system
To: Peter Maydell <peter.maydell@linaro.org>
References: <20200819213203.17876-1-pbonzini@redhat.com>
 <CAFEAcA86m9N5ceYB+Nu965Se=qyZ_3W-Cn76Qc+Dd75hEApz=w@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <446a210a-7e88-ab9b-05f4-6b0ffabf97c6@redhat.com>
Date: Thu, 20 Aug 2020 13:52:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA86m9N5ceYB+Nu965Se=qyZ_3W-Cn76Qc+Dd75hEApz=w@mail.gmail.com>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/19 20:12:44
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 20/08/20 12:33, Peter Maydell wrote:
> 'make check' still fails for the all-linux-static config, this
> time for a different reason:
> 
> make: *** No rule to make target 'check-qtest', needed by 'check'. Stop.

Oh, there are two "check:" rules.

I pushed again the tag with just this delta:

diff --git a/tests/Makefile.include b/tests/Makefile.include
index ae4315e00e..9ac8f5b86a 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -526,13 +526,12 @@ check-acceptance: check-venv $(TESTS_RESULTS_DIR) get-vm-images
 check-block:
 check-build: build-unit
 
-check: check-unit
 check-clean:
 	rm -rf $(check-unit-y) tests/*.o tests/*/*.o $(QEMU_IOTESTS_HELPERS-y)
 	rm -f tests/test-qapi-gen-timestamp
 	rm -rf $(TESTS_VENV_DIR) $(TESTS_RESULTS_DIR)
 
-check: check-block check-qapi-schema check-unit check-qtest check-decodetree
+check: check-unit
 
 clean: check-clean
 

If any more reasonable expectations from the older build system turn out to
be broken, like in the binaries case, I will be happy to accomodate them

Paolo


