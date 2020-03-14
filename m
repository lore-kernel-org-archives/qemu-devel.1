Return-Path: <SRS0=i8Yf=47=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3CAAC0044D
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Mar 2020 21:53:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 69D4E20575
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Mar 2020 21:53:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dHIMWR0S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69D4E20575
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48578 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDEiw-0001Oe-Ls
	for qemu-devel@archiver.kernel.org; Sat, 14 Mar 2020 17:53:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42213)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1jDEi7-0000es-1X
 for qemu-devel@nongnu.org; Sat, 14 Mar 2020 17:52:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1jDEi6-0003cc-2A
 for qemu-devel@nongnu.org; Sat, 14 Mar 2020 17:52:46 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:28644
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1jDEi5-0003cV-U4
 for qemu-devel@nongnu.org; Sat, 14 Mar 2020 17:52:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584222765;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8E+0HUOFjxnhYlN6Xj1i5gNWLN74R8GndU5TpjDMDnk=;
 b=dHIMWR0S76e+RLWMqfV9HFPC7dD6FRd6/z/irwcSqh9ya78O3c/ZXtjltktyzJP8eXMBCC
 2vbQi5OQkUBACwryctkQPPhggrQ77HcjvBchErfKW+LanbjFMhzYKW4T6coZ1LnlbXMg20
 g0ewU61jxL/eb3iVV8CE1iTp1U6bUDE=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-163-Zd4FOcJ3Ok2sySWs_73Ddw-1; Sat, 14 Mar 2020 17:52:41 -0400
X-MC-Unique: Zd4FOcJ3Ok2sySWs_73Ddw-1
Received: by mail-qt1-f198.google.com with SMTP id a21so12451715qto.0
 for <qemu-devel@nongnu.org>; Sat, 14 Mar 2020 14:52:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=22X4vsCvg0vNgjDLpixCJIa2HEDR9pTf5M1o8KEOJns=;
 b=RlDx36Wc7zLC0u+fv1mGHvtyWPZyQQVjm3T8CC9f5dqW8A3oIIHEHQ02s7if7CEgSl
 SaP/CdUYfZSneT6rWZBzcUtJE4us9rAVn6IVXxDywEb3eDRcZj7h9vEZ3+26ntKkA0Pw
 G3UFXQGuyFCwyAgouxb/XidkJFK7HuwtHLwBHuT/efd8EXb/fcv+CQ3sxZtVYzFUsYrP
 tczBgFsNOOpuln1pvzLUAjy08CYeeMDVdmYDxwuG6BQqMGXZirWIaQ/1j6Qti3AChLoe
 o2VPSwkqCIyGpFEfrYOfer45hiu111h0LjHXwhaiMDle5VpuJ/tc4zi46TPGiuuBTDkf
 US/g==
X-Gm-Message-State: ANhLgQ09AUOhDywjZ54qcYqqbKwRsm8RxIyC2TBuBV+o/3vO7fzOZG+u
 CRvL380gWfhHDekhrGchEUOo3nTIYc4XiNFThxxG0dwC3eXT0xNqNehTUwBMxiQyHplTIwQC3u5
 w/R4YgBufdooTVn0=
X-Received: by 2002:ac8:312e:: with SMTP id g43mr11855700qtb.360.1584222761132; 
 Sat, 14 Mar 2020 14:52:41 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vs7TUR3x6eg7b7tL1pgXhz5vY/8ZWYs1AZkPr5I4IN7ZTr/0PJHZCkK+RGhrBHb8l1W1BFLyQ==
X-Received: by 2002:ac8:312e:: with SMTP id g43mr11855688qtb.360.1584222760875; 
 Sat, 14 Mar 2020 14:52:40 -0700 (PDT)
Received: from redhat.com (bzq-79-180-7-202.red.bezeqint.net. [79.180.7.202])
 by smtp.gmail.com with ESMTPSA id
 x203sm18767328qkb.44.2020.03.14.14.52.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 14 Mar 2020 14:52:40 -0700 (PDT)
Date: Sat, 14 Mar 2020 17:52:34 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Liran Alon <liran.alon@oracle.com>
Subject: Re: [PATCH v3 15/16] hw/i386/vmport: Add support for CMD_GETHZ
Message-ID: <20200314174536-mutt-send-email-mst@kernel.org>
References: <20200312165431.82118-1-liran.alon@oracle.com>
 <20200312165431.82118-16-liran.alon@oracle.com>
 <97784452-8270-e0ab-1164-d3a9fe567006@redhat.com>
 <5a1a347a-102d-2c1e-bb27-e5b05408eb4a@oracle.com>
MIME-Version: 1.0
In-Reply-To: <5a1a347a-102d-2c1e-bb27-e5b05408eb4a@oracle.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
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
Cc: ehabkost@redhat.com, qemu-devel@nongnu.org,
 Nikita Leshenko <nikita.leshchenko@oracle.com>, pbonzini@redhat.com,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, Mar 14, 2020 at 12:44:55AM +0200, Liran Alon wrote:
>=20
> On 13/03/2020 22:07, Philippe Mathieu-Daud=E9 wrote:
> > On 3/12/20 5:54 PM, Liran Alon wrote:
> > >=20
> > > diff --git a/include/hw/i386/vmport.h b/include/hw/i386/vmport.h
> > > index 34cc050b1ffa..aee809521aa0 100644
> > > --- a/include/hw/i386/vmport.h
> > > +++ b/include/hw/i386/vmport.h
> > > @@ -12,6 +12,7 @@ typedef enum {
> > > =A0=A0=A0=A0=A0 VMPORT_CMD_VMMOUSE_DATA=A0=A0=A0=A0 =3D 39,
> > > =A0=A0=A0=A0=A0 VMPORT_CMD_VMMOUSE_STATUS=A0=A0 =3D 40,
> > > =A0=A0=A0=A0=A0 VMPORT_CMD_VMMOUSE_COMMAND=A0 =3D 41,
> > > +=A0=A0=A0 VMPORT_CMD_GETHZ=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =3D 45,
> >=20
> > Can you rename to something easier to read, such _GET_FREQS_HZ or nicer=
?
> >=20
> I actually prefer to stick with names similar to open-vm-tools. i.e. Simi=
lar
> to the definitions in lib/include/backdoor_def.h.

Please, do not copy without attribution. It really applies everywhere,
I commented on another enum and you fixed it there, but please
go over your code and try to generally apply the same rules.

> This helps correlates a command in QEMU code to guest code (in
> open-vm-tools) that interacts with it.
> I can rename to just VMPORT_CMD_GET_HZ (Similar to what you suggested for
> previous commands).
> But I don't have a strong opinion on this. If you still think _GET_FREQ_H=
Z
> is preferred, I will rename to that.
>=20
> -Liran


Generally I don't think a hard to read code somewhere is a good reason
to have hard to read code in QEMU, especially since it tends to
proliferate.  It seems unlikely that VMPORT_CMD_GETHZ appears verbatim
anywhere, and applying transformation rules is just too tricky. The best
way to map host code to guest code in light of coding style differences
etc is using comments. You did it in case of the type values, it
applies equally here.


--=20
MST


