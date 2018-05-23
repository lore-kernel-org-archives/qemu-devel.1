Received: from eggs.gnu.org ([2001:4830:134:3::10]:32974)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <y-goto@jp.fujitsu.com>) id 1fLM1F-0002BK-3X
	for qemu-devel@nongnu.org; Wed, 23 May 2018 01:09:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <y-goto@jp.fujitsu.com>) id 1fLM1B-0004el-U6
	for qemu-devel@nongnu.org; Wed, 23 May 2018 01:09:01 -0400
Received: from mgwym04.jp.fujitsu.com ([211.128.242.43]:12360)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <y-goto@jp.fujitsu.com>)
	id 1fLM1B-0004eJ-Cs
	for qemu-devel@nongnu.org; Wed, 23 May 2018 01:08:57 -0400
Received: from m3050.s.css.fujitsu.com (msm.b.css.fujitsu.com [10.134.21.208])
	by yt-mxoi1.gw.nic.fujitsu.com (Postfix) with ESMTP id 4E6A6AC01A5
	for <qemu-devel@nongnu.org>; Wed, 23 May 2018 14:08:45 +0900 (JST)
Date: Wed, 23 May 2018 14:08:12 +0900
From: Yasunori Goto <y-goto@jp.fujitsu.com>
Message-Id: <20180523140809.622F.E1E9C6FF@jp.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] Questions about vNVDIMM on qemu/KVM
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: NVDIMM-ML <linux-nvdimm@lists.01.org>

Hello,

I'm investigating status of vNVDIMM on qemu/KVM,
and I have some questions about it. I'm glad if anyone answer them.

In my understanding, qemu/KVM has a feature to show NFIT for guest,
and it will be still updated about platform capability with this patch set.
https://lists.gnu.org/archive/html/qemu-devel/2018-05/msg04756.html

And libvirt also supports this feature with <memory model='nvdimm'>
https://libvirt.org/formatdomain.html#elementsMemory


However, virtio-pmem is developing now, and it is better
for archtectures to detect regions of NVDIMM without ACPI (like s390x)
In addition, It is also necessary to flush guest contents on vNVDIMM
who has a backend-file. 


Q1) Does ACPI.NFIT bus of qemu/kvm remain with virtio-pmem? 
    How do each roles become it if both NFIT and virtio-pmem will be available?
    If my understanding is correct, both NFIT and virtio-pmem is used to
    detect vNVDIMM regions, but only one seems to be necessary....

    Otherwize, is the NFIT bus just for keeping compatibility, 
    and virtio-pmem is promising way?

    
Q2) What bus is(will be?) created for virtio-pmem?
    I could confirm the bus of NFIT is created with <memory model='nvdimm'>,
    and I heard other bus will be created for virtio-pmem, but I could not
    find what bus is created concretely.
    ---
      # ndctl list -B
      {
         "provider":"ACPI.NFIT",
         "dev":"ndbus0"
      }
    ---
   
    I think it affects what operations user will be able to, and what 
    notification is necessary for vNVDIMM. 
    ACPI defines some operations like namespace controll, and notification
    for NVDIMM health status or others.
    (I suppose that other status notification might be necessary for vNVDIMM,
     but I'm not sure yet...)

If my understanding is wrong, please correct me.

Thanks,
---
Yasunori Goto
