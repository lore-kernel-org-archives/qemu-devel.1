Return-Path: <SRS0=ZRpO=43=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2205C10F27
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 11:24:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D84B24692
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 11:24:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NHU9clsl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D84B24692
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58188 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBczu-0000qn-QT
	for qemu-devel@archiver.kernel.org; Tue, 10 Mar 2020 07:24:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57156)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1jBcyu-0008Q3-5Q
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 07:23:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1jBcyt-0002OW-62
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 07:23:28 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:36811
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1jBcyt-00024U-1m
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 07:23:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583839397;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LcuqEhLkT0xZZAYRRPitcP5D6HISehjkpLGD0ezjar8=;
 b=NHU9clslhLawUm01hw+ANr4uB6XywzfQHVcm7+8Rdt+shnDEIvuINKH9xVK2arbMjVOV9f
 6MNtTtemPlQ4zAEVUvOQ5CXjP//ZvSZBPlINLIep46yPwweXDeMFVKqqaM+kyMuLlz3k+E
 Y05hoEx3NtiLwQkxk9CwAvN0QTb9NzE=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-158-eut8GXPtNnCiN9KqFCNrBQ-1; Tue, 10 Mar 2020 07:23:15 -0400
X-MC-Unique: eut8GXPtNnCiN9KqFCNrBQ-1
Received: by mail-qk1-f200.google.com with SMTP id w2so9468589qka.4
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2020 04:23:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=BM8MGkgDvYVirz4PB46HcFVprqFcomjvlJrRwS8zQ6g=;
 b=QFWo4Vq97cqyiTa7G9kJ0nyRqx94Sxr0HaS3iBGfNhNOSxiS9SAC7XuasP+PknZe72
 CY++QFiEomx1MI8B+aL+2m1WLHCJyBbz3IbXYG1DhCRS5Hnlxubrc8YGN/GWz9/qRpRJ
 swGj5yOvI60KSJjrB+H5aQVhkxdzJhkPX7hGrAr3JCJJ/4hb3On8F95+VN5hQEWuENAf
 kloVUUAXHKrPDLxpLoej5AqdznCTkTbzbC8TCEkNN8kHN+0cmWhQf93gxncX/L5fKcCF
 lAwzgheW21WVux2f+Dyyk2qOrZmoBYaBo7CnB2sWmVbpswSdeb/pBNWwXC9SkoDEQxH2
 h/Eg==
X-Gm-Message-State: ANhLgQ2oeuOu0VvbQ5AiXLoJ/JaN8Gzgl7DJkGsdho8GVGGlcBaOBqQ+
 rhfiStJvh4b5hCp38Rni/fkv4HuHdyu5NDAAjpMF77Fxr+kVdp1XqdkfD1R4vWqR41Yd76Pq8zK
 DXyxhABjMURJv8fE=
X-Received: by 2002:a37:ef10:: with SMTP id j16mr10288162qkk.200.1583839395373; 
 Tue, 10 Mar 2020 04:23:15 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vsUTkukxTUBpe+In9H4Sf1jedoaPx1RFCUDVrxzPwxEGKebTLWa1QlrEwuz306tTP/QGld5rg==
X-Received: by 2002:a37:ef10:: with SMTP id j16mr10288145qkk.200.1583839395115; 
 Tue, 10 Mar 2020 04:23:15 -0700 (PDT)
Received: from redhat.com (bzq-79-178-2-19.red.bezeqint.net. [79.178.2.19])
 by smtp.gmail.com with ESMTPSA id 10sm3183455qtt.65.2020.03.10.04.23.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Mar 2020 04:23:14 -0700 (PDT)
Date: Tue, 10 Mar 2020 07:23:09 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Liran Alon <liran.alon@oracle.com>
Subject: Re: [PATCH 06/14] hw/i386/vmport: Define enum for all commands
Message-ID: <20200310072236-mutt-send-email-mst@kernel.org>
References: <20200309235411.76587-1-liran.alon@oracle.com>
 <20200309235411.76587-7-liran.alon@oracle.com>
 <20200310052327-mutt-send-email-mst@kernel.org>
 <63a5be78-65e2-4092-f771-984572cd07cf@oracle.com>
MIME-Version: 1.0
In-Reply-To: <63a5be78-65e2-4092-f771-984572cd07cf@oracle.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
 rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Mar 10, 2020 at 01:16:51PM +0200, Liran Alon wrote:
>=20
> On 10/03/2020 11:28, Michael S. Tsirkin wrote:
> > On Tue, Mar 10, 2020 at 01:54:03AM +0200, Liran Alon wrote:
> > > No functional change.
> > >=20
> > > Defining an enum for all VMPort commands have the following advantage=
s:
> > > * It gets rid of the error-prone requirement to update VMPORT_ENTRIES
> > > when new VMPort commands are added to QEMU.
> > > * It makes it clear to know by looking at one place at the source, wh=
at
> > > are all the VMPort commands supported by QEMU.
> > >=20
> > > Reviewed-by: Nikita Leshenko <nikita.leshchenko@oracle.com>
> > > Signed-off-by: Liran Alon <liran.alon@oracle.com>
> > > ---
> > >=20
> > > diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
> > > index d5ac76d54e1f..7f15a01137b1 100644
> > > --- a/include/hw/i386/pc.h
> > > +++ b/include/hw/i386/pc.h
> > > @@ -138,12 +138,21 @@ GSIState *pc_gsi_create(qemu_irq **irqs, bool p=
ci_enabled);
> > >   #define TYPE_VMPORT "vmport"
> > >   typedef uint32_t (VMPortReadFunc)(void *opaque, uint32_t address);
> > > +typedef enum {
> > > +    VMPORT_CMD_GETVERSION       =3D 10,
> > > +    VMPORT_CMD_GETRAMSIZE       =3D 20,
> > > +    VMPORT_CMD_VMMOUSE_DATA     =3D 39,
> > > +    VMPORT_CMD_VMMOUSE_STATUS   =3D 40,
> > > +    VMPORT_CMD_VMMOUSE_COMMAND  =3D 41,
> > > +    VMPORT_ENTRIES
> > > +} VMPortCommand;
> > > +
> > Please don't, let's leave pc.h alone. If you must add a new header for
> > vmport/vmmouse and put this stuff there.
>=20
> As you can see, pc.h already contains definitions which are specific to
> vmport. E.g. TYPE_VMPORT, VMPortReadFunc(), vmport_register(),
> vmmouse_get_data(), vmmouse_set_data(). Adding this enum is not what make=
s
> the difference.
> It is possible to create a new vmport.h header file but it's not really
> related to this patch. It's just general refactoring. I can do that in v2=
 if
> you think it's appropriate.
>=20
> -Liran

Well I just don't want lots of enums in pc.h

> >=20
> > >   static inline void vmport_init(ISABus *bus)
> > >   {
> > >       isa_create_simple(bus, TYPE_VMPORT);
> > >   }
> > > -void vmport_register(unsigned char command, VMPortReadFunc *func, vo=
id *opaque);
> > > +void vmport_register(VMPortCommand command, VMPortReadFunc *func, vo=
id *opaque);
> > >   void vmmouse_get_data(uint32_t *data);
> > >   void vmmouse_set_data(const uint32_t *data);
> > > --=20
> > > 2.20.1


