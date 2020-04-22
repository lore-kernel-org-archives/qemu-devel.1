Return-Path: <SRS0=gSpC=6G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09225C54FCB
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 14:25:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C64A32076E
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 14:25:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RmsV/1Wb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C64A32076E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51720 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRGJi-0001ve-1e
	for qemu-devel@archiver.kernel.org; Wed, 22 Apr 2020 10:25:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57418)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1jRGIx-0001C2-UT
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 10:24:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1jRGIw-0003ZP-NX
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 10:24:47 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:35837
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jRGIw-0003Xt-AZ
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 10:24:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587565485;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Dqqa9vO9xE1PCMBMxhYsxe/Mw/Bsir9iDpk9fNriRDA=;
 b=RmsV/1WbCLXn27IfcOWn5wX8FTjzyMn/yYCJB99Mxsv+/MTxoTNm7DFS/viae0pwCjj2Cg
 XvdvxtvfIiFpa6+pJEOGSZ3WRTzsnTuPmzJJOrujakuY/CehJOz8trECmrtckr5q2Evi4i
 d3ii3xV4667Ullt/e4PspKMnNMkIl+I=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-247-FcmTG0M2PgGrUiFQ8pYqZA-1; Wed, 22 Apr 2020 10:24:43 -0400
X-MC-Unique: FcmTG0M2PgGrUiFQ8pYqZA-1
Received: by mail-wr1-f70.google.com with SMTP id y10so1133917wrn.5
 for <qemu-devel@nongnu.org>; Wed, 22 Apr 2020 07:24:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=DAx54VJ2SwDHXQid7fK/MG+Q6XdS2U3nOW0hE/q5FNo=;
 b=gCzbQx2u4XIkAdqhRjW8rHp7CZePQQ/mF4G6Jc8jg9houzvjSj5BGWzQsWZAnUf/Xx
 BNeE1ANBnGrQIPDvIhuGG5XHDyCx4oZKIShm1YpC0RQW4i8iGc7roDl38wvdKs6zHyBG
 N+Gio7lOoqydXQHxydePtpxc1Hev2lQcRzeXJhpAB1nSVTE8JRea0m/dCtv6+kHDPBB1
 gVGgqAqZxWJMyPld8a1oOh/sak7ZurXeR45WDYfoQCD/o9tRSbGLzKch+at7BH0EByYA
 +2Z1OLM7Y5069I/TeUO6KclDHGAnn+mfQn2pi9G2DY17rW/O0B8O4q6VRT9vCwSvp+Kk
 SVQA==
X-Gm-Message-State: AGi0PubaZ8vCjYdKziW1t5CUaL2/6FPheKDAop9m7T/mgCE3FcnVgWSW
 ixbCQhQd8iAIyBL992DHSX7oQY/mET1uy5b+M3OvAGkeMe4NbKbW+WaqP0sS5bcKIuuU5+AcKgv
 82aRPPsApnFzscKc=
X-Received: by 2002:a5d:6302:: with SMTP id i2mr19414648wru.80.1587565481983; 
 Wed, 22 Apr 2020 07:24:41 -0700 (PDT)
X-Google-Smtp-Source: APiQypLWRjQbVYbcX4Rd6HtD+drGIWXvarbV2KRjQnp2cvwp5xSN2OM1FsiKrci6XN/uVb+V0XeqIg==
X-Received: by 2002:a5d:6302:: with SMTP id i2mr19414624wru.80.1587565481719; 
 Wed, 22 Apr 2020 07:24:41 -0700 (PDT)
Received: from redhat.com (bzq-79-183-51-3.red.bezeqint.net. [79.183.51.3])
 by smtp.gmail.com with ESMTPSA id 138sm8467323wmb.14.2020.04.22.07.24.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Apr 2020 07:24:41 -0700 (PDT)
Date: Wed, 22 Apr 2020 10:24:39 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH v2 08/14] virtio-net: Fix duplex=... and speed=... error
 handling
Message-ID: <20200422102422-mutt-send-email-mst@kernel.org>
References: <20200422130719.28225-1-armbru@redhat.com>
 <20200422130719.28225-9-armbru@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200422130719.28225-9-armbru@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=mst@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/22 09:07:24
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
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
Cc: Jason Wang <jasowang@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Apr 22, 2020 at 03:07:13PM +0200, Markus Armbruster wrote:
> virtio_net_device_realize() rejects invalid duplex and speed values.
> The error handling is broken:
>=20
>     $ ../qemu/bld-sani/x86_64-softmmu/qemu-system-x86_64 -S -display none=
 -monitor stdio
