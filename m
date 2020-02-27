Return-Path: <SRS0=0TZc=4P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31E39C11D3D
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 15:53:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F1DFE246A0
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 15:53:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dqBBmDre"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1DFE246A0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33648 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7LTf-0000vu-73
	for qemu-devel@archiver.kernel.org; Thu, 27 Feb 2020 10:53:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34224)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1j7LSh-0008QA-Dw
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 10:52:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peterx@redhat.com>) id 1j7LSg-0004kF-FY
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 10:52:31 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:26913
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <peterx@redhat.com>) id 1j7LSg-0004iv-Bl
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 10:52:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582818749;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5KwB+4nPPWFT9Zo+52l+UcQYm3R48JujDx1PXyBuh3I=;
 b=dqBBmDrefQycFPfdmp9z3iHMlcT6QrQavtWQSEJ2rrBewT9vZ2mZ4J7XVn0k0PV/fZz8ES
 hCsz1jZhu1QdOoBjvJ/qSY2uLpVJW7UhBrIB/hsyljx549QuUL001R3pN9katZ5o35a8KZ
 Iv/JWcdPrwzQurTls5q2Uj4k4VbwQL8=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-306-VvKRfRymNYGvIW2rN48InQ-1; Thu, 27 Feb 2020 10:52:28 -0500
X-MC-Unique: VvKRfRymNYGvIW2rN48InQ-1
Received: by mail-qt1-f199.google.com with SMTP id k20so4105934qtm.11
 for <qemu-devel@nongnu.org>; Thu, 27 Feb 2020 07:52:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=HbpZ79Vvpf6y5qlqo/6aoznhZgU8GmfHB3anv411c9o=;
 b=TszDRPVIj7/w2cO9KxRXQeZf0L0cJ7zyZYg7vGZyxMLr4bgQrqgoep4cPFlNea3CU0
 5pn8FlI2D23/In9dVC2bWWJRbUns0nH1YVYc68cIjhgRkCIfVyjXIbGX+jfLIPCGugYG
 5yn6NA0hpDOPUNgWsxSDSEtVRAxADBqCkkvIjSBjsPDwe6SRt/tYSWYq+c+oA7LnU3PR
 YEm+b0BPg6zccuty1DBWvhvZt0PMecuXRAWrVadUENpvuC2ZVYXX0ngtcr56xDwzJJiA
 LNz6L1WaXUF/HMOH/7504h+Dv0P6kg3YYcpeyni0GNZQYb53QyCN/nS3hV2T3UOPIePu
 XclA==
X-Gm-Message-State: APjAAAUbOn4gS4gbnX57ZCeRlAwR2rKEsWPB1QraD7lP1YG7YxKEf1wo
 WQNl7+7lij+8BMIraMKiv1QZXLUuTj7nOGIA9+vP1AMi1Rpf2x5P5wVO2EKIITm3ssw+WAJlmbq
 OZC97XsIgeoZhRbY=
X-Received: by 2002:ac8:5510:: with SMTP id j16mr5789095qtq.262.1582818747681; 
 Thu, 27 Feb 2020 07:52:27 -0800 (PST)
X-Google-Smtp-Source: APXvYqwQ34lbsakqXMMJm3hsX3qqYkozgG4yFvRhOdhTOTjqWIlLxjZ/DBW9yrVtaOU5MLqHGdR8IQ==
X-Received: by 2002:ac8:5510:: with SMTP id j16mr5789067qtq.262.1582818747455; 
 Thu, 27 Feb 2020 07:52:27 -0800 (PST)
Received: from xz-x1 ([2607:9880:19c0:32::2])
 by smtp.gmail.com with ESMTPSA id i91sm3362620qtd.70.2020.02.27.07.52.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Feb 2020 07:52:26 -0800 (PST)
Date: Thu, 27 Feb 2020 10:52:25 -0500
From: Peter Xu <peterx@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Subject: Re: [PATCH v2 2/2] hw/arm/smmu-common: Simplify
 smmu_find_smmu_pcibus() logic
Message-ID: <20200227155225.GE180973@xz-x1>
References: <20200227075111.15275-1-philmd@redhat.com>
 <20200227075111.15275-3-philmd@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200227075111.15275-3-philmd@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: Eric Auger <eric.auger@redhat.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Feb 27, 2020 at 08:51:11AM +0100, Philippe Mathieu-Daud=C3=A9 wrote=
:
> The smmu_find_smmu_pcibus() function was introduced (in commit
> cac994ef43b) in a code format that could return an incorrect
> pointer, which was then fixed by the previous commit.
> We could have avoid this by writing the if() statement differently.
> Do it now, in case this function is re-used. The code is easier to
> review (harder to miss bugs).
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

--=20
Peter Xu


