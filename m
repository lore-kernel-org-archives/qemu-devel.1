Received: from eggs.gnu.org ([2001:4830:134:3::10]:47632)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1esvTl-0002Jy-0F
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 14:08:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1esvTh-0003UQ-M5
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 14:08:56 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:55418)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1esvTh-0003Td-D6
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 14:08:53 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w25J8DFD094088
	for <qemu-devel@nongnu.org>; Mon, 5 Mar 2018 14:08:52 -0500
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2ghbnagec0-1
	(version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 05 Mar 2018 14:08:51 -0500
Received: from localhost
	by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Mon, 5 Mar 2018 19:08:49 -0000
From: Christian Borntraeger <borntraeger@de.ibm.com>
References: <079a5da7-6586-b974-6b99-e5de055b1bd1@linux.vnet.ibm.com>
	<20180302092318.GA6026@stefanha-x1.localdomain>
	<6a3461c2-368d-1aa1-5b86-a6a602251829@linux.vnet.ibm.com>
	<20180305110356.GF7910@stefanha-x1.localdomain>
	<12e1269c-6eae-a400-cc00-2c5c8e4bb8f9@linux.vnet.ibm.com>
	<c4c4c483-d7aa-7361-774e-254c5517468b@de.ibm.com>
Date: Mon, 5 Mar 2018 20:08:45 +0100
MIME-Version: 1.0
In-Reply-To: <c4c4c483-d7aa-7361-774e-254c5517468b@de.ibm.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Message-Id: <a90027f7-5b85-a6b1-0f0e-9d0a2510ece5@de.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [BUG] I/O thread segfault for QEMU on s390x
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Farhan Ali <alifm@linux.vnet.ibm.com>, Stefan Hajnoczi <stefanha@redhat.com>
Cc: Cornelia Huck <cohuck@redhat.com>, Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, mreitz@redhat.com, famz@redhat.com, QEMU Developers <qemu-devel@nongnu.org>, qemu-s390x@nongnu.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Hendrik Brueckner <brueckner@linux.vnet.ibm.com>

Do you happen to run with a recent host kernel that has=20

commit 7041d28115e91f2144f811ffe8a195c696b1e1d0
    s390: scrub registers on kernel entry and KVM exit





Can you run with this on top
diff --git a/arch/s390/kernel/entry.S b/arch/s390/kernel/entry.S
index 13a133a6015c..d6dc0e5e8f74 100644
--- a/arch/s390/kernel/entry.S
+++ b/arch/s390/kernel/entry.S
@@ -426,13 +426,13 @@ ENTRY(system_call)
        UPDATE_VTIME %r8,%r9,__LC_SYNC_ENTER_TIMER
        BPENTER __TI_flags(%r12),_TIF_ISOLATE_BP
        stmg    %r0,%r7,__PT_R0(%r11)
-       # clear user controlled register to prevent speculative use
-       xgr     %r0,%r0
        mvc     __PT_R8(64,%r11),__LC_SAVE_AREA_SYNC
        mvc     __PT_PSW(16,%r11),__LC_SVC_OLD_PSW
        mvc     __PT_INT_CODE(4,%r11),__LC_SVC_ILC
        stg     %r14,__PT_FLAGS(%r11)
 .Lsysc_do_svc:
+       # clear user controlled register to prevent speculative use
+       xgr     %r0,%r0
        # load address of system call table
        lg      %r10,__THREAD_sysc_table(%r13,%r12)
        llgh    %r8,__PT_INT_CODE+2(%r11)


To me it looks like that the critical section cleanup (interrupt during s=
ystem call entry) might
save the registers again into ptregs but we have already zeroed out r0.
This patch moves the clearing of r0 after sysc_do_svc, which should fix t=
he critical
section cleanup.

Adding Martin and Heiko. Will spin a patch.


On 03/05/2018 07:54 PM, Christian Borntraeger wrote:
>=20
>=20
> On 03/05/2018 07:45 PM, Farhan Ali wrote:
>>
>>
>> On 03/05/2018 06:03 AM, Stefan Hajnoczi wrote:
>>> Please include the following gdb output:
>>>
>>> =A0=A0 (gdb) disas swapcontext
>>> =A0=A0 (gdb) i r
>>>
>>> That way it's possible to see which instruction faulted and which
>>> registers were being accessed.
>>
>>
>> here is the disas out for swapcontext, this is on a coredump with debu=
gging symbols enabled for qemu. So the addresses from the previous dump i=
s a little different.
>>
>>
>> (gdb) disas swapcontext
>> Dump of assembler code for function swapcontext:
>> =A0=A0 0x000003ff90751fb8 <+0>:=A0=A0=A0 lgr=A0=A0=A0 %r1,%r2
>> =A0=A0 0x000003ff90751fbc <+4>:=A0=A0=A0 lgr=A0=A0=A0 %r0,%r3
>> =A0=A0 0x000003ff90751fc0 <+8>:=A0=A0=A0 stfpc=A0=A0=A0 248(%r1)
>> =A0=A0 0x000003ff90751fc4 <+12>:=A0=A0=A0 std=A0=A0=A0 %f0,256(%r1)
>> =A0=A0 0x000003ff90751fc8 <+16>:=A0=A0=A0 std=A0=A0=A0 %f1,264(%r1)
>> =A0=A0 0x000003ff90751fcc <+20>:=A0=A0=A0 std=A0=A0=A0 %f2,272(%r1)
>> =A0=A0 0x000003ff90751fd0 <+24>:=A0=A0=A0 std=A0=A0=A0 %f3,280(%r1)
>> =A0=A0 0x000003ff90751fd4 <+28>:=A0=A0=A0 std=A0=A0=A0 %f4,288(%r1)
>> =A0=A0 0x000003ff90751fd8 <+32>:=A0=A0=A0 std=A0=A0=A0 %f5,296(%r1)
>> =A0=A0 0x000003ff90751fdc <+36>:=A0=A0=A0 std=A0=A0=A0 %f6,304(%r1)
>> =A0=A0 0x000003ff90751fe0 <+40>:=A0=A0=A0 std=A0=A0=A0 %f7,312(%r1)
>> =A0=A0 0x000003ff90751fe4 <+44>:=A0=A0=A0 std=A0=A0=A0 %f8,320(%r1)
>> =A0=A0 0x000003ff90751fe8 <+48>:=A0=A0=A0 std=A0=A0=A0 %f9,328(%r1)
>> =A0=A0 0x000003ff90751fec <+52>:=A0=A0=A0 std=A0=A0=A0 %f10,336(%r1)
>> =A0=A0 0x000003ff90751ff0 <+56>:=A0=A0=A0 std=A0=A0=A0 %f11,344(%r1)
>> =A0=A0 0x000003ff90751ff4 <+60>:=A0=A0=A0 std=A0=A0=A0 %f12,352(%r1)
>> =A0=A0 0x000003ff90751ff8 <+64>:=A0=A0=A0 std=A0=A0=A0 %f13,360(%r1)
>> =A0=A0 0x000003ff90751ffc <+68>:=A0=A0=A0 std=A0=A0=A0 %f14,368(%r1)
>> =A0=A0 0x000003ff90752000 <+72>:=A0=A0=A0 std=A0=A0=A0 %f15,376(%r1)
>> =A0=A0 0x000003ff90752004 <+76>:=A0=A0=A0 slgr=A0=A0=A0 %r2,%r2
>> =A0=A0 0x000003ff90752008 <+80>:=A0=A0=A0 stam=A0=A0=A0 %a0,%a15,184(%=
r1)
>> =A0=A0 0x000003ff9075200c <+84>:=A0=A0=A0 stmg=A0=A0=A0 %r0,%r15,56(%r=
1)
>> =A0=A0 0x000003ff90752012 <+90>:=A0=A0=A0 la=A0=A0=A0 %r2,2
>> =A0=A0 0x000003ff90752016 <+94>:=A0=A0=A0 lgr=A0=A0=A0 %r5,%r0
>> =A0=A0 0x000003ff9075201a <+98>:=A0=A0=A0 la=A0=A0=A0 %r3,384(%r5)
>> =A0=A0 0x000003ff9075201e <+102>:=A0=A0=A0 la=A0=A0=A0 %r4,384(%r1)
>> =A0=A0 0x000003ff90752022 <+106>:=A0=A0=A0 lghi=A0=A0=A0 %r5,8
>> =A0=A0 0x000003ff90752026 <+110>:=A0=A0=A0 svc=A0=A0=A0 175
>=20
> sys_rt_sigprocmask. r0 should not be changed by the system call.
>=20
>> =A0=A0 0x000003ff90752028 <+112>:=A0=A0=A0 lgr=A0=A0=A0 %r5,%r0
>> =3D> 0x000003ff9075202c <+116>:=A0=A0=A0 lfpc=A0=A0=A0 248(%r5)
>=20
> so r5 is zero and it was loaded from r0. r0 was loaded from r3 (which i=
s the 2nd parameter to this
> function). Now this is odd.
>=20
>> =A0=A0 0x000003ff90752030 <+120>:=A0=A0=A0 ld=A0=A0=A0 %f0,256(%r5)
>> =A0=A0 0x000003ff90752034 <+124>:=A0=A0=A0 ld=A0=A0=A0 %f1,264(%r5)
>> =A0=A0 0x000003ff90752038 <+128>:=A0=A0=A0 ld=A0=A0=A0 %f2,272(%r5)
>> =A0=A0 0x000003ff9075203c <+132>:=A0=A0=A0 ld=A0=A0=A0 %f3,280(%r5)
>> =A0=A0 0x000003ff90752040 <+136>:=A0=A0=A0 ld=A0=A0=A0 %f4,288(%r5)
>> =A0=A0 0x000003ff90752044 <+140>:=A0=A0=A0 ld=A0=A0=A0 %f5,296(%r5)
>> =A0=A0 0x000003ff90752048 <+144>:=A0=A0=A0 ld=A0=A0=A0 %f6,304(%r5)
>> =A0=A0 0x000003ff9075204c <+148>:=A0=A0=A0 ld=A0=A0=A0 %f7,312(%r5)
>> =A0=A0 0x000003ff90752050 <+152>:=A0=A0=A0 ld=A0=A0=A0 %f8,320(%r5)
>> =A0=A0 0x000003ff90752054 <+156>:=A0=A0=A0 ld=A0=A0=A0 %f9,328(%r5)
>> =A0=A0 0x000003ff90752058 <+160>:=A0=A0=A0 ld=A0=A0=A0 %f10,336(%r5)
>> =A0=A0 0x000003ff9075205c <+164>:=A0=A0=A0 ld=A0=A0=A0 %f11,344(%r5)
>> =A0=A0 0x000003ff90752060 <+168>:=A0=A0=A0 ld=A0=A0=A0 %f12,352(%r5)
>> =A0=A0 0x000003ff90752064 <+172>:=A0=A0=A0 ld=A0=A0=A0 %f13,360(%r5)
>> =A0=A0 0x000003ff90752068 <+176>:=A0=A0=A0 ld=A0=A0=A0 %f14,368(%r5)
>> =A0=A0 0x000003ff9075206c <+180>:=A0=A0=A0 ld=A0=A0=A0 %f15,376(%r5)
>> =A0=A0 0x000003ff90752070 <+184>:=A0=A0=A0 lam=A0=A0=A0 %a2,%a15,192(%=
r5)
>> =A0=A0 0x000003ff90752074 <+188>:=A0=A0=A0 lmg=A0=A0=A0 %r0,%r15,56(%r=
5)
>> =A0=A0 0x000003ff9075207a <+194>:=A0=A0=A0 br=A0=A0=A0 %r14
>> End of assembler dump.
>>
>> (gdb) i r
>> r0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0x0=A0=A0=A0 0
>> r1=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0x3ff8fe7de40=A0=A0=A0 43961658=
81408
>> r2=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0x0=A0=A0=A0 0
>> r3=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0x3ff8fe7e1c0=A0=A0=A0 43961658=
82304
>> r4=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0x3ff8fe7dfc0=A0=A0=A0 43961658=
81792
>> r5=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0x0=A0=A0=A0 0
>> r6=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0xffffffff88004880=A0=A0=A0 184=
46744071696304256
>> r7=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0x3ff880009e0=A0=A0=A0 43960332=
47712
>> r8=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0x27ff89000=A0=A0=A0 1073693081=
6
>> r9=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0x3ff88001460=A0=A0=A0 43960332=
50400
>> r10=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0x1000=A0=A0=A0 4096
>> r11=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0x1261be0=A0=A0=A0 19274720
>> r12=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0x3ff88001e00=A0=A0=A0 4396033252=
864
>> r13=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0x14d0bc0=A0=A0=A0 21826496
>> r14=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0x1312ac8=A0=A0=A0 19999432
>> r15=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0x3ff8fe7dc80=A0=A0=A0 4396165880=
960
>> pc=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0x3ff9075202c=A0=A0=A0 0x3ff907=
5202c <swapcontext+116>
>> cc=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0x2=A0=A0=A0 2
