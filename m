Received: from eggs.gnu.org ([2001:4830:134:3::10]:59893)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1evKKZ-0006wh-94
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 06:05:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1evKKT-0005Av-5B
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 06:05:23 -0400
References: <1518702707-7077-1-git-send-email-vsementsov@virtuozzo.com>
	<1518702707-7077-9-git-send-email-vsementsov@virtuozzo.com>
	<0739c439-4c1e-4c55-0c68-2c64978079eb@redhat.com>
	<20180220054204.GA2962@localhost.localdomain>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <d008d66b-b3c5-a8b1-6860-8ee7ba4acf0b@virtuozzo.com>
Date: Mon, 12 Mar 2018 13:04:55 +0300
MIME-Version: 1.0
In-Reply-To: <20180220054204.GA2962@localhost.localdomain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH 8/9] iotests: add file_path helper
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jeff Cody <jcody@redhat.com>, Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, kwolf@redhat.com, pbonzini@redhat.com, den@openvz.org, mreitz@redhat.com

20.02.2018 08:42, Jeff Cody wrote:
> On Fri, Feb 16, 2018 at 02:46:35PM -0600, Eric Blake wrote:
>> On 02/15/2018 07:51 AM, Vladimir Sementsov-Ogievskiy wrote:
>>> Simple way to have auto generated filenames with auto clenup. Like
>> s/clenup/cleanup/
>>
>>> FilePath but without using 'with' statement and without additional
>>> indentation of the whole test.
>>>
>>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>>> ---
>>>   tests/qemu-iotests/iotests.py | 32 ++++++++++++++++++++++++++++++++
>>>   1 file changed, 32 insertions(+)
>> Jeff, where do we stand on your iotests cleanups?  Is this something you
>> want to use?
>>
> This patch has niceties that my patch does not, in that explicit clean-up is
> not required.  This is also a slight design difference; my patch series
> explicitly avoided auto-cleanup, so that ./check could handle it, or
> (optionally) leave behind all the mouse droppings for later analysis, in the
> case of test failure.
>
> Ideally, I'd love clean-up to be optional; if a test fails, I'd like to have
> the option of examining all the intermediate files and output of the test
> (and once it resides in its own subdir, that is also side-affect free for
> the other tests).

Hmm. Now I think explicit clean-up (by ./chek, not by test) is better, 
at least for
just removing any files in TEST_DIR. Now it's often a problem to save 
test outputs
to debug it, and generic way to do it is good idea.. However, it may be 
cool to combine
both variants (so that, file_path will understand the option form Jeff's 
patches).

Anyway, for now I left this patch as is.

>
>>> diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests.py
>>> index c1302a2f9b..f2d05ca3fd 100644
>>> --- a/tests/qemu-iotests/iotests.py
>>> +++ b/tests/qemu-iotests/iotests.py
>>> @@ -27,6 +27,7 @@ import struct
>>>   import json
>>>   import signal
>>>   import logging
>>> +import atexit
>>>   sys.path.append(os.path.join(os.path.dirname(__file__), '..', '..', 'scripts'))
>>>   import qtest
>>> @@ -250,6 +251,37 @@ class FilePath(object):
>>>           return False
>>> +def file_path_remover():
>>> +    for path in reversed(file_path_remover.paths):
>>> +        try:
>>> +            os.remove(path)
>>> +        except OSError:
>>> +            pass
>>> +
>>> +
>>> +def file_path(*names):
>>> +    ''' Another way to get auto-generated filename that cleans itself up.
>>> +
>>> +    Use it as simple as:
>>> +
>>> +    img_a, img_b = file_path('a.img', 'b.img')
>>> +    sock = file_path('socket')
>>> +    '''
>>> +
>>> +    if not hasattr(file_path_remover, 'paths'):
>>> +        file_path_remover.paths = []
>>> +        atexit.register(file_path_remover)
>>> +
>>> +    paths = []
>>> +    for name in names:
>>> +        filename = '{0}-{1}'.format(os.getpid(), name)
>>> +        path = os.path.join(test_dir, filename)
>>> +        file_path_remover.paths.append(path)
>>> +        paths.append(path)
>>> +
>>> +    return paths[0] if len(paths) == 1 else paths
>>> +
>>> +
>>>   class VM(qtest.QEMUQtestMachine):
>>>       '''A QEMU VM'''
>>>
>> -- 
>> Eric Blake, Principal Software Engineer
>> Red Hat, Inc.           +1-919-301-3266
>> Virtualization:  qemu.org | libvirt.org
>>


-- 
Best regards,
Vladimir
