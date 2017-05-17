Received: from eggs.gnu.org ([2001:4830:134:3::10]:35706)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dAsxF-0002k4-8j
	for qemu-devel@nongnu.org; Wed, 17 May 2017 03:01:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dAsxB-00048e-PG
	for qemu-devel@nongnu.org; Wed, 17 May 2017 03:01:05 -0400
Date: Wed, 17 May 2017 16:45:44 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170517064544.GK15596@umbus.fritz.box>
References: <1494992962-6929-1-git-send-email-bharata@linux.vnet.ibm.com>
	<1494992962-6929-3-git-send-email-bharata@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="M9kwpIYUMbI/2cCx"
Content-Disposition: inline
In-Reply-To: <1494992962-6929-3-git-send-email-bharata@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [RFC PATCH v1 2/6] migration: Introduce
 unregister_savevm_live()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Bharata B Rao <bharata@linux.vnet.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, sam.bobroff@au1.ibm.com, rnsastry@linux.vnet.ibm.com


--M9kwpIYUMbI/2cCx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 17, 2017 at 09:19:18AM +0530, Bharata B Rao wrote:
> Introduce a new function unregister_savevm_live() to unregister the vmsta=
te
> handlers registered via register_savevm_live().
>=20
> register_savevm() allocates SaveVMHandlers while register_savevm_live()
> gets passed with SaveVMHandlers. During unregistration, we  want to
> free SaveVMHandlers in the former case but not free in the latter case.
> Hence this new API is needed to differentiate this.
>=20
> This new API will be needed by PowerPC to unregister the HTAB savevm
> handlers.
>=20
> Signed-off-by: Bharata B Rao <bharata@linux.vnet.ibm.com>

It's not my bailiwick, so I don't get final say, but I dislike
changing the signature of the existing unregister_savevm() interface.
I think it would be preferable to only add the 'live' paramter to a
new unregister_savevm_common() (or whatever) function.

