Return-Path: <SRS0=qQQb=4Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30A01C10DCE
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Mar 2020 12:18:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F11262084E
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Mar 2020 12:18:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Lu1h1cbk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F11262084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57440 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jAutH-0000jc-4R
	for qemu-devel@archiver.kernel.org; Sun, 08 Mar 2020 08:18:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45395)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1jAusd-0000IG-7S
 for qemu-devel@nongnu.org; Sun, 08 Mar 2020 08:18:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1jAusZ-0003kn-U1
 for qemu-devel@nongnu.org; Sun, 08 Mar 2020 08:18:01 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:46554
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1jAusZ-0003ke-NT
 for qemu-devel@nongnu.org; Sun, 08 Mar 2020 08:17:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583669878;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xv/lGL0FwDoI4ITkE+v8VTdGzu6alGDSlXWh9FhRhiw=;
 b=Lu1h1cbkqpZ9VMVFzStIO3gElqK/cdg4HrfUSFr+P+gbP1BcWvIMqIQZMKv3HLrdSr/WsP
 CB2aBHcmTKy8cTEVmNlEfV++UgrUuYRl5gsTlfMdlJVroSstLF4ycdZdtZvctYrxwZtstb
 sVBwGrd0lVBQzTvKDEJMWbXVjKq4vpg=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-406-1peQGePeMd2n0bDxpuoIlA-1; Sun, 08 Mar 2020 08:17:55 -0400
X-MC-Unique: 1peQGePeMd2n0bDxpuoIlA-1
Received: by mail-qt1-f199.google.com with SMTP id r19so4882110qtb.10
 for <qemu-devel@nongnu.org>; Sun, 08 Mar 2020 05:17:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=ZmjBBAPKtXDEcqlwn1BHM1yl6//yeHM3M224ogp6tOY=;
 b=lbkKFopQ9o1ObRJF9ZD40pubXmzrnFuCYMJ8foZLDR+PwlhHrAewi7SDoqnV3VM8eX
 sG9qY6kyat1akgesRFBbTLfH7zRpHoiLDGHqwUM+kecEHBHDsgDEOtO82Z1AI43zKx/6
 FjYc76PVolGjPqoTlFMNKaHaezUXiaSiIzcXchzlfXsG4aAMUtjRKk+hTm5rTbjQfs4x
 Yn7McgyX1dKq8jaKqUR66ToR2PnGbs7npaWfke5ltGwua4B3WggrATICEcxZQSVvJqC8
 M21yfJ9yX+D/kiGWTZR07hweWz/st91bfChZQS2dGTpvMPjueIAC2dbniB/PyVz1xkaf
 HclA==
X-Gm-Message-State: ANhLgQ0uKZxhgJ5hxuPGRN6d577Q4pCm7vGEUdjvYKi6Zu+LlhsOZgp6
 +wMH3Kr/OAhJtMTDTzRAhggnEhLGMra7oCRkT8y7/7keT8w6kxhO27XP2oDJ/GCi3/lUaXuyp/A
 kXvgB9MIGQaVfYv0=
X-Received: by 2002:ac8:5058:: with SMTP id h24mr10508260qtm.384.1583669874832; 
 Sun, 08 Mar 2020 05:17:54 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vs2xv+unjFb8Xf3e+LPOG8gnHOG8FZ8J2DpYWBxftNF0dQmpp6f0NRZyIKxUfCW0OuK5U0SfA==
X-Received: by 2002:ac8:5058:: with SMTP id h24mr10508244qtm.384.1583669874519; 
 Sun, 08 Mar 2020 05:17:54 -0700 (PDT)
Received: from redhat.com (bzq-79-178-2-19.red.bezeqint.net. [79.178.2.19])
 by smtp.gmail.com with ESMTPSA id 11sm21228306qkr.101.2020.03.08.05.17.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 08 Mar 2020 05:17:53 -0700 (PDT)
