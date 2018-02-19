Received: from eggs.gnu.org ([2001:4830:134:3::10]:34850)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mihajlov@linux.vnet.ibm.com>) id 1enkMS-00021n-GC
	for qemu-devel@nongnu.org; Mon, 19 Feb 2018 07:16:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mihajlov@linux.vnet.ibm.com>) id 1enkMR-0006En-Ev
	for qemu-devel@nongnu.org; Mon, 19 Feb 2018 07:16:00 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:40700
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mihajlov@linux.vnet.ibm.com>)
	id 1enkMR-0006EO-9h
	for qemu-devel@nongnu.org; Mon, 19 Feb 2018 07:15:59 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w1JC9ChI105545
	for <qemu-devel@nongnu.org>; Mon, 19 Feb 2018 07:15:57 -0500
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2g7vtmm00t-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 19 Feb 2018 07:15:56 -0500
Received: from localhost
	by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mihajlov@linux.vnet.ibm.com>;
	Mon, 19 Feb 2018 12:15:53 -0000
From: Viktor Mihajlovski <mihajlov@linux.vnet.ibm.com>
References: <1518818879-18608-1-git-send-email-walling@linux.vnet.ibm.com>
	<1518818879-18608-6-git-send-email-walling@linux.vnet.ibm.com>
	<331dee18-2eb2-9189-852b-bf8723c03d27@redhat.com>
	<eab38e32-4a4b-1cee-e034-d7e425f3ca44@linux.vnet.ibm.com>
Date: Mon, 19 Feb 2018 13:15:48 +0100
MIME-Version: 1.0
In-Reply-To: <eab38e32-4a4b-1cee-e034-d7e425f3ca44@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Message-Id: <8bc5f6a2-275f-8e06-571d-d270deb1fa29@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH v7 05/12] s390-ccw: move
 auxiliary IPL data to separate location
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, "Collin L. Walling" <walling@linux.vnet.ibm.com>, qemu-s390x@nongnu.org, qemu-devel@nongnu.org, borntraeger@de.ibm.com
Cc: alifm@linux.vnet.ibm.com, frankja@linux.vnet.ibm.com, cohuck@redhat.com, david@redhat.com

On 19.02.2018 09:50, Viktor Mihajlovski wrote:
> On 17.02.2018 09:11, Thomas Huth wrote:
> [...]
>>
>> I still think that the information should *not* be stored within the
>> IplParameterBlock to avoid that we pass it via DIAG 0x308, too.
>> If we do it like this, I'm pretty sure that we will look at this code in
>> a couple of years and wonder whether we can change it again or whether
>> this is an established interface between the host and the guest. So
>> please, let's avoid establishing such "hidden" interfaces just out of
>> current convenience. There must be a better location for this.
>> Christian, do you have an idea?
>>
>>  Thomas
>>
> In principle I do agree, although I think we can manage the host/guest
> boundary. If we believe we can't, we have a much bigger problem (looking
> at the position of the iplb smack in the middle of the s390-ipl state).
> 
> The main reason why I didn't bother to introduce a new private field in
> s390-ipl was that I expect more changes to the IPL area in the future
> (earlier than in a couple of years) and am not really sure whether this
> QEMU <-> BIOS interface will remain the same and how much effort to
> spend on it.
> 
> The major point of this change is to move non-standard data out of the
> guest-visible IPLB to avoid compatibility problems in the future, while
> still catering for features like network boot and boot menus. I have no
> bias against other solutions achieving this objective. If you and
> Christian think we need a new field, it's all right with me.
> 
With below squashed in (and a subsequent fixup for the next patch), we can
logically separate the QEMU IPL parameter from the IPLB. Better?

---
diff --git a/hw/s390x/ipl.c b/hw/s390x/ipl.c
index 31565ce..c5923b5 100644
--- a/hw/s390x/ipl.c
+++ b/hw/s390x/ipl.c
@@ -410,7 +410,7 @@ static void s390_ipl_prepare_qipl(S390CPU *cpu)
         error_report("Cannot set QEMU IPL parameters");
         return;
     }
-    memcpy(addr + QIPL_ADDRESS, &ipl->iplb.qipl, sizeof(QemuIplParameters));
+    memcpy(addr + QIPL_ADDRESS, &ipl->qipl, sizeof(QemuIplParameters));
     cpu_physical_memory_unmap(addr, len, 1, len);
 }
 
@@ -433,7 +433,7 @@ void s390_ipl_prepare_cpu(S390CPU *cpu)
             error_report_err(err);
             vm_stop(RUN_STATE_INTERNAL_ERROR);
         }
-        ipl->iplb.qipl.netboot_start_addr = cpu_to_be64(ipl->start_addr);
+        ipl->qipl.netboot_start_addr = cpu_to_be64(ipl->start_addr);
     }
     s390_ipl_prepare_qipl(cpu);
 
diff --git a/hw/s390x/ipl.h b/hw/s390x/ipl.h
index 74469b1..775d363 100644
--- a/hw/s390x/ipl.h
+++ b/hw/s390x/ipl.h
@@ -88,7 +88,6 @@ union IplParameterBlock {
             IplBlockFcp fcp;
             IplBlockQemuScsi scsi;
         };
-        QemuIplParameters qipl;
     } QEMU_PACKED;
     struct {
         uint8_t  reserved1[110];
@@ -120,6 +119,7 @@ struct S390IPLState {
     bool iplb_valid;
     bool reipl_requested;
     bool netboot;
+    QemuIplParameters qipl;
 
     /*< public >*/
     char *kernel;


-- 
Regards,
 Viktor Mihajlovski