> ---
>  hw/net/vmxnet3.c            |  2 +-
>  hw/s390x/s390-skeys.c       |  2 +-
>  include/migration/vmstate.h |  4 +++-
>  migration/savevm.c          | 12 ++++++++++--
>  slirp/slirp.c               |  2 +-
>  5 files changed, 16 insertions(+), 6 deletions(-)
>=20
> diff --git a/hw/net/vmxnet3.c b/hw/net/vmxnet3.c
> index 8b1fab2..2b923be 100644
> --- a/hw/net/vmxnet3.c
> +++ b/hw/net/vmxnet3.c
> @@ -2350,7 +2350,7 @@ static void vmxnet3_pci_uninit(PCIDevice *pci_dev)
> =20
>      VMW_CBPRN("Starting uninit...");
> =20
> -    unregister_savevm(dev, "vmxnet3-msix", s);
> +    unregister_savevm(dev, "vmxnet3-msix", s, false);
> =20
>      vmxnet3_net_uninit(s);
> =20
> diff --git a/hw/s390x/s390-skeys.c b/hw/s390x/s390-skeys.c
> index e2d4e1a..32b6435 100644
> --- a/hw/s390x/s390-skeys.c
> +++ b/hw/s390x/s390-skeys.c
> @@ -379,7 +379,7 @@ static inline void s390_skeys_set_migration_enabled(O=
bject *obj, bool value,
>          register_savevm(NULL, TYPE_S390_SKEYS, 0, 1, s390_storage_keys_s=
ave,
>                          s390_storage_keys_load, ss);
>      } else {
> -        unregister_savevm(DEVICE(ss), TYPE_S390_SKEYS, ss);
> +        unregister_savevm(DEVICE(ss), TYPE_S390_SKEYS, ss, false);
>      }
>  }
> =20
> diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
> index f4bf3f1..ba81b3e 100644
> --- a/include/migration/vmstate.h
> +++ b/include/migration/vmstate.h
> @@ -78,7 +78,9 @@ int register_savevm_live(DeviceState *dev,
>                           SaveVMHandlers *ops,
>                           void *opaque);
> =20
> -void unregister_savevm(DeviceState *dev, const char *idstr, void *opaque=
);
> +void unregister_savevm(DeviceState *dev, const char *idstr, void *opaque,
> +                       bool live);
> +void unregister_savevm_live(DeviceState *dev, const char *idstr, void *o=
paque);
> =20
>  typedef struct VMStateInfo VMStateInfo;
>  typedef struct VMStateDescription VMStateDescription;
> diff --git a/migration/savevm.c b/migration/savevm.c
> index 7a268ec..fa7c3db 100644
> --- a/migration/savevm.c
> +++ b/migration/savevm.c
> @@ -630,7 +630,8 @@ int register_savevm(DeviceState *dev,
>                                  ops, opaque);
>  }
> =20
> -void unregister_savevm(DeviceState *dev, const char *idstr, void *opaque)
> +void unregister_savevm(DeviceState *dev, const char *idstr, void *opaque,
> +                       bool live)
>  {
>      SaveStateEntry *se, *new_se;
>      char id[256] =3D "";
> @@ -651,12 +652,19 @@ void unregister_savevm(DeviceState *dev, const char=
 *idstr, void *opaque)
>              if (dev) {
>                  g_free(se->compat);
>              }
> -            g_free(se->ops);
> +            if (!live) {
> +                g_free(se->ops);
> +            }
>              g_free(se);
>          }
>      }
>  }
> =20
> +void unregister_savevm_live(DeviceState *dev, const char *idstr, void *o=
paque)
> +{
> +    unregister_savevm(dev, idstr, opaque, true);
> +}
> +
>  int vmstate_register_with_alias_id(DeviceState *dev, int instance_id,
>                                     const VMStateDescription *vmsd,
>                                     void *opaque, int alias_id,
> diff --git a/slirp/slirp.c b/slirp/slirp.c
> index 2f2ec2c..108e669 100644
> --- a/slirp/slirp.c
> +++ b/slirp/slirp.c
> @@ -333,7 +333,7 @@ void slirp_cleanup(Slirp *slirp)
>  {
>      QTAILQ_REMOVE(&slirp_instances, slirp, entry);
> =20
> -    unregister_savevm(NULL, "slirp", slirp);
> +    unregister_savevm(NULL, "slirp", slirp, false);
> =20
>      ip_cleanup(slirp);
>      ip6_cleanup(slirp);

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--M9kwpIYUMbI/2cCx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZG/GYAAoJEGw4ysog2bOSYvUP/jtP1iFGT/MKp+HLb8M9ANGM
Y/obsdVWuwddgjPAGw3dl2zYl+v2GJoLXnw+QOtrG/CDzyW3Bhi/qF9t0VMdfNgt
x8sKBY2j2LZbnmuDSk5KSBf1qKyWnU6wghjikDPCuu3ZirA5s6HZEky3EWZI3vIY
gcr+wT6Fhgp9L481Ab6WBFZkIUHtLKdBrXYAzA0dOaJtMW8jbIaaBSfxiq1B3jHt
H0WuYGbjOWFUFm8HR1qE9OoaQCOccoBgTZJ+56OGCWQX7qWF7Q/3Rn3P3F7eUidc
TIgDZkS6/N/X3EUJNhDf6XWDyNWtwUlhrP93JzKTd35QdF9+poH63l7WiCUY4wUq
1BJ/HdcDLqpHo1F1TdPeKZzWHwGvsGMrrUf7WNGDoj1XhPasE0xWRkklf74UTGmK
xm8xLLF+F0+Ktmb8eKsBNnL+KorQE6XPtUVz5uh3rvqxo5y3KalrWX6CoPgGNQIG
JbSSF/STvYE4dPLGoXXmDAOg+vBGrx4S9XU89CfNJTNssnNN+nkVFUItDLuGIXJd
t6wXV7UdqoauA1zhF5Hq+InIqrCwPLvQsFka9Ublyp+7vZ2+GVZpvlHd0V93UhtF
LzYvwV8eIGLL1SQDFkqhVU1N29We4s/swrB93z0UlhnJlKhpa7UKzZyvo+z9JRcv
H0c8WUjq6m8QzY9ZBQpM
=SUJc
-----END PGP SIGNATURE-----

--M9kwpIYUMbI/2cCx--
