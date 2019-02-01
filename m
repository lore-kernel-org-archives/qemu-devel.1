Received: from eggs.gnu.org ([209.51.188.92]:40215)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1gpfF9-00034Q-FV
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 15:16:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1gpfF6-0000o9-PE
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 15:16:53 -0500
References: <20190114162605.5330-1-eblake@redhat.com>
	<20190114162605.5330-12-eblake@redhat.com>
	<20190130172734.GB892@localhost.localdomain>
	<1ec3a905-2e8c-6248-7204-32f30a8c8ca1@redhat.com>
	<20190131085512.GB3950@localhost.localdomain>
From: John Snow <jsnow@redhat.com>
Message-ID: <c66802a8-c25e-109e-30c0-a21b1d7f620c@redhat.com>
Date: Fri, 1 Feb 2019 15:16:36 -0500
MIME-Version: 1.0
In-Reply-To: <20190131085512.GB3950@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PULL 11/20] iotests: add iotest 236 for testing
 bitmap merge
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org, "open list:Block layer core" <qemu-block@nongnu.org>, Max Reitz <mreitz@redhat.com>



On 1/31/19 3:55 AM, Kevin Wolf wrote:
> Am 31.01.2019 um 03:03 hat John Snow geschrieben:
>> On 1/30/19 12:27 PM, Kevin Wolf wrote:
>>> Am 14.01.2019 um 17:25 hat Eric Blake geschrieben:
>>>> From: John Snow <jsnow@redhat.com>
>>>>
>>>> New interface, new smoke test.
>>>>
>>>> Signed-off-by: John Snow <jsnow@redhat.com>
>>>> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>>>> Reviewed-by: Eric Blake <eblake@redhat.com>
>>>> Message-Id: <20181221093529.23855-12-jsnow@redhat.com>
>>>> [eblake: fix last-minute change to echo text]
>>>> Signed-off-by: Eric Blake <eblake@redhat.com>
>>>
>>> This test fails for me (with Python 3) because I get a different dict
>>> order.
>>>
>>> Probably related to the OrderedDict that qmp_log() uses, so log() uses
>>> sort_keys=False and the unordered dicts that are contained in the outer
>>> OrderedDict stay unordered.
>>>
>>> Kevin
>>>
>>
>> OK, the problem is that ordered_kwargs() is not recursively ordering
>> those kwargs beneath list entries, so transactions are avoiding the sort.
>>
>> Patch coming up, thank you for the report and my apologies for breaking
>> iotests so often this cycle.
>>
>> (While I'm here, how do you configure iotests to use your python3
>> binary? I tried at configure time but that breaks the build for me with
>> some "magic number" errors. I could toy with it after by editing
>> common.env, but should the build work with python3?)
> 
> Yes, just at configure time:
> 
>     ./configure --target-list=x86_64-softmmu --python=/usr/bin/python3
> 
> I'm building and running tests in-tree, if that makes a difference.
> 
> But maybe it's actually not so bad if at least one of us still tests
> with Python 2 as long as we haven't officially removed support for
> that...
> 
> Kevin
> 

jhuston@probe (master) ~/s/q/b/git> make
  GEN     qapi-gen
Traceback (most recent call last):
  File "/home/bos/jhuston/src/qemu/scripts/qapi-gen.py", line 8, in <module>
    import argparse
ImportError: bad magic number in 'argparse': b'\x03\xf3\r\n'
make: *** [Makefile:540: qapi-gen-timestamp] Error 1

Ah, I see ... there are stale .pyc and __pycache__ files hiding around
that break things when you switch from 2 to 3 and `make distclean`
doesn't clear those out.

Probably ought to.
