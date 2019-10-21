Return-Path: <SRS0=8ZcK=YO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3C1ACA9EAF
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 14:11:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF0112070B
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 14:11:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QCqTPMUQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF0112070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42926 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMYPX-0008Th-E6
	for qemu-devel@archiver.kernel.org; Mon, 21 Oct 2019 10:11:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45313)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jfreimann@redhat.com>) id 1iMYNQ-0006FW-0c
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 10:09:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jfreimann@redhat.com>) id 1iMYNN-0003dj-PG
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 10:09:39 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:54165
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jfreimann@redhat.com>)
 id 1iMYNN-0003dX-LU
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 10:09:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1571666977;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nEE8xrlk1LOkLllgW0pYJmvd8i9ffzrkime+vGkNz2k=;
 b=QCqTPMUQ0x4AM9y/gwzjPupnU1kbds00TOQziVzQwLOU+UbGT0qBW+KZd7jy/wO0huaGkl
 m7NPZNMxT6Gt8eYGs9kLLGqR3ZlWCuDOQOMN3P/3W7QdDj4B4CRHkfOCFK3ER9THWvTW6N
 3iHmb3YCU0bFJDQcMFE/ZXLBz+eBT00=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-261-7BA9M7d2MMeQrj-arNCAAg-1; Mon, 21 Oct 2019 10:09:35 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BCDA747B;
 Mon, 21 Oct 2019 14:09:34 +0000 (UTC)
Received: from localhost (dhcp-192-217.str.redhat.com [10.33.192.217])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3452398A9;
 Mon, 21 Oct 2019 14:09:34 +0000 (UTC)
Date: Mon, 21 Oct 2019 16:09:32 +0200
From: Jens Freimann <jfreimann@redhat.com>
To: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH 11/11] vfio: unplug failover primary device before
 migration
Message-ID: <20191021140932.hufkcin75lhbfakf@jenstp.localdomain>
References: <20191018202040.30349-1-jfreimann@redhat.com>
 <20191018202040.30349-12-jfreimann@redhat.com>
 <20191021154504.0fbebf39.cohuck@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20191021154504.0fbebf39.cohuck@redhat.com>
User-Agent: NeoMutt/20180716-1376-5d6ed1
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: 7BA9M7d2MMeQrj-arNCAAg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: pkrempa@redhat.com, berrange@redhat.com, ehabkost@redhat.com,
 mst@redhat.com, aadam@redhat.com, qemu-devel@nongnu.org, dgilbert@redhat.com,
 alex.williamson@redhat.com, laine@redhat.com, ailan@redhat.com,
 parav@mellanox.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Oct 21, 2019 at 03:45:04PM +0200, Cornelia Huck wrote:
>On Fri, 18 Oct 2019 22:20:40 +0200
>Jens Freimann <jfreimann@redhat.com> wrote:
>
>> As usual block all vfio-pci devices from being migrated, but make an
>> exception for failover primary devices. This is achieved by setting
>> unmigratable to 0 but also add a migration blocker for all vfio-pci
>> devices except failover primary devices. These will be unplugged before
>> migration happens by the migration handler of the corresponding
>> virtio-net standby device.
>>
>> Signed-off-by: Jens Freimann <jfreimann@redhat.com>
>> ---
>>  hw/vfio/pci.c | 31 +++++++++++++++++++++++++------
>>  hw/vfio/pci.h |  1 +
>>  2 files changed, 26 insertions(+), 6 deletions(-)
>>
>> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
>> index 12fac39804..a15b83c6b6 100644
>> --- a/hw/vfio/pci.c
>> +++ b/hw/vfio/pci.c
>> @@ -40,6 +40,9 @@
>>  #include "pci.h"
>>  #include "trace.h"
>>  #include "qapi/error.h"
>> +#include "migration/blocker.h"
>> +#include "qemu/option.h"
>> +#include "qemu/option_int.h"
>>
>>  #define TYPE_VFIO_PCI "vfio-pci"
>>  #define PCI_VFIO(obj)    OBJECT_CHECK(VFIOPCIDevice, obj, TYPE_VFIO_PCI=
)
>> @@ -2712,12 +2715,26 @@ static void vfio_realize(PCIDevice *pdev, Error =
**errp)
>>      int i, ret;
>>      bool is_mdev;
>>
>> +    if (!pdev->net_failover_pair_id) {
>> +        error_setg(&vdev->migration_blocker,
>> +                "VFIO device doesn't support migration");
>> +        ret =3D migrate_add_blocker(vdev->migration_blocker, &err);
>> +        if (err) {
>> +            error_propagate(errp, err);
>> +            goto error;
>
>This looks wrong, you haven't set up vbasedev.name yet.

You're right.

>> +        }
>> +    } else {
>> +            pdev->qdev.allow_unplug_during_migration =3D true;
>> +    }
>> +
>>      if (!vdev->vbasedev.sysfsdev) {
>>          if (!(~vdev->host.domain || ~vdev->host.bus ||
>>                ~vdev->host.slot || ~vdev->host.function)) {
>>              error_setg(errp, "No provided host device");
>>              error_append_hint(errp, "Use -device vfio-pci,host=3DDDDD:B=
B:DD.F "
>>                                "or -device vfio-pci,sysfsdev=3DPATH_TO_D=
EVICE\n");
>> +            migrate_del_blocker(vdev->migration_blocker);
>> +            error_free(vdev->migration_blocker);
>>              return;
>>          }
>>          vdev->vbasedev.sysfsdev =3D
>> @@ -2729,6 +2746,8 @@ static void vfio_realize(PCIDevice *pdev, Error **=
errp)
>>      if (stat(vdev->vbasedev.sysfsdev, &st) < 0) {
>>          error_setg_errno(errp, errno, "no such host device");
>>          error_prepend(errp, VFIO_MSG_PREFIX, vdev->vbasedev.sysfsdev);
>> +        migrate_del_blocker(vdev->migration_blocker);
>> +        error_free(vdev->migration_blocker);
>>          return;
>>      }
>
>Might be a bit easier cleanup-wise if you set up the blocker resp.
>allow unplug during migration only here. The only difference is that
>you'll get a different error message when trying to set up a
>non-failover device with invalid specs on a migratable-only setup.

Yes, so I moved it to this place now. This saves me cleanup up the
migration blocker in the above two cases. I don't jump to error if
adding the migration blocker failed, I just have to free the blocker
Error and can return.
>
>>
>> @@ -3008,6 +3027,8 @@ out_teardown:
>>      vfio_bars_exit(vdev);
>>  error:
>>      error_prepend(errp, VFIO_MSG_PREFIX, vdev->vbasedev.name);
>> +    migrate_del_blocker(vdev->migration_blocker);
>> +    error_free(vdev->migration_blocker);
>
>Shouldn't you check whether migration_block has been set up, like in
>the finalize routine?

yes, added the same check here.

Thanks Conny!

regards,
Jens=20


