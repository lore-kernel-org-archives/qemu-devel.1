Received: from eggs.gnu.org ([2001:4830:134:3::10]:49450)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <schwidefsky@de.ibm.com>) id 1et6Bu-0002dO-1m
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 01:35:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <schwidefsky@de.ibm.com>) id 1et6Bp-0005Aq-IL
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 01:35:13 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:60324
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <schwidefsky@de.ibm.com>)
	id 1et6Bp-00057z-Du
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 01:35:09 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w266YZwU045067
	for <qemu-devel@nongnu.org>; Tue, 6 Mar 2018 01:35:08 -0500
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2ghnfp8s25-1
	(version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 06 Mar 2018 01:35:07 -0500
Received: from localhost
	by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <schwidefsky@de.ibm.com>;
	Tue, 6 Mar 2018 06:35:06 -0000
Date: Tue, 6 Mar 2018 07:34:58 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
In-Reply-To: <a90027f7-5b85-a6b1-0f0e-9d0a2510ece5@de.ibm.com>
References: <079a5da7-6586-b974-6b99-e5de055b1bd1@linux.vnet.ibm.com>
	<20180302092318.GA6026@stefanha-x1.localdomain>
	<6a3461c2-368d-1aa1-5b86-a6a602251829@linux.vnet.ibm.com>
	<20180305110356.GF7910@stefanha-x1.localdomain>
	<12e1269c-6eae-a400-cc00-2c5c8e4bb8f9@linux.vnet.ibm.com>
	<c4c4c483-d7aa-7361-774e-254c5517468b@de.ibm.com>
	<a90027f7-5b85-a6b1-0f0e-9d0a2510ece5@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20180306073458.24118b01@mschwideX1>
Subject: Re: [Qemu-devel] [BUG] I/O thread segfault for QEMU on s390x
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Farhan Ali <alifm@linux.vnet.ibm.com>, Stefan Hajnoczi <stefanha@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, mreitz@redhat.com, famz@redhat.com, QEMU Developers <qemu-devel@nongnu.org>, qemu-s390x@nongnu.org, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Hendrik Brueckner <brueckner@linux.vnet.ibm.com>

On Mon, 5 Mar 2018 20:08:45 +0100
Christian Borntraeger <borntraeger@de.ibm.com> wrote:

> Do you happen to run with a recent host kernel that has 
> 
> commit 7041d28115e91f2144f811ffe8a195c696b1e1d0
>     s390: scrub registers on kernel entry and KVM exit
> 
> Can you run with this on top
> diff --git a/arch/s390/kernel/entry.S b/arch/s390/kernel/entry.S
> index 13a133a6015c..d6dc0e5e8f74 100644
> --- a/arch/s390/kernel/entry.S
> +++ b/arch/s390/kernel/entry.S
> @@ -426,13 +426,13 @@ ENTRY(system_call)
>         UPDATE_VTIME %r8,%r9,__LC_SYNC_ENTER_TIMER
>         BPENTER __TI_flags(%r12),_TIF_ISOLATE_BP
>         stmg    %r0,%r7,__PT_R0(%r11)
> -       # clear user controlled register to prevent speculative use
> -       xgr     %r0,%r0
>         mvc     __PT_R8(64,%r11),__LC_SAVE_AREA_SYNC
>         mvc     __PT_PSW(16,%r11),__LC_SVC_OLD_PSW
>         mvc     __PT_INT_CODE(4,%r11),__LC_SVC_ILC
>         stg     %r14,__PT_FLAGS(%r11)
>  .Lsysc_do_svc:
> +       # clear user controlled register to prevent speculative use
> +       xgr     %r0,%r0
>         # load address of system call table
>         lg      %r10,__THREAD_sysc_table(%r13,%r12)
>         llgh    %r8,__PT_INT_CODE+2(%r11)
> 
> 
> To me it looks like that the critical section cleanup (interrupt during system call entry) might
> save the registers again into ptregs but we have already zeroed out r0.
> This patch moves the clearing of r0 after sysc_do_svc, which should fix the critical
> section cleanup.
> 
> Adding Martin and Heiko. Will spin a patch.

Argh, yes. Thanks Chrisitan, this is it. I have been searching for the bug
for days now. The point is that if the system call handler is interrupted
after the xgr but before .Lsysc_do_svc the code at .Lcleanup_system_call 
repeats the stmg for %r0-%r7 but now %r0 is already zero.

Please commit a patch for this and I'll will queue it up immediately.

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
