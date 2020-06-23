Return-Path: <SRS0=Q9tF=AE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B709C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 00:34:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5BFD82053B
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 00:34:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FCv7QLn+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BFD82053B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44094 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnWtO-00079b-JW
	for qemu-devel@archiver.kernel.org; Mon, 22 Jun 2020 20:34:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52206)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jnWsR-00060B-3W
 for qemu-devel@nongnu.org; Mon, 22 Jun 2020 20:33:27 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:60210
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jnWsP-0006eD-Dk
 for qemu-devel@nongnu.org; Mon, 22 Jun 2020 20:33:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592872404;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KOmEJ2oxzESZ3EuEW5xU1n8YJTu+KDq1M6AO0eMmXRo=;
 b=FCv7QLn+V6pynmtdxZXLfNbGUsM8oBZJl9SovUcjmEsScJqHdhbdhjgqxbqksAs/lVm2k2
 wSMt+b0QlINdnbNkWS0uyZgnoT4OUMAnBOLc0WM6cCd2/v7cjeamoguZfKyLlV/vXzaKFn
 s7X0eRjyLBZlj909gllAM8bGi4VnNmg=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-51-tt_mO76HNz6PTE2gE8gqyw-1; Mon, 22 Jun 2020 20:33:22 -0400
X-MC-Unique: tt_mO76HNz6PTE2gE8gqyw-1
Received: by mail-wr1-f71.google.com with SMTP id z3so6435903wrr.7
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2020 17:33:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=KOmEJ2oxzESZ3EuEW5xU1n8YJTu+KDq1M6AO0eMmXRo=;
 b=LpcahGE7uKtzYT0A00c1aJ9zPV91reFYa6/NOxm+ootoOmH6UTNTO5orrBaWRz6pC0
 YXjQojJdJ0rPSIeMfCwEGs1uiAowH9Bfbh/Q32etkvvya4+Fs2NNBYoAm+MijA21IGVm
 RgoeIsUqMwBu+LCWdcRcK4Zf9j0OtKdulp+rqc9YqtTNieHbHy4qNQD86T72L4Tv5KJJ
 5LahHKATifgoVWnshq3eVLX+JTRoEH8nXAHs9C74Z1c8ywAnJGoHdlfMVMsaL8eDZ5MK
 cXwXJr9zyF4J2wSo6ps2B9aa4jBpBQ4bbJxI7dOoMb6BcmKPdyNeMBEzAn9AFLUIfM2H
 bSXg==
X-Gm-Message-State: AOAM531ZKQI6RafY/K7IKuHUcpfBYQ+j0MAal2GZn2LQm6T519v6PXdV
 yX1SXSCKQYjO2DIpBDI9WxBq91juvy4jbf5SgKylbAXRI/f7Fg2rQBrIGXX+V+f5V+C+b8i16x+
 /EFtmq+2f6MN1fbU=
X-Received: by 2002:adf:a396:: with SMTP id l22mr21742276wrb.24.1592872401622; 
 Mon, 22 Jun 2020 17:33:21 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzkx05z733Qq+ThgqlOQ3tRDJeYr1nU+3hok92SdnvMz36tDaXWQrSIE1uWk2ZpkOZX8oXMHw==
X-Received: by 2002:adf:a396:: with SMTP id l22mr21742249wrb.24.1592872401297; 
 Mon, 22 Jun 2020 17:33:21 -0700 (PDT)
Received: from [192.168.10.150] ([93.56.170.5])
 by smtp.gmail.com with ESMTPSA id j41sm21022293wre.12.2020.06.22.17.33.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 22 Jun 2020 17:33:20 -0700 (PDT)
Subject: Re: [PATCH v2] target/i386: reimplement fpatan using floatx80
 operations
To: Joseph Myers <joseph@codesourcery.com>, qemu-devel@nongnu.org,
 rth@twiddle.net, ehabkost@redhat.com
References: <alpine.DEB.2.21.2006230000340.24721@digraph.polyomino.org.uk>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <27588539-95cc-f10f-b8c2-c263b56c921a@redhat.com>
Date: Tue, 23 Jun 2020 02:33:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.2006230000340.24721@digraph.polyomino.org.uk>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/22 02:57:26
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 23/06/20 02:01, Joseph Myers wrote:
> The x87 fpatan emulation is currently based around conversion to
> double.  This is inherently unsuitable for a good emulation of any
> floatx80 operation.  Reimplement using the soft-float operations, as
> for other such instructions.
> 
> Signed-off-by: Joseph Myers <joseph@codesourcery.com>

Queued, thanks.

Just one question: do recent processors still use the same CORDIC
approximations as the 8087, and if so would it be better or simpler to
do that instead of using a good implementation such as this one?

Thanks,

Paolo


