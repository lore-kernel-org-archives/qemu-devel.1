Return-Path: <SRS0=MBD3=C4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42C0BC43463
	for <qemu-devel@archiver.kernel.org>; Sat, 19 Sep 2020 14:59:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 865F72098B
	for <qemu-devel@archiver.kernel.org>; Sat, 19 Sep 2020 14:59:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KDgRYB/u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 865F72098B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37650 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJeKd-0003dB-CP
	for qemu-devel@archiver.kernel.org; Sat, 19 Sep 2020 10:59:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39252)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kJeK6-0003D9-6N
 for qemu-devel@nongnu.org; Sat, 19 Sep 2020 10:58:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:43985)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kJeK4-0006c9-3t
 for qemu-devel@nongnu.org; Sat, 19 Sep 2020 10:58:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600527522;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bI1NfvZ5jlodFjuxAXXR6eKv3SBXzM3kVsC2fRqNE6Y=;
 b=KDgRYB/uj0iSGLg45lfM9lAGOu49XocmxNgkYAU/TAhulg6OWZCqCc1Y490igInHCxSbkE
 hwz889ExFa4xuP0A9JekSlgWIXAMBGFLLuB4o0eH55jA9ZCvvuwOks9KmJcuYyp0qHUvS0
 b0PUOZ3m7TY5Ev+GiJzHlcEo0x0Omss=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-29-PVdOhV5kOKmtOh520Zwp7Q-1; Sat, 19 Sep 2020 10:58:39 -0400
X-MC-Unique: PVdOhV5kOKmtOh520Zwp7Q-1
Received: by mail-wr1-f69.google.com with SMTP id b7so3534721wrn.6
 for <qemu-devel@nongnu.org>; Sat, 19 Sep 2020 07:58:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=bI1NfvZ5jlodFjuxAXXR6eKv3SBXzM3kVsC2fRqNE6Y=;
 b=UKq6b70MbWRMl0laKiQ1J6hYMYaD6eQjzwdM0/TngAUhfi0G1gI1ej/AcK+1YFESN4
 K26DTSswB9xi2CXb6n8q3g82uG+YEkvdJ9/bk5MTYYMjjqi8SSsoftl4X5G0/tWmbqli
 /+Zq9wi6R/tnL34Gzx5MtT+zttddPy+1kOAJL9H33tzVgNc/DW2Y6+xwIuEeP+PYhjVV
 uugc1bypF6Wj3Bx5G5EXbTM/EeJv/KJY73diqFfwAgVlKunYM8HlbtJXmpW1EAf4A7Z9
 YvOfCSU4QxpQenrufjCzJ9BZUnp/YkHnFYbxsUmzl47KjyxooKF00zBHFN8x8E/NXv1x
 leJQ==
X-Gm-Message-State: AOAM533WB1jSxB92ilRSg5En/imUyxP2y/HltAX4VdnQsi2nAUYsA86b
 jogdEH+3116wU9z0xCcau98Q8n12W4lOsrVz+/G1gc/K1Lxgf+v03RrNfwxaYJcrDpBocCiTLkj
 w40tSu66trIeZgP8=
X-Received: by 2002:a5d:4c4c:: with SMTP id n12mr29661565wrt.162.1600527518306; 
 Sat, 19 Sep 2020 07:58:38 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwDfKDhir5rE9VN5E9TN8p1jEmGJylqYfOtbht4Z0i5gnfZ7LOi689BXkD1gHSL2gUhA6PgeQ==
X-Received: by 2002:a5d:4c4c:: with SMTP id n12mr29661552wrt.162.1600527518086; 
 Sat, 19 Sep 2020 07:58:38 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:b20a:b600:521c:512d?
 ([2001:b07:6468:f312:b20a:b600:521c:512d])
 by smtp.gmail.com with ESMTPSA id b18sm12248498wrn.21.2020.09.19.07.58.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 19 Sep 2020 07:58:37 -0700 (PDT)
Subject: Re: [PATCH 0/6] Convert pc-bios Makefiles to meson
To: marcandre.lureau@redhat.com, qemu-devel@nongnu.org
References: <20200918204759.225810-1-marcandre.lureau@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <0e14e115-797d-b91b-dec5-7a2a26836d92@redhat.com>
Date: Sat, 19 Sep 2020 16:58:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200918204759.225810-1-marcandre.lureau@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Received-SPF: pass client-ip=216.205.24.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/19 06:41:51
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
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
Cc: qemu-s390x@nongnu.org, Thomas Huth <thuth@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 18/09/20 22:47, marcandre.lureau@redhat.com wrote:
> From: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> Hi,
> 
> Here is a series of patches to convert the remaining Makefile in
> pc-bios/ to meson. I have done various tests to check that the
> resulting binaries are working as expected, but I didn't cover it
> all, and I am not sure the test su= ite covers them all either.

I don't know, the way pc-bios/ works seems just wrong to me.  pc-bios 
should IMO be its own build system with support for docker-based cross 
compilers similar to tests/tcg.

In fact one thing I was considering before falling in love with Meson :) 
was to write a simple meta-build-system for all of QEMU-owned ROMs, 
submodules such as SLOF and tests/tcg.  I never even got to the 
whiteboard phase, but if this were done, we could just build all the 
firmwares as a Meson 0.56 "external project"[1].

Paolo

[1] https://github.com/mesonbuild/meson/commit/master#diff-3a49da052fafbb502673f20d188644e1


