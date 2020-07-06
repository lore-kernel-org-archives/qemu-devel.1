Return-Path: <SRS0=h+Ky=AR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB11FC433E0
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 12:05:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A4E3E206E9
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 12:05:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LX6FquHB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4E3E206E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41592 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jsPsc-0006Yc-VM
	for qemu-devel@archiver.kernel.org; Mon, 06 Jul 2020 08:05:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51294)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jsPrr-00060R-Ij
 for qemu-devel@nongnu.org; Mon, 06 Jul 2020 08:05:03 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:39105
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jsPrp-0006lu-QM
 for qemu-devel@nongnu.org; Mon, 06 Jul 2020 08:05:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594037100;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Cjvw2gz/ks0M8X/sdpwjhdnM4lcXvyssuPZR5wcUK5M=;
 b=LX6FquHBylYFrbHHECaTSL2oWabKj316LZo+0Eo9zpHPqV+D+zrJUcsboGYOzy7znpCDyU
 yZriCzNDmHxpahjmdpUAxG8uinQDHUHFlY6IB9gi/L3rc4IpVadx7KkXkAzanrwlMVE9mT
 6GfZRNh8g9wMQyPQmpkTStxnd51tZlw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-471-t6-g2H3OM1aIWfTg2UzXmA-1; Mon, 06 Jul 2020 08:04:58 -0400
X-MC-Unique: t6-g2H3OM1aIWfTg2UzXmA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D46D018FF67B;
 Mon,  6 Jul 2020 12:04:56 +0000 (UTC)
Received: from localhost (ovpn-114-217.ams2.redhat.com [10.36.114.217])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 60526106F74C;
 Mon,  6 Jul 2020 12:04:54 +0000 (UTC)
Date: Mon, 6 Jul 2020 13:04:53 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Subject: Re: [PATCH v3 16/16] block/nvme: Use per-queuepair IRQ notifier and
 AIO context
Message-ID: <20200706120453.GE342708@stefanha-x1.localdomain>
References: <20200704213051.19749-1-philmd@redhat.com>
 <20200704213051.19749-17-philmd@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200704213051.19749-17-philmd@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="uCPdOCrL+PnN2Vxy"
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=stefanha@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/06 01:52:41
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Maxim Levitsky <mlevitsk@redhat.com>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--uCPdOCrL+PnN2Vxy
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 04, 2020 at 11:30:51PM +0200, Philippe Mathieu-Daud=E9 wrote:
> @@ -683,6 +676,17 @@ static bool nvme_add_io_queue(BlockDriverState *bs, =
Error **errp)
>      s->queues =3D g_renew(NVMeQueuePair *, s->queues, n + 1);
>      s->queues[n] =3D q;
>      s->nr_queues++;
> +
> +    ret =3D qemu_vfio_pci_init_irq(s->vfio,
> +                                 &s->queues[n]->irq_notifier,
> +                                 VFIO_PCI_MSIX_IRQ_INDEX, errp);
> +    if (ret) {
> +        goto out_error;
> +    }
> +    aio_set_event_notifier(aio_context,
> +                           &s->queues[n]->irq_notifier,
> +                           false, nvme_handle_event, nvme_poll_cb);

s->queues[n] can be replaced with q to make the code easier to read.

> @@ -784,12 +782,14 @@ static int nvme_init(BlockDriverState *bs, const ch=
ar *device, int namespace,
>          }
>      }
> =20
> -    ret =3D qemu_vfio_pci_init_irq(s->vfio, &s->irq_notifier,
> +    ret =3D qemu_vfio_pci_init_irq(s->vfio,
> +                                 &s->queues[QUEUE_INDEX_ADMIN]->irq_noti=
fier,
>                                   VFIO_PCI_MSIX_IRQ_INDEX, errp);

QEMU is setting up only 1 MSI-X vector that is shared by the admin and
all io queues?

I'm not very familiar with the VFIO ioctls but I guess this call
replaces the admin queue's irq_notifier registration with VFIO. So now
the queue's irq_notifier is signalled on admin cq events. The admin
irq_notifier is no longer signalled. This seems broken.

If there are multiple irq_notifiers then multiple MSI-X vectors are
needed.

Stefan

--uCPdOCrL+PnN2Vxy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl8DE2UACgkQnKSrs4Gr
c8hq7gf/UaRxkOYkqtm21zr6M1kWkH3foOTnNNv4+KNp13bIYOURbi82r868UG+v
ZpE/1hhflhlhrkM/dM8ldlR4zTMUi2hxSn22cnPhOU49rkCVsvsjXVT+4C21l8m0
dJ/Tc70XmY5CQMd3uF1G0eA6T1TG2vzS3x1SOExiN21hgobu5rHPabC3sE9uwC+j
uCbE9D+ilE0XGHp8+pRATaz3PIrFKynJIRUx7FPI2w82XwzQuST5+PfzRwYdXPRP
zGICPjivFYEU7GC1ODkgQCG4Z+YNK0F9OwRyLtJ+q7vDk+dnbdT0UfOfF7x7x9qr
+niiTtnJDCEY5W4lEBmOWDPt+xPG0A==
=wOH2
-----END PGP SIGNATURE-----

--uCPdOCrL+PnN2Vxy--


