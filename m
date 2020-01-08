Return-Path: <SRS0=peXq=25=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F78FC282DD
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 13:08:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2D4D1205F4
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 13:08:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BGN9M53t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D4D1205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43358 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipB4M-0002Uy-AZ
	for qemu-devel@archiver.kernel.org; Wed, 08 Jan 2020 08:08:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40738)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <marcandre.lureau@gmail.com>) id 1ipAmT-00022q-0R
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 07:49:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcandre.lureau@gmail.com>) id 1ipAmR-00075s-Sm
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 07:49:48 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:44367)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
 id 1ipAmR-00075P-Mg; Wed, 08 Jan 2020 07:49:47 -0500
Received: by mail-wr1-x444.google.com with SMTP id q10so3199335wrm.11;
 Wed, 08 Jan 2020 04:49:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=3nSD+C0NYHVQUPjtC1lGASSOIFia0uW6qYw+c8vOsn4=;
 b=BGN9M53tGhuMF6fDWSmj1k/v48RW30de8yl1VPgdX0avBfoh+bsPMEPyjjUtMCibjI
 9SmTLjQLrDwo+Q0FYUUkivgRKKTNuReLczEsU6ol4GgnkWqhWPK6s7hKIZ8ZSavRY+PQ
 WVQbx+Fj6OMg/+HkOCeAaDbtvbYIdfYhUHq8hH/qwqoJuXny6WxDEfB55iPtuPYaMuJj
 0DgLcd8CFmVas6fJRhkVRo85WlCI0lmqgUJpDopoouIj0AokHacsofVkGzbhB3I2czg0
 xaQ3cGOEish88LplLvBaLIzoFouyNg2PXYMsagshO/zAIPApG5s4Ldj743NecQqj28K9
 g9oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=3nSD+C0NYHVQUPjtC1lGASSOIFia0uW6qYw+c8vOsn4=;
 b=N7OuyDTxsA6dUWfoSq4LUUGZ94KvnF80RFWbQ6OeQE6tbpOqEf8owXfKbKXY8q7FNL
 Ed3DjGjmBMxvxXDHXrI/z9tkD3syQAh1v8jBZ4JkJA4N5jgBc0VIQOedf3xkNgrlU/wk
 VeJSuLUjy0RX0/tLBeUzWSMe7TzmSaeTTQnxiJ4yaXXNnMi/SmauxioL5xhpclcpGTMc
 jSyeHGVuocit6TCdeq6rOcyIEHt+ROHz3l2HHHkxS1up90h7zcafTLQ7TCLhr74L6ClJ
 LbUu+wA1op09+c7is9EIiJByviCbs4v+LGCjVC6iQdFkC1wn/5WqJCNjCJiWPrcl5Cs+
 KsWQ==
X-Gm-Message-State: APjAAAWTomFF0n4JFZ8u+FQWiGpH7+Wt65/N/eWSQxWyc7i32eHldtKY
 5ml6lAiViYq8GBz4u5soJm7d3Paf4fCWcV4h5DA=
X-Google-Smtp-Source: APXvYqyBjTYZB0nEeaunys2fOpuR6fD5TVjnWAWD2/QF9Wx8l3W5ZL07f4kshQgotmidHtKkab5J1XNZEk6kd52I+Is=
X-Received: by 2002:a5d:66c3:: with SMTP id k3mr4162674wrw.370.1578487786643; 
 Wed, 08 Jan 2020 04:49:46 -0800 (PST)
MIME-Version: 1.0
References: <20200103074000.1006389-1-marcandre.lureau@redhat.com>
 <20200103074000.1006389-3-marcandre.lureau@redhat.com>
 <20200103100233.GA3804@work-vm> <20200108112902.GB3184@work-vm>
In-Reply-To: <20200108112902.GB3184@work-vm>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Wed, 8 Jan 2020 16:49:32 +0400
Message-ID: <CAJ+F1CJp1rxiwZ30HCH43Yxw4QgUt5QEdyRk9Z3bWyZat1NMAA@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] tpm-ppi: page-align PPI RAM
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
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
Cc: Juan Quintela <quintela@redhat.com>, qemu-stable <qemu-stable@nongnu.org>,
 QEMU <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <rth@twiddle.net>, Stefan Berger <stefanb@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi

On Wed, Jan 8, 2020 at 3:29 PM Dr. David Alan Gilbert
<dgilbert@redhat.com> wrote:
>
> * Dr. David Alan Gilbert (dgilbert@redhat.com) wrote:
> > * Marc-Andr=C3=A9 Lureau (marcandre.lureau@redhat.com) wrote:
> > > post-copy migration fails on destination with error such as:
> > > 2019-12-26T10:22:44.714644Z qemu-kvm: ram_block_discard_range:
> > > Unaligned start address: 0x559d2afae9a0
> >
> > Ah good, we got a sane error message!
> >
> > > Use qemu_memalign() to constrain the PPI RAM memory alignment.
> > >
> > > Cc: qemu-stable@nongnu.org
> > > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > > Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> > > ---
> > >  hw/tpm/tpm_ppi.c | 3 ++-
> > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/hw/tpm/tpm_ppi.c b/hw/tpm/tpm_ppi.c
> > > index ff314592b4..6d9c1a3e40 100644
> > > --- a/hw/tpm/tpm_ppi.c
> > > +++ b/hw/tpm/tpm_ppi.c
> > > @@ -43,7 +43,8 @@ void tpm_ppi_reset(TPMPPI *tpmppi)
> > >  void tpm_ppi_init(TPMPPI *tpmppi, struct MemoryRegion *m,
> > >                    hwaddr addr, Object *obj)
> > >  {
> > > -    tpmppi->buf =3D g_malloc0(HOST_PAGE_ALIGN(TPM_PPI_ADDR_SIZE));
> > > +    tpmppi->buf =3D qemu_memalign(qemu_real_host_page_size,
> > > +                                HOST_PAGE_ALIGN(TPM_PPI_ADDR_SIZE));
> >
> > Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
>
> I just noticed a bit in the CODING_STYLE that says:
>
>   Memory allocated by qemu_memalign or qemu_blockalign must be freed with
>   qemu_vfree, since breaking this will cause problems on Win32.
>
> so I guess this is wrong?

The buf is not freed, TPM are not hotpluggable. For strictness, we
could have a finalize later.

>
> Dave
>
> >
> > >      memory_region_init_ram_device_ptr(&tpmppi->ram, obj, "tpm-ppi",
> > >                                        TPM_PPI_ADDR_SIZE, tpmppi->buf=
);
> > >      vmstate_register_ram(&tpmppi->ram, DEVICE(obj));
> > > --
> > > 2.24.0.308.g228f53135a
> > >
> > --
> > Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
>
>


--=20
Marc-Andr=C3=A9 Lureau

