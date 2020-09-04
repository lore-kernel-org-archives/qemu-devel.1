Return-Path: <SRS0=8bV5=CN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0B26C433E2
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 15:28:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A3A792074D
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 15:28:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=euphon.net header.i=fam@euphon.net header.b="fQoQn+Va"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3A792074D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=euphon.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45860 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kEDdJ-0005yQ-OC
	for qemu-devel@archiver.kernel.org; Fri, 04 Sep 2020 11:28:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42162)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fam@euphon.net>)
 id 1kEDBT-0007nF-6Z; Fri, 04 Sep 2020 10:59:23 -0400
Received: from sender2-op-o12.zoho.com.cn ([163.53.93.243]:17624)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fam@euphon.net>)
 id 1kEDBM-0007Ql-VK; Fri, 04 Sep 2020 10:59:22 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1599231488; cv=none; d=zoho.com.cn; s=zohoarc; 
 b=nmO8f7UA5CvomRG9HoHiMTkJXHPfAnL+nVpU4k8OpjLNQNTa1JN8dN80c2TyMe/FLl5Y8Y43gKYNfcT35srWI1TW53+NWNdCz9x/VoeQXrT1JY7AJq28q+L4D7XpEZkCEveUWrCbjM88UHf40u0El52J5FhOUaCOSHiQLlx+h2I=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com.cn;
 s=zohoarc; t=1599231488;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To;
 bh=PhDfXRkCeGlPv/Ht8rlUSc0qy49TKLiY4ktJqOc9h0s=; 
 b=HKP07L/HVJbWhYVSk32wG/5Jr9eEfYUu9Hd3tA9vYCsJFxwajBE8PYplvlwj4gyTjGL6DKik8Tfoyvt2OU1nTtboyHxSYnzQcyFjb2vyzmsyGvAKzGZd5bS/0p7mgUMopO3bDcs2ET0VWxF7DnxN6anGDBRWmdaLMw7TbN0wWPc=
ARC-Authentication-Results: i=1; mx.zoho.com.cn;
 dkim=pass  header.i=euphon.net;
 spf=pass  smtp.mailfrom=fam@euphon.net;
 dmarc=pass header.from=<fam@euphon.net> header.from=<fam@euphon.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1599231488; 
 s=zoho; d=euphon.net; i=fam@euphon.net;
 h=Date:From:To:Cc:Message-ID:Subject:References:MIME-Version:Content-Type:Content-Transfer-Encoding:In-Reply-To;
 bh=PhDfXRkCeGlPv/Ht8rlUSc0qy49TKLiY4ktJqOc9h0s=;
 b=fQoQn+VaAvhgC90bPsYXt15QtRsAcz7G85bBuQPfXzxxFR99hdsF12VYoFf93d+e
 CHD1uJESwEHpBXw4dU0zWd6wJ1uRocGd6L+9AeEfvm7l35JhqedsLZGrPD45twhfSS/
 Hatj6RWMcbN4yvw7Wg0bszL6tdu8xxe3tN7h8+LU=
Received: from localhost (ec2-52-56-101-76.eu-west-2.compute.amazonaws.com
 [52.56.101.76]) by mx.zoho.com.cn
 with SMTPS id 1599231485716490.9781603438166;
 Fri, 4 Sep 2020 22:58:05 +0800 (CST)
Date: Fri, 4 Sep 2020 14:57:57 +0000
From: Fam Zheng <fam@euphon.net>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Message-ID: <20200904145757.h6blvetg6rnw7xig@dev>
Subject: Re: [PATCH 0/3] block/nvme: Use NvmeBar structure from "block/nvme.h"
References: <20200904124130.583838-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200904124130.583838-1-philmd@redhat.com>
X-ZohoCNMailClient: External
Received-SPF: pass client-ip=163.53.93.243; envelope-from=fam@euphon.net;
 helo=sender2-op-o12.zoho.com.cn
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/04 10:58:55
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 04 Sep 2020 11:27:15 -0400
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>, Klaus Jensen <its@irrelevant.dk>,
 Stefan Hajnoczi <stefanha@redhat.com>, Keith Busch <kbusch@kernel.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2020-09-04 14:41, Philippe Mathieu-Daud=E9 wrote:
> Cleanups in the NVMeRegs structure:
> - Use the already existing NvmeBar structure from "block/nvme.h"
> - Pair doorbell registers
>=20
> Based-on: <20200903122803.405265-1-philmd@redhat.com>
>=20
> Philippe Mathieu-Daud=E9 (3):
>   block/nvme: Group controller registers in NVMeRegs structure
>   block/nvme: Use generic NvmeBar structure
>   block/nvme: Pair doorbell registers
>=20
>  block/nvme.c | 43 +++++++++++++++----------------------------
>  1 file changed, 15 insertions(+), 28 deletions(-)
>=20
> --=20
> 2.26.2
>=20
>=20

Reviewed-by: Fam Zheng <fam@euphon.net>


