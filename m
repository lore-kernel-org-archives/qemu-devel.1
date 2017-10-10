Received: from eggs.gnu.org ([2001:4830:134:3::10]:54922)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1e1rac-00087W-HI
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 06:16:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1e1raY-0003vP-61
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 06:16:42 -0400
Date: Tue, 10 Oct 2017 12:16:22 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20171010101622.GH4177@dhcp-200-186.str.redhat.com>
References: <20170913181910.29688-1-mreitz@redhat.com>
	<20170913181910.29688-16-mreitz@redhat.com>
	<20170914155738.GE7370@stefanha-x1.localdomain>
	<2f1c5239-0cde-d164-b803-ebf807e684f2@redhat.com>
	<20170918100626.GE31063@stefanha-x1.localdomain>
	<d6dbcebf-6dce-4803-0be0-a9f48a73a32f@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="wac7ysb48OaltWcw"
Content-Disposition: inline
In-Reply-To: <d6dbcebf-6dce-4803-0be0-a9f48a73a32f@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 15/18] block/mirror: Add
 active mirroring
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org


--wac7ysb48OaltWcw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 18.09.2017 um 18:26 hat Max Reitz geschrieben:
> On 2017-09-18 12:06, Stefan Hajnoczi wrote:
> > On Sat, Sep 16, 2017 at 03:58:01PM +0200, Max Reitz wrote:
> >> On 2017-09-14 17:57, Stefan Hajnoczi wrote:
> >>> On Wed, Sep 13, 2017 at 08:19:07PM +0200, Max Reitz wrote:
> >>>> This patch implements active synchronous mirroring.  In active mode,=
 the
> >>>> passive mechanism will still be in place and is used to copy all
> >>>> initially dirty clusters off the source disk; but every write request
> >>>> will write data both to the source and the target disk, so the source
> >>>> cannot be dirtied faster than data is mirrored to the target.  Also,
> >>>> once the block job has converged (BLOCK_JOB_READY sent), source and
> >>>> target are guaranteed to stay in sync (unless an error occurs).
> >>>>
> >>>> Optionally, dirty data can be copied to the target disk on read
> >>>> operations, too.
> >>>>
> >>>> Active mode is completely optional and currently disabled at runtime=
=2E  A
> >>>> later patch will add a way for users to enable it.
> >>>>
> >>>> Signed-off-by: Max Reitz <mreitz@redhat.com>
> >>>> ---
> >>>>  qapi/block-core.json |  23 +++++++
> >>>>  block/mirror.c       | 187 ++++++++++++++++++++++++++++++++++++++++=
+++++++++--
> >>>>  2 files changed, 205 insertions(+), 5 deletions(-)
> >>>>
> >>>> diff --git a/qapi/block-core.json b/qapi/block-core.json
> >>>> index bb11815608..e072cfa67c 100644
> >>>> --- a/qapi/block-core.json
> >>>> +++ b/qapi/block-core.json
> >>>> @@ -938,6 +938,29 @@
> >>>>    'data': ['top', 'full', 'none', 'incremental'] }
> >>>> =20
> >>>>  ##
> >>>> +# @MirrorCopyMode:
> >>>> +#
> >>>> +# An enumeration whose values tell the mirror block job when to
> >>>> +# trigger writes to the target.
> >>>> +#
> >>>> +# @passive: copy data in background only.
> >>>> +#
> >>>> +# @active-write: when data is written to the source, write it
> >>>> +#                (synchronously) to the target as well.  In additio=
n,
> >>>> +#                data is copied in background just like in @passive
> >>>> +#                mode.
> >>>> +#
> >>>> +# @active-read-write: write data to the target (synchronously) both
> >>>> +#                     when it is read from and written to the sourc=
e.
> >>>> +#                     In addition, data is copied in background just
> >>>> +#                     like in @passive mode.
> >>>
> >>> I'm not sure the terms "active"/"passive" are helpful.  "Active commi=
t"
> >>> means committing the top-most BDS while the guest is accessing it.  T=
he
> >>> "passive" mirror block still works on the top-most BDS while the guest
> >>> is accessing it.
> >>>
> >>> Calling it "asynchronous" and "synchronous" is clearer to me.  It's a=
lso
> >>> the terminology used in disk replication (e.g. DRBD).
> >>
> >> I'd be OK with that, too, but I think I remember that in the past at
> >> least Kevin made a clear distinction between active/passive and
> >> sync/async when it comes to mirroring.
> >>
> >>> Ideally the user wouldn't have to worry about async vs sync because Q=
EMU
> >>> would switch modes as appropriate in order to converge.  That way
> >>> libvirt also doesn't have to worry about this.
> >>
> >> So here you mean async/sync in the way I meant it, i.e., whether the
> >> mirror operations themselves are async/sync?
> >=20
> > The meaning I had in mind is:
> >=20
> > Sync mirroring means a guest write waits until the target write
> > completes.
>=20
> I.e. active-sync, ...
>=20
> > Async mirroring means guest writes completes independently of target
> > writes.
>=20
> ... i.e. passive or active-async in the future.

So we already have at least three different modes, sync/async doesn't
quite cut it anyway. There's a reason why we have been talking about
both active/passive and sync/async.

When I was looking at the code, it actually occurred to me that there
are more possible different modes than I thought there were: This patch
waits for successful completion on the source before it even attempts to
write to the destination.

Wouldn't it be generally (i.e. in the success case) more useful if we
start both requests at the same time and only wait for both to complete,
avoiding to double the latency? If the source write fails, we're out of
sync, obviously, so we'd have to mark the block dirty again.

By the way, what happens when the guest modifies the RAM during the
request? Is it acceptable even for writes if source and target differ
after a successful write operation? Don't we need a bounce buffer
anyway?

Kevin

--wac7ysb48OaltWcw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJZ3J32AAoJEH8JsnLIjy/W644P/1M3dV/CDasCZfLZWQRunSAC
devZaCDB+OrXIAu3CWsRETnaUvpokmvMQO3Dun5qMprTPm1X4cSZ4geFfQvHjrL/
MsnlqMLnlMNBFGTO6GkO50Bm4aOcpNwk5KRh5dYptsngBM11s63/nWtxKP7mqQ3D
BxrbNKQDr9Mg7E0BlkyZXQX9N0sspTe2h05souwhMUS6xIPWRJb6facrY+GNxmrs
uZMRO844Y1yrdoj6Auz/Ly3yd6Dh0ybN1RCxD5z+Iz7PtBneBjVzwx9jsUHaXwbV
y7heml2CNWR84DI/geY0z3WB6wgfO/GVPpjGSjtUO++3FvH8AQtQlAaQDurY4VTN
bMkcQSBQR9CAzB2eebgz4xRv+iH4DwBEaTVd/IeiRKJsajQBf2SmISFfa+kMEmEj
uHiDhnW/ECvm7qtDciepNtw8NTODpNFYveFnbktoTQIh1VE0H6pKwUHTXn2E20dI
oPK9NtRd4veipIuqW34FWRzTON6nWEHPKMJkJWGQ2dt1mcOenXAsJh7eFalNPEb9
ltXP5ytc9NLDkkNT4VGi+ObbNediPJbchLkWOCd6d9bUwen4oPtA/wmS1hypUAST
epOu4OtblXunfakuPsrpK9/5XSwEKKAc8PbEeyV0ZfINILbEYmFP3e/9S7REvfgO
wqQS9fG9BAm9qqlx1Iyf
=GYwJ
-----END PGP SIGNATURE-----

--wac7ysb48OaltWcw--
