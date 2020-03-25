Return-Path: <SRS0=PjAl=5K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BB92C2D0E5
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 17:52:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0BDE6206F6
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 17:52:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n8xt9PxO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BDE6206F6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40988 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHACl-0005I0-8e
	for qemu-devel@archiver.kernel.org; Wed, 25 Mar 2020 13:52:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36777)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <marcandre.lureau@gmail.com>) id 1jHABI-0003Wn-5f
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 13:51:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcandre.lureau@gmail.com>) id 1jHABH-0005rS-3V
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 13:51:08 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:37820)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
 id 1jHABG-0005oJ-RX
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 13:51:07 -0400
Received: by mail-wr1-x443.google.com with SMTP id w10so4329600wrm.4
 for <qemu-devel@nongnu.org>; Wed, 25 Mar 2020 10:51:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=aYAwwKy/XtE7/Ffsjr6wvOgND+OzslD5i1Pl4UFdyFY=;
 b=n8xt9PxOn+uil/nxbkWHfhGLR/PBtFZqGM3hYYA1YXna8YmVzv0scWB/wAOk96C1jw
 Gu3Hw+KRDcJAOQWU9es2YSOV3r3F6a9G7yJOS/uAArHGzrVPPebnhUp84trN9Sz3f9oR
 uwh6mFIj0u3DCL1z0j9W5PiH0JS2lLsUjDpgX8qQCQpMxkpdpq1ychvoXn4201zjbpHM
 of5Ei2+AUp3IQY7AI8fvSI7bbBZFHRx+l13wHrVz/LBKPebUyfid3jVNq6Q6plyMDsD2
 yLqDhvbY2QeizHnodXFy5QwkNIVs4LXP1MazxFhTJ/uN46hTeO/4Cjq6/haIPwcvV+wf
 zhDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=aYAwwKy/XtE7/Ffsjr6wvOgND+OzslD5i1Pl4UFdyFY=;
 b=A94gnRndCSiYwpdVseyOU5e18dovpys3vUA6K9HMYP/hb0v8E4NA66p3GiKoj1eELZ
 UMR4hi82FiVA1XRGYYwymgqHnhwlA1iSx3+AjCv5E9OAtwDqCFzx/LW1zSfQrUHoscx+
 0afhOUOPTFdSyGotfsBte98OUjl8VB5TF7Uk+JaZQb3rVpfQOmT3rpeG2urntl+Vx5v4
 UOejxqLW+gi+YQgGDgwp7KOgVX4NEjhNXeaWKZmu7rpqCk6CzUGbE8dosA27qx/A2CwE
 ui0TfDeUNzkPfcnun13cOX7SST1/Hd7PHtGx20ltvVFgr7c2hYehz18a4nJGQ8hOcBp2
 3reg==
X-Gm-Message-State: ANhLgQ2Mm2AzCi18+5+DaJb2mZrSXw+kxf5Eq1C2+rjq09L6RHFi0jga
 Vvl5E0rcPJxfdimk/n47CkAp9Ap4T8H504aFOKQ=
X-Google-Smtp-Source: ADFU+vvz7I7r0BDPaJI+qgsdtn4fZegtCW4D/yD+MG0Kzq29hqMciR27LwAeUxg+M+iF9JWE7MwX9jEl53MJxkInOa4=
X-Received: by 2002:adf:ecc3:: with SMTP id s3mr4500458wro.32.1585158663836;
 Wed, 25 Mar 2020 10:51:03 -0700 (PDT)
MIME-Version: 1.0
References: <20200323112943.12010-1-philmd@redhat.com>
 <20200323112943.12010-3-philmd@redhat.com>
 <CAMxuvazGfXXz0tc4DJpRecW1CYdT5WGO=t7VbjS9hLqhC2rO8Q@mail.gmail.com>
In-Reply-To: <CAMxuvazGfXXz0tc4DJpRecW1CYdT5WGO=t7VbjS9hLqhC2rO8Q@mail.gmail.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Wed, 25 Mar 2020 18:50:51 +0100
Message-ID: <CAJ+F1CLwE7uBsryb2oRJH_4Mi_19XaxeSJUipD=M35W48Kz88g@mail.gmail.com>
Subject: Re: [PATCH-for-5.0 2/3] virtio: Document virtqueue_pop()
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Gerd Hoffmann <kraxel@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>, "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Mar 23, 2020 at 12:55 PM Marc-Andr=C3=A9 Lureau
<marcandre.lureau@redhat.com> wrote:
>
> On Mon, Mar 23, 2020 at 12:30 PM Philippe Mathieu-Daud=C3=A9
> <philmd@redhat.com> wrote:
> >
> > Document that virtqueue_pop() returned memory must be released
> > with free().
> >
> > Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>
> Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

nack, hw/virtio/virtio.c uses g_malloc

>
>
> > ---
> >  include/hw/virtio/virtio.h | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> >
> > diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
> > index b69d517496..c6e3bfc500 100644
> > --- a/include/hw/virtio/virtio.h
> > +++ b/include/hw/virtio/virtio.h
> > @@ -199,6 +199,14 @@ void virtqueue_fill(VirtQueue *vq, const VirtQueue=
Element *elem,
> >                      unsigned int len, unsigned int idx);
> >
> >  void virtqueue_map(VirtIODevice *vdev, VirtQueueElement *elem);
> > +/**
> > + * virtqueue_pop:
> > + * @vq: a VirtQueue queue
> > + * @sz: the size of struct to return (must be >=3D VirtQueueElement)
> > + *
> > + * Returns: a VirtQueueElement filled from the queue or NULL.
> > + * The returned element must be free()-d by the caller.
> > + */
> >  void *virtqueue_pop(VirtQueue *vq, size_t sz);
> >  unsigned int virtqueue_drop_all(VirtQueue *vq);
> >  void *qemu_get_virtqueue_element(VirtIODevice *vdev, QEMUFile *f, size=
_t sz);
> > --
> > 2.21.1
> >
>
>


--=20
Marc-Andr=C3=A9 Lureau

