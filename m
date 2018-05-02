Received: from eggs.gnu.org ([2001:4830:134:3::10]:60722)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fDwKP-0005Y6-NK
	for qemu-devel@nongnu.org; Wed, 02 May 2018 14:18:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fDwKO-00008r-Ml
	for qemu-devel@nongnu.org; Wed, 02 May 2018 14:18:09 -0400
References: <20180421165423.30759-1-mreitz@redhat.com>
	<20180421165423.30759-8-mreitz@redhat.com>
	<53a4f279-49cc-7bf3-824a-4cb98fd9590c@redhat.com>
	<906eccc3-dba6-5674-45cd-fa11b4ea25b8@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <8c3b3d8a-93ca-451e-4929-af9d6210c1d5@redhat.com>
Date: Wed, 2 May 2018 14:18:05 -0400
MIME-Version: 1.0
In-Reply-To: <906eccc3-dba6-5674-45cd-fa11b4ea25b8@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 7/7] iotests: Rework 113
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org



On 05/02/2018 02:13 PM, Max Reitz wrote:
> On 2018-05-02 20:03, John Snow wrote:
>>
>>
>> On 04/21/2018 12:54 PM, Max Reitz wrote:
>>> This test case has been broken since 398e6ad014df261d (roughly half a
>>> year).  qemu-img amend requires its output image to be R/W, so it opens
>>> it as such; the node is then turned into an read-only node automatically
>>> which is now accompanied by a warning, however.  This warning has not
>>> been part of the reference output.
>>>
>>> For one thing, this warning shows that we cannot keep the test case as
>>> it is.  We would need a format that has no create_opts but that does
>>> have write support -- we do not have such a format, though.
>>>
>>> Another thing is that qemu now actually checks whether an image format
>>> supports amendment instead of whether it has create_opts (since the
>>> former always implies the latter).  So we can now use any format that
>>> does not support amendment (even if it supports creation) and thus test
>>> the same code path.
>>>
>>> The reason nobody has noticed the breakage until now of course is the
>>> fact that nobody runs the iotests for nbd+bochs.  There actually was
>>> never any reason to set the protocol to "nbd" but because that was
>>> technically correct; functionally it made no difference.  So that is the
>>> first thing we are going to change: Make the protocol "file" instead so
>>> that people might actually notice breakage here.
>>>
>>> Secondly, now that bochs no longer works for the amend test case, we
>>> have to change the format there anyway.  Set let us just bend the truth
> 
> I suppose s/Set/So/
> 
>>> a bit, declare this test a raw test.  In fact, that does not even
>>> concern the bochs test cases, other than the output now reading 'bochs'
>>> instead of 'IMGFMT'.
>>>
>>> So with this test now being a raw test, we can rework the amend test
>>> case to use raw instead.
>>>
>>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>>
>> Well, it passes... Not sure if I'm wild about the format change, it
>> sounds like a failure of our CI more than something that needed to
>> change in the test, but... shrug.
> 
> I think it's not really an issue in the CI.  Testing all possible
> combinations of protocols and formats seems too much to me.
> 
> I think it really is an issue in our test suite.  There are many tests
> that work only with a single combination (numerous file+qcow2 tests, for
> instance), so having our great test matrix capability is completely
> useless for them.
> 
> Maybe tests should be able to offer a preferred format+protocol
> (+options) combination?  Then, when you run check without any such
> arguments, it would just run each test in its preferred mode.
> 
> Max
> 

"You're not wrong" -- iotests presents an impossible matrix. You're not
going to fix our infrastructural problems with this one patch, which
looks like a hack in contrast to how the rest of iotests is presently
structured.

I don't oppose it, though. Just voicing my full-throated ambivalence.
There's definitely a discussion or two to be had about what
instrumenting iotests looks like and how we can ensure we're getting
proper coverage. The current solution *is* bad.

--js
