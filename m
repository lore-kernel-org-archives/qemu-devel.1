Received: from eggs.gnu.org ([2001:4830:134:3::10]:41676)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dDPzu-0007ds-0m
	for qemu-devel@nongnu.org; Wed, 24 May 2017 02:42:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dDPzs-0000RM-W6
	for qemu-devel@nongnu.org; Wed, 24 May 2017 02:42:18 -0400
Date: Wed, 24 May 2017 16:36:17 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170524063617.GX30246@umbus.fritz.box>
References: <1495601614-18586-1-git-send-email-bharata@linux.vnet.ibm.com>
	<1495601614-18586-2-git-send-email-bharata@linux.vnet.ibm.com>
	<87a8627opg.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="p11K2BJEgMZL61bg"
Content-Disposition: inline
In-Reply-To: <87a8627opg.fsf@secure.mitica>
Subject: Re: [Qemu-devel] [PATCH v3 1/3] migration: Introduce
 unregister_savevm_live()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Juan Quintela <quintela@redhat.com>
Cc: Bharata B Rao <bharata@linux.vnet.ibm.com>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, sam.bobroff@au1.ibm.com, rnsastry@linux.vnet.ibm.com, sjitindarsingh@gmail.com, "Dr . David Alan Gilbert" <dgilbert@redhat.com>


--p11K2BJEgMZL61bg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 24, 2017 at 08:28:59AM +0200, Juan Quintela wrote:
> Bharata B Rao <bharata@linux.vnet.ibm.com> wrote:
> > Introduce a new function unregister_savevm_live() to unregister the vms=
tate
> > handlers registered via register_savevm_live().
> >
> > register_savevm() allocates SaveVMHandlers while register_savevm_live()
> > gets passed with SaveVMHandlers. During unregistration, we  want to
> > free SaveVMHandlers in the former case but not free in the latter case.
> > Hence this new API is needed to differentiate this.
> >
> > This new API will be needed by PowerPC to unregister the HTAB savevm
> > handlers.
> >
> > Signed-off-by: Bharata B Rao <bharata@linux.vnet.ibm.com>
> > Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
> > Cc: Juan Quintela <quintela@redhat.com>
> > Cc: Dr. David Alan Gilbert <dgilbert@redhat.com>
>=20
> Hi
>=20
> How about this one?
> I just test compiled it.
>=20
> Advantage from my point of view is that we always do the right thing.
> And as migration code already knows if it has to be freed or not, I
> think it is a better API.
>=20
> What do you think?

I think this is a better approach.  Do you want to push this one
directly, Juan, or do you want me to take it through my tree?

>=20
> Later, Juan.
>=20
> commit 6e71fac7a9c29cef9625135c58ce59ccfbb3b86f
> Author: Juan Quintela <quintela@redhat.com>
> Date:   Wed May 24 08:25:06 2017 +0200
>=20
>     migration: Allow to free save_live handlers
>    =20
>     Migration save_live handlers have an ops member that is not dynamic.
>     Add a new member is_allocated that remembers if ops has to be freed.
>    =20
>     Signed-off-by: Juan Quintela <quintela@redhat.com>
>=20
> diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
> index f97411d..1d20e30 100644
> --- a/include/migration/vmstate.h
> +++ b/include/migration/vmstate.h
> @@ -57,6 +57,8 @@ typedef struct SaveVMHandlers {
>                                uint64_t *non_postcopiable_pending,
>                                uint64_t *postcopiable_pending);
>      LoadStateHandler *load_state;
> +    /* Has been allocated by migratation code */
> +    bool is_allocated;
>  } SaveVMHandlers;
> =20
>  int register_savevm(DeviceState *dev,
> diff --git a/migration/savevm.c b/migration/savevm.c
> index d971e5e..187f386 100644
> --- a/migration/savevm.c
> +++ b/migration/savevm.c
> @@ -628,6 +628,7 @@ int register_savevm(DeviceState *dev,
>      SaveVMHandlers *ops =3D g_new0(SaveVMHandlers, 1);
>      ops->save_state =3D save_state;
>      ops->load_state =3D load_state;
> +    ops->is_allocated =3D true;
>      return register_savevm_live(dev, idstr, instance_id, version_id,
>                                  ops, opaque);
>  }
> @@ -651,7 +652,9 @@ void unregister_savevm(DeviceState *dev, const char *=
idstr, void *opaque)
>          if (strcmp(se->idstr, id) =3D=3D 0 && se->opaque =3D=3D opaque) {
>              QTAILQ_REMOVE(&savevm_state.handlers, se, entry);
>              g_free(se->compat);
> -            g_free(se->ops);
> +            if (se->ops->is_allocated) {
> +                g_free(se->ops);
> +            }
>              g_free(se);
>          }
>      }
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--p11K2BJEgMZL61bg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZJSnfAAoJEGw4ysog2bOS7M8QAKgqZ+MpCksJuNAOrf72WYmg
MBXMgY2vM+PMr9TDkEmwDfu053HniHKDghSdOf+8vZmm+YDYGFwrFp1yLsjrzVQl
S07GhO4+3jZNKSjLeNygwhxjccCkm06vxz1/jHRdM9Dm7BpnFil3DXSQ/YTlZ3nV
v+GcPDMny5p92kmoax4qkVg+qWg+gzv6JSYyhXSayRJXH3g1bdi7ANG3xZuiF9cn
ILErdDIpsInE0Ht8XJ3ZflDFqzY6NilylcZp4f9qkgYXD/2EmpYC9BlO6VouzIIB
3rZPLsnhTgdHBqFH2wKsZpv8h4+DvqajnrpVGXg6U6xInFB2++BASsKUwdf8ww4u
HdNfTuxU1ypY8gaBx11QOav46wp4PvwdzoJRW/2KP/tIbhOvXE61fQrUvfR93OKN
qo7xy1gbynEJZQHovg1LlbAuxCeWW9tx3+UMsoc5s3ORNwb2/vTmkRLXLeGmH+8n
KYAO5sovFPxtYQndTx4OGbVgHDZ6BsnX81hWjJB4HFy525VFpeUzFlYWgCMZZpgi
If0gpr3vbg0WSYseJEsURSt2z3WAJoyVQMVhQGd0kRkWijIJcitQ9ARu7ZbFhGKI
J7bHlo8uq7QmEoXGkTur4IsU/VcV/zY+PpjGI3cWsjaROWyztJpT69vCOakwx7kf
RRs25CK2K3K8+6znIT71
=pE7o
-----END PGP SIGNATURE-----

--p11K2BJEgMZL61bg--
