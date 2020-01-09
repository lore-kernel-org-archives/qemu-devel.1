Return-Path: <SRS0=I8Mx=26=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D313C282DD
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 21:19:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 27AF52077B
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 21:19:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ig+/edBE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27AF52077B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37354 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipfDh-0007xK-EZ
	for qemu-devel@archiver.kernel.org; Thu, 09 Jan 2020 16:19:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52186)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <afscoelho@gmail.com>) id 1ipfD1-0007XY-Ku
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 16:19:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <afscoelho@gmail.com>) id 1ipfCz-0004fP-OK
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 16:19:15 -0500
Received: from mail-lj1-x244.google.com ([2a00:1450:4864:20::244]:36345)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <afscoelho@gmail.com>) id 1ipfCz-0004Ui-Bv
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 16:19:13 -0500
Received: by mail-lj1-x244.google.com with SMTP id r19so8799333ljg.3
 for <qemu-devel@nongnu.org>; Thu, 09 Jan 2020 13:19:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=EbSxBnxdfVgWnddHjXAK7aaAd5vZDCIBbpoJNXRNrto=;
 b=ig+/edBEzToBSYARjAgqMQo3HAYUDX2RiMXdic7etO+Pze8GPhU1K0EAUPGYF4P+f7
 G8zB0EQeyvaw7PyWIFsGb40S+0z8YCFk1euNdnLv3Iwp/0NR+AHK0eXTv91Wi0P5IbRr
 ZpX4JGzxoOnmgH4m9is24+F6DrfkCHxgJWifU0bC7SAh7X3yyt4CInOK1vJwAXpItgpX
 GGqhH85O/j/giN2yQXu2DFgfiNQpYjZGD/LBqSj0/t+AKeNEX6iskjdfZkx2fPakgI3N
 SGecE06/rQdU5Bk2lKNvq9QYKUEo4gaaYoHU9F275+CmHNEeFm8HDy3yLXCpySXnmscs
 bLvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=EbSxBnxdfVgWnddHjXAK7aaAd5vZDCIBbpoJNXRNrto=;
 b=OECLjKA2shXffQjsd/euTjvg11nUDl9xA84MU+JZ36TktSAAEd7zt4exJTzzHpAWR/
 zhoT2Wns4NNRqZSf2Ke7xV3pUtqF7aPpg4XrSwDF1gOwwJ0BNV4XFY35xALZHDzItawP
 Y+RNitMx5gzF9CC+o09WtvNMN8N2srt2Ic1RQqQvyDXnUdclg6Jmitlo/gDZI4S6loec
 alfeRIc4Na7N5PCPmeWaiMNXMFeYw9/FBrCQlKNRCUMi08Zkin3AxKMu9LsX2LOtL7VG
 GH5KVrLbr6cRmGoEIW1XF3o3BkXdheHHYoD88um7xUj6eUPgwjwmymVxpu+BVVeC/9Vj
 gKlA==
X-Gm-Message-State: APjAAAXs6I383aoNdN4I/7tZ1aQmN/6rG/j4FA/cZ6u/xdGUhmuW9PhZ
 mrC2JrZ0Zz0hPDls6Y1nvlIqgKXszQMYruGGrJY=
X-Google-Smtp-Source: APXvYqyZY22IQpsi3n0kqa3UFWHYoxemxyUstlsI/nQW6u3ZFtb0biLUAAy597WUEt4cqynSRen9d/PDFgtYASUc00k=
X-Received: by 2002:a2e:9015:: with SMTP id h21mr37634ljg.69.1578604749305;
 Thu, 09 Jan 2020 13:19:09 -0800 (PST)
MIME-Version: 1.0
References: <20200108161618.221116-1-afscoelho@gmail.com>
 <20200109054233-mutt-send-email-mst@kernel.org>
 <CAGTcC7yLjP5h4oWfgvrOYobChW-cw-oL5EBmMCH45O41+yuvyA@mail.gmail.com>
 <20200109073529-mutt-send-email-mst@kernel.org>
 <20200109170640.4c3fa148@bahia.lan>
In-Reply-To: <20200109170640.4c3fa148@bahia.lan>
From: =?UTF-8?B?QW5kcsOpIFNpbHZh?= <afscoelho@gmail.com>
Date: Thu, 9 Jan 2020 18:18:57 -0300
Message-ID: <CAGTcC7wsTkS+E00SjNoyc7EwyviALr0ucYY4JN=w3oykjhkpuw@mail.gmail.com>
Subject: Re: [PATCH] virtio: Prevent double swap due to target pre 1.0 VirtIO
To: Greg Kurz <groug@kaod.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::244
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
Cc: QEMU Developers <qemu-devel@nongnu.org>,
 "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Greg,

