Return-Path: <SRS0=zL9l=BA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECD6CC433E4
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2020 10:02:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B92B620729
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2020 10:02:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f0NkynJ3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B92B620729
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36264 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jxp6e-0001xs-2x
	for qemu-devel@archiver.kernel.org; Tue, 21 Jul 2020 06:02:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47394)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jxp5b-0001Gc-LR
 for qemu-devel@nongnu.org; Tue, 21 Jul 2020 06:01:35 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:48249
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jxp5Z-0006zG-PO
 for qemu-devel@nongnu.org; Tue, 21 Jul 2020 06:01:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595325693;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=gno2KXC9RrjGMmr6ka2Qbd5O8HhBn5MJk9R8WDrdFXg=;
 b=f0NkynJ3ewPtC3hdGOGTABLmyqEALnb7WrhHpV0MOvSgUo5WEjgLU9mMFoYGeyvyLBaZYT
 MbC2JiNCts4l6m1OifG19bfVsMCbyreEXrfLB3Ldk1qe/mEgDrkv9jg114iyOLLge3MD33
 MSAFu+bBI0+jMpkCUQQf3B7iJb0ncoA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-313-CyCs4r4HPrKItubVl4nbwg-1; Tue, 21 Jul 2020 06:01:21 -0400
X-MC-Unique: CyCs4r4HPrKItubVl4nbwg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5D8421902EA0;
 Tue, 21 Jul 2020 10:01:20 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-113-68.ams2.redhat.com
 [10.36.113.68])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 45E485D9D7;
 Tue, 21 Jul 2020 10:01:15 +0000 (UTC)
Subject: Re: [PATCH for-5.1] block: fix bdrv_aio_cancel() for ENOMEDIUM
 requests
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
References: <20200720100141.129739-1-stefanha@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Autocrypt: addr=mreitz@redhat.com; prefer-encrypt=mutual; keydata=
 mQENBFXOJlcBCADEyyhOTsoa/2ujoTRAJj4MKA21dkxxELVj3cuILpLTmtachWj7QW+TVG8U
 /PsMCFbpwsQR7oEy8eHHZwuGQsNpEtNC2G/L8Yka0BIBzv7dEgrPzIu+W3anZXQW4702+uES
 U29G8TP/NGfXRRHGlbBIH9KNUnOSUD2vRtpOLXkWsV5CN6vQFYgQfFvmp5ZpPeUe6xNplu8V
 mcTw8OSEDW/ZnxJc8TekCKZSpdzYoxfzjm7xGmZqB18VFwgJZlIibt1HE0EB4w5GsD7x5ekh
 awIe3RwoZgZDLQMdOitJ1tUc8aqaxvgA4tz6J6st8D8pS//m1gAoYJWGwwIVj1DjTYLtABEB
 AAG0HU1heCBSZWl0eiA8bXJlaXR6QHJlZGhhdC5jb20+iQFTBBMBCAA9AhsDBQkSzAMABQsJ
 CAcCBhUICQoLAgQWAgMBAh4BAheABQJVzie5FRhoa3A6Ly9rZXlzLmdudXBnLm5ldAAKCRD0
 B9sAYdXPQDcIB/9uNkbYEex1rHKz3mr12uxYMwLOOFY9fstP5aoVJQ1nWQVB6m2cfKGdcRe1
 2/nFaHSNAzT0NnKz2MjhZVmcrpyd2Gp2QyISCfb1FbT82GMtXFj1wiHmPb3CixYmWGQUUh+I
 AvUqsevLA+WihgBUyaJq/vuDVM1/K9Un+w+Tz5vpeMidlIsTYhcsMhn0L9wlCjoucljvbDy/
 8C9L2DUdgi3XTa0ORKeflUhdL4gucWoAMrKX2nmPjBMKLgU7WLBc8AtV+84b9OWFML6NEyo4
 4cP7cM/07VlJK53pqNg5cHtnWwjHcbpGkQvx6RUx6F1My3y52vM24rNUA3+ligVEgPYBuQEN
 BFXOJlcBCADAmcVUNTWT6yLWQHvxZ0o47KCP8OcLqD+67T0RCe6d0LP8GsWtrJdeDIQk+T+F
 xO7DolQPS6iQ6Ak2/lJaPX8L0BkEAiMuLCKFU6Bn3lFOkrQeKp3u05wCSV1iKnhg0UPji9V2
 W5eNfy8F4ZQHpeGUGy+liGXlxqkeRVhLyevUqfU0WgNqAJpfhHSGpBgihUupmyUg7lfUPeRM
 DzAN1pIqoFuxnN+BRHdAecpsLcbR8sQddXmDg9BpSKozO/JyBmaS1RlquI8HERQoe6EynJhd
 64aICHDfj61rp+/0jTIcevxIIAzW70IadoS/y3DVIkuhncgDBvGbF3aBtjrJVP+5ABEBAAGJ
 ASUEGAEIAA8FAlXOJlcCGwwFCRLMAwAACgkQ9AfbAGHVz0CbFwf9F/PXxQR9i4N0iipISYjU
 sxVdjJOM2TMut+ZZcQ6NSMvhZ0ogQxJ+iEQ5OjnIputKvPVd5U7WRh+4lF1lB/NQGrGZQ1ic
 alkj6ocscQyFwfib+xIe9w8TG1CVGkII7+TbS5pXHRxZH1niaRpoi/hYtgzkuOPp35jJyqT/
 /ELbqQTDAWcqtJhzxKLE/ugcOMK520dJDeb6x2xVES+S5LXby0D4juZlvUj+1fwZu+7Io5+B
 bkhSVPb/QdOVTpnz7zWNyNw+OONo1aBUKkhq2UIByYXgORPFnbfMY7QWHcjpBVw9MgC4tGeF
 R4bv+1nAMMxKmb5VvQCExr0eFhJUAHAhVg==
