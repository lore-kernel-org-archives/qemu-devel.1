Received: from eggs.gnu.org ([2001:4830:134:3::10]:38127)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mihajlov@linux.vnet.ibm.com>) id 1enkjw-0006if-Mg
	for qemu-devel@nongnu.org; Mon, 19 Feb 2018 07:40:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mihajlov@linux.vnet.ibm.com>) id 1enkjq-0002vd-Lr
	for qemu-devel@nongnu.org; Mon, 19 Feb 2018 07:40:16 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:60866)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mihajlov@linux.vnet.ibm.com>)
	id 1enkjq-0002uc-Dl
	for qemu-devel@nongnu.org; Mon, 19 Feb 2018 07:40:10 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w1JCdwca127005
	for <qemu-devel@nongnu.org>; Mon, 19 Feb 2018 07:40:09 -0500
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2g7wp5jtkc-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 19 Feb 2018 07:40:07 -0500
Received: from localhost
	by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mihajlov@linux.vnet.ibm.com>;
	Mon, 19 Feb 2018 12:39:47 -0000
References: <1518818879-18608-1-git-send-email-walling@linux.vnet.ibm.com>
	<1518818879-18608-7-git-send-email-walling@linux.vnet.ibm.com>
	<ce6141a7-5071-ea5a-01b8-f432672e2f77@redhat.com>
From: Viktor Mihajlovski <mihajlov@linux.vnet.ibm.com>
Date: Mon, 19 Feb 2018 13:39:44 +0100
MIME-Version: 1.0
In-Reply-To: <ce6141a7-5071-ea5a-01b8-f432672e2f77@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Message-Id: <aebd3bd2-2380-134d-afad-cc0614282491@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH v7 06/12] s390-ccw: parse and
 set boot menu options
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, "Collin L. Walling" <walling@linux.vnet.ibm.com>, qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: frankja@linux.vnet.ibm.com, cohuck@redhat.com, david@redhat.com, alifm@linux.vnet.ibm.com, borntraeger@de.ibm.com

On 17.02.2018 09:26, Thomas Huth wrote:
[...]
>>  struct QemuIplParameters {
>> -    uint8_t  reserved1[4];
>> +    uint8_t  boot_menu_flags;
>> +    uint8_t  reserved1[3];
>> +    uint32_t boot_menu_timeout;
>>      uint64_t netboot_start_addr;
>> -    uint8_t  reserved2[16];
>> +    uint8_t  reserved2[12];
>>  } __attribute__ ((packed));
>>  typedef struct QemuIplParameters QemuIplParameters;
> 
> I think Victor's original intention was to get netboot_start_addr
> aligned in the lowcore memory. Now it's rather aligned in the host
> memory. Quite confusing, but I think I'd rather prefer Victor's idea to
> keep it aligned in the lowcore (since that's the "architected" part).
> 
> Maybe it's better if we do not declare this as a packed struct at all,
> and then instead of doing a memcpy of the whole struct, we set the
> fields manually one by one on the host side into the lowcore, and read
> the fields manually one by one on the guest side? That's more
> cumbersome, but avoids future confusion about the alignments here...
> 
>  Thomas
> 

Hm ... I would prefer to keep it all together and perhaps come up with
better comments (for the fields). BTW: I think it would make sense to
reserve the last 8 bytes 'seriously': in case more global configuration
data is needed in the future, we should have the possibility to install
a pointer to an extension block in there.

Anyway, here's the follup squash-in for a qipl-free IPLB.

---
diff --git a/hw/s390x/ipl.c b/hw/s390x/ipl.c
index 3c6a411..fe70008 100644
--- a/hw/s390x/ipl.c
+++ b/hw/s390x/ipl.c
@@ -222,7 +222,7 @@ static Property s390_ipl_properties[] = {
     DEFINE_PROP_END_OF_LIST(),
 };
 
-static void s390_ipl_set_boot_menu(IplParameterBlock *iplb)
+static void s390_ipl_set_boot_menu(S390IPLState *ipl)
 {
     QemuOptsList *plist = qemu_find_opts("boot-opts");
     QemuOpts *opts = QTAILQ_FIRST(&plist->head);
@@ -231,11 +231,11 @@ static void s390_ipl_set_boot_menu(IplParameterBlock *iplb)
     const char *tmp;
     unsigned long splash_time = 0;
 
-    switch (iplb->pbt) {
+    switch (ipl->iplb.pbt) {
     case S390_IPL_TYPE_CCW:
     case S390_IPL_TYPE_QEMU_SCSI:
-        flags = &iplb->qipl.boot_menu_flags;
-        timeout = &iplb->qipl.boot_menu_timeout;
+        flags = &ipl->qipl.boot_menu_flags;
+        timeout = &ipl->qipl.boot_menu_timeout;
         break;
     default:
         error_report("boot menu is not supported for this device type.");
@@ -482,7 +482,7 @@ void s390_ipl_prepare_cpu(S390CPU *cpu)
         }
         ipl->qipl.netboot_start_addr = cpu_to_be64(ipl->start_addr);
     }
-    s390_ipl_set_boot_menu(&ipl->iplb);
+    s390_ipl_set_boot_menu(ipl);
     s390_ipl_prepare_qipl(cpu);
 
 }


-- 
Regards,
 Viktor Mihajlovski
