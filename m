Return-Path: <SRS0=aRDT=W3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEC85C3A59B
	for <qemu-devel@archiver.kernel.org>; Sat, 31 Aug 2019 00:47:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9067C2342E
	for <qemu-devel@archiver.kernel.org>; Sat, 31 Aug 2019 00:47:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9067C2342E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42012 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i3rXh-0004Sb-Ph
	for qemu-devel@archiver.kernel.org; Fri, 30 Aug 2019 20:47:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58003)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <fangying1@huawei.com>) id 1i3rVA-0003mA-T2
 for qemu-devel@nongnu.org; Fri, 30 Aug 2019 20:44:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <fangying1@huawei.com>) id 1i3rV7-0000p2-GZ
 for qemu-devel@nongnu.org; Fri, 30 Aug 2019 20:44:23 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:34244 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <fangying1@huawei.com>)
 id 1i3rV7-0000Kg-5l
 for qemu-devel@nongnu.org; Fri, 30 Aug 2019 20:44:21 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id ABC48D5CB061C8EF8976;
 Sat, 31 Aug 2019 08:44:10 +0800 (CST)
Received: from [127.0.0.1] (10.133.205.53) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.439.0; Sat, 31 Aug 2019
 08:44:01 +0800
To: <kraxel@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
From: fangying <fangying1@huawei.com>
Message-ID: <7d22c299-29fe-8479-ee14-17d521bb9d6b@huawei.com>
Date: Sat, 31 Aug 2019 08:44:01 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.133.205.53]
X-CFilter-Loop: Reflected
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 45.249.212.32
Subject: [Qemu-devel] Discussion: vnc: memory leak in zrle_compress_data
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
Cc: berrange@redhat.com, zhouyibo <zhouyibo3@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Gerd,

Memory leak is observed in zrle_compress_data when we are doing some 
AddressSanitizer tests. The leak stack is as bellow:

=================================================================
==47887==ERROR: LeakSanitizer: detected memory leaks

Direct leak of 29760 byte(s) in 5 object(s) allocated from:
     #0 0xffffa67ef3c3 in __interceptor_calloc (/lib64/libasan.so.4+0xd33c3)
     #1 0xffffa65071cb in g_malloc0 (/lib64/libglib-2.0.so.0+0x571cb)
     #2 0xffffa5e968f7 in deflateInit2_ (/lib64/libz.so.1+0x78f7)
     #3 0xaaaacec58613 in zrle_compress_data ui/vnc-enc-zrle.c:87
     #4 0xaaaacec58613 in zrle_send_framebuffer_update ui/vnc-enc-zrle.c:344
     #5 0xaaaacec34e77 in vnc_send_framebuffer_update ui/vnc.c:919
     #6 0xaaaacec5e023 in vnc_worker_thread_loop ui/vnc-jobs.c:271
     #7 0xaaaacec5e5e7 in vnc_worker_thread ui/vnc-jobs.c:340
     #8 0xaaaacee4d3c3 in qemu_thread_start util/qemu-thread-posix.c:502
     #9 0xffffa544e8bb in start_thread (/lib64/libpthread.so.0+0x78bb)
     #10 0xffffa53965cb in thread_start (/lib64/libc.so.6+0xd55cb)

This leak stack can be easily reproduced in the case that a client repeatedly 
does vnc connect/disconnect .

To get the leak stack, we can compile qemu with
--extra-ldflags=-Wl,--build-id -Wl,-z,relro -Wl,-z,now -lasan'
'--extra-cflags=-O0 -g -fno-omit-frame-pointer -fno-stack-protector 
-fsanitize=address -fsanitize=leak' using gcc that supports asan.

It is obvious that there may be memory leak in the zlib/zrle compress stuff.
IIUC, *deflateInit2* is called with the local VncState vs->zrle.stream when a 
client is connected the vnc server. And then *deflate* is called to do the 
encoding. Finally *deflateEnd* is called in vnc_zrle_clear when a connection is
closed.

I had not think it out why this memory leak could happen here.
It is noticed that deflateInit2 is called with the local vs,
however deflateEnd is called with the origin vs.
The local vs is copied to the origin vs in vnc_async_encoding_start and 
vnc_async_encoding_end on the contrary.

Have you got any idea on this issue ?

Thanks.
Ying Fang


