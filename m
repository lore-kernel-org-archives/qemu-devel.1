Return-Path: <SRS0=SHB2=AK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81D9FC433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 15:35:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5207D251E6
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 15:35:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GgVvO/+L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5207D251E6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38380 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jpvoH-0005CN-KR
	for qemu-devel@archiver.kernel.org; Mon, 29 Jun 2020 11:35:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35166)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jpvlz-0002uA-PB
 for qemu-devel@nongnu.org; Mon, 29 Jun 2020 11:32:43 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:23290
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jpvly-00037Q-1I
 for qemu-devel@nongnu.org; Mon, 29 Jun 2020 11:32:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593444761;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xSEKWLIff91k0QtT2B+qgNFOXQtfs85ZJbiETAijifA=;
 b=GgVvO/+LpHG/pWT2J0ka6IQ2P1QXwO2/dgwzEP2ow2xlrsO2OTC02f/IpjMr4BN84Ks73V
 zH8vuCVn2Niwp8hBeSqdvPh1kenYEvdkZGW0Zxtu6qbB7qphuy8yKWB72YpHgpa2H1zwA3
 XvPbQV2G7rr6bs/5c8C3iw/qNKHP3xA=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-514-eXVxja_PO0Ca4DJScp7xFA-1; Mon, 29 Jun 2020 11:32:19 -0400
X-MC-Unique: eXVxja_PO0Ca4DJScp7xFA-1
Received: by mail-wr1-f70.google.com with SMTP id z3so16626852wrr.7
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2020 08:32:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=xSEKWLIff91k0QtT2B+qgNFOXQtfs85ZJbiETAijifA=;
 b=WNEeB1/j/bOmocGWFXzIkCW7aaotiPMlZPA5rqcDR+qbWy0N29rlVGrYqhLw4V29e+
 qktRx8vtYNXUHFZVX2RcybA6hgbjWG2VInKcH5HhFqNttXtsDV5LghFOWJljiVeB2CEy
 jzRvPwxlkpAeY7cPN71nzdIF+2V37cXmWRMT8YsOEgXpS/0Br+L5bkneKVYBqPVh74yd
 +x9CHrfbZoMk/gRMZbgCCEIBBfYXam/8DWJaBXCi/RnzmUFXODhCWNrOatow7vEu4pNw
 QRtHa9d4z4qfP+izMMAjdLihyO/X5ndMbVbefQHZA1upKKNdDJ3GXeg2dgYLGlHytF3Z
 Mr7A==
X-Gm-Message-State: AOAM530eJDMzLK8AZj3BBh5O0dJZ5IaSYMCErDcwl0ZVA62yjzRf1E1f
 jnhJ0mVB7/77vLZ1A1qkKwuZgT69JZrGW1L8wRN6utD0vo/f9r5cskuU5l4XZ16P4so/gk+z9QM
 AOw3T6TZWoOde+3g=
X-Received: by 2002:a5d:518a:: with SMTP id k10mr17181219wrv.316.1593444738474; 
 Mon, 29 Jun 2020 08:32:18 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyQRT25GooWgmdLQlbOF/hxp4aFgsifTelcxqZjOWD6EvyYt0uy+Us3pgPd9an2UvJEzlBoQQ==
X-Received: by 2002:a5d:518a:: with SMTP id k10mr17181207wrv.316.1593444738239; 
 Mon, 29 Jun 2020 08:32:18 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:b0e5:c632:a580:8b9a?
 ([2001:b07:6468:f312:b0e5:c632:a580:8b9a])
 by smtp.gmail.com with ESMTPSA id a22sm183924wmj.9.2020.06.29.08.32.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 29 Jun 2020 08:32:17 -0700 (PDT)
Subject: Re: [PATCH v2 5/9] nvram: add nrf51_soc flash read method
To: P J P <ppandit@redhat.com>, Li Qiang <liq3ea@gmail.com>
References: <20200624185523.762240-1-ppandit@redhat.com>
 <20200624185523.762240-6-ppandit@redhat.com>
 <CAKXe6SKBYpdouoN=C_NZawLOnDMYjDU2X3c2CsCv7X7rPym1Rg@mail.gmail.com>
 <nycvar.YSQ.7.77.849.2006291718520.92950@xnncv>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <f76bf4c5-7b6a-8ee2-b46f-9799f879ef16@redhat.com>
Date: Mon, 29 Jun 2020 17:32:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <nycvar.YSQ.7.77.849.2006291718520.92950@xnncv>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/29 01:06:01
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Lei Sun <slei.casper@gmail.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 29/06/20 13:55, P J P wrote:
> | 
> | I prefer here just 'qemu_log_mask(LOG_UNIMP, "%s not implemented\n", 
> | __func__);' as other patches does.
> 
> Earlier patch v1 did that. It was suggested to return ldl_le_p(), as that's a 
> valid return IIUC, instead of a zero(0), in case flash_read() is called.
> 
> Thanks so much for the reviews. I'll send a revised series with due updates.

I think abort() is preferable (while LOG_UNIMP is wrong as it implies
there is something to do that QEMU is not doing).

Paolo


