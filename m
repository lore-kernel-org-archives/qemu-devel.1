Return-Path: <SRS0=0TZc=4P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB5C8C3567B
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 17:19:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 656A8246A1
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 17:19:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="deRJ/+Ij"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 656A8246A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35298 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7Mp1-000558-Bq
	for qemu-devel@archiver.kernel.org; Thu, 27 Feb 2020 12:19:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49825)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1j7MoA-00041U-N2
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 12:18:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1j7Mo9-0000M2-L3
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 12:18:46 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:45158
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1j7Mo9-0000L9-GI
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 12:18:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582823924;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8Ajq05RJFerE4Ic3IquUIm/eDPOXbjbL/N/ZiwWAaGA=;
 b=deRJ/+Ijur4dMfoAw5t6mNvlBSA/voqugkBRsMlokjC9em2ka7TEeSIO9h11k5cVPD0acv
 SwwDFtE0fRtq4MNFxvWK6MF3vC9Lwj90hKQKi64rrQP36LYUWosryh5BcPcE3yeYb4nsCI
 e1JaY4CXcqCQAiscKxybVuJ8S06QxXo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-271-T1mavSxsPBWXEkB3GtBh4w-1; Thu, 27 Feb 2020 12:18:40 -0500
X-MC-Unique: T1mavSxsPBWXEkB3GtBh4w-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0844A800D48;
 Thu, 27 Feb 2020 17:18:38 +0000 (UTC)
Received: from localhost (ovpn-117-38.ams2.redhat.com [10.36.117.38])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7761C1CB;
 Thu, 27 Feb 2020 17:18:32 +0000 (UTC)
Date: Thu, 27 Feb 2020 17:18:30 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Jagannathan Raman <jag.raman@oracle.com>
Subject: Re: [PATCH v5 48/50] multi-process: Validate incoming commands from
 Proxy
Message-ID: <20200227171830.GG315098@stefanha-x1.localdomain>
References: <cover.1582576372.git.jag.raman@oracle.com>
 <00737a41c9bc4993ad47e5d4387ac14f1892be40.1582576372.git.jag.raman@oracle.com>
MIME-Version: 1.0
In-Reply-To: <00737a41c9bc4993ad47e5d4387ac14f1892be40.1582576372.git.jag.raman@oracle.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="V32M1hWVjliPHW+c"
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
 liran.alon@oracle.com, thanos.makatos@nutanix.com, rth@twiddle.net,
 kwolf@redhat.com, berrange@redhat.com, mreitz@redhat.com,
 ross.lagerwall@citrix.com, marcandre.lureau@gmail.com, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--V32M1hWVjliPHW+c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 24, 2020 at 03:55:39PM -0500, Jagannathan Raman wrote:
> From: Elena Ufimtseva <elena.ufimtseva@oracle.com>
>=20
> Validate the incoming commands to confirm that they would not cause any
> errors in the remote process.
>=20
> Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
> Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
> Signed-off-by: John G Johnson <john.g.johnson@oracle.com>
> ---
>  hw/proxy/qemu-proxy.c    |  6 +++-
>  include/io/mpqemu-link.h |  2 ++
>  io/mpqemu-link.c         | 75 ++++++++++++++++++++++++++++++++++++++++++=
+++++-
>  remote/remote-main.c     |  4 +++
>  4 files changed, 85 insertions(+), 2 deletions(-)

Please squash this into the patch(es) that introduced the code.

Reviewers want to see a logical sequence of patches.  Introducing
unsafe code in an earlier patch and adding checks in a later patch makes
it impossible to review the patches in sequence (reviewers would waste
time pointing out bugs that end up getting fixed later).

> diff --git a/remote/remote-main.c b/remote/remote-main.c
> index 20d160e..c4aa3e0 100644
> --- a/remote/remote-main.c
> +++ b/remote/remote-main.c
> @@ -435,6 +435,10 @@ static void process_msg(GIOCondition cond, MPQemuCha=
nnel *chan)
>      if (msg->id > MAX_REMOTE_DEVICES) {
>          error_setg(&err, "id of the device is larger than max number of =
"\
>                           "devices per remote process.");
> +    }

Was goto finalize_loop accidentally dropped?

--V32M1hWVjliPHW+c
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl5X+eYACgkQnKSrs4Gr
c8iZWQgAmEY/+4W1kP9RaZbAyYmSbxmWOS43ZfJskGFg4IVnAZ2AEgSJtxKe82wR
Cjqtb+rxHDLHIhozR2LJ4ERfXfGd3oq6FL4lygRYtQOcAwPeJcPiV0OEVxyDF0B9
yZ5Ucpooc8KiGAZVeCq4REtb2Bg8UIcn7q0f7i5DCpFsmrkgaIwIvtbOFjZYv80w
GeV1KczqS6qykXqIHW8eo5x+00WQdZ4QkIkJS4cvPtk6Dal4QmxH4AUKwrHU7zoa
N/P6hQGeafgcwaIPF/Ttu4dQBO0Mfouk8AipdSNLqEP27TdFSvdLYcMVBymBGd/d
WfcHvNXdDNsCi8yt9YOEnn3qZxvF/g==
=4j5P
-----END PGP SIGNATURE-----

--V32M1hWVjliPHW+c--


