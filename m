Received: from eggs.gnu.org ([2001:4830:134:3::10]:59569)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ej4p2-0008NY-Gz
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 10:06:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ej4ox-0005Nm-TM
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 10:06:12 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52070)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1ej4ox-0005NM-Mg
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 10:06:07 -0500
References: <20180202130336.24719-1-armbru@redhat.com>
	<20180202130336.24719-10-armbru@redhat.com>
	<1ec446ca-a469-7950-bea1-c832cbaf9fa3@redhat.com>
	<878tca4ez9.fsf@dusky.pond.sub.org>
	<13b80daf-db39-8183-2836-a13b2d4ef21b@redhat.com>
	<87607aftg8.fsf@dusky.pond.sub.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <69d92223-dcdd-0f2a-f155-f6cadd0441af@redhat.com>
Date: Tue, 6 Feb 2018 09:06:03 -0600
MIME-Version: 1.0
In-Reply-To: <87607aftg8.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH RFC 09/21] qapi: Don't absolutize include
 file name in error messages
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: marcandre.lureau@redhat.com, qemu-devel@nongnu.org, mdroth@linux.vnet.ibm.com

On 02/06/2018 01:49 AM, Markus Armbruster wrote:

>>> Probably not, as our make rule strips off $(SRC_PATH):
>>>
>>> 	@perl -p -e 's|\Q$(SRC_PATH)\E/||g' $*.test.err | diff -q $(SRC_PATH)/$*.err -
>>>
>>> I've kept that, because it might also occur in stack backtraces.  I
>>> think.

Ideally, we don't have any stack backtraces ;)  But we have indeed 
historically checked in .err files with a backtrace that a later patch 
in the series cleans up, so that part of the munging does indeed play a 
role in a clean 'make check' for documenting an expected weakness in the 
generator.

>>
>> I still recall having to hand-edit .err files when doing a naive "run
>> the test to get the failure, then 'mv' the bad files into the expected
>> filenames, then rerun the tests";
> 
> Whenever the Perl script does something, you can't simply move the
> .test.err to .err.  Annoying.

We could also munge the original output prior to creating .test.err; but 
that also has drawbacks if it eats something that would have been useful 
for debugging the test.

> 
> A make target check-accept could automate the work.

Yeah, but I'm not sure how often we'd need to invoke it, or even 
remember that it exists.  But it would at least avoid the issue of 
having to debug a munged .test.err.

> 
> However, with this patch, the Perl script should do something less
> often.  I guess that's your point.
> 
> Sorry for being slow on the update :)

No problem; I figure you've got a lot on your mind as you are trying to 
tie down loose ends before some much deserved time off.


-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
