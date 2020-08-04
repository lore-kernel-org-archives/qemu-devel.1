Return-Path: <SRS0=UEgn=BO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B15BDC433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2020 12:59:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 80C922075A
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2020 12:59:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f3TQ9NPq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80C922075A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52766 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k2wXU-00025l-Qu
	for qemu-devel@archiver.kernel.org; Tue, 04 Aug 2020 08:59:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49300)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1k2wWt-0001fw-0n
 for qemu-devel@nongnu.org; Tue, 04 Aug 2020 08:58:55 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:27232
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1k2wWr-0003Dp-Gu
 for qemu-devel@nongnu.org; Tue, 04 Aug 2020 08:58:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596545932;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=L1RqonMz7BzfOEmTKXi1pC2feABOyly6vtpf9a9ZAGM=;
 b=f3TQ9NPq3/7Gxez5qPlm6bBgibP4UjF9Z+DWhwhLSFXyFbD0rVSOiAcGk0g4BjZeByMhCJ
 ZFSt4YNA5J7i+A5eUb3ef+agWNszymnjwuEytU7lZlu4Z3jBTFAwX2rzMZZ+bWCaG+tg0R
 hB68zp1IvJ5eksQmeb03VkQ3bBZqB1g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-293-xsZ-fqyBPzqpMbRtA5U4aQ-1; Tue, 04 Aug 2020 08:58:51 -0400
X-MC-Unique: xsZ-fqyBPzqpMbRtA5U4aQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6F9821B18BC2;
 Tue,  4 Aug 2020 12:58:49 +0000 (UTC)
Received: from localhost (ovpn-112-116.ams2.redhat.com [10.36.112.116])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C4355282E3;
 Tue,  4 Aug 2020 12:58:38 +0000 (UTC)
Date: Tue, 4 Aug 2020 13:58:37 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Jagannathan Raman <jag.raman@oracle.com>
Subject: Re: [PATCH v8 08/20] multi-process: Initialize message handler in
 remote device
Message-ID: <20200804125837.GA1286828@stefanha-x1.localdomain>
References: <cover.1596217462.git.jag.raman@oracle.com>
 <0851c9322a54f6cba2de750529f9ebf21e1ba50e.1596217462.git.jag.raman@oracle.com>
MIME-Version: 1.0
In-Reply-To: <0851c9322a54f6cba2de750529f9ebf21e1ba50e.1596217462.git.jag.raman@oracle.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="W/nzBZO5zC0uMSeA"
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/04 01:01:15
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

--W/nzBZO5zC0uMSeA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jul 31, 2020 at 02:20:15PM -0400, Jagannathan Raman wrote:
> +gboolean mpqemu_process_msg(QIOChannel *ioc, GIOCondition cond,
> +                            gpointer opaque)
> +{
> +    PCIDevice *pci_dev = (PCIDevice *)opaque;
> +    Error *local_err = NULL;
> +    MPQemuMsg msg = { 0 };
> +
> +    if (cond & G_IO_HUP) {
> +        qemu_system_shutdown_request(SHUTDOWN_CAUSE_GUEST_SHUTDOWN);
> +        return FALSE;
> +    }
> +
> +    if (cond & (G_IO_ERR | G_IO_NVAL)) {
> +        error_report("Error %d while processing message from proxy \
> +                   in remote process pid=%d", errno, getpid());

String literals don't wrap with backslash in C. Please use:

  "Error %d while processing message from proxy "
  "in remote process pid=%d", ...

instead.

> +        return FALSE;
> +    }
> +
> +    mpqemu_msg_recv(&msg, ioc, &local_err);
> +    if (local_err) {
> +        goto exit;
> +    }
> +
> +    if (!mpqemu_msg_valid(&msg)) {
> +        error_report("Received invalid message from proxy \
> +                     in remote process pid=%d", getpid());

Same here.

--W/nzBZO5zC0uMSeA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl8pW30ACgkQnKSrs4Gr
c8g4bQf+OEUuv1fNRU3zD7whprEdNH4mz8QffFxYQ4EtJFgchWEEnm9gmNzddWT/
PzwxunLzGgQrqPAifxFRzjTg1xRkCcxoGDxcxPtokx/j9HF0Eu/RgmxNCmio1zX5
kzx5wMQyRgyMDGkmbBfJG/V/w5IQScxIbdknegyUucDfbJBejoHc534uqB7e3+LK
9Um/dtipaoZUDsb9ROmftP+U0RtXBm01emgkQh4R1mb8Pln64Rr7NV/r6pw4ZyGT
kvSEnS/rh3FXuoppJZGdXtCcM0FGzKiq6eTx/C7qJenO69rnEYMJoFvE1O0NhJe5
0eOF3Uyf4zc2EISSYwQxJYJzwIsTdA==
=5HDv
-----END PGP SIGNATURE-----

--W/nzBZO5zC0uMSeA--


