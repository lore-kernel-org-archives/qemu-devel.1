Received: from eggs.gnu.org ([2001:4830:134:3::10]:59602)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1eiy16-0001mp-R6
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 02:50:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1eiy11-0001L4-3K
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 02:50:12 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39316)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1eiy10-0001JA-QW
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 02:50:06 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <20180202130336.24719-1-armbru@redhat.com>
	<20180202130336.24719-10-armbru@redhat.com>
	<1ec446ca-a469-7950-bea1-c832cbaf9fa3@redhat.com>
	<878tca4ez9.fsf@dusky.pond.sub.org>
	<13b80daf-db39-8183-2836-a13b2d4ef21b@redhat.com>
Date: Tue, 06 Feb 2018 08:49:59 +0100
In-Reply-To: <13b80daf-db39-8183-2836-a13b2d4ef21b@redhat.com> (Eric Blake's
	message of "Mon, 5 Feb 2018 09:55:54 -0600")
Message-ID: <87607aftg8.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
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
To: Eric Blake <eblake@redhat.com>
Cc: marcandre.lureau@redhat.com, qemu-devel@nongnu.org, mdroth@linux.vnet.ibm.com

Eric Blake <eblake@redhat.com> writes:

> On 02/03/2018 03:08 AM, Markus Armbruster wrote:
>> Eric Blake <eblake@redhat.com> writes:
>> 
>>> On 02/02/2018 07:03 AM, Markus Armbruster wrote:
>>>> Error messages print absolute filenames of included files even gave a
>>>
>>> s/even gave/even when given/
>> 
>> I meant to write "even if the user gave".  Is that okay?
>
> Yes, that works too.
>
>> 
>>>> relative one on the command line:
>>>>
>>>>      PYTHONPATH=scripts python -B tests/qapi-schema/test-qapi.py tests/qapi-schema/include-cycle.json
>>>>     In file included from tests/qapi-schema/include-cycle.json:1:
>>>>     In file included from /work/armbru/qemu/tests/qapi-schema/include-cycle-b.json:1:
>>>>     /work/armbru/qemu/tests/qapi-schema/include-cycle-c.json:1: Inclusion loop for include-cycle.json
>>>>
>>>> Improve this to
>>>>
>>>>     In file included from tests/qapi-schema/include-cycle.json:1:
>>>>     In file included from tests/qapi-schema/include-cycle-b.json:1:
>>>>     tests/qapi-schema/include-cycle-c.json:1: Inclusion loop for include-cycle.json
>>>
>>> Nice, and makes developing new qapi tests a little less painful since
>>> it's less modification to qapi-schema/*.err additions.
>> 
>> Probably not, as our make rule strips off $(SRC_PATH):
>> 
>> 	@perl -p -e 's|\Q$(SRC_PATH)\E/||g' $*.test.err | diff -q $(SRC_PATH)/$*.err -
>> 
>> I've kept that, because it might also occur in stack backtraces.  I
>> think.
>
> I still recall having to hand-edit .err files when doing a naive "run
> the test to get the failure, then 'mv' the bad files into the expected
> filenames, then rerun the tests";

Whenever the Perl script does something, you can't simply move the
.test.err to .err.  Annoying.

A make target check-accept could automate the work.

However, with this patch, the Perl script should do something less
often.  I guess that's your point.

Sorry for being slow on the update :)

>                                   so I'm not sure if our make rule was
> properly munging absolute names out of the file in the first place.  I'm
> not too fussed about it, though, as adding new tests is less frequent
> and it's still fairly easy to learn if you did it right or not by
> whether 'make check' succeeds.
>
>>>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>>>> ---
>>>>  scripts/qapi/common.py                | 12 ++++++------
>>>>  tests/qapi-schema/include-no-file.err |  2 +-
>>>>  2 files changed, 7 insertions(+), 7 deletions(-)
>>>>
>>>
>>> Reviewed-by: Eric Blake <eblake@redhat.com>
>> 
>> Thanks!
>> 
