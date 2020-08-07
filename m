Return-Path: <SRS0=Waq1=BR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E67CBC433E0
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2020 13:22:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B203D2086A
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2020 13:22:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EsFQQ/IZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B203D2086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51450 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k42KF-00073W-W7
	for qemu-devel@archiver.kernel.org; Fri, 07 Aug 2020 09:22:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51404)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k42Jc-0006Xj-SI
 for qemu-devel@nongnu.org; Fri, 07 Aug 2020 09:21:44 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:31489
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k42Jb-0005TR-B1
 for qemu-devel@nongnu.org; Fri, 07 Aug 2020 09:21:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596806502;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zMN2RLdFfTNLR6oXLxBg4se2VLc4ej206tLtuhyoHUo=;
 b=EsFQQ/IZ29k5nj1Qsud3Rz1zU6EwmTSqjI6zzNUCT2dZ6V/BcC/B/YQ01asGNpDJxXsPQh
 Gugo40K9CbdLa0KZU6VBC5THH8wi9ptLE5hC5rzDu4tdcJSDcwE0r9wAKa4kJhScZ9Dr1r
 hkZ/bTUEXJPi1PXyQKLI1lY/LyAPoVA=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-124-s31PP-7ANs6cI9cuGboYZw-1; Fri, 07 Aug 2020 09:21:40 -0400
X-MC-Unique: s31PP-7ANs6cI9cuGboYZw-1
Received: by mail-wm1-f69.google.com with SMTP id h6so665474wml.8
 for <qemu-devel@nongnu.org>; Fri, 07 Aug 2020 06:21:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=zMN2RLdFfTNLR6oXLxBg4se2VLc4ej206tLtuhyoHUo=;
 b=px4hRBWUtVoKvqU2nCj23/BDxgK79p6iroOC6G/0J9Sz+HYVEd+mLN5wCXE1vAJ6nF
 hQY8lTlaT4JR6pDfq9/v7BS4XT1SZaT8UGNZT9XCsS5ce1UYtZa1VOd0zxemG4Ev4b2r
 g9POeUbFVw2KrXXBieBhVsn5DlXjqROgMJ83MhnYL3qheH2YdSN4V1TTrTd2ZF01JKD3
 3XS5N1cGHCmGSG3bWPdvb4u5jJpdqBMeBM1q4E8CYkpOut4yqrgGJnGStMoVxLU2yHSZ
 gZy4IWMExQsfFDAHCVvt8wgPaEUde+Oyti/7vIu9+VZRMg9d92JN712ZctO5Fzx95CFM
 rYWg==
X-Gm-Message-State: AOAM533qBuhcCHotvAa+Bj9276HQamXjSIsXTAu7pCucLFbV53FJYQkT
 Md6fIggqjHIsZXXtP+XxTz4rzVEDISd4Lv1A7tzsPh5/bDrB/vkNxnkd/nJfdQgSZkIHIDIBaSD
 nv7v0UmKLXH2+uZQ=
X-Received: by 2002:a5d:66c7:: with SMTP id k7mr11783277wrw.290.1596806499587; 
 Fri, 07 Aug 2020 06:21:39 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzG+N7tkM6LDyuJp/JK+P8k4l+xjm+nCvIrHMng033oSsm5e8GtAZuGECEZXIeJnAb3eAQWtg==
X-Received: by 2002:a5d:66c7:: with SMTP id k7mr11783264wrw.290.1596806499413; 
 Fri, 07 Aug 2020 06:21:39 -0700 (PDT)
Received: from [192.168.178.58] ([151.20.136.3])
 by smtp.gmail.com with ESMTPSA id g188sm11755423wma.5.2020.08.07.06.21.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 07 Aug 2020 06:21:38 -0700 (PDT)
Subject: Re: [PATCH 007/143] tests/vm: do not pollute configure with
 --efi-aarch64
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <1596741379-12902-1-git-send-email-pbonzini@redhat.com>
 <1596741379-12902-8-git-send-email-pbonzini@redhat.com>
 <034b45cb-8b41-377d-778e-fec813357b2f@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <88f9be85-16ef-e7be-4527-af3465cc776d@redhat.com>
Date: Fri, 7 Aug 2020 15:21:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <034b45cb-8b41-377d-778e-fec813357b2f@redhat.com>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/07 04:00:03
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 07/08/20 15:06, Philippe Mathieu-Daudé wrote:
>> +EFI_AARCH64 = $(wildcard $(SRC_PATH)/pc-bios/edk2-aarch64-code.fd)
> I'm not sure this is correct. Shouldn't we use the '?=' operator to
> allow override? I think we want to test
> $(BUILD_DIR)/pc-bios/edk2-aarch64-code.fd instead.
> 

Command-line always override the Makefile value.  But yes I'll fix the path.

Paolo


