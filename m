Received: from eggs.gnu.org ([2001:4830:134:3::10]:45263)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dmitry@daynix.com>) id 1dDXD4-00086Y-62
	for qemu-devel@nongnu.org; Wed, 24 May 2017 10:24:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dmitry@daynix.com>) id 1dDXCz-0008Mc-4i
	for qemu-devel@nongnu.org; Wed, 24 May 2017 10:24:22 -0400
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:33523)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <dmitry@daynix.com>) id 1dDXCy-0008LB-Og
	for qemu-devel@nongnu.org; Wed, 24 May 2017 10:24:17 -0400
Received: by mail-wm0-x242.google.com with SMTP id b84so31830120wmh.0
	for <qemu-devel@nongnu.org>; Wed, 24 May 2017 07:24:16 -0700 (PDT)
From: Dmitry Fleytman <dmitry@daynix.com>
Message-Id: <13E972E6-E798-4B32-818E-1EAB4BFD4405@daynix.com>
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Date: Wed, 24 May 2017 17:24:11 +0300
In-Reply-To: <20170524121048.10067-1-lvivier@redhat.com>
References: <20170524121048.10067-1-lvivier@redhat.com>
Content-Type: text/plain;
	charset=utf-8
Content-Transfer-Encoding: quoted-printable
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
Cc: Juan Quintela <quintela@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, rnsastry@linux.vnet.ibm.com, Bharata B Rao <bharata@linux.vnet.ibm.com>, Qemu Developers <qemu-devel@nongnu.org>, Richard Henderson <rth@twiddle.net>, Jason Wang <jasowang@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Cornelia Huck <cornelia.huck@de.ibm.com>, qemu-ppc@nongnu.org, Samuel Thibault <samuel.thibault@ens-lyon.org>, sam.bobroff@au1.ibm.com, Peter Xu <peterx@redhat.com>


> On 24 May 2017, at 15:10 PM, Laurent Vivier <lvivier@redhat.com> =
wrote:
>=20
> We can replace the four remaining calls of register_savevm() by
> calls to register_savevm_live(). So we can remove the function and
> as we don't allocate anymore the ops pointer with g_new0()
> we don't have to free it then.
>=20
> Signed-off-by: Laurent Vivier <lvivier@redhat.com>
> ---
> hw/net/vmxnet3.c            |  8 ++++++=E2=80=94


Acked-by: Dmitry Fleytman <dmitry@daynix.com <mailto:dmitry@daynix.com>>

