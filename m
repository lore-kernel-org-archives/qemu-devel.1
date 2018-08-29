Received: from eggs.gnu.org ([2001:4830:134:3::10]:43243)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fuyrP-00028Q-CX
	for qemu-devel@nongnu.org; Wed, 29 Aug 2018 07:42:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fuycf-0001B5-Mp
	for qemu-devel@nongnu.org; Wed, 29 Aug 2018 07:26:54 -0400
References: <cover.1535291602.git.berto@igalia.com>
	<d470d52cfc97265fec584e6b7d4b5a89c37a1739.1535291602.git.berto@igalia.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <c9cb16fe-8e23-50c4-67c0-3c5952163099@redhat.com>
Date: Wed, 29 Aug 2018 13:26:46 +0200
MIME-Version: 1.0
In-Reply-To: <d470d52cfc97265fec584e6b7d4b5a89c37a1739.1535291602.git.berto@igalia.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="5gMDOBD76EatADTyVctlkGhyMeIvl24iH"
Subject: Re: [Qemu-devel] [PATCH 5/9] block: Allow child references on reopen
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--5gMDOBD76EatADTyVctlkGhyMeIvl24iH
From: Max Reitz <mreitz@redhat.com>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>
Message-ID: <c9cb16fe-8e23-50c4-67c0-3c5952163099@redhat.com>
Subject: Re: [PATCH 5/9] block: Allow child references on reopen
References: <cover.1535291602.git.berto@igalia.com>
 <d470d52cfc97265fec584e6b7d4b5a89c37a1739.1535291602.git.berto@igalia.com>
In-Reply-To: <d470d52cfc97265fec584e6b7d4b5a89c37a1739.1535291602.git.berto@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-08-26 16:09, Alberto Garcia wrote:
> In the previous patches we removed all child references from
> bs->{options,explicit_options} because keeping them is useless and
> wrong.
>=20
> Because of this, any attempt to reopen a BlockDriverState using a
> child reference as one of its options would result in a failure,
> because bdrv_reopen_prepare() would detect that there's a new option
> (the child reference) that wasn't present in bs->options.
>=20
> But passing child references on reopen can be useful. It's a way to
> specify a BDS's child without having to pass recursively all of the
> child's options, and if the reference points to a different BDS then
> this can allow us to replace the child.
>=20
> However, replacing the child is something that needs to be implemented
> case by case and only when it makes sense. For now, this patch allows
> passing a child reference as long as it points to the current child of
> the BlockDriverState.

"For now"?  If you intend it to be case-by-case, won't it be handled by
the driver's bdrv_reopen_prepare() implementation?

> It's also important to remember that, as a consequence of the
> previous patches, this child reference will be removed from
> bs->{options,explicit_options} after the reopening has been completed.
>=20
> Signed-off-by: Alberto Garcia <berto@igalia.com>
> ---
>  block.c | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
>=20
> diff --git a/block.c b/block.c
> index 92afb3dcce..804d557608 100644
> --- a/block.c
> +++ b/block.c
> @@ -3241,6 +3241,25 @@ int bdrv_reopen_prepare(BDRVReopenState *reopen_=
state, BlockReopenQueue *queue,
>              QObject *new =3D entry->value;
>              QObject *old =3D qdict_get(reopen_state->bs->options, entr=
y->key);
> =20
> +            /* We allow child references 'child_name'=3D'value'
> +             * if 'child_name' is an existing child of the BDS
> +             * and 'value' is the child's node name (a string). */
> +            if (qobject_type(new) =3D=3D QTYPE_QSTRING) {
> +                BdrvChild *child;
> +                QLIST_FOREACH(child, &reopen_state->bs->children, next=
) {
> +                    if (!strcmp(child->name, entry->key)) {
> +                        break;
> +                    }
> +                }
> +
> +                if (child) {
> +                    const char *str =3D qobject_get_try_str(new);
> +                    if (!strcmp(child->bs->node_name, str)) {
> +                        continue; /* Found child with this name, skip =
option */
> +                    }
> +                }
> +            }
> +

Looks good, but I think the comment looks a bit convoluted.  Maybe add a
note like "(so the child has to stay the same)"?

Third...  Hm.  This is just a general question.  So as far as I
understand we decided that when you don't specify an option for reopen,
it means that the default is used, and that we don't want to retain the
old value.  Specifically, that means when you don't specify @backing,
the default chain will be opened and may replace the current one.  So
for other children, not specifying them should mean detaching them.

So why isn't it mandatory to re-specify all children for now?

Max


--5gMDOBD76EatADTyVctlkGhyMeIvl24iH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAluGgvYACgkQ9AfbAGHV
z0DK6wf/eympZECxNjpvPCccVsINTWNyQHHNL63QxL+rMiV28k0djiWiC/TpMQ0O
KGyacMFmXjDemWeGUB39V5OM8uOCdr2U2OXxC9Y+RHL7dXSTL+UV5RqpJdWsLK4L
Gl3Hkf3XR6rYjI5EwfMHHyU05997vr1VbQnedIm227sObGp0wFzobwVkCfrFZGVc
3TNrJczrTVpFjL65JndZuo5GU3yEDNgA9oCNt4iXueVA4msr6OyUeajeLIuR5Lxe
rmeYyZEOl8iX9StZHQTk24ckXeM2u3e2EWpBfWF4G1JuknoJCI4HzkYv28ybpQBR
ItNMQMWB2yyPs5KVoFueDOUkVUWMlg==
=aFau
-----END PGP SIGNATURE-----

--5gMDOBD76EatADTyVctlkGhyMeIvl24iH--
