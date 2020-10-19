Return-Path: <SRS0=qJMs=D2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF5E0C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 13:28:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2132620773
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 13:28:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DCl8HdnG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2132620773
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38206 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUVCh-00082h-48
	for qemu-devel@archiver.kernel.org; Mon, 19 Oct 2020 09:27:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42654)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kUVAt-000796-LA
 for qemu-devel@nongnu.org; Mon, 19 Oct 2020 09:26:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:37873)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kUVAr-0004xj-Vq
 for qemu-devel@nongnu.org; Mon, 19 Oct 2020 09:26:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603113964;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ksbl7mxjv/cuvPS4O4ITILOnb2h789qIXsSGPgp3RVg=;
 b=DCl8HdnGytOV5tLKI9zF4BqmXgPcu44pWjINsuH0dft8O9OFaEZDIr31pgc9oltD6InMmG
 MA2bhhWAs41wRJM+e5jgQf4NqIuID9Mut+57XwYmc5SlKn60fqrETZ5pmgwP4xrhRYpo0C
 P7f0L1L4axAOyiEM1J/Q8401lcdteNo=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-512-hg2wFOtpMTWtmMfSGfmgVA-1; Mon, 19 Oct 2020 09:26:03 -0400
X-MC-Unique: hg2wFOtpMTWtmMfSGfmgVA-1
Received: by mail-wm1-f69.google.com with SMTP id g71so4569987wmg.2
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2020 06:26:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ksbl7mxjv/cuvPS4O4ITILOnb2h789qIXsSGPgp3RVg=;
 b=Dg7m7qL4pDM3+kHuU0W/NKye6EMoqk9pyXIc3Yf3CE6KXyMZ9eJzNqxzygcjswL2SW
 NOgvvTZ76/vYaoHqM2QbsQn+UnCZV4lNvqf3asgrf2XQs/JwOCTgetBoQjaZ/tH0s6U0
 W4E3bxhAu7MzaQplf+TlAqlgLHAFjqUA90n/XfY1h9CXBEnwq7U3YSf5pcFpeM+btAM5
 EJTsQT7vZqnDF5RMfrNuP/f+lXuy9cp/0BdEeDtRoG2vVqn+4EUIkKHVcn4R3Kd6n7n2
 ujAE5vTRHmZytI8RM6MKIdVJeeZr79a80mrCOlrv+4qQHJ3DcvTyJwGNZ0iOnKyENNQ1
 D8dQ==
X-Gm-Message-State: AOAM532RCll4nsnXE29hCNdS//2YzOiHmaHaSSUWZZpMrsJr2qh6ZTnH
 gw7hen3/F/XJSqRhbwHs1r2ygz6JkSGsxjIPdiPWWwnDFEeblzedL5jiLpflZriQ1JEeC6z6iI8
 ALGUP3bM8WpustWc=
X-Received: by 2002:adf:8541:: with SMTP id 59mr19803390wrh.61.1603113961968; 
 Mon, 19 Oct 2020 06:26:01 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyR9xRQSTuRtKwZZd0/PTsphVhxdpcWyh/+TMO7pHLo+nPsJHWAmLs7SRKkMpbl31BaIjSevg==
X-Received: by 2002:adf:8541:: with SMTP id 59mr19803373wrh.61.1603113961786; 
 Mon, 19 Oct 2020 06:26:01 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a?
 ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
 by smtp.gmail.com with ESMTPSA id u20sm11209wmm.29.2020.10.19.06.26.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 19 Oct 2020 06:26:01 -0700 (PDT)
Subject: Re: [PATCH] configure: Test that gio libs from pkg-config work
To: Peter Maydell <peter.maydell@linaro.org>
References: <20200928160402.7961-1-peter.maydell@linaro.org>
 <0cbbe621-cae0-548b-fecf-0dd0e7b30fec@redhat.com>
 <CAFEAcA_nKtDRzV9YUdMoNXRV_o_rp-y2aai3zH2JsM7yWhJ9eg@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <783fb422-5561-e113-9d25-a3079dbd2a41@redhat.com>
Date: Mon, 19 Oct 2020 15:26:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_nKtDRzV9YUdMoNXRV_o_rp-y2aai3zH2JsM7yWhJ9eg@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/19 02:32:01
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
Cc: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 19/10/20 13:16, Peter Maydell wrote:
> On Mon, 28 Sep 2020 at 17:42, Paolo Bonzini <pbonzini@redhat.com> wrote:
>>
>> On 28/09/20 18:04, Peter Maydell wrote:
>>> I wanted a statically-linked system emulation binary (which, yes,
>>> I know is not really something we support :-)). I got one with
>>> suitably liberal use of --disable-foo configure options, and
>>> this was the only thing I couldn't work around that way.
>>> The patch is needed because there's no --disable-gio. I suppose
>>> we could add that instead (or as well)...
>>> Possibly meson offers a nicer way to do this, but this was
>>> simple and gnutls is doing the check this way already.
>>
>> No, you'd get just that warning about static libraries not being
>> available; so I think either this patch or --disable-gio is fine.
> 
> Could I have a Reviewed-by: if you're happy with this patch?

Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>


