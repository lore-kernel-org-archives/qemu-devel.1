Return-Path: <SRS0=qPFU=AM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BF91C433E0
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 06:53:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A50B20663
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 06:53:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M6WI9Y7Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A50B20663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53492 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqWd2-0004Ir-OR
	for qemu-devel@archiver.kernel.org; Wed, 01 Jul 2020 02:53:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45320)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jqWcT-0003pF-FM
 for qemu-devel@nongnu.org; Wed, 01 Jul 2020 02:53:21 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:51667
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jqWcP-0005kD-Pa
 for qemu-devel@nongnu.org; Wed, 01 Jul 2020 02:53:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593586396;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mPxv82h+XsGYkibwxrO1tUskFpUtkxOlVZJPmET32Sg=;
 b=M6WI9Y7YjLy2GXaTIoeufWP2wy7lCO3wwZCfTRLh81HRjEkTHs4L/9KnixJwVK7VrXAFuL
 Nyk9QseNByJs0pu3iDTvmOdRTnvUb1cdw2NpkFMVkpm6xcKVP69PoQ8R04JFLlJ25I+JLy
 6JPEN+4Iso3C58smYh+DFjrf/xEZYWo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-25-Bk6D4PTxODC3QJtnhOyQHg-1; Wed, 01 Jul 2020 02:53:14 -0400
X-MC-Unique: Bk6D4PTxODC3QJtnhOyQHg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C909380183C;
 Wed,  1 Jul 2020 06:53:12 +0000 (UTC)
Received: from localhost (ovpn-113-121.ams2.redhat.com [10.36.113.121])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E82A55DAB0;
 Wed,  1 Jul 2020 06:53:05 +0000 (UTC)
Date: Wed, 1 Jul 2020 07:53:04 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: elena.ufimtseva@oracle.com
Subject: Re: [PATCH v7 09/21] multi-process: Initialize message handler in
 remote device
Message-ID: <20200701065304.GB126613@stefanha-x1.localdomain>
References: <cover.1593273671.git.elena.ufimtseva@oracle.com>
 <6918de2756774d1c6e2c0f9105d8eeceff28938c.1593273671.git.elena.ufimtseva@oracle.com>
MIME-Version: 1.0
In-Reply-To: <6918de2756774d1c6e2c0f9105d8eeceff28938c.1593273671.git.elena.ufimtseva@oracle.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="ZoaI/ZTpAVc4A5k6"
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=stefanha@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/01 01:29:47
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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

--ZoaI/ZTpAVc4A5k6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Jun 27, 2020 at 10:09:31AM -0700, elena.ufimtseva@oracle.com wrote:
> diff --git a/hw/i386/remote-msg.c b/hw/i386/remote-msg.c
> new file mode 100644
> index 0000000000..58e24ab2ad
> --- /dev/null
> +++ b/hw/i386/remote-msg.c
> @@ -0,0 +1,52 @@
> +#include "qemu/osdep.h"
> +#include "qemu-common.h"
> +
> +#include "hw/i386/remote.h"
> +#include "io/channel.h"
> +#include "io/mpqemu-link.h"
> +#include "qapi/error.h"
> +#include "sysemu/runstate.h"
> +
> +gboolean mpqemu_process_msg(QIOChannel *ioc, GIOCondition cond,
> +                            gpointer opaque)
> +{
> +    Error *local_err = NULL;
> +    MPQemuMsg msg = { 0 };
> +
> +    if (cond & G_IO_HUP) {
> +        qemu_system_shutdown_request(SHUTDOWN_CAUSE_GUEST_SHUTDOWN);
> +    }

Missing return FALSE?

> +
> +    if (cond & (G_IO_ERR | G_IO_NVAL)) {
> +        error_setg(&local_err, "Error %d while processing message from proxy \
> +                   in remote process pid=%d", errno, getpid());

This sets and leaks local_err. Should this be error_report()?

> +        return FALSE;
> +    }
> +
> +    if (mpqemu_msg_recv(&msg, ioc) < 0) {
> +        return FALSE;
> +    }
> +
> +    if (!mpqemu_msg_valid(&msg)) {
> +        error_report("Received invalid message from proxy \
> +                     in remote process pid=%d", getpid());
> +        return TRUE;
> +    }

Why return TRUE here but FALSE in previous error cases?

> +
> +    switch (msg.cmd) {
> +    default:
> +        error_setg(&local_err, "Unknown command (%d) received from proxy \
> +                   in remote process pid=%d", msg.cmd, getpid());
> +    }
> +
> +    if (msg.data2) {
> +        free(msg.data2);
> +    }

A mpqemu_msg_cleanup() function in mpqemu-link.h would be nice. That way
the code that frees data2 can be next to the code that allocates it.

Do passed file descriptors need to be closed too (especially in cases
where the command normally does not expect passed file descriptors)?

--ZoaI/ZTpAVc4A5k6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl78MtAACgkQnKSrs4Gr
c8hGEgf/VwqBv4RkIxypvTgOedATR2ol4Q8ceLZZTA+QWMU4kLr3/u4mvGIhgPHo
OtRDJJWDnwmTkfDA3J6VJgmkzcyvdA5BjP8hH8H3wrf3pUw91V0D42ozXbVguWEs
ldyVjwzW9dgYIwc4J2AvFdm+SBu+SbDQxYrc55tlo+BgpZIQBJ2ugKtzAClwUQrx
IkfPMzF98Es1gfWfZP68c0slxnZmN6CDXyXWcEsdvhjRLFuovw1AocosE7YK0ivv
56c55PWa5aIyGU3dwye1Vinp+nx+JoT5lagstbpK0i+zya9vaPVSjuim5jRxunoi
sHHn9Faozr8lz2Xr7rlU5W2Zgf9n0A==
=SvyS
-----END PGP SIGNATURE-----

--ZoaI/ZTpAVc4A5k6--


