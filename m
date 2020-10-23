Return-Path: <SRS0=OdKR=D6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 054AAC388F9
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 13:54:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 388F1208C3
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 13:54:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="doDSCOb/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 388F1208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54614 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVxWU-0003zt-Up
	for qemu-devel@archiver.kernel.org; Fri, 23 Oct 2020 09:54:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33406)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kVxVi-0003Uh-8R
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 09:53:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:29392)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kVxVd-0005Oz-9p
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 09:53:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603461211;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LIGUOIiet6XMT9IEWXQwMSh8XbxEBCvCFuHeGgLV4SQ=;
 b=doDSCOb/cHKBA7GF0jK9xPe5Y8IQS6fgnshaCYMOnxYoGP99OrPt6X5x8IzOs2t26aCF+l
 qEWKQquR5yTajLBLveGl2aSBF7JKm4bPUqMNvzMuTRRNVibwHHL2NSAxWpjRmcNgwPQLAz
 Rlco8Ywu4AOqHH7dZNBCRVva6e0Kl6c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-213-_DDTjBXtP9aQK4NF-bMACA-1; Fri, 23 Oct 2020 09:53:30 -0400
X-MC-Unique: _DDTjBXtP9aQK4NF-bMACA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B44E3804B7C;
 Fri, 23 Oct 2020 13:53:27 +0000 (UTC)
Received: from localhost (ovpn-114-178.ams2.redhat.com [10.36.114.178])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B27DF5C1D0;
 Fri, 23 Oct 2020 13:53:25 +0000 (UTC)
Date: Fri, 23 Oct 2020 14:53:24 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Jagannathan Raman <jag.raman@oracle.com>
Subject: Re: [PATCH v11 06/19] multi-process: define MPQemuMsg format and
 transmission functions
Message-ID: <20201023135324.GD812157@stefanha-x1.localdomain>
References: <cover.1602784930.git.jag.raman@oracle.com>
 <32b85be52b3901160de03aac396ed516d748204b.1602784930.git.jag.raman@oracle.com>
MIME-Version: 1.0
In-Reply-To: <32b85be52b3901160de03aac396ed516d748204b.1602784930.git.jag.raman@oracle.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="WChQLJJJfbwij+9x"
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/23 01:44:00
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

--WChQLJJJfbwij+9x
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Oct 15, 2020 at 02:04:59PM -0400, Jagannathan Raman wrote:
> +void mpqemu_msg_recv(MPQemuMsg *msg, QIOChannel *ioc, Error **errp)
> +{
> +    Error *local_err = NULL;
> +    int *fds = NULL;
> +    size_t nfds = 0;
> +    ssize_t len;
> +
> +    len = mpqemu_read(ioc, (void *)msg, MPQEMU_MSG_HDR_SIZE, &fds, &nfds,
> +                      &local_err);
> +    if (!local_err) {
> +        if (len == -EIO) {
> +            error_setg(&local_err, "Connection closed.");
> +            goto fail;
> +        }
> +        if (len < 0) {
> +            error_setg(&local_err, "Message length is less than 0");
> +            goto fail;
> +        }
> +        if (len != MPQEMU_MSG_HDR_SIZE) {
> +            error_setg(&local_err, "Message header corrupted");
> +            goto fail;
> +        }
> +    } else {
> +        goto fail;
> +    }
> +
> +    if (msg->size > sizeof(msg->data)) {
> +        error_setg(&local_err, "Invalid size for message");
> +        goto fail;
> +    }
> +
> +    if (mpqemu_read(ioc, (void *)&msg->data, msg->size, NULL, NULL,
> +                    &local_err) < 0) {
> +        goto fail;
> +    }
> +
> +    msg->num_fds = nfds;
> +    if (nfds) {
> +        memcpy(msg->fds, fds, nfds * sizeof(int));

I can't find anything that limits nfds to REMOTE_MAX_FDS. This looks
like a buffer overflow.

--WChQLJJJfbwij+9x
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl+S4FQACgkQnKSrs4Gr
c8gRGQf5ASEPsD+kiqqVmI06lfhpoWolwi5pOg+ajMOn9IM9lgN+bwSeFJuQ/5oU
eGXN5u3ZwJSGYhtF10TvqsbzZg5L2+7mv3N6fvWeK2XU6oMReB9K8Y6K7o9+Scib
wD9ulxZzg1boVgqzdcPaRzNcYTcwbjNrhbP76Du4F5jHrxfTkEUUYaBJzsuiWfhg
3ZRrESPsXgNmeFy7QMZkYqRXFvFkT9z8/JqUV2g5P/F3/aPLykopSpAVk4xVMmGZ
Jt9aTDQwNgdwkdGlYXcPhS2FxgOTqpHGUHh8KVEBu23Dg4zl6Hom4ZzqLtZSs/Rk
sqh90IywM1SHBRO6/cYqyVfANE4E4w==
=tl5x
-----END PGP SIGNATURE-----

--WChQLJJJfbwij+9x--


