Return-Path: <SRS0=OA/w=ZN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77A3EC432C0
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2019 14:37:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4194C20714
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2019 14:37:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B2oKVAjs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4194C20714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41402 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXnaQ-0004qB-Aj
	for qemu-devel@archiver.kernel.org; Thu, 21 Nov 2019 09:37:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40971)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1iXnWk-0008ID-8m
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 09:33:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1iXnWh-0002Fx-UN
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 09:33:45 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:52602
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1iXnWg-0002BG-1D
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 09:33:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574346820;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=soEqsE7/qw0Lx4ylWUXGucV2YwmoK9X+Qv2q+s1/3EQ=;
 b=B2oKVAjscRRZHV5e0KYQxmb5ah2pcfVqtN7uN8i3k4Yd/S1A1RZxkM2yzGMOihk2kZTra6
 lY9BqqkKmJJXMTHgrbhaKg9sqAhC4QtDr6kvKNUg6ToRx/+fKtfnNU1FUfGKvRAKedf8wF
 i+W6cQ2t8HzQgfHHz3RdvYBYQp1+t4k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-179-rohySzC2PiCIeim38UlntQ-1; Thu, 21 Nov 2019 09:33:39 -0500
X-MC-Unique: rohySzC2PiCIeim38UlntQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0B1E4DBB6;
 Thu, 21 Nov 2019 14:33:38 +0000 (UTC)
Received: from linux.fritz.box (ovpn-117-225.ams2.redhat.com [10.36.117.225])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B815D6E712;
 Thu, 21 Nov 2019 14:33:33 +0000 (UTC)
Date: Thu, 21 Nov 2019 15:33:31 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Max Reitz <mreitz@redhat.com>
Subject: Re: [PATCH v2 2/6] block: truncate: Don't make backing file data
 visible
Message-ID: <20191121143331.GG6007@linux.fritz.box>
References: <20191120184501.28159-1-kwolf@redhat.com>
 <20191120184501.28159-3-kwolf@redhat.com>
 <c53f6f2d-2451-2fb3-cbf0-2a1a686cccf5@redhat.com>
 <20191121113405.GE6007@linux.fritz.box>
 <38b48cd4-a7b6-c2c0-db38-99c2192b6d05@redhat.com>
MIME-Version: 1.0
In-Reply-To: <38b48cd4-a7b6-c2c0-db38-99c2192b6d05@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="G6nVm6DDWH/FONJq"
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
Cc: vsementsov@virtuozzo.com, stefanha@redhat.com, qemu-block@nongnu.org,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--G6nVm6DDWH/FONJq
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 21.11.2019 um 13:21 hat Max Reitz geschrieben:
> On 21.11.19 12:34, Kevin Wolf wrote:
> > Am 21.11.2019 um 09:59 hat Max Reitz geschrieben:
> >> On 20.11.19 19:44, Kevin Wolf wrote:
> >>> When extending the size of an image that has a backing file larger th=
an
> >>> its old size, make sure that the backing file data doesn't become
> >>> visible in the guest, but the added area is properly zeroed out.
> >>>
> >>> Consider the following scenario where the overlay is shorter than its
> >>> backing file:
> >>>
> >>>     base.qcow2:     AAAAAAAA
> >>>     overlay.qcow2:  BBBB
> >>>
> >>> When resizing (extending) overlay.qcow2, the new blocks should not st=
ay
> >>> unallocated and make the additional As from base.qcow2 visible like
> >>> before this patch, but zeros should be read.
> >>>
> >>> A similar case happens with the various variants of a commit job when=
 an
> >>> intermediate file is short (- for unallocated):
> >>>
> >>>     base.qcow2:     A-A-AAAA
> >>>     mid.qcow2:      BB-B
> >>>     top.qcow2:      C--C--C-
> >>>
> >>> After commit top.qcow2 to mid.qcow2, the following happens:
> >>>
> >>>     mid.qcow2:      CB-C00C0 (correct result)
> >>>     mid.qcow2:      CB-C--C- (before this fix)
> >>>
> >>> Without the fix, blocks that previously read as zeros on top.qcow2
> >>> suddenly turn into A.
> >>>
> >>> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> >>> ---
> >>>  block/io.c | 32 ++++++++++++++++++++++++++++++++
> >>>  1 file changed, 32 insertions(+)
> >>
> >> Zeroing the intersection may take some time.  So is it right for QMP=
=E2=80=99s
> >> block_resize to do this, seeing it is a synchronous operation?
> >=20
> > What else would be right? Returning an error?
>=20
> Going through a deprecation cycle.

