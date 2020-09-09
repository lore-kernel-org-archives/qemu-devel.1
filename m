Return-Path: <SRS0=UKTp=CS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9EF4C433E2
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 04:47:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D66121D43
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 04:47:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qzi3o7+7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D66121D43
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58284 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFs0b-00044g-Do
	for qemu-devel@archiver.kernel.org; Wed, 09 Sep 2020 00:47:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51442)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liq3ea@gmail.com>) id 1kFrzy-0003eT-A6
 for qemu-devel@nongnu.org; Wed, 09 Sep 2020 00:46:22 -0400
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:36049)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <liq3ea@gmail.com>) id 1kFrzw-00059u-GM
 for qemu-devel@nongnu.org; Wed, 09 Sep 2020 00:46:21 -0400
Received: by mail-oi1-x241.google.com with SMTP id x19so1119839oix.3
 for <qemu-devel@nongnu.org>; Tue, 08 Sep 2020 21:46:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=ZwcCERn7UI2z/H0T1yeksqY1aFU21aynAIZo738IYPE=;
 b=qzi3o7+7OG5irqq+Apx3cVQ1XFP7bPkCNpdn3DxUyqfOJe0jIQ4yn2qnFgLEpX2+lt
 Efx1YHXfRH9CdFcQTSFnWs7pTVr2Oxm9HdEjOVAAVCOTLj1z+tUVFwbodl3z/YV8vsss
 yzK9ZzMDwHzDOTrLG52xYLAkHNIeFiz8h5E9JO2Hp9rLYekRng9UbKPHY/6XdlK3Df1H
 k1sYE/tt+aWUZUxiN6mr55lrBB9iDRsYWelREheM+NTR2lhMQf7LRtp0vDlwFTE5OytB
 nrqyjHxwrVGLxMDWrveFw3R9CZRVDwVBzf8fk6pz7+0XMCgkm7ntflhElROJHNMdYlAI
 NuSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=ZwcCERn7UI2z/H0T1yeksqY1aFU21aynAIZo738IYPE=;
 b=M+2F6x0cDJwUQBnT5asHVaIzNrzrUPZ2woCWibiiAp6BBMBYyzUF3ZXkEaGOlSbmDK
 l149KEirvzN539bbQ8O5Y+m8uzwgdrZLAFxxelW1HfUjqeGMbfd2YpJksZH6OSR2Wy+m
 KkRvskNy1X4xNw3iy18CkMDTP5HNjDiK6A3TsgBPUocpWMJV1EpRm2nYRXLi8IzeOmVh
 iZz5EGnviJFUblbpRCaP7QKv3xkqrWzytbvO8n4YFOsfwfW4K8wQdghJviWwt3yDKnOB
 Q97uv5HfJpjbtJf1d+yNo0xzY0IoXq9g4vqhKWXgr4mOnYNxHg4IPTNbEiAU1SqhEn+F
 KY5g==
X-Gm-Message-State: AOAM532FVeQwCdh5ENHMxBRedYPTg4qjd53a/9nYIQPqcOKf4DnHdOM1
 SpZqIDSj4x/vJbnG8Icq+jgPKQyPDcXGk1/W4ts=
X-Google-Smtp-Source: ABdhPJy4Fn7gZBDAh2o4vNXqWCBkXofLGC6EVW0xro1xsDK825BQGq8rJNJjxN2mtIUZx4lQo1aWXACczyj/qlAZcPw=
X-Received: by 2002:aca:b454:: with SMTP id d81mr1543084oif.150.1599626779339; 
 Tue, 08 Sep 2020 21:46:19 -0700 (PDT)
MIME-Version: 1.0
References: <20200908164157.47108-1-liq3ea@163.com>
 <20200908164157.47108-2-liq3ea@163.com>
 <48a99ece-d808-f860-2551-0fec05ec5b01@redhat.com>
