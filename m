Received: from eggs.gnu.org ([2001:4830:134:3::10]:50264)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1e4q5h-00023g-3n
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 11:17:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1e4q5g-0005Po-0a
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 11:17:05 -0400
References: <cover.1508257445.git.jcody@redhat.com>
	<503559b438cd67b865d32d7d0577afc7ee15f32c.1508257445.git.jcody@redhat.com>
	<2de32e52-2c2a-5738-4624-d84bf7379c5f@redhat.com>
	<20171018150352.GE17962@localhost.localdomain>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <d3682b70-64c6-1284-77c4-8df561a61098@redhat.com>
Date: Wed, 18 Oct 2017 17:16:44 +0200
MIME-Version: 1.0
In-Reply-To: <20171018150352.GE17962@localhost.localdomain>
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

On 18/10/2017 17:03, Jeff Cody wrote:
> On Wed, Oct 18, 2017 at 04:46:20PM +0200, Paolo Bonzini wrote:
>> On 17/10/2017 18:31, Jeff Cody wrote:
>>>              )
>>>          else
>>> +            # Do this in a sub-shell, so we are operating on the rig=
ht
>>> +            # TEST_DIR / QEMU_TEST_DIR
>>>              (
>>>              export TEST_DIR=3D$TEST_DIR_SEQ
>>>              cd "$source_iotests";
>> Where is the missing ")"?
> It's part of the diff context, not a change itself... it's still there,=
 just
> not shown in the patch.
>=20
>>> @@ -837,6 +841,15 @@ do
>>>              fi
>>>          fi
>>> =20
>>> +        # Do this in a sub-shell, so we are operating on the right
>>> +        # TEST_DIR / QEMU_TEST_DIR
>>> +        (
>>> +        export TEST_DIR=3D$TEST_DIR_SEQ
>>> +        . "$source_iotests/common.config"
>>> +        . "$source_iotests/common.rc"
>>> +
>>> +        _cleanup_protocols
>> "check" wasn't including common.rc before this patch, and most of the
>> content of that file doesn't apply to "check".  So if we want to move
>> cleanup code to "check" we should remove it from common.rc too.
>>
>> In general, I think we should strive to have a better separation betwe=
en
>> tests and harness.  This for example could let us write a different
>> harness for the same tests and integrate the tests better into Avocado=
.
>> Hence I see one advantage and one disadvantage in your series:
>>
>> * by adding more functionality to "check", it shows that the current
>> separation may fail with a more sophisticated harness (such as the one
>> you are creating here)
>>
>> * it adds a lot more knowledge of QEMU (especially protocols) in
>> "check", but there is still some unbalance: tests create the images an=
d
>> the protocol servers, but the harness cleans it up.  The visible resul=
t
>> of this unbalance is for example how multi-process protocol tests can
>> fail when multiple tests try to bind the same address.
>>
>> I think it's the right direction, but it feels like it's not there
>> yet...  Sorry---I know this is not very constructive, but I hope it
>> helps anyway.
>>
>> Maybe we should actually rewrite "check" in Python.  That would force =
us
>> to think more about the design.
>
> I think writing a more sophisticated harness in another language, such =
as
> Python, has merit.  But to clarify, do you mean that as a 'nack' to thi=
s
> series, or as something to be done later, after this series?  If this s=
eries
> improves the existing harness, I don't see why to exclude it because a =
new

Well, I have no idea (hence the "not very constructive" part).  I'm only
"nacking" the sourcing of common.rc in the check script.

The series improves the harness, but it also sets a very different
separation between the tests and the harness (especially WRT the tests
cleaning up after themselves).  The level of separation would at least
be clearer if check didn't include common.rc.

Paolo
