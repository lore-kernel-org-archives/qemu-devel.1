Received: from eggs.gnu.org ([2001:4830:134:3::10]:59180)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jaden1q84@gmail.com>) id 1cuBVu-0007W2-3j
	for qemu-devel@nongnu.org; Sat, 01 Apr 2017 01:23:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jaden1q84@gmail.com>) id 1cuBVt-0001AE-AH
	for qemu-devel@nongnu.org; Sat, 01 Apr 2017 01:23:50 -0400
Received: from mail-qt0-x234.google.com ([2607:f8b0:400d:c0d::234]:35454)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jaden1q84@gmail.com>) id 1cuBVt-00019a-5g
	for qemu-devel@nongnu.org; Sat, 01 Apr 2017 01:23:49 -0400
Received: by mail-qt0-x234.google.com with SMTP id x35so80460395qtc.2
	for <qemu-devel@nongnu.org>; Fri, 31 Mar 2017 22:23:47 -0700 (PDT)
MIME-Version: 1.0
From: Jaden Liang <jaden1q84@gmail.com>
Date: Sat, 1 Apr 2017 13:23:46 +0800
Message-ID: <CA+Vqw5nfvdR-sE6DfmxMJmbE6+khoYLZSh+JAPD_9vVHtfdBpg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: [Qemu-devel] Performance problem and improvement about block drive
 on NFS shares with libnfs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Hello,

I ran qemu with drive file via libnfs recently, and found some performance
problem and an improvement idea.

I started qemu with 6 drives parameter like nfs://127.0.0.1/dir/vm-disk-x.qcow2
which linked to a local NFS server, then used iometer in guest machine to test
the 4K random read or random write IO performance. I found that while the IO
depth go up, the IOPS hit a bottleneck. I looked into the causes, found that the
main thread of qemu used 100% CPU. From the perf data, it show the CPU heats are
send / recv calls in libnfs. By reading the source code of libnfs and qemu block
drive of nfs.c, libnfs only support single work thread, and the network events
of nfs interface in qemu are all registered in the epoll of main thread. That is
the cause why main thread uses 100% CPU.

After the analysis above, there is an improvement idea comes up. I start a
thread for every drive while libnfs open drive file, then create an epoll in
every drive thread to handle all of the network events. I have finished an demo
modification in block/nfs.c, then rerun iometer in the guest machine, the
performance increased a lot. Random read IOPS increases almost 100%, random
write IOPS increases about 68%.

Test model details
VM configure: 6 vdisks in 1 VM
Test tool and parameter: iometer with 4K random read and randwrite
Backend physical drive: 2 SSDs, 6 vdisks are seperated in 2 SSDs

Before modified:
IO Depth           1        2          4           8       16         32
4K randread  16659  28387   42932   46868   52108   55760
4K randwrite  12212   19456   30447   30574   35788   39015

After modified:
IO Depth            1         2          4          8        16          32
4K randread   17661   33115   57138   82016   99369   109410
4K randwrite  12669   21492   36017   51532   61475   65577

I could put a up to coding standard patch later. Now I want to get some advise
about this modification. Is this a reasonable solution to improve performance in
NFS shares? Or there is another better way?

Any suggestions would be great! Also please feel free to ask question.

-- 
Best regards,
Jaden Liang
