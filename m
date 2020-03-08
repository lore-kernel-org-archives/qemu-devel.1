Return-Path: <SRS0=qQQb=4Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C06A7C10DCE
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Mar 2020 12:46:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8595920828
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Mar 2020 12:46:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=daynix-com.20150623.gappssmtp.com header.i=@daynix-com.20150623.gappssmtp.com header.b="AQuKr93z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8595920828
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57602 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jAvKC-0004qb-5b
	for qemu-devel@archiver.kernel.org; Sun, 08 Mar 2020 08:46:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47860)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <yuri.benditovich@daynix.com>) id 1jAvIv-0004KJ-GD
 for qemu-devel@nongnu.org; Sun, 08 Mar 2020 08:45:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <yuri.benditovich@daynix.com>) id 1jAvIt-0008PE-Vq
 for qemu-devel@nongnu.org; Sun, 08 Mar 2020 08:45:13 -0400
Received: from mail-yw1-xc44.google.com ([2607:f8b0:4864:20::c44]:45651)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <yuri.benditovich@daynix.com>)
 id 1jAvIt-0008NS-Fo
 for qemu-devel@nongnu.org; Sun, 08 Mar 2020 08:45:11 -0400
Received: by mail-yw1-xc44.google.com with SMTP id d206so7190664ywa.12
 for <qemu-devel@nongnu.org>; Sun, 08 Mar 2020 05:45:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=+VtdiC8Gz5Ney2aPSyk1ppvtnz2b+scipmsXzrQKb/s=;
 b=AQuKr93zJwd8Ua6GjAHCK+QIQjrlpzuDOZjD4OIgq5MKaan10FU+1SYqvFLTFPLWWN
 3jiBS1qOGg8kuE2xJcFEXHtnpLCv1hTLJR7zlhRw2BIyrUwLU5TSqz5tKN7V5qystpKG
 601VEGB9uwwyyjE7zKGYOGF/5XEVNowGCwvM1wFbjUi6uMFJnEHT+8Zdya7xkKDJ0cPq
 Phc6qs2IB3fXssHyzc/z9gQuQ+Ko3ZCi+8ag8AuyADhB9ByB0zb4Q6TgZW6FGlyzQcui
 CWchl4PbXKfw898rmvChlRVg9W+iPgLseA+X5o1ekjCSaz3PDB8ixAj+WKSZS2HXClwT
 UUwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=+VtdiC8Gz5Ney2aPSyk1ppvtnz2b+scipmsXzrQKb/s=;
 b=pDVnKze1oVXhfZTBvF0EOpwdFASQjig8RH5oX8SH8ENPzvcJEim6beRaRPFMWQEWO2
 IKBHlr9WxeGn9lKOBhN+G368HnMVZyhigc78NXob8r45kHGGYdqqqxr5EyVFyoU/Bj82
 dUHN9Ya170Wo2YvXKgOWVsrAtgMqACpBmsxLhstdIecwnQ0holorHgkAlQilxJ/aSjgG
 hELrqkNsMTZbN5iH9TE9WYHoLXZFgYYLGkcBkfHEE8trThL4QeshSzl5z1r1X7GKxo58
 46D3OHqDX97zjbzd3XAnT6T5DXtsZWilXVT5zuvWsxs4SxregpNLUu+kq1aS5K3zCRuh
 Kjjw==
X-Gm-Message-State: ANhLgQ0+U7y+J5XojOf7TgswmqMpUs8orXQD62njp4H4bKqphrTiL1d1
 GsN/IatrZSfzwpFSyJ0gU574iB1PiosIhvIOxjAU6g==
X-Google-Smtp-Source: ADFU+vstPV5nSYYxXF8E2OFed7gcblb+owOclW5IY0UrcgWV1/+byhmJHLmaf3WOhmnyFwg0tNckAWaUEcp+Yeh1wSE=
X-Received: by 2002:a25:ba89:: with SMTP id s9mr12560556ybg.265.1583671510240; 
 Sun, 08 Mar 2020 05:45:10 -0700 (PDT)
