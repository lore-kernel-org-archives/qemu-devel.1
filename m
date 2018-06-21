Received: from eggs.gnu.org ([2001:4830:134:3::10]:57638)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1fW1qb-0007LZ-RZ
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 11:50:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1fW1qZ-0003Zq-AV
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 11:50:09 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:23989
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1fW1qZ-0003ZP-4U
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 11:50:07 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w5LFniIZ023358
	for <qemu-devel@nongnu.org>; Thu, 21 Jun 2018 11:50:05 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2jrdf2mpyf-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 21 Jun 2018 11:50:03 -0400
Received: from localhost
	by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Thu, 21 Jun 2018 16:50:01 +0100
References: <20180424101859.10239-1-david@redhat.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Thu, 21 Jun 2018 17:49:56 +0200
MIME-Version: 1.0
In-Reply-To: <20180424101859.10239-1-david@redhat.com>
Content-Language: en-US
Message-Id: <7c046e3c-8752-87c5-f4ff-06ef56ef0128@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v1] s390x: refactor reset/reipl handling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>, qemu-s390x@nongnu.org
Cc: qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>, Cornelia Huck <cohuck@redhat.com>, Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>



On 04/24/2018 12:18 PM, David Hildenbrand wrote:
> Calling pause_all_vcpus()/resume_all_vcpus() from a VCPU thread might
> not be the best idea. As pause_all_vcpus() temporarily drops the qemu
> mutex, two parallel calls to pause_all_vcpus() can be active at a time,
> resulting in a deadlock. (either by two VCPUs or by the main thread and a
> VCPU)
> 
> Let's handle it via the main loop instead, as suggested by Paolo. If we
> would have two parallel reset requests by two different VCPUs at the
> same time, the last one would win.
> 
> We use the existing ipl device to handle it. The nice side effect is
> that we can get rid of reipl_requested.
> 
> This change implies that all reset handling now goes via the common
> path, so "no-reboot" handling is now active for all kinds of reboots.

Ok, this breaks the s390 IPL process when -no-reboot  is specified.
The bios does a diagnose 308 subcode 1 to jump to the final image while
at the same time resetting all devices. This is now blocked with -no-reboot
(although it is actually the boot)


I have noticed that with virt-install on iso images since virt-install
specifies -no-reboot.

Something like this seems to help but it is not a nice solution.

diff --git a/hw/s390x/ipl.c b/hw/s390x/ipl.c
index 0d67349004..7b32698eaa 100644
--- a/hw/s390x/ipl.c
+++ b/hw/s390x/ipl.c
@@ -534,8 +534,14 @@ void s390_ipl_reset_request(CPUState *cs, enum s390_reset reset_type)
              */
             ipl->iplb_valid = s390_gen_initial_iplb(ipl);
         }
+        qemu_system_reset_request(SHUTDOWN_CAUSE_GUEST_RESET);
+    } else  if (reset_type == S390_RESET_MODIFIED_CLEAR ||
+                reset_type == S390_RESET_LOAD_NORMAL) {
+	/* ignore -no-reboot */
+        qemu_system_reset_request(SHUTDOWN_CAUSE_GUEST_RESET_FORCE);
+    } else {
+        qemu_system_reset_request(SHUTDOWN_CAUSE_GUEST_RESET);
     }
-    qemu_system_reset_request(SHUTDOWN_CAUSE_GUEST_RESET);
     /* as this is triggered by a CPU, make sure to exit the loop */
     if (tcg_enabled()) {
         cpu_loop_exit(cs);
diff --git a/include/sysemu/sysemu.h b/include/sysemu/sysemu.h
index e893f72f3b..e9b11fd6cb 100644
--- a/include/sysemu/sysemu.h
+++ b/include/sysemu/sysemu.h
@@ -44,6 +44,9 @@ typedef enum ShutdownCause {
                                      turns that into a shutdown */
     SHUTDOWN_CAUSE_GUEST_PANIC,   /* Guest panicked, and command line turns
                                      that into a shutdown */
+    SHUTDOWN_CAUSE_GUEST_RESET_FORCE,/* Guest reset that should ignore --no-reboot
+                                     useful for the subsystem resets on s390 done
+                                     for kdump and kexec */
     SHUTDOWN_CAUSE__MAX,
 } ShutdownCause;
 
diff --git a/vl.c b/vl.c
index b3426e03d0..18f379e833 100644
--- a/vl.c
+++ b/vl.c
@@ -1674,7 +1674,9 @@ void qemu_system_guest_panicked(GuestPanicInformation *info)
 
 void qemu_system_reset_request(ShutdownCause reason)
 {
-    if (no_reboot) {
+    if (reason == SHUTDOWN_CAUSE_GUEST_RESET_FORCE) {
+	    reset_requested = SHUTDOWN_CAUSE_GUEST_RESET;
+    } else if (no_reboot) {
         shutdown_requested = reason;
     } else {
         reset_requested = reason;
-- 
2.17.0
