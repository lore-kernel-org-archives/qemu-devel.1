Return-Path: <SRS0=QD06=ZF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5BD6C4741F
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2019 16:31:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F0540233C5
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2019 15:55:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XeVYnGfK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0540233C5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46722 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iUuz3-00079N-6F
	for qemu-devel@archiver.kernel.org; Wed, 13 Nov 2019 10:55:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38631)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1iUuy7-0006XZ-8J
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 10:54:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1iUuy5-0004U0-Vb
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 10:54:07 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:25497
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1iUuy5-0004Tq-RS
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 10:54:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573660445;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=VVJ8fJkqlMO3n9KhheC4nUSbBS6LFb8Oj7qlcjLuq38=;
 b=XeVYnGfKxISVoJXFoOgsU4EHyI/6bJKpOwIVg2tPpxdFdEqE1cfQnlqbB0cexci3YJcMVA
 gILltGd4iUIoyOwFjPGRFBHgOSAbdL9qnOJzShkHAF6Iy7FjNl/BGCyEGRwGcble9q6+03
 Oec1T3NE7NLQJ2tWYA0JDZQPjM5lo2s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-331-azM27VtDOv-Qc_woqjuaHw-1; Wed, 13 Nov 2019 10:54:01 -0500
X-MC-Unique: azM27VtDOv-Qc_woqjuaHw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BCF80802921;
 Wed, 13 Nov 2019 15:53:59 +0000 (UTC)
Received: from localhost (ovpn-117-166.ams2.redhat.com [10.36.117.166])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9AAF59472;
 Wed, 13 Nov 2019 15:53:53 +0000 (UTC)
Date: Wed, 13 Nov 2019 15:53:52 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Jagannathan Raman <jag.raman@oracle.com>
Subject: Re: [RFC v4 PATCH 07/49] multi-process: define mpqemu-link object
Message-ID: <20191113155352.GC563983@stefanha-x1.localdomain>
References: <cover.1571905346.git.jag.raman@oracle.com>
 <b0bc2a517b0a41eb138ed4127aebe8a3952daec6.1571905346.git.jag.raman@oracle.com>
MIME-Version: 1.0
In-Reply-To: <b0bc2a517b0a41eb138ed4127aebe8a3952daec6.1571905346.git.jag.raman@oracle.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="XWOWbaMNXpFDWE00"
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
Cc: elena.ufimtseva@oracle.com, fam@euphon.net, thuth@redhat.com,
 john.g.johnson@oracle.com, ehabkost@redhat.com, konrad.wilk@oracle.com,
 quintela@redhat.com, berrange@redhat.com, mst@redhat.com,
 qemu-devel@nongnu.org, armbru@redhat.com, ross.lagerwall@citrix.com,
 kanth.ghatraju@oracle.com, kraxel@redhat.com, kwolf@redhat.com,
 pbonzini@redhat.com, liran.alon@oracle.com, marcandre.lureau@gmail.com,
 mreitz@redhat.com, dgilbert@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--XWOWbaMNXpFDWE00
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Oct 24, 2019 at 05:08:48AM -0400, Jagannathan Raman wrote:
> +#ifndef MPQEMU_LINK_H
> +#define MPQEMU_LINK_H
> +
> +#include "qemu/osdep.h"
> +#include "qemu-common.h"
> +
> +#include <stddef.h>
> +#include <stdint.h>

These are already included by "qemu/osdep.h".

> +#include <pthread.h>

Is <pthread.h> needed?

> +
> +#include "qom/object.h"
> +#include "qemu/thread.h"
> +
> +#define TYPE_MPQEMU_LINK "mpqemu-link"
> +#define MPQEMU_LINK(obj) \
> +    OBJECT_CHECK(MPQemuLinkState, (obj), TYPE_MPQEMU_LINK)
> +
> +#define REMOTE_MAX_FDS 8
> +
> +#define MPQEMU_MSG_HDR_SIZE offsetof(MPQemuMsg, data1.u64)
> +
> +/**
> + * mpqemu_cmd_t:
> + * CONF_READ        PCI config. space read
> + * CONF_WRITE       PCI config. space write
> + *
> + * proc_cmd_t enum type to specify the command to be executed on the remote
> + * device.
> + */
> +typedef enum {
> +    INIT = 0,
> +    CONF_READ,
> +    CONF_WRITE,
> +    MAX,
> +} mpqemu_cmd_t;

Please allow for future non-PCI devices by clearly naming PCI-specific
commands and including a bus type in the initialization messages.

> diff --git a/io/mpqemu-link.c b/io/mpqemu-link.c
> new file mode 100644
> index 0000000..b39f4d0
> --- /dev/null
> +++ b/io/mpqemu-link.c
> @@ -0,0 +1,309 @@
> +/*
> + * Communication channel between QEMU and remote device process
> + *
> + * Copyright 2019, Oracle and/or its affiliates.
> + *
> + * Permission is hereby granted, free of charge, to any person obtaining a copy
> + * of this software and associated documentation files (the "Software"), to deal
> + * in the Software without restriction, including without limitation the rights
> + * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
> + * copies of the Software, and to permit persons to whom the Software is
> + * furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice shall be included in
> + * all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
> + * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
> + * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
> + * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
> + * THE SOFTWARE.
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qemu-common.h"
> +
> +#include <assert.h>
> +#include <errno.h>
> +#include <pthread.h>
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <sys/types.h>
> +#include <sys/socket.h>
> +#include <sys/un.h>
> +#include <unistd.h>
> +#include <limits.h>
> +#include <poll.h>

Many of these are already included by "qemu/osdep.h".  Some of them
shouldn't be used directly because QEMU or glib have abstractions that
hide the platform-specific differences (e.g. pthread, poll).

> +MPQemuLinkState *mpqemu_link_create(void)
> +{
> +    return MPQEMU_LINK(object_new(TYPE_MPQEMU_LINK));
> +}

I'm not sure what the purpose of this object is.  mpqemu_link_create()
suggests the objects will be created internally instead of via -object
mpqemu-link,..., which is unusual.

mpqemu_msg_send() and mpqemu_msg_recv() seem to be the main functions
but they do not even use their MPQemuLinkState *s argument.

> +void mpqemu_start_coms(MPQemuLinkState *s)
> +{
> +
> +    g_assert(g_source_attach(&s->com->gsrc, s->ctx));
> +
> +    g_main_loop_run(s->loop);
> +}

There is already IOThread if you need an event loop thread.  But does
this need to be its own thread?  The communication should be
asynchronous and therefore it can run in the main event loop or any
existing IOThread.

--XWOWbaMNXpFDWE00
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl3MJxAACgkQnKSrs4Gr
c8jvXQf+IAkEW92a0592aS2IyA7cghQOiXoU8B9gwDIIgd8IQSd25F4761ODNJ9K
qkMJkQrAUfoNSUE4QRc+HnxzZss0SXqT3RM74vhcudEYm7rRG93eBiuHP3fyc1I0
kO9fe+XXwYE3eumkS8t2MUVnL69BxFDg4WSTUvC3Xi6BBb7Gbg6sBbTFEtacuHhZ
KifIVbA8iUAPy/5CaYY1r4wa/MqOPixF8G25MxQcEzZoVXqWNPJLOEJjNFiEJPfr
KCgSBiScCMZXftVP6Ts7MXNxKr3Xh5Bc06SZ9GBIdvukRriK2bv/SBrdu7RIcZYX
zHfQyIrzpOhJ1QFUzNKLw8Af4iX8Lw==
=JslS
-----END PGP SIGNATURE-----

--XWOWbaMNXpFDWE00--


