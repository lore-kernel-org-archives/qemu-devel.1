Received: from eggs.gnu.org ([2001:4830:134:3::10]:36600)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <danielhb@linux.vnet.ibm.com>) id 1f4E1c-0000FI-J0
	for qemu-devel@nongnu.org; Thu, 05 Apr 2018 19:10:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <danielhb@linux.vnet.ibm.com>) id 1f4E1Z-0002nd-Dn
	for qemu-devel@nongnu.org; Thu, 05 Apr 2018 19:10:36 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:60676
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <danielhb@linux.vnet.ibm.com>)
	id 1f4E1Z-0002nM-6u
	for qemu-devel@nongnu.org; Thu, 05 Apr 2018 19:10:33 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w35NAI25072435
	for <qemu-devel@nongnu.org>; Thu, 5 Apr 2018 19:10:32 -0400
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2h5vjvh8k6-1
	(version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 05 Apr 2018 19:10:32 -0400
Received: from localhost
	by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <danielhb@linux.vnet.ibm.com>;
	Thu, 5 Apr 2018 19:10:31 -0400
References: <20180405162347.5623-1-pbonzini@redhat.com>
From: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
Date: Thu, 5 Apr 2018 20:10:27 -0300
MIME-Version: 1.0
In-Reply-To: <20180405162347.5623-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Message-Id: <5a3d6ece-e68b-5eae-3808-510c4eed4d68@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4 0/2] hw/scsi: support SCSI-2 passthrough
 without PI
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: famz@redhat.com

Hi,


On 04/05/2018 01:23 PM, Paolo Bonzini wrote:
> This is my version of Daniel's patch.  In order to keep the
> RD/WRPROTECT check for emulated SCSI disks, I've added a new property
> to scsi-disk/hd/cd devices as well.  The property, similar to the
> earlier versions posted by Daniel, is available to the user, but for
> scsi-disk/hd/cd it affects the INQUIRY value returned by the emulated
> INQUIRY command.
>
> Daniel, can you please test it?

Emulated case worked as intended: I was able to set the scsi_version of=20
the emulated device via command line.

One thing I noticed is that I am also able to set the scsi_version of=20
scsi-block devices - if I set scsi_version=3D6 in a SCSI passthrough=20
device that has version=3D2, the version that ends up being passed to the=
=20
guest is 6. In a quick look I believe that this behavior is caused by=20
setting

+=C2=A0=C2=A0=C2=A0 s->qdev.scsi_version =3D s->qdev.default_scsi_version=
;

in scsi_disk_reset, which is the reset function that is also used for=20
scsi-block devices. So, setting scsi_version=3D6 in the command line=20
overwrites the default_scsi_version =3D -1 that is being set in patch 2,=20
making scsi_version =3D! -1 and bypassing the scsi_version assignment cod=
e.

A quick fix is to get rid of the scsi_version =3D=3D -1 restriction to se=
t=20
the scsi_version. This is something that Fam proposed in one of the=20
reviews. Given that a well behaved guest will not spam INQUIRY messages=20
(causing the code to always recalculate the same version again), I am=20
fine with it.

Another quick fix is to make a new scsi_block_reset function that calls=20
scsi_disk_reset and=C2=A0 sets s->scsi_version =3D -1 right after.

Yet another fix is to fully prohibit the user to set scsi_version=20
scsi-block and scsi-generic cases, returning an error message right off=20
the start. Not sure how hard this would be - perhaps the above=20
alternatives are cleaner.

Another fix is ... no fix. I am not sure how far the design philosophy=20
of passthrough devices allows the user to overwrite device parameters in=20
despite of their real values, but ....=C2=A0 what if the user wants to=20
enforce a scsi_version when using a scsi-block device? The device will=20
surely behave badly, but the user explicitly enforced it via command=20
line, so perhaps let him/her have at it?


Thanks,


Daniel




>
> Thanks,
>
> Paolo
>
> Daniel Henrique Barboza (1):
>    hw/scsi: support SCSI-2 passthrough without PI
>
> Paolo Bonzini (1):
>    scsi-disk: allow customizing the SCSI version
>
>   hw/scsi/scsi-disk.c    | 29 ++++++++++++++++++++++++-----
>   hw/scsi/scsi-generic.c | 48 +++++++++++++++++++++++++++++++++++++----=
-------
>   include/hw/scsi/scsi.h |  2 ++
>   3 files changed, 63 insertions(+), 16 deletions(-)
>
