Received: from eggs.gnu.org ([209.51.188.92]:38047)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1hGLrx-0007AU-P9
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 07:03:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1hGLrw-0006Ic-Ll
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 07:03:17 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:41584)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1hGLrw-0006Gt-Aq
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 07:03:16 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x3GB286D060487
	for <qemu-devel@nongnu.org>; Tue, 16 Apr 2019 07:03:15 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2rwdd2gv26-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 16 Apr 2019 07:03:11 -0400
Received: from localhost
	by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Tue, 16 Apr 2019 12:02:47 +0100
From: Christian Borntraeger <borntraeger@de.ibm.com>
References: <1555334842-195718-1-git-send-email-imammedo@redhat.com>
	<1555334842-195718-6-git-send-email-imammedo@redhat.com>
	<43f77950-019d-f06f-bfbc-4daa831430e3@de.ibm.com>
Date: Tue, 16 Apr 2019 13:02:42 +0200
MIME-Version: 1.0
In-Reply-To: <43f77950-019d-f06f-bfbc-4daa831430e3@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <531023ac-8e7a-01d1-3fff-e9252625fb16@de.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v1 5/5] s390: do not call
 memory_region_allocate_system_memory() multiple times
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Helge Deller <deller@gmx.de>, =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>, David Gibson <david@gibson.dropbear.id.au>, Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>, David Hildenbrand <david@redhat.com>, Artyom Tarasenko <atar4qemu@gmail.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-ppc@nongnu.org, qemu-s390x@nongnu.org

On 16.04.19 13:01, Christian Borntraeger wrote:
> This crashes
> 
> a simple -kernel -initrd example on s390x.
> 
> #0  0x000003ff94e3e47c in __GI_raise (sig=sig@entry=6) at ../sysdeps/unix/sysv/linux/raise.c:50
> #1  0x000003ff94e23d18 in __GI_abort () at abort.c:79
> #2  0x000003ff94e365e6 in __assert_fail_base
>     (fmt=0x3ff94f60ca6 "%s%s%s:%u: %s%sAssertion `%s' failed.\n%n", assertion=assertion@entry=0x14aac70 "new_block", file=file@entry=0x13b1168 "/home/cborntra/REPOS/qemu/exec.c", line=line@entry=2041, function=function@entry=0x13b0c8a <__PRETTY_FUNCTION__.34656> "qemu_ram_set_idstr") at assert.c:92
> #3  0x000003ff94e36664 in __GI___assert_fail
>     (assertion=assertion@entry=0x14aac70 "new_block", file=file@entry=0x13b1168 "/home/cborntra/REPOS/qemu/exec.c", line=line@entry=2041, function=function@entry=0x13b0c8a <__PRETTY_FUNCTION__.34656> "qemu_ram_set_idstr") at assert.c:101
> #4  0x000000000102e062 in qemu_ram_set_idstr (new_block=new_block@entry=0x0, name=<optimized out>, dev=dev@entry=0x0) at /home/cborntra/REPOS/qemu/exec.c:2041
> #5  0x00000000011f5b0a in vmstate_register_ram (mr=0x2cd2dd0, mr@entry=<error reading variable: value has been optimized out>, dev=dev@entry=0x0) at /home/cborntra/REPOS/qemu/migration/savevm.c:2828
> #6  0x00000000011f5b5a in vmstate_register_ram_global (mr=<error reading variable: value has been optimized out>) at /home/cborntra/REPOS/qemu/migration/savevm.c:2841
> #7  0x000000000110d2ce in s390_memory_init (mem_size=<optimized out>) at /home/cborntra/REPOS/qemu/hw/s390x/s390-virtio-ccw.c:186
> #8  0x000000000110d2ce in ccw_init (machine=0x2a96770) at /home/cborntra/REPOS/qemu/hw/s390x/s390-virtio-ccw.c:266
> #9  0x00000000011b342c in machine_run_board_init (machine=0x2a96770) at /home/cborntra/REPOS/qemu/hw/core/machine.c:1030
> #10 0x0000000001026fee in main (argc=<optimized out>, argv=<optimized out>, envp=<optimized out>) at /home/cborntra/REPOS/qemu/vl.c:4479

Sorry, I forgot to also add Patch4. With that the crash is gone. I will have a look at the patch.
