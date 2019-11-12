Return-Path: <SRS0=1YIe=ZE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B9E5C43331
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2019 10:04:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 415CC21783
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2019 10:04:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Vl/Ke7No"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 415CC21783
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60912 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iUT2Q-0001YA-Cl
	for qemu-devel@archiver.kernel.org; Tue, 12 Nov 2019 05:04:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52583)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1iUT1A-0000WT-6C
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 05:03:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1iUT18-0001dy-Ou
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 05:03:24 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:36614
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1iUT18-0001ca-J3
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 05:03:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573553001;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=79b53HtVGpE09LwB7dtFt79Ki9KVSl2ClbvlHhaMQxs=;
 b=Vl/Ke7No3Kq1UKCwyVacgu4E/B+f0dchtnOhjnoIBkqc45I+r+CG/EHgLLIhzNiSXxSLfy
 G53NLy96c4tprjuS1wmYNc7Hkm8tr5NyGyQn8zfatZ8rMGVYio7h92Wq1DjZIlKd96AUPK
 7TwhVPiw/2Ck4KN9WhFNcO9OKxL18Oc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-396-IjztqjDENlKeQ1RNodMmTA-1; Tue, 12 Nov 2019 05:03:18 -0500
X-MC-Unique: IjztqjDENlKeQ1RNodMmTA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CC22F1005500;
 Tue, 12 Nov 2019 10:03:17 +0000 (UTC)
Received: from localhost (ovpn-116-203.ams2.redhat.com [10.36.116.203])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4346F579F;
 Tue, 12 Nov 2019 10:03:11 +0000 (UTC)
Date: Tue, 12 Nov 2019 10:03:10 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH] virtio: fix IO request length in virtio SCSI/block
 #PSBM-78839
Message-ID: <20191112100310.GB463128@stefanha-x1.localdomain>
References: <20191018115547.19299-1-dplotnikov@virtuozzo.com>
 <20191023172005-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20191023172005-mutt-send-email-mst@kernel.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="UHN/qo2QbUvPLonB"
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
Cc: kwolf@redhat.com, den@virtuozzo.com, qemu-devel@nongnu.org,
 mreitz@redhat.com, Denis Plotnikov <dplotnikov@virtuozzo.com>,
 kraxel@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--UHN/qo2QbUvPLonB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 23, 2019 at 05:28:17PM -0400, Michael S. Tsirkin wrote:
> On Fri, Oct 18, 2019 at 02:55:47PM +0300, Denis Plotnikov wrote:
> > From: "Denis V. Lunev" <den@openvz.org>
> >=20
> > Linux guests submit IO requests no longer than PAGE_SIZE * max_seg
> > field reported by SCSI controler. Thus typical sequential read with
> > 1 MB size results in the following pattern of the IO from the guest:
> >   8,16   1    15754     2.766095122  2071  D   R 2095104 + 1008 [dd]
> >   8,16   1    15755     2.766108785  2071  D   R 2096112 + 1008 [dd]
> >   8,16   1    15756     2.766113486  2071  D   R 2097120 + 32 [dd]
> >   8,16   1    15757     2.767668961     0  C   R 2095104 + 1008 [0]
> >   8,16   1    15758     2.768534315     0  C   R 2096112 + 1008 [0]
> >   8,16   1    15759     2.768539782     0  C   R 2097120 + 32 [0]
> > The IO was generated by
> >   dd if=3D/dev/sda of=3D/dev/null bs=3D1024 iflag=3Ddirect
> >=20
> > This effectively means that on rotational disks we will observe 3 IOPS
> > for each 2 MBs processed. This definitely negatively affects both
> > guest and host IO performance.
> >=20
> > The cure is relatively simple - we should report lengthy scatter-gather
> > ability of the SCSI controller. Fortunately the situation here is very
> > good. VirtIO transport layer can accomodate 1024 items in one request
> > while we are using only 128. This situation is present since almost
> > very beginning. 2 items are dedicated for request metadata thus we
> > should publish VIRTQUEUE_MAX_SIZE - 2 as max_seg.
> >=20
> > The following pattern is observed after the patch:
> >   8,16   1     9921     2.662721340  2063  D   R 2095104 + 1024 [dd]
> >   8,16   1     9922     2.662737585  2063  D   R 2096128 + 1024 [dd]
> >   8,16   1     9923     2.665188167     0  C   R 2095104 + 1024 [0]
> >   8,16   1     9924     2.665198777     0  C   R 2096128 + 1024 [0]
> > which is much better.
> >=20
> > The dark side of this patch is that we are tweaking guest visible
> > parameter, though this should be relatively safe as above transport
> > layer support is present in QEMU/host Linux for a very long time.
> > The patch adds configurable property for VirtIO SCSI with a new default
> > and hardcode option for VirtBlock which does not provide good
> > configurable framework.
> >=20
> > Unfortunately the commit can not be applied as is. For the real cure we
> > need guest to be fixed to accomodate that queue length, which is done
> > only in the latest 4.14 kernel. Thus we are going to expose the propert=
y
> > and tweak it on machine type level.
> >=20
> > The problem with the old kernels is that they have
> > max_segments <=3D virtqueue_size restriction which cause the guest
> > crashing in the case of violation.
>=20
> This isn't just in the guests: virtio spec also seems to imply this,
> or at least be vague on this point.
>=20
> So I think it'll need a feature bit.
> Doing that in a safe way will also allow being compatible with old guests=
.

The spec is quite explicit about this:

  2.6.5 The Virtqueue Descriptor Table

  The number of descriptors in the table is defined by the queue size for t=
his virtqueue: this is the maximum possible descriptor chain length.

and:

  2.6.5.3.1 Driver Requirements: Indirect Descriptors

  A driver MUST NOT create a descriptor chain longer than the Queue Size of=
 the device.

If some drivers or devices allow longer descriptor chains today that's
an implementation quirk but a new feature bit is definitely required to
officially allow longer descriptor chains.

Stefan

--UHN/qo2QbUvPLonB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl3Kg14ACgkQnKSrs4Gr
c8i4bAf/SFE97PZsQQ5Jb+OyEvCfHNPGCMHPhNtIprVt02Atjff+A/D1YZ3ahQcR
D+NDDhqhl6T0ybYVi77gsC/lWrs307Gj4QFMqIXSu4Rp9AF4SJAvl1/G8z0cQw4S
12VgqQ3q2DT6kjE0wVPlEop3Mpgw6bAq/0rP8/daUkD7I0qZiHHr1vqAeIGE4Ti7
E8quoLtoz6T1FLmisifYg7tA+IhoePc99cGn6D/b6QmhlSXYD6M8htrrNJvGCA7g
tf9Zuknrdnz4sf8luQ7tBwA06z5pkuIyu38TUWMWSXvzFTatKbPMS5N+URkDtZBL
VgHwa7mEpHCgMzetbNOzqRbKZWBPOg==
=qNTo
-----END PGP SIGNATURE-----

--UHN/qo2QbUvPLonB--


