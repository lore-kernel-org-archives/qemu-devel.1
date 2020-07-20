Return-Path: <SRS0=C20x=A7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52DBDC433E2
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2020 14:08:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1BCCB20B1F
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2020 14:08:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U114pxt2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1BCCB20B1F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56256 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jxWSv-0004Hs-Bk
	for qemu-devel@archiver.kernel.org; Mon, 20 Jul 2020 10:08:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53882)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jxWS7-0003oe-Cx
 for qemu-devel@nongnu.org; Mon, 20 Jul 2020 10:07:35 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:45488
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jxWS5-0001Yy-8X
 for qemu-devel@nongnu.org; Mon, 20 Jul 2020 10:07:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595254052;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/rgRWdP8p0yrJjFVMsOv4VUvtYtUlNVHLBPz0j7Rwho=;
 b=U114pxt20O4bbDq7JLjqUEnGFu4Z/Cx7CSA0o9ibry/J2gLwBPjV8gd0uI+Qxdf/hWWCQf
 wiZtepP+2XVBmrmaczxmphdR518w9H3fS57NttrAYFlWdpNHFFpA4cx8jDCWs1hEG7ciYA
 5eVPMvWgJc8Kwc3CPJGKJOff7yriAPc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-343-P7O9b7CbME-BWhp7EFbebA-1; Mon, 20 Jul 2020 10:07:30 -0400
X-MC-Unique: P7O9b7CbME-BWhp7EFbebA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3F93E106B242;
 Mon, 20 Jul 2020 14:07:29 +0000 (UTC)
Received: from linux.fritz.box (ovpn-114-59.ams2.redhat.com [10.36.114.59])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4BBFA19C71;
 Mon, 20 Jul 2020 14:07:28 +0000 (UTC)
Date: Mon, 20 Jul 2020 16:07:26 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: antoine.damhet@blade-group.com
Subject: Re: [PATCH RESEND] file-posix: Handle `EINVAL` fallocate return value
Message-ID: <20200720140726.GD5541@linux.fritz.box>
References: <20200717135603.51180-1-antoine.damhet@blade-group.com>
MIME-Version: 1.0
In-Reply-To: <20200717135603.51180-1-antoine.damhet@blade-group.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=kwolf@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/20 03:17:01
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: qemu-devel@nongnu.org, "open list:raw" <qemu-block@nongnu.org>,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 17.07.2020 um 15:56 hat antoine.damhet@blade-group.com geschrieben:
> From: Antoine Damhet <antoine.damhet@blade-group.com>
> 
> The `detect-zeroes=unmap` option may issue unaligned
> `FALLOC_FL_PUNCH_HOLE` requests, raw block devices can (and will) return
> `EINVAL`, qemu should then write the zeroes to the blockdev instead of
> issuing an `IO_ERROR`.
> 
> Signed-off-by: Antoine Damhet <antoine.damhet@blade-group.com>

Do you have a simple reproducer for this? I tried it with something like
this (also with a LV instead of loop, but it didn't really make a
difference):

$ ./qemu-io -c 'write -P 0 42 1234' --image-opts driver=host_device,filename=/dev/loop0,cache.direct=on,detect-zeroes=on
wrote 1234/1234 bytes at offset 42
1.205 KiB, 1 ops; 00.00 sec (2.021 MiB/sec and 1717.5697 ops/sec)

So I don't seem to run into an error.

> diff --git a/block/file-posix.c b/block/file-posix.c
> index 8067e238cb..b2fabcc1b8 100644
> --- a/block/file-posix.c
> +++ b/block/file-posix.c
> @@ -1620,7 +1620,11 @@ static int handle_aiocb_write_zeroes_unmap(void *opaque)
>  #ifdef CONFIG_FALLOCATE_PUNCH_HOLE
>      int ret = do_fallocate(s->fd, FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE,
>                             aiocb->aio_offset, aiocb->aio_nbytes);
> -    if (ret != -ENOTSUP) {
> +    switch (ret) {
> +    case -ENOTSUP:
> +    case -EINVAL:
> +        break;
> +    default:
>          return ret;
>      }
>  #endif

This means that we fall back to BLKZEROOUT in case of -EINVAL. Does this
return a better error code in the relevant cases, or did you just happen
to test a case where it was skipped or returned -ENOTSUP?

Kevin


