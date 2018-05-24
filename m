Received: from eggs.gnu.org ([2001:4830:134:3::10]:54102)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fLuAZ-000859-Hw
	for qemu-devel@nongnu.org; Thu, 24 May 2018 13:36:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fLuAY-0007GL-JG
	for qemu-devel@nongnu.org; Thu, 24 May 2018 13:36:55 -0400
References: <20180518132114.4070-1-kwolf@redhat.com>
	<20180518132114.4070-36-kwolf@redhat.com>
	<6b0e43c5-f35b-5865-e423-ff6de432bb86@redhat.com>
	<20180524083624.GE4008@localhost.localdomain>
From: John Snow <jsnow@redhat.com>
Message-ID: <d58401b0-18e6-5815-b46f-67e941ade836@redhat.com>
Date: Thu, 24 May 2018 13:36:48 -0400
MIME-Version: 1.0
In-Reply-To: <20180524083624.GE4008@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 35/40] job: Add JOB_STATUS_CHANGE QMP
 event
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



On 05/24/2018 04:36 AM, Kevin Wolf wrote:
> Am 24.05.2018 um 02:02 hat John Snow geschrieben:
>>
>>
>> On 05/18/2018 09:21 AM, Kevin Wolf wrote:
>>> This adds a QMP event that is emitted whenever a job transitions from
>>> one status to another.
>>>
>>> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
>>
>> That's a lot of events, and a lot are redundant to what we already
>> transmitted under block jobs; it also has the effect of making internal
>> state changes explicit behavior that we're responsible for maintaining
>> for external clients.
>>
>> Is that what we want here?
>>
>> (I mean, the answer is probably "Yes" because you're here writing the
>> patch, but I was hoping to find your motivation.)
> 
> The state change is visible in query-jobs anyway, so allowing the client
> to get events rather than polling query-jobs doesn't change the amount
> of information that is exposed.
> 

With differing amounts of guarantees, though; for querying you have to
so happen to catch it and in practice you may never observe many of the
status transitions. It's not something that an external client could
rely on.

With events, we're guaranteeing you will be able to listen to all
possible state transitions. People may begin depending on them in ways
we hadn't anticipated just yet.

...Well, as long as the client is connected to the stream, which we
suggest may not always be possible with the presence of the concluded state.

> You're right that some of the events are redundant with existing block
> job events, but that unavoidable because we can't send BLOCK_JOB_*
> events for non-block jobs. And not sending JOB_* for block jobs would be
> inconsistent.
> 
> The question that I was asking myself was just whether I'd literally
> duplicate the existing events, just with s/BLOCK_JOB_/JOB_/, or whether
> a single event with a status field can do. I think the latter is more
> elegant (also because it can be implemented in a single place), even if
> it is emitted a bit more often than strictly necessary.
> 

Code-wise I agree that this is more elegant; just wondering if the
implications of the additional API guarantees were considered. This
means we have to be a bit more careful about how we restructure the
state machine in the future, I think.

It also makes the "NULL" state visible, which I didn't really intend...
It's probably fine, just a little quirky.

> Kevin
> 
