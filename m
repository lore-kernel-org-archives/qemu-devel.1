Received: from eggs.gnu.org ([2001:4830:134:3::10]:44212)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1e4rNh-0004KL-0c
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 12:39:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1e4rNg-0004Nk-5H
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 12:39:45 -0400
References: <cover.1508257445.git.jcody@redhat.com>
	<503559b438cd67b865d32d7d0577afc7ee15f32c.1508257445.git.jcody@redhat.com>
	<2de32e52-2c2a-5738-4624-d84bf7379c5f@redhat.com>
	<20171018150352.GE17962@localhost.localdomain>
	<d3682b70-64c6-1284-77c4-8df561a61098@redhat.com>
	<20171018153416.GF17962@localhost.localdomain>
	<07a69c86-aae3-9174-b646-dee04bf191de@redhat.com>
	<20171018155038.GG17962@localhost.localdomain>
	<f5da8290-096d-36b5-28c5-ecfeb66199af@redhat.com>
	<20171018161935.GH17962@localhost.localdomain>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <d6b6250f-4215-adfa-f09a-e35360f04597@redhat.com>
Date: Wed, 18 Oct 2017 18:39:26 +0200
MIME-Version: 1.0
In-Reply-To: <20171018161935.GH17962@localhost.localdomain>
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

On 18/10/2017 18:19, Jeff Cody wrote:
>>> Here is what we need from common.rc for this series:
>>>
>>> _rm_test_img
>>> _cleanup_nbd
>>> _cleanup_vxhs
>>> _cleanup_rbd
>>> _cleanup_sheepdog
>>> _cleanup_protocols
>>> _cleanup_test_img
>>>
>>> They all have a common theme (cleanup), so I could move them all to a
>>> common.cleanup (naming suggestion?) file (which would need to be incl=
uded by
>>> common.rc, as well).
>>>
>>> Would this be a strong enough delineation to overcome your concerns?
>>
>> A great start.  Which of these are actually needed by the tests (and
>> hence by common.rc) and why?
>
>  Some tests are written such that they do intermediate cleanups between
>  multiple internal sub-tests for varying reasons, and so use those clea=
nup
>  functions as part of their testing.  The function _cleanup_test_img
>  effectively calls all the other functions I listed, so they are really=
 all
>  required for the tests, if they choose to call _cleanup_test_img.
>=20
> And for 'check' to tear everything down to a clean state, it also needs=
 to
> use the cleanup functions for everything that is not just a file/direct=
ory.

Do these tests really need the "cleanup protocols" part, because the few
that have more than one _cleanup_test_img (059, 066, 070, 084, 146, 171)
are either file-only or non-raw, so they should be able to just rebuild
the format on top of the same image.

Maybe that's where the separation lies---protocol vs. format, where
cleaning up the "file" protocol need not do anything because it's done
when removing the test directory.  If that's the case, it'd be nice
because it might also make it much easier to tackle the issue with
parallel tests.

Paolo
