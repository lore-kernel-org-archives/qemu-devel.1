Return-Path: <SRS0=IkQf=EJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA2EFC2D0A3
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 10:53:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0893222384
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 10:53:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=euphon.net header.i=fam@euphon.net header.b="DeYZ6Wel"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0893222384
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=euphon.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40228 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZtwn-00037Z-Ql
	for qemu-devel@archiver.kernel.org; Tue, 03 Nov 2020 05:53:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55680)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fam@euphon.net>) id 1kZtvl-0002dW-AC
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 05:52:49 -0500
Received: from sender3-of-o52.zoho.com.cn ([124.251.121.247]:21580)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fam@euphon.net>) id 1kZtvg-0002Jn-Sf
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 05:52:48 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1604400733; cv=none; d=zoho.com.cn; s=zohoarc; 
 b=CwiV5JRXkWZ9fJw2XhKWf1xNuGRoNXJNZ7KXPx8r0xh1dOHq/f/rk4r3sIYZJ8hfV+TcwcfYuIOHGDAkvENupr5TP/781vd2S6D4wh+K61I6Mr3CYxs9xl3DYHAjzVJ1cmuOsFzWJo0kYFV06+ptyEKwm76YQcF+sfjZsMYV0ac=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com.cn;
 s=zohoarc; t=1604400733;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To;
 bh=xhFPRveOBGWizfcyIWU133fo/j0PLFHqS5JsATCo2gA=; 
 b=H1pX8F5LzyHlTZxduYgPBBhQmzurCvKn34qxDqJ7WeU9BJXpbfvICPa0AKYDCTA9C4QdGQlnkoE90v6WtKgIgkgizcM3+IIOfs34QG9EGW0ZqWggohiYwu+K7dSKfppmjXJ63dPFIav9Cn6A4xLyVSRiA9dZDTnBGZ2hFHvmqcA=
ARC-Authentication-Results: i=1; mx.zoho.com.cn;
 dkim=pass  header.i=euphon.net;
 spf=pass  smtp.mailfrom=fam@euphon.net;
 dmarc=pass header.from=<fam@euphon.net> header.from=<fam@euphon.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1604400733; 
 s=zoho; d=euphon.net; i=fam@euphon.net;
 h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:Content-Type:Mime-Version:Content-Transfer-Encoding;
 bh=xhFPRveOBGWizfcyIWU133fo/j0PLFHqS5JsATCo2gA=;
 b=DeYZ6WelkKSy+U4ck/qE3Ip1jganrimMPMX2IpwKDATMtVrtxbiUhlixeplnO843
 WCi83zP7O4zCy9lPsC+UdJ0Sjx5t/ASyaf5vjoxU64/MU3w9lh9SU34OuEQQ7kEgOV2
 qot9/d9tPKbExSyM9VsUwA2E4eXF1aGTD/Axb7Ms=
Received: from u60bdefc337955a.ant.amazon.com (54-240-197-231.amazon.com
 [54.240.197.231]) by mx.zoho.com.cn
 with SMTPS id 1604400730780542.4351567619085;
 Tue, 3 Nov 2020 18:52:10 +0800 (CST)
Message-ID: <33fd8330630defb91feb6c627800a3ca952a4b55.camel@euphon.net>
Subject: Re: [PATCH] scsi: allow user to set werror as report
From: Fam Zheng <fam@euphon.net>
To: Zihao Chang <changzihao1@huawei.com>, pbonzini@redhat.com
Date: Tue, 03 Nov 2020 10:52:05 +0000
In-Reply-To: <20201103061240.1364-1-changzihao1@huawei.com>
References: <20201103061240.1364-1-changzihao1@huawei.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-ZohoCNMailClient: External
Received-SPF: pass client-ip=124.251.121.247; envelope-from=fam@euphon.net;
 helo=sender3-of-o52.zoho.com.cn
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/03 05:52:28
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
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
Cc: qemu-devel@nongnu.org, xiexiangyou@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 2020-11-03 at 14:12 +0800, Zihao Chang wrote:
> 'enospc' is the default for -drive, but qemu allows user to set
> drive option werror. If werror of scsi-generic is set to 'report'
> by user, qemu will not allow vm to start.
> 
> This patch allow user to set werror as 'report' for scsi-generic.
> 
> Signed-off-by: Zihao Chang <changzihao1@huawei.com>
> ---
>  hw/scsi/scsi-generic.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/scsi/scsi-generic.c b/hw/scsi/scsi-generic.c
> index 2cb23ca891..2730e37d63 100644
> --- a/hw/scsi/scsi-generic.c
> +++ b/hw/scsi/scsi-generic.c
> @@ -664,7 +664,8 @@ static void scsi_generic_realize(SCSIDevice *s,
> Error **errp)
>          return;
>      }
>  
> -    if (blk_get_on_error(s->conf.blk, 0) !=
> BLOCKDEV_ON_ERROR_ENOSPC) {
> +    if (blk_get_on_error(s->conf.blk, 0) != BLOCKDEV_ON_ERROR_ENOSPC
> &&
> +        blk_get_on_error(s->conf.blk, 0) !=
> BLOCKDEV_ON_ERROR_REPORT) {
>          error_setg(errp, "Device doesn't support drive option
> werror");
>          return;
>      }

Accepting the report sounds sane to me, it matches what we actually
(always) do. Is the idea to allow users to spell it out explicitly in
the command line?

Reviewed-by: Fam Zheng <fam@euphon.net>


