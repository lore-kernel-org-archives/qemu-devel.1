Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B3B9C18E5B
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 23:06:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 44AE020674
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 23:06:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iIvw1M6j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44AE020674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50148 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDyoB-0002ll-Du
	for qemu-devel@archiver.kernel.org; Mon, 16 Mar 2020 19:06:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49617)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1jDynT-0002Lu-U0
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 19:05:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1jDynS-0000vL-71
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 19:05:23 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:23021)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1jDynR-0000lE-RM
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 19:05:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584399921;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BrRl0eq7Kxl7Nl2IgjNuTjv8sWYfAYslrhz3RRQd1fQ=;
 b=iIvw1M6j5DhkqHhYYOiMJ9twYei3fqAFLevb6b9Gt2LF6lV2nO1h2fhmCDr5QpNwl/rX6v
 WRNXWomgN/OKKPCbHPJdb6eJ1ibctQB1n41Qwao9p9bP0BgY13o/TKr3LnYSOBxmL9F9j6
 8+URgA4tUJbfo0qTCbupunyYQgSA6Zo=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-377-fMS7nFaWPyyKrEt9BubLXQ-1; Mon, 16 Mar 2020 19:05:18 -0400
X-MC-Unique: fMS7nFaWPyyKrEt9BubLXQ-1
Received: by mail-wr1-f69.google.com with SMTP id t4so6819220wrv.9
 for <qemu-devel@nongnu.org>; Mon, 16 Mar 2020 16:05:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=fRptwMDA7InWGtlyymVbIikiQUpgBV66DqBAd/ywCGE=;
 b=aeQEzafSo9DdsW59jM9GzULPAs2iEfgPE8ZzbdA4grWNFlzxo/jupV+pXNI4ttdyK4
 AX4m9eMLdnyh8TFajBjW1OLAc7OuGOomFilI/zL3LVo2p47zCtWPbgHP9r0Gi2qWBCIv
 JufJ8KDHtA5NGltgjDjXnCtYTBrPYAzL7fHQtj2u/vG3JKJYzE46N/lScZbJwpn6yGSx
 JBELPvx44fVLdaEhjFWbbBpDPreLT2lD3cAJPFRC9bsPXqanWqjjWnS8Ljd8wrZk6LKD
 NLOLLwVLAiyHVwoa0V3ttptSi0vgoCk9ItHgjyMjgBf+Qih0sTPQrowN0d7Iqd48q80O
 Y78g==
X-Gm-Message-State: ANhLgQ1dbQHpyB5H2+HJMT5dVfa6QRwFtjoZMTnhaxkeEKUy6NmVnJa2
 pIJZKt96bD1/0stAdciJPQ1iQ4ImwaBtGQobp6VP4g0IFMFjusH4miNgP28kAXAMIiqdjc1M+zd
 SPan6JimjAwR4+pA=
X-Received: by 2002:a1c:491:: with SMTP id 139mr1420824wme.21.1584399917633;
 Mon, 16 Mar 2020 16:05:17 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vtet+O+/5aat15SzoVDdpQir0jQhOSPJ8vsS8T8ysx64QzGoqF+Tzx+XtSPFqzh5v0r+y24Pw==
X-Received: by 2002:a1c:491:: with SMTP id 139mr1420804wme.21.1584399917425;
 Mon, 16 Mar 2020 16:05:17 -0700 (PDT)
Received: from redhat.com (bzq-79-180-7-202.red.bezeqint.net. [79.180.7.202])
 by smtp.gmail.com with ESMTPSA id
 l8sm1537480wmj.2.2020.03.16.16.05.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Mar 2020 16:05:12 -0700 (PDT)
Date: Mon, 16 Mar 2020 19:05:10 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Yuri Benditovich <yuri.benditovich@daynix.com>
Subject: Re: [PATCH v4 6/6] virtio-net: add migration support for RSS and
 hash report
Message-ID: <20200316190407-mutt-send-email-mst@kernel.org>
References: <20200316100933.11499-1-yuri.benditovich@daynix.com>
 <20200316100933.11499-7-yuri.benditovich@daynix.com>
MIME-Version: 1.0
In-Reply-To: <20200316100933.11499-7-yuri.benditovich@daynix.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 216.205.24.74
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
Cc: yan@daynix.com, jasowang@redhat.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Mar 16, 2020 at 12:09:33PM +0200, Yuri Benditovich wrote:
> Save and restore RSS/hash report configuration.
>=20
> Signed-off-by: Yuri Benditovich <yuri.benditovich@daynix.com>
> ---
>  hw/net/virtio-net.c | 26 ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
>=20
> diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
> index a0614ad4e6..f343762a0f 100644
> --- a/hw/net/virtio-net.c
> +++ b/hw/net/virtio-net.c
> @@ -2842,6 +2842,13 @@ static int virtio_net_post_load_device(void *opaqu=
e, int version_id)
>          }
>      }
> =20
> +    if (n->rss_data.enabled) {
> +        trace_virtio_net_rss_enable(n->rss_data.hash_types,
> +                                    n->rss_data.indirections_len,
> +                                    sizeof(n->rss_data.key));
> +    } else {
> +        trace_virtio_net_rss_disable();
> +    }
>      return 0;
>  }
> =20
> @@ -3019,6 +3026,24 @@ static const VMStateDescription vmstate_virtio_net=
_has_vnet =3D {
>      },
>  };
> =20
> +static const VMStateDescription vmstate_rss =3D {
> +    .name      =3D "vmstate_rss",
> +    .fields =3D (VMStateField[]) {
> +        VMSTATE_BOOL(enabled, VirtioNetRssData),
> +        VMSTATE_BOOL(redirect, VirtioNetRssData),
> +        VMSTATE_BOOL(populate_hash, VirtioNetRssData),
> +        VMSTATE_UINT32(hash_types, VirtioNetRssData),
> +        VMSTATE_UINT32(indirections_len, VirtioNetRssData),


Why is this UINT32? Shouldn't it be UINT16?

> +        VMSTATE_UINT16(default_queue, VirtioNetRssData),
> +        VMSTATE_UINT8_ARRAY(key, VirtioNetRssData,
> +                            VIRTIO_NET_RSS_MAX_KEY_SIZE),
> +        VMSTATE_VARRAY_UINT32_ALLOC(indirections_table, VirtioNetRssData=
,
> +                                    indirections_len, 0,
> +                                    vmstate_info_uint16, uint16_t),
> +        VMSTATE_END_OF_LIST()
> +    },
> +};
> +
>  static const VMStateDescription vmstate_virtio_net_device =3D {
>      .name =3D "virtio-net-device",
>      .version_id =3D VIRTIO_NET_VM_VERSION,
> @@ -3067,6 +3092,7 @@ static const VMStateDescription vmstate_virtio_net_=
device =3D {
>                           vmstate_virtio_net_tx_waiting),
>          VMSTATE_UINT64_TEST(curr_guest_offloads, VirtIONet,
>                              has_ctrl_guest_offloads),
> +        VMSTATE_STRUCT(rss_data, VirtIONet, 1, vmstate_rss, VirtioNetRss=
Data),
>          VMSTATE_END_OF_LIST()
>     },
>  };
> --=20
> 2.17.1


