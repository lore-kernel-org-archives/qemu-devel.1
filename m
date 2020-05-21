Return-Path: <SRS0=QiA4=7D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6543C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 12:52:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 817F02072C
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 12:52:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gf8LMdSe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 817F02072C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52864 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbkgK-0007HT-NB
	for qemu-devel@archiver.kernel.org; Thu, 21 May 2020 08:52:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50824)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jbkat-0005EI-0Y
 for qemu-devel@nongnu.org; Thu, 21 May 2020 08:46:39 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:22728
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jbkas-0005H6-3B
 for qemu-devel@nongnu.org; Thu, 21 May 2020 08:46:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590065197;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PeGpWItfOJZddJcKTk8DZm7ycGZspJwU5c59cQRQihQ=;
 b=gf8LMdSe0al6H8BOsxpDh4zZws+CuYYbJZKcQGpCnNksGayh4gprqOVxZkusJg6w65gckL
 Tx8QdFRU44R/r9Wdqmi8+suxnIJAz8Xc6y3vB7ivPPNW5uxszlDr4RCr7EzO6j2uyB0pHO
 RveDvk+lg9wVL0vJnacRwuw1gtDzK2w=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-259-pGR-adOdO8iT4ezhDlJFOQ-1; Thu, 21 May 2020 08:46:33 -0400
X-MC-Unique: pGR-adOdO8iT4ezhDlJFOQ-1
Received: by mail-wr1-f69.google.com with SMTP id n9so2861139wru.20
 for <qemu-devel@nongnu.org>; Thu, 21 May 2020 05:46:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to;
 bh=pD7dRz0HbjX1Z3dLa5HOTCEnHSW5/TCCKIxYqYpngEc=;
 b=nfTl2hqzBXaB+vf5nuFCiC1VtbBAYgaIlQd/5mud9Tj9TRlEmmDXfEBZGXz8gjK3mg
 lsG8yCz8cYtoflaIesqqv5hQl0ECsKx6Xe/cgurS2zy0kWCEu77QBF21xzObqWTsBU6p
 c+4VunzP5rmypgqOqeaNX8sr0xmMAHGe4wXj1KeBiOLjpPeTYbNOckn5wmoyOKjxfjM2
 IvhKY5w7UiA4yXzPqv7NCJ7Fa/Pt7WWRMGkhpzso+Tnswv2urKL1Xzp3PHa1smNSeWP9
 iVxKrjx+mMiYCYlcRS7ztwffUEL+pI+eh4clNlZ0SUc0RFYvlsZjwKpC4Xyahxv0JTmc
 n2Dg==
X-Gm-Message-State: AOAM531IJedkGtLqoShBsZv3fqNf/MYUHXuflHU0T30GzM02K05VuT2S
 W9IJJuAJjEY0lbjEaNfocE2FMEvqi5Fvy2tYQ/CXCNBSeny04Kc79MxyihCbDBcoqjKTkqS75Ye
 Gzyv5McfvkAE6nOE=
X-Received: by 2002:a7b:cd84:: with SMTP id y4mr8651278wmj.2.1590065192229;
 Thu, 21 May 2020 05:46:32 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyEyF1k2JejKKSVxibxJ4yyBqQdG0zgPLI0TifQz9Mv8bIxe1K+QzV2XRFNX1X/6l0SLfa00A==
X-Received: by 2002:a7b:cd84:: with SMTP id y4mr8651259wmj.2.1590065191982;
 Thu, 21 May 2020 05:46:31 -0700 (PDT)
Received: from [192.168.178.58] ([151.30.94.134])
 by smtp.gmail.com with ESMTPSA id a17sm2483448wmm.23.2020.05.21.05.46.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 21 May 2020 05:46:31 -0700 (PDT)
Subject: Re: [PATCH 0/4] memory: Add memory_region_msync() & make NVMe
 emulated device generic
To: Stefan Hajnoczi <stefanha@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
References: <20200508062456.23344-1-philmd@redhat.com>
 <20200521123245.GG251811@stefanha-x1.localdomain>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <5514da71-8d9e-e784-bfad-5939bd7ac99f@redhat.com>
Date: Thu, 21 May 2020 14:46:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200521123245.GG251811@stefanha-x1.localdomain>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="cnPwKwY95zFoTWIEJTwV1FHsbv0FbsNN8"
Received-SPF: pass client-ip=207.211.31.81; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/21 04:44:45
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Beata Michalska <beata.michalska@linaro.org>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, qemu-arm@nongnu.org,
 Keith Busch <kbusch@kernel.org>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--cnPwKwY95zFoTWIEJTwV1FHsbv0FbsNN8
Content-Type: multipart/mixed; boundary="4m78srN6PibKSPtZF7iUwG0r86mCzYNKf"

--4m78srN6PibKSPtZF7iUwG0r86mCzYNKf
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 21/05/20 14:32, Stefan Hajnoczi wrote:
> On Fri, May 08, 2020 at 08:24:52AM +0200, Philippe Mathieu-Daud=E9 wrote:
>> Let the NVMe emulated device be target-agnostic.
>>
>> It is not clear if dccvap_writefn() really needs
>> memory_region_writeback() or could use memory_region_msync().
>>
>> Philippe Mathieu-Daud=E9 (4):
>>   memory: Rename memory_region_do_writeback -> memory_region_writeback
>>   memory: Extract memory_region_msync() from memory_region_writeback()
>>   hw/block: Let the NVMe emulated device be target-agnostic
>>   exec: Rename qemu_ram_writeback() as qemu_ram_msync()
>>
>>  include/exec/memory.h   | 15 +++++++++++++--
>>  include/exec/ram_addr.h |  4 ++--
>>  exec.c                  |  2 +-
>>  hw/block/nvme.c         |  6 ++----
>>  memory.c                | 12 +++++++++---
>>  target/arm/helper.c     |  2 +-
>>  hw/block/Makefile.objs  |  2 +-
>>  7 files changed, 29 insertions(+), 14 deletions(-)
>>
>> --=20
>> 2.21.3
>>
>>
>=20
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
>=20

Acked-by: Paolo Bonzini <pbonzini@redhat.com>


--4m78srN6PibKSPtZF7iUwG0r86mCzYNKf--

--cnPwKwY95zFoTWIEJTwV1FHsbv0FbsNN8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEE8TM4V0tmI4mGbHaCv/vSX3jHroMFAl7GeCYACgkQv/vSX3jH
roPoYgf+JNMgIUZzO7+lN61e+os+EfjEubcxarvJeqyjX2tl43tKjiz9g7ZG6nWu
W1ID5hJQPfoyAuzf8cCiroEG0WPpwfkw4OjuvhAmocDYfaF1BxPs9lf4CacIr4yQ
IPB9jxsdvgN2KMlo0NOKPzFuEaq17DOLr6tg2GhWTuA//3Qz5Xk5wxhIaMUzRjex
rHpHowj4FiHyB4EbFHZs9W6po8jLusY9r5QgDloBswwcrFOG0fop8FLPO/uUTv5J
R0KRWrjZiL/lCLu8WXwxyqfYc81Ap5fry/7tulCU4kA+eJJTSnzB5rNzwqT7KZ6r
piGDiRrcAhiF01TIEHlE1Kclj4epWg==
=fpV6
-----END PGP SIGNATURE-----

--cnPwKwY95zFoTWIEJTwV1FHsbv0FbsNN8--


