Return-Path: <SRS0=37Ja=DO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA921C4363D
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 14:28:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 041442076C
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 14:28:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PVqQ3tdf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 041442076C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56360 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQAR0-0002GD-0f
	for qemu-devel@archiver.kernel.org; Wed, 07 Oct 2020 10:28:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41148)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kQAOm-0001jY-WD
 for qemu-devel@nongnu.org; Wed, 07 Oct 2020 10:26:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:30302)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kQAOi-0003KT-HV
 for qemu-devel@nongnu.org; Wed, 07 Oct 2020 10:26:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602080787;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DsFy08Vr5EC/2gKrq8ms9mRwDUigCZD0N+lBn8AJl+Y=;
 b=PVqQ3tdfIAkahIGMHloqbQQ7wlrf29kCFrXy4agw6i+dHC2R38skJtTws8z01nCP8SZnZA
 ZSlq2lm82GohxQL+bK5Z73q1zYp16zZfwAmcHJW9GDxRQ6JRBR2GO5wdYgpwYAksEG4VWr
 eL5s2v8/2o58A8D5K91KcNfGlrEpsOc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-91-eAx63gtxNX6ay_Q4dGkyig-1; Wed, 07 Oct 2020 10:26:23 -0400
X-MC-Unique: eAx63gtxNX6ay_Q4dGkyig-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 86011805EF9;
 Wed,  7 Oct 2020 14:26:21 +0000 (UTC)
Received: from localhost (ovpn-115-47.ams2.redhat.com [10.36.115.47])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2981D6EF42;
 Wed,  7 Oct 2020 14:26:15 +0000 (UTC)
Date: Wed, 7 Oct 2020 15:26:14 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: elena.ufimtseva@oracle.com
Subject: Re: [PATCH v10 07/19] multi-process: Initialize message handler in
 remote device
Message-ID: <20201007142614.GB113587@stefanha-x1.localdomain>
References: <cover.1601923020.git.elena.ufimtseva@oracle.com>
 <5d30e11c97869c7ae9ce6fd9c3318098ee8f23ec.1601923020.git.elena.ufimtseva@oracle.com>
MIME-Version: 1.0
In-Reply-To: <5d30e11c97869c7ae9ce6fd9c3318098ee8f23ec.1601923020.git.elena.ufimtseva@oracle.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="Yylu36WmvOXNoKYn"
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/07 00:54:30
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.742,
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
Cc: fam@euphon.net, john.g.johnson@oracle.com, swapnil.ingle@nutanix.com,
 mst@redhat.com, qemu-devel@nongnu.org, kraxel@redhat.com, jag.raman@oracle.com,
 quintela@redhat.com, armbru@redhat.com, kanth.ghatraju@oracle.com,
 felipe@nutanix.com, thuth@redhat.com, ehabkost@redhat.com,
 konrad.wilk@oracle.com, dgilbert@redhat.com, thanos.makatos@nutanix.com,
 rth@twiddle.net, kwolf@redhat.com, berrange@redhat.com, mreitz@redhat.com,
 ross.lagerwall@citrix.com, marcandre.lureau@gmail.com, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--Yylu36WmvOXNoKYn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 05, 2020 at 11:50:55AM -0700, elena.ufimtseva@oracle.com wrote:
> From: Jagannathan Raman <jag.raman@oracle.com>
>=20
> Initializes the message handler function in the remote process. It is
> called whenever there's an event pending on QIOChannel that registers
> this function.
>=20
> Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
> Signed-off-by: John G Johnson <john.g.johnson@oracle.com>
> Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
> ---
>  MAINTAINERS              |  1 +
>  hw/i386/meson.build      |  1 +
>  hw/i386/remote-msg.c     | 61 ++++++++++++++++++++++++++++++++++++++++
>  include/hw/i386/remote.h |  9 ++++++
>  4 files changed, 72 insertions(+)
>  create mode 100644 hw/i386/remote-msg.c

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--Yylu36WmvOXNoKYn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl990AYACgkQnKSrs4Gr
c8jviwf/dTk4utqX7Oz8MSlzCb9Ft6kf9s2FC2BjRiCPgb+wOmpvvF8e/Ox94yt3
r29Dffuquy2MZXwvS4IswottkdiGgH/DVXrP0JDfAWfpk5GWpCLJIe8LSDsv4RXg
CmGBGltj0VitH75vdgiWTseZHh9035NeY4cL6PmwH3FYeXpTF5GkYofj6Cl0gYfq
zcVY89zt+aZhLBf+PjDYHwsGKwi+NkSlHFUonWWa69mkruwwj6sfTZlVgEW60kN7
s/TFq5aNoOh0MBmmHS8va826TCNIZDw7gzhllOmBIw7ZeBZVzdCjIBhhqViB7Kmy
bIb9oaMOp0LD8QYHxMt64pA0btY9rw==
=N/ON
-----END PGP SIGNATURE-----

--Yylu36WmvOXNoKYn--


