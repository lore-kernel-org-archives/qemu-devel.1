Received: from eggs.gnu.org ([2001:4830:134:3::10]:39262)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fLv2U-0001Px-Vk
	for qemu-devel@nongnu.org; Thu, 24 May 2018 14:32:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fLv2U-00039l-4Z
	for qemu-devel@nongnu.org; Thu, 24 May 2018 14:32:39 -0400
References: <20180518132114.4070-1-kwolf@redhat.com>
	<20180518132114.4070-36-kwolf@redhat.com>
	<6b0e43c5-f35b-5865-e423-ff6de432bb86@redhat.com>
	<20180524083624.GE4008@localhost.localdomain>
	<d58401b0-18e6-5815-b46f-67e941ade836@redhat.com>
	<b22b1f99-8205-b2ec-78e8-2b1f84bf754a@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <b2a6d650-a03b-8c85-a139-9e9e1ec63130@redhat.com>
Date: Thu, 24 May 2018 14:32:31 -0400
MIME-Version: 1.0
In-Reply-To: <b22b1f99-8205-b2ec-78e8-2b1f84bf754a@redhat.com>
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
To: Eric Blake <eblake@redhat.com>, Kevin Wolf <kwolf@redhat.com>
Cc: jcody@redhat.com, mreitz@redhat.com, qemu-devel@nongnu.org, qemu-block@nongnu.org, armbru@redhat.com



On 05/24/2018 02:22 PM, Eric Blake wrote:
> On 05/24/2018 12:36 PM, John Snow wrote:
> 
>>>> On 05/18/2018 09:21 AM, Kevin Wolf wrote:
>>>>> This adds a QMP event that is emitted whenever a job transitions from
>>>>> one status to another.
>>>>>
>>>>> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> 
>>>
>>> The question that I was asking myself was just whether I'd literally
>>> duplicate the existing events, just with s/BLOCK_JOB_/JOB_/, or whether
>>> a single event with a status field can do. I think the latter is more
>>> elegant (also because it can be implemented in a single place), even if
>>> it is emitted a bit more often than strictly necessary.
>>>
>>
>> Code-wise I agree that this is more elegant; just wondering if the
>> implications of the additional API guarantees were considered. This
>> means we have to be a bit more careful about how we restructure the
>> state machine in the future, I think.
>>
>> It also makes the "NULL" state visible, which I didn't really intend...
>> It's probably fine, just a little quirky.
> 
> Is it worth a special case to avoid emitting the event on transition to
> the NULL state?
> 

I would have done it, but it also doesn't necessarily hurt anything to
have it in here either.

Maybe it provides a benefit: I suppose it would definitely indicate to a
client that -- regardless of how they configured the job (with
auto-dismiss or not) that it serves as final record that the job has
*definitely absolutely gone* and can no longer be addressed.

It's just a strange state name for that purpose; I simply didn't
*intend* to expose it.

...OTOH, for early failures it seems like an obviously spurious message
that we don't need or want.

Well, glad I can give you precisely conflicting feelings on it and
arrive at no opinion. Good job everyone, see you tomorrow.

--js
