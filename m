Return-Path: <SRS0=0TZc=4P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86E72C4BA24
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 11:08:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 525C62468E
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 11:08:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HAVpek4C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 525C62468E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57392 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7H1X-0003JT-IL
	for qemu-devel@archiver.kernel.org; Thu, 27 Feb 2020 06:08:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59375)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlureau@redhat.com>) id 1j7H0l-0002JJ-Lw
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 06:07:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlureau@redhat.com>) id 1j7H0k-0001kt-BO
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 06:07:23 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:30194
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1j7H0k-0001kf-7a
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 06:07:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582801641;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SRXLqtvlZeiksUIK4OEf7JHz7ugB3XqILj4VjqJjoWw=;
 b=HAVpek4Cik/dRgPuoCbGz4rGwJ/nL3JT+qa77BSTISnzkNj1vXWJF21QObiQbNNO1y3PBK
 R2PKz6jpeTPU2ZQFyd+TKKiLiUSCZnRpASWpsvisizwD7zJo6cFyCrSxRvsE3rge4TndhV
 FI+KcZDv1tdO2HNR5p0w+XTarv/m9Jo=
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-407-lAHI2lrYMLWPH3mnN3SFOQ-1; Thu, 27 Feb 2020 06:07:20 -0500
X-MC-Unique: lAHI2lrYMLWPH3mnN3SFOQ-1
Received: by mail-oi1-f200.google.com with SMTP id 16so1415308oii.18
 for <qemu-devel@nongnu.org>; Thu, 27 Feb 2020 03:07:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=caCayBLYYolZoWzJAxY3HmfphtPzX2QRgzfDdgCa3jw=;
 b=AE6MvNW9X3YRoS+hC++WrL5xo9kTn90737F1f+BIemgeY+JWofpNZ5htC+BSxFxe+Y
 fy7Zs+fzbD3crGccl+Cdk8rCzg3RL7u5DIfcjC7h0d7eRcY8EItxmH6tEI9jTB3OeZgQ
 LX1ufryKmPeLTli4EdMOAE5Ph8IVAGw6rC/38jUz9eB3ruqMCoL6Difpy47t65j4kEV5
 vgJ8aexzN4ERsE9raaow7vGxYsz99mZ/DnIOWvJcddhTVOgZC5Wa39NpoCk2XUkfLFjv
 NBy4dYcb157OixQHiIcNSbjmxukSycj6pAjxETf8luyR44Vg63y036IS183g3JM1nQfQ
 URaw==
X-Gm-Message-State: APjAAAXYTyVK6H7XGzzHVVdX5GUZUWF/zkWTkRA1/I3Eu+k3gxzLhip9
 F5Pm94umrITMa/9EO0Px8zDr1sjCZnKcTqxx5pj14BaRbobQ/xHBBiGEJmqej6OfADsQEOkz6T3
 2VlutaEcjcaH7JXV6xcGw0MhDCmdoGJc=
X-Received: by 2002:a05:6830:1447:: with SMTP id
 w7mr2694163otp.368.1582801638989; 
 Thu, 27 Feb 2020 03:07:18 -0800 (PST)
X-Google-Smtp-Source: APXvYqwk2oZoXC6ee1kfFj/8fZJXikn5durnkITYT/ztq/ImS+VDUZBtzd0YVHn43ammtUUc6WfSpQwQd3ZI19oJUPs=
X-Received: by 2002:a05:6830:1447:: with SMTP id
 w7mr2694131otp.368.1582801638574; 
 Thu, 27 Feb 2020 03:07:18 -0800 (PST)
MIME-Version: 1.0
References: <20200218050711.8133-1-coiby.xu@gmail.com>
 <20200219163815.GD1085125@stefanha-x1.localdomain>
 <CAJAkqrXaqmT2pR4K1x06AeQZHvUWp-fcqnbKZq_45czO96v5PA@mail.gmail.com>
 <20200227074114.GB83512@stefanha-x1.localdomain>
 <CAJAkqrWUJWLdT+6b_XmHFwnzhhbYei2SakCKVW0Rf92HJgoZDw@mail.gmail.com>
 <20200227100206.GA7493@linux.fritz.box>
 <CAJAkqrW_Euur3HjWaK6E-TAjT1dmjA1fz1oPwKSt7_pOC3=S+w@mail.gmail.com>
 <20200227105528.GC7493@linux.fritz.box>
In-Reply-To: <20200227105528.GC7493@linux.fritz.box>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Thu, 27 Feb 2020 12:07:07 +0100
Message-ID: <CAMxuvay1vLosHTpXP7b3pXQvfRPOMp0z3ML66khLSrK-iLf7aQ@mail.gmail.com>
Subject: Re: [PATCH v4 0/5] vhost-user block device backend implementation
To: Kevin Wolf <kwolf@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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

