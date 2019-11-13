Return-Path: <SRS0=QD06=ZF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6620C43331
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2019 11:43:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 80698222C9
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2019 11:43:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gPvC3ZDW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80698222C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43194 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iUr39-0000uM-Hk
	for qemu-devel@archiver.kernel.org; Wed, 13 Nov 2019 06:43:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59440)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1iUr2U-0000La-Cs
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 06:42:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1iUr2S-0000pn-B5
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 06:42:21 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:55970
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1iUr2R-0000ob-MD
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 06:42:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573645338;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=85fsVWvzYnD+mm448oAj/FKqg21EgD9YvxqnXBpTVE4=;
 b=gPvC3ZDWQVvt6RGkDo3FD4Jh8WgMX4noHS4PlEGoFlw98OgZHd5itd1Q93RWysunWqD9H4
 ekDMraNI/aOG3DfP5sAZh5kqAlBEerssahkRCtesrhk87+afyWbt2yU6kccv9ZZyTkgzHP
 fi/6ZcWqGqPHcPEaYVkGIkGv8ZqkXV4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-134-qbeHOlU1O0etKLIvzDeK7A-1; Wed, 13 Nov 2019 06:42:16 -0500
X-MC-Unique: qbeHOlU1O0etKLIvzDeK7A-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5F89D1005502;
 Wed, 13 Nov 2019 11:42:15 +0000 (UTC)
Received: from localhost (ovpn-117-166.ams2.redhat.com [10.36.117.166])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 63C2028DCD;
 Wed, 13 Nov 2019 11:42:09 +0000 (UTC)
Date: Wed, 13 Nov 2019 11:42:08 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Max Reitz <mreitz@redhat.com>
Subject: Re: [PATCH v2 03/15] block/block: add BDRV flag for io_uring
Message-ID: <20191113114208.GB538417@stefanha-x1.localdomain>
References: <20191025160444.31632-1-stefanha@redhat.com>
 <20191025160444.31632-4-stefanha@redhat.com>
 <20191111105759.GB7297@linux.fritz.box>
 <6e8cf473-d3e9-c743-d2bd-75a0d955e6c6@redhat.com>
MIME-Version: 1.0
In-Reply-To: <6e8cf473-d3e9-c743-d2bd-75a0d955e6c6@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="DBIVS5p969aUjpLe"
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 Maxim Levitsky <maximlevitsky@gmail.com>, qemu-block@nongnu.org,
 oleksandr@redhat.com, Julia Suvorova <jusual@redhat.com>,
 qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Aarushi Mehta <mehta.aaru20@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--DBIVS5p969aUjpLe
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 11, 2019 at 05:25:04PM +0100, Max Reitz wrote:
> On 11.11.19 11:57, Kevin Wolf wrote:
> > Am 25.10.2019 um 18:04 hat Stefan Hajnoczi geschrieben:
> >> From: Aarushi Mehta <mehta.aaru20@gmail.com>
> >>
> >> Signed-off-by: Aarushi Mehta <mehta.aaru20@gmail.com>
> >> Reviewed-by: Maxim Levitsky <maximlevitsky@gmail.com>
> >> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> >> ---
> >>  include/block/block.h | 1 +
> >>  1 file changed, 1 insertion(+)
> >>
> >> diff --git a/include/block/block.h b/include/block/block.h
> >> index 89606bd9f8..bdb48dcd1b 100644
> >> --- a/include/block/block.h
> >> +++ b/include/block/block.h
> >> @@ -126,6 +126,7 @@ typedef struct HDGeometry {
> >>                                        ignoring the format layer */
> >>  #define BDRV_O_NO_IO       0x10000 /* don't initialize for I/O */
> >>  #define BDRV_O_AUTO_RDONLY 0x20000 /* degrade to read-only if opening=
 read-write fails */
> >> +#define BDRV_O_IO_URING    0x40000 /* use io_uring instead of the thr=
ead pool */
> >=20
> > Why do we need a new (global!) flag rather than a driver-specific optio=
n
> > for file-posix? This looks wrong to me, the flag has no sensible meanin=
g
> > for any other driver.
> >=20
> > (Yes, BDRV_O_NATIVE_AIO is wrong, too, but compatibility means we can't
> > remove it easily.)
>=20
> To add to that, Kevin and me had a short talk on IRC, and it seemed like
> the reason would be that it=E2=80=99s easier to use this way than an opti=
on
> would be.
>=20
> To me, the problem seems to be that it=E2=80=99s only easier to use becau=
se of
> the option inheritance we have in the block layer (so you can set this
> flag on a qcow2 node and its file node will have it, too).  But
> naturally this inheritance is a bit of magic (because qemu has to guess
> where you probably want the flag to end up), so I=E2=80=99d too rather av=
oid
> adding to it.
>=20
> OTOH, I wonder whether ease of use is really that important here.  Would
> people who want to use io_uring really care about a command line that=E2=
=80=99s
> going to be a bit more complicated than just
> -drive file=3Dfoo.img,format=3D$imgfmt,aio=3Dio_uring,if=3D$interface?  (=
Namely
> file.aio in this case, or maybe even a full-on block graph definition.)

Thanks for the idea.  I agree it's cleaner to avoid a new global flag.

I'll take a look at fixing this and let you know if I hit any problems.

Stefan

--DBIVS5p969aUjpLe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl3L7BAACgkQnKSrs4Gr
c8iTqwf/Wk9AmJ+/J6nAHZn89JzBjeM8wdgK9JNguZiajRzZJH9qeQ+RQeewuLWT
3m8AOXAwFtjP1uYwAFYRSpUKDTVVINgKQThYcjzcSUfigbZFEiI6Oil6JmVKFmZ8
KrTrVPZQuJ3i/mTRrTCcZghYr8e0hNANkbCb1dF+8VmGeXeXvl/bI3y/ghaZrHIE
5JHMR+VHqMuY9z6+sbVfkegzJEpKNUWjf3K2AyDm1xw8XtkKpUrXVduUHXKtgwxt
wjjiSE12E1zWzaxxXrkRISjz4TT5ay1CffLr8tpfKMeNB6nj5mgw/rGvS7dM2JIa
qgcA9uN8grlljO9hRSHY+hFlT1O+6Q==
=3h6i
-----END PGP SIGNATURE-----

--DBIVS5p969aUjpLe--


