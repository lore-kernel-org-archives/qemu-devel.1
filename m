Return-Path: <SRS0=LSdK=2Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15BB8C2D0DA
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Dec 2019 09:30:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6EDCD206CB
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Dec 2019 09:30:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=daynix-com.20150623.gappssmtp.com header.i=@daynix-com.20150623.gappssmtp.com header.b="YqQepsn7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6EDCD206CB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52324 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ikPTl-0003y6-HM
	for qemu-devel@archiver.kernel.org; Thu, 26 Dec 2019 04:30:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52056)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <yuri.benditovich@daynix.com>) id 1ikPT3-0003PG-R8
 for qemu-devel@nongnu.org; Thu, 26 Dec 2019 04:30:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <yuri.benditovich@daynix.com>) id 1ikPT2-0001h8-Nq
 for qemu-devel@nongnu.org; Thu, 26 Dec 2019 04:30:05 -0500
Received: from mail-il1-x144.google.com ([2607:f8b0:4864:20::144]:45838)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <yuri.benditovich@daynix.com>)
 id 1ikPT2-0001gt-Cx
 for qemu-devel@nongnu.org; Thu, 26 Dec 2019 04:30:04 -0500
Received: by mail-il1-x144.google.com with SMTP id p8so19801560iln.12
 for <qemu-devel@nongnu.org>; Thu, 26 Dec 2019 01:30:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=xUvA+/4EVOCRpGy2oxEekavp8NWeREkrXoXZzG3WwLQ=;
 b=YqQepsn7l9ntMNckExfwvx2CRHq7LSlAUQvZBXPSQESiAOzyg+cfq6vblvLCCgM3WI
 z9zLakzu0IpW+F3UwL/8mIG3D1J2msFDAz/BgLWqvoUuw4j0WaSw4Ku6I3TXvJc/xtre
 LPPiuj7KDBgiVofK1Hl5h/pclXGyOVpQ/XUQHzCNANKHMQo/9BVHv+zxKEjCFRpiHtVb
 8I8faSO/A7EjGm4NYty2a5k+ODC0zAPoWjQhJuNJ+ugTakIDs0irsBg0PR4oTmJnN7Jr
 rWxaiMBpNpGEB3AJiMh61ULq5dyh1X1pMtC6RUzJxR8WntcVCbRBjHashAB8hGDabyNT
 nVuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=xUvA+/4EVOCRpGy2oxEekavp8NWeREkrXoXZzG3WwLQ=;
 b=KaeoAtGmhS1jIR9GzJvM5f6MseC4upUNFxtsmTP2QBuAWoVMUrajyW9/1J0t9FVZNG
 WC4TtB58Ai1tLrlfDxvDDZ52Phmz3jnjAAsaWjZNxgq8NUAAEgitBjZuUfYYGajjsTPQ
 BCa4ljk5NQa8ublN8r2/Yc96OGV+j+vKKeOooL6EaskmX9qpvP4cC5FRvw4oTu4um5rO
 BIz/RcfzkHJyOUPnIpQU2LypaRNlZWytWD+wH3zQWUcTj1Q8wwazgdg+CTBsGx1PPtnW
 HJVK7HsmoOr4tHUTOla5K0RUAO9K48ph8t902/KAZ0+RqeFE42CMhhuh8Lm5ZB/mAzkV
 5ZSQ==
X-Gm-Message-State: APjAAAVPIFEk3DxDn4Utv7uSn45T1nXbU9bdS1IM86EJK+XGGIHbiZKj
 YX1UYc0R0jsbct5ORAHrVr8ipnYQXSIIt0rvjQF1Xg==
X-Google-Smtp-Source: APXvYqzDf9XFqxgTs/J5pn9vi/55dUyyudVFuSecW796j92lHgv+q/epp9sSb8ZZv6CTNoswv4uMGA6OaVJwnJ77l6A=
X-Received: by 2002:a92:84dd:: with SMTP id y90mr34454748ilk.99.1577352603538; 
 Thu, 26 Dec 2019 01:30:03 -0800 (PST)
MIME-Version: 1.0
References: <20191226043649.14481-1-yuri.benditovich@daynix.com>
 <20191226043649.14481-2-yuri.benditovich@daynix.com>
 <05ead321-e93f-1b07-01cc-e0b023be8168@redhat.com>
In-Reply-To: <05ead321-e93f-1b07-01cc-e0b023be8168@redhat.com>
From: Yuri Benditovich <yuri.benditovich@daynix.com>
Date: Thu, 26 Dec 2019 11:29:50 +0200
Message-ID: <CAOEp5OdDj_=c_75FsM45iQnqDYBPz=Fn48FbR2FHcY=5D3rB-Q@mail.gmail.com>
Subject: Re: [PATCH 1/2] virtio: reset region cache when on queue deletion
To: Jason Wang <jasowang@redhat.com>, pbonzini@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::144
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
Cc: Yan Vugenfirer <yan@daynix.com>, qemu-devel@nongnu.org,
 "Michael S . Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Dec 26, 2019 at 10:58 AM Jason Wang <jasowang@redhat.com> wrote:
>
>
> On 2019/12/26 =E4=B8=8B=E5=8D=8812:36, Yuri Benditovich wrote:
> > https://bugzilla.redhat.com/show_bug.cgi?id=3D1708480
> > Fix leak of region reference that prevents complete
> > device deletion on hot unplug.
>
>
> More information is needed here, the bug said only q35 can meet this
> issue. What makes q35 different here?
>

I do not have any ready answer, I did not dig into it too much.
Probably Michael Tsirkin or Paolo Bonzini can answer without digging.

>
> >
> > Signed-off-by: Yuri Benditovich <yuri.benditovich@daynix.com>
> > ---
> >   hw/virtio/virtio.c | 5 +++++
> >   1 file changed, 5 insertions(+)
> >
> > diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
> > index 04716b5f6c..baadec8abc 100644
> > --- a/hw/virtio/virtio.c
> > +++ b/hw/virtio/virtio.c
> > @@ -2340,6 +2340,11 @@ void virtio_del_queue(VirtIODevice *vdev, int n)
> >       vdev->vq[n].vring.num_default =3D 0;
> >       vdev->vq[n].handle_output =3D NULL;
> >       vdev->vq[n].handle_aio_output =3D NULL;
> > +    /*
> > +     * with vring.num =3D 0 the queue will be ignored
> > +     * in later loops of region cache reset
> > +     */
>
>
> I can't get the meaning of this comment.
>
> Thanks
>
>
> > +    virtio_virtqueue_reset_region_cache(&vdev->vq[n]);
> >       g_free(vdev->vq[n].used_elems);
> >   }
> >
>

