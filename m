Received: from eggs.gnu.org ([2001:4830:134:3::10]:39822)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1ejPa4-0002Q4-Ez
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 08:16:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1ejPZy-0007Cn-PV
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 08:16:08 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:37028)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1ejPZy-0007CS-Gf
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 08:16:02 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w17DDlrW101949
	for <qemu-devel@nongnu.org>; Wed, 7 Feb 2018 08:16:01 -0500
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2fyynpfnxc-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 07 Feb 2018 08:16:01 -0500
Received: from localhost
	by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Wed, 7 Feb 2018 13:15:58 -0000
References: <151800886003.204.16471399016453391332@bdbb90650ae5>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Wed, 7 Feb 2018 14:15:54 +0100
MIME-Version: 1.0
In-Reply-To: <151800886003.204.16471399016453391332@bdbb90650ae5>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Message-Id: <90149d66-845b-2252-05e2-c88647149bb0@de.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v6] s390x/cpu: expose the guest crash
 information
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: famz@redhat.com, qemu-s390x@nongnu.org, thuth@redhat.com, bwalk@linux.vnet.ibm.com, david@redhat.com, cohuck@redhat.com, pasic@linux.vnet.ibm.com, fiuczy@linux.vnet.ibm.com



On 02/07/2018 02:07 PM, no-reply@patchew.org wrote:

>   CC      s390x-linux-user/target/s390x/cpu.o
> /var/tmp/patchew-tester-tmp-ctncjhw8/src/target/s390x/cpu.c: In functio=
n =E2=80=98s390_cpu_get_crash_info=E2=80=99:
> /var/tmp/patchew-tester-tmp-ctncjhw8/src/target/s390x/cpu.c:251:39: err=
or: =E2=80=98CPUS390XState {aka struct CPUS390XState}=E2=80=99 has no mem=
ber named =E2=80=98core_id=E2=80=99
>      panic_info->u.s390.core =3D cpu->env.core_id;
>                                        ^
> make[1]: *** [/var/tmp/patchew-tester-tmp-ctncjhw8/src/rules.mak:66: ta=
rget/s390x/cpu.o] Error 1

Hmm, I should really re-add linux-user to my testing...


This on top fixes the issue:

diff --git a/target/s390x/cpu.c b/target/s390x/cpu.c
index 9dea65b604..603e68e284 100644
--- a/target/s390x/cpu.c
+++ b/target/s390x/cpu.c
@@ -248,7 +248,9 @@ static GuestPanicInformation *s390_cpu_get_crash_info=
(CPUState *cs)
     panic_info =3D g_malloc0(sizeof(GuestPanicInformation));
=20
     panic_info->type =3D GUEST_PANIC_INFORMATION_TYPE_S390;
+#if !defined(CONFIG_USER_ONLY)
     panic_info->u.s390.core =3D cpu->env.core_id;
+#endif
     panic_info->u.s390.psw_mask =3D cpu->env.psw.mask;
     panic_info->u.s390.psw_addr =3D cpu->env.psw.addr;
     panic_info->u.s390.reason =3D cpu->env.crash_reason;
