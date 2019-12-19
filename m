Return-Path: <SRS0=p/0J=2J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F9F9C2D0C0
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 15:49:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E3AB206EC
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 15:49:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ep9KYvR8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E3AB206EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43832 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihy30-0000mS-F0
	for qemu-devel@archiver.kernel.org; Thu, 19 Dec 2019 10:49:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52995)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1ihy26-000076-Ht
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 10:48:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1ihy24-00084W-7f
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 10:48:09 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:23858
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1ihy22-00081n-G0
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 10:48:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576770485;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=r8xyNIwM2APRs+WEdRgzlmVgiUEAcHo5b+7orPGl8RI=;
 b=ep9KYvR8pN3dKuGAdcBDKlliofBMNZPPRd3WsNMm+mZ/BACm8NIzJqwxT4+fhxuMo/sBQX
 sm3ngCrG8y8vXvAK8NAo8Zv0unPuVpfGvLSskUCzsalmZyWTO8xvFsfCEHWq1+bspAsJ8V
 PVAr5WU6Cf7cXkRXM1dNTm6xnqJpJmw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-36-NThDrjG4PTKvhqRUe69BPQ-1; Thu, 19 Dec 2019 10:48:02 -0500
X-MC-Unique: NThDrjG4PTKvhqRUe69BPQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C93B2803A44;
 Thu, 19 Dec 2019 15:48:01 +0000 (UTC)
Received: from linux.fritz.box (ovpn-117-53.ams2.redhat.com [10.36.117.53])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8A2915C57C;
 Thu, 19 Dec 2019 15:48:00 +0000 (UTC)
Date: Thu, 19 Dec 2019 16:47:58 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Max Reitz <mreitz@redhat.com>
Subject: Re: [PATCH 3/3] iotests: Test external snapshot with VM state
Message-ID: <20191219154758.GN5230@linux.fritz.box>
References: <20191217145939.5537-1-kwolf@redhat.com>
 <20191217145939.5537-4-kwolf@redhat.com>
 <e4212782-78ef-6bc9-f0e4-9a069c47a77b@redhat.com>
MIME-Version: 1.0
In-Reply-To: <e4212782-78ef-6bc9-f0e4-9a069c47a77b@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="O5XBE6gyVG5Rl6Rj"
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, dgilbert@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--O5XBE6gyVG5Rl6Rj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 19.12.2019 um 15:26 hat Max Reitz geschrieben:
> On 17.12.19 15:59, Kevin Wolf wrote:
> > This tests creating an external snapshot with VM state (which results i=
n
> > an active overlay over an inactive backing file, which is also the root
> > node of an inactive BlockBackend), re-activating the images and
> > performing some operations to test that the re-activation worked as
> > intended.
> >=20
> > Signed-off-by: Kevin Wolf <kwolf@redhat.com>
>=20
> [...]
>=20
> > diff --git a/tests/qemu-iotests/280.out b/tests/qemu-iotests/280.out
> > new file mode 100644
> > index 0000000000..5d382faaa8
> > --- /dev/null
> > +++ b/tests/qemu-iotests/280.out
> > @@ -0,0 +1,50 @@
> > +Formatting 'TEST_DIR/PID-base', fmt=3Dqcow2 size=3D67108864 cluster_si=
ze=3D65536 lazy_refcounts=3Doff refcount_bits=3D16
> > +
> > +=3D=3D=3D Launch VM =3D=3D=3D
> > +Enabling migration QMP events on VM...
> > +{"return": {}}
> > +
> > +=3D=3D=3D Migrate to file =3D=3D=3D
> > +{"execute": "migrate", "arguments": {"uri": "exec:cat > /dev/null"}}
> > +{"return": {}}
> > +{"data": {"status": "setup"}, "event": "MIGRATION", "timestamp": {"mic=
roseconds": "USECS", "seconds": "SECS"}}
> > +{"data": {"status": "active"}, "event": "MIGRATION", "timestamp": {"mi=
croseconds": "USECS", "seconds": "SECS"}}
> > +{"data": {"status": "completed"}, "event": "MIGRATION", "timestamp": {=
"microseconds": "USECS", "seconds": "SECS"}}
> > +
> > +VM is now stopped:
> > +completed
> > +{"execute": "query-status", "arguments": {}}
> > +{"return": {"running": false, "singlestep": false, "status": "postmigr=
ate"}}
>=20
> Hmmm, I get a finish-migrate status here (on tmpfs)...

Dave, is it intentional that the "completed" migration event is emitted
while we are still in finish-migration rather than postmigrate?

I guess we could change wait_migration() in qemu-iotests to wait for the
postmigrate state rather than the "completed" event, but maybe it would
be better to change the migration code to avoid similar races in other
QMP clients.

Kevin

--O5XBE6gyVG5Rl6Rj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJd+5uuAAoJEH8JsnLIjy/WNUAP/jSIswb/6J/qB8gnbRO9LNw6
1M0heue0fsPzqtwSb9lEq03/Rl16hEQqqWzSEBKhjiROJSs4GPqv9FcvbCicuYIU
3VYR/rc+iBBCNCTOqSO9NXliIC82oPqquZV3lPtucYI3PgAq0IEYIvPoCV3IObs9
/a8drJQtdMAvIumKJD0qKwXxt+NVWsnFsAkffLG/bAM7iDsQ2yumgR7K99XMdM3G
4tUAkA/bus0lP6/1vyFY9xnvvYtkfh4KOscpDM3ZGU7ov3RYMtTZrCv330L3nEU1
vlX7WMKRIK4mxSoT/MzL4DkTKZbJ4uEIYfqqmeiJVJCUCNy/vYGh39nG9R8f6v1h
Tu5oErZ/UzI4xwYabMLTtQxDuddA5ynAhUNHhM9XTQZzuop9mgLXjrKcPFKq1u6p
ttQsKJ8Nqig7NTXCCgOZ7eOAnQ1n+ad+D/BHcbaoHps6OCBSej7L7VkA8ncpjwyc
q4RADg6Anua4lAID9CHUMpRUsMobbxncBfymuAyBoZ8Ux7kDQWgqeOId1tkIjpke
/XY7J+tp+c16GjnPt6P6oHnUaZ6ytlw2LbMiSoZCQ4h8YJgDzf1rW8M4Yy3XjBwm
87VTmsJXp0GfJcE1k2sO+A4qokM+EcZeVhfn9O3q6oIFVtBQE5GkcvbY9LkPHYQH
QxoOOgL/jwpAVwh9ROSW
=XTP9
-----END PGP SIGNATURE-----

--O5XBE6gyVG5Rl6Rj--


