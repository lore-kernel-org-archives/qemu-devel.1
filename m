Return-Path: <SRS0=hH57=EK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EDD7C2D0A3
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 09:45:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 69AB820679
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 09:45:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RJw5re1U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69AB820679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48054 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaFMb-0005MF-DH
	for qemu-devel@archiver.kernel.org; Wed, 04 Nov 2020 04:45:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58848)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kaFLg-0004nA-Ot
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 04:45:00 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:60874)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kaFLe-00058p-AV
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 04:44:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604483096;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MVO6HETyN8zB+DLIGp4qDXzbcCF5s16mNoT16D/pboQ=;
 b=RJw5re1Uph4kTdhGiYTE0ViRJF5Iqn7yqD/YeiUH9Be0d7ubSSjN4vHuwQz+xw5sWKM0PW
 qIvo/9kie/mMt8NwHAMOr3ErFADvRUcIyo/IfGCHg9Vg7+gSdovT+8haRtzagoABOe+M2o
 9kGJElDLmVRRjbo2mQLBeZdSLSVesco=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-46-mZQGDbAbNtqL4gAQPlU1SQ-1; Wed, 04 Nov 2020 04:44:54 -0500
X-MC-Unique: mZQGDbAbNtqL4gAQPlU1SQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 12E94803F4D;
 Wed,  4 Nov 2020 09:44:53 +0000 (UTC)
Received: from dresden.str.redhat.com (unknown [10.40.194.145])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7C04F60C84;
 Wed,  4 Nov 2020 09:44:51 +0000 (UTC)
Subject: Re: [PULL 12/30] hw/block/nvme: add support for scatter gather lists
To: Klaus Jensen <its@irrelevant.dk>, peter.maydell@linaro.org,
 qemu-devel@nongnu.org
References: <20201027104932.558087-1-its@irrelevant.dk>
 <20201027104932.558087-13-its@irrelevant.dk>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <7a66a049-4635-0803-7709-c1e169960c2f@redhat.com>
Date: Wed, 4 Nov 2020 10:44:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201027104932.558087-13-its@irrelevant.dk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mreitz@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=mreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/03 22:09:52
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
Cc: Keith Busch <kbusch@kernel.org>, Klaus Jensen <k.jensen@samsung.com>,
 qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 27.10.20 11:49, Klaus Jensen wrote:
> From: Klaus Jensen <k.jensen@samsung.com>
> 
> For now, support the Data Block, Segment and Last Segment descriptor
> types.
> 
> See NVM Express 1.3d, Section 4.4 ("Scatter Gather List (SGL)").
> 
> Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
> Reviewed-by: Keith Busch <kbusch@kernel.org>
> ---
>  include/block/nvme.h  |   6 +-
>  hw/block/nvme.c       | 329 ++++++++++++++++++++++++++++++++++--------
>  hw/block/trace-events |   4 +
>  3 files changed, 279 insertions(+), 60 deletions(-)

[...]

> diff --git a/hw/block/nvme.c b/hw/block/nvme.c
> index c0f1f8ccd473..63d0a17bc5f0 100644
> --- a/hw/block/nvme.c
> +++ b/hw/block/nvme.c
> @@ -413,13 +413,262 @@ static uint16_t nvme_map_prp(NvmeCtrl *n, uint64_t prp1, uint64_t prp2,

[...]

> +        if (*len == 0) {
> +            /*
> +             * All data has been mapped, but the SGL contains additional
> +             * segments and/or descriptors. The controller might accept
> +             * ignoring the rest of the SGL.
> +             */
> +            uint16_t sgls = le16_to_cpu(n->id_ctrl.sgls);
> +            if (sgls & NVME_CTRL_SGLS_EXCESS_LENGTH) {

Hi,

Coverity reports that this condition is always false because
NVME_CTRL_SGLS_EXCESS_LENGTH is (1 << 18) and thus won’t fit in a uint16_t.

I think the problem is that n->id_ctrl.sgls is a uint32_t, so sgls
should be uint32_t and we should use le32_to_cpu().  (Which technically
is a second problem, namely to access a 32 bit LE field as a 16 bit
field.  That will give wrong results on big endian hosts.)

Max