Message-ID: <5d918d7e-8ffd-cde7-639f-8216257098a2@redhat.com>
Date: Tue, 21 Jul 2020 12:01:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200720100141.129739-1-stefanha@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=mreitz@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/21 01:46:39
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=unavailable autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>, Alexander Bulekov <alxndr@bu.edu>,
 qemu-stable@nongnu.org, qemu-block@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 20.07.20 12:01, Stefan Hajnoczi wrote:
> bdrv_aio_cancel() calls aio_poll() on the AioContext for the given I/O
> request until it has completed. ENOMEDIUM requests are special because
> there is no BlockDriverState when the drive has no medium!
> 
> Define a .get_aio_context() function for BlkAioEmAIOCB requests so that
> bdrv_aio_cancel() can find the AioContext where the completion BH is
> pending. Without this function bdrv_aio_cancel() aborts on ENOMEDIUM
> requests!
> 
> libFuzzer triggered the following assertion:
> 
>   cat << EOF | qemu-system-i386 -M pc-q35-5.0 \
>     -nographic -monitor none -serial none \
>     -qtest stdio -trace ide\*
>   outl 0xcf8 0x8000fa24
>   outl 0xcfc 0xe106c000
>   outl 0xcf8 0x8000fa04
>   outw 0xcfc 0x7
>   outl 0xcf8 0x8000fb20
>   write 0x0 0x3 0x2780e7
>   write 0xe106c22c 0xd 0x1130c218021130c218021130c2
>   write 0xe106c218 0x15 0x110010110010110010110010110010110010110010
>   EOF
>   ide_exec_cmd IDE exec cmd: bus 0x56170a77a2b8; state 0x56170a77a340; cmd 0xe7
>   ide_reset IDEstate 0x56170a77a340
>   Aborted (core dumped)
> 
>   (gdb) bt
>   #1  0x00007ffff4f93895 in abort () at /lib64/libc.so.6
>   #2  0x0000555555dc6c00 in bdrv_aio_cancel (acb=0x555556765550) at block/io.c:2745
>   #3  0x0000555555dac202 in blk_aio_cancel (acb=0x555556765550) at block/block-backend.c:1546
>   #4  0x0000555555b1bd74 in ide_reset (s=0x555557213340) at hw/ide/core.c:1318
>   #5  0x0000555555b1e3a1 in ide_bus_reset (bus=0x5555572132b8) at hw/ide/core.c:2422
>   #6  0x0000555555b2aa27 in ahci_reset_port (s=0x55555720eb50, port=2) at hw/ide/ahci.c:650
>   #7  0x0000555555b29fd7 in ahci_port_write (s=0x55555720eb50, port=2, offset=44, val=16) at hw/ide/ahci.c:360
>   #8  0x0000555555b2a564 in ahci_mem_write (opaque=0x55555720eb50, addr=556, val=16, size=1) at hw/ide/ahci.c:513
>   #9  0x000055555598415b in memory_region_write_accessor (mr=0x55555720eb80, addr=556, value=0x7fffffffb838, size=1, shift=0, mask=255, attrs=...) at softmmu/memory.c:483
> 
> Looking at bdrv_aio_cancel:
> 
> 2728 /* async I/Os */
> 2729
> 2730 void bdrv_aio_cancel(BlockAIOCB *acb)
> 2731 {
> 2732     qemu_aio_ref(acb);
> 2733     bdrv_aio_cancel_async(acb);
> 2734     while (acb->refcnt > 1) {
> 2735         if (acb->aiocb_info->get_aio_context) {
> 2736             aio_poll(acb->aiocb_info->get_aio_context(acb), true);
> 2737         } else if (acb->bs) {
> 2738             /* qemu_aio_ref and qemu_aio_unref are not thread-safe, so
> 2739              * assert that we're not using an I/O thread.  Thread-safe
> 2740              * code should use bdrv_aio_cancel_async exclusively.
> 2741              */
> 2742             assert(bdrv_get_aio_context(acb->bs) == qemu_get_aio_context());
> 2743             aio_poll(bdrv_get_aio_context(acb->bs), true);
> 2744         } else {
> 2745             abort();     <===============
> 2746         }
> 2747     }
> 2748     qemu_aio_unref(acb);
> 2749 }
> 
> Fixes: 02c50efe08736116048d5fc355043080f4d5859c ("block: Add bdrv_aio_cancel_async")
> Reported-by: Alexander Bulekov <alxndr@bu.edu>
> Buglink: https://bugs.launchpad.net/qemu/+bug/1878255
> Originally-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  block/block-backend.c | 8 ++++++++
>  1 file changed, 8 insertions(+)

Thanks, applied to my block branch:

https://git.xanclic.moe/XanClic/qemu/commits/branch/block


