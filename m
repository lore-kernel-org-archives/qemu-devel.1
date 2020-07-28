Return-Path: <SRS0=L+nc=BH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B36D7C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 14:29:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D65620663
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 14:29:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M6VgxXxC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D65620663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60016 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0Qbj-0000UW-MR
	for qemu-devel@archiver.kernel.org; Tue, 28 Jul 2020 10:29:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58776)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1k0Qal-0008Qk-Vh
 for qemu-devel@nongnu.org; Tue, 28 Jul 2020 10:28:32 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:54412
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1k0Qai-0001Fu-V4
 for qemu-devel@nongnu.org; Tue, 28 Jul 2020 10:28:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595946507;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1ghv4ONygeqEVIKEfG+zmjH84ZnLCOQ5FIntbcXfmXw=;
 b=M6VgxXxC0hTrhDxmGA1P2KowQIiGJB1XBxujseroCTHynCBGCC7wmPgqeJUcat2vrsyJoO
 LdqDfxrwBwTD9/jRaNXOlxSQ//fvrpYBrGKAfo088jl87U2pLbCy8j1tJ+wiJsh2YY2FLz
 er0ZMP+cMyoLLR9m41XEyF/oK9PlQmI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-357-VEm1xgdNO96eOExBlGEG2Q-1; Tue, 28 Jul 2020 10:28:23 -0400
X-MC-Unique: VEm1xgdNO96eOExBlGEG2Q-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3F0E4100A61E;
 Tue, 28 Jul 2020 14:28:22 +0000 (UTC)
Received: from [10.10.118.248] (ovpn-118-248.rdu2.redhat.com [10.10.118.248])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A4D091975F;
 Tue, 28 Jul 2020 14:28:15 +0000 (UTC)
Subject: Re: [PATCH v2 1/4] block: nbd: Fix convert qcow2 compressed to nbd
To: Nir Soffer <nirsof@gmail.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
References: <20200727215846.395443-1-nsoffer@redhat.com>
 <20200727215846.395443-2-nsoffer@redhat.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <42876df5-68a9-f450-8644-7d8967363ab0@redhat.com>
Date: Tue, 28 Jul 2020 09:28:10 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200727215846.395443-2-nsoffer@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=eblake@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/28 10:28:27
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: Kevin Wolf <kwolf@redhat.com>, Nir Soffer <nsoffer@redhat.com>,
 vsementsov@virtuozzo.com, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/27/20 4:58 PM, Nir Soffer wrote:
> When converting to qcow2 compressed format, the last step is a special
> zero length compressed write, ending in call to bdrv_co_truncate(). This

in a call

> call always fails for the nbd driver since it does not implement
> bdrv_co_truncate().
> 
> For block devices, which have the same limits, the call succeeds since
> file driver implements bdrv_co_truncate(). If the caller asked to

since the file

> truncate to the same or smaller size with exact=false, the truncate
> succeeds. Implement the same logic for nbd.
> 
> Example failing without this change:
> 
> In one shell starts qemu-nbd:

start

> 
> $ truncate -s 1g test.tar
> $ qemu-nbd --socket=/tmp/nbd.sock --persistent --format=raw --offset 1536 test.tar
> 
> In another shell convert an image to qcow2 compressed via NBD:
> 
> $ echo "disk data" > disk.raw
> $ truncate -s 1g disk.raw
> $ qemu-img convert -f raw -O qcow2 -c disk1.raw nbd+unix:///?socket=/tmp/nbd.sock; echo $?
> 1
> 
> qemu-img failed, but the conversion was successful:
> 
> $ qemu-img info nbd+unix:///?socket=/tmp/nbd.sock
> image: nbd+unix://?socket=/tmp/nbd.sock
> file format: qcow2
> virtual size: 1 GiB (1073741824 bytes)
> ...
> 
> $ qemu-img check nbd+unix:///?socket=/tmp/nbd.sock
> No errors were found on the image.
> 1/16384 = 0.01% allocated, 100.00% fragmented, 100.00% compressed clusters
> Image end offset: 393216
> 
> $ qemu-img compare disk.raw nbd+unix:///?socket=/tmp/nbd.sock
> Images are identical.
> 
> Fixes: https://bugzilla.redhat.com/1860627
> Signed-off-by: Nir Soffer <nsoffer@redhat.com>
> ---
>   block/nbd.c | 30 ++++++++++++++++++++++++++++++
>   1 file changed, 30 insertions(+)

Reviewed-by: Eric Blake <eblake@redhat.com>

> 
> diff --git a/block/nbd.c b/block/nbd.c
> index 65a4f56924..dcb0b03641 100644
> --- a/block/nbd.c
> +++ b/block/nbd.c
> @@ -1966,6 +1966,33 @@ static void nbd_close(BlockDriverState *bs)
>       nbd_clear_bdrvstate(s);
>   }
>   
> +/*
> + * NBD cannot truncate, but if the caller asks to truncate to the same size, or
> + * to a smaller size with exact=false, there is no reason to fail the
> + * operation.
> + *
> + * Preallocation mode is ignored since it does not seems useful to fail when
> + * when never change anything.

s/when when/when we/

I tested with a quick hack to qemu-io-cmds.c:

diff --git i/qemu-io-cmds.c w/qemu-io-cmds.c
index 851f07e8f8b9..baeae86d8c85 100644
--- i/qemu-io-cmds.c
+++ w/qemu-io-cmds.c
@@ -1715,7 +1715,7 @@ static int truncate_f(BlockBackend *blk, int argc, 
char **argv)
       * exact=true.  It is better to err on the "emit more errors" side
       * than to be overly permissive.
       */
-    ret = blk_truncate(blk, offset, true, PREALLOC_MODE_OFF, 0, 
&local_err);
+    ret = blk_truncate(blk, offset, false, PREALLOC_MODE_OFF, 0, 
&local_err);
      if (ret < 0) {
          error_report_err(local_err);
          return ret;

[We should _really_ improve that command to take options, so you can 
control whether to be exact and what prealloc mode on the fly rather 
than hard-coded, but that's a different patch for a later day]

and with that hack in place, I observed:
$ truncate --size=3m file
$ ./qemu-nbd -f raw file
$ ./qemu-io -f raw nbd://localhost:10809
qemu-io> length
3 MiB
qemu-io> truncate 2m
qemu-io> length
3 MiB
qemu-io> truncate 4m
qemu-io: Cannot grow NBD nodes
qemu-io> length
3 MiB

so my initial worry that qemu would see the shrunken size, and therefore 
a later resize back up to the actual NBD limit would have to pay 
attention to preallocation mode for that portion of the file, appears to 
not matter.  But if we can find a case where it does matter, I guess 
it's still appropriate for a followup for -rc3.  Meanwhile, I'm queuing 
this for -rc2.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


