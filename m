Return-Path: <SRS0=kfsL=DV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88E62C433E7
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 12:36:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6D84520848
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 12:36:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=euphon.net header.i=fam@euphon.net header.b="NMzUlQ00"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D84520848
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=euphon.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53544 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSg0s-0007dd-24
	for qemu-devel@archiver.kernel.org; Wed, 14 Oct 2020 08:36:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60528)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fam@euphon.net>)
 id 1kSfzq-0006x8-1R; Wed, 14 Oct 2020 08:35:10 -0400
Received: from sender2-op-o12.zoho.com.cn ([163.53.93.243]:17644)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fam@euphon.net>)
 id 1kSfzm-0006RE-9W; Wed, 14 Oct 2020 08:35:09 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1602678886; cv=none; d=zoho.com.cn; s=zohoarc; 
 b=KFyF1/3M7DMqyTnJWnWyA6c/Ko92ngXXdtoXPGte5kDTH9tKtgU7Rw+akpIv7N9RnGwETCBfIzOmHBE36AHtfDSKKs1Qa8J07I3RJ8AmxL2K9CirYzNw408BDXpGjE/+lozI6lVmOqnuBimabEL2xyJapNdh/PJdJSZ2+Z7cc7I=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com.cn;
 s=zohoarc; t=1602678886;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To;
 bh=QkF4/s64hqeKLvvY/MaQH2AHWRPWyAbK3zpYQyCWXMg=; 
 b=A8Mzbc/kWtkakzCy+oJvXfo9Hr9hTD9N/VVCII/rjCW8ZaDiXGYCa4P1Y1rSB5OGstIbEFpl0fdq5gBYAhwXdSY+pqb0vVwHWP7KyF2hXq5KDZt/45h03aP/1CsO3Ld+gZhW0dARv5VKhnlOSD8iqzw//xUNGjcCIUFFy5vU3e4=
ARC-Authentication-Results: i=1; mx.zoho.com.cn;
 dkim=pass  header.i=euphon.net;
 spf=pass  smtp.mailfrom=fam@euphon.net;
 dmarc=pass header.from=<fam@euphon.net> header.from=<fam@euphon.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1602678886; 
 s=zoho; d=euphon.net; i=fam@euphon.net;
 h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:Content-Type:Mime-Version:Content-Transfer-Encoding;
 bh=QkF4/s64hqeKLvvY/MaQH2AHWRPWyAbK3zpYQyCWXMg=;
 b=NMzUlQ00poetc1F3asA1ws0zju1P/QUtTUKaSj/EjdHDbs1yYQA3tcQA661mm3I1
 VFTTd7xZJZMHv0O54Ik/NBvTcbWnqyhNGWlsePjmwLbM+cS3kqPr9NVAPz0MmhUnBys
 at+2K71hyPK9Yj/v438FQNtf24zod5Uf8nsU4wn4=
Received: from u60bdefc337955a.ant.amazon.com (54.239.6.185 [54.239.6.185]) by
 mx.zoho.com.cn with SMTPS id 1602678882493867.9108707620145;
 Wed, 14 Oct 2020 20:34:42 +0800 (CST)
Message-ID: <9d08c9ab6310a5f0c796c4d98d1c51f071802369.camel@euphon.net>
Subject: Re: [PATCH 0/9] util/vfio-helpers: Improve debugging experience
From: Fam Zheng <fam@euphon.net>
To: Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>, 
 qemu-devel@nongnu.org
Date: Wed, 14 Oct 2020 13:34:36 +0100
In-Reply-To: <20201014115253.25276-1-philmd@redhat.com>
References: <20201014115253.25276-1-philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-ZohoCNMailClient: External
Received-SPF: pass client-ip=163.53.93.243; envelope-from=fam@euphon.net;
 helo=sender2-op-o12.zoho.com.cn
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/14 08:23:49
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Cc: Kevin Wolf <kwolf@redhat.com>, Alex Williamson <alex.williamson@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, qemu-block@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 2020-10-14 at 13:52 +0200, Philippe Mathieu-Daud=C3=A9 wrote:
> A bunch of boring patches that have been proven helpful
> while debugging.
>=20
> Philippe Mathieu-Daud=C3=A9 (9):
>   util/vfio-helpers: Improve reporting unsupported IOMMU type
>   util/vfio-helpers: Trace PCI I/O config accesses
>   util/vfio-helpers: Trace PCI BAR region info
>   util/vfio-helpers: Trace where BARs are mapped
>   util/vfio-helpers: Improve DMA trace events
>   util/vfio-helpers: Convert vfio_dump_mapping to trace events
>   util/vfio-helpers: Let qemu_vfio_dma_map() propagate Error
>   util/vfio-helpers: Let qemu_vfio_do_mapping() propagate Error
>   util/vfio-helpers: Let qemu_vfio_verify_mappings() use
> error_report()
>=20
>  include/qemu/vfio-helpers.h |  2 +-
>  block/nvme.c                | 14 ++++----
>  util/vfio-helpers.c         | 66 +++++++++++++++++++++------------
> ----
>  util/trace-events           | 10 ++++--
>  4 files changed, 54 insertions(+), 38 deletions(-)
>=20
> --=20
> 2.26.2
>=20
>=20
>=20

Modular the g_strdup_printf() memleak I pointed out:

Reviewed-by: Fam Zheng <fam@euphon.net>


