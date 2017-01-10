Received: from eggs.gnu.org ([2001:4830:134:3::10]:50650)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cQvGs-00044i-OU
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 07:11:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cQvGp-0005LG-IH
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 07:11:22 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60878)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1cQvGp-0005Ko-9D
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 07:11:19 -0500
Date: Tue, 10 Jan 2017 12:11:13 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170110121112.GG2423@work-vm>
References: <1483981368-9965-1-git-send-email-ashijeetacharya@gmail.com>
	<1483981368-9965-5-git-send-email-ashijeetacharya@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1483981368-9965-5-git-send-email-ashijeetacharya@gmail.com>
Subject: Re: [Qemu-devel] [PATCH v4 4/4] migration: Fail migration blocker
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
Cc: jsnow@redhat.com, amit.shah@redhat.com, pbonzini@redhat.com, kwolf@redhat.com, armbru@redhat.com, quintela@redhat.com, mst@redhat.com, marcandre.lureau@redhat.com, groug@kaod.org, aneesh.kumar@linux.vnet.ibm.com, peter.maydell@linaro.org, qemu-devel@nongnu.org

* Ashijeet Acharya (ashijeetacharya@gmail.com) wrote:
> migrate_add_blocker should rightly fail if the '--only-migratable'
> option was specified and the device in use should not be able to
> perform the action which results in an unmigratable VM.
>=20
> Make migrate_add_blocker return -EACCES in this case.
>=20
> Signed-off-by: Ashijeet Acharya <ashijeetacharya@gmail.com>
> ---
>  block/qcow.c                |  5 ++++-
>  block/vdi.c                 |  5 ++++-
>  block/vhdx.c                |  6 ++++--
>  block/vmdk.c                |  5 ++++-
>  block/vpc.c                 |  5 ++++-
>  block/vvfat.c               |  6 ++++--
>  hw/display/virtio-gpu.c     |  9 +++++++--
>  hw/intc/arm_gic_kvm.c       |  7 +++++--
>  hw/intc/arm_gicv3_its_kvm.c |  5 ++++-
>  hw/intc/arm_gicv3_kvm.c     |  5 ++++-
>  hw/misc/ivshmem.c           | 10 ++++++++--
>  hw/scsi/vhost-scsi.c        |  8 +++++---
>  hw/virtio/vhost.c           |  6 ++++--
>  migration/migration.c       |  7 +++++++
>  target-i386/kvm.c           |  5 ++++-
>  15 files changed, 72 insertions(+), 22 deletions(-)
>=20
> diff --git a/block/qcow.c b/block/qcow.c
> index 11526a1..bdc6446 100644
> --- a/block/qcow.c
> +++ b/block/qcow.c
> @@ -254,7 +254,10 @@ static int qcow_open(BlockDriverState *bs, QDict *op=
tions, int flags,
>                 bdrv_get_device_or_node_name(bs));
>      ret =3D migrate_add_blocker(s->migration_blocker, errp);
>      if (ret < 0) {
> -        error_free(s->migration_blocker);
> +        if (ret =3D=3D -EACCES) {
> +            error_append_hint(errp, "Cannot use a node with qcow format =
as "
> +                              "it does not support live migration");
> +        }
>          goto fail;
>      }
> =20
> diff --git a/block/vdi.c b/block/vdi.c
> index 2b56f52..0b011ea 100644
> --- a/block/vdi.c
> +++ b/block/vdi.c
> @@ -473,7 +473,10 @@ static int vdi_open(BlockDriverState *bs, QDict *opt=
ions, int flags,
>                 bdrv_get_device_or_node_name(bs));
>      ret =3D migrate_add_blocker(s->migration_blocker, errp);
>      if (ret < 0) {
> -        error_free(s->migration_blocker);
> +        if (ret =3D=3D -EACCES) {
> +            error_append_hint(errp, "Cannot use a node with vdi format a=
s "
> +                              "it does not support live migration");
> +        }
>          goto fail_free_bmap;
>      }
> =20
> diff --git a/block/vhdx.c b/block/vhdx.c
> index d81941b..b8d53ec 100644
> --- a/block/vhdx.c
> +++ b/block/vhdx.c
> @@ -997,10 +997,12 @@ static int vhdx_open(BlockDriverState *bs, QDict *o=
ptions, int flags,
>                 bdrv_get_device_or_node_name(bs));
>      ret =3D migrate_add_blocker(s->migration_blocker, errp);
>      if (ret < 0) {
> -        error_free(s->migration_blocker);
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
> index 4a45a83..defe400 100644
> --- a/block/vmdk.c
> +++ b/block/vmdk.c
> @@ -978,7 +978,10 @@ static int vmdk_open(BlockDriverState *bs, QDict *op=
tions, int flags,
>                 bdrv_get_device_or_node_name(bs));
>      ret =3D migrate_add_blocker(s->migration_blocker, errp);
>      if (ret < 0) {
> -        error_free(s->migration_blocker);
> +        if (ret =3D=3D -EACCES) {
> +            error_append_hint(errp, "Cannot use a node with vmdk format =
as "
> +                              "it does not support live migration");
> +        }
>          goto fail;
>      }
> =20
> diff --git a/block/vpc.c b/block/vpc.c
> index 299a8c8..5e58d77 100644
> --- a/block/vpc.c
> +++ b/block/vpc.c
> @@ -428,7 +428,10 @@ static int vpc_open(BlockDriverState *bs, QDict *opt=
ions, int flags,
>                 bdrv_get_device_or_node_name(bs));
>      ret =3D migrate_add_blocker(s->migration_blocker, errp);
>      if (ret < 0) {
> -        error_free(s->migration_blocker);
> +        if (ret =3D=3D -EACCES) {
> +            error_append_hint(errp, "Cannot use a node with vpc format a=
s "
> +                              "it does not support live migration");
> +        }
>          goto fail;
>      }
> =20
> diff --git a/block/vvfat.c b/block/vvfat.c
> index 3de3320..5a6e038 100644
> --- a/block/vvfat.c
> +++ b/block/vvfat.c
> @@ -1193,7 +1193,10 @@ static int vvfat_open(BlockDriverState *bs, QDict =
*options, int flags,
>                     bdrv_get_device_or_node_name(bs));
>          ret =3D migrate_add_blocker(s->migration_blocker, errp);
>          if (ret < 0) {
> -            error_free(s->migration_blocker);
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
> diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
> index 6e60b8c..fad95bf 100644
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
> +        if (ret < 0) {
> +            if (ret =3D=3D -EACCES) {
> +                error_append_hint(errp, "Cannot use virgl as it does not=
 "
> +                                  "support live migration yet");
> +            }
>              return;
>          }
>      }
> diff --git a/hw/intc/arm_gic_kvm.c b/hw/intc/arm_gic_kvm.c
> index 3614daa..2097808 100644
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
> +        if (ret < 0 ) {
> +            if (ret =3D=3D -EACCES) {
> +                error_append_hint(errp, "Failed to realize vGICv2 as its"
> +                                  " migrataion is not implemented yet");
 Typo of migrataion.
Also is that message right? I think that should mention the OS kernel.

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
> index 585cc5b..14ed60d 100644
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
> +        if (ret < 0) {
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
> index ff503d0..bb731b2 100644
> --- a/hw/scsi/vhost-scsi.c
> +++ b/hw/scsi/vhost-scsi.c
> @@ -245,7 +245,11 @@ static void vhost_scsi_realize(DeviceState *dev, Err=
or **errp)
>                 "vhost-scsi does not support migration");
>      ret =3D migrate_add_blocker(s->migration_blocker, errp);
>      if (ret < 0) {
> -        goto free_blocker;
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
> index 416fada..6d2375a 100644
> --- a/hw/virtio/vhost.c
> +++ b/hw/virtio/vhost.c
> @@ -1160,8 +1160,10 @@ int vhost_dev_init(struct vhost_dev *hdev, void *o=
paque,
>          Error *local_err;
>          r =3D migrate_add_blocker(hdev->migration_blocker, &local_err);
>          if (r < 0) {
> -            error_report_err(local_err);
> -            error_free(hdev->migration_blocker);
> +            if (r =3D=3D -EACCES) {
> +                error_append_hint(&local_err, "Cannot use vhost drivers =
as "
> +                                  "it does not support live migration");

In this case there are 2 different reasons that it might be disabled;
we've lost that text.  It seems best in this case to use the message
=66rom hdev->migration_blocker.

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

That free doesn't look right there; isn't that freeing the reason that is a=
dded
to the list and will get used later if someone tries to start a migration?

Dave

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
> index 6031a1c..f2c35d8 100644
> --- a/target-i386/kvm.c
> +++ b/target-i386/kvm.c
> @@ -963,6 +963,10 @@ int kvm_arch_init_vcpu(CPUState *cs)
>                     " (invtsc flag)");
>          r =3D migrate_add_blocker(invtsc_mig_blocker, NULL);
>          if (r < 0) {
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
> --=20
> 2.6.2
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
