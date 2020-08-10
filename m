Return-Path: <SRS0=QvPl=BU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B9F6C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2020 16:04:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DAE1A2078E
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2020 16:04:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Cfl3Y7mh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DAE1A2078E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54050 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5AHi-0002Ws-5g
	for qemu-devel@archiver.kernel.org; Mon, 10 Aug 2020 12:04:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59162)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1k5AGq-0001nO-PF
 for qemu-devel@nongnu.org; Mon, 10 Aug 2020 12:03:32 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:44972
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1k5AGn-0003PT-Fn
 for qemu-devel@nongnu.org; Mon, 10 Aug 2020 12:03:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597075407;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dhjTJH/ytGUDzuAKkHpQ7/JZhJ7cKTZHMrNULMT6EWA=;
 b=Cfl3Y7mh2PjLDzji4EC5GMgFqn4OMlL7E2GOJtRaLvWY9g1VENWZWtyjA9DqNpvPLUr7F6
 2Q84YqFZITG8cbdZyFtBZmJ/3vKehBZqT2oYG40PIMw8IXmhfgb9qYNmUTEql0qjIdgWBn
 5eLtzuib7g6jwt/UaQqaJ82lmdf0xHc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-471-fVaJU4GYMlSlRwkSvOI1PA-1; Mon, 10 Aug 2020 12:03:20 -0400
X-MC-Unique: fVaJU4GYMlSlRwkSvOI1PA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 538CD1005510;
 Mon, 10 Aug 2020 16:03:18 +0000 (UTC)
Received: from localhost (ovpn-114-132.ams2.redhat.com [10.36.114.132])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C8DF87B92F;
 Mon, 10 Aug 2020 16:02:49 +0000 (UTC)
Date: Mon, 10 Aug 2020 17:02:48 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Jagannathan Raman <jag.raman@oracle.com>
Subject: Re: [PATCH v8 07/20] multi-process: add co-routines to communicate
 with remote
Message-ID: <20200810160248.GB66474@stefanha-x1.localdomain>
References: <cover.1596217462.git.jag.raman@oracle.com>
 <b57493752ed0ec04f44df915413e325acf641882.1596217462.git.jag.raman@oracle.com>
MIME-Version: 1.0
In-Reply-To: <b57493752ed0ec04f44df915413e325acf641882.1596217462.git.jag.raman@oracle.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="FkmkrVfFsRoUs1wW"
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/10 04:13:00
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: elena.ufimtseva@oracle.com, fam@euphon.net, swapnil.ingle@nutanix.com,
 john.g.johnson@oracle.com, qemu-devel@nongnu.org, kraxel@redhat.com,
 quintela@redhat.com, mst@redhat.com, armbru@redhat.com,
 kanth.ghatraju@oracle.com, felipe@nutanix.com, thuth@redhat.com,
 ehabkost@redhat.com, konrad.wilk@oracle.com, dgilbert@redhat.com,
 alex.williamson@redhat.com, thanos.makatos@nutanix.com, rth@twiddle.net,
 kwolf@redhat.com, berrange@redhat.com, mreitz@redhat.com,
 ross.lagerwall@citrix.com, marcandre.lureau@gmail.com, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--FkmkrVfFsRoUs1wW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jul 31, 2020 at 02:20:14PM -0400, Jagannathan Raman wrote:
> +/*
> + * Create if needed and enter co-routine to send the message to the
> + * remote channel ioc and wait for the reply.
> + * Returns the value from the reply message, sets the error on failure.
> + */
> +
> +uint64_t mpqemu_msg_send_and_await_reply(MPQemuMsg *msg, QIOChannel *ioc,
> +                                  Error **errp)
> +{
> +    MPQemuRequest req = {0};
> +    uint64_t ret = UINT64_MAX;
> +
> +    req.ioc = ioc;
> +    if (!req.ioc) {
> +        error_setg(errp, "Channel is set to NULL");
> +        return ret;
> +    }
> +
> +    req.msg = msg;
> +    req.ret = 0;
> +    req.finished = false;
> +
> +    req.co = qemu_coroutine_create(mpqemu_msg_send_co, &req);
> +    qemu_coroutine_enter(req.co);
> +
> +    while (!req.finished) {
> +        aio_poll(qemu_get_aio_context(), true);
> +    }

This is called from vcpu threads. aio_poll() does not release the global
mutex so all other vcpu threads are blocked until mpqemu communication
completes.

The simplest solution is to unlock the global mutex and call blocking,
non-coroutine versions of the send/recv code. That way other vcpu
threads can execute.

This means that the QEMU process would not use the mpqemu IOChannel in
the event loop.

The remote process would still use the IOChannel in the event loop,
however.

Stefan

--FkmkrVfFsRoUs1wW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl8xb6gACgkQnKSrs4Gr
c8j5Ogf+LjFVIml9m39/9H76AFmerro7gv+4o5Ff/sP15G7qhUCSCe4sP0whM5JN
kIOZL22iZ7W1K2G9AVIqY1VwXqPJ/eT6+li0kOXnBf1sPGGMjFhZ4XrOga0MF+Hh
AH9m2Ej9x21EKc5om52tIueGTS2ZuYSS86yCg7D0m0IRKRIfltJTBG+O4wBvC3z1
QAxZBoB+AJCmEtE3i8x532A5QyUDnUUqFjvmFM4u+thCbYePnD7OcylcLxVixnqt
FczACdTru5HhrdWIjEoBvVkhC4ATRGhWoFo5TGhj50HunHv51PGDX/TrC8pY6c/K
87eoHpAqWtbDAPt/Hk5HLGnhQ/P15g==
=kpgr
-----END PGP SIGNATURE-----

--FkmkrVfFsRoUs1wW--