> hw/s390x/s390-skeys.c       |  9 +++++++--
> hw/s390x/s390-virtio-ccw.c  |  8 ++++++--
> include/migration/vmstate.h |  8 --------
> migration/savevm.c          | 16 ----------------
> slirp/slirp.c               |  8 ++++++--
> 6 files changed, 25 insertions(+), 32 deletions(-)
>=20
> diff --git a/hw/net/vmxnet3.c b/hw/net/vmxnet3.c
> index 8b1fab2..4df3110 100644
> --- a/hw/net/vmxnet3.c
> +++ b/hw/net/vmxnet3.c
> @@ -2262,6 +2262,11 @@ static const MemoryRegionOps b1_ops =3D {
>     },
> };
>=20
> +static SaveVMHandlers savevm_vmxnet3_msix =3D {
> +    .save_state =3D vmxnet3_msix_save,
> +    .load_state =3D vmxnet3_msix_load,
> +};
> +
> static uint64_t vmxnet3_device_serial_num(VMXNET3State *s)
> {
>     uint64_t dsn_payload;
> @@ -2331,8 +2336,7 @@ static void vmxnet3_pci_realize(PCIDevice =
*pci_dev, Error **errp)
>                               vmxnet3_device_serial_num(s));
>     }
>=20
> -    register_savevm(dev, "vmxnet3-msix", -1, 1,
> -                    vmxnet3_msix_save, vmxnet3_msix_load, s);
> +    register_savevm_live(dev, "vmxnet3-msix", -1, 1, =
&savevm_vmxnet3_msix, s);
> }
>=20
> static void vmxnet3_instance_init(Object *obj)
> diff --git a/hw/s390x/s390-skeys.c b/hw/s390x/s390-skeys.c
> index e2d4e1a..a3dc088 100644
> --- a/hw/s390x/s390-skeys.c
> +++ b/hw/s390x/s390-skeys.c
> @@ -363,6 +363,11 @@ static inline bool =
s390_skeys_get_migration_enabled(Object *obj, Error **errp)
>     return ss->migration_enabled;
> }
>=20
> +static SaveVMHandlers savevm_s390_storage_keys =3D {
> +    .save_state =3D s390_storage_keys_save,
> +    .load_state =3D s390_storage_keys_load,
> +};
> +
> static inline void s390_skeys_set_migration_enabled(Object *obj, bool =
value,
>                                             Error **errp)
> {
> @@ -376,8 +381,8 @@ static inline void =
s390_skeys_set_migration_enabled(Object *obj, bool value,
>     ss->migration_enabled =3D value;
>=20
>     if (ss->migration_enabled) {
> -        register_savevm(NULL, TYPE_S390_SKEYS, 0, 1, =
s390_storage_keys_save,
> -                        s390_storage_keys_load, ss);
> +        register_savevm_live(NULL, TYPE_S390_SKEYS, 0, 1,
> +                             &savevm_s390_storage_keys, ss);
>     } else {
>         unregister_savevm(DEVICE(ss), TYPE_S390_SKEYS, ss);
>     }
> diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
> index fdd4384..697a2d6 100644
> --- a/hw/s390x/s390-virtio-ccw.c
> +++ b/hw/s390x/s390-virtio-ccw.c
> @@ -104,6 +104,11 @@ void s390_memory_init(ram_addr_t mem_size)
>     s390_skeys_init();
> }
>=20
> +static SaveVMHandlers savevm_gtod =3D {
> +    .save_state =3D gtod_save,
> +    .load_state =3D gtod_load,
> +};
> +
> static void ccw_init(MachineState *machine)
> {
>     int ret;
> @@ -146,8 +151,7 @@ static void ccw_init(MachineState *machine)
>     s390_create_virtio_net(BUS(css_bus), "virtio-net-ccw");
>=20
>     /* Register savevm handler for guest TOD clock */
> -    register_savevm(NULL, "todclock", 0, 1,
> -                    gtod_save, gtod_load, kvm_state);
> +    register_savevm_live(NULL, "todclock", 0, 1, &savevm_gtod, =
kvm_state);
> }
>=20
> static void s390_cpu_plug(HotplugHandler *hotplug_dev,
> diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
> index f97411d..21aa6ca 100644
> --- a/include/migration/vmstate.h
> +++ b/include/migration/vmstate.h
> @@ -59,14 +59,6 @@ typedef struct SaveVMHandlers {
>     LoadStateHandler *load_state;
> } SaveVMHandlers;
>=20
> -int register_savevm(DeviceState *dev,
> -                    const char *idstr,
> -                    int instance_id,
> -                    int version_id,
> -                    SaveStateHandler *save_state,
> -                    LoadStateHandler *load_state,
> -                    void *opaque);
> -
> int register_savevm_live(DeviceState *dev,
>                          const char *idstr,
>                          int instance_id,
> diff --git a/migration/savevm.c b/migration/savevm.c
> index d971e5e..32badfc 100644
> --- a/migration/savevm.c
> +++ b/migration/savevm.c
> @@ -617,21 +617,6 @@ int register_savevm_live(DeviceState *dev,
>     return 0;
> }
>=20
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
> void unregister_savevm(DeviceState *dev, const char *idstr, void =
*opaque)
> {
>     SaveStateEntry *se, *new_se;
> @@ -651,7 +636,6 @@ void unregister_savevm(DeviceState *dev, const =
char *idstr, void *opaque)
>         if (strcmp(se->idstr, id) =3D=3D 0 && se->opaque =3D=3D =
opaque) {
>             QTAILQ_REMOVE(&savevm_state.handlers, se, entry);
>             g_free(se->compat);
> -            g_free(se->ops);
>             g_free(se);
>         }
>     }
> diff --git a/slirp/slirp.c b/slirp/slirp.c
> index 2f2ec2c..11d169b 100644
> --- a/slirp/slirp.c
> +++ b/slirp/slirp.c
> @@ -272,6 +272,11 @@ static void slirp_init_once(void)
> static void slirp_state_save(QEMUFile *f, void *opaque);
> static int slirp_state_load(QEMUFile *f, void *opaque, int =
version_id);
>=20
> +static SaveVMHandlers savevm_slirp_state =3D {
> +    .save_state =3D slirp_state_save,
> +    .load_state =3D slirp_state_load,
> +};
> +
> Slirp *slirp_init(int restricted, bool in_enabled, struct in_addr =
vnetwork,
>                   struct in_addr vnetmask, struct in_addr vhost,
>                   bool in6_enabled,
> @@ -321,8 +326,7 @@ Slirp *slirp_init(int restricted, bool in_enabled, =
struct in_addr vnetwork,
>=20
>     slirp->opaque =3D opaque;
>=20
> -    register_savevm(NULL, "slirp", 0, 4,
> -                    slirp_state_save, slirp_state_load, slirp);
> +    register_savevm_live(NULL, "slirp", 0, 4, &savevm_slirp_state, =
slirp);
>=20
>     QTAILQ_INSERT_TAIL(&slirp_instances, slirp, entry);
>=20
> --=20
> 2.9.4
>=20