>     QEMU 4.2.93 monitor - type 'help' for more information
>     (qemu) device_add virtio-net,duplex=3Dx
>     Error: 'duplex' must be 'half' or 'full'
>     (qemu) c
>     =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>     =3D=3D15654=3D=3DERROR: AddressSanitizer: heap-use-after-free on addr=
ess 0x62e000014590 at pc 0x560b75c8dc13 bp 0x7fffdf1a6950 sp 0x7fffdf1a6940
>     READ of size 8 at 0x62e000014590 thread T0
> =09#0 0x560b75c8dc12 in object_dynamic_cast_assert /work/armbru/qemu/qom/=
object.c:826
> =09#1 0x560b74c38ac0 in virtio_vmstate_change /work/armbru/qemu/hw/virtio=
/virtio.c:3210
> =09#2 0x560b74d9765e in vm_state_notify /work/armbru/qemu/softmmu/vl.c:12=
71
> =09#3 0x560b7494ba72 in vm_prepare_start /work/armbru/qemu/cpus.c:2156
> =09#4 0x560b7494bacd in vm_start /work/armbru/qemu/cpus.c:2162
> =09#5 0x560b75a7d890 in qmp_cont /work/armbru/qemu/monitor/qmp-cmds.c:160
> =09#6 0x560b75a8d70a in hmp_cont /work/armbru/qemu/monitor/hmp-cmds.c:104=
3
> =09#7 0x560b75a799f2 in handle_hmp_command /work/armbru/qemu/monitor/hmp.=
c:1082
>     [...]
>=20
>     0x62e000014590 is located 33168 bytes inside of 42288-byte region [0x=
62e00000c400,0x62e000016930)
>     freed by thread T1 here:
> =09#0 0x7feadd39491f in __interceptor_free (/lib64/libasan.so.5+0x10d91f)
> =09#1 0x7feadcebcd7c in g_free (/lib64/libglib-2.0.so.0+0x55d7c)
> =09#2 0x560b75c8fd40 in object_unref /work/armbru/qemu/qom/object.c:1128
> =09#3 0x560b7498a625 in memory_region_unref /work/armbru/qemu/memory.c:17=
62
> =09#4 0x560b74999fa4 in do_address_space_destroy /work/armbru/qemu/memory=
.c:2788
> =09#5 0x560b762362fc in call_rcu_thread /work/armbru/qemu/util/rcu.c:283
> =09#6 0x560b761c8884 in qemu_thread_start /work/armbru/qemu/util/qemu-thr=
ead-posix.c:519
> =09#7 0x7fead9be34bf in start_thread (/lib64/libpthread.so.0+0x84bf)
>=20
>     previously allocated by thread T0 here:
> =09#0 0x7feadd394d18 in __interceptor_malloc (/lib64/libasan.so.5+0x10dd1=
8)
> =09#1 0x7feadcebcc88 in g_malloc (/lib64/libglib-2.0.so.0+0x55c88)
> =09#2 0x560b75c8cf8a in object_new /work/armbru/qemu/qom/object.c:699
> =09#3 0x560b75010ad9 in qdev_device_add /work/armbru/qemu/qdev-monitor.c:=
654
> =09#4 0x560b750120c2 in qmp_device_add /work/armbru/qemu/qdev-monitor.c:8=
05
> =09#5 0x560b75012c1b in hmp_device_add /work/armbru/qemu/qdev-monitor.c:9=
05
>     [...]
>     =3D=3D15654=3D=3DABORTING
>=20
> Cause: virtio_net_device_realize() neglects to bail out after setting
> the error.  Fix that.
>=20
> Fixes: 9473939ed7addcaaeb8fde5c093918fb7fa0919c
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: Jason Wang <jasowang@redhat.com>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> Reviewed-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>

Acked-by: Michael S. Tsirkin <mst@redhat.com>

Feel free to merge with the rest of the patchset.

> ---
>  hw/net/virtio-net.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>=20
> diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
> index a46e3b37a7..b52ff4ab63 100644
> --- a/hw/net/virtio-net.c
> +++ b/hw/net/virtio-net.c
> @@ -2947,6 +2947,7 @@ static void virtio_net_device_realize(DeviceState *=
dev, Error **errp)
>              n->net_conf.duplex =3D DUPLEX_FULL;
>          } else {
>              error_setg(errp, "'duplex' must be 'half' or 'full'");
> +            return;
>          }
>          n->host_features |=3D (1ULL << VIRTIO_NET_F_SPEED_DUPLEX);
>      } else {
> @@ -2955,7 +2956,9 @@ static void virtio_net_device_realize(DeviceState *=
dev, Error **errp)
> =20
>      if (n->net_conf.speed < SPEED_UNKNOWN) {
>          error_setg(errp, "'speed' must be between 0 and INT_MAX");
> -    } else if (n->net_conf.speed >=3D 0) {
> +        return;
> +    }
> +    if (n->net_conf.speed >=3D 0) {
>          n->host_features |=3D (1ULL << VIRTIO_NET_F_SPEED_DUPLEX);
>      }
> =20
> --=20
> 2.21.1


