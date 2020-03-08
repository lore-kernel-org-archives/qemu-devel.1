Return-Path: <SRS0=qQQb=4Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED9D5C10DCE
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Mar 2020 13:16:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B1EE3206D7
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Mar 2020 13:16:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K7RWBiKZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1EE3206D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57826 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jAvnG-0001Mt-S6
	for qemu-devel@archiver.kernel.org; Sun, 08 Mar 2020 09:16:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51655)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1jAvmQ-0000te-00
 for qemu-devel@nongnu.org; Sun, 08 Mar 2020 09:15:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1jAvmO-00039v-CX
 for qemu-devel@nongnu.org; Sun, 08 Mar 2020 09:15:41 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:52582
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1jAvmO-00039d-7H
 for qemu-devel@nongnu.org; Sun, 08 Mar 2020 09:15:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583673339;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Fd01nf7jK7I0TZycKbjC337An6cUtE/81cNvNppWi9M=;
 b=K7RWBiKZQp2rZ3/sOqfP0jVoP/EihwblwaIU3vzXmvlyzBzThfE4ID2TDZysoJgBq0asdo
 cubVgzygjYgcU/yfJWOv9rXQBTy3v8GMTkeXrlDU0lNYbt3DP8Dt4k1UPoQHu5bYilL69F
 KU9WTSNjIPdYrQySNpgNGymoFuPgB6k=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-343-g56LkEeyP5qPmG7mQ1Nt9Q-1; Sun, 08 Mar 2020 09:15:35 -0400
X-MC-Unique: g56LkEeyP5qPmG7mQ1Nt9Q-1
Received: by mail-qv1-f70.google.com with SMTP id k16so4973027qvj.7
 for <qemu-devel@nongnu.org>; Sun, 08 Mar 2020 06:15:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=mJRx+ZZGHkSVJ0drEXdv/7zzC+VXvFEV4y66Y+Pb8u8=;
 b=VXSYml6tx9zS5zyc/JH2II2LTImUtPo5lLXDgb3Jyzjv6x0nolD9MKHNssZjievuoR
 s9m59n0ny12pI2lEkYZBxOsQ67IuGVaq0mQjYEFqp4a6D7lYzx+XKUL8kMBMKLZD5kSt
 V16vwXDnSS7pXO9ukX6MZ460LFttKm2Nw592g2kTpXd6ZH+jJYkZjc5XYEf8f1FonwsB
 ApDpOzkEhSzSSyAQvDywLtxaIJbxxQLhqi9W3zyOTy2umdjwCtPSN9mGXeR/75LhPnI3
 YLIVxOpyAk7pSYP6bLKYhVgoCre/ZUSVhZvGy4pX0U+Q9awrKntgVzlCX/cfFC3kN2F9
 6mZw==
X-Gm-Message-State: ANhLgQ0bhTfhBokm43WJ0wUwiNc8FQPfdJ0u8LWfo5IQrpX69TuLT+xk
 GvhgOjjXmH2XQb/dP53gt32CX4BQy8x8iSGb5e+55YipQ+2/YNGoRySFlQ2dZqXrE/VQEQF9Hxx
 E+RKfjAsigZj7F54=
X-Received: by 2002:a37:4bd3:: with SMTP id y202mr11270043qka.32.1583673335330; 
 Sun, 08 Mar 2020 06:15:35 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vvPMr7iOatYWGe2x/Z0/EcktNnd7i5cEyrBAAjefZF1i7cYyXwxuuJOOoVGllKb4yRrJAlNbw==
X-Received: by 2002:a37:4bd3:: with SMTP id y202mr11270017qka.32.1583673334954; 
 Sun, 08 Mar 2020 06:15:34 -0700 (PDT)
Received: from redhat.com (bzq-79-178-2-19.red.bezeqint.net. [79.178.2.19])
 by smtp.gmail.com with ESMTPSA id w21sm22172303qth.17.2020.03.08.06.15.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 08 Mar 2020 06:15:33 -0700 (PDT)