And keeping the buggy behaviour for two more releases?

> > Common cases (raw and qcow2 v3 without external data files) are quick
> > anyway.
>=20
> Well, but quick enough for a fully blocking operation?

For raw definitely yes, because raw doesn't have backing files, so the
code will never run.

For qcow2, block_resize can already block for a relatively long time
while metadata tables are resized, clusters are discarded etc. I just
don't really see the difference in quality between that and allocating
some zero clusters in a corner case like having a short overlay.

Would you feel more comfortable if we set BDRV_REQ_NO_FALLBACK and
return an error if we can't zero out the area? We would have to
advertise that flag in bs->supported_zero_flags for qcow2 then (but
probably we should do that anyway?)

> >> As far as I can tell, jobs actually have the same problem.  I don=E2=
=80=99t
> >> think mirror or commit have a pause point before truncating, so they
> >> still block the monitor there, don=E2=80=99t they?
> >=20
> > Do you really need a pause point? They call bdrv_co_truncate() from
> > inside the job coroutine, so it will yield. I would expect that this
> > is enough.
>=20
> OK then.
>=20
> > But in fact, all jobs have a pause point before even calling .run(), so
> > even if that made a difference, it should still be fine.
>=20
> Good.
>=20
> But I believe this is still a problem for block_resize.  I don=E2=80=99t =
see why
> this needs to be fixed in 4.2-rc3.  What=E2=80=99s the problem with going
> through a proper deprecation cycle other than the fact that we can=E2=80=
=99t
> start it in 4.2 because we don=E2=80=99t have a resize job yet?

That the behaviour is wrong.

For commit it's an image corruptor. For resize, I'll admit that it's
just wrong behaviour that is probably harmless in most cases, but it's
still wrong behaviour. It would be a corruptor in the same way as commit
if it allowed resizing intermediate nodes, but I _think_ the old-style
op blockers still forbid this. We'd have to double-check this if we
leave things broken for block_resize.

Anyway, so are you suggesting adding another parameter to
bdrv_co_truncate() that enables wrong, but quicker semantics, and that
would only be used by block_resize?

Kevin

--G6nVm6DDWH/FONJq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJd1qA7AAoJEH8JsnLIjy/WZLkP/2oIRfTWkFgaMJQxUy5Vmzxk
3guLoY85TKjJWH+hP3gukkKMea3ShL9FE7sL52vUGCrIiLK0Zps+t87Kkc3quJn4
guy5AwgH3K5FkGRNrzvHxRsqCUEC2rIvwqdIvpW9iSasohJZn6243LUHL0JGWQmp
Kys9/w6qLsztk3suW/MT5ALJ6jAFnHsSAVczr3apLTVfgKMT9YNP/0hkWM/GDmUX
AQzMrFW9szLiBNBXX/GvkaSy5JrKmmD6LofZM809/Wsw+36hOE0mNYQV1txQl8Di
QWDeHmrpSE1UwUXLbhaeAvdfS3CudourugRIQYGp3dY+Xeng+45/7ktSL3YFr01z
9J4SZRjO4xzf1ug2r1PwweNhxQcRMXqzc0hfd+v5iXinI6Tcwi8ZJlO2b1+M1aL2
8SUEE+/V9XUZLxHBRn4Gbgwin6NQPW9umVrQZ2gEC1WNdUkFbdmMvNRiMMuR0hok
YZTps07HMOxexqaCHUqMmhQcUGpflMlSY5ICZp3uKNOwYwBZie1DRYnmyEuHClFP
/oBZJ8QC2i1l+VMoe1M9BozvKylj/VSYUlndpCKuIiyujjs9hVRmjuAUfjN8Y0IN
AYWU6a2/YBRGdBvJ0T9hE/mh8H9x8FefMJe8DXqEJed3UCVBsnTU1jy2QnAFi7tR
fZpp0UWNqbClZ6M6nkqp
=t99S
-----END PGP SIGNATURE-----

--G6nVm6DDWH/FONJq--


