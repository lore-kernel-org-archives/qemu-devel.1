Received: from eggs.gnu.org ([2001:4830:134:3::10]:52769)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cTtbU-00083A-09
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 12:00:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cTtbQ-00023n-UG
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 12:00:56 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58580)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1cTtbQ-00023D-OU
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 12:00:52 -0500
Date: Wed, 18 Jan 2017 15:00:49 -0200
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170118170049.GB3491@thinpad.lan.raisama.net>
References: <20170117010204.4909-1-ehabkost@redhat.com>
	<309bd499-204d-df07-aa99-9a999cfecabc@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <309bd499-204d-df07-aa99-9a999cfecabc@linux.vnet.ibm.com>
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
To: "Jason J. Herne" <jjherne@linux.vnet.ibm.com>
Cc: qemu-devel@nongnu.org, David Hildenbrand <david@redhat.com>, libvir-list@redhat.com, Markus Armbruster <armbru@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, Igor Mammedov <imammedo@redhat.com>, Jiri Denemark <jdenemar@redhat.com>, Richard Henderson <rth@twiddle.net>

On Tue, Jan 17, 2017 at 10:22:10AM -0500, Jason J. Herne wrote:
> On 01/16/2017 08:01 PM, Eduardo Habkost wrote:
> > This is a follow-up to the series that implements
> > query-cpu-model-expansion. Before including the test script, the
> > series has some fixes to allow the results of
> > query-cpu-model-expansion to be used in the QEMU command-line.
> > 
> > The script probably will work on s390x too, but I couldn't test
> > it yet.
> > 
> 
> Eduardo,
> 
> This test seems to mostly work on s390. The only issue I ran into is
> querying host model using tcg only. s390 requires kvm to query the host
> model. Perhaps we could just skip the tcg host test case on s390?

We could still try to test "host", but add it to a greylist where
errors returned by query-cpu-model-expansion can be non-fatal.
query-cpu-model-expansion model="host" can also fail with KVM if
the host doesn't support CPU models.

> 
> 
> hernejj: ['/usr/local/bin/qemu-system-s390x', '-chardev',
> 'socket,id=mon,path=/var/tmp/qom-fetch-monitor.sock', '-mon',
> 'chardev=mon,mode=control', '-display', 'none', '-vga', 'none', '-qtest',
> 'unix:path=/var/tmp/qom-fetch-qtest.sock', '-qtest-log', '/dev/null',
> '-machine', 'accel=qtest', '-machine', 'accel=tcg', '-S', '-cpu', 'host']
> qemu-system-s390x: CPU definition requires KVM
> E
> ======================================================================
> ERROR: testTCGModels (__main__.CPUModelTest)
> ----------------------------------------------------------------------
> Traceback (most recent call last):
>   File "./query-cpu-model-test.py", line 380, in testTCGModels
>     self.checkAllCPUModels()
>   File "./query-cpu-model-test.py", line 375, in checkAllCPUModels
>     self.checkOneCPUModel(m)
>   File "./query-cpu-model-test.py", line 304, in checkOneCPUModel
>     self.checkExpansions(model, msg)
>   File "./query-cpu-model-test.py", line 221, in checkExpansions
>     '%s.static' % (msg))
>   File "./query-cpu-model-test.py", line 177, in checkOneExpansion
>     type=type, model=model['model'])
>   File "./../scripts/qemu.py", line 185, in command
>     raise Exception(reply["error"]["desc"])
> Exception: The CPU definition 'host' requires KVM
> 
> ----------------------------------------------------------------------
> Ran 2 tests in 74.622s
> 
> 
> -- 
> -- Jason J. Herne (jjherne@linux.vnet.ibm.com)
> 

-- 
Eduardo
