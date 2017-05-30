Received: from eggs.gnu.org ([2001:4830:134:3::10]:50703)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dFhwn-0002fR-Gm
	for qemu-devel@nongnu.org; Tue, 30 May 2017 10:16:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dFhwh-00048L-QK
	for qemu-devel@nongnu.org; Tue, 30 May 2017 10:16:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43304)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1dFhwh-000489-KM
	for qemu-devel@nongnu.org; Tue, 30 May 2017 10:16:27 -0400
References: <20170505101337.4650-1-pbonzini@redhat.com>
	<20170505101337.4650-22-pbonzini@redhat.com>
	<20170530131140.GA11356@stefanha-x1.localdomain>
	<086D6F07-A66C-4DDE-A84F-131EFFB1F56B@nutanix.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <e5ed37e3-832a-8336-ea9e-3e7fd3974596@redhat.com>
Date: Tue, 30 May 2017 16:16:23 +0200
MIME-Version: 1.0
In-Reply-To: <086D6F07-A66C-4DDE-A84F-131EFFB1F56B@nutanix.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
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
To: Felipe Franciosi <felipe@nutanix.com>, Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-devel <qemu-devel@nongnu.org>



On 30/05/2017 16:06, Felipe Franciosi wrote:
>> This breaks the mingw build:
>>
>>  hw/scsi/vhost-scsi-common.c:19:25: fatal error: linux/vhost.h: No suc=
h file or directory
>>   #include <linux/vhost.h>
>>                         ^
>>  compilation terminated.
> Thanks for the report.
>=20
> Paolo: I know you wanted this enabled by default whenever virtio was bu=
ilt, but maybe we should stick to a configure switch live vhost-net, vhos=
t-scsi and vhost-vsock?
>=20
> Let me know what you think and I'll send an extra patch for it straight=
 away.

This was my mistake.  Your patch broke s390, and when I fixed it I
copied the wrong setting:

default-configs/pci.mak:CONFIG_VHOST_USER_SCSI=3D$(CONFIG_POSIX)
default-configs/s390x-softmmu.mak:CONFIG_VHOST_USER_SCSI=3Dy

Unfortunately, the mingw docker test doesn't build all targets, so I
missed it.

I would like vhost-user to be available on non-Linux POSIX, but this is
not immediately possible because vhost-backend.c includes the kernel
backend.  So we'll have to change CONFIG_POSIX to CONFIG_LINUX too.

Paolo
