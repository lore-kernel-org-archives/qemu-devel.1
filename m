Return-Path: <SRS0=c3jH=W7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80C28C3A5A7
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 14:11:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5696422CEA
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 14:11:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5696422CEA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60972 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5W03-0002E2-Bo
	for qemu-devel@archiver.kernel.org; Wed, 04 Sep 2019 10:11:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44856)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1i5Vyy-0001N8-1A
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 10:10:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1i5Vyw-0001hp-Mp
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 10:09:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36786)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>)
 id 1i5Vyt-0001f1-Fa; Wed, 04 Sep 2019 10:09:55 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 1978A30860CA;
 Wed,  4 Sep 2019 14:09:54 +0000 (UTC)
Received: from localhost.localdomain (ovpn-116-221.ams2.redhat.com
 [10.36.116.221])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id ADDC65DC1E;
 Wed,  4 Sep 2019 14:09:51 +0000 (UTC)
Date: Wed, 4 Sep 2019 16:09:49 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Peter Lieven <pl@kamp.de>
Message-ID: <20190904140949.GC21246@localhost.localdomain>
References: <20190903133524.11755-1-pl@kamp.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190903133524.11755-1-pl@kamp.de>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.44]); Wed, 04 Sep 2019 14:09:54 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH V3] block/vhdx: add check for truncated
 image files
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
Cc: codyprime@gmail.com, mreitz@redhat.com, jhf@kamp.de, qemu-block@nongnu.org,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 03.09.2019 um 15:35 hat Peter Lieven geschrieben:
> qemu is currently not able to detect truncated vhdx image files.
> Add a basic check if all allocated blocks are reachable at open and
> report all errors during bdrv_co_check.
> 
> Signed-off-by: Peter Lieven <pl@kamp.de>
> ---
> V3: - check for bdrv_getlength failure [Kevin]
>     - use uint32_t for i [Kevin]
>     - check for BAT entry overflow [Kevin]
>     - break on !errcnt in second check
> 
> V2: - add error reporting [Kevin]
>     - use bdrv_getlength instead of bdrv_get_allocated_file_size [Kevin]
>     - factor out BAT entry check and add error reporting for region
>       overlaps
>     - already check on vhdx_open

Something still seems to be wrong with this patch:

    213      fail       [15:50:13] [15:50:14]      (last: 2s)    output mismatch (see 213.out.bad)
    --- /home/kwolf/source/qemu/tests/qemu-iotests/213.out  2019-06-28 14:19:50.065797707 +0200
    +++ /home/kwolf/source/qemu/tests/qemu-iotests/213.out.bad      2019-09-04 15:50:14.582053976 +0200
    @@ -46,10 +46,8 @@
     {"execute": "job-dismiss", "arguments": {"id": "job0"}}
     {"return": {}}

    -image: TEST_IMG
    -file format: IMGFMT
    -virtual size: 32 MiB (33554432 bytes)
    -cluster_size: 268435456
    +qemu-img: VHDX BAT entry 0 offset points after end of file. Image has probably been truncated.
    +qemu-img: Could not open 'TEST_IMG': Could not open 'TEST_IMG': Invalid argument

     === Invalid BlockdevRef ===

I can reproduce this manually with the following qemu-img invocations.
It seems all three options must be given to reproduce the error:

    $ ./qemu-img create -f vhdx -o block_size=268435456,subformat=fixed,block_state_zero=off /tmp/test.vhdx 32M
    Formatting '/tmp/test.vhdx', fmt=vhdx size=33554432 log_size=1048576 block_size=268435456 subformat=fixed block_state_zero=off
    $ ./qemu-img info /tmp/test.vhdx
    qemu-img: VHDX BAT entry 0 offset points after end of file. Image has probably been truncated.
    qemu-img: Could not open '/tmp/test.vhdx': Could not open '/tmp/test.vhdx': Invalid argument

If I add the offsets to the error message (would probably nice to have),
I get:

    qemu-img: VHDX BAT entry 0 offset 8388608 points after end of file (41943040). Image has probably been truncated.

So it seems that the file is large enough to hold 32M + metadata, but we
don't increase the file size to hold a full block (256M). Is this a
problem in the way we create images or are partial blocks at the end
expected?

Kevin

