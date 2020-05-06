Return-Path: <SRS0=CRBd=6U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7D92C28CBC
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2020 12:08:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C9A1206DD
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2020 12:08:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NVkVCY/p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C9A1206DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35520 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWIqZ-0002df-M0
	for qemu-devel@archiver.kernel.org; Wed, 06 May 2020 08:08:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56434)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jWIo0-00066i-2j
 for qemu-devel@nongnu.org; Wed, 06 May 2020 08:05:40 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:54030
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jWInx-0008Az-JT
 for qemu-devel@nongnu.org; Wed, 06 May 2020 08:05:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588766733;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Lrczv+j6Wd9V8pXLvK37NjdjaIG/kQHx01eSO+UTiBk=;
 b=NVkVCY/pBrmSaStH4Ek26BuvzMSFg65PHgRp+mox6I0LBbuGo5w9QnE/b0lSyhGOnZZ1u1
 tYzAvIOdQ48QkSmGv0O+ZjP3wJXBMyMtfCOtpHSOC+G8pymDr8HRzlhiBix2VSAqkCQRlm
 S06I7CHry8CDtQaeh5pNLDZlqGXniiI=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-371-ooJ1gsVfMWyBdz-OsH_w0w-1; Wed, 06 May 2020 08:05:32 -0400
X-MC-Unique: ooJ1gsVfMWyBdz-OsH_w0w-1
Received: by mail-wm1-f70.google.com with SMTP id d134so2492872wmd.0
 for <qemu-devel@nongnu.org>; Wed, 06 May 2020 05:05:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=8UQCLO69Ng+9ievTR1YKMQ7IS7/Jm5XdR//BLbfIXfw=;
 b=Zl/vO9Oh8I5e3OT2eSneiEd5S1kcN86hNv7aXcXct18g2mG/ue3na3i+0C2CWclGXZ
 J75JYNkAfvJc/DNY6YuqtsVsUjbEbP5k+tPEjxFo4ASfVqIpWxjcf+Z0KI5+dir0tgRL
 REZUqUfe+20JWHzSUTk9BVXcl9an0O9rOEONpdqim5YAxiVbMHFYYop1/foXpiPLGyb6
 2+8WT0u7BDUjxLPRXvPGrKiY3sLpjLwMqOHDgyT7j8x69e+bm225sOIcyeJTR9NVtoxL
 76dNv3mj3FkD/fx8rn6ab7GraaRVjKg2+AcV+zIaFOrXhOBO5n9bzAOM4e3VPAuo94qF
 1rAw==
X-Gm-Message-State: AGi0PuZjAddj1QsAPU/XtyuBIZvbJqHzY65C9AvV2UhYss7e/coqIb4s
 9uvN46/mOw11Amb7sZIvW9Q++MBZL0uACbjez1cSyPmqW03wVgzIEjEcpoceX3qgKcSRrRil3K8
 HD0Ts4734KrGTcq0=
X-Received: by 2002:a5d:4c8c:: with SMTP id z12mr9993214wrs.213.1588766731362; 
 Wed, 06 May 2020 05:05:31 -0700 (PDT)
X-Google-Smtp-Source: APiQypID9ByNWET63NHG5jI3s2sGQ4G5KBGc9yPGtQrWpDhXMstOCjyUqlA/NeU73mJBjh5ebmxqSQ==
X-Received: by 2002:a5d:4c8c:: with SMTP id z12mr9993173wrs.213.1588766731048; 
 Wed, 06 May 2020 05:05:31 -0700 (PDT)
Received: from [192.168.1.37] (26.red-88-21-207.staticip.rima-tde.net.
 [88.21.207.26])
 by smtp.gmail.com with ESMTPSA id v16sm2727732wml.30.2020.05.06.05.05.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 06 May 2020 05:05:30 -0700 (PDT)
Subject: Re: [PATCH v1 1/2] hw/riscv: spike: Remove deprecated ISA specific
 machines
To: Alistair Francis <alistair.francis@wdc.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
References: <cover.1588727508.git.alistair.francis@wdc.com>
 <a051869c728f7f9c5e274b363ee76fc16451a043.1588727508.git.alistair.francis@wdc.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <d5834a53-4c45-423e-3559-d087ade1af6f@redhat.com>
Date: Wed, 6 May 2020 14:05:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <a051869c728f7f9c5e274b363ee76fc16451a043.1588727508.git.alistair.francis@wdc.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.81; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/06 02:39:40
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: alistair23@gmail.com, palmer@dabbelt.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/6/20 3:12 AM, Alistair Francis wrote:
> The ISA specific Spike machines have  been deprecated in QEMU since 4.1,
> let's finally remove them.
>=20
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> ---
>   hw/riscv/spike.c         | 217 ---------------------------------------
>   include/hw/riscv/spike.h |   6 +-
>   2 files changed, 2 insertions(+), 221 deletions(-)
>=20
> diff --git a/hw/riscv/spike.c b/hw/riscv/spike.c

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>


