Return-Path: <SRS0=6iUH=ZY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66AB6C432C0
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2019 10:05:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2D0032084F
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2019 10:05:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JylP2iYF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D0032084F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33200 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ibiaN-0006fY-7o
	for qemu-devel@archiver.kernel.org; Mon, 02 Dec 2019 05:05:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59141)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1ibiZY-000620-F7
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 05:04:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1ibiZT-0002lx-GO
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 05:04:48 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:53561
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1ibiZS-0002lE-W5
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 05:04:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575281085;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=n7AnznIqLVuGicmns1uqlWUr7s0rr2qMc+ZaOodAQcQ=;
 b=JylP2iYF38/4HVu1o2FEUVpMQUVpGU+Oe+vRlks2Tx7pN2kY1sou53hZnTLaXnl1PGjQkT
 u/X2uh1r2FPePZXJlhDuaD2kUOPaovEJCsUXAoiAeIx+57SlfW4Gj9eg+NSrlsSattILDr
 ffVg6jvjI7R9QfE+vFqWjQ5ERi2o4Rw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-277-Cvqxy0OrOB68rpRx8YfEwg-1; Mon, 02 Dec 2019 05:04:41 -0500
X-MC-Unique: Cvqxy0OrOB68rpRx8YfEwg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 605148017DF;
 Mon,  2 Dec 2019 10:04:40 +0000 (UTC)
Received: from localhost (unknown [10.36.118.29])
 by smtp.corp.redhat.com (Postfix) with ESMTP id AA96F1001F43;
 Mon,  2 Dec 2019 10:04:39 +0000 (UTC)
Date: Mon, 2 Dec 2019 10:04:38 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH 03/21] block/file-posix: Fix laio_init() error handling
 crash bug
Message-ID: <20191202100438.GB131786@stefanha-x1.localdomain>
References: <20191130194240.10517-1-armbru@redhat.com>
 <20191130194240.10517-4-armbru@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20191130194240.10517-4-armbru@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="vGgW1X5XWziG23Ko"
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
Cc: Kevin Wolf <kwolf@redhat.com>, vsementsov@virtuozzo.com,
 qemu-devel@nongnu.org, Nishanth Aravamudan <naravamudan@digitalocean.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--vGgW1X5XWziG23Ko
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 30, 2019 at 08:42:22PM +0100, Markus Armbruster wrote:
> raw_aio_attach_aio_context() passes uninitialized Error *local_err by
> reference to laio_init() via aio_setup_linux_aio().  When laio_init()
> fails, it passes it on to error_setg_errno(), tripping error_setv()'s
> assertion unless @local_err is null by dumb luck.
>=20
> Fix by initializing @local_err properly.
>=20
> Fixes: ed6e2161715c527330f936d44af4c547f25f687e
> Cc: Nishanth Aravamudan <naravamudan@digitalocean.com>
> Cc: Stefan Hajnoczi <stefanha@redhat.com>
> Cc: Kevin Wolf <kwolf@redhat.com>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  block/file-posix.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Worth including in QEMU 4.2.

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--vGgW1X5XWziG23Ko
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl3k4bYACgkQnKSrs4Gr
c8i8MAgAh4GwKqfcjXAiYige4MZZ0Z93Ptg24Z0WL28/ok6vpdwNC5G7ot/yFBRU
+PRIeic9WOdE3uDW5wI2Vsq4X13edXYtoWMlJ1vsQPvVUWLaMRzSpHMsWf43ErBo
+JuGuB79Nlmc32EZOnew++G6HJoV7FTNcmwiqAB/hHu7tU9sUTn86PVLCmXZ0JoH
u8kkGgtu8h5Jjid6n5dKxEoPHGTEdPe330bTQXTxI11sYMW40bzBfgOU3CqNMulC
CvMZoVDHleMAxYTwjpaxB5CXXZm5G4BGbTlBVViM6xcICfg6NsB9A3lE6My4uQOP
0uI8ougEQIczgxDNUNoPuiOXkqvT6g==
=iaIe
-----END PGP SIGNATURE-----

--vGgW1X5XWziG23Ko--