MIME-Version: 1.0
References: <20200226174809.9675-1-yuri.benditovich@daynix.com>
 <87242152-5823-59a0-b0ce-2aa555559391@redhat.com>
 <CAOEp5OfPkQsWs=kYzwxHA0t_gv0iFb4OD6Wppde+qo42wr-eGg@mail.gmail.com>
 <20200308040540-mutt-send-email-mst@kernel.org>
 <CAOEp5OewvnX9zxidQ2Tp1FTH+V7HYhoCUrJ4hY3U6obSwnOysg@mail.gmail.com>
 <20200308081509-mutt-send-email-mst@kernel.org>
In-Reply-To: <20200308081509-mutt-send-email-mst@kernel.org>
From: Yuri Benditovich <yuri.benditovich@daynix.com>
Date: Sun, 8 Mar 2020 14:44:59 +0200
Message-ID: <CAOEp5Oc1FPPcryoQZXso9_MEOSkfSrrguatEhL7AKk+WLvdWfg@mail.gmail.com>
Subject: Re: [PATCH 0/3] reference implementation of RSS
To: "Michael S. Tsirkin" <mst@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::c44
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

On Sun, Mar 8, 2020 at 2:17 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Sun, Mar 08, 2020 at 11:56:38AM +0200, Yuri Benditovich wrote:
> > On Sun, Mar 8, 2020 at 10:06 AM Michael S. Tsirkin <mst@redhat.com> wro=
te:
> > >
> > > On Fri, Mar 06, 2020 at 11:50:30AM +0200, Yuri Benditovich wrote:
> > > >
> > > >
> > > > On Fri, Mar 6, 2020 at 11:27 AM Jason Wang <jasowang@redhat.com> wr=
ote:
> > > >
> > > >
> > > >     On 2020/2/27 =E4=B8=8A=E5=8D=881:48, Yuri Benditovich wrote:
> > > >     > Support for VIRTIO_NET_F_RSS feature in QEMU for reference
> > > >     > purpose. Implements Toeplitz hash calculation for incoming
> > > >     > packets according to configuration provided by driver.
> > > >     >
> > > >     > This series requires previously submitted and accepted
> > > >     > patch to be applied:
> > > >     > https://lists.gnu.org/archive/html/qemu-devel/2020-01/msg0644=
8.html
> > > >     >
> > > >     > Yuri Benditovich (3):
> > > >     >    virtio-net: introduce RSS RX steering feature
> > > >     >    virtio-net: implement RSS configuration command
> > > >     >    virtio-net: implement RX RSS processing
> > > >     >
> > > >     >   hw/net/trace-events                         |   3 +
> > > >     >   hw/net/virtio-net.c                         | 234
> > > >     +++++++++++++++++++-VIRTIO_NET_F_RSS
> > > >     >   include/hw/virtio/virtio-net.h              |  12 +
> > > >     >   include/standard-headers/linux/virtio_net.h |  37 +++-
> > > >     >   4 files changed, 273 insertions(+), 13 deletions(-)
> > > >     >
> > > >
> > > >     One question before the reviewing.
> > > >
> > > >     Do we need to deal with migration (which I think yes)?
> > > >
> > > >
> > > > I think we don't (yet) as this is a reference implementation and th=
e main goal
> > > > is to provide the functional reference for hardware solution.
> > >
> > >
> > > That's fine, but then we must block migration, and add appropriate co=
de
> > > comments. Just silently losing data isn't a good idea.
> >
> > Note that there is no data lost, just the configuration of RSS is not m=
igrating.
> > So, qemu just will not redirect the data to different queues after migr=
ation.
>
> Right. Unlike auto-mq, the spec doesn't say the direction is best effort =
though,
> so that would be a spec violation.
>
> > I would add the migration prevention in the next series with
> > implementation of hash delivery to prevent different packet sizes in
> > driver and qemu.
>
> And hopefully full migration support will follow.
>
> One other thing to check is vhost - I didn't check
> what happens with this patchset but
> I think at a minimum we need to fail vhost init,
> until the backend implements the feature biit.

RSS feature currently is not indicated in case vhost is on.
The same will be with hash report.

>
>
> > >
> > > > I agree with the general direction that for complete support of RSS=
 and hash
> > > > delivery the best way is to do that in kernel using bpf.
> > > > For that, IMO, the bpf should be a part of the kernel (it uses skb =
fields) and
> > > > the tap should receive just RSS parameters for it.
> > > > At this stage we definitely will need to add migration support and =
propagation
> > > > of RSS parameters.
> > > >
> > > >
> > > >
> > > >     Thanks
> > > >
> > > >
> > >
>

