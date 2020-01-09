Return-Path: <SRS0=I8Mx=26=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 713AEC32771
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 10:51:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 364FE2067D
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 10:51:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W4e2Amgb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 364FE2067D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58112 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipVPZ-0002uY-BX
	for qemu-devel@archiver.kernel.org; Thu, 09 Jan 2020 05:51:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54185)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1ipVOu-0002Tw-KI
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 05:50:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1ipVOs-0003h1-R4
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 05:50:52 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:20585
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1ipVOs-0003Yp-8t
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 05:50:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578567048;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KlyZTXDIEcFjo6J85IK9ym2HX3G4zA21MxUsd7ZHvME=;
 b=W4e2AmgbLqCLQVyM//WBntiDpCfpd91gWzu2+6mOlxRxX/KHr02qSWpPkqwUoaKjh7w2U2
 RxsCIiD6u9iOCsZiteLpqR2WdF7p2mXOaL3oksTNHwsLZxWx23xZ74GAxp9cVieAaSx17S
 CD667ESDGcRQKsMMyS55+VLlWp6P5o0=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-214-UKASyaq8PyecyUinGqRxrg-1; Thu, 09 Jan 2020 05:50:45 -0500
Received: by mail-wm1-f70.google.com with SMTP id b9so760940wmj.6
 for <qemu-devel@nongnu.org>; Thu, 09 Jan 2020 02:50:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=HqGRPbB2YzeynzDwFcUm/jOYcN8ExYvexINqxzYQwIM=;
 b=j24sc5XT/HHudebtbuLv/wfwAmysk1cIC+RORtJuWMxle64sO4IDFyAbr7Xy8AVph/
 QNAwqaSw5D0eNCdWPzk6g79omZVLqL/II1/0sLVvdWT7S3TX0Am//dFpWlZWGTm3z525
 bFSh6XfzbX4lbHKXcXPPOzdQoqfEQS6if1d5B7AJWt9fuXeLrCFfIP1PNTeHHHw6U0nj
 iWwFO8FMKNC66gW7j+mxiTFAS9wg5afenf2Iu62xQNgJqhFQnkQuq8RJdOd91ILdsQPs
 6Cy6i2hPZh+gaLv+pcZMrkdXkvj+bKmS9A8yoii3LnZhi/7IfZAglfwmPAc1eVvKrvoI
 lcBA==
X-Gm-Message-State: APjAAAUmWBk/WuSoAxoWKulM1G57ab70WcGAzzvCseZizjLTfjLabhPK
 dZt5oaf+sC3LMxJj//E+hN9WWRQUjdSZ1MYqfEcZLVhQIly2pKREyps+VNsMA+YcNjLJZWOpnK8
 XyMc8Txw0Qa29Pvw=
X-Received: by 2002:a5d:428c:: with SMTP id k12mr10186459wrq.57.1578567043803; 
 Thu, 09 Jan 2020 02:50:43 -0800 (PST)
X-Google-Smtp-Source: APXvYqxPXgNW30Y9SLCyXr4vXa0fdQteF/Uy9XRt6zqOi58u1df2je49Y1aWL9eS+KX4+E0TAH4RoA==
X-Received: by 2002:a5d:428c:: with SMTP id k12mr10186438wrq.57.1578567043547; 
 Thu, 09 Jan 2020 02:50:43 -0800 (PST)
Received: from redhat.com (bzq-79-183-34-164.red.bezeqint.net. [79.183.34.164])
 by smtp.gmail.com with ESMTPSA id x6sm2351560wmi.44.2020.01.09.02.50.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jan 2020 02:50:42 -0800 (PST)
