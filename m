Received: from eggs.gnu.org ([2001:4830:134:3::10]:38231)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cEJT5-0002SA-1q
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 12:23:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cEJT1-0005bq-Tj
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 12:23:51 -0500
Received: from mail-wj0-f196.google.com ([209.85.210.196]:35356)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1cEJT1-0005bW-Na
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 12:23:47 -0500
Received: by mail-wj0-f196.google.com with SMTP id he10so30899470wjc.2
	for <qemu-devel@nongnu.org>; Tue, 06 Dec 2016 09:23:47 -0800 (PST)
Date: Tue, 6 Dec 2016 17:22:44 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20161206172244.GA30363@stefanha-x1.localdomain>
References: <20161201192652.9509-1-stefanha@redhat.com>
	<20161201192652.9509-13-stefanha@redhat.com>
	<14acce63-5f93-ca54-477a-3a998769bbe9@de.ibm.com>
	<20161206092029.GA12630@stefanha-x1.localdomain>
	<826ff365-4ef1-6118-f677-ccfd86ea337b@de.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="4Ckj6UjgE2iN1+kY"
Content-Disposition: inline
In-Reply-To: <826ff365-4ef1-6118-f677-ccfd86ea337b@de.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v4 12/13] aio: self-tune polling time
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <famz@redhat.com>, Karl Rister <krister@redhat.com>


--4Ckj6UjgE2iN1+kY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 06, 2016 at 11:12:45AM +0100, Christian Borntraeger wrote:
> On 12/06/2016 10:20 AM, Stefan Hajnoczi wrote:
> > On Mon, Dec 05, 2016 at 09:06:17PM +0100, Christian Borntraeger wrote:
> >> On 12/01/2016 08:26 PM, Stefan Hajnoczi wrote:
> >>> This patch is based on the algorithm for the kvm.ko halt_poll_ns
> >>> parameter in Linux.  The initial polling time is zero.
> >>>
> >>> If the event loop is woken up within the maximum polling time it means
> >>> polling could be effective, so grow polling time.
> >>>
> >>> If the event loop is woken up beyond the maximum polling time it means
> >>> polling is not effective, so shrink polling time.
> >>>
> >>> If the event loop makes progress within the current polling time then
> >>> the sweet spot has been reached.
> >>>
> >>> This algorithm adjusts the polling time so it can adapt to variations=
 in
> >>> workloads.  The goal is to reach the sweet spot while also recognizing
> >>> when polling would hurt more than help.
> >>>
> >>> Two new trace events, poll_grow and poll_shrink, are added for observ=
ing
> >>> polling time adjustment.
> >>>
> >>> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> >>
> >> Not sure way, but I have 4 host ramdisks with the same iothread as gue=
st
> >> virtio-blk. running fio in the guest on one of these disks will poll, =
as
> >> soon as I have 2 disks  in fio I almost always see shrinks (so polling=
=20
> >> stays at 0) and almost no grows.
> >=20
> > Shrinking occurs when polling + ppoll(2) time exceeds poll-max-ns.
> >=20
> > What is the value of poll-max-ns
>=20
> I used 50000ns as poll value. When using 500000ns it is polling again.
>=20
> > and how long is run_poll_handlers_end - run_poll_handlers_begin?
>=20
> Too long. I looked again and I realized that I used cache=3Dnone without
> io=3Dnative. After adding io=3Dnative things are better. Even with 4 disks
> polling still happens. So it seems that the mileage will vary depending
> on the settings

Okay, it could be the things I mentioned.  The self-tuning can be too
conservative and poll less than we'd hope for.  On the other hand it's
hard to predict the actual ideal polling amount so I guess being
conservative is alright.  Maybe the algorithm can be refined later.

Stefan

--4Ckj6UjgE2iN1+kY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYRvPkAAoJEJykq7OBq3PIOaUH/ipwyUEaDMJFlcZ9HPKUNufV
XGqR/F1Ld7I27QWELSf05qCnjo33kRXNZlGMaH0Mc9JE232qkVcT9vbc7sPOWjw7
7bP+X9etiu75qs3DyOiTF68kpFAfcpxA+ROfXsWKSYUs7c1y9v3B9a7Uo7X1dwUX
DmkVgEYVaTz1+cXKmbZEoSfV516vX+DDu82ENG0WX0v79gs4/OH37717A/5P6Mia
W29usxD2ErlKQ5FIpF3ppEUHTaa17/xMYHQEt5lDuWSkSO63m00zS6C5T6I5OCRR
fes01AdklfW/tAio/IOPTXxIK0l6SAftVvMjTB629TLCcM/C12B+bLhr1qiDuLA=
=fx4S
-----END PGP SIGNATURE-----

--4Ckj6UjgE2iN1+kY--