Thanks for the commit info.
But I'm testing in this scenario, that is, a ppc64le host with a ppc64
BE guest, and without my patch I can't get virtio to work. The patch
makes virtio 0.95 (legacy) net, scsi, blk work. I don't get the
firmware error. I also tested with a ppc64le guest and had no problems
either. Maybe we have different firmware versions?

My firmware output:

SLOF **********************************************************************
QEMU Starting
 Build Date =3D Jul  3 2019 12:26:14
 FW Version =3D git-ba1ab360eebe6338
 Press "s" to enter Open Firmware.

Populating /vdevice methods
Populating /vdevice/vty@71000000
Populating /vdevice/nvram@71000001
Populating /vdevice/v-scsi@71000002
       SCSI: Looking for devices
          8200000000000000 CD-ROM   : "QEMU     QEMU CD-ROM      2.5+"
Populating /pci@800000020000000
                     00 0000 (D) : 1af4 1000    virtio [ net ]
                     00 0800 (D) : 1af4 1001    virtio [ block ]
No NVRAM common partition, re-initializing...
Scanning USB
Using default console: /vdevice/vty@71000000

  Welcome to Open Firmware

  Copyright (c) 2004, 2017 IBM Corporation All rights reserved.
  This program and the accompanying materials are made available
  under the terms of the BSD License available at
  http://www.opensource.org/licenses/bsd-license.php


Trying to load:  from: /pci@800000020000000/scsi@1 ...   Successfully loade=
d

>> FreeBSD/powerpc Open Firmware boot block
   Boot path:   /pci@800000020000000/scsi@1
   Boot loader: /boot/loader
   Boot volume:   /pci@800000020000000/scsi@1:2
Consoles: Open Firmware console

FreeBSD/powerpc64 Open Firmware loader, Revision 0.1
(Mon Nov 11 22:33:43 -02 2019 jenkins@FreeBSD_x86)
Memory: 4194304KB
Booted from: /pci@800000020000000/scsi@1

Loading /boot/defaults/loader.conf
/boot/kernel/kernel data=3D0x129f658+0x4aaa88 syms=3D[0x8+0x105120+0x8+0x12=
5429]
...

Until now, I was able to test the patch and see virtio working on the
following systems:

  Qemu     Host             Guest                           Guest VirtIO
  -------- ---------------- ------------------------------- --------------
  master   Ubuntu ppc64le   FreeBSD 13.0-current ppc64 BE   legacy
  master   Ubuntu ppc64le   debian 4.19.0-6-powerpc64le     modern
  master   Ubuntu ppc64le   debian 4.19.0-6-powerpc64le     legacy
  master   arch x86_64      FreeBSD 13.0-current ppc64 BE   legacy

Thanks,
andr=C3=A9

On Thu, Jan 9, 2020 at 1:06 PM Greg Kurz <groug@kaod.org> wrote:
>
> On Thu, 9 Jan 2020 07:39:17 -0500
> "Michael S. Tsirkin" <mst@redhat.com> wrote:
>
> > On Thu, Jan 09, 2020 at 09:25:42AM -0300, Andr=C3=A9 Silva wrote:
> > > Hi Michael!
> > > Thanks for reviewing the patch!
> > >
> > > > we always get LE values from memory subsystem,
> > > > not target endian values:
> > >
> > > I see. So do you think the patch is correct in eliminating the extra
> > > swap (as virtio_config_readw for example already makes a swap)?
> > >
> > > Thanks,
> > > andr=C3=A9
> >
> > I don't think it is, I think we do need an extra swap
> > in some cases. It's possible that some cross-endian
> > setups are broken now, if so pls include testing
> > result not just theoretical analysis.
> >
>
> I confirm that we must keep the extra swap otherwise
> read/write in cross-endian setups will have wrong
> endian. Please read this commit for a more detailed
> explanation:
>
> commit 82afa58641b0e67abbaf4da6c325ebd7c2513262
> Author: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Date:   Tue Jan 10 01:35:11 2012 +0000
>
>     virtio-pci: Fix endianness of virtio config
>
> https://git.qemu.org/?p=3Dqemu.git;a=3Dcommitdiff;h=3D82afa58641b0e67abba=
f4da6c325ebd7c2513262
>
> This is especially critical on ppc64 since _all_ hosts are now LE
> but the first piece of code in the guest that is likely to drive
> the device is the SLOF firmware which is BE.
>
> This is what we get with this patch when trying to run a pseries guest on=
 a
