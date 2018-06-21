Received: from eggs.gnu.org ([2001:4830:134:3::10]:47894)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1fW2wW-0005VI-1m
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 13:00:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1fW2wT-0001SX-0q
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 13:00:20 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:44770
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1fW2wS-0001SF-RM
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 13:00:16 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w5LGxfrg062575
	for <qemu-devel@nongnu.org>; Thu, 21 Jun 2018 13:00:16 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2jrftugf84-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 21 Jun 2018 13:00:15 -0400
Received: from localhost
	by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Thu, 21 Jun 2018 18:00:13 +0100
From: Christian Borntraeger <borntraeger@de.ibm.com>
References: <20180621163522.100968-1-borntraeger@de.ibm.com>
	<f21788b0-6417-dddb-fd5e-9dd9d17cfc66@de.ibm.com>
Date: Thu, 21 Jun 2018 19:00:07 +0200
MIME-Version: 1.0
In-Reply-To: <f21788b0-6417-dddb-fd5e-9dd9d17cfc66@de.ibm.com>
Content-Language: en-US
Message-Id: <e6f90da2-1bba-c14f-83f3-f95b348b9de9@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2] s390/ipl: fix ipl with -no-reboot
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, qemu-s390x <qemu-s390x@nongnu.org>, Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>, Halil Pasic <pasic@linux.vnet.ibm.com>, Janosch Frank <frankja@linux.vnet.ibm.com>, Alexander Graf <agraf@suse.de>, Richard Henderson <rth@twiddle.net>, Paolo Bonzini <pbonzini@redhat.com>



On 06/21/2018 06:51 PM, Christian Borntraeger wrote:
> 
> 
> On 06/21/2018 06:35 PM, Christian Borntraeger wrote:
>> kexec/kdump as well as the bootloader use a subcode of diagnose 308
>> that is supposed to reset the subsystem but not comprise a full
>> "reboot". With the latest refactoring this is now broken when
>> -no-reboot is used. This for example break virt-install from
>> iso images.
> 
> Its even worse. With this patch I can IPL with --no-reboot, but
> virt-install still creates an xml like
> 
>   <on_poweroff>destroy</on_poweroff>
>   <on_reboot>destroy</on_reboot>
>   <on_crash>destroy</on_crash>
> 
> With you patch a "soft reset" still seems to trigger an qapi event
> so that libvirt kills the guest due to that...

So this on top....


diff --git a/vl.c b/vl.c
index 722c3b9963..44e65071bc 100644
--- a/vl.c
+++ b/vl.c
@@ -1628,7 +1628,7 @@ void qemu_system_reset(ShutdownCause reason)
     } else {
         qemu_devices_reset();
     }
-    if (reason) {
+    if (reason != SHUTDOWN_CAUSE_GUEST_RESET_FORCE) {
         qapi_event_send_reset(shutdown_caused_by_guest(reason),
                               &error_abort);
     }
