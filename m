Return-Path: <SRS0=ZRpO=43=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89049C10F27
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 11:49:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 525D4208E4
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 11:49:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PRQCmbon"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 525D4208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58648 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBdNd-0000xx-IQ
	for qemu-devel@archiver.kernel.org; Tue, 10 Mar 2020 07:49:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42326)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1jBdKx-0005Y3-Ft
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 07:46:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1jBdKv-0006V1-MG
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 07:46:14 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:41057
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1jBdKv-0006P8-Fc
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 07:46:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583840771;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pHACq79Q+NVuoZ07xxxZN5ECuXOXur+MoD8TeNpTdr0=;
 b=PRQCmbonr3KlMh5p8hVXF3x3W+rkkkqYYxYUyGbBvKDiMxYkFCuxseTQKtNybFyXZ7ia28
 axf0N0jnbd7NlzUUQ7+zJLT1bKCOsdzxLDKcPYrm8ig+ekGLifD8k2xFbMy8LsU8JQVva6
 ZiabiFGa30tUHXI+nQxZgBPHSJHxB8A=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-288-B_-G27IuOYeVoe30xHdUMQ-1; Tue, 10 Mar 2020 07:46:09 -0400
X-MC-Unique: B_-G27IuOYeVoe30xHdUMQ-1
Received: by mail-qt1-f197.google.com with SMTP id w3so3398161qtc.8
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2020 04:46:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=WAM8uyefeS70PNpz/ifLl52vFGBm1sEkxH1Ot44WZfw=;
 b=mOGxn/7ucOAR3+48mlD9SKPFAzwWGZicY93f1VWO4bEP7/STm/NEVxJTZi73R5lq7C
 bcerWlTXCVh+R9kN2UpZ6dzvonqCthvEWqRLQATX85lezmKqKw2MCM34MW/aDyguEmH5
 2z0MKR+9YcdsOlqfV4z+Vep6RdMHMUIvg5N3GLDsnYT039rD262OgsnPyFLFYMOvcwPT
 Cdc/l/vsdEwacEt3Yb0AMeT+ti0atZaC3aB5BMcHo/VnVpdq5u4rj1vwtre8LL5pCTN2
 HMkeIq6eDaAcxHchUKSKJz3OZlaudRfrH2Jp7qcRnRqMj4pkP9wA641L1ShOA6+bHPnZ
 ouYQ==
X-Gm-Message-State: ANhLgQ0hemCjj3nfmSTB5ZQL3YOBnnw7ipQIWyXU7pENdBXyetoWJNpP
 x9A0xIfgO+iEYwBZoVIpc0bKxfDB3RtAxou+yd2hVQbl1aVeDCbQ4+8y+vepZlpcRoCo1Tf/VAg
 HCpQ9aUMWGwQRYQY=
X-Received: by 2002:a05:620a:848:: with SMTP id
 u8mr8809652qku.495.1583840769092; 
 Tue, 10 Mar 2020 04:46:09 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vvkTpcZWeQzITXS9Gcl5PGhemo5ZTVlmBXF8cTj/DIAU4SetmWRXC0GUF+Dy1V3CJOmRhHxcA==
X-Received: by 2002:a05:620a:848:: with SMTP id
 u8mr8809621qku.495.1583840768727; 
 Tue, 10 Mar 2020 04:46:08 -0700 (PDT)
Received: from redhat.com (bzq-79-178-2-19.red.bezeqint.net. [79.178.2.19])
 by smtp.gmail.com with ESMTPSA id i28sm24796737qtc.57.2020.03.10.04.46.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Mar 2020 04:46:06 -0700 (PDT)
