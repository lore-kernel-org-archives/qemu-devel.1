Received: from eggs.gnu.org ([2001:4830:134:3::10]:48496)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <felipe@nutanix.com>) id 1dFhnY-0003iD-7g
	for qemu-devel@nongnu.org; Tue, 30 May 2017 10:07:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <felipe@nutanix.com>) id 1dFhnT-0001Sh-6k
	for qemu-devel@nongnu.org; Tue, 30 May 2017 10:07:00 -0400
Received: from us-smtp-delivery-101.mimecast.com ([63.128.21.101]:27837)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <felipe@nutanix.com>) id 1dFhnS-0001S7-T2
	for qemu-devel@nongnu.org; Tue, 30 May 2017 10:06:55 -0400
From: Felipe Franciosi <felipe@nutanix.com>
Date: Tue, 30 May 2017 14:06:40 +0000
Message-ID: <086D6F07-A66C-4DDE-A84F-131EFFB1F56B@nutanix.com>
References: <20170505101337.4650-1-pbonzini@redhat.com>
	<20170505101337.4650-22-pbonzini@redhat.com>
	<20170530131140.GA11356@stefanha-x1.localdomain>
In-Reply-To: <20170530131140.GA11356@stefanha-x1.localdomain>
Content-Language: en-US
Content-ID: <88D4ED65D79E0D43826A5BA633180131@namprd02.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 21/21] vhost-scsi: create a
 vhost-scsi-common abstraction
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>


> On 30 May 2017, at 14:11, Stefan Hajnoczi <stefanha@gmail.com> wrote:
>=20
> On Fri, May 05, 2017 at 12:13:37PM +0200, Paolo Bonzini wrote:
>> From: Felipe Franciosi <felipe@nutanix.com>
>>=20
>> In order to introduce a new vhost-user-scsi host device type, it makes
>> sense to abstract part of vhost-scsi into a common parent class. This
>> commit does exactly that.
>>=20
>> Signed-off-by: Felipe Franciosi <felipe@nutanix.com>
>> Message-Id: <1488479153-21203-3-git-send-email-felipe@nutanix.com>
>> ---
>> hw/scsi/Makefile.objs                 |   2 +-
>> hw/scsi/vhost-scsi-common.c           | 143 +++++++++++++++++++++++++
>> hw/scsi/vhost-scsi.c                  | 194 ++++++++++------------------=
------
>> include/hw/virtio/vhost-scsi-common.h |  48 +++++++++
>> include/hw/virtio/vhost-scsi.h        |  11 +-
>> include/hw/virtio/virtio-scsi.h       |   2 +
>> 6 files changed, 252 insertions(+), 148 deletions(-)
>> create mode 100644 hw/scsi/vhost-scsi-common.c
>> create mode 100644 include/hw/virtio/vhost-scsi-common.h
>>=20
>> diff --git a/hw/scsi/Makefile.objs b/hw/scsi/Makefile.objs
>> index 5a2248be36..54d8754e9a 100644
>> --- a/hw/scsi/Makefile.objs
>> +++ b/hw/scsi/Makefile.objs
>> @@ -10,5 +10,5 @@ obj-$(CONFIG_PSERIES) +=3D spapr_vscsi.o
>>=20
>> ifeq ($(CONFIG_VIRTIO),y)
>> obj-y +=3D virtio-scsi.o virtio-scsi-dataplane.o
>> -obj-$(CONFIG_VHOST_SCSI) +=3D vhost-scsi.o
>> +obj-$(CONFIG_VHOST_SCSI) +=3D vhost-scsi-common.o vhost-scsi.o
>> endif
>> diff --git a/hw/scsi/vhost-scsi-common.c b/hw/scsi/vhost-scsi-common.c
>> new file mode 100644
>> index 0000000000..e41c0314db
>> --- /dev/null
>> +++ b/hw/scsi/vhost-scsi-common.c
>> @@ -0,0 +1,143 @@
>> +/*
>> + * vhost-scsi-common
>> + *
>> + * Copyright (c) 2016 Nutanix Inc. All rights reserved.
>> + *
>> + * Author:
>> + *  Felipe Franciosi <felipe@nutanix.com>
>> + *
>> + * This work is largely based on the "vhost-scsi" implementation by:
>> + *  Stefan Hajnoczi    <stefanha@linux.vnet.ibm.com>
>> + *  Nicholas Bellinger <nab@risingtidesystems.com>
>> + *
>> + * This work is licensed under the terms of the GNU LGPL, version 2 or =
later.
>> + * See the COPYING.LIB file in the top-level directory.
>> + *
>> + */
>> +
>> +#include "qemu/osdep.h"
>> +#include <linux/vhost.h>
>=20
> This breaks the mingw build:
>=20
>  hw/scsi/vhost-scsi-common.c:19:25: fatal error: linux/vhost.h: No such f=
ile or directory
>   #include <linux/vhost.h>
>                         ^
>  compilation terminated.

Thanks for the report.

Paolo: I know you wanted this enabled by default whenever virtio was built,=
 but maybe we should stick to a configure switch live vhost-net, vhost-scsi=
 and vhost-vsock?

Let me know what you think and I'll send an extra patch for it straight awa=
y.

Felipe
