Return-Path: <SRS0=6r5r=AY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE04BC433E2
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 13:13:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A654206F0
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 13:13:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iVr2WOza"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A654206F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51194 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1juyH7-0005Kt-QJ
	for qemu-devel@archiver.kernel.org; Mon, 13 Jul 2020 09:13:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46336)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1juyGK-0004pE-E5
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 09:12:52 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:25927
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1juyGH-0006VH-WD
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 09:12:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594645969;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GNnS/SfM60+uqZn3yqe7yEzqULhES+nzjph0bvhKvJg=;
 b=iVr2WOzaCluqtKRKtoiQzDSY8iAhG9rPA3ZXAxdJLwoXubVjB1x2qb1QDl2YEfIgCSLY3m
 8ZERVRUITsPZvwLyhN4to8f4et+9fY1KEnIqxLTLOF7K1iOcZ4SFtln2E26cSht90DpmEr
 IumV3OKUX86IV26k3NfXq52kEZw6GhQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-192-2ND7BlIvORSerJhlDJfTjg-1; Mon, 13 Jul 2020 09:12:47 -0400
X-MC-Unique: 2ND7BlIvORSerJhlDJfTjg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1978E1081;
 Mon, 13 Jul 2020 13:12:46 +0000 (UTC)
Received: from linux.fritz.box (ovpn-114-91.ams2.redhat.com [10.36.114.91])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 214875C1D0;
 Mon, 13 Jul 2020 13:12:44 +0000 (UTC)
Date: Mon, 13 Jul 2020 15:12:43 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Max Reitz <mreitz@redhat.com>
Subject: Re: [PATCH for-5.1] file-posix: Mitigate file fragmentation with
 extent size hints
Message-ID: <20200713131243.GB10318@linux.fritz.box>
References: <20200707142329.48303-1-kwolf@redhat.com>
 <20200707161741.GG7002@linux.fritz.box>
 <451ed32d-72e8-0238-8793-f5a80ae991c4@redhat.com>
 <2974eb09-24fe-58b0-65d4-5cb550ed08f1@redhat.com>
MIME-Version: 1.0
In-Reply-To: <2974eb09-24fe-58b0-65d4-5cb550ed08f1@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="82I3+IH0IqGh5yIs"
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=kwolf@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/13 03:20:22
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--82I3+IH0IqGh5yIs
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 13.07.2020 um 11:08 hat Max Reitz geschrieben:
> On 10.07.20 18:12, Max Reitz wrote:
> > On 07.07.20 18:17, Kevin Wolf wrote:
> >> Am 07.07.2020 um 16:23 hat Kevin Wolf geschrieben:
> >>> Espeically when O_DIRECT is used with image files so that the page ca=
che
> >>> indirection can't cause a merge of allocating requests, the file will
> >>> fragment on the file system layer, with a potentially very small
> >>> fragment size (this depends on the requests the guest sent).
> >>>
> >>> On Linux, fragmentation can be reduced by setting an extent size hint
> >>> when creating the file (at least on XFS, it can't be set any more aft=
er
> >>> the first extent has been allocated), basically giving raw files a
> >>> "cluster size" for allocation.
> >>>
> >>> This adds an create option to set the extent size hint, and changes t=
he
> >>> default from not setting a hint to setting it to 1 MB. The main reaso=
n
> >>> why qcow2 defaults to smaller cluster sizes is that COW becomes more
> >>> expensive, which is not an issue with raw files, so we can choose a
> >>> larger file. The tradeoff here is only potentially wasted disk space.
> >>>
> >>> For qcow2 (or other image formats) over file-posix, the advantage sho=
uld
> >>> even be greater because they grow sequentially without leaving holes,=
 so
> >>> there won't be wasted space. Setting even larger extent size hints fo=
r
> >>> such images may make sense. This can be done with the new option, but
> >>> let's keep the default conservative for now.
> >>>
> >>> The effect is very visible with a test that intentionally creates a
> >>> badly fragmented file with qemu-img bench (the time difference while
> >>> creating the file is already remarkable) and then looks at the number=
 of
> >>> extents and the take a simple "qemu-img map" takes.
> >>>
> >>> Without an extent size hint:
> >>>
> >>>     $ ./qemu-img create -f raw -o extent_size_hint=3D0 ~/tmp/test.raw=
 10G
> >>>     Formatting '/home/kwolf/tmp/test.raw', fmt=3Draw size=3D107374182=
40 extent_size_hint=3D0
> >>>     $ ./qemu-img bench -f raw -t none -n -w ~/tmp/test.raw -c 1000000=
 -S 8192 -o 0
> >>>     Sending 1000000 write requests, 4096 bytes each, 64 in parallel (=
starting at offset 0, step size 8192)
> >>>     Run completed in 25.848 seconds.
> >>>     $ ./qemu-img bench -f raw -t none -n -w ~/tmp/test.raw -c 1000000=
 -S 8192 -o 4096
