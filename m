Return-Path: <SRS0=aJdJ=WV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62438C3A5A1
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Aug 2019 07:45:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 32D76217F4
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Aug 2019 07:45:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32D76217F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41264 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i1nDW-0000xg-40
	for qemu-devel@archiver.kernel.org; Sun, 25 Aug 2019 03:45:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35058)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlevitsk@redhat.com>) id 1i1nCT-0000DL-Gu
 for qemu-devel@nongnu.org; Sun, 25 Aug 2019 03:44:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1i1nCR-0001dK-FN
 for qemu-devel@nongnu.org; Sun, 25 Aug 2019 03:44:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58502)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>)
 id 1i1nCM-0001S5-Oy; Sun, 25 Aug 2019 03:44:26 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id EB3608D5BA2;
 Sun, 25 Aug 2019 07:44:25 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.49])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6C0021001B13;
 Sun, 25 Aug 2019 07:44:24 +0000 (UTC)
Message-ID: <92b8b240313fc978a1454e079963488667b6d4b0.camel@redhat.com>
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Nir Soffer <nirsof@gmail.com>, qemu-block@nongnu.org
Date: Sun, 25 Aug 2019 10:44:23 +0300
In-Reply-To: <20190816212122.8816-1-nsoffer@redhat.com>
References: <20190816212122.8816-1-nsoffer@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.69]); Sun, 25 Aug 2019 07:44:25 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH] block: posix: Always allocate
 the first block
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, 2019-08-17 at 00:21 +0300, Nir Soffer wrote:
> When creating an image with preallocation "off" or "falloc", the first
> block of the image is typically not allocated. When using Gluster
> storage backed by XFS filesystem, reading this block using direct I/O
> succeeds regardless of request length, fooling alignment detection.
> 
> In this case we fallback to a safe value (4096) instead of the optimal
> value (512), which may lead to unneeded data copying when aligning
> requests.  Allocating the first block avoids the fallback.
> 
> When using preallocation=off, we always allocate at least one filesystem
> block:
> 
>     $ ./qemu-img create -f raw test.raw 1g
>     Formatting 'test.raw', fmt=raw size=1073741824
> 
>     $ ls -lhs test.raw
>     4.0K -rw-r--r--. 1 nsoffer nsoffer 1.0G Aug 16 23:48 test.raw

Are you sure about this?

[mlevitsk@maximlenovopc ~/work/test_area/posix-file 0]$ qemu-img create -f raw test.raw 1g -o preallocation=off
Formatting 'test.raw', fmt=raw size=1073741824 preallocation=off
[mlevitsk@maximlenovopc ~/work/test_area/posix-file 0]$ls -lhs ./test.raw 
0 -rw-r--r--. 1 mlevitsk mlevitsk 1.0G Aug 25 10:38 ./test.raw

ext4, tested on qemu-4.0.0 and qemu git master.


From what I remember, the only case when posix-raw touches the first block is to zero it out
when running on top of kernel block device, to erase whatever header might be there, and this
is also kind of a backward compat hack which might be one day removed.

[...]

Best regards,
	Maxim Levitsky


