Return-Path: <SRS0=ZOtl=62=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BB8DCA90AF
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 15:58:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F31B7206DD
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 15:58:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KjITKJU3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F31B7206DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47410 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYXIX-0006Ys-6Q
	for qemu-devel@archiver.kernel.org; Tue, 12 May 2020 11:58:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43362)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jYXHv-00066z-N2
 for qemu-devel@nongnu.org; Tue, 12 May 2020 11:57:47 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:58063
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jYXHu-0003Ss-8S
 for qemu-devel@nongnu.org; Tue, 12 May 2020 11:57:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589299065;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=T0SyB5bznjiqJJhpXW8OAiDNHNJbHNwZA5NJxmtNPV8=;
 b=KjITKJU3F/Ojnil3B3S7EexzFDuQG33xmHVlVgJztjffaPzh7P3wfPtbIvPESSp/wKUCR4
 NDrjNCeClp6RA33mUjwo1dQpowQKyioHASCGhXY9Kk/JOoWJyWWw0zSkEFo6OaAEqq6xsC
 tDyrqEeGeVkA9uVT959OTmhadSpOZXg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-250-iwXHE7BrN26fRwx1pxmjvg-1; Tue, 12 May 2020 11:57:41 -0400
X-MC-Unique: iwXHE7BrN26fRwx1pxmjvg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2E5F1835B4A;
 Tue, 12 May 2020 15:57:39 +0000 (UTC)
Received: from localhost (ovpn-112-75.ams2.redhat.com [10.36.112.75])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B0DB75C1B2;
 Tue, 12 May 2020 15:57:30 +0000 (UTC)
Date: Tue, 12 May 2020 16:57:29 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: elena.ufimtseva@oracle.com
Subject: Re: [PATCH RESEND v6 23/36] multi-process: create IOHUB object to
 handle irq
Message-ID: <20200512155729.GM300009@stefanha-x1.localdomain>
References: <cover.1587614626.git.elena.ufimtseva@oracle.com>
 <fc698970e58de0c205a736261e1ac9cc6f37acba.1587614626.git.elena.ufimtseva@oracle.com>
MIME-Version: 1.0
In-Reply-To: <fc698970e58de0c205a736261e1ac9cc6f37acba.1587614626.git.elena.ufimtseva@oracle.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="UeXZ3FjlYZvuln/G"
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/12 02:02:05
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: fam@euphon.net, john.g.johnson@oracle.com, swapnil.ingle@nutanix.com,
 mst@redhat.com, qemu-devel@nongnu.org, kraxel@redhat.com, jag.raman@oracle.com,
 quintela@redhat.com, armbru@redhat.com, kanth.ghatraju@oracle.com,
 felipe@nutanix.com, thuth@redhat.com, ehabkost@redhat.com,
 konrad.wilk@oracle.com, dgilbert@redhat.com, liran.alon@oracle.com,
 thanos.makatos@nutanix.com, rth@twiddle.net, kwolf@redhat.com,
 berrange@redhat.com, mreitz@redhat.com, ross.lagerwall@citrix.com,
 marcandre.lureau@gmail.com, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--UeXZ3FjlYZvuln/G
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 22, 2020 at 09:13:58PM -0700, elena.ufimtseva@oracle.com wrote:
> diff --git a/include/remote/iohub.h b/include/remote/iohub.h
> new file mode 100644
> index 0000000000..7a488a8c38
> --- /dev/null
> +++ b/include/remote/iohub.h
> @@ -0,0 +1,50 @@
> +/*
> + * IO Hub for remote device
> + *
> + * Copyright =A9 2018, 2020 Oracle and/or its affiliates.
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or la=
ter.
> + * See the COPYING file in the top-level directory.
> + *
> + */
> +
> +#ifndef REMOTE_IOHUB_H
> +#define REMOTE_IOHUB_H
> +
> +#include <sys/types.h>
> +
> +#include "qemu/osdep.h"
> +#include "hw/pci/pci.h"
> +#include "qemu/event_notifier.h"
> +#include "qemu/thread-posix.h"
> +#include "io/mpqemu-link.h"
> +
> +#define REMOTE_IOHUB_NB_PIRQS    8

We only use pirqs 4-7 based on the (slot + intx) % 4 + 4 formula. Why is
it necessary to reserve 8 irqs?

> +
> +#define REMOTE_IOHUB_DEV         31
> +#define REMOTE_IOHUB_FUNC        0
> +
> +#define TYPE_REMOTE_IOHUB_DEVICE "remote-iohub"
> +#define REMOTE_IOHUB_DEVICE(obj) \
> +    OBJECT_CHECK(RemoteIOHubState, (obj), TYPE_REMOTE_IOHUB_DEVICE)
> +
> +typedef struct ResampleToken {
> +    void *iohub;
> +    int pirq;
> +} ResampleToken;
> +
> +typedef struct RemoteIOHubState {
> +    PCIDevice d;
> +    uint8_t irq_num[PCI_SLOT_MAX][PCI_NUM_PINS];

This is a fixed mapping based on a formula. Is there any need to store
it in an array?

> diff --git a/io/mpqemu-link.c b/io/mpqemu-link.c
> index 5cb93fc47b..ea519a980e 100644
> --- a/io/mpqemu-link.c
> +++ b/io/mpqemu-link.c
> @@ -389,6 +389,7 @@ bool mpqemu_msg_valid(MPQemuMsg *msg)
>          break;
>      case BAR_WRITE:
>      case BAR_READ:
> +    case SET_IRQFD:
>          if (msg->size !=3D sizeof(msg->data1)) {

Wait, this is checking for sizeof(msg->data1) but the message defines
its own struct!

> +void process_set_irqfd_msg(PCIDevice *pci_dev, MPQemuMsg *msg)
> +{
> +    RemMachineState *machine =3D REMOTE_MACHINE(current_machine);
> +    RemoteIOHubState *iohub =3D machine->iohub;
> +    int pirq =3D remote_iohub_map_irq(pci_dev, msg->data1.set_irqfd.intx=
);

intx has not been validated.

--UeXZ3FjlYZvuln/G
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl66x2kACgkQnKSrs4Gr
c8h5bAf9EvS4wUiOKgzNTZ5QrOZ8trhCy+TgM5kWcKIFiiMsYwecBlmXF9ynrvgy
clf5Y0hdfQEMGjTClRKXSEJsqE7G1hI63jQ3ol4/IjsGZypuzU8RnnbP6DIwVx1e
ZDWASSfqHkzTeeFBJJF8tt4z018hDUBK9N/xfCdWYSSDp3mFQARJWT3/k4pa/Fil
pXH5qIx/a0fjnGL5pGenYLVcu89W0OZVJX+3x8xIJScXDdWVSLbj1PjCesVlfi4m
Z5CUsoZ4uVImEkGaKFQcVL8IFu9CQ+zMnXT5pwo2jMWQrX4Y7sTmZf9VdKLGMhqR
rjAVPVX3SaKVw44gvUgzULkHB0FjUg==
=ifuH
-----END PGP SIGNATURE-----

--UeXZ3FjlYZvuln/G--


