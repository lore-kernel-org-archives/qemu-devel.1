Received: from eggs.gnu.org ([2001:4830:134:3::10]:39342)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cxrUd-0004yN-BE
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 04:49:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cxrUc-0002Xa-Gd
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 04:49:43 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20170118161653.19296-1-eblake@redhat.com>
	<20170118161653.19296-5-eblake@redhat.com>
	<87h94vflc6.fsf@dusky.pond.sub.org>
	<8999bd18-6f17-c15f-65a4-221475088ec8@redhat.com>
	<8ae60273-e215-7b08-c5b1-bb1132b86312@redhat.com>
Date: Tue, 11 Apr 2017 10:49:31 +0200
In-Reply-To: <8ae60273-e215-7b08-c5b1-bb1132b86312@redhat.com> (Eric Blake's
	message of "Tue, 4 Apr 2017 21:10:25 -0500")
Message-ID: <8737dfe3c4.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v2 4/6] fdc-test: Avoid deprecated 'change'
 command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org, "open list:Floppy" <qemu-block@nongnu.org>, Kevin Wolf <kwolf@redhat.com>

Eric Blake <eblake@redhat.com> writes:

> On 01/19/2017 08:39 AM, Eric Blake wrote:
>> On 01/19/2017 03:30 AM, Markus Armbruster wrote:
>>> Eric Blake <eblake@redhat.com> writes:
>>>
>>>> Use the preferred blockdev-change-medium command instead.
>>>>
>>>> Signed-off-by: Eric Blake <eblake@redhat.com>
>>>> Reviewed-by: John Snow <jsnow@redhat.com>
>>>> ---
>>>>  tests/fdc-test.c | 5 +++--
>>>>  1 file changed, 3 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/tests/fdc-test.c b/tests/fdc-test.c
>>>> index 738c6b4..f5ff68d 100644
>>>> --- a/tests/fdc-test.c
>>>> +++ b/tests/fdc-test.c
>>>> @@ -298,8 +298,9 @@ static void test_media_insert(void)
>>>>
>>>>      /* Insert media in drive. DSKCHK should not be reset until a step pulse
>>>>       * is sent. */
>>>> -    qmp_discard_response("{'execute':'change', 'arguments':{"
>>>> -                         " 'device':'floppy0', 'target': %s, 'arg': 'raw' }}",
>>>> +    qmp_discard_response("{'execute':'blockdev-change-medium', 'arguments':{"
>>>> +                         " 'device':'floppy0', 'filename': %s, "
>>>> +                         "'format': 'raw' }}",
>>>>                           test_image);
>>>>
>>>>      dir = inb(FLOPPY_BASE + reg_dir);
>>>
>>> 'device' is deprecated.  Can we use 'id' here?
>> 
>> I'll give it a shot.
>
> Harder than I thought. Search for 'floppy0' in tests/ - you'll notice
> that nothing explicitly sets that device name, which means I don't know
> where to inject an explicit 'id' counterpart name to use instead (we are
> inheriting the default device name that you get when starting an x86
> board without -nodefaults).  Maybe someone else can supply an idea?

Kevin, John?