> ppc64le host:
>
> Trying to load:  from: /pci@800000020000000/scsi@0 ... virtioblk_transfer=
: Access beyond end of device!
>
> Cheers,
>
> --
> Greg
>
> > > On Thu, Jan 9, 2020 at 7:50 AM Michael S. Tsirkin <mst@redhat.com> wr=
ote:
> > > >
> > > > On Wed, Jan 08, 2020 at 01:16:18PM -0300, Andre Silva wrote:
> > > > > Remove the bswap function calls after reading and before writing
> > > > > memory bytes in virtio_pci_config_read and virtio_pci_config_writ=
e
> > > > > because they are reverting back an already swapped bytes.
> > > > >
> > > > > Consider the table below in the context of virtio_pci_config_read
> > > > > function.
> > > > >
> > > > > Host   Target  virtio-config-read[wl]
> > > > >                swap?                   virtio-is-big-endian?   ex=
tra bswap?   Should be   Final result   Final result ok?
> > > > > ----- ------- ------------------------ ----------------------- --=
------------ ----------- -------------- ------------------
> > > > > LE     BE      s(x)                    true                    s(=
s(x))        s(x)        x              No
> > > > > LE     LE      x                       false                   - =
             x           x              Yes
> > > > > BE     LE      s(x)                    false                   - =
             s(x)        s(x)           Yes
> > > > > BE     BE      x                       true                    s(=
x)           x           s(x)           No
> > > >
> > > > we always get LE values from memory subsystem,
> > > > not target endian values:
> > > >
> > > > static const MemoryRegionOps virtio_pci_config_ops =3D {
> > > >     .read =3D virtio_pci_config_read,
> > > >     .write =3D virtio_pci_config_write,
> > > >     .impl =3D {
> > > >         .min_access_size =3D 1,
> > > >         .max_access_size =3D 4,
> > > >     },
> > > >     .endianness =3D DEVICE_LITTLE_ENDIAN,
> > > > };
> > > >
> > > >
> > > > This triggers another swap in address_space_ldl_internal
> > > > (memory_ldst.inc.c).
> > > >
> > > >
> > > > > In table above, when target is big endian and VirtIO is pre 1.0,
> > > > > function virtio_is_big_endian would return true and the extra
> > > > > swap would be executed, reverting the previous swap made by
> > > > > virtio_config_read[wl].
> > > > >
> > > > > The 's(x)' means that a swap function was applied at
> > > > > address x. 'LE' is little endian and 'BE' is big endian. The
> > > > > 'Final result' column is the returned value from
> > > > > virtio_pci_config_read, considering a target Virtio pre 1.0.
> > > > > 'x' means that target's value was not swapped in Qemu, 's(x)' mea=
ns
> > > > > that Qemu will use a swapped value.
> > > > >
> > > > > If we remove the extra swap made in virtio_pci_config_read we wil=
l
> > > > > have the correct result in any host/target combination, both for
> > > > > VirtIO pre 1.0 or later versions.
> > > > >
> > > > > The same reasoning applies to virtio_pci_config_write.
> > > > >
> > > > > Signed-off-by: Andre Silva <afscoelho@gmail.com>
> > > > > ---
> > > > >  hw/virtio/virtio-pci.c | 12 ------------
> > > > >  1 file changed, 12 deletions(-)
> > > > >
> > > > > diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
> > > > > index c6b47a9c73..4ba9e847f3 100644
> > > > > --- a/hw/virtio/virtio-pci.c
> > > > > +++ b/hw/virtio/virtio-pci.c
> > > > > @@ -431,15 +431,9 @@ static uint64_t virtio_pci_config_read(void =
*opaque, hwaddr addr,
> > > > >          break;
> > > > >      case 2:
> > > > >          val =3D virtio_config_readw(vdev, addr);
> > > > > -        if (virtio_is_big_endian(vdev)) {
> > > > > -            val =3D bswap16(val);
> > > > > -        }
> > > > >          break;
> > > > >      case 4:
> > > > >          val =3D virtio_config_readl(vdev, addr);
> > > > > -        if (virtio_is_big_endian(vdev)) {
> > > > > -            val =3D bswap32(val);
> > > > > -        }
> > > > >          break;
> > > > >      }
> > > > >      return val;
> > > > > @@ -465,15 +459,9 @@ static void virtio_pci_config_write(void *op=
aque, hwaddr addr,
> > > > >          virtio_config_writeb(vdev, addr, val);
> > > > >          break;
> > > > >      case 2:
> > > > > -        if (virtio_is_big_endian(vdev)) {
> > > > > -            val =3D bswap16(val);
> > > > > -        }
> > > > >          virtio_config_writew(vdev, addr, val);
> > > > >          break;
> > > > >      case 4:
> > > > > -        if (virtio_is_big_endian(vdev)) {
> > > > > -            val =3D bswap32(val);
> > > > > -        }
> > > > >          virtio_config_writel(vdev, addr, val);
> > > > >          break;
> > > > >      }
> > > > > --
> > > > > 2.24.1
> > > >
> >
> >
>

