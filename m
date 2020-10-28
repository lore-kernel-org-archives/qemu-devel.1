Return-Path: <SRS0=Un+l=ED=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87AC9C388F7
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 14:33:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BFE9B2479C
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 14:33:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Wp6xBnwo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFE9B2479C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36378 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXmW1-0007nR-Gk
	for qemu-devel@archiver.kernel.org; Wed, 28 Oct 2020 10:33:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32808)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1kXmTX-0006Qy-Os
 for qemu-devel@nongnu.org; Wed, 28 Oct 2020 10:30:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:42998)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1kXmTW-00004w-8K
 for qemu-devel@nongnu.org; Wed, 28 Oct 2020 10:30:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603895451;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jFLImShH5iPiQEn2VgdaRkaiuAOx5qTZef3TG6et7So=;
 b=Wp6xBnwoLI8FHNSUBww+EUcbfe6PiTFhVuOEuQyPXDSxH3SpB6LXnVg5iGTsihac2BffAM
 aVmmnARilRPtj+Vgduagegx94jREE7Vc4pLU/cqX8PIo4IqpDAm7fLZeuN/K/4lJdCtb3i
 DRK5eXENsIkS02AlSw0f2ZLHpfPtf0I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-109-fpO8at3IPAefVWqOzQEKYw-1; Wed, 28 Oct 2020 10:30:44 -0400
X-MC-Unique: fpO8at3IPAefVWqOzQEKYw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 663DB195CC40;
 Wed, 28 Oct 2020 14:30:43 +0000 (UTC)
Received: from [10.36.112.194] (ovpn-112-194.ams2.redhat.com [10.36.112.194])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 919105DA33;
 Wed, 28 Oct 2020 14:30:33 +0000 (UTC)
Subject: Re: [PATCH 18/25] block/nvme: Pass AioContext argument to
 nvme_add_io_queue()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20201027135547.374946-1-philmd@redhat.com>
 <20201027135547.374946-19-philmd@redhat.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <4afb898f-c179-58f0-04f7-72ca5c4ae78c@redhat.com>
Date: Wed, 28 Oct 2020 15:30:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20201027135547.374946-19-philmd@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=eric.auger@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/28 01:50:00
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.921, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
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
 Keith Busch <kbusch@kernel.org>, Stefan Hajnoczi <stefanha@redhat.com>,
 Klaus Jensen <its@irrelevant.dk>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Philippe,

On 10/27/20 2:55 PM, Philippe Mathieu-Daudé wrote:
> We want to get ride of the BlockDriverState pointer at some point,
s/ride/rid
> so pass aio_context along.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> ---
>  block/nvme.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/block/nvme.c b/block/nvme.c
> index 68f0c3f7959..a0871fc2a81 100644
> --- a/block/nvme.c
> +++ b/block/nvme.c
> @@ -644,7 +644,9 @@ static void nvme_handle_event(EventNotifier *n)
>      nvme_poll_queues(s);
>  }
>  
> -static bool nvme_add_io_queue(BlockDriverState *bs, Error **errp)
> +/* Returns true on success, false on failure. */
belongs to another patch, still not a big fan of bool ;-)
> +static bool nvme_add_io_queue(BlockDriverState *bs,
> +                              AioContext *aio_context, Error **errp)
>  {
>      BDRVNVMeState *s = bs->opaque;
>      unsigned n = s->queue_count;
> @@ -653,8 +655,7 @@ static bool nvme_add_io_queue(BlockDriverState *bs, Error **errp)
>      unsigned queue_size = NVME_QUEUE_SIZE;
>  
>      assert(n <= UINT16_MAX);
> -    q = nvme_create_queue_pair(s, bdrv_get_aio_context(bs),
> -                               n, queue_size, errp);
> +    q = nvme_create_queue_pair(s, aio_context, n, queue_size, errp);
>      if (!q) {
>          return false;
>      }
> @@ -830,7 +831,7 @@ static int nvme_init(BlockDriverState *bs, const char *device, int namespace,
>      }
>  
>      /* Set up command queues. */
> -    if (!nvme_add_io_queue(bs, errp)) {
> +    if (!nvme_add_io_queue(bs, aio_context, errp)) {
>          ret = -EIO;
>      }
>  out:
> 
Besides
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Eric


