Received: from eggs.gnu.org ([2001:4830:134:3::10]:39516)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1chVqr-0003Lb-33
	for qemu-devel@nongnu.org; Sat, 25 Feb 2017 01:29:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1chVqq-0004Xw-0S
	for qemu-devel@nongnu.org; Sat, 25 Feb 2017 01:29:05 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <1487710908-26356-1-git-send-email-armbru@redhat.com>
	<1487710908-26356-3-git-send-email-armbru@redhat.com>
	<5f90e39c-e4ea-8638-d057-25eff232ad3d@redhat.com>
	<878toxmeol.fsf@dusky.pond.sub.org>
	<877f4g2f6m.fsf@dusky.pond.sub.org>
	<c00ea08f-f596-6e3e-4084-7f183c92a04d@redhat.com>
	<87h93j2ytj.fsf@dusky.pond.sub.org>
	<86ea8b80-f2ae-088f-ae2d-cf529d2db02b@redhat.com>
	<87r32nxrzm.fsf@dusky.pond.sub.org>
	<420c2df1-5bb9-29dc-ed0f-707e8985b4f3@redhat.com>
	<7030cab7-202d-15bc-dcdc-2710c7ebb4eb@redhat.com>
Date: Sat, 25 Feb 2017 07:28:54 +0100
In-Reply-To: <7030cab7-202d-15bc-dcdc-2710c7ebb4eb@redhat.com> (Eric Blake's
	message of "Fri, 24 Feb 2017 15:27:46 -0600")
Message-ID: <87d1e6vl5l.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH RFC v3 2/5] keyval: New keyval_parse()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: kwolf@redhat.com, pkrempa@redhat.com, qemu-devel@nongnu.org, qemu-block@nongnu.org

Eric Blake <eblake@redhat.com> writes:

> On 02/24/2017 03:06 PM, Eric Blake wrote:
>
>> On 02/24/2017 02:18 PM, Markus Armbruster wrote:
>>>> I have a preference for option 1 in the long run, but as it seems to be
>>>> upwards compatible from option 2 for -blockdev in 2.9, I'm leaning
>>>> towards option 2 for this release.
>>> 
>>> Let me rename the options:
>>> 
>>> * "no sugar -blockdev": both "FOO" and "noFOO" are rejected.
>>> 
>>> * "positive sugar blockdev": "FOO" is desugared to "FOO=on", "noFOO" to
>>>   "noFOO=on".
>>> 
>>> Which one do you prefer for 2.9?
>>
>> My current leanings:
>>
>> For 2.9: keyval_parse() should have no sugar.  Both "FOO" and "noFOO"
>> are rejected; an '=' must be present except for an implicit key -
>> although if -blockdev is the only client of keyval_parse(), then it's a
>> tossup whether we want to use it with an implicit key.

I agree on not doing implicit values for 2.9.  We have some thinking to
do on "noFOO", and having keyval_parse() support just "FOO" now could
backfire, as explained upthread.

Regarding implicit keys: I think we can just as well have them.  We're
not going to get rid of existing implicit keys.  Since keyval_parse()
has the code for supporting them already, we can just as well keep it.

>> Also for 2.9: turn on the deprecation warning for QemuOpts negative
>> sugar, but leave positive sugar unchanged (it seems like positive sugar
>> is probably more in use than negative sugar, other than chardev nowait).
>
> Capturing the gist of an IRC conversation:
>
> Right now, it appears that '-chardev nowait' is in heavy use ('git grep
> nowait' shows that qemu itself recommends it in documentation, nodelay
> being another one).  Right now, QemuOpts says that '-chardev
> wait,nowait' results in 'wait=off', and '-chardev nowait,wait' results
> in 'wait=on' (that is, last-one-wins semantics) - but in reality, there
> are probably few (if any) clients that rely on this particular semantics.
>
> If we get rid of 'noFOO' magic, we can still teach the chardev QemuOpts
> to recognize optional keys for BOTH 'wait' and 'nowait'; a user that
> specifies neither gets the default behavior as always; a user that
> specifies only 'wait' or 'nowait' gets the requested behavior (although
> now chardev has to check both key spellings rather than one), and a user
> that specifies 'wait,nowait' or 'nowait,wait' causes an error, not at
> QemuOpts parse time, but in the chardev initialization code.  That is,
> for any boolean option where 'noFOO' magic is currently handled by
> QemuOpts, we can still mostly keep back-compat by adding a new 'noFOO'
> key to the object, and teaching that object to check that 'FOO' and
> 'noFOO' are not both selected at once.

Another possibility is to start with deprecating "noFOO" only when we
don't have description for "FOO".

Hmm, could just as well also deprecate it when we do have one, but it
isn't QEMU_OPT_BOOL.

> But whether this change to QemuOpts is the right thing to do is not 2.9
> material, so let's take a breather and revisit it for 2.10 (or whenever
> we try to fix QemuOpts to layer on top of keyval_parse()).

Makes sense.

>> That way, we still have the option of enabling positive sugar blockdev
>> in a later version, if we decide its useful (and after dealing with any
>> QemuOpts fallout), but are not locked into having to use it.

Exactly.