Date: Sun, 8 Mar 2020 08:17:48 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Yuri Benditovich <yuri.benditovich@daynix.com>
Subject: Re: [PATCH 0/3] reference implementation of RSS
Message-ID: <20200308081509-mutt-send-email-mst@kernel.org>
References: <20200226174809.9675-1-yuri.benditovich@daynix.com>
 <87242152-5823-59a0-b0ce-2aa555559391@redhat.com>
 <CAOEp5OfPkQsWs=kYzwxHA0t_gv0iFb4OD6Wppde+qo42wr-eGg@mail.gmail.com>
 <20200308040540-mutt-send-email-mst@kernel.org>
 <CAOEp5OewvnX9zxidQ2Tp1FTH+V7HYhoCUrJ4hY3U6obSwnOysg@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAOEp5OewvnX9zxidQ2Tp1FTH+V7HYhoCUrJ4hY3U6obSwnOysg@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: Yan Vugenfirer <yan@daynix.com>, Jason Wang <jasowang@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, Mar 08, 2020 at 11:56:38AM +0200, Yuri Benditovich wrote:
> On Sun, Mar 8, 2020 at 10:06 AM Michael S. Tsirkin <mst@redhat.com> wrote=
:
> >
> > On Fri, Mar 06, 2020 at 11:50:30AM +0200, Yuri Benditovich wrote:
> > >
> > >
> > > On Fri, Mar 6, 2020 at 11:27 AM Jason Wang <jasowang@redhat.com> wrot=
e:
> > >
> > >
> > >     On 2020/2/27 =E4=B8=8A=E5=8D=881:48, Yuri Benditovich wrote:
> > >     > Support for VIRTIO_NET_F_RSS feature in QEMU for reference
> > >     > purpose. Implements Toeplitz hash calculation for incoming
> > >     > packets according to configuration provided by driver.
> > >     >
> > >     > This series requires previously submitted and accepted
> > >     > patch to be applied:
> > >     > https://lists.gnu.org/archive/html/qemu-devel/2020-01/msg06448.=
html
> > >     >
> > >     > Yuri Benditovich (3):
> > >     >    virtio-net: introduce RSS RX steering feature
> > >     >    virtio-net: implement RSS configuration command
> > >     >    virtio-net: implement RX RSS processing
> > >     >
> > >     >   hw/net/trace-events                         |   3 +
> > >     >   hw/net/virtio-net.c                         | 234
> > >     +++++++++++++++++++-VIRTIO_NET_F_RSS
> > >     >   include/hw/virtio/virtio-net.h              |  12 +
> > >     >   include/standard-headers/linux/virtio_net.h |  37 +++-
> > >     >   4 files changed, 273 insertions(+), 13 deletions(-)
> > >     >
> > >
> > >     One question before the reviewing.
> > >
> > >     Do we need to deal with migration (which I think yes)?
> > >
> > >
> > > I think we don't (yet) as this is a reference implementation and the =
main goal
> > > is to provide the functional reference for hardware solution.
> >
> >
> > That's fine, but then we must block migration, and add appropriate code
> > comments. Just silently losing data isn't a good idea.
>=20
> Note that there is no data lost, just the configuration of RSS is not mig=
rating.
> So, qemu just will not redirect the data to different queues after migrat=
ion.

Right. Unlike auto-mq, the spec doesn't say the direction is best effort th=
ough,
so that would be a spec violation.

> I would add the migration prevention in the next series with
> implementation of hash delivery to prevent different packet sizes in
> driver and qemu.

And hopefully full migration support will follow.

One other thing to check is vhost - I didn't check
what happens with this patchset but
I think at a minimum we need to fail vhost init,
until the backend implements the feature biit.


> >
> > > I agree with the general direction that for complete support of RSS a=
nd hash
> > > delivery the best way is to do that in kernel using bpf.
> > > For that, IMO, the bpf should be a part of the kernel (it uses skb fi=
elds) and
> > > the tap should receive just RSS parameters for it.
> > > At this stage we definitely will need to add migration support and pr=
opagation
> > > of RSS parameters.
> > >
> > >
> > >
> > >     Thanks
> > >
> > >
> >


