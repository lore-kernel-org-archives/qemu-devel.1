Received: from eggs.gnu.org ([2001:4830:134:3::10]:46718)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <fanc.fnst@cn.fujitsu.com>) id 1cEBV1-0001xe-TZ
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 03:53:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <fanc.fnst@cn.fujitsu.com>) id 1cEBUy-0000ZJ-S3
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 03:53:20 -0500
Received: from [59.151.112.132] (port=17126 helo=heian.cn.fujitsu.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <fanc.fnst@cn.fujitsu.com>) id 1cEBUy-0000W0-F8
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 03:53:16 -0500
Date: Tue, 6 Dec 2016 16:52:11 +0800
From: Chao Fan <fanc.fnst@cn.fujitsu.com>
Message-ID: <20161206085211.GC13801@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
Subject: [Qemu-devel] An issue for migration determining the cpu throttle
 value according to workload
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: quintela@redhat.com, amit.shah@redhat.com, izumi.taku@jp.fujitsu.com, caoj.fnst@cn.fujitsu.com, douly.fnst@cn.fujitsu.com

Hi all,

Here is an issue in auto-converge feature of migration.

When migrating a guest which consumes too much CPU & memory, dirty
pages amount will increase significantly, so does the migration
time, migration can not even complete, at worst.

I did some simple tests on this feature. Set the two parameters
the same as 10,20,30,40,50,60,70,80,99 and run the same task in the
same guest. The result roughly is, with the increment of the
two parameters, the total_time and the dirty_sync_count will decrease.
Result shows larger the value of the two parameters is, faster the
migration is, but much more slowly the guest runs.

So I think there should be a appropriate throttle value according to
the workload of guest. But users do not know how to determine the
appropriate value.

So I want to do a job that qemu can set the throttle value according
to the workload of guest. I think qemu could calculate the instant
dirty pages rate, and then determine a appropriate throttle value.
The instant dirty pages rate means in a short fixed time, how
many dirty pages born. But I have two questions:
1. Where to add this feature. I have two options:
   a. Now qemu detects the rest migration time and decides whether
      to execute the CPU throttle. It can be changed to that qemu
      executes the CPU throttle when instant dirty pages rate increases
      to a certain threshold and sets the throttle value according to
      the instant dirty pages rate. 
   b. Using the current way as it is, when the rest migration time
      is too long and begin to execute the CPU throttle, assign
      appropriate throttle value according to the workload. Codes
      will be changed fewer in this method.
2. How to determine the CPU throttle value according to the dirty pages.
   My preliminary idea is, the CPU throttle should be related to
   the instant dirty pages rate and the total memory.
   But I am not sure how to do the map from instant dirty pages rate
   and total memory to CPU throttle value is best.

Any comments will be welcome, and I want to know whether more people
think this feature is needed.
If anyone has good ideas, please tell me.

Thanks,
Chao Fan
