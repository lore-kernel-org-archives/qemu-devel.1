Received: from eggs.gnu.org ([209.51.188.92]:42385)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gudIc-0004xd-S4
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 08:13:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gudIc-00064U-4Q
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 08:13:02 -0500
References: <20190215130325.5294-1-dplotnikov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <3df12684-6337-b03f-bd41-386a01ab42b8@redhat.com>
Date: Fri, 15 Feb 2019 07:12:39 -0600
MIME-Version: 1.0
In-Reply-To: <20190215130325.5294-1-dplotnikov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="vTquAen8eMz0qAFx33SN2HAH3VFDP5ooD"
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
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, den@virtuozzo.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--vTquAen8eMz0qAFx33SN2HAH3VFDP5ooD
From: Eric Blake <eblake@redhat.com>
To: Denis Plotnikov <dplotnikov@virtuozzo.com>, kwolf@redhat.com,
 mreitz@redhat.com
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, den@virtuozzo.com
Message-ID: <3df12684-6337-b03f-bd41-386a01ab42b8@redhat.com>
Subject: Re: [PATCH v2] block: don't set the same context
References: <20190215130325.5294-1-dplotnikov@virtuozzo.com>
In-Reply-To: <20190215130325.5294-1-dplotnikov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2/15/19 7:03 AM, Denis Plotnikov wrote:
> Adds a fast path on aio context setting preventing
> unnecessary context setting routine.
> Also, it prevents issues with cyclic walk of child
> bds-es appeared because of registering aio walking
> notifiers:

> Signed-off-by: Denis Plotnikov <dplotnikov@virtuozzo.com>
> ---

Right here, after the ---, is a good place to list how v2 differs from
v1. It looks to me like the only change was a typo fix in the commit
message?  But that still doesn't address the concern on whether this
approach is right in the face of nesting (if attach/detach is always
paired, then attach-attach-detach-detach will cause the inner detach to
pair to the outer attach, any actions between the inner and outer detach
will not be against an attached context, and the outer detach needs to
be safe as a no-op).  The patch may still be right, but I'm not enough
of an expert in how aio attach/detach are supposed to work to know for
sure.  Or, we may need some form of reference counting, so that the
inner detach is a no-op if the inner attach was short-circuited, and the
outer detach then resumes being the proper pair against the outer
attach.  If you have checked why the patch works, then amending the
commit message to address my question will also help future readers that
might otherwise ask the same question. Posting a rapid-turnaround v2 for
just a typo fix, while not addressing the larger question raised as to
whether the patch is correct, is just churn.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--vTquAen8eMz0qAFx33SN2HAH3VFDP5ooD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlxmuscACgkQp6FrSiUn
Q2r7Dwf9EgUH0a48WKNPN9ruf0rLceWb3b7ptwd/BeK+kSvUW6XeS5cgSERUXXjz
OrBBI5feDQu/S2XO45zGaEiktaiv25b59QxmP7iav3NnRpt3WKaD39wiOcgu7dF0
5z/guKZwReTBzIeqyGqXypYrXIUIhk/dQaojyJOBOQyvh8COJgSh33TcluxpKlwW
oU2pMtsw9pBbw0KRns9HvsMOSCSbqFp4B8ISics94GU42JdBIkvJge7iPz+06yN1
H/yBnegOl+poVztYzXegzOyfW9nZowOXd/tYJR4IfnM02Vhhhz5oM3Xzhw2ErA++
VkHon2t0gKU305wVkeljOvi3WK9H3A==
=wIDg
-----END PGP SIGNATURE-----

--vTquAen8eMz0qAFx33SN2HAH3VFDP5ooD--