Hi

On Thu, Feb 27, 2020 at 11:55 AM Kevin Wolf <kwolf@redhat.com> wrote:
>
> Am 27.02.2020 um 11:28 hat Coiby Xu geschrieben:
> > > > we still need customized vu_message_read because libvhost-user assu=
mes
> > > > we will always get a full-size VhostUserMsg and hasn't taken care o=
f
> > > > this short read case. I will improve libvhost-user's vu_message_rea=
d
> > > > by making it keep reading from socket util getting enough bytes. I
> > > > assume short read is a rare case thus introduced performance penalt=
y
> > > > would be negligible.
> >
> > > In any case, please make sure that we use the QIOChannel functions
> > > called from a coroutine in QEMU so that it will never block, but the
> > > coroutine can just yield while it's waiting for more bytes.
> >
> > But if I am not wrong, libvhost-user is supposed to be indepdent from
> > the main QEMU code. So it can't use the QIOChannel functions if we
> > simply modify exiting vu_message_read to address the short read issue.
> > In v3 & v4, I extended libvhost-user to allow vu_message_read to be
> > replaced by one which will depend on the main QEMU code. I'm not sure
> > which way is better.
>
> The way your latest patches have it, with a separate read function,
> works for me.

Done right, I am not against it, fwiw

> You could probably change libvhost-user to reimplement the same
> functionality, and it might be an improvement for other users of the
> library, but it's also code duplication and doesn't provide more value
> in the context of the vhost-user export in QEMU.
>
> The point that's really important to me is just that we never block when
> we run inside QEMU because that would actually stall the guest. This
> means busy waiting in a tight loop until read() returns enough bytes is
> not acceptable in QEMU.

In the context of vhost-user, local unix sockets with short messages
(do we have >1k messages?), I am not sure if this is really a problem.

And isn't it possible to run libvhost-user in its own thread for this serie=
s?


>
> Kevin
>
> > On Thu, Feb 27, 2020 at 6:02 PM Kevin Wolf <kwolf@redhat.com> wrote:
> > >
> > > Am 27.02.2020 um 10:53 hat Coiby Xu geschrieben:
> > > > Thank you for reminding me of this socket short read issue! It seem=
s
> > > > we still need customized vu_message_read because libvhost-user assu=
mes
> > > > we will always get a full-size VhostUserMsg and hasn't taken care o=
f
> > > > this short read case. I will improve libvhost-user's vu_message_rea=
d
> > > > by making it keep reading from socket util getting enough bytes. I
> > > > assume short read is a rare case thus introduced performance penalt=
y
> > > > would be negligible.
> > >
> > > In any case, please make sure that we use the QIOChannel functions
> > > called from a coroutine in QEMU so that it will never block, but the
> > > coroutine can just yield while it's waiting for more bytes.
> > >
> > > Kevin
> > >
> > > > On Thu, Feb 27, 2020 at 3:41 PM Stefan Hajnoczi <stefanha@redhat.co=
m> wrote:
> > > > >
> > > > > On Wed, Feb 26, 2020 at 11:18:41PM +0800, Coiby Xu wrote:
> > > > > > Hi Stefan,
> > > > > >
> > > > > > Thank you for reviewing my code!
> > > > > >
> > > > > > I tried to reach you on IRC. But somehow either you missed my m=
essage
> > > > > > or I missed your reply. So I will reply by email instead.
> > > > > >
> > > > > > If we use qio_channel_set_aio_fd_handler to monitor G_IO_IN eve=
nt,
> > > > > > i.e. use vu_dispatch as the read handler, then we can re-use
> > > > > > vu_message_read. And "removing the blocking recv from libvhost-=
user"
> > > > > > isn't necessary because "the operation of poll() and ppoll() is=
 not
> > > > > > affected by the O_NONBLOCK flag" despite that we use
> > > > > > qio_channel_set_blocking before calling qio_channel_set_aio_fd_=
handler
> > > > > > to make recv non-blocking.
> > > > >
> > > > > I'm not sure I understand.  poll() just says whether the file des=
criptor
> > > > > is readable.  It does not say whether enough bytes are readable :=
).  So
> > > > > our callback will be invoked if there is 1 byte ready, but when w=
e try
> > > > > to read 20 bytes either it will block (without O_NONBLOCK) or ret=
urn
> > > > > only 1 byte (with O_NONBLOCK).  Neither case is okay, so I expect=
 that
> > > > > code changes will be necessary.
> > > > >
> > > > > But please go ahead and send the next revision and I'll take a lo=
ok.
> > > > >
> > > > > Stefan
> > > >
> > > >
> > > >
> > > > --
> > > > Best regards,
> > > > Coiby
> > > >
> > >
> >
> >
> > --
> > Best regards,
> > Coiby
> >
>


