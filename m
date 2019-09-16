Return-Path: <SRS0=kH2x=XL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3FC1C49ED7
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2019 16:24:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B2E142184D
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2019 16:24:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M/HPRJMm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2E142184D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36748 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i9tnI-0007Zk-Cp
	for qemu-devel@archiver.kernel.org; Mon, 16 Sep 2019 12:24:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60584)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1i9sxg-00050M-N1
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 11:30:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1i9sxf-0001d1-EL
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 11:30:44 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:33562
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1i9sxe-0001cV-PT
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 11:30:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1568647841;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=te3evpxZ+xN1wQC1yCOin2y8byAP9R+d80VqueBPR3I=;
 b=M/HPRJMmgEYmqEdAtkkvZFMwYqCjqFUThAu/O7dgb193h0Ix+LT71VjXtClGHcUnRC6gXd
 bO29iK3n4qswfqYUOlc6VOvTtXbCOMiqyizwhIrdFF/MhGofY90s/6lA3wQdYV6FySMufQ
 wVGQ2Pxf9gwKZPc9WwxP6ZKFJX2fdLw=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-346-bsBAAAMROqmoaS8AThI7RA-1; Mon, 16 Sep 2019 11:30:40 -0400
Received: by mail-qt1-f200.google.com with SMTP id n5so473236qtp.5
 for <qemu-devel@nongnu.org>; Mon, 16 Sep 2019 08:30:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=+kyMHWIzdDDa0kHLKcIALBjG7dIK1Osv/wN3pWM03nA=;
 b=d0bLPUaVkQyx/WuNNtkjaR1gMaHK/nZR1mgJ7PIbUOkKegUcGpeZyf6wud0kmARyz3
 v361zk7iuH122pt6b3WCxhjJHaZlBZkiFBhwhzDrWXrX/3d/qBojfX4nHS6zg5q5Eqa0
 kdShAlsKyvNMY9m7rhj3QNb0GX+Eijv614CPjmOKa5JChLeb+ZPIP4m+tYN6Q5Fh2fkL
 lawLtJHZjjqD2SgD5pmt5tX/uWL1Y/5q+VcWoaMQQ+ZIt52N0Xp56qy6Pgncc3twEVED
 eBp54dbTqdOsNcv93Oy5cBDxEQiIAhDhVu/aM06vQdzun4bMBEbB14UKIuLCYxWenuDf
 2M5Q==
X-Gm-Message-State: APjAAAUb71A++IAgMwHkDa81NzM019PLNlEDXoKHs6iPj7av5b0DHZav
 gSM3mIxq3iTJsppe8ura7OqnCbsbG0fNo6xbSCoXlNYSFPw3UaBIArsYEAo0yduT/n+UhDBb78V
 sYiL2yA6A3ZTx/yA=
X-Received: by 2002:ac8:480b:: with SMTP id g11mr100474qtq.359.1568647839183; 
 Mon, 16 Sep 2019 08:30:39 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyAYbsZzVknH40g891MIZXMy0ThCnAHLHZZOCjW8/Gmy5Ja/x98NkAQ/nHzWE6PwH85bXaZvQ==
X-Received: by 2002:ac8:480b:: with SMTP id g11mr100460qtq.359.1568647839000; 
 Mon, 16 Sep 2019 08:30:39 -0700 (PDT)
Received: from redhat.com (bzq-79-176-40-226.red.bezeqint.net. [79.176.40.226])
 by smtp.gmail.com with ESMTPSA id x15sm3291235qkh.44.2019.09.16.08.30.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Sep 2019 08:30:38 -0700 (PDT)
Date: Mon, 16 Sep 2019 11:30:34 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Johannes Berg <johannes@sipsolutions.net>
Message-ID: <20190916112430-mutt-send-email-mst@kernel.org>
References: <20190911134539.25650-1-johannes@sipsolutions.net>
 <20190911134539.25650-2-johannes@sipsolutions.net>
 <20190911095650-mutt-send-email-mst@kernel.org>
 <fedd74ed3e9cc554287b202e73b047a938515113.camel@sipsolutions.net>
 <674086baeed5fce100d0882e668d5e36f026bd71.camel@sipsolutions.net>
MIME-Version: 1.0
In-Reply-To: <674086baeed5fce100d0882e668d5e36f026bd71.camel@sipsolutions.net>
X-MC-Unique: bsBAAAMROqmoaS8AThI7RA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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

On Mon, Sep 16, 2019 at 01:40:35PM +0200, Johannes Berg wrote:
> Hi Michael,
>=20
> I had just wanted to prepare a resend, but
>=20
> > > Hmm I don't like this. I propose that with VHOST_USER_PROTOCOL_F_IN_B=
AND_NOTIFICATIONS
> > > we just don't allow VHOST_USER_SET_VRING_CALL (if you think it's
> > > important to allow them, we can say that we do not require them).
> >=20
> > You can't actually skip SET_VRING_CALL, it's necessary to start a vring=
,
> > so libvhost-user for example calls dev->iface->queue_set_started() only
> > in this case. The docs in the "Starting and stopping rings" section als=
o
> > explain this.
>=20
> [...]
>=20
> > See above. But I guess we could put a flag into bit 9 indicating that
> > you want to use messages instead of polling or a file descriptor, if yo=
u
> > prefer.
>=20
> Personally, I don't think it matters since right now I can see the in-
> band notification as being really necessary/useful only for simulation
> work, and in that case no polling will be doable.
>=20
> If you do think it's important to not make the two mutually exclusive,
> how would you prefer to have this handled? With a new flag, e.g. in bit
> 9, indicating "use inband signalling instead of polling or eventfd"?
>=20
> Thanks,
> johannes


So first we really need to fix up Starting and stopping section,
explaining that if the FD is invalid, this means ring
is immediately started, right?

If we want to keep it simple, my proposal is this, if
VHOST_USER_PROTOCOL_F_IN_BAND_NOTIFICATIONS is set then
VHOST_USER_SET_VRING_CALL and VHOST_USER_SET_VRING_KICK are not valid.
Starting/stopping ring needs to be updated, teaching it
that ring is started after it gets a kick.


--=20
MST