Date: Sun, 8 Mar 2020 09:15:29 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Yuri Benditovich <yuri.benditovich@daynix.com>
Subject: Re: [PATCH 0/3] reference implementation of RSS
Message-ID: <20200308091326-mutt-send-email-mst@kernel.org>
References: <20200226174809.9675-1-yuri.benditovich@daynix.com>
 <87242152-5823-59a0-b0ce-2aa555559391@redhat.com>
 <CAOEp5OfPkQsWs=kYzwxHA0t_gv0iFb4OD6Wppde+qo42wr-eGg@mail.gmail.com>
 <20200308040540-mutt-send-email-mst@kernel.org>
 <CAOEp5OewvnX9zxidQ2Tp1FTH+V7HYhoCUrJ4hY3U6obSwnOysg@mail.gmail.com>
 <20200308081509-mutt-send-email-mst@kernel.org>
 <CAOEp5Oc1FPPcryoQZXso9_MEOSkfSrrguatEhL7AKk+WLvdWfg@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAOEp5Oc1FPPcryoQZXso9_MEOSkfSrrguatEhL7AKk+WLvdWfg@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: Yan Vugenfirer <yan@daynix.com>, marcandre.lureau@redhat.com,
 Jason Wang <jasowang@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, Mar 08, 2020 at 02:44:59PM +0200, Yuri Benditovich wrote:
> On Sun, Mar 8, 2020 at 2:17 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Sun, Mar 08, 2020 at 11:56:38AM +0200, Yuri Benditovich wrote:
> > > On Sun, Mar 8, 2020 at 10:06 AM Michael S. Tsirkin <mst@redhat.com> w=
rote:
> > > >
> > > > On Fri, Mar 06, 2020 at 11:50:30AM +0200, Yuri Benditovich wrote:
> > > > >
> > > > >
> > > > > On Fri, Mar 6, 2020 at 11:27 AM Jason Wang <jasowang@redhat.com> =
wrote:
> > > > >
> > > > >
> > > > >     On 2020/2/27 =E4=B8=8A=E5=8D=881:48, Yuri Benditovich wrote:
> > > > >     > Support for VIRTIO_NET_F_RSS feature in QEMU for reference
> > > > >     > purpose. Implements Toeplitz hash calculation for incoming
> > > > >     > packets according to configuration provided by driver.
> > > > >     >
> > > > >     > This series requires previously submitted and accepted
> > > > >     > patch to be applied:
> > > > >     > https://lists.gnu.org/archive/html/qemu-devel/2020-01/msg06=
448.html
> > > > >     >
> > > > >     > Yuri Benditovich (3):
> > > > >     >    virtio-net: introduce RSS RX steering feature
> > > > >     >    virtio-net: implement RSS configuration command
> > > > >     >    virtio-net: implement RX RSS processing
> > > > >     >
> > > > >     >   hw/net/trace-events                         |   3 +
> > > > >     >   hw/net/virtio-net.c                         | 234
> > > > >     +++++++++++++++++++-VIRTIO_NET_F_RSS
> > > > >     >   include/hw/virtio/virtio-net.h              |  12 +
> > > > >     >   include/standard-headers/linux/virtio_net.h |  37 +++-
> > > > >     >   4 files changed, 273 insertions(+), 13 deletions(-)
> > > > >     >
> > > > >
> > > > >     One question before the reviewing.
> > > > >
> > > > >     Do we need to deal with migration (which I think yes)?
> > > > >
> > > > >
> > > > > I think we don't (yet) as this is a reference implementation and =
the main goal
> > > > > is to provide the functional reference for hardware solution.
> > > >
> > > >
> > > > That's fine, but then we must block migration, and add appropriate =
code
> > > > comments. Just silently losing data isn't a good idea.
> > >
> > > Note that there is no data lost, just the configuration of RSS is not=
 migrating.
> > > So, qemu just will not redirect the data to different queues after mi=
gration.
> >
> > Right. Unlike auto-mq, the spec doesn't say the direction is best effor=
t though,
> > so that would be a spec violation.
> >
> > > I would add the migration prevention in the next series with
> > > implementation of hash delivery to prevent different packet sizes in
> > > driver and qemu.
> >
> > And hopefully full migration support will follow.
> >
> > One other thing to check is vhost - I didn't check
> > what happens with this patchset but
> > I think at a minimum we need to fail vhost init,
> > until the backend implements the feature biit.
>=20
> RSS feature currently is not indicated in case vhost is on.
> The same will be with hash report.

IIRC with vhost features not listed are assumed to be
implemented by qemu and not to need backend support.

Maybe we should change that to make things more robust
in the future ... Jason, Marc-Andr=C3=A9 am I right? what do you think?



> >
> >
> > > >
> > > > > I agree with the general direction that for complete support of R=
SS and hash
> > > > > delivery the best way is to do that in kernel using bpf.
> > > > > For that, IMO, the bpf should be a part of the kernel (it uses sk=
b fields) and
> > > > > the tap should receive just RSS parameters for it.
> > > > > At this stage we definitely will need to add migration support an=
d propagation
> > > > > of RSS parameters.
> > > > >
> > > > >
> > > > >
> > > > >     Thanks
> > > > >
> > > > >
> > > >
> >


