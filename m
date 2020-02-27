Return-Path: <SRS0=0TZc=4P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A926BC4BA24
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 11:21:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 782FE222C2
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 11:21:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PmFNHIjL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 782FE222C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57526 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7HDz-0001K5-J7
	for qemu-devel@archiver.kernel.org; Thu, 27 Feb 2020 06:21:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35742)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1j7HDB-0000hX-8m
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 06:20:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1j7HDA-0002cl-4s
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 06:20:13 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:47636
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1j7HDA-0002am-0u
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 06:20:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582802411;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=M3SeBZIM5TXGlI8TVlyDZAIuzspUnIELJSeZ7XGUFhg=;
 b=PmFNHIjLHDWirLDA2mLGlhUAfEsAyf0f5l/IcT3Dk6ftBuL+NkiP68WDS4mfcflydGkpYq
 dOrH5hmzAy4RXbOOmFRDRQ2eQ7im8t4CA/d+qkUNIR4pTqiAW9LT5Y1G9+noW8v0BxpXrj
 b8kVODwltuv9rSNCjdWEOdw/DNy+PQQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-204-7oYPP2EUOq2PtxXx4fgbFw-1; Thu, 27 Feb 2020 06:20:07 -0500
X-MC-Unique: 7oYPP2EUOq2PtxXx4fgbFw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C8B3EDBB0;
 Thu, 27 Feb 2020 11:20:06 +0000 (UTC)
Received: from linux.fritz.box (unknown [10.36.118.7])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id CE2E690CC8;
 Thu, 27 Feb 2020 11:20:00 +0000 (UTC)
Date: Thu, 27 Feb 2020 12:19:58 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>
Subject: Re: [PATCH v4 0/5] vhost-user block device backend implementation
Message-ID: <20200227111958.GD7493@linux.fritz.box>
References: <20200218050711.8133-1-coiby.xu@gmail.com>
 <20200219163815.GD1085125@stefanha-x1.localdomain>
 <CAJAkqrXaqmT2pR4K1x06AeQZHvUWp-fcqnbKZq_45czO96v5PA@mail.gmail.com>
 <20200227074114.GB83512@stefanha-x1.localdomain>
 <CAJAkqrWUJWLdT+6b_XmHFwnzhhbYei2SakCKVW0Rf92HJgoZDw@mail.gmail.com>
 <20200227100206.GA7493@linux.fritz.box>
 <CAJAkqrW_Euur3HjWaK6E-TAjT1dmjA1fz1oPwKSt7_pOC3=S+w@mail.gmail.com>
 <20200227105528.GC7493@linux.fritz.box>
 <CAMxuvay1vLosHTpXP7b3pXQvfRPOMp0z3ML66khLSrK-iLf7aQ@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAMxuvay1vLosHTpXP7b3pXQvfRPOMp0z3ML66khLSrK-iLf7aQ@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: bharatlkmlkvm@gmail.com, Stefan Hajnoczi <stefanha@redhat.com>,
 Coiby Xu <coiby.xu@gmail.com>, qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 27.02.2020 um 12:07 hat Marc-Andr=E9 Lureau geschrieben:
> On Thu, Feb 27, 2020 at 11:55 AM Kevin Wolf <kwolf@redhat.com> wrote:
> > Am 27.02.2020 um 11:28 hat Coiby Xu geschrieben:
> > > > > we still need customized vu_message_read because libvhost-user as=
sumes
> > > > > we will always get a full-size VhostUserMsg and hasn't taken care=
 of
> > > > > this short read case. I will improve libvhost-user's vu_message_r=
ead
> > > > > by making it keep reading from socket util getting enough bytes. =
I
> > > > > assume short read is a rare case thus introduced performance pena=
lty
> > > > > would be negligible.
> > >
> > > > In any case, please make sure that we use the QIOChannel functions
> > > > called from a coroutine in QEMU so that it will never block, but th=
e
> > > > coroutine can just yield while it's waiting for more bytes.
> > >
> > > But if I am not wrong, libvhost-user is supposed to be indepdent from
> > > the main QEMU code. So it can't use the QIOChannel functions if we
> > > simply modify exiting vu_message_read to address the short read issue=
.
> > > In v3 & v4, I extended libvhost-user to allow vu_message_read to be
> > > replaced by one which will depend on the main QEMU code. I'm not sure
> > > which way is better.
> >
> > The way your latest patches have it, with a separate read function,
> > works for me.
>=20
> Done right, I am not against it, fwiw
>=20
> > You could probably change libvhost-user to reimplement the same
> > functionality, and it might be an improvement for other users of the
> > library, but it's also code duplication and doesn't provide more value
> > in the context of the vhost-user export in QEMU.
> >
> > The point that's really important to me is just that we never block whe=
n
> > we run inside QEMU because that would actually stall the guest. This
> > means busy waiting in a tight loop until read() returns enough bytes is
> > not acceptable in QEMU.
>=20
> In the context of vhost-user, local unix sockets with short messages
> (do we have >1k messages?), I am not sure if this is really a problem.

I'm not sure how much of a problem it is in practice, and whether we
can consider the vhost-user client trusted. But using QIOChannel from
within a coroutine just avoids the problem completely, so it feels like
a natural choice to just do that.

> And isn't it possible to run libvhost-user in its own thread for this
> series?

You need to run the actual block I/O requests in the iothread where the
block device happens to run. So if you move the message processing to a
separate thread, you would have to communicate between threads for the
actual request processing. Possible, but probably slower than necessary
and certainly more complex.

Kevin


