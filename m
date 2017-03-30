Received: from eggs.gnu.org ([2001:4830:134:3::10]:59712)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ctbHS-00023a-NN
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 10:42:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ctbHR-0000Dr-QR
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 10:42:30 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <1490805920-17029-1-git-send-email-armbru@redhat.com>
	<1490805920-17029-5-git-send-email-armbru@redhat.com>
	<5e1790e7-5e12-adc6-a049-ca004682025d@redhat.com>
	<87fuhvfe96.fsf@dusky.pond.sub.org>
	<2e07453b-4d48-3acb-91bd-526de637c5c2@redhat.com>
Date: Thu, 30 Mar 2017 16:42:22 +0200
In-Reply-To: <2e07453b-4d48-3acb-91bd-526de637c5c2@redhat.com> (Eric Blake's
	message of "Thu, 30 Mar 2017 08:09:33 -0500")
Message-ID: <871ste4yi9.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [for-2.9 4/8] block: Document -drive problematic
 code and bugs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Max Reitz <mreitz@redhat.com>, kwolf@redhat.com, qemu-block@nongnu.org, mitake.hitoshi@lab.ntt.co.jp, jcody@redhat.com, qemu-devel@nongnu.org, pbonzini@redhat.com, namei.unix@gmail.com

Eric Blake <eblake@redhat.com> writes:

> On 03/30/2017 01:52 AM, Markus Armbruster wrote:
>
>>>> +++ b/block.c
>>>> @@ -1157,6 +1157,12 @@ static int bdrv_open_common(BlockDriverState *bs, BlockBackend *file,
>>>>      if (file != NULL) {
>>>>          filename = blk_bs(file)->filename;
>>>>      } else {
>>>> +       /*
>>>> +        * Caution: direct use of non-string @options members is
>>>> +        * problematic.  When they come from -blockdev or blockdev_add,
>>>> +        * members are typed according to the QAPI schema, but when
>>>> +        * they come from -drive, they're all QString.
>>>> +        */
>>>>          filename = qdict_get_try_str(options, "filename");
>>>
>>> For instance this one: Well, yes, for -drive, this will always be a
>>> QString. Which is OK, because that's what we're trying to get.
>>>
>>> The comment makes this confusing, IMO. If you really want a comment here
>>> it should at least contain a mention that it's totally fine in practice
>>> here. Calling the code "problematic" sounds like this could blow up when
>>> it reality it can't; and I would think it actually is the most sane
>>> solution given the current state of the whole infrastructure (i.e. how
>>> -drive and -blockdev work).
>> 
>> Well, if it could blow up, I'd call it wrong, and start the comment with
>> FIXME :)
>> 
>> Even though qdict_get_try_str() is indeed fine, I propose to have a
>> comment, because someone with less detailed understanding of how the
>> configuration machine works (me, until yesterday, and probably again
>> after next month) could conclude that qdict_get_try_bool() would be just
>> as fine.
>> 
>> What about:
>> 
>>    /*
>>     * Caution: while qdict_get_try_str() is fine, getting non-string
>>     * types would require more care.  When @options come from -blockdev
>>     * or blockdev_add, its members are typed according to the QAPI
>>     * schema, but when they come from -drive, they're all QString.
>>     */
>
> Yes, that's better - it makes it obvious that our current usage works,
> but that the code must not be carelessly edited if we add another field
> in the future.

If Max is also happy with it, I'll put it in v3.