Date: Thu, 9 Jan 2020 05:50:40 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Andre Silva <afscoelho@gmail.com>
Subject: Re: [PATCH] virtio: Prevent double swap due to target pre 1.0 VirtIO
Message-ID: <20200109054233-mutt-send-email-mst@kernel.org>
References: <20200108161618.221116-1-afscoelho@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20200108161618.221116-1-afscoelho@gmail.com>
X-MC-Unique: UKASyaq8PyecyUinGqRxrg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Jan 08, 2020 at 01:16:18PM -0300, Andre Silva wrote:
> Remove the bswap function calls after reading and before writing
> memory bytes in virtio_pci_config_read and virtio_pci_config_write
> because they are reverting back an already swapped bytes.
>=20
> Consider the table below in the context of virtio_pci_config_read
> function.
>=20
> Host   Target  virtio-config-read[wl]
>                swap?                   virtio-is-big-endian?   extra bswa=
p?   Should be   Final result   Final result ok?
> ----- ------- ------------------------ ----------------------- ----------=
---- ----------- -------------- ------------------
> LE     BE      s(x)                    true                    s(s(x))   =
     s(x)        x              No
> LE     LE      x                       false                   -         =
     x           x              Yes
> BE     LE      s(x)                    false                   -         =
     s(x)        s(x)           Yes
> BE     BE      x                       true                    s(x)      =
     x           s(x)           No

we always get LE values from memory subsystem,
not target endian values:

static const MemoryRegionOps virtio_pci_config_ops =3D {
    .read =3D virtio_pci_config_read,
    .write =3D virtio_pci_config_write,
    .impl =3D {
        .min_access_size =3D 1,
        .max_access_size =3D 4,
    },
    .endianness =3D DEVICE_LITTLE_ENDIAN,
};


This triggers another swap in address_space_ldl_internal
(memory_ldst.inc.c).


> In table above, when target is big endian and VirtIO is pre 1.0,
> function virtio_is_big_endian would return true and the extra
> swap would be executed, reverting the previous swap made by
> virtio_config_read[wl].
>=20
> The 's(x)' means that a swap function was applied at
> address x. 'LE' is little endian and 'BE' is big endian. The
> 'Final result' column is the returned value from
> virtio_pci_config_read, considering a target Virtio pre 1.0.
> 'x' means that target's value was not swapped in Qemu, 's(x)' means
> that Qemu will use a swapped value.
>=20
> If we remove the extra swap made in virtio_pci_config_read we will
> have the correct result in any host/target combination, both for
> VirtIO pre 1.0 or later versions.
>=20
> The same reasoning applies to virtio_pci_config_write.
>=20
> Signed-off-by: Andre Silva <afscoelho@gmail.com>
> ---
>  hw/virtio/virtio-pci.c | 12 ------------
>  1 file changed, 12 deletions(-)
>=20
> diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
> index c6b47a9c73..4ba9e847f3 100644
> --- a/hw/virtio/virtio-pci.c
> +++ b/hw/virtio/virtio-pci.c
> @@ -431,15 +431,9 @@ static uint64_t virtio_pci_config_read(void *opaque,=
 hwaddr addr,
>          break;
>      case 2:
>          val =3D virtio_config_readw(vdev, addr);
> -        if (virtio_is_big_endian(vdev)) {
> -            val =3D bswap16(val);
> -        }
>          break;
>      case 4:
>          val =3D virtio_config_readl(vdev, addr);
> -        if (virtio_is_big_endian(vdev)) {
> -            val =3D bswap32(val);
> -        }
>          break;
>      }
>      return val;
> @@ -465,15 +459,9 @@ static void virtio_pci_config_write(void *opaque, hw=
addr addr,
>          virtio_config_writeb(vdev, addr, val);
>          break;
>      case 2:
> -        if (virtio_is_big_endian(vdev)) {
> -            val =3D bswap16(val);
> -        }
>          virtio_config_writew(vdev, addr, val);
>          break;
>      case 4:
> -        if (virtio_is_big_endian(vdev)) {
> -            val =3D bswap32(val);
> -        }
>          virtio_config_writel(vdev, addr, val);
>          break;
>      }
> --=20
> 2.24.1