In-Reply-To: <48a99ece-d808-f860-2551-0fec05ec5b01@redhat.com>
From: Li Qiang <liq3ea@gmail.com>
Date: Wed, 9 Sep 2020 12:45:43 +0800
Message-ID: <CAKXe6S+=s9D+EbQeb11f308VzrdCyTzXTLHqc6+ron5nE0ioUg@mail.gmail.com>
Subject: Re: [RFC 1/4] memory: add memory_region_init_io_with_dev interface
To: Jason Wang <jasowang@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::241;
 envelope-from=liq3ea@gmail.com; helo=mail-oi1-x241.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Li Qiang <liq3ea@163.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>,
 Qemu Developers <qemu-devel@nongnu.org>, Alexander Bulekov <alxndr@bu.edu>,
 Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Jason Wang <jasowang@redhat.com> =E4=BA=8E2020=E5=B9=B49=E6=9C=889=E6=97=A5=
=E5=91=A8=E4=B8=89 =E4=B8=8A=E5=8D=8810:16=E5=86=99=E9=81=93=EF=BC=9A
>
>
> On 2020/9/9 =E4=B8=8A=E5=8D=8812:41, Li Qiang wrote:
> > Currently the MR is not explicitly connecting with its device instead o=
f
> > a opaque. In most situation this opaque is the deivce but it is not an
> > enforcement. This patch adds a DeviceState member of to MemoryRegion
> > we will use it in later patch.
>
>
> I don't have a deep investigation. But I wonder whether we could make
> sure of owner instead of adding a new field here.

I have did some investigation.

void memory_region_init_io(MemoryRegion *mr,
struct Object *owner,
const MemoryRegionOps *ops,
void *opaque,
const char *name,
uint64_t size);


memory_region_init_io now mostly connects to the device with an opaque memb=
er.
But it has no guaranteen that this should be true. So we can't assume this.

The 'owner' is just in the 'object' context.

For the MR itself, MR may have sub-MR and alias. This will complicated
the issue.

As the device emulation and MR has a clear relation. I think add such
field is reasonable.


Thanks,
Li Qiang

>
> Thanks
>
>
> >
> > Signed-off-by: Li Qiang <liq3ea@163.com>
> > ---
> >   include/exec/memory.h |  9 +++++++++
> >   softmmu/memory.c      | 15 +++++++++++++++
> >   2 files changed, 24 insertions(+)
> >
> > diff --git a/include/exec/memory.h b/include/exec/memory.h
> > index 0cfe987ab4..620fb12d9b 100644
> > --- a/include/exec/memory.h
> > +++ b/include/exec/memory.h
> > @@ -404,6 +404,7 @@ struct MemoryRegion {
> >       const char *name;
> >       unsigned ioeventfd_nb;
> >       MemoryRegionIoeventfd *ioeventfds;
> > +    DeviceState *dev;
> >   };
> >
> >   struct IOMMUMemoryRegion {
> > @@ -794,6 +795,14 @@ void memory_region_init_io(MemoryRegion *mr,
> >                              const char *name,
> >                              uint64_t size);
> >
> > +void memory_region_init_io_with_dev(MemoryRegion *mr,
> > +                           struct Object *owner,
> > +                           const MemoryRegionOps *ops,
> > +                           void *opaque,
> > +                           const char *name,
> > +                           uint64_t size,
> > +                           DeviceState *dev);
> > +
> >   /**
> >    * memory_region_init_ram_nomigrate:  Initialize RAM memory region.  =
Accesses
> >    *                                    into the region will modify mem=
ory
> > diff --git a/softmmu/memory.c b/softmmu/memory.c
> > index 70b93104e8..2628c9d2d9 100644
> > --- a/softmmu/memory.c
> > +++ b/softmmu/memory.c
> > @@ -1490,6 +1490,21 @@ void memory_region_init_io(MemoryRegion *mr,
> >       mr->terminates =3D true;
> >   }
> >
> > +void memory_region_init_io_with_dev(MemoryRegion *mr,
> > +                           Object *owner,
> > +                           const MemoryRegionOps *ops,
> > +                           void *opaque,
> > +                           const char *name,
> > +                           uint64_t size,
> > +                           DeviceState *dev)
> > +{
> > +    memory_region_init(mr, owner, name, size);
> > +    mr->ops =3D ops ? ops : &unassigned_mem_ops;
> > +    mr->opaque =3D opaque;
> > +    mr->terminates =3D true;
> > +    mr->dev =3D dev;
> > +}
> > +
> >   void memory_region_init_ram_nomigrate(MemoryRegion *mr,
> >                                         Object *owner,
> >                                         const char *name,
>

