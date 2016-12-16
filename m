Received: from eggs.gnu.org ([2001:4830:134:3::10]:43356)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1cHqT2-000066-Nr
	for qemu-devel@nongnu.org; Fri, 16 Dec 2016 06:14:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1cHqSx-00059D-Dt
	for qemu-devel@nongnu.org; Fri, 16 Dec 2016 06:14:24 -0500
Received: from 8.mo179.mail-out.ovh.net ([46.105.75.26]:34553)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1cHqSx-00057B-3u
	for qemu-devel@nongnu.org; Fri, 16 Dec 2016 06:14:19 -0500
Received: from player732.ha.ovh.net (b7.ovh.net [213.186.33.57])
	by mo179.mail-out.ovh.net (Postfix) with ESMTP id A73FAEAB7
	for <qemu-devel@nongnu.org>; Fri, 16 Dec 2016 12:14:16 +0100 (CET)
Date: Fri, 16 Dec 2016 12:14:00 +0100
From: Greg Kurz <groug@kaod.org>
Message-ID: <20161216121400.28e1cbc6@bahia.lan>
In-Reply-To: <1481882024-10016-5-git-send-email-ashijeetacharya@gmail.com>
References: <1481882024-10016-1-git-send-email-ashijeetacharya@gmail.com>
	<1481882024-10016-5-git-send-email-ashijeetacharya@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 4/4] migration: Fail migration blocker
 for --only-migratble
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ashijeet Acharya <ashijeetacharya@gmail.com>
Cc: dgilbert@redhat.com, jsnow@redhat.com, amit.shah@redhat.com, pbonzini@redhat.com, kwolf@redhat.com, armbru@redhat.com, quintela@redhat.com, mst@redhat.com, marcandre.lureau@redhat.com, aneesh.kumar@linux.vnet.ibm.com, peter.maydell@linaro.org, qemu-devel@nongnu.org

On Fri, 16 Dec 2016 15:23:44 +0530
Ashijeet Acharya <ashijeetacharya@gmail.com> wrote:

> migrate_add_blocker should rightly fail if the '--only-migratable'
> option was specified and the device in use should not be able to
> perform the action which results in an unmigratable VM.
>=20
> Make migrate_add_blocker return -EACCES in this case.
>=20
> Signed-off-by: Ashijeet Acharya <ashijeetacharya@gmail.com>
> ---
>  block/qcow.c                |  7 +++++--
>  block/vdi.c                 |  7 +++++--
>  block/vhdx.c                |  8 +++++---
>  block/vmdk.c                |  7 +++++--
>  block/vpc.c                 |  7 +++++--
>  block/vvfat.c               |  8 +++++---
>  hw/9pfs/9p.c                |  9 +++++++--
>  hw/display/virtio-gpu.c     |  9 +++++++--
>  hw/intc/arm_gic_kvm.c       |  7 +++++--
>  hw/intc/arm_gicv3_its_kvm.c |  5 ++++-
>  hw/intc/arm_gicv3_kvm.c     |  5 ++++-
>  hw/misc/ivshmem.c           | 10 ++++++++--
>  hw/scsi/vhost-scsi.c        | 10 ++++++----
>  hw/virtio/vhost.c           |  8 +++++---
>  migration/migration.c       |  7 +++++++
>  target-i386/kvm.c           |  7 +++++--
>  16 files changed, 88 insertions(+), 33 deletions(-)
>=20
> diff --git a/block/qcow.c b/block/qcow.c
> index 11526a1..7e5003ac 100644
> --- a/block/qcow.c
> +++ b/block/qcow.c
> @@ -253,8 +253,11 @@ static int qcow_open(BlockDriverState *bs, QDict *op=
tions, int flags,
>                 "does not support live migration",
>                 bdrv_get_device_or_node_name(bs));
>      ret =3D migrate_add_blocker(s->migration_blocker, errp);
> -    if (ret < 0) {
> -        error_free(s->migration_blocker);
> +    if (ret) {
> +        if (ret =3D=3D -EACCES) {
> +            error_append_hint(errp, "Cannot use a node with qcow format =
as "
> +                              "it does not support live migration");
> +        }
>          goto fail;
>      }
> =20
> diff --git a/block/vdi.c b/block/vdi.c
> index 2b56f52..df45df4 100644
> --- a/block/vdi.c
> +++ b/block/vdi.c
> @@ -472,8 +472,11 @@ static int vdi_open(BlockDriverState *bs, QDict *opt=
ions, int flags,
>                 "does not support live migration",
>                 bdrv_get_device_or_node_name(bs));
>      ret =3D migrate_add_blocker(s->migration_blocker, errp);
> -    if (ret < 0) {
> -        error_free(s->migration_blocker);
> +    if (ret) {
> +        if (ret =3D=3D -EACCES) {
> +            error_append_hint(errp, "Cannot use a node with vdi format a=
s "
> +                              "it does not support live migration");
> +        }
>          goto fail_free_bmap;
>      }
> =20
> diff --git a/block/vhdx.c b/block/vhdx.c
> index d81941b..118134e 100644
> --- a/block/vhdx.c
> +++ b/block/vhdx.c
> @@ -996,11 +996,13 @@ static int vhdx_open(BlockDriverState *bs, QDict *o=
ptions, int flags,
>                 "does not support live migration",
>                 bdrv_get_device_or_node_name(bs));
>      ret =3D migrate_add_blocker(s->migration_blocker, errp);
> -    if (ret < 0) {
> -        error_free(s->migration_blocker);
> +    if (ret) {
> +        if (ret =3D=3D -EACCES) {
> +            error_append_hint(errp, "Cannot use a node with vhdx format =
as "
> +                              "it does not support live migration");
> +        }
>          goto fail;
>      }
> -
>      if (flags & BDRV_O_RDWR) {
>          ret =3D vhdx_update_headers(bs, s, false, NULL);
>          if (ret < 0) {
> diff --git a/block/vmdk.c b/block/vmdk.c
> index 4a45a83..cd6a641 100644
> --- a/block/vmdk.c
> +++ b/block/vmdk.c
> @@ -977,8 +977,11 @@ static int vmdk_open(BlockDriverState *bs, QDict *op=
tions, int flags,
>                 "does not support live migration",
>                 bdrv_get_device_or_node_name(bs));
>      ret =3D migrate_add_blocker(s->migration_blocker, errp);
> -    if (ret < 0) {
> -        error_free(s->migration_blocker);
> +    if (ret) {
> +        if (ret =3D=3D -EACCES) {
> +            error_append_hint(errp, "Cannot use a node with vmdk format =
as "
> +                              "it does not support live migration");
> +        }
>          goto fail;
>      }
> =20
> diff --git a/block/vpc.c b/block/vpc.c
> index 299a8c8..c935962 100644
> --- a/block/vpc.c
> +++ b/block/vpc.c
> @@ -427,8 +427,11 @@ static int vpc_open(BlockDriverState *bs, QDict *opt=
ions, int flags,
>                 "does not support live migration",
>                 bdrv_get_device_or_node_name(bs));
>      ret =3D migrate_add_blocker(s->migration_blocker, errp);
> -    if (ret < 0) {
> -        error_free(s->migration_blocker);
> +    if (ret) {
> +        if (ret =3D=3D -EACCES) {
> +            error_append_hint(errp, "Cannot use a node with vpc format a=
s "
> +                              "it does not support live migration");
> +        }
>          goto fail;
>      }
> =20
> diff --git a/block/vvfat.c b/block/vvfat.c
> index 3de3320..f9a5f9b 100644
> --- a/block/vvfat.c
> +++ b/block/vvfat.c
> @@ -1192,8 +1192,11 @@ static int vvfat_open(BlockDriverState *bs, QDict =
*options, int flags,
>                     "does not support live migration",
>                     bdrv_get_device_or_node_name(bs));
>          ret =3D migrate_add_blocker(s->migration_blocker, errp);
> -        if (ret < 0) {
> -            error_free(s->migration_blocker);
> +        if (ret) {
> +            if (ret =3D=3D -EACCES) {
> +                error_append_hint(errp, "Cannot use a node with vvfat fo=
rmat "
> +                                  "as it does not support live migration=
");
> +            }
>              goto fail;
>          }
>      }
> @@ -1202,7 +1205,6 @@ static int vvfat_open(BlockDriverState *bs, QDict *=
options, int flags,
>          init_mbr(s, cyls, heads, secs);
>      }
> =20
> -    //    assert(is_consistent(s));
>      qemu_co_mutex_init(&s->lock);
> =20
>      ret =3D 0;
> diff --git a/hw/9pfs/9p.c b/hw/9pfs/9p.c
> index e72ef43..01dd67f 100644
> --- a/hw/9pfs/9p.c
> +++ b/hw/9pfs/9p.c
> @@ -1020,12 +1020,17 @@ static void coroutine_fn v9fs_attach(void *opaque)
>       */
>      if (!s->migration_blocker) {
>          int ret;
> +        Error *local_err;
>          s->root_fid =3D fid;
>          error_setg(&s->migration_blocker,
>                     "Migration is disabled when VirtFS export path '%s' i=
s mounted in the guest using mount_tag '%s'",
>                     s->ctx.fs_root ? s->ctx.fs_root : "NULL", s->tag);
> -        ret =3D migrate_add_blocker(s->migration_blocker, NULL);
> -        if (ret < 0) {
> +        ret =3D migrate_add_blocker(s->migration_blocker, &local_err);
> +        if (ret) {

Why s/ret < 0/ret/ ? The migrate_add_blocker() function in this v2 only
returns 0 or a negative errno...

> +            if (ret =3D=3D -EACCES) {
> +                error_append_hint(&local_err, "Failed to mount VirtFS as=
 it "
> +                                  "does not support live migration");

And then local_err is leaked...

BTW, I'm not even sure if this useful since this is a guest originated acti=
on.

> +            }

This errno will be ultimately be returned to the mount(2) caller in the gue=
st.

When reading the manpage, it looks like EBUSY definitely makes more sense t=
han
EACCES:

       EACCES A component of a path was not searchable.  (See also  path_re=
so=E2=80=90
              lution(7).)   Or,  mounting a read-only filesystem was attemp=
ted
              without giving the MS_RDONLY flag.  Or, the block device  sou=
rce
              is located on a filesystem mounted with the MS_NODEV option.

       EBUSY  source  is  already  mounted.   Or, it cannot be remounted re=
ad-
              only, because it still holds files open  for  writing.   Or, =
 it
              cannot  be mounted on target because target is still busy (it=
 is
              the working directory of some thread, the mount point of anot=
her
              device, has open files, etc.).

>              err =3D ret;
>              clunk_fid(s, fid);
>              goto out;
> diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
> index 6e60b8c..1b02f4b 100644
> --- a/hw/display/virtio-gpu.c
> +++ b/hw/display/virtio-gpu.c
> @@ -1102,6 +1102,7 @@ static void virtio_gpu_device_realize(DeviceState *=
qdev, Error **errp)
>      VirtIOGPU *g =3D VIRTIO_GPU(qdev);
>      bool have_virgl;
>      int i;
> +    int ret;
> =20
>      if (g->conf.max_outputs > VIRTIO_GPU_MAX_SCANOUTS) {
>          error_setg(errp, "invalid max_outputs > %d", VIRTIO_GPU_MAX_SCAN=
OUTS);
> @@ -1120,8 +1121,12 @@ static void virtio_gpu_device_realize(DeviceState =
*qdev, Error **errp)
> =20
>      if (virtio_gpu_virgl_enabled(g->conf)) {
>          error_setg(&g->migration_blocker, "virgl is not yet migratable");
> -        if (migrate_add_blocker(g->migration_blocker, errp) < 0) {
> -            error_free(g->migration_blocker);
> +        ret =3D migrate_add_blocker(g->migration_blocker, errp);
> +        if (ret) {
> +            if (ret =3D=3D -EACCES) {
> +                error_append_hint(errp, "Cannot use virgl as it does not=
 "
> +                                  "support live migration yet");
> +            }
>              return;
>          }
>      }
> diff --git a/hw/intc/arm_gic_kvm.c b/hw/intc/arm_gic_kvm.c
> index 3614daa..b40ad5f 100644
> --- a/hw/intc/arm_gic_kvm.c
> +++ b/hw/intc/arm_gic_kvm.c
> @@ -514,8 +514,11 @@ static void kvm_arm_gic_realize(DeviceState *dev, Er=
ror **errp)
>          error_setg(&s->migration_blocker, "This operating system kernel =
does "
>                                            "not support vGICv2 migration"=
);
>          ret =3D migrate_add_blocker(s->migration_blocker, errp);
> -        if (ret < 0) {
> -            error_free(s->migration_blocker);
> +        if (ret) {
> +            if (ret =3D=3D -EACCES) {
> +                error_append_hint(errp, "Failed to realize vGICv2 as its"
> +                                  " migrataion is not implemented yet");
> +            }
>              return;
>          }
>      }
> diff --git a/hw/intc/arm_gicv3_its_kvm.c b/hw/intc/arm_gicv3_its_kvm.c
> index 950a02f..3474642 100644
> --- a/hw/intc/arm_gicv3_its_kvm.c
> +++ b/hw/intc/arm_gicv3_its_kvm.c
> @@ -70,7 +70,10 @@ static void kvm_arm_its_realize(DeviceState *dev, Erro=
r **errp)
>      error_setg(&s->migration_blocker, "vITS migration is not implemented=
");
>      ret =3D migrate_add_blocker(s->migration_blocker, errp);
>      if (ret < 0) {
> -        error_free(s->migration_blocker);
> +        if (ret =3D=3D -EACCES) {
> +            error_append_hint(errp, "Failed to realize vITS as its migra=
tion "
> +                              "is not implemented yet");
> +        }
>          return;
>      }
> =20
> diff --git a/hw/intc/arm_gicv3_kvm.c b/hw/intc/arm_gicv3_kvm.c
> index 06f6f30..be7b97c 100644
> --- a/hw/intc/arm_gicv3_kvm.c
> +++ b/hw/intc/arm_gicv3_kvm.c
> @@ -118,7 +118,10 @@ static void kvm_arm_gicv3_realize(DeviceState *dev, =
Error **errp)
>      error_setg(&s->migration_blocker, "vGICv3 migration is not implement=
ed");
>      ret =3D migrate_add_blocker(s->migration_blocker, errp);
>      if (ret < 0) {
> -        error_free(s->migration_blocker);
> +        if (ret =3D=3D -EACCES) {
> +            error_append_hint(errp, "Failed to realize vGICv3 as its mig=
ration"
> +                              "is not implemented yet");
> +        }
>          return;
>      }
> =20
> diff --git a/hw/misc/ivshmem.c b/hw/misc/ivshmem.c
> index 585cc5b..58f27b1 100644
> --- a/hw/misc/ivshmem.c
> +++ b/hw/misc/ivshmem.c
> @@ -837,6 +837,7 @@ static void ivshmem_common_realize(PCIDevice *dev, Er=
ror **errp)
>  {
>      IVShmemState *s =3D IVSHMEM_COMMON(dev);
>      Error *err =3D NULL;
> +    int ret;
>      uint8_t *pci_conf;
>      uint8_t attr =3D PCI_BASE_ADDRESS_SPACE_MEMORY |
>          PCI_BASE_ADDRESS_MEM_PREFETCH;
> @@ -910,8 +911,13 @@ static void ivshmem_common_realize(PCIDevice *dev, E=
rror **errp)
>      if (!ivshmem_is_master(s)) {
>          error_setg(&s->migration_blocker,
>                     "Migration is disabled when using feature 'peer mode'=
 in device 'ivshmem'");
> -        if (migrate_add_blocker(s->migration_blocker, errp) < 0) {
> -            error_free(s->migration_blocker);
> +        ret =3D migrate_add_blocker(s->migration_blocker, errp);
> +        if (ret) {
> +            if (ret =3D=3D -EACCES) {
> +                error_append_hint(errp, "Cannot use the 'peer mode' feat=
ure "
> +                                  "in device 'ivshmem' as it does not "
> +                                  "support live migration");
> +            }
>              return;
>          }
>      }
> diff --git a/hw/scsi/vhost-scsi.c b/hw/scsi/vhost-scsi.c
> index ff503d0..0c571f8 100644
> --- a/hw/scsi/vhost-scsi.c
> +++ b/hw/scsi/vhost-scsi.c
> @@ -244,8 +244,12 @@ static void vhost_scsi_realize(DeviceState *dev, Err=
or **errp)
>      error_setg(&s->migration_blocker,
>                 "vhost-scsi does not support migration");
>      ret =3D migrate_add_blocker(s->migration_blocker, errp);
> -    if (ret < 0) {
> -        goto free_blocker;
> +    if (ret) {
> +        if (ret =3D=3D -EACCES) {
> +            error_append_hint(errp, "Cannot use vhost-scsi as it does no=
t "
> +                              "support live migration");
> +        }
> +        goto close_fd;
>      }
> =20
>      s->dev.nvqs =3D VHOST_SCSI_VQ_NUM_FIXED + vs->conf.num_queues;
> @@ -272,8 +276,6 @@ static void vhost_scsi_realize(DeviceState *dev, Erro=
r **errp)
>   free_vqs:
>      migrate_del_blocker(s->migration_blocker);
>      g_free(s->dev.vqs);
> - free_blocker:
> -    error_free(s->migration_blocker);
>   close_fd:
>      close(vhostfd);
>      return;
> diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
> index 416fada..1c4a4f9 100644
> --- a/hw/virtio/vhost.c
> +++ b/hw/virtio/vhost.c
> @@ -1159,9 +1159,11 @@ int vhost_dev_init(struct vhost_dev *hdev, void *o=
paque,
>      if (hdev->migration_blocker !=3D NULL) {
>          Error *local_err;
>          r =3D migrate_add_blocker(hdev->migration_blocker, &local_err);
> -        if (r < 0) {
> -            error_report_err(local_err);
> -            error_free(hdev->migration_blocker);
> +        if (r) {
> +            if (r =3D=3D -EACCES) {
> +                error_append_hint(&local_err, "Cannot use vhost drivers =
as "
> +                                  "it does not support live migration");
> +            }
>              goto fail_busyloop;
>          }
>      }
> diff --git a/migration/migration.c b/migration/migration.c
> index 713e012..ab34328 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -1115,9 +1115,16 @@ int migrate_add_blocker(Error *reason, Error **err=
p)
>  {
>      if (migration_is_idle(NULL)) {
>          migration_blockers =3D g_slist_prepend(migration_blockers, reaso=
n);
> +        error_free(reason);
>          return 0;
>      }
> =20
> +    if (only_migratable) {
> +        error_setg(errp, "Failed to add migration blocker: --only-migrat=
able "
> +                   "was specified");
> +        return -EACCES;
> +    }
> +
>      error_setg(errp, "Cannot block a migration already in-progress");
>      return -EBUSY;
>  }
> diff --git a/target-i386/kvm.c b/target-i386/kvm.c
> index 6031a1c..05c8365 100644
> --- a/target-i386/kvm.c
> +++ b/target-i386/kvm.c
> @@ -962,7 +962,11 @@ int kvm_arch_init_vcpu(CPUState *cs)
>                     "State blocked by non-migratable CPU device"
>                     " (invtsc flag)");
>          r =3D migrate_add_blocker(invtsc_mig_blocker, NULL);
> -        if (r < 0) {
> +        if (r) {
> +            if (r =3D=3D -EACCES) {
> +                error_report("kvm: non-migratable CPU device but"
> +                        " --only-migratable was specified");
> +            }
>              error_report("kvm: migrate_add_blocker failed");
>              goto efail;
>          }
> @@ -1009,7 +1013,6 @@ int kvm_arch_init_vcpu(CPUState *cs)
>   fail:
>      migrate_del_blocker(invtsc_mig_blocker);
>   efail:
> -    error_free(invtsc_mig_blocker);
>      return r;
>  }
> =20
