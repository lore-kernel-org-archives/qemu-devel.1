Return-Path: <SRS0=ES4k=XM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B72EC4CEC9
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2019 12:09:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1103921881
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2019 12:09:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1103921881
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45126 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iACID-00032W-KT
	for qemu-devel@archiver.kernel.org; Tue, 17 Sep 2019 08:09:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59666)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <johannes@sipsolutions.net>) id 1iACB4-00071Z-1C
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 08:01:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <johannes@sipsolutions.net>) id 1iACB1-0003VH-P0
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 08:01:49 -0400
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2]:58944
 helo=sipsolutions.net)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <johannes@sipsolutions.net>)
 id 1iACAz-0003QU-UQ
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 08:01:46 -0400
Received: by sipsolutions.net with esmtpsa
 (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.92)
 (envelope-from <johannes@sipsolutions.net>)
 id 1iACAt-0003KK-Um; Tue, 17 Sep 2019 14:01:40 +0200
Message-ID: <0978f7296c9cb2da303ccae38941eb6fc9c4dbe1.camel@sipsolutions.net>
From: Johannes Berg <johannes@sipsolutions.net>
To: "Michael S. Tsirkin" <mst@redhat.com>
Date: Tue, 17 Sep 2019 14:01:38 +0200
In-Reply-To: <20190916112430-mutt-send-email-mst@kernel.org>
References: <20190911134539.25650-1-johannes@sipsolutions.net>
 <20190911134539.25650-2-johannes@sipsolutions.net>
 <20190911095650-mutt-send-email-mst@kernel.org>
 <fedd74ed3e9cc554287b202e73b047a938515113.camel@sipsolutions.net>
 <674086baeed5fce100d0882e668d5e36f026bd71.camel@sipsolutions.net>
 <20190916112430-mutt-send-email-mst@kernel.org>
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 2019-09-16 at 11:30 -0400, Michael S. Tsirkin wrote:
> 
> So first we really need to fix up Starting and stopping section,
> explaining that if the FD is invalid, this means ring
> is immediately started, right?

It actually does say that, and ... I even changed it already to say the
ring is also started when receiving the new VHOST_USER_VRING_KICK
message:

   Client must start ring upon receiving a kick (that is, detecting that
   file descriptor is readable) on the descriptor specified by
   ``VHOST_USER_SET_VRING_KICK`` (or receiving the in-band message
   ``VHOST_USER_VRING_KICK`` if negotiated) and stop ring upon receiving
   ``VHOST_USER_GET_VRING_BASE``.


> If we want to keep it simple, my proposal is this, if
> VHOST_USER_PROTOCOL_F_IN_BAND_NOTIFICATIONS is set then
> VHOST_USER_SET_VRING_CALL and VHOST_USER_SET_VRING_KICK are not valid.
> Starting/stopping ring needs to be updated, teaching it
> that ring is started after it gets a kick.

Makes sense, mostly I just need to actually *implement* that.

johannes


