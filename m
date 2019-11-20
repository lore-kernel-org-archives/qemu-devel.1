Return-Path: <SRS0=6hMH=ZM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87E26C432C0
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 10:49:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 54D9B22429
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 10:49:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IbcRMndf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54D9B22429
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56072 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXNYA-0007iP-Rn
	for qemu-devel@archiver.kernel.org; Wed, 20 Nov 2019 05:49:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60031)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1iXNVX-0005cs-9A
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 05:46:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1iXNVV-0007tr-4s
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 05:46:46 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:28916
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1iXNVU-0007s3-OG
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 05:46:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574246803;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qlYk5aiU5D3CLRGn4femP/PU33DFKMQIxAmvsPw8iQI=;
 b=IbcRMndfxDP41/VcZjK9Crfgtt6JTy9rFEJesptLBMzpjbka480f+po1he231MgPZqyNuS
 K8HdyEmqrg7Gwf+W+OublPxWIDrGiCJP7DAdZvprYqotZFZyYHaqrxKGh9x3oA4RewcMXW
 5aui1nYCFiyh8Rlbp6K9yZ/LjHZYNVE=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-440-Mgk6ErinN5m1YLeUXtVHWg-1; Wed, 20 Nov 2019 05:46:42 -0500
Received: by mail-qv1-f71.google.com with SMTP id y24so16888896qvh.1
 for <qemu-devel@nongnu.org>; Wed, 20 Nov 2019 02:46:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=St9Kj3sk8x7KkZcLZTATy8n1jzO3UEeae88tUu3WDXo=;
 b=VmBstFJFrVPl21kptpYxcNLwYMr53iO4dIeARLJnGT991gccwoVTkWRmiaYjxU9bP3
 iyISrOFxpyzC0IlCaLRyxblVUuTZZzQYLnyocfMa7/ljS6xbyoaK1Z4f1BICW/dzBsNR
 IFkCwL2DhDLEVewJmoDdXCes0X9xrmO8z0UqoZSxpara7vv8h3S5z96UXWKediDbMAmS
 4IvPsIArLHnaVpTJPjh8Pl8vaFve5Lq50vLPFy4OLa9+dDzSx7nxJEtox4DN7dKcLIkD
 NrwO9vkCjKEF4oen7eedNfCLhoXeQlKj/Fx2YaGeP62QXDXqZp8iWzbNiTjPXSCb7xQK
 k6xA==
X-Gm-Message-State: APjAAAV39gUE5Iw6ud0tlvGhvNmDnSGTPR5ZOnABh2qqBshRDrr3STs7
 1XCh5auIAY+tI8a+aQrsyFW16wNGMCVQDuA/mgsi4a4S2nqeqSFUBmPbERGSCyjRLA5FYnRB8Yd
 UVRZw2UCZ4lFWZzY=
X-Received: by 2002:ac8:458c:: with SMTP id l12mr1929792qtn.300.1574246801682; 
 Wed, 20 Nov 2019 02:46:41 -0800 (PST)
X-Google-Smtp-Source: APXvYqwmfT+tdUThuVJGx4Sp9SDvBWdMkfqI/UmnCwpIkeeCuoNZ5jJDEU5qm/KpnqUFaNyltGX87A==
X-Received: by 2002:ac8:458c:: with SMTP id l12mr1929767qtn.300.1574246801509; 
 Wed, 20 Nov 2019 02:46:41 -0800 (PST)
Received: from redhat.com (bzq-79-176-6-42.red.bezeqint.net. [79.176.6.42])
 by smtp.gmail.com with ESMTPSA id t2sm11634838qkt.95.2019.11.20.02.46.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Nov 2019 02:46:40 -0800 (PST)
Date: Wed, 20 Nov 2019 05:46:36 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jens Freimann <jfreimann@redhat.com>
Subject: Re: [PATCH 3/4] net/virtio: avoid passing NULL to qdev_set_parent_bus
Message-ID: <20191120054036-mutt-send-email-mst@kernel.org>
References: <20191114141613.15804-1-jfreimann@redhat.com>
 <20191114141613.15804-3-jfreimann@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20191114141613.15804-3-jfreimann@redhat.com>
X-MC-Unique: Mgk6ErinN5m1YLeUXtVHWg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
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
Cc: peter.maydell@linaro.org, jasowang@redhat.com, qemu-devel@nongnu.org,
 dgilbert@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Nov 14, 2019 at 03:16:12PM +0100, Jens Freimann wrote:
> Make sure no arguments for qdev_set_parent_bus are NULL.
> This fixes CID 1407224.
>=20
> Fixes: 9711cd0dfc3f ("net/virtio: add failover support")
> Signed-off-by: Jens Freimann <jfreimann@redhat.com>
> ---
>  hw/net/virtio-net.c | 14 ++++++++++----
>  1 file changed, 10 insertions(+), 4 deletions(-)
>=20
> diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
> index ac4d19109e..81650d4dc0 100644
> --- a/hw/net/virtio-net.c
> +++ b/hw/net/virtio-net.c
> @@ -2809,8 +2809,16 @@ static bool failover_replug_primary(VirtIONet *n, =
Error **errp)
>      if (n->primary_device_opts) {
>          if (n->primary_dev) {
>              n->primary_bus =3D n->primary_dev->parent_bus;
> +            if (n->primary_bus) {
> +                qdev_set_parent_bus(n->primary_dev, n->primary_bus);
> +            } else  {
> +                error_setg(errp, "virtio_net: couldn't set bus for prima=
ry");
> +                goto out;
> +            }
> +        } else {
> +            error_setg(errp, "virtio_net: couldn't find primary device")=
;
> +            goto out;
>          }


A bit less messy:

if (!n->primary_dev) {
            error_setg(errp, "virtio_net: couldn't find primary device");
            goto err;
}

n->primary_bus =3D n->primary_dev->parent_bus;
if (!n->primary_bus) {
      error_setg(errp, "virtio_net: couldn't find primary device");
          goto err;
}

qdev_set_parent_bus(n->primary_dev, n->primary_bus);

err:
=09return false;

also is it valid for primary_device_opts to not be present at all?
Maybe we should check that too.



> -        qdev_set_parent_bus(n->primary_dev, n->primary_bus);
>          n->primary_should_be_hidden =3D false;
>          qemu_opt_set_bool(n->primary_device_opts,
>                  "partially_hotplugged", true, errp);
> @@ -2819,10 +2827,8 @@ static bool failover_replug_primary(VirtIONet *n, =
Error **errp)
>              hotplug_handler_pre_plug(hotplug_ctrl, n->primary_dev, errp)=
;
>              hotplug_handler_plug(hotplug_ctrl, n->primary_dev, errp);
>          }
> -        if (!n->primary_dev) {
> -            error_setg(errp, "virtio_net: couldn't find primary device")=
;
> -        }
>      }
> +out:
>      return *errp !=3D NULL;
>  }

I'd handle errors separately from good path.
BTW I don't understand something here:
*errp !=3D NULL is true on error, no?
Why are we returning success?
Confused.
Just return true would be cleaner imho.

> =20
> --=20
> 2.21.0