> >>>     Sending 1000000 write requests, 4096 bytes each, 64 in parallel (=
starting at offset 4096, step size 8192)
> >>>     Run completed in 19.616 seconds.
> >>>     $ filefrag ~/tmp/test.raw
> >>>     /home/kwolf/tmp/test.raw: 2000000 extents found
> >>>     $ time ./qemu-img map ~/tmp/test.raw
> >>>     Offset          Length          Mapped to       File
> >>>     0               0x1e8480000     0               /home/kwolf/tmp/t=
est.raw
> >>>
> >>>     real    0m1,279s
> >>>     user    0m0,043s
> >>>     sys     0m1,226s
> >>>
> >>> With the new default extent size hint of 1 MB:
> >>>
> >>>     $ ./qemu-img create -f raw -o extent_size_hint=3D1M ~/tmp/test.ra=
w 10G
> >>>     Formatting '/home/kwolf/tmp/test.raw', fmt=3Draw size=3D107374182=
40 extent_size_hint=3D1048576
> >>>     $ ./qemu-img bench -f raw -t none -n -w ~/tmp/test.raw -c 1000000=
 -S 8192 -o 0
> >>>     Sending 1000000 write requests, 4096 bytes each, 64 in parallel (=
starting at offset 0, step size 8192)
> >>>     Run completed in 11.833 seconds.
> >>>     $ ./qemu-img bench -f raw -t none -n -w ~/tmp/test.raw -c 1000000=
 -S 8192 -o 4096
> >>>     Sending 1000000 write requests, 4096 bytes each, 64 in parallel (=
starting at offset 4096, step size 8192)
> >>>     Run completed in 10.155 seconds.
> >>>     $ filefrag ~/tmp/test.raw
> >>>     /home/kwolf/tmp/test.raw: 178 extents found
> >>>     $ time ./qemu-img map ~/tmp/test.raw
> >>>     Offset          Length          Mapped to       File
> >>>     0               0x1e8480000     0               /home/kwolf/tmp/t=
est.raw
> >>>
> >>>     real    0m0,061s
> >>>     user    0m0,040s
> >>>     sys     0m0,014s
> >>>
> >>> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> >>
> >> I also need to squash in a few trivial qemu-iotests updates, for which=
 I
> >> won't send a v2:
> >=20
> > The additional specifications in 243 make it print a warning on tmpfs
> > (because the option doesn=E2=80=99t work there).  I suppose the same ma=
y be true
> > on other filesystems as well.  Should it be filtered out?

I guess we just shouldn't print a warning if the requested hint is 0.

> This patch also breaks 059, 106, and 175.

Hm, I was sure I had tested raw... Anyway, 059 should filter out the
actual size (how could this ever work?), and 175 is obvious, too - it
tries to be clever, but not clever enough.

106 is a bit mysterious because the error message implies that the
images end up smaller than before, which shouldn't be the case. I'll
have a look.

Kevin

--82I3+IH0IqGh5yIs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE3D3rFZqa+V09dFb+fwmycsiPL9YFAl8MXcsACgkQfwmycsiP
L9YUbg//cod9N/Wk7CA3MHzSCf4DbGJdFYC4+yzs/fhpimgP0yc7FJcT5SLrLBbq
7OnRu5mQsft/DRVB216FO13HiVSIhpkRpCJRrP4gcjqTOjmyvRQH1sBOgAyeJVHY
LU60Zg3Dh7nRW1KhxKrfClZnrze2MIqO33GXO7NEK5CylJBo1uL+EPedTv5SATXt
Png/4qUPbDQXamU50iAXUvAXcOZUU1+GesdHk6SOzGwLY/F05fR5l/+qfrBW4x6Q
IdYse4L6OOe0xoGCkkWDLGWtJPG/UCpW8JXaaba6JwdBrMGSxx8w2k2kdzS0Tcw/
BtPsETrnN4k87yhTBIsBsLYdLyAvNO8bI6LiC78Zer8T0a6Ox6XSmRVbKkSjZzYT
WFGeSANQfTOCzvAz2NUkL7IaPp60p0zhsnrd0UgnYf370vASNIx6Q8RcbeHTM5XL
8jpIdEAq+Y5ggVBZ6Co4QBNhYZs+eVYUQrji9YfY3ESTDgTKYGy6QZinVqJCL4+t
aXM4mhnaMZu58yC/BAwpSJOSFEKdl8CgRXp4QijmGg7xIhmPAw9LXDKVoe4vV5JB
ldzfIAfrSID/MJuiOlZjWGPpEEcC0aTg82m0v5ux2bYy7rM8TqCcLKDLg/Z69cuK
E0VmR7QgWCKPdgdrcDJniFFjWg5cWwMgn1qpyrmRRG0U+zCOIuw=
=RzQX
-----END PGP SIGNATURE-----

--82I3+IH0IqGh5yIs--


