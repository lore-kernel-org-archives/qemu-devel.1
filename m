Received: from eggs.gnu.org ([2001:4830:134:3::10]:34344)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1epH3U-0007O8-Qn
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 12:22:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1epH3R-0000CU-Mm
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 12:22:44 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:58220 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1epH3R-0000CB-HX
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 12:22:41 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <20180211093607.27351-1-armbru@redhat.com>
	<20180211093607.27351-11-armbru@redhat.com>
	<e989b2d3-cb5f-d378-763f-560174772b5b@redhat.com>
	<CAMxuvawNSxW9F84jZoAn2-Zxor_fK8P2s0ZksuTSCZWH1Vu1Og@mail.gmail.com>
Date: Fri, 23 Feb 2018 18:22:38 +0100
In-Reply-To: <CAMxuvawNSxW9F84jZoAn2-Zxor_fK8P2s0ZksuTSCZWH1Vu1Og@mail.gmail.com>
	(Marc-Andre Lureau's message of "Tue, 13 Feb 2018 16:22:30 +0100")
Message-ID: <87606nlixt.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v2 10/29] qapi: Touch generated files only
 when they change
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Marc-Andre Lureau <mlureau@redhat.com>
Cc: Eric Blake <eblake@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, marcandre <marcandre.lureau@redhat.com>, qemu-devel <qemu-devel@nongnu.org>

Marc-Andre Lureau <mlureau@redhat.com> writes:

> Hi
>
> On Mon, Feb 12, 2018 at 8:48 PM, Eric Blake <eblake@redhat.com> wrote:
>> On 02/11/2018 03:35 AM, Markus Armbruster wrote:
>>>
>>> A massive number of objects depends on QAPI-generated headers.  In my
>>> "build everything" tree, it's roughly 4800 out of 5100.  This is
>>> particularly annoying when only some of the generated files change,
>>> say for a doc fix.
>>>
>>> Improve qapi-gen.py to touch its output files only if they actually
>>> change.  Rebuild time for a QAPI doc fix drops from many minutes to a
>>> few seconds.  Rebuilds get faster for certain code changes, too.  For
>>> instance, adding a simple QMP event now recompiles less than 200
>>> instead of 4800 objects.  But adding a QAPI type is as bad as ever;
>>> we've clearly got more work to do.
>>>
>>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>>> Reviewed-by: Eric Blake <eblake@redhat.com>
>>> ---
>>>   scripts/qapi/common.py | 11 +++++++++--
>>>   1 file changed, 9 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/scripts/qapi/common.py b/scripts/qapi/common.py
>>> index 8290795dc1..2e58573a39 100644
>>> --- a/scripts/qapi/common.py
>>> +++ b/scripts/qapi/common.py
>>> @@ -1951,9 +1951,16 @@ class QAPIGen(object):
>>>               except os.error as e:
>>>                   if e.errno != errno.EEXIST:
>>>                       raise
>>> -        f = open(os.path.join(output_dir, fname), 'w')
>>> -        f.write(self._top(fname) + self._preamble + self._body
>>> +        fd = os.open(os.path.join(output_dir, fname),
>>> +                     os.O_RDWR | os.O_CREAT, 0666)
>>
>>
>> patchew complained here for mingw; I'm not sure why.
>
> python3 syntax error.
> https://stackoverflow.com/questions/1837874/invalid-token-when-using-octal-numbers

Yes, we need to spell the mode 0o666.
