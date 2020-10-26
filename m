Return-Path: <SRS0=ZyMj=EB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52B46C4363A
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 18:20:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E0012087C
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 18:20:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZUI5waUz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E0012087C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58848 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kX76E-0005uK-Mz
	for qemu-devel@archiver.kernel.org; Mon, 26 Oct 2020 14:20:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54844)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1kX6SV-0000eN-MC
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 13:39:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:40405)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1kX6SU-0002f9-7s
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 13:39:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603733941;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6XA1d3EJeySRjLo/5RWZERIOSiiASqjMOYpyytb8M+w=;
 b=ZUI5waUzhfybTf8p9dxi/j/KZl4cYAD/Gv9gC01BCo+pf0x4jAXvcBqPd5c5Is16Ne6iMx
 +JHfplU0Hz0Ghn6fQYG3LqFyJZjj0uNjj+wwroUqsd2qr4NNZSen3BuheI54fr6JMVP6WN
 pU6Ig3NcL5EWDtqtBmTyiNrCvihk/3k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-587-LpBRGf9xPrSreDJBxrSQ4A-1; Mon, 26 Oct 2020 13:38:57 -0400
X-MC-Unique: LpBRGf9xPrSreDJBxrSQ4A-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 837EF18B9F58;
 Mon, 26 Oct 2020 17:38:56 +0000 (UTC)
Received: from [10.36.112.194] (ovpn-112-194.ams2.redhat.com [10.36.112.194])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B375062A14;
 Mon, 26 Oct 2020 17:38:48 +0000 (UTC)
Subject: Re: [PATCH v2 02/19] block/nvme: Set request_alignment at
 initialization
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20201026105504.4023620-1-philmd@redhat.com>
 <20201026105504.4023620-3-philmd@redhat.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <ef3d9a12-646a-5cec-7673-8693bc83ac0c@redhat.com>
Date: Mon, 26 Oct 2020 18:38:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20201026105504.4023620-3-philmd@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=eric.auger@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/26 02:39:09
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-2.167, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,

On 10/26/20 11:54 AM, Philippe Mathieu-Daudé wrote:
> When introducing this driver in commit bdd6a90a9e5
> ("block: Add VFIO based NVMe driver") we correctly
> set the request_alignment in nvme_refresh_limits()
> but forgot to set it at initialization. Do it now.
> 
> Reported-by: Stefan Hajnoczi <stefanha@redhat.com>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Thanks

Eric

> ---
>  block/nvme.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/block/nvme.c b/block/nvme.c
> index 029694975b9..aa290996679 100644
> --- a/block/nvme.c
> +++ b/block/nvme.c
> @@ -727,6 +727,7 @@ static int nvme_init(BlockDriverState *bs, const char *device, int namespace,
>      s->page_size = MAX(4096, 1u << (12 + NVME_CAP_MPSMIN(cap)));
>      s->doorbell_scale = (4 << NVME_CAP_DSTRD(cap)) / sizeof(uint32_t);
>      bs->bl.opt_mem_alignment = s->page_size;
> +    bs->bl.request_alignment = s->page_size;
>      timeout_ms = MIN(500 * NVME_CAP_TO(cap), 30000);
>  
>      /* Reset device to get a clean state. */
> 


