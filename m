Received: from eggs.gnu.org ([2001:4830:134:3::10]:37832)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zyimin@linux.ibm.com>) id 1fNaVy-0006gC-Kt
	for qemu-devel@nongnu.org; Tue, 29 May 2018 05:02:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zyimin@linux.ibm.com>) id 1fNaVv-0007g2-JU
	for qemu-devel@nongnu.org; Tue, 29 May 2018 05:01:58 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:54458
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <zyimin@linux.ibm.com>)
	id 1fNaVv-0007ff-EK
	for qemu-devel@nongnu.org; Tue, 29 May 2018 05:01:55 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w4T906is098622
	for <qemu-devel@nongnu.org>; Tue, 29 May 2018 05:01:54 -0400
Received: from e18.ny.us.ibm.com (e18.ny.us.ibm.com [129.33.205.208])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2j92cxkuxh-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 29 May 2018 05:01:54 -0400
Received: from localhost
	by e18.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <zyimin@linux.ibm.com>;
	Tue, 29 May 2018 05:01:53 -0400
References: <20180529073140.7392-1-zyimin@linux.ibm.com>
	<20180529084021.GC31560@dnr>
From: Yi Min Zhao <zyimin@linux.ibm.com>
Date: Tue, 29 May 2018 17:01:46 +0800
MIME-Version: 1.0
In-Reply-To: <20180529084021.GC31560@dnr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Message-Id: <b41a7ff8-2705-e065-4a1c-ecfa117a6978@linux.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3] sandbox: disable -sandbox if
 CONFIG_SECCOMP undefined
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?J=c3=a1n_Tomko?= <jtomko@redhat.com>
Cc: otubo@redhat.com, fiuczy@linux.ibm.com, qemu-devel@nongnu.org, borntraeger@de.ibm.com, jferlan@redhat.com, pbonzini@redhat.com



=E5=9C=A8 2018/5/29 =E4=B8=8B=E5=8D=884:40, J=C3=A1n Tomko =E5=86=99=E9=81=
=93:
> On Tue, May 29, 2018 at 03:31:40PM +0800, Yi Min Zhao wrote:
>> If CONFIG_SECCOMP is undefined, the option 'elevateprivileges' remains
>> compiled. This would make libvirt set the corresponding capability and
>> then trigger failure during guest startup. This patch moves the code
>> regarding seccomp command line options to qemu-seccomp.c file and
>> wraps qemu_opts_foreach finding sandbox option with CONFIG_SECCOMP.
>> Because parse_sandbox() is moved into qemu-seccomp.c file, change
>> seccomp_start() to static function.
>>
>> Signed-off-by: Yi Min Zhao <zyimin@linux.ibm.com>
>> ---
>> 1. Problem Description
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> If QEMU is built without seccomp support, 'elevateprivileges' remains=20
>> compiled.
>> This option of sandbox is treated as an indication for seccomp=20
>> blacklist support
>> in libvirt. This behavior is introduced by the libvirt commits=20
>> 31ca6a5 and
>> 3527f9d. It would make libvirt build wrong QEMU cmdline, and then the=20
>> guest
>> startup would fail.
>>
>> 2. Libvirt Log
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> qemu-system-s390x: -sandbox=20
>> on,obsolete=3Ddeny,elevateprivileges=3Ddeny,spawn=3Ddeny,\
>> resourcecontrol=3Ddeny: seccomp support is disabled
>>
>> 3. Fixup
>> =3D=3D=3D=3D=3D=3D=3D=3D
>> Move the code related ot sandbox to qemu-seccomp.c file and wrap them=20
>> with
>> CONFIG_SECCOMP. So compile the code related to sandbox only when
>> CONFIG_SECCOMP is defined.
>> ---
>> include/sysemu/seccomp.h |=C2=A0=C2=A0 3 +-
>> qemu-seccomp.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 | 121=20
>> ++++++++++++++++++++++++++++++++++++++++++++++-
>> vl.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 118=20
>> +--------------------------------------------
>> 3 files changed, 124 insertions(+), 118 deletions(-)
>>
>
> Reviewed-by: J=C3=A1n Tomko <jtomko@redhat.com>
> Tested-by: J=C3=A1n Tomko <jtomko@redhat.com>
>
> Jano
Thanks very much!
