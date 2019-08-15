Return-Path: <SRS0=gzPR=WL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFBF5C3A589
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2019 16:27:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4DCFF20578
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2019 16:27:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CRzV2U/V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DCFF20578
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44026 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hyIb3-0007mM-99
	for qemu-devel@archiver.kernel.org; Thu, 15 Aug 2019 12:27:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45990)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <u9012063@gmail.com>) id 1hyIa5-0007Jw-VD
 for qemu-devel@nongnu.org; Thu, 15 Aug 2019 12:26:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <u9012063@gmail.com>) id 1hyIa0-0006Rt-Bn
 for qemu-devel@nongnu.org; Thu, 15 Aug 2019 12:26:29 -0400
Received: from mail-qk1-x741.google.com ([2607:f8b0:4864:20::741]:33442)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <u9012063@gmail.com>) id 1hyIa0-0006Rj-5s
 for qemu-devel@nongnu.org; Thu, 15 Aug 2019 12:26:24 -0400
Received: by mail-qk1-x741.google.com with SMTP id w18so1589521qki.0
 for <qemu-devel@nongnu.org>; Thu, 15 Aug 2019 09:26:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=3YjRw1tIrnDLxfjgndrOp5OYARSPcK28XJu/AOGdzdo=;
 b=CRzV2U/VAPd89SrJFf4M6476gtVVNL4wtsiD+hgTWypwNNX0XLx59IJT6YqDM14DxL
 fTcwJ73MS74OMJ+siVdsOAFAJ/hRB80+jzGzO0exnYW5AlezM9WQy5MWNkUCCqk0eXNZ
 SOAEyPgodb4WaYZ/5dlARnw6Lo8u4IIRTayqFeeeBx88rnHX8tcOTBsBlvRo0f1nMCju
 SDF7qGLdQY5h7JQF8bKWYqdGL0fLIovf0/EDo3STGqF3E0UnEmTWyLycqxndayD+z7DF
 Stt0O9yizCt/CtoqbU/BdpMiiWuex7XUlG0/CxmFuGTOGprI6YF3A+365YSnwXZsf9Ha
 jJUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=3YjRw1tIrnDLxfjgndrOp5OYARSPcK28XJu/AOGdzdo=;
 b=szrIy/dCzm9ZkR7x5ZtFeIrc1Q/VbjG8Nmi3TlAak196YDO0vHVV6BI6E+gzRqQnOK
 0dUftdAgA0opoeTXcKNIwQMW0PhT3zf1gqN05vGKnARzD0d5fzM+AyWFjv/De7oTLc5b
 t2aOBwK1io1LCLLCNecy8X1KQ5EOJXIJkEuUCXt2QzxjJtYajil+2ZiOz97apj4mLKAu
 JRo/gYjahEluoBVce8oua2iKBork3LLbRbfHEIEAphoSHItIrkbLpkkvbVinuT/gEzg0
 EJUUe8mxg6Y3nt9nr7O4LeEc8OuKE+R11IDBoLIzzkE3NVwHn6vdSUqL97m6UgVC052O
 sTyw==
X-Gm-Message-State: APjAAAUfR5BsSF36Sdd13OAa2LsMjEioGj5l8DGipmLkXYDBzBv0XBj2
 kCb8o9Am/R3Pu4HQ2lgPelf82HZoD9YxS0w7WBo=
X-Google-Smtp-Source: APXvYqxB1G4QPhUXHhWCRa7XOCio/GuAKMNYoJT9DLPM2ebuyYKhgX086WollV0EklIx0la/Vjy3HLQoEE6O/b7Xh/s=
X-Received: by 2002:ae9:c30f:: with SMTP id n15mr4807296qkg.147.1565886383442; 
 Thu, 15 Aug 2019 09:26:23 -0700 (PDT)
MIME-Version: 1.0
References: <CALDO+SbRvSSW3OQimwVe59HcHqv0PPLwoAW6yGg_UOnzounPtQ@mail.gmail.com>
 <20190815140744.GE10996@stefanha-x1.localdomain>
In-Reply-To: <20190815140744.GE10996@stefanha-x1.localdomain>
From: William Tu <u9012063@gmail.com>
Date: Thu, 15 Aug 2019 09:25:45 -0700
Message-ID: <CALDO+SZXLvktEhJxL62b9vUuMw9RWj=wzvqpy==X1eDy_ZzSSw@mail.gmail.com>
To: Stefan Hajnoczi <stefanha@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::741
Subject: Re: [Qemu-devel] Question about libvhost-user and
 vhost-user-bridge.c
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
Cc: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org, mst@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Stefan,

Thanks for your reply.

On Thu, Aug 15, 2019 at 7:07 AM Stefan Hajnoczi <stefanha@gmail.com> wrote:
>
> On Wed, Aug 14, 2019 at 10:54:34AM -0700, William Tu wrote:
> > Hi,
> >
> > I'm using libvhost-user.a to write a vhost backend, in order to receive and
> > send packets from/to VMs from OVS. I started by reading the vhost-user-bridge.c.
> > I can now pass the initialization stage, seeing .queue_set_started get invoked.
> >
> > However, I am stuck at receiving the packet from VM.
> > So is it correct to do:
> > 1) check vu_queue_empty, started, and aval_bytes, if OK, then
>
> This step can be skipped because vu_queue_pop() returns NULL if there
> are no virtqueue elements available.
>
> > 2) elem = vu_queue_pop(&dev->vudev, vq, sizeof(VuVirtqElement));
> > 3) the packet payload should be at elem->in_sg->iov_base + hdrlen? or
> > at elem->out_sg?
>
> The driver->device buffers are elem->out_sg and the device->driver
> buffers are elem->in_sg.

OK, thanks. Then for vswitch to receive from qemu, I should check
device->driver.
>
> Device implementations must not make assumptions about the layout of
> out_sg and in_sg (e.g. you cannot assume that in_sg[0]->iov_len ==
> sizeof(struct virtio_net_hdr) and you must handle the case where
> in_sg[0]->iov_len == 1).

OK so I might need to copy to a single continuous buffer.

>
> > I tried to hex dump the iov_base, but the content doesn't look like
> > having a ethernet header. I saw in vubr_backend_recv_cb at vhost-user-bridge.c,
> > we're creating another iovec and recvmsg(vubr->backend_udp_sock, &msg, 0);
> > I don't think I have to create backend UDP sock, am I correct?
>
> Please see the VIRTIO specification for details of the virtio-net rx/tx
> virtqueue formats:
> https://docs.oasis-open.org/virtio/virtio/v1.1/cs01/virtio-v1.1-cs01.html#x1-2050006
>
> I think you may need to handle the struct virtio_net_hdr that comes
> before the Ethernet header.

Thank, will look at it.
William
>
> Stefan

