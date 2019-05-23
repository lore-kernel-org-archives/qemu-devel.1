Return-Path: <SRS0=bvyN=TX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFC60C282DD
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 14:39:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A61EC2175B
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 14:39:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A61EC2175B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:37814 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTosE-0007eX-TI
	for qemu-devel@archiver.kernel.org; Thu, 23 May 2019 10:39:14 -0400
Received: from eggs.gnu.org ([209.51.188.92]:54545)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <johannes@sipsolutions.net>) id 1hToft-0004lW-Pd
	for qemu-devel@nongnu.org; Thu, 23 May 2019 10:26:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <johannes@sipsolutions.net>) id 1hTofs-0000Ew-HA
	for qemu-devel@nongnu.org; Thu, 23 May 2019 10:26:29 -0400
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2]:32926
	helo=sipsolutions.net)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <johannes@sipsolutions.net>)
	id 1hTofs-0008FU-9x
	for qemu-devel@nongnu.org; Thu, 23 May 2019 10:26:28 -0400
Received: by sipsolutions.net with esmtpsa
	(TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.92)
	(envelope-from <johannes@sipsolutions.net>)
	id 1hTofJ-00042W-Kh; Thu, 23 May 2019 16:25:53 +0200
Message-ID: <41d64b8971a097d1568f947517b45d09c156ccc8.camel@sipsolutions.net>
From: Johannes Berg <johannes@sipsolutions.net>
To: Stefan Hajnoczi <stefanha@gmail.com>
Date: Thu, 23 May 2019 16:25:52 +0200
In-Reply-To: <20190523115950.GH26632@stefanha-x1.localdomain>
	(sfid-20190523_135953_660617_C54B8FAF)
References: <0952696452f5ff4e38d2417029243fc60efa33d6.camel@sipsolutions.net>
	<20190523115950.GH26632@stefanha-x1.localdomain>
	(sfid-20190523_135953_660617_C54B8FAF)
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-2.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a01:4f8:191:4433::2
Subject: Re: [Qemu-devel] custom virt-io support (in user-mode-linux)
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
Cc: ido@wizery.com, linux-um@lists.infradead.org, qemu-devel@nongnu.org,
	virtualization@lists.linux-foundation.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Stefan,

> Check out vhost-user.  It's a protocol for running a subset of a VIRTIO
> device's emulation in a separate process (usually just the data plane
> with the PCI emulation and other configuration/setup still handled by
> QEMU).

Yes, I think that's basically what I'm looking for.

> vhost-user uses a UNIX domain socket to pass file descriptors to shared
> memory regions.  This way the vhost-user device backend process has
> access to guest RAM.
> 
> This would be quite different for UML since my understanding is you
> don't have guest RAM but actual host Linux processes, but vhost-user
> might still give you ideas:
> https://git.qemu.org/?p=qemu.git;a=blob_plain;f=docs/interop/vhost-user.rst;hb=HEAD

I guess it could still be implemented. Do you know how qemu actually
creates the shared memory region though? It's normal inside kernel
memory, no?

Ah, no, I see ... you have to give -mem-path and then the entire guest
memory isn't allocated as anonymous memory but from a file, and then you
can pass a descriptor to that file and effectively the client/slave of
vhost-user can access the whole guest's memory. Interesting. Next you're
going to want an IOMMU there, not just fake one, to protect against
hostile virt-user client? Not that I care :-)

UML in fact already maps all of its memory as a file (see arch/um/
create_mem_file()), so this part is easy.

What confused me at first is how all this talks about the ioctl()
interface, but I think I understand now - it's basically replacing
ioctl() with talking to a client.

So ultimately, it would actually seem "pretty simple".

Not sure I understand why there's all this stuff about multiple FDs,
once you have access to the guest's memory, why do you still need a
second (or more) FDs?

Also, not sure I understand how the client is started?

Once we have a connection, I guess as a client I'd at the very least
have to handle
 * VHOST_USER_GET_FEATURES and reply with the features, obviously, which
   is in this case just VHOST_USER_F_PROTOCOL_FEATURES?

 * VHOST_USER_SET_FEATURES - not sure, what would that do? the master
   sends VHOST_USER_GET_PROTOCOL_FEATURES which is with this feature
   bit? Especially since it says: "Slave that reported
   VHOST_USER_F_PROTOCOL_FEATURES must support this message even before
   VHOST_USER_SET_FEATURES was called."

 * VHOST_USER_GET_PROTOCOL_FEATURES - looking at the list, most I don't
   really need here, but OK

 * VHOST_USER_SET_OWNER - ??

 * VHOST_USER_RESET_OWNER - ignore

 * VHOST_USER_SET_MEM_TABLE - store the data/FDs for later use, I guess

 * VHOST_USER_SET_VRING_NUM - store the data for later use
 * VHOST_USER_SET_VRING_ADDR - dito
 * VHOST_USER_SET_VRING_BASE - dito
 * VHOST_USER_SET_VRING_KICK - start epoll on the FD (assuming there is
                               one, give up if not?) - well, if ring is
                               enabled?
 * VHOST_USER_SET_VRING_CALL - ...

I guess there might be better documentation on the ioctl interfaces?


Do you know if there's a sample client/server somewhere?

I guess we should implement the server in UML like it is in QEMU (unless
we can figure out how to virtualize the time with HPET or something in
QEMU) and then have our client and kernel driver for it...


Thanks a lot!

johannes


