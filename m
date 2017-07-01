Received: from eggs.gnu.org ([2001:4830:134:3::10]:35610)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <benyux.xu@intel.com>) id 1dRJtT-0003s1-Bw
	for qemu-devel@nongnu.org; Sat, 01 Jul 2017 11:01:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <benyux.xu@intel.com>) id 1dRJtO-0003oi-HV
	for qemu-devel@nongnu.org; Sat, 01 Jul 2017 11:01:07 -0400
Received: from mga05.intel.com ([192.55.52.43]:57356)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <benyux.xu@intel.com>) id 1dRJtO-0003hL-6u
	for qemu-devel@nongnu.org; Sat, 01 Jul 2017 11:01:02 -0400
From: Benyu Xu <benyux.xu@intel.com>
Date: Sat,  1 Jul 2017 22:57:07 +0800
Message-Id: <1498921030-23255-1-git-send-email-benyux.xu@intel.com>
Subject: [Qemu-devel] [PATCH 0/3] pin vcpus to pcpus(set CPU affinity).
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, crosthwaite.peter@gmail.com, rth@twiddle.net, gordon.jin@intel.com, eddie.dong@intel.com, kevin.tian@intel.com, haozhong.zhang@intel.com, hongbo.wang@intel.com, hao.l.li@intel.com, xudong.hao@intel.com, tianyu.lan@intel.com, binx.wu@intel.com, benyux.xu@intel.com, benjamin_xby@163.com

Pin vcpus to pcpus(set CPU affinity).
When run a Qemu in terminal, if we want to set the cpu affinity, for example,
using the tool taskset, we should find the cpus' thread ID first and then 
pin it manually. It's a tedious process, now a new feature "vcpupin" can help
this. This feature will be helpful to do performance tuning, it's more 
flexible and easily to use than external tools.

Add option "-vcpupin [pcpu_id_list]" to implement this feature. use the host's
physical or logical processor(pcpu) id to made a list to set cpu affinity, the
vcpus will sequentially pin to the pcpus of this list.
This means we should use the option -smp to allocate vcpus.
Here use ',' to seperate the single id or id sequence,
     use '-' as the id sequence's connector. eg:
a)
    qemu ... -smp 8 -vcpupin 0,2,4,6-10 ...
    It means qemu will pin 8 vcpus one by one and 1:1 to pcpu 0,2,4,6,7,8,9,10.
b)
    qemu ... -smp 8 -vcpupin 6-10,0,4,2 ...
    It means qemu will pin 8 vcpus one by one and 1:1 to pcpu 6,7,8,9,10,0,4,2.
c)
    qemu ... -smp 8 -vcpupin auto ...
    It means qemu will pin 8 vcpus one by one and 1:1 to pcpu 0,1,2,3,4,5,6,7.



Benyu Xu (3):
  add some vcpu-pin related functions.
  vcpu pin:  parameters parse and execution.
  add option -vcpupin into qemu-options.

 cpus.c                | 126 ++++++++++++++++++++++++++++++++++++++++++++++++++
 include/qom/cpu.h     |   9 ++++
 include/sysemu/cpus.h |   2 +
 qemu-options.hx       |  19 ++++++++
 vl.c                  | 115 +++++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 271 insertions(+)

-- 
1.8.3.1
