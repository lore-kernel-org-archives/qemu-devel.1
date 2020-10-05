Return-Path: <SRS0=FSHi=DM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFF92C4363A
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 13:20:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D517207BC
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 13:20:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DkYXQ8K2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D517207BC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55420 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPQPc-0000Gv-3P
	for qemu-devel@archiver.kernel.org; Mon, 05 Oct 2020 09:20:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45506)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kPQOU-00088z-1d
 for qemu-devel@nongnu.org; Mon, 05 Oct 2020 09:19:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:50620)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kPQOS-0003mb-FJ
 for qemu-devel@nongnu.org; Mon, 05 Oct 2020 09:19:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601903947;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ly6WXMgiiV3/HgpRTWHdsmm75VjE3sFn9KSShNvFuW0=;
 b=DkYXQ8K2L4vl9XimH2DquDqA1ssgmYRf9XgigmVYlH1oL+3SBShJRy6DGn5Hm5SbJ9+y/L
 vGU5GxrV/fmKk3n/RdO33O01udJg8VrTCyEIX9dU+huvr3W+0PxUlOzZD2vJmU3Jh2t/HE
 oYsj4vCd3G0p6mUhsVUeDw7b1LC9Eks=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-544-nsLTfdB-Noa_Nn8WGLRCEg-1; Mon, 05 Oct 2020 09:19:02 -0400
X-MC-Unique: nsLTfdB-Noa_Nn8WGLRCEg-1
Received: by mail-wr1-f72.google.com with SMTP id t17so679288wrm.13
 for <qemu-devel@nongnu.org>; Mon, 05 Oct 2020 06:19:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Ly6WXMgiiV3/HgpRTWHdsmm75VjE3sFn9KSShNvFuW0=;
 b=GNyHYg7LwxvAsInWpQoOSyvhe71DD964b0/KZyHmWoj0xMJQntP1GMsg75pR6WEwFG
 9+6/4DXRFeLyzIFip7S23Q83JQ05C/JG4lvUDxrCc7PW7AT0I5Pmf6o37jJGCAJYpuyp
 phzWbeuKqN49Xeha0ylnAFIHLi2Y/BqMT67YnjYaY2NLoCRoP02wslFQosG+mYgE3Ekp
 K/RJ30vSx2cD+VPrjgZdJY1ynK9cAvYq0HaTFxqjoJiYrj7CAMEYV4iUjou4aafX+pdV
 WvoZjfraIFqg98A6FVXdaGFo4rlx120YtN0oeFr9S2eUarg0xuJP0ZqAIWzfArERM/rx
 /Lyg==
X-Gm-Message-State: AOAM531C01yiZq2hEcHUILZqE8dNMvdANifhN7PTYh/Qyc1VQPFaSfII
 7sYQYZlcm363fjCXrV9IckmRX7cyg72AsuuTc+zpw5kzY6AIhR12PzYn/Ia6qu3Jqk0JKYkI1mC
 eX4o7MUSj+Z6cnuI=
X-Received: by 2002:adf:fc8d:: with SMTP id g13mr7569438wrr.248.1601903941352; 
 Mon, 05 Oct 2020 06:19:01 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy5riwbOxsK2ym1IO+QcjojSaQLdtvmxZdEwoj9iQW22hrxT6+bL/HkbkfGwNSeUyPC2HaJrw==
X-Received: by 2002:adf:fc8d:: with SMTP id g13mr7569412wrr.248.1601903941062; 
 Mon, 05 Oct 2020 06:19:01 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:2e86:3d8b:8b70:920c?
 ([2001:b07:6468:f312:2e86:3d8b:8b70:920c])
 by smtp.gmail.com with ESMTPSA id g12sm13410146wro.89.2020.10.05.06.19.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 Oct 2020 06:19:00 -0700 (PDT)
Subject: Re: [RFC PATCH 3/3] tests: Add a trivial qemu-storage-daemon test
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>,
 qemu-devel@nongnu.org
References: <20201005105442.2093105-1-philmd@redhat.com>
 <20201005105442.2093105-4-philmd@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <838fbab1-92f3-37da-dc7c-355fbc40f8bf@redhat.com>
Date: Mon, 5 Oct 2020 15:19:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20201005105442.2093105-4-philmd@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/05 01:25:11
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.733,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
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
Cc: Laszlo Ersek <lersek@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 qemu-block@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 05/10/20 12:54, Philippe Mathieu-Daudé wrote:
> This test fails on top of commit 69699f3055
> ("crypto/tls-cipher-suites: Produce fw_cfg consumable blob")
> because the TYPE_FW_CFG_DATA_GENERATOR_INTERFACE registered
> in hw/nvram/fw_cfg.c is not linked into qemu-storage-daemon:
> 
>   $ make check-block
>   Generating qemu-version.h with a meson_exe.py custom command
>     qemu-storage-daemon
>   tests/qemu-storage-daemon.sh: line 10: 2089929 Aborted                 (core dumped)
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> ---
>  tests/Makefile.include       |  3 +++
>  tests/qemu-storage-daemon.sh | 10 ++++++++++
>  2 files changed, 13 insertions(+)
>  create mode 100755 tests/qemu-storage-daemon.sh
> 
> diff --git a/tests/Makefile.include b/tests/Makefile.include
> index d257777560..be12581c77 100644
> --- a/tests/Makefile.include
> +++ b/tests/Makefile.include
> @@ -142,7 +142,10 @@ endif
>  check: check-block
>  check-block: $(SRC_PATH)/tests/check-block.sh qemu-img$(EXESUF) \
>  		qemu-io$(EXESUF) qemu-nbd$(EXESUF) $(QEMU_IOTESTS_HELPERS-y) \
> +		storage-daemon/qemu-storage-daemon \
>  		$(patsubst %-softmmu,qemu-system-%,$(filter %-softmmu,$(TARGET_DIRS)))
> +	$(call quiet-command, \
> +			$(SRC_PATH)/tests/qemu-storage-daemon.sh, "qemu-storage-daemon")
>  	@$<
>  endif
>  
> diff --git a/tests/qemu-storage-daemon.sh b/tests/qemu-storage-daemon.sh
> new file mode 100755
> index 0000000000..9fd4c73400
> --- /dev/null
> +++ b/tests/qemu-storage-daemon.sh
> @@ -0,0 +1,10 @@
> +#!/bin/sh
> +
> +# Test all QOM dependencies are resolved
> +storage-daemon/qemu-storage-daemon \
> +  --chardev stdio,id=qmp0  --monitor qmp0 \
> +  > /dev/null << 'EOF'
> +{"execute": "qmp_capabilities"}
> +{"execute": "qom-list-types"}
> +{"execute": "quit"}
> +EOF

I think you should either do this as a qemu-iotests testcase, or use
libqtest.

Paolo


