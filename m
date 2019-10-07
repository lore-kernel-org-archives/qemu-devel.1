Return-Path: <SRS0=TwS2=YA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 574FAC47404
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2019 14:57:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 255D4206C2
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2019 14:57:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MrO5ZZfF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 255D4206C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45774 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iHURt-00034r-BA
	for qemu-devel@archiver.kernel.org; Mon, 07 Oct 2019 10:57:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43382)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1iHUR9-0002d8-8j
 for qemu-devel@nongnu.org; Mon, 07 Oct 2019 10:56:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1iHUR6-00059J-P3
 for qemu-devel@nongnu.org; Mon, 07 Oct 2019 10:56:33 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:45117
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1iHUR6-00057Y-GQ
 for qemu-devel@nongnu.org; Mon, 07 Oct 2019 10:56:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1570460191;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=o04kWq5K2oSrkpQ5oAZ+MNLlob9B9eBzn2D4bczmO3s=;
 b=MrO5ZZfFyo10/z8aIuP1J02tu4d9Ykpqf67Iy1t0aJQbtpB7mh3jUlLVvTHNPaygKN9B5W
 miRsGANihcTdopupsd5rNy8W0NqWSm25tfBg3z4qw8GPOmEiptjwV8FfenqOsouWKIIXMk
 Fk4YMrBTraLWp9r9IbVMjai8g+D3uZU=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-210-Yo6VtW0SN5euD5ebwBRYbA-1; Mon, 07 Oct 2019 10:56:29 -0400
Received: by mail-wm1-f69.google.com with SMTP id l3so6324621wmf.8
 for <qemu-devel@nongnu.org>; Mon, 07 Oct 2019 07:56:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=o04kWq5K2oSrkpQ5oAZ+MNLlob9B9eBzn2D4bczmO3s=;
 b=XsCjE8mrVKJRS9tD9VriToH/asiDx+dB+jWJKBiqU3z0fvalp1i9iiCwY80dPyfthF
 8uYZIf1SCvn4vIVsK6FmKvv6xJYNUGmnvtiPymelr6rODf8yEZbM+yaUbE4y0R1murQD
 AnwgrtUa2IA+CngrN/5VErw9zMSdUzhI/cmnHfUtZ3Rzo+O2zijVb9spK9XZ8CTJ2G/W
 0AIGIn0Sr27xZLXS1jzV4YW35hiXmkv0EPUwhPi04v3mAkNoOcwJB0McFo+ZQsgkFPwc
 Ns7du9WFJecrWLfokq91djyct1XjKtNviRtutz7pa3Ya1mlRfBMvxHUOdoKNO96Ml1qG
 7d3A==
X-Gm-Message-State: APjAAAVpKYk2R1WeP2/mBs13gCU03OEmroId5n79Lf74CndCWXAfPuEl
 GNmErXs0SfASMBIAcfZ4zLuDsL6lNg64PtPFNFGfs0enXLVKbC8i2dvI+eRmfvXcualpTHDtfVh
 BWX1DhQU7IUuJtGQ=
X-Received: by 2002:a1c:dcd6:: with SMTP id t205mr11584064wmg.10.1570460188048; 
 Mon, 07 Oct 2019 07:56:28 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzYMzsMVNFlUFJ/OKIYDzp32J+2TloADigVv72SlCf6zEtRkhHb/WMWj8K4gDAvuwUNaPKhhA==
X-Received: by 2002:a1c:dcd6:: with SMTP id t205mr11584053wmg.10.1570460187788; 
 Mon, 07 Oct 2019 07:56:27 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:9dd9:ce92:89b5:d1f2?
 ([2001:b07:6468:f312:9dd9:ce92:89b5:d1f2])
 by smtp.gmail.com with ESMTPSA id z189sm16153422wmc.25.2019.10.07.07.56.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 07 Oct 2019 07:56:27 -0700 (PDT)
Subject: Re: [PATCH] cpus: kick all vCPUs when running thread=single
To: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
References: <20191001160426.26644-1-alex.bennee@linaro.org>
 <5582c91e-ac0e-9f74-a3de-82f7fe25fadd@redhat.com> <874l0sl5z6.fsf@linaro.org>
 <d25121c7-e499-95e4-840e-4de53a4469f2@redhat.com>
 <a475e640-1739-24df-f873-d54abb891c35@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <54339ab0-054c-e0b8-30ac-267272a32e17@redhat.com>
Date: Mon, 7 Oct 2019 16:56:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <a475e640-1739-24df-f873-d54abb891c35@linaro.org>
Content-Language: en-US
X-MC-Unique: Yo6VtW0SN5euD5ebwBRYbA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Doug Gale <doug16k@gmail.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 07/10/19 16:00, Richard Henderson wrote:
>> I wasn't, since we have had a proper TCG maintainer for a while. :)
> Hah.  Point taken, and queued.  Would you care to go on the record with
> something more than a LGTM?

Sure,

Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>


