Return-Path: <SRS0=ZOtl=62=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B9FECA90AF
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 16:14:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 30A21206B7
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 16:14:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aqWerh16"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30A21206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60140 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYXXo-0002cq-E8
	for qemu-devel@archiver.kernel.org; Tue, 12 May 2020 12:14:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45832)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jYXWk-0001I3-Jh
 for qemu-devel@nongnu.org; Tue, 12 May 2020 12:13:06 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:32527
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jYXWj-0006C8-7R
 for qemu-devel@nongnu.org; Tue, 12 May 2020 12:13:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589299984;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uCiObssjduWDJXx35c2UNApsOX22Pjn1+UY3kqA4LXs=;
 b=aqWerh16N1OYu1EGbvOk+Kt0xPlUdX/GObbkcZsF0H7qckoNkXkACpvCsWlXEiX2hpCwzO
 NYhG438QZ57gShx3bn7VXZADnUAmlQfhVzE3P+YWRKCw4/uLugbaTp1RvuxdQvw+lqBzTj
 mjJwyhKm89qcac3d/+dp/5prWLGc2Lc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-306-J3kqXF4HMQi9G946saeylw-1; Tue, 12 May 2020 12:13:00 -0400
X-MC-Unique: J3kqXF4HMQi9G946saeylw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3CDEB1B18BC1;
 Tue, 12 May 2020 16:12:58 +0000 (UTC)
Received: from localhost (ovpn-112-75.ams2.redhat.com [10.36.112.75])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DC0B81000079;
 Tue, 12 May 2020 16:12:48 +0000 (UTC)
Date: Tue, 12 May 2020 17:12:47 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: elena.ufimtseva@oracle.com
Subject: Re: [PATCH RESEND v6 23/36] multi-process: create IOHUB object to
 handle irq
Message-ID: <20200512161247.GO300009@stefanha-x1.localdomain>
References: <cover.1587614626.git.elena.ufimtseva@oracle.com>
 <fc698970e58de0c205a736261e1ac9cc6f37acba.1587614626.git.elena.ufimtseva@oracle.com>
MIME-Version: 1.0
In-Reply-To: <fc698970e58de0c205a736261e1ac9cc6f37acba.1587614626.git.elena.ufimtseva@oracle.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="0u4QAjBqqw4+MLTw"
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

--0u4QAjBqqw4+MLTw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 22, 2020 at 09:13:58PM -0700, elena.ufimtseva@oracle.com wrote:
> From: Jagannathan Raman <jag.raman@oracle.com>
>=20
> IOHUB object is added to manage PCI IRQs. It uses KVM_IRQFD
> ioctl to create irqfd to injecting PCI interrupts to the guest.
> IOHUB object forwards the irqfd to the remote process. Remote process
> uses this fd to directly send interrupts to the guest, bypassing QEMU.
>=20
> Signed-off-by: John G Johnson <john.g.johnson@oracle.com>
> Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
> Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
> ---
>  MAINTAINERS                   |   2 +
>  Makefile.target               |   1 +
>  hw/Makefile.objs              |   2 -
>  hw/proxy/Makefile.objs        |   1 -
>  hw/proxy/qemu-proxy.c         |  52 ++++++++++++
>  include/hw/pci/pci_ids.h      |   3 +
>  include/hw/proxy/qemu-proxy.h |   8 ++
>  include/io/mpqemu-link.h      |   8 ++
>  include/remote/iohub.h        |  50 ++++++++++++
>  include/remote/machine.h      |   2 +
>  io/mpqemu-link.c              |   1 +
>  remote/Makefile.objs          |   1 +
>  remote/iohub.c                | 148 ++++++++++++++++++++++++++++++++++
>  remote/machine.c              |  15 ++++
>  remote/remote-main.c          |   4 +
>  15 files changed, 295 insertions(+), 3 deletions(-)
>  delete mode 100644 hw/proxy/Makefile.objs
>  create mode 100644 include/remote/iohub.h
>  create mode 100644 remote/iohub.c

Does this mean MSI-X is not supported?

For legacy device emulation INTx is fine but for modern devices MSI-X is
used for better performance (multiqueue, etc).

Stefan

--0u4QAjBqqw4+MLTw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl66yv8ACgkQnKSrs4Gr
c8j6Swf/TtsdAgjLY+VzFPSJSIHWO7pnP2LhYK2fzf/eKSKQL+VO7W1+KMjJdY3o
56WOpay+maHeMGFsv+IKajo27eY5wlDAQ14D1ml9TDZ+JEjA7/iBAn16NWghZy80
QH/NXPMpxb6uwmpGEIqr63BI0SboE2Z74MIOB6lJiJ907vXLg33Yz6RZT/pRcxA6
ifF4I4vKSOyzq4os2nonTtstJjGWCYjSNNUbedI/SKoSu7gCml9W0x4FLm88jXxG
vDTplBye022AfXxvP8KOazzuFabw/y71rXomzXgLRSeQmJC/T9Yr2QjFgiqLqYUI
Z4DnDnGm7ptZqOY/J6ghlGowd03b4A==
=RxrK
-----END PGP SIGNATURE-----

--0u4QAjBqqw4+MLTw--


