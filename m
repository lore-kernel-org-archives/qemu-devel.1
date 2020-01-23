Return-Path: <SRS0=mO9Z=3M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABE79C2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 19:29:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5BCBB21D7E
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 19:29:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HlKweBAt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BCBB21D7E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35766 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuiAr-0003Pl-UU
	for qemu-devel@archiver.kernel.org; Thu, 23 Jan 2020 14:29:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60229)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iugYs-0001B1-BL
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 12:46:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iugYr-0001kW-2p
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 12:46:34 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:34507
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iugYq-0001jt-Tv
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 12:46:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579801592;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Txe1hVSZM6rRfrzRJ0bDbAftCeHHtCU8jnW8nDv//uM=;
 b=HlKweBAtvItlCFiGBslHkjz6PqTAI0oODSWXVCtY/tVAdo5DhBmuEqgL3D/iKA+QtW/EB5
 8qoiTjJkWKMdBFkVpp2y2vZ8CRdpbt+T3kpDmr2r0ouWOBKhb5hOzWciOat8v6Sa/sECgw
 8whLkN6IZl9yIj4G9p7Nad16nbZPn9c=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-193-R3nB6urVNGKX6kHe5vLvmw-1; Thu, 23 Jan 2020 12:46:29 -0500
Received: by mail-wr1-f72.google.com with SMTP id f17so2227710wrt.19
 for <qemu-devel@nongnu.org>; Thu, 23 Jan 2020 09:46:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Txe1hVSZM6rRfrzRJ0bDbAftCeHHtCU8jnW8nDv//uM=;
 b=CQiTF8P9gOK0KEHISCuQ2YomAk6snDr2zsQdvzJ8t6hup8BgVOOAg1kDv79nDQUDfw
 KkIHtNnm0azTTeQkrc5h/B3Hpp/m5zCZ29UsMaEp6Qd/+i5JVdl/5HNdesObEEBdgIg0
 3hJTfEmG7bhQ7W4EcLTe9WoCAiv1wtFj6dScc3HMxL6p4ZK1VfN9skt0DVMpZTiQqAP4
 jryYA8wNHoTzzRddINWsbcO8QCMDVZvW7+QqndqA9qLAFyUGvfaByQ0h23lkEiu2AUGK
 Refx8Nqa/MzfxkblRKKf0a3oWPTcK+gWQat6cAdMY3yyHgm6KxPgg6amOCjXh0RKAMlo
 Vn5g==
X-Gm-Message-State: APjAAAU+fHjJZVB39r0gTopZDpXA8MiJ+ioA2w8Wxu8C+gCYcAQoQmc+
 g9PcTE7v7qEKgDGiLcAfxijU7WWFOO0hzyJKI4Rq8T2V0jvoXj9m5+WoKjUgyYBgkB+vygjjUtS
 9ixIoskq2HMwpJEk=
X-Received: by 2002:a7b:cf2d:: with SMTP id m13mr5503974wmg.163.1579801587965; 
 Thu, 23 Jan 2020 09:46:27 -0800 (PST)
X-Google-Smtp-Source: APXvYqzZ5GjUBeXghFIr2RwszBtxh90LN3+b16dXFgziG3y+vAFF8jm2YEu0npYG5fBOXVF2bGw77A==
X-Received: by 2002:a7b:cf2d:: with SMTP id m13mr5503951wmg.163.1579801587740; 
 Thu, 23 Jan 2020 09:46:27 -0800 (PST)
Received: from [192.168.1.35] (113.red-83-57-172.dynamicip.rima-tde.net.
 [83.57.172.113])
 by smtp.gmail.com with ESMTPSA id x132sm10120601wmg.0.2020.01.23.09.46.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 23 Jan 2020 09:46:27 -0800 (PST)
Subject: Re: [PATCH] iscsi: Cap block count from GET LBA STATUS (CVE-2020-1711)
To: Felipe Franciosi <felipe@nutanix.com>,
 Ronnie Sahlberg <ronniesahlberg@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Lieven <pl@kamp.de>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-stable@nongnu.org" <qemu-stable@nongnu.org>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>
