Return-Path: <SRS0=8ZcK=YO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92F41CA9EAF
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 12:46:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5CAF420B7C
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 12:46:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AThZ/ggy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5CAF420B7C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40394 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMX50-0005iz-OO
	for qemu-devel@archiver.kernel.org; Mon, 21 Oct 2019 08:46:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59374)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1iMX31-0004HW-Oq
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 08:44:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cohuck@redhat.com>) id 1iMX2y-0003nA-Aq
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 08:44:30 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:53572
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1iMX2w-0003mh-LX
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 08:44:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1571661865;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VxFUb7yYdcac7Qz5Vl+omLaDK5x6RcX9X6owrpOMuvM=;
 b=AThZ/ggyrv5ERFu+ZTICF1mGuzaQncafe6nvZnokOkd8S7mWOxfijz+CnpIL+i/YAyMtlO
 EsurgcIeWQzvE9vAnC48dOVCzZKHKIDMYsXwTXp2UMbe4S5K8RVvs4JvlRLE1GQvg77LRn
 /cplAjKlhZ16SjJ6gYhHAyehJ1ZI0/8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-33-ZN7h4gLGP5GQucqRNSghGQ-1; Mon, 21 Oct 2019 08:44:23 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BCFA4107AD31;
 Mon, 21 Oct 2019 12:44:22 +0000 (UTC)
Received: from gondolin (dhcp-192-218.str.redhat.com [10.33.192.218])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 91ECA60606;
 Mon, 21 Oct 2019 12:44:11 +0000 (UTC)
Date: Mon, 21 Oct 2019 14:44:08 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: Jens Freimann <jfreimann@redhat.com>
Subject: Re: [PATCH 01/11] qdev/qbus: add hidden device support
Message-ID: <20191021144408.413b3fca.cohuck@redhat.com>
In-Reply-To: <20191018202040.30349-2-jfreimann@redhat.com>
References: <20191018202040.30349-1-jfreimann@redhat.com>
 <20191018202040.30349-2-jfreimann@redhat.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: ZN7h4gLGP5GQucqRNSghGQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
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
Cc: pkrempa@redhat.com, berrange@redhat.com, ehabkost@redhat.com,
 mst@redhat.com, aadam@redhat.com, qemu-devel@nongnu.org, dgilbert@redhat.com,
 alex.williamson@redhat.com, laine@redhat.com, ailan@redhat.com,
 parav@mellanox.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 18 Oct 2019 22:20:30 +0200
Jens Freimann <jfreimann@redhat.com> wrote:

> This adds support for hiding a device to the qbus and qdev APIs.  The
> first user of this will be the virtio-net failover feature but the API
> introduced with this patch could be used to implement other features as
> well, for example hiding pci devices when a pci bus is powered off.
>=20
> qdev_device_add() is modified to check for a net_failover_pair_id
> argument in the option string. A DeviceListener callback
> should_be_hidden() is added. It can be used by a standby device to
> inform qdev that this device should not be added now. The standby device
> handler can store the device options to plug the device in at a later
> point in time.
>=20
> One reason for hiding the device is that we don't want to expose both
> devices to the guest kernel until the respective virtio feature bit
> VIRTIO_NET_F_STANDBY was negotiated and we know that the devices will be
> handled correctly by the guest.
>=20
> More information on the kernel feature this is using:
>  https://www.kernel.org/doc/html/latest/networking/net_failover.html
>=20
> An example where the primary device is a vfio-pci device and the standby
> device is a virtio-net device:
>=20
> A device is hidden when it has an "net_failover_pair_id" option, e.g.
>=20
>  -device virtio-net-pci,...,failover=3Don,...
>  -device vfio-pci,...,net_failover_pair_id=3Dnet1,...
>=20
> Signed-off-by: Jens Freimann <jfreimann@redhat.com>
> ---
>  hw/core/qdev.c         | 23 +++++++++++++++++++++++
>  include/hw/qdev-core.h |  8 ++++++++
>  qdev-monitor.c         | 36 +++++++++++++++++++++++++++++++++---
>  vl.c                   |  6 ++++--
>  4 files changed, 68 insertions(+), 5 deletions(-)
>=20
> diff --git a/hw/core/qdev.c b/hw/core/qdev.c
> index cbad6c1d55..89c134ec53 100644
> --- a/hw/core/qdev.c
> +++ b/hw/core/qdev.c
> @@ -212,6 +212,29 @@ void device_listener_unregister(DeviceListener *list=
ener)
>      QTAILQ_REMOVE(&device_listeners, listener, link);
>  }
> =20
> +bool qdev_should_hide_device(QemuOpts *opts)
> +{
> +    int rc;

Initialize to 0?

> +    DeviceListener *listener;
> +
> +    QTAILQ_FOREACH(listener, &device_listeners, link) {
> +       if (listener->should_be_hidden) {
> +            /* should_be_hidden_will return
> +             *  1 if device matches opts and it should be hidden
> +             *  0 if device matches opts and should not be hidden
> +             *  -1 if device doesn't match ops
> +             */
> +            rc =3D listener->should_be_hidden(listener, opts);
> +        }
> +
> +        if (rc > 0) {
> +            break;
> +        }
> +    }
> +
> +    return rc > 0;
> +}
> +
>  void qdev_set_legacy_instance_id(DeviceState *dev, int alias_id,
>                                   int required_for_version)
>  {

(...)

> +static bool should_hide_device(QemuOpts *opts)
> +{
> +    if (qemu_opt_foreach(opts, is_failover_device, opts, NULL) =3D=3D 0)=
 {
> +        return false;
> +    }
> +    return true;
> +}

I still think you should turn the check around to make it easier to
extend in the future, but this is fine as well.

(...)

With the rc thing changed,

Reviewed-by: Cornelia Huck <cohuck@redhat.com>