Date: Tue, 10 Mar 2020 07:46:01 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Liran Alon <liran.alon@oracle.com>
Subject: Re: [PATCH 06/14] hw/i386/vmport: Define enum for all commands
Message-ID: <20200310074457-mutt-send-email-mst@kernel.org>
References: <20200309235411.76587-1-liran.alon@oracle.com>
 <20200309235411.76587-7-liran.alon@oracle.com>
 <20200310052327-mutt-send-email-mst@kernel.org>
 <63a5be78-65e2-4092-f771-984572cd07cf@oracle.com>
 <20200310072236-mutt-send-email-mst@kernel.org>
 <6de0d982-aa39-4188-455e-fe8c11a11b7e@oracle.com>
MIME-Version: 1.0
In-Reply-To: <6de0d982-aa39-4188-455e-fe8c11a11b7e@oracle.com>
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

On Tue, Mar 10, 2020 at 01:37:40PM +0200, Liran Alon wrote:
>=20
> On 10/03/2020 13:23, Michael S. Tsirkin wrote:
> > On Tue, Mar 10, 2020 at 01:16:51PM +0200, Liran Alon wrote:
> > > On 10/03/2020 11:28, Michael S. Tsirkin wrote:
> > > > On Tue, Mar 10, 2020 at 01:54:03AM +0200, Liran Alon wrote:
> > > > > No functional change.
> > > > >=20
> > > > > Defining an enum for all VMPort commands have the following advan=
tages:
> > > > > * It gets rid of the error-prone requirement to update VMPORT_ENT=
RIES
> > > > > when new VMPort commands are added to QEMU.
> > > > > * It makes it clear to know by looking at one place at the source=
, what
> > > > > are all the VMPort commands supported by QEMU.
> > > > >=20
> > > > > Reviewed-by: Nikita Leshenko <nikita.leshchenko@oracle.com>
> > > > > Signed-off-by: Liran Alon <liran.alon@oracle.com>
> > > > > ---
> > > > >=20
> > > > > diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
> > > > > index d5ac76d54e1f..7f15a01137b1 100644
> > > > > --- a/include/hw/i386/pc.h
> > > > > +++ b/include/hw/i386/pc.h
> > > > > @@ -138,12 +138,21 @@ GSIState *pc_gsi_create(qemu_irq **irqs, bo=
ol pci_enabled);
> > > > >    #define TYPE_VMPORT "vmport"
> > > > >    typedef uint32_t (VMPortReadFunc)(void *opaque, uint32_t addre=
ss);
> > > > > +typedef enum {
> > > > > +    VMPORT_CMD_GETVERSION       =3D 10,
> > > > > +    VMPORT_CMD_GETRAMSIZE       =3D 20,
> > > > > +    VMPORT_CMD_VMMOUSE_DATA     =3D 39,
> > > > > +    VMPORT_CMD_VMMOUSE_STATUS   =3D 40,
> > > > > +    VMPORT_CMD_VMMOUSE_COMMAND  =3D 41,
> > > > > +    VMPORT_ENTRIES
> > > > > +} VMPortCommand;
> > > > > +
> > > > Please don't, let's leave pc.h alone. If you must add a new header =
for
> > > > vmport/vmmouse and put this stuff there.
> > > As you can see, pc.h already contains definitions which are specific =
to
> > > vmport. E.g. TYPE_VMPORT, VMPortReadFunc(), vmport_register(),
> > > vmmouse_get_data(), vmmouse_set_data(). Adding this enum is not what =
makes
> > > the difference.
> > > It is possible to create a new vmport.h header file but it's not real=
ly
> > > related to this patch. It's just general refactoring. I can do that i=
n v2 if
> > > you think it's appropriate.
> > >=20
> > > -Liran
> > Well I just don't want lots of enums in pc.h
>=20
> This is the only one which is global, and makes sense as it's directly
> related to vmport_register() exposed API.
> Similar to how the VMPortReadFunc typedef is put in here.
>=20
> -Liran

So pls find another home for this stuff. Whoever touches legacy code
gets to clean it up a bit first :) Tough but that's the only stick
maintainers have to make maintainance happen.

--=20
MST


