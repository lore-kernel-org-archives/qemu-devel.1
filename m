Return-Path: <SRS0=T5iq=DQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D62DBC433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 07:41:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F6E222277
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 07:41:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZUq8n5wL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F6E222277
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41916 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQn1o-0003jn-DO
	for qemu-devel@archiver.kernel.org; Fri, 09 Oct 2020 03:41:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38134)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kQn0z-00036q-3l
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 03:40:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:58035)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kQn0x-0007mr-HT
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 03:40:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602229230;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0QpIi+NO1E7TW+l+6Cu8HuQos58eXFVHh9DLnR4VFbE=;
 b=ZUq8n5wLLB1ief9j6htGFGnv2BAmkElSDVTwpZj/mgqrn71MyhlQ8xLkzOb/rvA9pnOhzA
 va3iqc8AlZFW8oE4FOEwzSS3DoxaMkJFavVcCEcbZrgX3LNfuZ8ffuH4a76fYrtluj68uM
 vuUis0wlCQ0LhQw0he1DD8DZye+mm64=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-534-mz0pq582OQK8dL6caGCJKA-1; Fri, 09 Oct 2020 03:40:28 -0400
X-MC-Unique: mz0pq582OQK8dL6caGCJKA-1
Received: by mail-wm1-f71.google.com with SMTP id p17so3816467wmi.7
 for <qemu-devel@nongnu.org>; Fri, 09 Oct 2020 00:40:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=0QpIi+NO1E7TW+l+6Cu8HuQos58eXFVHh9DLnR4VFbE=;
 b=S5ThhWE7RKALO8JWtLLpXO6f1Kd2hoxhdi5kZ6ihQ+f1w3kqFnGdND0fpZQYdQBBFI
 4ZSFcgoSDfASVAALYvqmgJTXD3m/MKZQ3zgw723gpiAV4Zck/wt13KF4YaIOtXc4CZVr
 hsHnSh8uEuzM+3aNXbFBWIsfgTVrGT1cTNvG/AOPCXP7m4aobAFS4wOCgoycyzrIpB+I
 A0vVjXgR1roMviL6F4nh7DnVdcoI4JOBiSFBNfCvirufYW9lI9S5LES9NaHac7W6H3xi
 JZEUZBuWBhHGhRpRxRSXHuNzuZk9pC547z0Xck4T34q7e8MofR/zTqbhBzzoA0cYUcVt
 WLuw==
X-Gm-Message-State: AOAM533w7yWJVJounhaVJw5BfPyciZJW1sdi5/Wzie5/FZSlkt16nxdI
 YOehKmA7yP+opLy/colktqTgEBFdj+kLCTd1kxeRz2xZ97k60nXSFuYGPl+MB2eUsvppKh4LE9P
 CHLv9h7P+nneG5nQ=
X-Received: by 2002:a05:6000:81:: with SMTP id
 m1mr13651454wrx.67.1602229227055; 
 Fri, 09 Oct 2020 00:40:27 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw7L2Tj7GXPqmti644vQrFLnUCNS2qDzrrJexXFzFxlFTlw964vB8ysP16m752hIIhxKBCqzQ==
X-Received: by 2002:a05:6000:81:: with SMTP id
 m1mr13651446wrx.67.1602229226871; 
 Fri, 09 Oct 2020 00:40:26 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:cee1:4797:6958:7698?
 ([2001:b07:6468:f312:cee1:4797:6958:7698])
 by smtp.gmail.com with ESMTPSA id c4sm10655023wrp.85.2020.10.09.00.40.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 09 Oct 2020 00:40:26 -0700 (PDT)
Subject: Re: does make check now require TCG? Or is it a parallelism issue?
To: Claudio Fontana <cfontana@suse.de>
References: <11ef73ff-4178-b3e8-2e49-44ff014a13ed@suse.de>
 <569520f6-adf6-6212-9625-a184bf499e24@redhat.com>
 <d21dff22-90b1-4769-0948-6bc37eaeb885@linaro.org>
 <6fe91a5a-c136-9af3-c48a-97ccdca7a543@suse.de>
 <3c527b0f-afa1-4b86-4fa5-9acca2a296bd@linaro.org>
 <CABgObfYWK2E8PsSFOcHpuA2vuA3HWgvtuLbrtQCWA=9=r07=5w@mail.gmail.com>
 <a1694fe3-9bc8-df93-345f-29f0de37b923@suse.de>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <8cedd3e4-dc6a-30ee-fd71-f4776aa8c953@redhat.com>
Date: Fri, 9 Oct 2020 09:40:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <a1694fe3-9bc8-df93-345f-29f0de37b923@suse.de>
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
 NICE_REPLY_A=-0.214, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
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
Cc: Alex Bennee <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 08/10/20 23:07, Claudio Fontana wrote:
> qtests are also broken for me now with --disable-tcg build,
> it _seems_ to me that TCG-only tests are being run for --disable-tcg too.
> 
> I am not sure if this is a test problem (for example tests/qtest/bios-tables-test.c): data->tcg_only
> or if it is a build system problem, or some combination.

Yes, this is due to tcg_only.  But since CONFIG_TCG is included in
config-host.mak, it should be easy to add a call to g_test_skip.

Paolo


