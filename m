Return-Path: <SRS0=Vgkn=6S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D1A2C4724C
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 15:50:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2BE3A206B9
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 15:50:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KnGmoY0p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BE3A206B9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55212 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVdLz-0006aP-AD
	for qemu-devel@archiver.kernel.org; Mon, 04 May 2020 11:49:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33156)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jVd8w-0006ln-DO
 for qemu-devel@nongnu.org; Mon, 04 May 2020 11:36:30 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:40501
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jVd8u-0003ZZ-FT
 for qemu-devel@nongnu.org; Mon, 04 May 2020 11:36:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588606587;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RciDH52nzyij8YDWKHsrEAIcYxsUXaCxv4y8LN4ySko=;
 b=KnGmoY0p6V2m/GsEg1s0kNaI580+/tzA5hufRi9jLPWqpfR6EGXL1QCUv7MbdBWEgr9CWn
 TwbWcKvutUzghrS9eT01csWORVikgNvAZJ/NOB1Awtp7leHkX/XZFRy5flO4Gxxi3yUqTY
 tKYV9dljnnf8G01+y3EfZG9Sc1eEz4k=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-464-qN64hi4rONG8yIoyvW6Cnw-1; Mon, 04 May 2020 11:36:26 -0400
X-MC-Unique: qN64hi4rONG8yIoyvW6Cnw-1
Received: by mail-wm1-f70.google.com with SMTP id v185so3724724wmg.0
 for <qemu-devel@nongnu.org>; Mon, 04 May 2020 08:36:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=IOjp0VqFANNYRmUXVrk3BZIyo18bdF5lD+2RqjtpK/E=;
 b=CgwIADwD3VGIuagwQoHlKrTq8AWR4iDKLExw8b7aCYXMIgCUaSFa7AdRh8HSpomXj5
 xChC1iMJD5DWvjRI0y8ggW4/f6i4LP/VvU7Zry4IYP9UZ9iYEadw3G0+usEfuxG+V9u3
 Lnh1+bgdoFYPo22wf2KyqrtdSqD7so7PnQnArMAxL/i6O+XeZgkmfTayJQB8u0YHAWCO
 XJwSi1hHFrxXj8hgq5fQOmB/nj3S0sEUYdPKeiqTTKPHEOHxTZqIU8ZtHd/Did6qIFSa
 pn62zL3HE6NsrQwpko6TyYNXav3+4qSA0kBMX7jPkP1Yj01PzZ1NU/JN8TYXrx46WFiS
 bMbg==
X-Gm-Message-State: AGi0PuY6izAt17r10Ewq20qyGtvUc075eyTRWQclKfswFi1WCPc6JraW
 P4vE09zkmiZ7+KihWbpLk8ywzq6mTCUghwK3E/Lp7aZUJmLqmLVwmhQug79b/Cr65FRA8TlFKOq
 mLQda4BUvpJVbCL0=
X-Received: by 2002:adf:f344:: with SMTP id e4mr12951218wrp.395.1588606584793; 
 Mon, 04 May 2020 08:36:24 -0700 (PDT)
X-Google-Smtp-Source: APiQypLiYzX0e3x5kA/EQrEd99JwAYblvumRCJyMWb7Hp4RghYNepqTE3o0OeX8BVOK/yB+F1SwUNg==
X-Received: by 2002:adf:f344:: with SMTP id e4mr12951188wrp.395.1588606584588; 
 Mon, 04 May 2020 08:36:24 -0700 (PDT)
Received: from [192.168.1.39] (26.red-88-21-207.staticip.rima-tde.net.
 [88.21.207.26])
 by smtp.gmail.com with ESMTPSA id n131sm14285042wmf.35.2020.05.04.08.36.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 04 May 2020 08:36:23 -0700 (PDT)
Subject: Re: [RFC PATCH 6/6] hw/block/nvme: Make device target agnostic
To: qemu-devel@nongnu.org
References: <20200504094641.4963-1-philmd@redhat.com>
 <20200504094641.4963-7-philmd@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <9a46b1b4-bfbf-21bd-cc66-5904e784150c@redhat.com>
Date: Mon, 4 May 2020 17:36:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200504094641.4963-7-philmd@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.61; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/04 01:21:32
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 Beata Michalska <beata.michalska@linaro.org>, qemu-block@nongnu.org,
 Maxim Levitsky <mlevitsk@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Keith Busch <kbusch@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

+Keith new email

On 5/4/20 11:46 AM, Philippe Mathieu-Daud=C3=A9 wrote:
> The NVMe device should not use target specific API.
> Use memory_region_do_writeback() (which was introduced
> in commit 61c490e25e0, after the NVMe emulated device
> was added) to replace qemu_ram_writeback().
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
> RFC because I have no clue how dirty_log_mask works.
>=20
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Beata Michalska <beata.michalska@linaro.org>
> ---
>   hw/block/nvme.c        | 4 +---
>   hw/block/Makefile.objs | 2 +-
>   2 files changed, 2 insertions(+), 4 deletions(-)
>=20
> diff --git a/hw/block/nvme.c b/hw/block/nvme.c
> index 9b453423cf..9b0ac0ea2a 100644
> --- a/hw/block/nvme.c
> +++ b/hw/block/nvme.c
> @@ -46,7 +46,6 @@
>   #include "qapi/visitor.h"
>   #include "sysemu/hostmem.h"
>   #include "sysemu/block-backend.h"
> -#include "exec/ram_addr.h"
>  =20
>   #include "qemu/log.h"
>   #include "qemu/module.h"
> @@ -1207,8 +1206,7 @@ static uint64_t nvme_mmio_read(void *opaque, hwaddr=
 addr, unsigned size)
>            */
>           if (addr =3D=3D 0xE08 &&
>               (NVME_PMRCAP_PMRWBM(n->bar.pmrcap) & 0x02)) {
> -            qemu_ram_writeback(n->pmrdev->mr.ram_block,
> -                               0, n->pmrdev->size);
> +            memory_region_do_writeback(&n->pmrdev->mr, 0, n->pmrdev->siz=
e);
>           }
>           memcpy(&val, ptr + addr, size);
>       } else {
> diff --git a/hw/block/Makefile.objs b/hw/block/Makefile.objs
> index 47960b5f0d..8855c22656 100644
> --- a/hw/block/Makefile.objs
> +++ b/hw/block/Makefile.objs
> @@ -13,6 +13,6 @@ common-obj-$(CONFIG_SH4) +=3D tc58128.o
>  =20
>   obj-$(CONFIG_VIRTIO_BLK) +=3D virtio-blk.o
>   obj-$(CONFIG_VHOST_USER_BLK) +=3D vhost-user-blk.o
> -obj-$(CONFIG_NVME_PCI) +=3D nvme.o
> +common-obj-$(CONFIG_NVME_PCI) +=3D nvme.o
>  =20
>   obj-y +=3D dataplane/
>=20


