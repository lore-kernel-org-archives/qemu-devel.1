Received: from eggs.gnu.org ([2001:4830:134:3::10]:56361)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dtyCG-0006vD-QC
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 11:43:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dtyCF-0005fL-Nl
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 11:42:56 -0400
References: <20170913181910.29688-1-mreitz@redhat.com>
	<20170914154221.GD7370@stefanha-x1.localdomain>
	<ff9cac4f-5dba-666c-fc0d-8c1e3f23e6c9@redhat.com>
	<20170918100226.GD31063@stefanha-x1.localdomain>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <38bf2d1a-ac37-84b0-7d36-689ba4697476@redhat.com>
Date: Mon, 18 Sep 2017 17:42:40 +0200
MIME-Version: 1.0
In-Reply-To: <20170918100226.GD31063@stefanha-x1.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="nOeiSfdPTVsNilGBEwiSsH8lk9oAwWKSk"
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 00/18] block/mirror: Add
 active-sync mirroring
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--nOeiSfdPTVsNilGBEwiSsH8lk9oAwWKSk
From: Max Reitz <mreitz@redhat.com>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Message-ID: <38bf2d1a-ac37-84b0-7d36-689ba4697476@redhat.com>
Subject: Re: [Qemu-block] [PATCH 00/18] block/mirror: Add active-sync
 mirroring
References: <20170913181910.29688-1-mreitz@redhat.com>
 <20170914154221.GD7370@stefanha-x1.localdomain>
 <ff9cac4f-5dba-666c-fc0d-8c1e3f23e6c9@redhat.com>
 <20170918100226.GD31063@stefanha-x1.localdomain>
In-Reply-To: <20170918100226.GD31063@stefanha-x1.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2017-09-18 12:02, Stefan Hajnoczi wrote:
> On Sat, Sep 16, 2017 at 04:02:45PM +0200, Max Reitz wrote:
>> On 2017-09-14 17:42, Stefan Hajnoczi wrote:
>>> On Wed, Sep 13, 2017 at 08:18:52PM +0200, Max Reitz wrote:
>>>> There may be a couple of things to do on top of this series:
>>>> - Allow switching between active and passive mode at runtime: This
>>>>   should not be too difficult to implement, the main question is how=
 to
>>>>   expose it to the user.
>>>>   (I seem to recall we wanted some form of block-job-set-option
>>>>   command...?)
>>>>
>>>> - Implement an asynchronous active mode: May be detrimental when it
>>>>   comes to convergence, but it might be nice to have anyway.  May or=
 may
>>>>   not be complicated to implement.
>>>
>>> Ideally the user doesn't have to know about async vs sync.  It's an
>>> implementation detail.
>>>
>>> Async makes sense during the bulk copy phase (e.g. sync=3Dfull) becau=
se
>>> guest read/write latencies are mostly unaffected.  Once the entire
>>> device has been copied there are probably still dirty blocks left
>>> because the guest touched them while the mirror job was running.  At
>>> that point it definitely makes sense to switch to synchronous mirrori=
ng
>>> in order to converge.
>>
>> Makes sense, but I'm not sure whether it really is just an
>> implementation detail.  If you're in the bulk copy phase in active/asy=
nc
>> mode and you have enough write requests with the target being slow
>> enough, I suspect you might still not get convergence then (because th=
e
>> writes to the target yield for a long time while ever more write
>> requests pile up) -- so then you'd just shift the dirty tracking from
>> the bitmap to a list of requests in progress.
>>
>> And I think we do want the bulk copy phase to guarantee convergence,
>> too, usually (when active/foreground/synchronous mode is selected).  I=
f
>> we don't, then that's a policy decision and would be up to libvirt, as=
 I
>> see it.
>=20
> This is a good point.  Bulk copy should converge too.
>=20
> Can we measure the target write rate and guest write rate?  A heuristic=

> can choose between async vs sync based on the write rates.
>=20
> For example, if the guest write rate has been larger than the target
> write rate for the past 10 seconds during the bulk phase, switch to
> synchronous mirroring.

I guess we can just count how many unfinished target write requests are
piling up.

=2E..or libvirt can simply see that the block job is not progressing and
switch the mode. :-)

Max


--nOeiSfdPTVsNilGBEwiSsH8lk9oAwWKSk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlm/6XASHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9Aj2EH/jWrg373ohhxDeYOePjLSH4aIdXm5Ppm
DZiJu6mQRnaMnlfUTvM95ToAQZPMcTkfijzC/4QOlwqINoliUbT3QkADj8LioUJR
2d3geM4D5fpqeTaEz47eQew4VrsPn3Kej9xxDeVTZGvItCTnHgXbr40VobxuRO+C
GnBbukgNTdHBgyg+1aYbC+QNsh5NYONSRxQX+RK5bt+UBq2PWyTO5r/oLVW3T1ch
PcSwtVEL3Nz3xX+ETNVlDmvssmSkplcNKsYmzBN/u2VAYHgqMLE3nDVvhhS0GiXx
YmtgEK3P1EdspyeVHumLNCOoq1fJxP+0nthNsrUvkYL5E1lSSYUdySA=
=NIuT
-----END PGP SIGNATURE-----

--nOeiSfdPTVsNilGBEwiSsH8lk9oAwWKSk--
