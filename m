Return-Path: <SRS0=QLzr=44=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 741BDC10F27
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 13:48:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 30A2020873
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 13:48:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SUow17YW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30A2020873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52194 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jC1j8-0005O5-EK
	for qemu-devel@archiver.kernel.org; Wed, 11 Mar 2020 09:48:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34716)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1jC1iS-0004RX-Ng
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 09:48:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1jC1iR-0006Cv-Ku
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 09:48:08 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:51569
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1jC1iR-0006Cf-Gv
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 09:48:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583934486;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fW675FI+o3YxcM/t0nFCZXXKq494qzWU6FSsbBiPkKE=;
 b=SUow17YWIDAvYvYjfFiaF60BBUJgWOsRNcoYQEj7zTJf+rXIFon/gZ7u/qyIIcBiPfW3b/
 hIzN7nRYcSYufIA0U3yMhO2sVqO1A+TJNF/Pfk317fsXBJRy+nof39AurLHlBf/n/COvbE
 28Nd9eReFWXjkuYFMRU0/fzWW0g4JFg=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-229-RJzHA6ppOVCmwQBjeA6XHg-1; Wed, 11 Mar 2020 09:48:04 -0400
X-MC-Unique: RJzHA6ppOVCmwQBjeA6XHg-1
Received: by mail-qt1-f199.google.com with SMTP id o10so1201637qtk.22
 for <qemu-devel@nongnu.org>; Wed, 11 Mar 2020 06:48:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=oL9+eTPBEW8/umpu8OjFKpX7tCIeiJ2wTDurwLPD1/o=;
 b=mJ6jXMkVObi+PdaAOpsjBjy4N1dSIE/Sby3wt35drA48yuU4AidQcypTrvCg3OyCBl
 DbeuJbWMzG2D6ZDLZc/nU20scFGLUcBXXGUlFO6GQRpbrMVpkEMr/FYDHSuTKuB8hNlv
 hYW6e50f25re6OhZGGYv8ewfVKRyDS4HOdDc+fXNm7X3gfOLp/B3trDfl/NRhEr29H9e
 Nzk5MkBVKVlXodLp9trrmn3IC6M7l141r6E5SEovfSL5ehtp5ZcU334iEWkJYjUmDevp
 EJnZmHGtiD9gV6Vclqx1V2J+2cMdnFQ/3KBSjWe/pUK4URZBM1xxz7Wstmlp7CAQHTXU
 1YgA==
X-Gm-Message-State: ANhLgQ3JE3leRQXMSiC6WHZJRZS0XKLGTKNfguhgrEmybk8eg62TJYLn
 5HvbsLuC9xfHuslJupkZH45an7khOwlTUw9MHbb7bQjpXzaAD4/FUOn3kRX+k3ks1Q7YJZ884cC
 pnTGJJna/eS2R778=
X-Received: by 2002:a37:2fc3:: with SMTP id v186mr2839953qkh.311.1583934483629; 
 Wed, 11 Mar 2020 06:48:03 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vu0aibX51H++8LqFgNjyZQZZuWrLI71yNY+4vgcWrP7JAmjxAOOvIYofWgYX25sYcjS5y9aVg==
X-Received: by 2002:a37:2fc3:: with SMTP id v186mr2839919qkh.311.1583934483231; 
 Wed, 11 Mar 2020 06:48:03 -0700 (PDT)
Received: from redhat.com (bzq-79-178-2-19.red.bezeqint.net. [79.178.2.19])
 by smtp.gmail.com with ESMTPSA id y60sm1409639qtd.32.2020.03.11.06.48.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Mar 2020 06:48:02 -0700 (PDT)
Date: Wed, 11 Mar 2020 09:47:58 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Yuri Benditovich <yuri.benditovich@daynix.com>
Subject: Re: [PATCH v3 5/6] virtio-net: add migration support for RSS and
 hast report
Message-ID: <20200311094706-mutt-send-email-mst@kernel.org>
References: <20200311123518.4025-1-yuri.benditovich@daynix.com>
 <20200311123518.4025-6-yuri.benditovich@daynix.com>
MIME-Version: 1.0
In-Reply-To: <20200311123518.4025-6-yuri.benditovich@daynix.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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

On Wed, Mar 11, 2020 at 02:35:17PM +0200, Yuri Benditovich wrote:
> Save and restore RSS/hash report configuration.
>=20
> Signed-off-by: Yuri Benditovich <yuri.benditovich@daynix.com>
> ---
>  hw/net/virtio-net.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>=20
> diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
> index 7b6a929e8c..c8d97d45cd 100644
> --- a/hw/net/virtio-net.c
> +++ b/hw/net/virtio-net.c
> @@ -2869,6 +2869,13 @@ static int virtio_net_post_load_device(void *opaqu=
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
> @@ -3094,6 +3101,8 @@ static const VMStateDescription vmstate_virtio_net_=
device =3D {
>                           vmstate_virtio_net_tx_waiting),
>          VMSTATE_UINT64_TEST(curr_guest_offloads, VirtIONet,
>                              has_ctrl_guest_offloads),
> +        VMSTATE_UINT8_ARRAY(rss_data_migration, VirtIONet,
> +                            sizeof(VirtioNetRssData)),
>          VMSTATE_END_OF_LIST()
>     },


I think we should migrate the length too. Avoid arbitrary limits.
Yes this means we should allocate the indirection arrays on the fly.
But that's probably a good idea anyway.

>  };
> --=20
> 2.17.1


