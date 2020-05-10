Return-Path: <SRS0=vfNf=6Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA111C38A2A
	for <qemu-devel@archiver.kernel.org>; Sun, 10 May 2020 16:57:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BEE5C20731
	for <qemu-devel@archiver.kernel.org>; Sun, 10 May 2020 16:57:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BEE5C20731
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tls.msk.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36940 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jXpGG-0007ie-Sa
	for qemu-devel@archiver.kernel.org; Sun, 10 May 2020 12:57:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35840)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1jXpFc-0007I1-CL
 for qemu-devel@nongnu.org; Sun, 10 May 2020 12:56:28 -0400
Received: from isrv.corpit.ru ([86.62.121.231]:41421)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1jXpFa-00063Z-Vi
 for qemu-devel@nongnu.org; Sun, 10 May 2020 12:56:28 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 053C64015F;
 Sun, 10 May 2020 19:56:14 +0300 (MSK)
Received: from [192.168.177.99] (mjt.vpn.tls.msk.ru [192.168.177.99])
 by tsrv.corpit.ru (Postfix) with ESMTP id DDB8F295;
 Sun, 10 May 2020 19:56:13 +0300 (MSK)
To: qemu-devel@nongnu.org
From: Michael Tokarev <mjt@tls.msk.ru>
Subject: some fun with -vga virtio or -display gtk,gl=on
Message-ID: <b701327d-c31a-d117-3bb9-74034eb478a8@msgid.tls.msk.ru>
Date: Sun, 10 May 2020 19:56:13 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: none client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/10 12:56:14
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_DNSWL_HI=-5 autolearn=_AUTOLEARN
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
Cc: Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi!

I'm seeing somewhat strange behavior of the mentioned options.

First is -vga virtio and regular gtk display - qemu opens initial window
of size 640x480 (I think anyway), and this window stays of that size, at
least while booting windows 10 (it uses stdvga driver), - it is not being
resized when windows switches to higher resolution, but scales instead.
"Best fit" does not change anything. What actually changes things is
*another* attempt to change screen resolution within windows, - this time
window gets correctly resized to the new size.

With -display sdl qemu window gets resized properly, ditto with -vga std.
Only -vga virtio -display gtk shows this strange behavior so far.


And second is another fun thing with mouse and its cursor when using
-display gtk,gl=on (independent on stdvga or virtiovga). This is quite
odd.  First, mouse _cursor_ disappears when the mouse is under qemu
window title or under the menu bar. Clicking on title/menu does the
correct things, but clicking needs to be done without seeing the cursor.
This is about the upper part of the window. And at the same time,
the bottom part, apparently of the same height as the window title +
menu bar, is unavailable within the guest, when trying to enter that
area with mouse the cursor gets out of sync and clicking on that area
is not possible.  It *looks* like the mouse cursor is shifted by the
height of upper area of invisibility, somehow.

Again, sdl display works fine here.

What is the thing about?  Having in mind also other fun things with gtk
display in the past (some of which are still here), should we switch
default display to sdl which does not have these issues?

Thanks,

/mjt

