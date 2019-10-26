Return-Path: <SRS0=l02z=YT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22605CA9EB9
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Oct 2019 16:21:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D894820684
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Oct 2019 16:21:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HJ5ddfEn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D894820684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40714 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iOOp4-0004NT-0Z
	for qemu-devel@archiver.kernel.org; Sat, 26 Oct 2019 12:21:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59098)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1iOOoA-0003C8-RF
 for qemu-devel@nongnu.org; Sat, 26 Oct 2019 12:20:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1iOOo8-0000VU-L1
 for qemu-devel@nongnu.org; Sat, 26 Oct 2019 12:20:53 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:58044
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1iOOo8-0000Ue-D5
 for qemu-devel@nongnu.org; Sat, 26 Oct 2019 12:20:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1572106850;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bLv+a19frc3qnzwQjt6tUoyqtftagDqpUJsXAixM5j4=;
 b=HJ5ddfEnnFrNlc1Vz2i6kHC6ws24C2PppFzeD775Onnu/mUIu/CbWd21+rhZopIrefZFg0
 895INX4q+f3SsiRFUh0GQKRdtCqonR/+tbj1QBBukA6sQrDLsu7vaqPWeIStzUUcwkPGIo
 QzzimCdgtsDzuZfzxqC00SzM3dal7FI=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-204-iOlI-7-MPie-5Jb-FwL-vA-1; Sat, 26 Oct 2019 12:20:48 -0400
Received: by mail-wm1-f72.google.com with SMTP id z23so1906875wml.0
 for <qemu-devel@nongnu.org>; Sat, 26 Oct 2019 09:20:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=wENAS2dmJ4JiszTgseYVbb7b8I3Eni0eXgPFeqxpBxA=;
 b=gHkRO0ARtCflUUrtJpTvKI+NjiJDslHjR3+gJza+Ngu9vzyiZO7aA/MK4XHjIR/Arp
 eTHGOjyrLUy5NXVrua2tf1VXPOeKNrYBLQZl+tAbBNSlIBGtnjwiS6fErGbL8hcJLQMY
 E1siZwpwAAXmWGcMeu1sLs8jnkot7nympmeM6bdHiaUUYigQUhUtNPkVQbKXUgrroI+x
 8SlSo7QVt0geIzW+8CaXUPbngfdoJrN0efkCdveJ42dE73GvjivVRJSrxIhOLDA9OcTN
 Q3zcQk2fl2BaxIkwJxOnwhlkO1A+bvaUQFZzcCQjttNA5EOvtBv5t3dPoQRzQITmcM5g
 cc2A==
X-Gm-Message-State: APjAAAXhoQm09Tn34h1TmsrPK7dyWv50daekObfdkeyVbPG2lBSLXH+u
 R/eYvmwjAnW1voOOLgCEnDAGl5vZX6abIKtPvooT2de6nYbqjd3mFpp4hQxPBV3jlCxVOPtYSUY
 c9vLPr89KcQWmEKg=
X-Received: by 2002:a5d:5544:: with SMTP id g4mr8206558wrw.72.1572106847516;
 Sat, 26 Oct 2019 09:20:47 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwKbkFVhbhDxL1+NozBk0GJW8lYtFTe9fH0kCq/vZvC8x6F14vLMBZpTpeT6bHw1CX6JSXNuQ==
X-Received: by 2002:a5d:5544:: with SMTP id g4mr8206542wrw.72.1572106847285;
 Sat, 26 Oct 2019 09:20:47 -0700 (PDT)
Received: from redhat.com (bzq-79-176-10-77.red.bezeqint.net. [79.176.10.77])
 by smtp.gmail.com with ESMTPSA id
 c21sm5305740wmb.46.2019.10.26.09.20.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 26 Oct 2019 09:20:45 -0700 (PDT)
Date: Sat, 26 Oct 2019 12:20:42 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Raphael Norwitz <raphael.norwitz@nutanix.com>
Subject: Re: Long term approaches to mitigate device reset issue in
 vhost-user-scsi
Message-ID: <20191026121841-mutt-send-email-mst@kernel.org>
References: <20191025134041.GC109271@raphael-norwitz.user.nutanix.com>
MIME-Version: 1.0
In-Reply-To: <20191025134041.GC109271@raphael-norwitz.user.nutanix.com>
X-MC-Unique: iOlI-7-MPie-5Jb-FwL-vA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
Cc: qemu-devel@nongnu.org, felipe@nutanix.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Oct 25, 2019 at 06:40:41AM -0700, Raphael Norwitz wrote:
> Hi MST,
>=20
> We are trying to develop a long term fix to the following issue with
> vhost-user-scsi:
>=20
> When a live migration starts, Qemu sends a SET_VRING_ADDR message to
> update the VQ's flags (turning log on). We can't distinguish that
> message from the first SET_VRING_ADDR message sent after a device
> reset (given that vhost-user backends are not notified about resets).
> That distinction is important because we need to know whether to
> refetch the used ring from guest memory.


Could you clarify a bit more please?

According to the spec the trigger for starting/stopping
the rings is supposed to be VHOST_USER_SET_VRING_KICK,
not SET_VRING_ADDR.

What is this fetching you are talking about?


> A while back we sent a patch [1] (which we still use internally) to intro=
duce a
> message which tells vhost-user backends about device resets. No one
> ever responded to that patch. They are getting clunky to maintain
> and we would prefer to converge on a solution which is inline with
> upstream.
>=20
> [1] https://lists.gnu.org/archive/html/qemu-devel/2018-03/msg05077.html
>=20
> Vhost seems to support the concept of a reset through the reset_device
> callback in the VhostOps struct. Currently, the vhost-user VhostOps
> reset callback sends RESET_OWNER message.
>=20
> The docs currently state, though, that this message is obsolete. Looking
> at the history, I see change d1f8b30ec8dde0318fd1b98d24a64926feae9625
> actually changed the message name to RESET_DEVICE, although it was
> subsequently changed back to RESET_OWNER.
>=20
> With this in mind, we think the code should be improved by:
>=20
> 1) Stopping qemu from sending the RESET_OWNER message on the
> vhost-user device_reset callback.
> 2) Amending the docs to better align with the code.
> 3) If you agree with 1), adding a separate DEVICE_RESET message.
>=20
> If you agree with 1) and 3) would you reconsider patch [1]? If so, I will
> have to update the patch because the message/features numbers
> are now taken. Should I update the patch and resend?
>=20
> If you don't plan on stopping Qemu from sending RESET_OWNER,
> I'd like to post a patch allowing vhost-user-scsi benefit from
> the RESET_OWNER message (as it currently don't offer a device
> reset callback).
>=20
> Thanks,
> Raphael


