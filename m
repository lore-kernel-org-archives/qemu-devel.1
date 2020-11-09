Return-Path: <SRS0=6joO=EP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B343FC2D0A3
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 15:18:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F0BB1206E3
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 15:18:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cQIn89UT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0BB1206E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59248 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kc8vo-00025R-1I
	for qemu-devel@archiver.kernel.org; Mon, 09 Nov 2020 10:18:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56408)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kc8uh-0001Z9-E8
 for qemu-devel@nongnu.org; Mon, 09 Nov 2020 10:16:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:47285)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kc8ue-0000ey-SF
 for qemu-devel@nongnu.org; Mon, 09 Nov 2020 10:16:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604935014;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jR5O/gZB07RA/1S9b2WhdxbSdbASFFPSc07lG3vFTzY=;
 b=cQIn89UTPPRAX8KoeEicM3Qx4aXkjS+KbcIvMrRvtrY47Tbbum74U27lZK7Cv72ur2/AeN
 bFeSwGsD3ZAHo2yOhqnlocVVOTK1zT4WTIY9xv5IrNv2HZxKC2TObb75RTf9pmbJZJqd3m
 Fkwqot/iqYpFedEYHnd0TIyQE3LC8/w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-100-t_FRBAjZNJmuz1RpdsrWFw-1; Mon, 09 Nov 2020 10:16:52 -0500
X-MC-Unique: t_FRBAjZNJmuz1RpdsrWFw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B2D141074653;
 Mon,  9 Nov 2020 15:16:51 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-113-179.ams2.redhat.com
 [10.36.113.179])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3B70F50B44;
 Mon,  9 Nov 2020 15:16:46 +0000 (UTC)
Subject: Re: [PATCH for-5.2] block/export/vhost-user-blk-server.c: Avoid
 potential integer overflow
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
References: <20201109150522.10350-1-peter.maydell@linaro.org>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <4c65f0d3-3769-b659-985f-f0cc5263a41e@redhat.com>
Date: Mon, 9 Nov 2020 16:16:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201109150522.10350-1-peter.maydell@linaro.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mreitz@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=mreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/09 01:25:23
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
Cc: Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Coiby Xu <Coiby.Xu@gmail.com>, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

[Cc-ing Stefan]

On 09.11.20 16:05, Peter Maydell wrote:
> In vu_blk_discard_write_zeroes(), we read a 32-bit sector count from
> the descriptor and convert it to a 64-bit byte count. Coverity warns
> that the left shift is done with 32-bit arithmetic so it might
> overflow before the conversion to 64-bit happens. Add a cast to
> avoid this.

This will silence Coverity, but both functions to which range[1] is then 
passed (blk_co_pdiscard() and blk_co_pwrite_zeroes()) only accept ints 
there, so this would only move the overflow to the function call.

Shouldn’t we verify that the number of sectors is in range and return an 
error if it isn’t?  (The same probably goes for the starting sector, 
then, too.)

Max

> Fixes: Coverity CID 1435956
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> Tested with 'make check' and 'make check-acceptance' only.
> ---
>   block/export/vhost-user-blk-server.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/block/export/vhost-user-blk-server.c b/block/export/vhost-user-blk-server.c
> index 62672d1cb95..e5749451e65 100644
> --- a/block/export/vhost-user-blk-server.c
> +++ b/block/export/vhost-user-blk-server.c
> @@ -70,7 +70,7 @@ vu_blk_discard_write_zeroes(BlockBackend *blk, struct iovec *iov,
>       }
>   
>       uint64_t range[2] = { le64_to_cpu(desc.sector) << 9,
> -                          le32_to_cpu(desc.num_sectors) << 9 };
> +                          (uint64_t)le32_to_cpu(desc.num_sectors) << 9 };
>       if (type == VIRTIO_BLK_T_DISCARD) {
>           if (blk_co_pdiscard(blk, range[0], range[1]) == 0) {
>               return 0;
> 


