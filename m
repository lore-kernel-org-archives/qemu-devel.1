Received: from eggs.gnu.org ([2001:4830:134:3::10]:48884)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1e57zY-0004dR-CU
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 06:23:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1e57zW-0006EB-MB
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 06:23:56 -0400
References: <503559b438cd67b865d32d7d0577afc7ee15f32c.1508257445.git.jcody@redhat.com>
	<2de32e52-2c2a-5738-4624-d84bf7379c5f@redhat.com>
	<20171018150352.GE17962@localhost.localdomain>
	<d3682b70-64c6-1284-77c4-8df561a61098@redhat.com>
	<20171018153416.GF17962@localhost.localdomain>
	<07a69c86-aae3-9174-b646-dee04bf191de@redhat.com>
	<20171018155038.GG17962@localhost.localdomain>
	<f5da8290-096d-36b5-28c5-ecfeb66199af@redhat.com>
	<20171018161935.GH17962@localhost.localdomain>
	<d6b6250f-4215-adfa-f09a-e35360f04597@redhat.com>
	<20171018172744.GI17962@localhost.localdomain>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <eb4560ed-9b2f-bab0-9b0a-d2e0b1c9137c@redhat.com>
Date: Thu, 19 Oct 2017 12:23:39 +0200
MIME-Version: 1.0
In-Reply-To: <20171018172744.GI17962@localhost.localdomain>
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

On 18/10/2017 19:27, Jeff Cody wrote:
> On Wed, Oct 18, 2017 at 06:39:26PM +0200, Paolo Bonzini wrote:
>> On 18/10/2017 18:19, Jeff Cody wrote:
>>>>> Here is what we need from common.rc for this series:
>>>>>
>>>>> _rm_test_img
>>>>> _cleanup_nbd
>>>>> _cleanup_vxhs
>>>>> _cleanup_rbd
>>>>> _cleanup_sheepdog
>>>>> _cleanup_protocols
>>>>> _cleanup_test_img
>>>>>
>>>>> They all have a common theme (cleanup), so I could move them all to=
 a
>>>>> common.cleanup (naming suggestion?) file (which would need to be in=
cluded by
>>>>> common.rc, as well).
>>>>>
>>>>> Would this be a strong enough delineation to overcome your concerns=
?
>>>>
>>>> A great start.  Which of these are actually needed by the tests (and
>>>> hence by common.rc) and why?
>>>
>>>  Some tests are written such that they do intermediate cleanups betwe=
en
>>>  multiple internal sub-tests for varying reasons, and so use those cl=
eanup
>>>  functions as part of their testing.  The function _cleanup_test_img
>>>  effectively calls all the other functions I listed, so they are real=
ly all
>>>  required for the tests, if they choose to call _cleanup_test_img.
>>>
>>> And for 'check' to tear everything down to a clean state, it also nee=
ds to
>>> use the cleanup functions for everything that is not just a file/dire=
ctory.
>>
>> Do these tests really need the "cleanup protocols" part, because the f=
ew
>> that have more than one _cleanup_test_img (059, 066, 070, 084, 146, 17=
1)
>> are either file-only or non-raw, so they should be able to just rebuil=
d
>> the format on top of the same image.
>>
>=20
> Maybe not, but that could just be the nature of what bugs we are testin=
g for
> at this time.  These specific tests may not need to, but it is not
> inconceivable to have a test that involves bringing up and tearing down
> a protocol based server some arbitrary number times, to test that speci=
fic
> behavior.

Right, but such a test should probably be protocol-specific; it can just
use "file" and invoke QEMU_NBD on its own for example, similar to what
tests 058 and 162 already do.

For example, it's very different if you delete and recreate a raw image
_and_ rerun qemu-nbd, or only do the latter.

>> Maybe that's where the separation lies---protocol vs. format, where
>> cleaning up the "file" protocol need not do anything because it's done
>> when removing the test directory.  If that's the case, it'd be nice
>> because it might also make it much easier to tackle the issue with
>> parallel tests.
>=20
> On final exit, yes, a test needs not remember to remove all of its mous=
e
> droppings.  But as far as not needing to remove images in intermediate
> stages of a given test, I think that assumes too much. For instance,
> qemu-img _should_ be able to rebuild a format on top of the same image.=
  But
