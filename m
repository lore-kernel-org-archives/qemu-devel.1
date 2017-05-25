Received: from eggs.gnu.org ([2001:4830:134:3::10]:56565)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dDgzS-0001XO-TX
	for qemu-devel@nongnu.org; Wed, 24 May 2017 20:51:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dDgzR-0008Iv-9H
	for qemu-devel@nongnu.org; Wed, 24 May 2017 20:50:58 -0400
Date: Thu, 25 May 2017 10:33:10 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170525003310.GC12929@umbus.fritz.box>
References: <20170524121048.10067-1-lvivier@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="32u276st3Jlj2kUU"
Content-Disposition: inline
In-Reply-To: <20170524121048.10067-1-lvivier@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] migration: remove register_savevm()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <lvivier@redhat.com>
Cc: Juan Quintela <quintela@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, rnsastry@linux.vnet.ibm.com, Bharata B Rao <bharata@linux.vnet.ibm.com>, qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>, Jason Wang <jasowang@redhat.com>, Dmitry Fleytman <dmitry@daynix.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, qemu-ppc@nongnu.org, Samuel Thibault <samuel.thibault@ens-lyon.org>, sam.bobroff@au1.ibm.com, Peter Xu <peterx@redhat.com>


--32u276st3Jlj2kUU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 24, 2017 at 02:10:48PM +0200, Laurent Vivier wrote:
> We can replace the four remaining calls of register_savevm() by
> calls to register_savevm_live(). So we can remove the function and
> as we don't allocate anymore the ops pointer with g_new0()
> we don't have to free it then.
>=20
> Signed-off-by: Laurent Vivier <lvivier@redhat.com>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  hw/net/vmxnet3.c            |  8 ++++++--
>  hw/s390x/s390-skeys.c       |  9 +++++++--
>  hw/s390x/s390-virtio-ccw.c  |  8 ++++++--
>  include/migration/vmstate.h |  8 --------
>  migration/savevm.c          | 16 ----------------
>  slirp/slirp.c               |  8 ++++++--
>  6 files changed, 25 insertions(+), 32 deletions(-)
>=20
> diff --git a/hw/net/vmxnet3.c b/hw/net/vmxnet3.c
> index 8b1fab2..4df3110 100644
> --- a/hw/net/vmxnet3.c
> +++ b/hw/net/vmxnet3.c
> @@ -2262,6 +2262,11 @@ static const MemoryRegionOps b1_ops =3D {
>      },
>  };
> =20
> +static SaveVMHandlers savevm_vmxnet3_msix =3D {
> +    .save_state =3D vmxnet3_msix_save,
> +    .load_state =3D vmxnet3_msix_load,
> +};
> +
>  static uint64_t vmxnet3_device_serial_num(VMXNET3State *s)
>  {
>      uint64_t dsn_payload;
> @@ -2331,8 +2336,7 @@ static void vmxnet3_pci_realize(PCIDevice *pci_dev,=
 Error **errp)
>                                vmxnet3_device_serial_num(s));
>      }
> =20
> -    register_savevm(dev, "vmxnet3-msix", -1, 1,
> -                    vmxnet3_msix_save, vmxnet3_msix_load, s);
> +    register_savevm_live(dev, "vmxnet3-msix", -1, 1, &savevm_vmxnet3_msi=
x, s);
>  }
> =20
>  static void vmxnet3_instance_init(Object *obj)
> diff --git a/hw/s390x/s390-skeys.c b/hw/s390x/s390-skeys.c
> index e2d4e1a..a3dc088 100644
> --- a/hw/s390x/s390-skeys.c
> +++ b/hw/s390x/s390-skeys.c
> @@ -363,6 +363,11 @@ static inline bool s390_skeys_get_migration_enabled(=
Object *obj, Error **errp)
>      return ss->migration_enabled;
>  }
> =20
> +static SaveVMHandlers savevm_s390_storage_keys =3D {
> +    .save_state =3D s390_storage_keys_save,
> +    .load_state =3D s390_storage_keys_load,
> +};
> +
>  static inline void s390_skeys_set_migration_enabled(Object *obj, bool va=
lue,
>                                              Error **errp)
>  {
> @@ -376,8 +381,8 @@ static inline void s390_skeys_set_migration_enabled(O=
bject *obj, bool value,
>      ss->migration_enabled =3D value;
> =20
>      if (ss->migration_enabled) {
> -        register_savevm(NULL, TYPE_S390_SKEYS, 0, 1, s390_storage_keys_s=
ave,
> -                        s390_storage_keys_load, ss);
> +        register_savevm_live(NULL, TYPE_S390_SKEYS, 0, 1,
> +                             &savevm_s390_storage_keys, ss);
>      } else {
>          unregister_savevm(DEVICE(ss), TYPE_S390_SKEYS, ss);
>      }
> diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
> index fdd4384..697a2d6 100644
> --- a/hw/s390x/s390-virtio-ccw.c
> +++ b/hw/s390x/s390-virtio-ccw.c
> @@ -104,6 +104,11 @@ void s390_memory_init(ram_addr_t mem_size)
>      s390_skeys_init();
>  }
> =20
> +static SaveVMHandlers savevm_gtod =3D {
> +    .save_state =3D gtod_save,
> +    .load_state =3D gtod_load,
> +};
> +
>  static void ccw_init(MachineState *machine)
>  {
>      int ret;
> @@ -146,8 +151,7 @@ static void ccw_init(MachineState *machine)
>      s390_create_virtio_net(BUS(css_bus), "virtio-net-ccw");
> =20
>      /* Register savevm handler for guest TOD clock */
> -    register_savevm(NULL, "todclock", 0, 1,
> -                    gtod_save, gtod_load, kvm_state);
> +    register_savevm_live(NULL, "todclock", 0, 1, &savevm_gtod, kvm_state=
);
>  }
> =20
>  static void s390_cpu_plug(HotplugHandler *hotplug_dev,
> diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
> index f97411d..21aa6ca 100644
> --- a/include/migration/vmstate.h
> +++ b/include/migration/vmstate.h
> @@ -59,14 +59,6 @@ typedef struct SaveVMHandlers {
>      LoadStateHandler *load_state;
>  } SaveVMHandlers;
> =20
> -int register_savevm(DeviceState *dev,
> -                    const char *idstr,
> -                    int instance_id,
> -                    int version_id,
> -                    SaveStateHandler *save_state,
> -                    LoadStateHandler *load_state,
> -                    void *opaque);
> -
>  int register_savevm_live(DeviceState *dev,
>                           const char *idstr,
>                           int instance_id,
> diff --git a/migration/savevm.c b/migration/savevm.c
> index d971e5e..32badfc 100644
> --- a/migration/savevm.c
> +++ b/migration/savevm.c
> @@ -617,21 +617,6 @@ int register_savevm_live(DeviceState *dev,
>      return 0;
>  }
> =20
> -int register_savevm(DeviceState *dev,
> -                    const char *idstr,
> -                    int instance_id,
> -                    int version_id,
> -                    SaveStateHandler *save_state,
> -                    LoadStateHandler *load_state,
> -                    void *opaque)
> -{
> -    SaveVMHandlers *ops =3D g_new0(SaveVMHandlers, 1);
> -    ops->save_state =3D save_state;
> -    ops->load_state =3D load_state;
> -    return register_savevm_live(dev, idstr, instance_id, version_id,
> -                                ops, opaque);
> -}
> -
>  void unregister_savevm(DeviceState *dev, const char *idstr, void *opaque)
>  {
>      SaveStateEntry *se, *new_se;
> @@ -651,7 +636,6 @@ void unregister_savevm(DeviceState *dev, const char *=
idstr, void *opaque)
>          if (strcmp(se->idstr, id) =3D=3D 0 && se->opaque =3D=3D opaque) {
>              QTAILQ_REMOVE(&savevm_state.handlers, se, entry);
>              g_free(se->compat);
> -            g_free(se->ops);
>              g_free(se);
>          }
>      }
> diff --git a/slirp/slirp.c b/slirp/slirp.c
> index 2f2ec2c..11d169b 100644
> --- a/slirp/slirp.c
> +++ b/slirp/slirp.c
> @@ -272,6 +272,11 @@ static void slirp_init_once(void)
>  static void slirp_state_save(QEMUFile *f, void *opaque);
>  static int slirp_state_load(QEMUFile *f, void *opaque, int version_id);
> =20
> +static SaveVMHandlers savevm_slirp_state =3D {
> +    .save_state =3D slirp_state_save,
> +    .load_state =3D slirp_state_load,
> +};
> +
>  Slirp *slirp_init(int restricted, bool in_enabled, struct in_addr vnetwo=
rk,
>                    struct in_addr vnetmask, struct in_addr vhost,
>                    bool in6_enabled,
> @@ -321,8 +326,7 @@ Slirp *slirp_init(int restricted, bool in_enabled, st=
ruct in_addr vnetwork,
> =20
>      slirp->opaque =3D opaque;
> =20
> -    register_savevm(NULL, "slirp", 0, 4,
> -                    slirp_state_save, slirp_state_load, slirp);
> +    register_savevm_live(NULL, "slirp", 0, 4, &savevm_slirp_state, slirp=
);
> =20
>      QTAILQ_INSERT_TAIL(&slirp_instances, slirp, entry);
> =20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--32u276st3Jlj2kUU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZJiZGAAoJEGw4ysog2bOSBkgP/0TMsyX7kVwpz7TnRxKhlZV+
64rPNC4SqmDV3Fy/yag9/P+hsP2pl0vDI7vNYk91MdyotwwuXoYSQyOeGFf129YW
KNsLZCKVhfhDPR7a6JN0uUMu/xKs7JIdMHSrUXBkZvPRCH0ZV0oECzVLwqYwcUu0
wEcoWsfYPxZ/b8cWKE0n958hUJAREdCvLd3VZKHYDNMPTvCZ2Mtlyz5vxCUtnSyk
bOspIASXHM9rR+OiCKrFJXkL2e/FPepIZzSMw4A0IcyhL/Nkl41mfXOkYpIU85Ed
H6kGh44C+A2ZteOCaTDvxrxLpKun6kzyDWKsHBzHNKUQ14pO55CqFoAk+lZNU6YL
q8Mh7Wict2y005CVX4ujmkQ17NnxwOfopQkfIsUqWgymUBrVw09PE7LQvGQo6TVk
tZdBOZaBQF1dYmpPjPdCmegB/N916jybfxpiJTRai+TLIHjcGaJwYC9MRayAncYP
7aUok9I/yh3JVcBFpCZmiqqXePwo1twbRKtEC5T1eGipFK2Rm6d2WJaa0JqYUQLU
0Uob1Kh3LsvbR14OgCsEgHMod7Qo8IOeC1tMjuamhjzVcJgHmWNMCDUmECX0cymP
Zl4tSisklKM9npL/65GYkqOUYsfCG1QBb2fDQQXvq9GjbU9dCl3hSdxts2uuwmDA
SpUfEVxmj/fhKtKTDfzg
=l5zE
-----END PGP SIGNATURE-----

--32u276st3Jlj2kUU--
