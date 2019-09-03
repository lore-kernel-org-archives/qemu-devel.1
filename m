Return-Path: <SRS0=U1cK=W6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB977C3A5A2
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 10:24:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C7A62087E
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 10:24:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C7A62087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43644 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i55z7-0000a9-87
	for qemu-devel@archiver.kernel.org; Tue, 03 Sep 2019 06:24:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42855)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1i55wy-0007PP-Bs
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 06:22:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1i55wx-0007t1-9T
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 06:22:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35976)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>)
 id 1i55wu-0007qv-By; Tue, 03 Sep 2019 06:22:08 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 990F0307D915;
 Tue,  3 Sep 2019 10:22:07 +0000 (UTC)
Received: from localhost.localdomain (ovpn-116-195.ams2.redhat.com
 [10.36.116.195])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 232C01001956;
 Tue,  3 Sep 2019 10:22:05 +0000 (UTC)
Date: Tue, 3 Sep 2019 12:22:04 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Li Qiang <liq3ea@163.com>
Message-ID: <20190903102204.GF4582@localhost.localdomain>
References: <20190831020432.61473-1-liq3ea@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190831020432.61473-1-liq3ea@163.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.48]); Tue, 03 Sep 2019 10:22:07 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH] block: qcow2: free 'refcount_table' in
 error path
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
Cc: liq3ea@gmail.com, qemu-devel@nongnu.org, qemu-block@nongnu.org,
 mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 31.08.2019 um 04:04 hat Li Qiang geschrieben:
> Currently, when doing './check -qcow2 098'. We can get following
> asan output:
> 
> qemu-img: Could not empty blkdebug:TEST_DIR/blkdebug.conf:TEST_DIR/t.IMGFMT: Input/output error
> +
> +=================================================================
> +==60365==ERROR: LeakSanitizer: detected memory leaks
> +
> +Direct leak of 65536 byte(s) in 1 object(s) allocated from:
> +    #0 0x7f3ed729fd38 in __interceptor_calloc (/usr/lib/x86_64-linux-gnu/libasan.so.4+0xded38)
> +    #1 0x56274517fe66 in make_completely_empty block/IMGFMT.c:4219
> +    #2 0x562745180e51 in IMGFMT_make_empty block/IMGFMT.c:4313
> +    #3 0x56274509b14e in img_commit /home/test/qemu5/qemu/qemu-img.c:1053
> +    #4 0x5627450b4b74 in main /home/test/qemu5/qemu/qemu-img.c:5097
> +    #5 0x7f3ed4f2fb96 in __libc_start_main (/lib/x86_64-linux-gnu/libc.so.6+0x21b96)
> 
> This is because the logic of clean resource in 'make_completely_empty' is
> wrong. The patch frees the 's->refcount_table' in error path.
> 
> Signed-off-by: Li Qiang <liq3ea@163.com>

This is wrong. You can never free s->refcount_table and leave it as a
dangling pointer. It is state that is only supposed to be freed in
qcow2_close() -> qcow2_refcount_close().

The only reason why it doesn't crash with your change is that you also
make the error fatal (bs->drv = NULL) so that any further I/O on the
image will fail anyway. But there is no good reason to make these errors
fatal.

Kevin

>  block/qcow2.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/block/qcow2.c b/block/qcow2.c
> index 7c5a4859f7..23fe713d4c 100644
> --- a/block/qcow2.c
> +++ b/block/qcow2.c
> @@ -4243,7 +4243,7 @@ static int make_completely_empty(BlockDriverState *bs)
>      ret = bdrv_pwrite_sync(bs->file, s->cluster_size,
>                             &rt_entry, sizeof(rt_entry));
>      if (ret < 0) {
> -        goto fail_broken_refcounts;
> +        goto fail;
>      }
>      s->refcount_table[0] = 2 * s->cluster_size;
>  
> @@ -4252,7 +4252,7 @@ static int make_completely_empty(BlockDriverState *bs)
>      offset = qcow2_alloc_clusters(bs, 3 * s->cluster_size + l1_size2);
>      if (offset < 0) {
>          ret = offset;
> -        goto fail_broken_refcounts;
> +        goto fail;
>      } else if (offset > 0) {
>          error_report("First cluster in emptied image is in use");
>          abort();
> @@ -4274,6 +4274,9 @@ static int make_completely_empty(BlockDriverState *bs)
>  
>      return 0;
>  
> +fail:
> +    g_free(s->refcount_table);
> +
>  fail_broken_refcounts:
>      /* The BDS is unusable at this point. If we wanted to make it usable, we
>       * would have to call qcow2_refcount_close(), qcow2_refcount_init(),
> @@ -4283,8 +4286,6 @@ fail_broken_refcounts:
>       * that that sequence will fail as well. Therefore, just eject the BDS. */
>      bs->drv = NULL;
>  
> -fail:
> -    g_free(new_reftable);
>      return ret;
>  }
>  
> -- 
> 2.17.1
> 
> 