References: <20200123124357.124019-1-felipe@nutanix.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <3cb32404-e8ee-ba8c-3684-bfa6d0827d39@redhat.com>
Date: Thu, 23 Jan 2020 18:46:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200123124357.124019-1-felipe@nutanix.com>
Content-Language: en-US
X-MC-Unique: R3nB6urVNGKX6kHe5vLvmw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 207.211.31.120
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Turschmid <peter.turschm@nutanix.com>,
 Max Reitz <mreitz@redhat.com>, Raphael Norwitz <raphael.norwitz@nutanix.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 P J P <ppandit@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/23/20 1:44 PM, Felipe Franciosi wrote:
> When querying an iSCSI server for the provisioning status of blocks (via
> GET LBA STATUS), Qemu only validates that the response descriptor zero's
> LBA matches the one requested. Given the SCSI spec allows servers to
> respond with the status of blocks beyond the end of the LUN, Qemu may
> have its heap corrupted by clearing/setting too many bits at the end of
> its allocmap for the LUN.
> 
> A malicious guest in control of the iSCSI server could carefully program
> Qemu's heap (by selectively setting the bitmap) and then smash it.
> 
> This limits the number of bits that iscsi_co_block_status() will try to
> update in the allocmap so it can't overflow the bitmap.
> 

Please add:

Fixes: CVE-2020-1711 (title of CVE if possible)
Cc: qemu-stable@nongnu.org

> Signed-off-by: Felipe Franciosi <felipe@nutanix.com>
> Signed-off-by: Peter Turschmid <peter.turschm@nutanix.com>
> Signed-off-by: Raphael Norwitz <raphael.norwitz@nutanix.com>
> ---
>   block/iscsi.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/block/iscsi.c b/block/iscsi.c
> index 2aea7e3f13..cbd57294ab 100644
> --- a/block/iscsi.c
> +++ b/block/iscsi.c
> @@ -701,7 +701,7 @@ static int coroutine_fn iscsi_co_block_status(BlockDriverState *bs,
>       struct scsi_get_lba_status *lbas = NULL;
>       struct scsi_lba_status_descriptor *lbasd = NULL;
>       struct IscsiTask iTask;
> -    uint64_t lba;
> +    uint64_t lba, max_bytes;
>       int ret;
>   
>       iscsi_co_init_iscsitask(iscsilun, &iTask);
> @@ -721,6 +721,7 @@ static int coroutine_fn iscsi_co_block_status(BlockDriverState *bs,
>       }
>   
>       lba = offset / iscsilun->block_size;
> +    max_bytes = (iscsilun->num_blocks - lba) * iscsilun->block_size;
>   
>       qemu_mutex_lock(&iscsilun->mutex);
>   retry:
> @@ -764,7 +765,7 @@ retry:
>           goto out_unlock;
>       }
>   
> -    *pnum = (int64_t) lbasd->num_blocks * iscsilun->block_size;
> +    *pnum = MIN((int64_t) lbasd->num_blocks * iscsilun->block_size, max_bytes);
>   
>       if (lbasd->provisioning == SCSI_PROVISIONING_TYPE_DEALLOCATED ||
>           lbasd->provisioning == SCSI_PROVISIONING_TYPE_ANCHORED) {
> 

What about this?

-- >8 --
diff --git a/block/iscsi.c b/block/iscsi.c
index 2aea7e3f13..25598accbb 100644
--- a/block/iscsi.c
+++ b/block/iscsi.c
@@ -506,6 +506,11 @@ iscsi_allocmap_update(IscsiLun *iscsilun, int64_t 
offset,
      /* shrink to touch only completely contained clusters */
      cl_num_shrunk = DIV_ROUND_UP(offset, iscsilun->cluster_size);
      nb_cls_shrunk = (offset + bytes) / iscsilun->cluster_size - 
cl_num_shrunk;
+    if (nb_cls_expanded >= iscsilun->allocmap_size
+        || nb_cls_shrunk >= iscsilun->allocmap_size) {
+        error_report("iSCSI invalid request: ..." /* TODO */);
+        return;
+    }
      if (allocated) {
          bitmap_set(iscsilun->allocmap, cl_num_expanded, nb_cls_expanded);
      } else {
---