> maybe a test wants to see if that specific functionality actually works=
 as
> intended, and compares removing and creating an image to rebuilding on =
top
> of an image, etc.

Right, but let's draw a line, does such a test need to support multiple
protocols?  For example:

- 083 and 143 for example are very much NBD-specific; 083 uses
"_supported_proto nbd", while 143 probably should be using either "file"
or "nbd".

- only 058 and 162 are running qemu-nbd manually, and they actually
start a _new_ NBD protocol server


In addition not many tests do not use _make_test_img, as seen with "git
grep -LE '_make_test_img|bin/env python' [0-9][0-9][0-9]".  They are:

- 064, 070 and 135 which use the sample image and thus _should_ be using
file

- 049, 082, 111 which is creating images with "qemu-img create"; 049 and
111 might actually use nfs too.  150 is using "qemu-img convert", which
is also creation more or less

- 083 is NBD-specific because it uses the fault injector

- 113 probably should be more generic than just NBD

- 128 is pretty unique in that it creates a Linux device mapper device (!=
)

- 143 probably should be using either "file" or "nbd".

- 162 is also a bit unique in that it tests null-co:// and disregards
IMGFMT/IMGPROTO


So it does seem that handling the protocol in "check" is a good
approximation.

And by the way, the only existing uses of "_supported_proto" are

    _supported_proto file
    _supported_proto file nfs
    _supported_proto file sheepdog rbd nfs
    _supported_proto generic
    _supported_proto nbd
    _supported_proto nfs

so another thing to do might be to change _supported_proto to a
feature-based test:

- file/sheepdog/rbd/nfs are those that support resizing (aka "truncate")

- file/nfs are generally those that support "qemu-img create" (plus
others that should be "generic" actually, including 090, 103, 107); 150
is "file" because it needs "map" in addition to "create".

- nfs is used in test 173 to test protocol-based images with relative
filename backing strings; it probably can run on file too, anyway that's
a third important discriminating feature

- nbd is used in a bunch of random tests that can be made more generic
(094, 113, 119, 123).  Only 083 is NBD-specific because it uses the NBD
fault injector, and it actually doesn't use the protocol that is created
by the caller.


Since you are doing a lot of whole-directory moves, "_supported" tags
could become a separate configuration file, e.g.

----
# all generic, no need to include it
#[001]

[025]
fmt=3Draw qcow2 qed
# specify feature
proto=3D+resize

[143]
fmt=3Dgeneric
proto=3Dnbd
start_protocol=3Dno

[150]
fmt=3Draw qcow2
proto=3D+create +map
----

The few tests using start_protocol=3Dno would have to ensure parallel-saf=
e
operation themselves.  This would also enable a more consistent handling
across shell and Python tests.

So, this is why I was wondering whether patches 3/4 kinda paint
ourselves in the corner.

So, looking at the patches:

- 1, 2, 7, 8, 9 are definitely good ideas, and should be done _before_
an eventual/hypothetical Python rewrite of "check".

- for 5, 6 I think we should be using shell job control instead in
"check" ('set -m')

  #! /bin/sh
  set -m
  # Start a job which leaves two processes behind.  By starting it
  # in the background, we can get the leader process's pid in $!
  # That pid is also the process group id of the whole job.
  sh -c 'echo subshell pid is $$; sleep 10 | sleep 15 &' &
  pgrp=3D$!
  wait
  echo '$! is '$pgrp', killing all processes in that group:'
  pgrep -g $pgrp -a
  kill -TERM -$pgrp
  sleep 1
  echo Leftover processes have been killed:
  ps axo pid,ppid,pgrp,stat,tty,comm|grep sleep

(Python can do the same by setting preexec_fn=3Dos.setpgrp when calling
Subprocess.popen; then you can kill the entire group with os.killpg)

- 10 depends on everything before. SAD! ;)

It's a pity to lose the cleanup in patch 4, but I think it's better in
the long term if we have a clear idea of the tests' tasks vs. the harness=
's.

Thanks,

Paolo
