Return-Path: <SRS0=/Jg5=XA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 837D1C3A5A5
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Sep 2019 09:50:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 571CA20825
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Sep 2019 09:50:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 571CA20825
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kamp.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43866 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5oPe-0005Rv-8P
	for qemu-devel@archiver.kernel.org; Thu, 05 Sep 2019 05:50:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49131)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pl@kamp.de>) id 1i5oOy-0004uL-P7
 for qemu-devel@nongnu.org; Thu, 05 Sep 2019 05:50:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pl@kamp.de>) id 1i5oOx-0001FF-M7
 for qemu-devel@nongnu.org; Thu, 05 Sep 2019 05:50:04 -0400
Received: from kerio.kamp.de ([195.62.97.192]:45095)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pl@kamp.de>)
 id 1i5oOx-0001Ez-G3; Thu, 05 Sep 2019 05:50:03 -0400
X-Footer: a2FtcC5kZQ==
Received: from [172.21.12.60] ([172.21.12.60]) (authenticated user pl@kamp.de)
 by kerio.kamp.de with ESMTPSA
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256 bits));
 Thu, 5 Sep 2019 11:49:57 +0200
To: Kevin Wolf <kwolf@redhat.com>
References: <20190903133524.11755-1-pl@kamp.de>
 <20190904140949.GC21246@localhost.localdomain>
From: Peter Lieven <pl@kamp.de>
Message-ID: <231274a6-e37c-5b7b-8168-a2f0f3a17f85@kamp.de>
Date: Thu, 5 Sep 2019 11:49:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190904140949.GC21246@localhost.localdomain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 195.62.97.192
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

Am 04.09.19 um 16:09 schrieb Kevin Wolf:
> Am 03.09.2019 um 15:35 hat Peter Lieven geschrieben:
>> qemu is currently not able to detect truncated vhdx image files.
>> Add a basic check if all allocated blocks are reachable at open and
>> report all errors during bdrv_co_check.
>>
>> Signed-off-by: Peter Lieven <pl@kamp.de>
>> ---
>> V3: - check for bdrv_getlength failure [Kevin]
>>      - use uint32_t for i [Kevin]
>>      - check for BAT entry overflow [Kevin]
>>      - break on !errcnt in second check
>>
>> V2: - add error reporting [Kevin]
>>      - use bdrv_getlength instead of bdrv_get_allocated_file_size [Kevin]
>>      - factor out BAT entry check and add error reporting for region
>>        overlaps
>>      - already check on vhdx_open
> Something still seems to be wrong with this patch:
>
>      213      fail       [15:50:13] [15:50:14]      (last: 2s)    output mismatch (see 213.out.bad)
>      --- /home/kwolf/source/qemu/tests/qemu-iotests/213.out  2019-06-28 14:19:50.065797707 +0200
>      +++ /home/kwolf/source/qemu/tests/qemu-iotests/213.out.bad      2019-09-04 15:50:14.582053976 +0200
>      @@ -46,10 +46,8 @@
>       {"execute": "job-dismiss", "arguments": {"id": "job0"}}
>       {"return": {}}
>
>      -image: TEST_IMG
>      -file format: IMGFMT
>      -virtual size: 32 MiB (33554432 bytes)
>      -cluster_size: 268435456
>      +qemu-img: VHDX BAT entry 0 offset points after end of file. Image has probably been truncated.
>      +qemu-img: Could not open 'TEST_IMG': Could not open 'TEST_IMG': Invalid argument
>
>       === Invalid BlockdevRef ===
>
> I can reproduce this manually with the following qemu-img invocations.
> It seems all three options must be given to reproduce the error:
>
>      $ ./qemu-img create -f vhdx -o block_size=268435456,subformat=fixed,block_state_zero=off /tmp/test.vhdx 32M
>      Formatting '/tmp/test.vhdx', fmt=vhdx size=33554432 log_size=1048576 block_size=268435456 subformat=fixed block_state_zero=off
>      $ ./qemu-img info /tmp/test.vhdx
>      qemu-img: VHDX BAT entry 0 offset points after end of file. Image has probably been truncated.
>      qemu-img: Could not open '/tmp/test.vhdx': Could not open '/tmp/test.vhdx': Invalid argument
>
> If I add the offsets to the error message (would probably nice to have),
> I get:
>
>      qemu-img: VHDX BAT entry 0 offset 8388608 points after end of file (41943040). Image has probably been truncated.


I can add this info and maybe we should also distinguish if the block is completely or only partially after

the end of file.


>
> So it seems that the file is large enough to hold 32M + metadata, but we
> don't increase the file size to hold a full block (256M). Is this a
> problem in the way we create images or are partial blocks at the end
> expected?


I have no idea if partial blocks are allowed. In all image created by Hyper-V that I used

to test the checker has reported no error.


Best,

Peter




