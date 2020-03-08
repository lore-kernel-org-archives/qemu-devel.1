Return-Path: <SRS0=qQQb=4Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95B4CC10DCE
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Mar 2020 09:57:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B37720828
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Mar 2020 09:57:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=daynix-com.20150623.gappssmtp.com header.i=@daynix-com.20150623.gappssmtp.com header.b="JvAq79yv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B37720828
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56518 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jAsgd-0003L6-Gf
	for qemu-devel@archiver.kernel.org; Sun, 08 Mar 2020 05:57:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58976)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <yuri.benditovich@daynix.com>) id 1jAsg2-0002vQ-9j
 for qemu-devel@nongnu.org; Sun, 08 Mar 2020 05:56:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <yuri.benditovich@daynix.com>) id 1jAsg1-000841-2w
 for qemu-devel@nongnu.org; Sun, 08 Mar 2020 05:56:54 -0400
Received: from mail-yw1-xc42.google.com ([2607:f8b0:4864:20::c42]:45516)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <yuri.benditovich@daynix.com>)
 id 1jAsg0-00083m-LE
 for qemu-devel@nongnu.org; Sun, 08 Mar 2020 05:56:53 -0400
Received: by mail-yw1-xc42.google.com with SMTP id d206so6963974ywa.12
 for <qemu-devel@nongnu.org>; Sun, 08 Mar 2020 01:56:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=5UawxOlJSyqEbUqOFFIbK1H2NB1PDkj0+Gu6zIf2T6Q=;
 b=JvAq79yv4xA0dpxmgvzLXdQJPdszQaAcUywiPqUvEBB/dIenMXRUMR716+ZsB7wbvk
 amLxyCfjrmkSFNKuOoXTLr+9qBUo1p8qF3Su49XRZLQUxekzge1W8kFfPptJQN/9RJZz
 n51K17K4SNEf9AXIIgaJdqvjW5DwMb5uOxybhsc6L2XV1IOWRVd5QVPYnHPZ9391THFd
 9m9QuvWW0sDQTlJPgiGilhAAFvOn9I8ZM/z4WUkIgV+WyL+uHuRS9l81mUl9FA6fcw92
 vdknxrufTpmWwfZwruLrvndnUWk7S3pAbYWcrRzrPAE+qqQkJMx2ho0/zVhIGKz7MoZz
 Ycpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=5UawxOlJSyqEbUqOFFIbK1H2NB1PDkj0+Gu6zIf2T6Q=;
 b=Gl2PrhJA2/BXSEDlgFIMRjCMECx3GvYePiygM+nIeptdfC9PfBFYDRA9DE8xQ0NBck
 KYAOXE5TAiGtYQGHkpugJd1oiDxFxDG9r0Sf/sInJLbvWZ30IBN2i0jxZCaf4tc7TWeB
 kp5Qxz545e++gJTkwYmOZG8/5rRsAvZpyRi+W5OLwzCgjOlL2ARJgf57F0nNd7G46BSY
 LvNZjzS/8Adbb1HY7YYclpgMYEsJs2iklu7fEIeEn+52gu0o0CTrhdhxvc3CGoZH5A56
 hIrzpHwDx2VB8yNKholunjJw5JyaqRP0khIpWve4sgY3Vu+yeERR9Bu5X16GyxgkALo3
 hWrw==
X-Gm-Message-State: ANhLgQ06LJvrsTq4NC/30F7wxgXn+8BRD+hWXvdDPdgdVm/2MQ00wtei
 W6H5xC/12dDZRU92jiyG2dxMhMiu4OLqeaV67O2rGA==
X-Google-Smtp-Source: ADFU+vsZsQ0qqT7NsEx0W8Y4HP38nfFuKgQGXiwYque0Q4dKpecG8AoJdSX63rmt7KfIzNddZaGTmUzF5l/Ds/USt+g=
X-Received: by 2002:a5b:a8e:: with SMTP id h14mr89148ybq.48.1583661411337;
 Sun, 08 Mar 2020 01:56:51 -0800 (PST)
MIME-Version: 1.0
References: <20200226174809.9675-1-yuri.benditovich@daynix.com>
 <87242152-5823-59a0-b0ce-2aa555559391@redhat.com>
 <CAOEp5OfPkQsWs=kYzwxHA0t_gv0iFb4OD6Wppde+qo42wr-eGg@mail.gmail.com>
 <20200308040540-mutt-send-email-mst@kernel.org>
In-Reply-To: <20200308040540-mutt-send-email-mst@kernel.org>
From: Yuri Benditovich <yuri.benditovich@daynix.com>
Date: Sun, 8 Mar 2020 11:56:38 +0200
Message-ID: <CAOEp5OewvnX9zxidQ2Tp1FTH+V7HYhoCUrJ4hY3U6obSwnOysg@mail.gmail.com>
Subject: Re: [PATCH 0/3] reference implementation of RSS
To: "Michael S. Tsirkin" <mst@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::c42
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

On Sun, Mar 8, 2020 at 10:06 AM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Fri, Mar 06, 2020 at 11:50:30AM +0200, Yuri Benditovich wrote:
> >
> >
> > On Fri, Mar 6, 2020 at 11:27 AM Jason Wang <jasowang@redhat.com> wrote:
> >
> >
> >     On 2020/2/27 =E4=B8=8A=E5=8D=881:48, Yuri Benditovich wrote:
> >     > Support for VIRTIO_NET_F_RSS feature in QEMU for reference
> >     > purpose. Implements Toeplitz hash calculation for incoming
> >     > packets according to configuration provided by driver.
> >     >
> >     > This series requires previously submitted and accepted
> >     > patch to be applied:
> >     > https://lists.gnu.org/archive/html/qemu-devel/2020-01/msg06448.ht=
ml
> >     >
> >     > Yuri Benditovich (3):
> >     >    virtio-net: introduce RSS RX steering feature
> >     >    virtio-net: implement RSS configuration command
> >     >    virtio-net: implement RX RSS processing
> >     >
> >     >   hw/net/trace-events                         |   3 +
> >     >   hw/net/virtio-net.c                         | 234
> >     +++++++++++++++++++-VIRTIO_NET_F_RSS
> >     >   include/hw/virtio/virtio-net.h              |  12 +
> >     >   include/standard-headers/linux/virtio_net.h |  37 +++-
> >     >   4 files changed, 273 insertions(+), 13 deletions(-)
> >     >
> >
> >     One question before the reviewing.
> >
> >     Do we need to deal with migration (which I think yes)?
> >
> >
> > I think we don't (yet) as this is a reference implementation and the ma=
in goal
> > is to provide the functional reference for hardware solution.
>
>
> That's fine, but then we must block migration, and add appropriate code
> comments. Just silently losing data isn't a good idea.

Note that there is no data lost, just the configuration of RSS is not migra=
ting.
So, qemu just will not redirect the data to different queues after migratio=
n.
I would add the migration prevention in the next series with
implementation of hash delivery to prevent different packet sizes in
driver and qemu.

>
> > I agree with the general direction that for complete support of RSS and=
 hash
> > delivery the best way is to do that in kernel using bpf.
> > For that, IMO, the bpf should be a part of the kernel (it uses skb fiel=
ds) and
> > the tap should receive just RSS parameters for it.
> > At this stage we definitely will need to add migration support and prop=
agation
> > of RSS parameters.
> >
> >
> >
> >     Thanks
> >
> >
>

