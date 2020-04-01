Return-Path: <SRS0=uFRu=5R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2DD3C43331
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2020 11:28:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE5FD2080C
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2020 11:28:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bEu8Egas"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE5FD2080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58182 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJbXg-0005r1-U1
	for qemu-devel@archiver.kernel.org; Wed, 01 Apr 2020 07:28:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34686)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1jJbX2-0005CH-4F
 for qemu-devel@nongnu.org; Wed, 01 Apr 2020 07:27:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1jJbX0-0003wm-BD
 for qemu-devel@nongnu.org; Wed, 01 Apr 2020 07:27:39 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:23661
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1jJbX0-0003u2-7C
 for qemu-devel@nongnu.org; Wed, 01 Apr 2020 07:27:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585740457;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pq6h1+4+GpkaDA7KikqWvCTREKEM3v8XKTYxepESK0k=;
 b=bEu8Egas+pljkR0lumdXgQASf8E4dfHbuwlCZ8432a44SwiDDuaOoyRe1PzryGcIyBfmS5
 s50eb6eq6KLgtHBwZBeQBZj33+M+4RZcTtHf3rwWBkuYuMTSC6bFzbTEBQ5y2qMMEGy8t8
 jfRZSCCyhbMaFjhyrft/rCjmV6LDoRQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-456-1Lc62O8iPBiJIZ8r3P2ilg-1; Wed, 01 Apr 2020 07:27:33 -0400
X-MC-Unique: 1Lc62O8iPBiJIZ8r3P2ilg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7846B800D4E;
 Wed,  1 Apr 2020 11:27:30 +0000 (UTC)
Received: from work-vm (ovpn-115-22.ams2.redhat.com [10.36.115.22])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2F63519C6A;
 Wed,  1 Apr 2020 11:27:23 +0000 (UTC)
Date: Wed, 1 Apr 2020 12:27:20 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Kirti Wankhede <kwankhede@nvidia.com>
Subject: Re: [PATCH v16 QEMU 07/16] vfio: Add migration state change notifier
Message-ID: <20200401112720.GB3258@work-vm>
References: <1585084154-29461-1-git-send-email-kwankhede@nvidia.com>
 <1585084154-29461-8-git-send-email-kwankhede@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <1585084154-29461-8-git-send-email-kwankhede@nvidia.com>
User-Agent: Mutt/1.13.3 (2020-01-12)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Zhengxiao.zx@alibaba-inc.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 cjia@nvidia.com, eskultet@redhat.com, ziye.yang@intel.com, cohuck@redhat.com,
 shuangtai.tst@alibaba-inc.com, qemu-devel@nongnu.org, zhi.a.wang@intel.com,
 mlevitsk@redhat.com, pasic@linux.ibm.com, aik@ozlabs.ru,
 alex.williamson@redhat.com, eauger@redhat.com, felipe@nutanix.com,
 jonathan.davies@nutanix.com, yan.y.zhao@intel.com, changpeng.liu@intel.com,
 Ken.Xue@amd.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Kirti Wankhede (kwankhede@nvidia.com) wrote:
> Added migration state change notifier to get notification on migration st=
ate
> change. These states are translated to VFIO device state and conveyed to =
vendor
> driver.
>=20
> Signed-off-by: Kirti Wankhede <kwankhede@nvidia.com>
> Reviewed-by: Neo Jia <cjia@nvidia.com>
> ---
>  hw/vfio/migration.c           | 29 +++++++++++++++++++++++++++++
>  hw/vfio/trace-events          |  1 +
>  include/hw/vfio/vfio-common.h |  1 +
>  3 files changed, 31 insertions(+)
>=20
> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
> index af9443c275fb..22ded9d28cf3 100644
> --- a/hw/vfio/migration.c
> +++ b/hw/vfio/migration.c
> @@ -154,6 +154,27 @@ static void vfio_vmstate_change(void *opaque, int ru=
nning, RunState state)
>      }
>  }
> =20
> +static void vfio_migration_state_notifier(Notifier *notifier, void *data=
)
> +{
> +    MigrationState *s =3D data;
> +    VFIODevice *vbasedev =3D container_of(notifier, VFIODevice, migratio=
n_state);
> +    int ret;
> +
> +    trace_vfio_migration_state_notifier(vbasedev->name, s->state);

You might want to use MigrationStatus_str(s->status) to make that
readable.

> +    switch (s->state) {
> +    case MIGRATION_STATUS_CANCELLING:
> +    case MIGRATION_STATUS_CANCELLED:
> +    case MIGRATION_STATUS_FAILED:
> +        ret =3D vfio_migration_set_state(vbasedev,
> +                      ~(VFIO_DEVICE_STATE_SAVING | VFIO_DEVICE_STATE_RES=
UMING),
> +                      VFIO_DEVICE_STATE_RUNNING);
> +        if (ret) {
> +            error_report("%s: Failed to set state RUNNING", vbasedev->na=
me);
> +        }

In the migration code we check to see if the VM was running prior to the
start of the migration before we start the CPUs going again (see
migration_iteration_finish):
    case MIGRATION_STATUS_FAILED:
    case MIGRATION_STATUS_CANCELLED:
    case MIGRATION_STATUS_CANCELLING:
        if (s->vm_was_running) {
            vm_start();
        } else {
            if (runstate_check(RUN_STATE_FINISH_MIGRATE)) {
                runstate_set(RUN_STATE_POSTMIGRATE);
            }

so if the guest was paused before a migration we don't falsely restart
it.  Maybe you need something similar?

Dave

> +    }
> +}
> +
>  static int vfio_migration_init(VFIODevice *vbasedev,
>                                 struct vfio_region_info *info)
>  {
> @@ -173,6 +194,9 @@ static int vfio_migration_init(VFIODevice *vbasedev,
>      vbasedev->vm_state =3D qemu_add_vm_change_state_handler(vfio_vmstate=
_change,
>                                                            vbasedev);
> =20
> +    vbasedev->migration_state.notify =3D vfio_migration_state_notifier;
> +    add_migration_state_change_notifier(&vbasedev->migration_state);
> +
>      return 0;
>  }
> =20
> @@ -211,6 +235,11 @@ add_blocker:
> =20
>  void vfio_migration_finalize(VFIODevice *vbasedev)
>  {
> +
> +    if (vbasedev->migration_state.notify) {
> +        remove_migration_state_change_notifier(&vbasedev->migration_stat=
e);
> +    }
> +
>      if (vbasedev->vm_state) {
>          qemu_del_vm_change_state_handler(vbasedev->vm_state);
>      }
> diff --git a/hw/vfio/trace-events b/hw/vfio/trace-events
> index 3d15bacd031a..69503228f20e 100644
> --- a/hw/vfio/trace-events
> +++ b/hw/vfio/trace-events
> @@ -148,3 +148,4 @@ vfio_display_edid_write_error(void) ""
>  vfio_migration_probe(char *name, uint32_t index) " (%s) Region %d"
>  vfio_migration_set_state(char *name, uint32_t state) " (%s) state %d"
>  vfio_vmstate_change(char *name, int running, const char *reason, uint32_=
t dev_state) " (%s) running %d reason %s device state %d"
> +vfio_migration_state_notifier(char *name, int state) " (%s) state %d"
> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.=
h
> index 3d18eb146b33..28f55f66d019 100644
> --- a/include/hw/vfio/vfio-common.h
> +++ b/include/hw/vfio/vfio-common.h
> @@ -123,6 +123,7 @@ typedef struct VFIODevice {
>      VMChangeStateEntry *vm_state;
>      uint32_t device_state;
>      int vm_running;
> +    Notifier migration_state;
>  } VFIODevice;
> =20
>  struct VFIODeviceOps {
> --=20
> 2.7.0
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


