Received: from eggs.gnu.org ([2001:4830:134:3::10]:47314)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1e5HyT-0003La-Ew
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 17:03:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1e5HyS-0004MQ-9I
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 17:03:29 -0400
References: <20171018150352.GE17962@localhost.localdomain>
	<d3682b70-64c6-1284-77c4-8df561a61098@redhat.com>
	<20171018153416.GF17962@localhost.localdomain>
	<07a69c86-aae3-9174-b646-dee04bf191de@redhat.com>
	<20171018155038.GG17962@localhost.localdomain>
	<f5da8290-096d-36b5-28c5-ecfeb66199af@redhat.com>
	<20171018161935.GH17962@localhost.localdomain>
	<d6b6250f-4215-adfa-f09a-e35360f04597@redhat.com>
	<20171018172744.GI17962@localhost.localdomain>
	<eb4560ed-9b2f-bab0-9b0a-d2e0b1c9137c@redhat.com>
	<20171019145240.GJ17962@localhost.localdomain>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <3a5ee63c-9fd6-4223-4510-48b896a37419@redhat.com>
Date: Thu, 19 Oct 2017 23:03:12 +0200
MIME-Version: 1.0
In-Reply-To: <20171019145240.GJ17962@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v5 03/10] qemu-iotests: automatically clean
 up bash protocol servers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jeff Cody <jcody@redhat.com>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, jsnow@redhat.com, stefanha@redhat.com, qemu-block@nongnu.org

On 19/10/2017 16:52, Jeff Cody wrote:
> On Thu, Oct 19, 2017 at 12:23:39PM +0200, Paolo Bonzini wrote:
>> On 18/10/2017 19:27, Jeff Cody wrote:
>>> On final exit, yes, a test needs not remember to remove all of its mo=
use
>>> droppings.  But as far as not needing to remove images in intermediat=
e
>>> stages of a given test, I think that assumes too much. For instance,
>>> qemu-img _should_ be able to rebuild a format on top of the same imag=
e.  But
>>> maybe a test wants to see if that specific functionality actually wor=
ks as
>>> intended, and compares removing and creating an image to rebuilding o=
n top
>>> of an image, etc.
>>
>> Right, but let's draw a line, does such a test need to support multipl=
e
>> protocols?  For example:
>>
> This is a good question.  But, I'm not sure that this is a question thi=
s
> series is trying to answer; one goal of this series is to keep the exis=
ting
> APIs currently in use by tests unchanged.

Right, but in order to do so it's also making the line between test and
harness unclear, which is something I'd like to avoid (when I looked at
it a couple months ago, the line was surprisingly clear apart from some
confusion around searching for programs, and separating check vs.
common.rc turned out to be very easy).

>> [snip] So, this is why I was wondering whether patches 3/4 kinda paint
>> ourselves in the corner.
>=20
> I think this conflates a bit how we'd like to restructure tests in a fu=
ture
> harness rewrite, and what this series does.

This is true.  But this sure is not exactly keeping the test APIs
intact.  The APIs are intact, but the usage isn't---for example, for
patch 9 to work you need to _not_ use _cleanup_test_img in the tests.

> If we look at what patches 3 & 4 do:
>=20
> Patch 3:
>=20
>     - Code movement within common.rc, but doesn't change the API.  Test=
s
>       still just call _cleanup_test_img() as needed.
>=20
>     - It does break apart _cleanup_test_img(), thereby technically crea=
ting
>       some new APIs available to future tests:
>          * _cleanup_nbd()
>          * _cleanup_vxhs()
>          * _cleanup_rbd()
>          * _cleanup_sheepdog()
>          * _cleanup_protocols()
>=20
>       Maybe these new APIs are a sticking point?  If so, perhaps we can=
 mark
>       them (via comments) as internal-only?
>=20
>     - ./check does an extra protocol cleanup check after a test is run,=
 via
>       the new _cleanup_protocols().
>=20
>     As far as existing tests go, no changes yet.

Here I'd like to remove _cleanup_test_img as a test API even.  Most
invocations out of the "trap" are unnecessary.  Some (for VMDK) can be
changed to _rm_test_img or changed to create a file with a new name (to
make patch 9 more effective).

With that change, we can apply patch 4 with no issue.

> Patch 4:
>=20
>     - Removes test exit cleanup from tests
>=20
>     Now this does change test behavior, as it relies on the harness for=
 file
>     and protocol cleanup at test exit.
>=20
>     This will indeed paint us in a corner if we want a new check.py to =
not
>     perform the test exit cleanup, and leave test cleanup (either parti=
ally
>     or fully) as the responsibility for the tests. [1]

I think patch 9 is enough proof that check should perform the test exit
cleanup.

But again, the thing I'm worried about is mixing code between check and
tests.

>> So, looking at the patches:
>>
>> - 1, 2, 7, 8, 9 are definitely good ideas, and should be done _before_
>> an eventual/hypothetical Python rewrite of "check".
>=20
> Alas, 9 requires 4 (which in turn requires 3).  Without 4, there is not=
hing
> to keep, as the tests try to remove it all.
>=20
>> - for 5, 6 I think we should be using shell job control instead in
>> "check" ('set -m')
>>
>>   #! /bin/sh
>>   set -m
>>   # Start a job which leaves two processes behind.  By starting it
>>   # in the background, we can get the leader process's pid in $!
>>   # That pid is also the process group id of the whole job.
>>   sh -c 'echo subshell pid is $$; sleep 10 | sleep 15 &' &
>>   pgrp=3D$!
>>   wait
>>   echo '$! is '$pgrp', killing all processes in that group:'
>>   pgrep -g $pgrp -a
>>   kill -TERM -$pgrp
>>   sleep 1
>>   echo Leftover processes have been killed:
>>   ps axo pid,ppid,pgrp,stat,tty,comm|grep sleep
>>
>=20
> Existing tests right now use _cleanup_qemu in their tests (outside of f=
inal
> cleanup): 095 109 117 130, etc.  So we can do process control different=
ly,
> but _cleanup_qemu still needs to exist and also clean up other files (s=
uch
> as fifos, close fds, etc..), and provide the same functionality (option=
al
> wait-for-completion, etc.), if we are keeping the usage by tests the sa=
me.

Yes, _cleanup_qemu can stay in the tests.

> [1] So on that point: do you think individual tests should be responsib=
le
> for cleaning up files and processes at test exit?  If that answer is a =
'yes'
> to either files or processes, then 3, 4, 6 (and maybe 9) are incompatib=
le
> with a future redesign with that assumption.  FWIW, my thought is that =
the
> answer should be "the harness shall perform both file and process clean=
up on
> test exit".

I definitely agree on that, but I that the harness can be a little less
refined: kill the whole process group and rm -rf the whole test
directory.  Protocols may need a little bit of refinement, but
everything else should use OS services and ignore the QEMUness of
qemu-iotests (and especially the fact that tests are shell scripts).

Paolo
