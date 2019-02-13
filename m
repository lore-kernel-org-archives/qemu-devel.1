Received: from eggs.gnu.org ([209.51.188.92]:42974)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=94072d1a0=marcolso@amazon.com>)
	id 1gu1Sx-0007v2-PT
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 15:49:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=94072d1a0=marcolso@amazon.com>)
	id 1gu1Sw-0004x4-FK
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 15:49:11 -0500
References: <1542006398-30037-1-git-send-email-marcolso@amazon.com>
	<1542006398-30037-3-git-send-email-marcolso@amazon.com>
	<72fed418-fb20-28cd-aa34-e1df84a9cba4@redhat.com>
	<13cbaa71-82ac-e142-945f-4ece8e3093f6@amazon.com>
	<8a51bd30-40c2-e367-208f-df0f2d225d0f@redhat.com>
From: Marc Olson <marcolso@amazon.com>
Message-ID: <c2965971-4e19-8d68-d57a-6ee28ecfe22e@amazon.com>
Date: Wed, 13 Feb 2019 12:49:00 -0800
MIME-Version: 1.0
In-Reply-To: <8a51bd30-40c2-e367-208f-df0f2d225d0f@redhat.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH v3 3/3] blkdebug: Add latency injection
 rule type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org
Cc: jsnow@redhat.com, qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>

On 2/13/19 7:48 AM, Max Reitz wrote:
> On 12.02.19 22:21, Marc Olson wrote:
>> On 1/11/19 7:00 AM, Max Reitz wrote:
>>> On 12.11.18 08:06, Marc Olson wrote:
> [...]
>
>>>> diff --git a/qapi/block-core.json b/qapi/block-core.json
>>>> index d4fe710..72f7861 100644
>>>> --- a/qapi/block-core.json
>>>> +++ b/qapi/block-core.json
>>>> @@ -3057,6 +3057,34 @@
>>>>                '*immediately': 'bool' } }
>>>>      ##
>>>> +# @BlkdebugDelayOptions:
>>>> +#
>>>> +# Describes a single latency injection for blkdebug.
>>>> +#
>>>> +# @event:       trigger event
>>>> +#
>>>> +# @state:       the state identifier blkdebug needs to be in to
>>>> +#               actually trigger the event; defaults to "any"
>>>> +#
>>>> +# @latency:     The delay to add to an I/O, in microseconds.
>>>> +#
>>>> +# @sector:      specifies the sector index which has to be affected
>>>> +#               in order to actually trigger the event; defaults to
>>>> "any
>>>> +#               sector"
>>>> +#
>>>> +# @once:        disables further events after this one has been
>>>> +#               triggered; defaults to false
>>>> +#
>>>> +# Since: 3.1
>>> Well, 4.0 now, sorry...
>> Baking version numbers into code is downright silly. Every single
>> version of this patch has made a comment along the lines of, "oops, it
>> didn't get reviewed in time for the next version bump, so you have to
>> resubmit." With a fast moving project, this is nonsense. If you're
>> looking at the code, you should have access to the git history as well
>> to determine the version.
> True, but these comments are used to generate documentation (e.g.
> docs/interopt/qemu-qmp-ref.7 in the build directory).  So they are used
> by people who don't have access to the git history.
>
> It might be possible to generate that information from git-blame when
> generating the documentation, but how would trivial fixes be handled
> that are no functional changes?  For instance, it seems difficult to me
> to distinguish between a spelling change for some parameter description
> and a change in behavior.
>
> (Then again, we shouldn't have such behavioral changes, hm.)
>
> To me personally, the easiest thing would seem to be some convention to
> write ***INSERT VERSION HERE*** into the code and then the maintainer
> can just find an replace all instances of that when applying the
> patches.  But that sounds a bit silly...
>
> (I don't have an issue with adjusting the version numbers myself as they
> are, but it's just as hard for me to find and replace all of them as it
> is for you.  And since you're probably going to send a v4 anyway...)
>
> In the end, it's up to the QAPI maintainers.

IFF I submit by the end of the week, what version number shall I choose?


> [...]
>
>>>> diff --git a/tests/qemu-iotests/071 b/tests/qemu-iotests/071
>>>> index 48b4955..976f747 100755
>>>> --- a/tests/qemu-iotests/071
>>>> +++ b/tests/qemu-iotests/071
>>>> @@ -100,6 +100,69 @@ $QEMU_IO -c "open -o
>>>> driver=$IMGFMT,file.driver=blkdebug,file.inject-error.event
>>>>             -c 'read -P 42 0x38000 512'
>>>>      echo
>>>> +echo "=== Testing blkdebug latency through filename ==="
>>>> +echo
>>>> +
>>>> +$QEMU_IO -c "open -o
>>>> file.driver=blkdebug,file.inject-delay.event=write_aio,file.inject-delay.latency=10000
>>>> $TEST_IMG" \
>>>> +         -c 'aio_write -P 42 0x28000 512' \
>>>> +         -c 'aio_read -P 42 0x38000 512' \
>>>> +         | _filter_qemu_io
>>>> +
>>>> +echo
>>>> +echo "=== Testing blkdebug latency through file blockref ==="
>>>> +echo
>>>> +
>>>> +$QEMU_IO -c "open -o
>>>> driver=$IMGFMT,file.driver=blkdebug,file.inject-delay.event=write_aio,file.inject-delay.latency=10000,file.image.filename=$TEST_IMG"
>>>> \
>>>> +         -c 'aio_write -P 42 0x28000 512' \
>>>> +         -c 'aio_read -P 42 0x38000 512' \
>>>> +         | _filter_qemu_io
>>>> +
>>>> +# Using QMP is synchronous by default, so even though we would
>>>> +# expect reordering due to using the aio_* commands, they are
>>>> +# not. The purpose of this test is to verify that the driver
>>>> +# can be setup via QMP, and IO can complete. See the qemu-io
>>>> +# test above to prove delay functionality
>>> But it doesn't prove that because the output is filtered.  To prove it,
>>> you'd probably need to use null-co as the protocol (so there is as
>>> little noise as possible) and then parse the qemu-io output to show that
>>> the time is always above 10 ms.
>>>
>>> I leave it to you whether you'd like to go through that pain.
>> There's not a great way to prove it without doing a lot of parsing
>> changes in testing. I'll consider an update to this patch, but I think
>> this series has carried on long enough.
> I agree in this instance, but I'd like to note still that "this series
> has carried on long enough" is not an argument to merge bad code (or
> something incomplete without promise of a follow-up).  This is just a
> test for blkdebug, though, so it's OK (with the comment fixed, because
> it doesn't prove anything).
I wasn't implying that it's ok to merge bad code, but that at some point 
we have to just paint the shed a color and move on. At the risk of 
excess drama, at what point does a small addition become a complete 
tear-down and rebuild?
> (I'm sorry for not having looked at this series for so long, but qemu is
> not my own, so it isn't like I could pay for my wrong by accepting
> something incomplete -- if it were more important than this single test
> case.)
>
> Also, we do support Python for iotests, and parsing should be simpler
> there.  Since blkdebug is just a debugging driver, I'm fine with not
> knowing whether its features work, though.
>
> Maybe I'll write the test, that would kind of pay for my wrong...

I think the real fix is to make QMP support async IO, but if you'd like 
to do more parsing, that's fine too.

/marc
