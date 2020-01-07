Return-Path: <SRS0=ZO09=24=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C158C33C99
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 11:26:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 451632077B
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 11:26:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CO5U1eik"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 451632077B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46836 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ion0I-00038T-Vm
	for qemu-devel@archiver.kernel.org; Tue, 07 Jan 2020 06:26:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51755)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1iolv6-0002Xj-Ox
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 05:17:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1iolv5-0000f6-Hp
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 05:17:04 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:23562
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1iolv5-0000e4-EH
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 05:17:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578392220;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=r0STccT34N5ItZUau0wV7rkrChafV6uF8AHjbxz8uDo=;
 b=CO5U1eikPVb7EFQ0A4fqnYzZndFcalxwjsLPlQgj+ypKYYz4LvBpXl3RI6WV+Bo8EubaE8
 IE4HSbb7ot+AJ39HB2pDdrr+hXs6Vd/tAkfDfD1Dr0gwBOpOm+M1r3F4x/8vxBU8yjBKFt
 s9RbwEhMyG77nNzr05m9G5qsTaufMEE=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-140-QMog8vdTOUCeS9rGsXRnYg-1; Tue, 07 Jan 2020 05:16:57 -0500
Received: by mail-qv1-f72.google.com with SMTP id a14so36435466qvy.23
 for <qemu-devel@nongnu.org>; Tue, 07 Jan 2020 02:16:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=jrNrFq9JK+WaKWHqHJCTbQFCSaUv5W5458tjcRcsmzI=;
 b=tFoBBWW8svH8DjMRFazl98TqW5nE5VzReJ+4QaDCZb7P+vXzz49PlNaBXCDSxmHKCP
 2JVCR3/Xdm1iOSHDsNzImgY9JYwyLEYVJaXH6POtcIiF4Q0OnlWra98Gak/h31VWG6gl
 vpSCOir16RF3xvYX3URfWkQt0WNGfNz6urYzy8CXU8UPcOpkWy7cXBOtwY58tTvOMrj1
 irpDmvRLcribU0sVYRCHpMtBWxY+rbIHv7lVkjkJZhx8Vp2HopNrDhyreSDpWBEfOc3U
 ZxL+W8o4GVeehpLvT0BJiySb1xkYpxF8jKt8Mrs4Zq1HUOJY3glVgkwF4MR84Sk8T56m
 EHBw==
X-Gm-Message-State: APjAAAUrSKw40/CzXh3dartuR02b2HfIVwU54yFqa1AO26IM89mp+vK0
 9bl1aXXCfeySffQYvyVEiDCIpw0pPawYmyaJN8a85pwwEUBzvsws3LwPrdxnuvsUq/C4bXT4haS
 8GnrWF/sp8zJqVdc=
X-Received: by 2002:ac8:490f:: with SMTP id e15mr75237237qtq.32.1578392217319; 
 Tue, 07 Jan 2020 02:16:57 -0800 (PST)
X-Google-Smtp-Source: APXvYqzpBJu26VfvSGGIDbo6xpmHXHitA1zey7jV85qJWgBsTG6wxTM46ZRSYcCob1v0ClC4LFaA1A==
X-Received: by 2002:ac8:490f:: with SMTP id e15mr75237216qtq.32.1578392217144; 
 Tue, 07 Jan 2020 02:16:57 -0800 (PST)
Received: from redhat.com (bzq-79-183-34-164.red.bezeqint.net. [79.183.34.164])
 by smtp.gmail.com with ESMTPSA id i4sm22127480qki.45.2020.01.07.02.16.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jan 2020 02:16:55 -0800 (PST)
Date: Tue, 7 Jan 2020 05:16:49 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 04/14] hw/i386: Restrict fw_cfg to the PC machines
Message-ID: <20200107050921-mutt-send-email-mst@kernel.org>
References: <20191231183216.6781-1-philmd@redhat.com>
 <20191231183216.6781-5-philmd@redhat.com>
 <a5ba0619-e236-7fb0-8c17-028670b69501@redhat.com>
MIME-Version: 1.0
In-Reply-To: <a5ba0619-e236-7fb0-8c17-028670b69501@redhat.com>
X-MC-Unique: QMog8vdTOUCeS9rGsXRnYg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
Cc: Fam Zheng <fam@euphon.net>, Eduardo Habkost <ehabkost@redhat.com>,
 Sergio Lopez <slp@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Aleksandar Markovic <amarkovic@wavecomp.com>, qemu-ppc@nongnu.org,
 Gerd Hoffmann <kraxel@redhat.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Jan 07, 2020 at 11:01:48AM +0100, Paolo Bonzini wrote:
> On 31/12/19 19:32, Philippe Mathieu-Daud=E9 wrote:
> > Only the PC-based machines use the fw_cfg device. In particular,
> > the MicroVM machine does not use it. Only compile/link it when
> > machines require it.
> >=20
> > Signed-off-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>
> > ---
> > Cc: Sergio Lopez <slp@redhat.com>
> > ---
> >  hw/i386/Makefile.objs | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/hw/i386/Makefile.objs b/hw/i386/Makefile.objs
> > index 6ebb6d0cf0..48f2693546 100644
> > --- a/hw/i386/Makefile.objs
> > +++ b/hw/i386/Makefile.objs
> > @@ -5,7 +5,7 @@ obj-$(CONFIG_PC) +=3D pc.o pc_sysfw.o
> >  obj-$(CONFIG_I440FX) +=3D pc_piix.o
> >  obj-$(CONFIG_Q35) +=3D pc_q35.o
> >  obj-$(CONFIG_MICROVM) +=3D microvm.o
> > -obj-y +=3D fw_cfg.o
> > +obj-$(CONFIG_PC) +=3D fw_cfg.o
> >  obj-$(CONFIG_X86_IOMMU) +=3D x86-iommu.o
> >  obj-$(CONFIG_VTD) +=3D intel_iommu.o
> >  obj-$(CONFIG_AMD_IOMMU) +=3D amd_iommu.o
> >=20
>=20
> Ah no, this is hw/i386/fw_cfg.c; of course hw/nvram/fw_cfg.c has its own
> Kconfig symbol.

Sorry couldn't find it. Which symbol is that?

>  Can you rename the file to pc-fwcfg.c and adjust the
> commit message?
>=20
> Paolo

Yea hw/i386/fw_cfg.c are helpers for use of fw cfg in pc,
it's not a fw cfg device as the commit message seems to
imply.

If there is a fw cfg symbol, would it be cleaner to make pc-fwcfg.c
depend on it?

--=20
MST


