Received: from eggs.gnu.org ([2001:4830:134:3::10]:36178)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jjherne@linux.vnet.ibm.com>) id 1cTVab-0005bX-Tg
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 10:22:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jjherne@linux.vnet.ibm.com>) id 1cTVaX-0002DA-3l
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 10:22:25 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:57004)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jjherne@linux.vnet.ibm.com>)
	id 1cTVaW-0002CF-R5
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 10:22:21 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v0HFJ1wV102472
	for <qemu-devel@nongnu.org>; Tue, 17 Jan 2017 10:22:18 -0500
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2812r1uvfj-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 17 Jan 2017 10:22:18 -0500
Received: from localhost
	by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <jjherne@linux.vnet.ibm.com>;
	Tue, 17 Jan 2017 08:22:16 -0700
Reply-To: jjherne@linux.vnet.ibm.com
References: <20170117010204.4909-1-ehabkost@redhat.com>
From: "Jason J. Herne" <jjherne@linux.vnet.ibm.com>
Date: Tue, 17 Jan 2017 10:22:10 -0500
MIME-Version: 1.0
In-Reply-To: <20170117010204.4909-1-ehabkost@redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Message-Id: <309bd499-204d-df07-aa99-9a999cfecabc@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH 0/9] i386: query-cpu-model-expansion test
 script
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org
Cc: David Hildenbrand <david@redhat.com>, libvir-list@redhat.com, Markus Armbruster <armbru@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, Igor Mammedov <imammedo@redhat.com>, Jiri Denemark <jdenemar@redhat.com>, Richard Henderson <rth@twiddle.net>

On 01/16/2017 08:01 PM, Eduardo Habkost wrote:
> This is a follow-up to the series that implements
> query-cpu-model-expansion. Before including the test script, the
> series has some fixes to allow the results of
> query-cpu-model-expansion to be used in the QEMU command-line.
>
> The script probably will work on s390x too, but I couldn't test
> it yet.
>

Eduardo,

This test seems to mostly work on s390. The only issue I ran into is 
querying host model using tcg only. s390 requires kvm to query the host 
model. Perhaps we could just skip the tcg host test case on s390?


hernejj: ['/usr/local/bin/qemu-system-s390x', '-chardev', 
'socket,id=mon,path=/var/tmp/qom-fetch-monitor.sock', '-mon', 
'chardev=mon,mode=control', '-display', 'none', '-vga', 'none', 
'-qtest', 'unix:path=/var/tmp/qom-fetch-qtest.sock', '-qtest-log', 
'/dev/null', '-machine', 'accel=qtest', '-machine', 'accel=tcg', '-S', 
'-cpu', 'host']
qemu-system-s390x: CPU definition requires KVM
E
======================================================================
ERROR: testTCGModels (__main__.CPUModelTest)
----------------------------------------------------------------------
Traceback (most recent call last):
   File "./query-cpu-model-test.py", line 380, in testTCGModels
     self.checkAllCPUModels()
   File "./query-cpu-model-test.py", line 375, in checkAllCPUModels
     self.checkOneCPUModel(m)
   File "./query-cpu-model-test.py", line 304, in checkOneCPUModel
     self.checkExpansions(model, msg)
   File "./query-cpu-model-test.py", line 221, in checkExpansions
     '%s.static' % (msg))
   File "./query-cpu-model-test.py", line 177, in checkOneExpansion
     type=type, model=model['model'])
   File "./../scripts/qemu.py", line 185, in command
     raise Exception(reply["error"]["desc"])
Exception: The CPU definition 'host' requires KVM

----------------------------------------------------------------------
Ran 2 tests in 74.622s


-- 
-- Jason J. Herne (jjherne@linux.vnet.ibm.com)
