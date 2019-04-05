Received: from eggs.gnu.org ([209.51.188.92]:47243)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jjherne@linux.ibm.com>) id 1hCOd2-0001oh-C1
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 09:11:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jjherne@linux.ibm.com>) id 1hCOd1-0006n1-5s
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 09:11:32 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:32896
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jjherne@linux.ibm.com>)
	id 1hCOd0-0006mf-RJ
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 09:11:31 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x35DBNKs121338
	for <qemu-devel@nongnu.org>; Fri, 5 Apr 2019 09:11:30 -0400
Received: from e15.ny.us.ibm.com (e15.ny.us.ibm.com [129.33.205.205])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2rp6sbapk4-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 05 Apr 2019 09:11:24 -0400
Received: from localhost
	by e15.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <jjherne@linux.ibm.com>;
	Fri, 5 Apr 2019 14:11:05 +0100
Reply-To: jjherne@linux.ibm.com
References: <1554388475-18329-1-git-send-email-jjherne@linux.ibm.com>
	<6cd9fc3c-f5cb-e0fd-6990-d519014bead0@redhat.com>
	<d5b711f6-2e0e-f664-70cc-8d9c906bf122@redhat.com>
From: "Jason J. Herne" <jjherne@linux.ibm.com>
Date: Fri, 5 Apr 2019 09:11:00 -0400
MIME-Version: 1.0
In-Reply-To: <d5b711f6-2e0e-f664-70cc-8d9c906bf122@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <5749904a-9ac3-1b68-c544-b0f0cdcc8ffa@linux.ibm.com>
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH v6 00/16] s390: vfio-ccw dasd
 ipl support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, qemu-s390x@nongnu.org, cohuck@redhat.com, pasic@linux.ibm.com, alifm@linux.ibm.com, borntraeger@de.ibm.com

On 4/5/19 3:52 AM, Thomas Huth wrote:
> On 05/04/2019 08.58, Thomas Huth wrote:
>> On 04/04/2019 16.34, Jason J. Herne wrote:
>>> This is to support booting from vfio-ccw dasd devices. We basically implement
>>> the real hardware ipl procedure. This allows for booting Linux guests on
>>> vfio-ccw devices.
>>>
>>> vfio-ccw's channel program prefetch algorithm complicates ipl because most ipl
>>> channel programs dynamically modify themselves. Details on the ipl process and
>>> how we worked around this issue can be found in docs/devel/s390-dasd-ipl.txt.
>>
>>   Hi Jason,
>>
>> while running my s390-ccw bios tests, I noticed that network booting
>> seems to be broken now. This used to work before:
>>
>> s390x-softmmu/qemu-system-s390x -nographic -accel kvm \
>>   -bios pc-bios/s390-ccw/s390-ccw.img \
>>   -global s390-ipl.netboot_fw=pc-bios/s390-ccw/s390-netboot.img \
>>   -netdev user,id=n1,tftp=/boot,bootfile=vmlinuz-4.18.0 \
>>   -device virtio-net-ccw,netdev=n1,bootindex=1
>>
>> Now it simply fails with "! No IPL device available !".
>>
>> Could you have a look at it, please?
> 
> FWIW: The problem seems to be in the last patch: virtio_is_supported()
> is now not called anymore, and so virtio_get_device_type() now returns
> the wrong type.
> 
>   Thomas
> 

Good catch. Testing netboot for this iteration did slip my mind. I've now added a basic 
netboot script to my test suite to avoid this type of regression in the future.

Your analysis of the problem matches what I'm seeing as well. Here is what I'm proposing 
to fix it. If you like it, let me know if you want me to re-send just the final patch, or 
the entire series again with a v7 tag.


diff --git a/pc-bios/s390-ccw/main.c b/pc-bios/s390-ccw/main.c
index 03e90e3..3d1e9a4 100644
--- a/pc-bios/s390-ccw/main.c
+++ b/pc-bios/s390-ccw/main.c
@@ -67,6 +67,7 @@ static bool find_subch(int dev_no)
  {
      Schib schib;
      int i, r;
+    bool is_virtio;

      for (i = 0; i < 0x10000; i++) {
          blk_schid.sch_no = i;
@@ -80,12 +81,13 @@ static bool find_subch(int dev_no)

          enable_subchannel(blk_schid);
          cutype = cu_type(blk_schid);
+        is_virtio = virtio_is_supported(blk_schid);

          /* No specific devno given, just return 1st possibly bootable device */
          if (dev_no < 0) {
              switch (cutype) {
              case CU_TYPE_VIRTIO:
-                if (virtio_is_supported(blk_schid)) {
+                if (is_virtio) {
                      /*
                       * Skip net devices since no IPLB is created and therefore
                       * no network bootloader has been loaded


-- 
-- Jason J. Herne (jjherne@linux.ibm.com)
