Return-Path: <SRS0=8zLO=TW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBDB6C282CE
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 13:33:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8BC4C20879
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 13:33:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BC4C20879
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:43331 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTRMw-0005p1-Ox
	for qemu-devel@archiver.kernel.org; Wed, 22 May 2019 09:33:22 -0400
Received: from eggs.gnu.org ([209.51.188.92]:33195)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <johannes@sipsolutions.net>) id 1hTQts-0003dj-5N
	for qemu-devel@nongnu.org; Wed, 22 May 2019 09:03:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <johannes@sipsolutions.net>) id 1hTQtm-0000WO-P1
	for qemu-devel@nongnu.org; Wed, 22 May 2019 09:03:20 -0400
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2]:54342
	helo=sipsolutions.net)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <johannes@sipsolutions.net>)
	id 1hTQtk-0000P7-Nh
	for qemu-devel@nongnu.org; Wed, 22 May 2019 09:03:14 -0400
Received: by sipsolutions.net with esmtpsa
	(TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.92)
	(envelope-from <johannes@sipsolutions.net>)
	id 1hTQtE-0005go-Fa; Wed, 22 May 2019 15:02:40 +0200
Message-ID: <0952696452f5ff4e38d2417029243fc60efa33d6.camel@sipsolutions.net>
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-um@lists.infradead.org, virtualization@lists.linux-foundation.org,
	qemu-devel@nongnu.org
Date: Wed, 22 May 2019 15:02:38 +0200
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-2.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a01:4f8:191:4433::2
X-Mailman-Approved-At: Wed, 22 May 2019 09:30:39 -0400
Subject: [Qemu-devel] custom virt-io support (in user-mode-linux)
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,

While my main interest is mostly in UML right now [1] I've CC'ed the
qemu and virtualization lists because something similar might actually
apply to other types of virtualization.

I'm thinking about adding virt-io support to UML, but the tricky part is
that while I want to use the virt-io basics (because it's a nice
interface from the 'inside'), I don't actually want the stock drivers
that are part of the kernel now (like virtio-net etc.) but rather
something that integrates with wifi (probably building on hwsim).

The 'inside' interfaces aren't really a problem - just have a specific
device ID for this, and then write a normal virtio kernel driver for it.

The 'outside' interfaces are where my thinking breaks down right now.

Looking at lkl, the outside is just all implemented in lkl as code that
gets linked to the library, so in UML terms it'd just be extra 'outside'
code like the timer handling or other netdev stuff we have today.
Looking at qemu, it's of course also implemented there, and then
interfaces with the real network, console abstraction, etc.

However, like I said above, I really need something very custom and not
likely to make it upstream to any project (because what point is that if
you cannot connect to the rest of the environment I'm building), so I'm
thinking that perhaps it should be possible to write an abstract
'outside' that lets you interact with it really from out-of-process?
Perhaps through some kind of shared memory segment? I think that gets
tricky with virt-io doing DMA (I think it does?) though, so that part
would have to be implemented directly and not out-of-process?

But really that's why I'm asking - is there a better way than to just
link the device-side virt-io code into the same binary (be it lkl lib,
uml binary, qemu binary)?

Thanks,
johannes

[1] Actually, I've considered using qemu, but it doesn't have
virtualized time and doesn't seem to support TSC virtualization. I guess
I could remove TSC from the guest CPU and add a virtualized HPET, but
I've yet to convince myself this works - on UML I made virtual time as a
prototype already:
https://patchwork.ozlabs.org/patch/1095814/
(though my real goal isn't to just skip time forward when the host goes
idle, it's to sync with other simulated components)


