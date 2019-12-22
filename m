Return-Path: <SRS0=nsQZ=2M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B765C2D0C0
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Dec 2019 10:32:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4FDAE2070A
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Dec 2019 10:32:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TIUI5vHg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FDAE2070A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46066 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iiyXX-00005F-G3
	for qemu-devel@archiver.kernel.org; Sun, 22 Dec 2019 05:32:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41686)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1iiyWf-000884-Qz
 for qemu-devel@nongnu.org; Sun, 22 Dec 2019 05:31:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1iiyWd-0003ew-0N
 for qemu-devel@nongnu.org; Sun, 22 Dec 2019 05:31:51 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:22400
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1iiyWc-0003XJ-B7
 for qemu-devel@nongnu.org; Sun, 22 Dec 2019 05:31:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1577010709;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wkmeuOG7A+KZWuw49owg4IEFV/YvO4NNTRrnOnCHQ6s=;
 b=TIUI5vHgrC/grwzJn0cSXWBCpSjCG9aNcPMq9hS+OBqxtJs0zMRSHmSSYgMCkfjtxZKjKQ
 bAkvrEsh0H/QGGcB5DsIg4tu6I25kNlUWyaolCFt97TjpMylnguCrUALGCcxipFu2W6tem
 Msk5RFzcmvyiNNE36Wc32t7u484Tnl4=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-251-7fezw4iJOW67PFnSkbklyQ-1; Sun, 22 Dec 2019 05:31:43 -0500
Received: by mail-wr1-f72.google.com with SMTP id f10so5510536wro.14
 for <qemu-devel@nongnu.org>; Sun, 22 Dec 2019 02:31:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=nahE/yIk8qQZGhUo7k8PBb+OrHOzxJo7Z/ELjlA8mnM=;
 b=t+s39z7q/GLqq59AaIHcF2eVB72ckLeVHqUIll8CdmZSatb6Qv79hMqemtffIeJvIX
 KPRV8OhsEbCi3iUQRz46wATgUcW3hReyamMomY0GJoDZBWQ7OJ/Wivv3tjIcIGDhk4gs
 fOydTQMmKHnrtzjZxNDb9Xx/udt0JWonULMtpCObjw2s81wbmzlu9Mc7W8LG9JHPpumJ
 QJp34kQ/jU4faAhw6puFiEZstSAQ5Vonn+3FSjv6GELEOh0kt5y7hDSQOgKN1LYb/3Ce
 1/HFt6NNHj6uvw+KOsM6O4zlEvWGAs/UB4Bpnob39lpep15DF+ovdV+lWcrUOgbPLjOa
 EOhw==
X-Gm-Message-State: APjAAAWlbcuyWz9FjLm8eRrxlST3h/hmx1y2U/uHjiE0VMfhosujtQLi
 Tpjo2bwHdhvKhq7yvznQq7yP9DNqQ0VUMXqQZhxv9OidyNgCVrXg8WID2uAvT/Pd4+3X/xudkAz
 VMawUw5ovA0IWfdg=
X-Received: by 2002:adf:fcc4:: with SMTP id f4mr24796034wrs.247.1577010702045; 
 Sun, 22 Dec 2019 02:31:42 -0800 (PST)
X-Google-Smtp-Source: APXvYqzEo1K100Frfq0qKP86XLlMrN91otS8krMrLPYw0W9AC2Ynkb8uawoHV0v7Ap+/5xnVSVQSgw==
X-Received: by 2002:adf:fcc4:: with SMTP id f4mr24796005wrs.247.1577010701794; 
 Sun, 22 Dec 2019 02:31:41 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:7009:9cf0:6204:f570?
 ([2001:b07:6468:f312:7009:9cf0:6204:f570])
 by smtp.gmail.com with ESMTPSA id u22sm16974908wru.30.2019.12.22.02.31.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 22 Dec 2019 02:31:41 -0800 (PST)
Subject: Re: [PATCH] hw/i386/x86-iommu: Add missing stubs
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20191220154225.25879-1-philmd@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <df27c488-0cf2-1a4d-0de8-9509f442f5fb@redhat.com>
Date: Sun, 22 Dec 2019 11:31:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191220154225.25879-1-philmd@redhat.com>
Content-Language: en-US
X-MC-Unique: 7fezw4iJOW67PFnSkbklyQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Received-From: 207.211.31.81
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
 Eduardo Habkost <ehabkost@redhat.com>, Sergio Lopez <slp@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 20/12/19 16:42, Philippe Mathieu-Daud=C3=A9 wrote:
> In commit 6c730e4af9 we introduced a stub to build the MicroVM
> machine without Intel IOMMU. This stub is incomplete for the
> other PC machines. Add the missing stubs.

In other words, without this patch you cannot build without Q35 (which
brings in the IOMMU, at least unless building
--without-default-devices).  Is this correct?

Paolo

>=20
> Fixes: 6c730e4af9
> Reported-by: Travis-CI
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>  hw/i386/x86-iommu-stub.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>=20
> diff --git a/hw/i386/x86-iommu-stub.c b/hw/i386/x86-iommu-stub.c
> index 03576cdccb..c5ba077f9d 100644
> --- a/hw/i386/x86-iommu-stub.c
> +++ b/hw/i386/x86-iommu-stub.c
> @@ -32,3 +32,12 @@ X86IOMMUState *x86_iommu_get_default(void)
>      return NULL;
>  }
> =20
> +bool x86_iommu_ir_supported(X86IOMMUState *s)
> +{
> +    return false;
> +}
> +
> +IommuType x86_iommu_get_type(void)
> +{
> +    abort();
> +}
>=20


