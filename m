Return-Path: <SRS0=eeqW=XH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A617C5ACAE
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2019 08:14:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E8A120650
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2019 08:14:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E8A120650
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59046 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i8KF3-000752-FP
	for qemu-devel@archiver.kernel.org; Thu, 12 Sep 2019 04:14:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59121)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <johannes@sipsolutions.net>) id 1i8KEO-0006dP-8T
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 04:13:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <johannes@sipsolutions.net>) id 1i8KEN-0007bV-Bm
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 04:13:32 -0400
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2]:54788
 helo=sipsolutions.net)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <johannes@sipsolutions.net>)
 id 1i8KEN-0007a6-5I
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 04:13:31 -0400
Received: by sipsolutions.net with esmtpsa
 (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.92)
 (envelope-from <johannes@sipsolutions.net>)
 id 1i8KEK-0008RQ-VO; Thu, 12 Sep 2019 10:13:29 +0200
Message-ID: <cd8efde95c4edf806af3c2255e52be0567302f7e.camel@sipsolutions.net>
From: Johannes Berg <johannes@sipsolutions.net>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Date: Thu, 12 Sep 2019 10:13:28 +0200
In-Reply-To: <20190912080932.GA2722@work-vm>
References: <20190911134539.25650-1-johannes@sipsolutions.net>
 <20190911134539.25650-2-johannes@sipsolutions.net>
 <20190911191514.GA2895@work-vm>
 <24d6940040c4f846eaba2154979fd6658b665c98.camel@sipsolutions.net>
 <20190912080932.GA2722@work-vm>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a01:4f8:191:4433::2
Subject: Re: [Qemu-devel] [RFC v2 1/2] docs: vhost-user: add in-band
 kick/call messages
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
Cc: qemu-devel@nongnu.org, "Michael S . Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 2019-09-12 at 09:09 +0100, Dr. David Alan Gilbert wrote:
> 
> You're actually using the same trick of using
> REPLY_ACK/need_reply  to make it synchronous that set_mem_table does;

I don't think it's really the same - though arguably I could have
spec'ed the inband signal to *require* an ACK. The way I did it relies
on the REPLY_ACK extension.

SET_MEM_TABLE actually specifies a 3-way handshake, qemu->device,
device->qemu, qemu->device.

> that makes sense - but then new calls are getting it to actually process
> some data/commands on the ring itself?

No, the calls (or more specifically the REPLY_ACK to them) are really in
simulation to only acknowledge the interrupt (kick/call) signal has been
received and accounted for on the simulation calendar, the actual
processing happens when the calendar event is scheduled.

johannes


