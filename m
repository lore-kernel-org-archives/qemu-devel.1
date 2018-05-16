Received: from eggs.gnu.org ([2001:4830:134:3::10]:60412)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fJ0Ne-0004Mu-DQ
	for qemu-devel@nongnu.org; Wed, 16 May 2018 13:38:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fJ0Nd-0004qi-Bo
	for qemu-devel@nongnu.org; Wed, 16 May 2018 13:38:26 -0400
References: <20180509162637.15575-1-kwolf@redhat.com>
	<20180509162637.15575-19-kwolf@redhat.com>
	<c063b982-58ac-e477-991f-07b847edc48a@redhat.com>
	<20180516165004.GF4435@localhost.localdomain>
From: John Snow <jsnow@redhat.com>
Message-ID: <ba186290-2cdf-e581-a21b-ff086c1e0e60@redhat.com>
Date: Wed, 16 May 2018 13:38:18 -0400
MIME-Version: 1.0
In-Reply-To: <20180516165004.GF4435@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 18/42] job: Move coroutine and related code
 to Job
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, jcody@redhat.com, armbru@redhat.com, mreitz@redhat.com



On 05/16/2018 12:50 PM, Kevin Wolf wrote:
> Am 15.05.2018 um 01:02 hat John Snow geschrieben:
>>
>>
>> On 05/09/2018 12:26 PM, Kevin Wolf wrote:
>>> This commit moves some core functions for dealing with the job coroutine
>>> from BlockJob to Job. This includes primarily entering the coroutine
>>> (both for the first and reentering) and yielding explicitly and at pause
>>> points.
>>>
>>> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
>>> ---
>>>  include/block/blockjob.h     |  40 ---------
>>>  include/block/blockjob_int.h |  26 ------
>>>  include/qemu/job.h           |  76 ++++++++++++++++
>>>  block/backup.c               |   2 +-
>>>  block/commit.c               |   4 +-
>>>  block/mirror.c               |  22 ++---
>>>  block/replication.c          |   2 +-
>>>  block/stream.c               |   4 +-
>>>  blockdev.c                   |   8 +-
>>>  blockjob.c                   | 201 +++++++------------------------------------
>>>  job.c                        | 137 +++++++++++++++++++++++++++++
>>>  tests/test-bdrv-drain.c      |  38 ++++----
>>>  tests/test-blockjob-txn.c    |  12 +--
>>>  tests/test-blockjob.c        |  14 +--
>>>  14 files changed, 296 insertions(+), 290 deletions(-)
>>>
>>
>> [...]
>>
>>>  
>>>  /* Assumes the block_job_mutex is held */
>>> -static bool block_job_timer_pending(BlockJob *job)
>>> +static bool job_timer_pending(Job *job)
>>
>> Is this intentionally left behind in blockjob.c, even once you've
>> changed the name (and moved the state to job.c?)
> 
> Yes, it's just a small callback that is structually part of
> block_job_set_speed(). Maybe I shouldn't rename it, but it does get a
> Job rather than a BlockJob now, so I'm not sure.
> 
> Kevin
> 

Your choice; it's not clear to me yet which things truly belong in which
file because I haven't had a chance to look at the finished result. I'm
sure if it looks like it needs to move later that someone will
eventually move it.

--js
