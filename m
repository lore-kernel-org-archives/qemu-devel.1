Received: from eggs.gnu.org ([209.51.188.92]:33855)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gugs2-0002UL-7p
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 12:01:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gugrp-0006zh-Vj
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 12:01:40 -0500
References: <20190215130325.5294-1-dplotnikov@virtuozzo.com>
	<3df12684-6337-b03f-bd41-386a01ab42b8@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <bb9cb41e-25f7-bd30-f48b-05915dba501d@redhat.com>
Date: Fri, 15 Feb 2019 11:01:15 -0600
MIME-Version: 1.0
In-Reply-To: <3df12684-6337-b03f-bd41-386a01ab42b8@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="LqHcUA9xIiD2AibwHgInTmMG0IrZIXOLw"
Subject: Re: [Qemu-devel] [PATCH v2] block: don't set the same context
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Denis Plotnikov <dplotnikov@virtuozzo.com>, kwolf@redhat.com, mreitz@redhat.com
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, den@virtuozzo.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--LqHcUA9xIiD2AibwHgInTmMG0IrZIXOLw
From: Eric Blake <eblake@redhat.com>
To: Denis Plotnikov <dplotnikov@virtuozzo.com>, kwolf@redhat.com,
 mreitz@redhat.com
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, den@virtuozzo.com
Message-ID: <bb9cb41e-25f7-bd30-f48b-05915dba501d@redhat.com>
Subject: Re: [PATCH v2] block: don't set the same context
References: <20190215130325.5294-1-dplotnikov@virtuozzo.com>
 <3df12684-6337-b03f-bd41-386a01ab42b8@redhat.com>
In-Reply-To: <3df12684-6337-b03f-bd41-386a01ab42b8@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2/15/19 7:12 AM, Eric Blake wrote:
> On 2/15/19 7:03 AM, Denis Plotnikov wrote:
>> Adds a fast path on aio context setting preventing
>> unnecessary context setting routine.
>> Also, it prevents issues with cyclic walk of child
>> bds-es appeared because of registering aio walking
>> notifiers:
>=20
>> Signed-off-by: Denis Plotnikov <dplotnikov@virtuozzo.com>
>> ---
>=20
> Right here, after the ---, is a good place to list how v2 differs from
> v1. It looks to me like the only change was a typo fix in the commit
> message?  But that still doesn't address the concern on whether this
> approach is right in the face of nesting (if attach/detach is always
> paired, then attach-attach-detach-detach will cause the inner detach to=

> pair to the outer attach, any actions between the inner and outer detac=
h
> will not be against an attached context, and the outer detach needs to
> be safe as a no-op).  The patch may still be right, but I'm not enough
> of an expert in how aio attach/detach are supposed to work to know for
> sure.  Or, we may need some form of reference counting, so that the
> inner detach is a no-op if the inner attach was short-circuited, and th=
e
> outer detach then resumes being the proper pair against the outer
> attach.  If you have checked why the patch works, then amending the
> commit message to address my question will also help future readers tha=
t
> might otherwise ask the same question. Posting a rapid-turnaround v2 fo=
r
> just a typo fix, while not addressing the larger question raised as to
> whether the patch is correct, is just churn.

Having now re-read the patch, I see that you are patching
bdrv_set_aio_context, even though your commit message focused my
attention on the nesting:

>=20
> 3  __GI___assert_fail
> 4  bdrv_detach_aio_context (bs=3D0x55f54d65c000)      <<<
> 5  bdrv_detach_aio_context (bs=3D0x55f54fc8a800)
> 6  bdrv_set_aio_context (bs=3D0x55f54fc8a800, ...)
> 7  block_job_attached_aio_context
> 8  bdrv_attach_aio_context (bs=3D0x55f54d65c000, ...) <<<
> 9  bdrv_set_aio_context (bs=3D0x55f54d65c000)

That is, you marked lines 4 and 8 as forming nested attach/detach pairs,
rather than 6 and 9 as nested set calls. If I understand the point of
this patch, your goal is to realize that setting the context to what it
already has is pointless, and by short-circuiting the second set, you
can then completely bypass the nested attach/detach.  So it looks like
the change is correct, and that it is merely that the commit message
could still be improved to do a better job of calling out that the
symptoms were a nested attach/detach, but the fix is to avoid the nested
calls by fixing the setting to be smarter on the realization that
setting can be reached more than once.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--LqHcUA9xIiD2AibwHgInTmMG0IrZIXOLw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlxm8FsACgkQp6FrSiUn
Q2pTSwgAgazGRgwc00OPLiR2MFGzIubal4AxoXcHZ6ifJkWfWrc1k6bjP5xmyyC/
f2nlgJgjHhvAAB+a62FxxLumGDv2x1pt0vAq9mma2Qox7NEELK9mdJet4y2uJvkO
wzAlh/p3YGZfI21KHHSAmvfrB3QFYzM8i5NimwBQHvorf+a2Sv1TeqQL21FStg+O
M0mu+I/zLoD0cPIPuQLiGfFKs/oFEcITSMZzsKgM8SxzGxfSFJlU+hZygsHZx0/s
5e6xiaxljcUV/5wrkRvuENvPiD2Bc88+AH7HhjMWTwI9XlHME9JSG21Fg79DfJWj
BhMbVYKhyxfWOvR/H06KO0OZErolfg==
=EYqx
-----END PGP SIGNATURE-----

--LqHcUA9xIiD2AibwHgInTmMG0IrZIXOLw--
