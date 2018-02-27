Received: from eggs.gnu.org ([2001:4830:134:3::10]:55763)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1eqmGa-0003dJ-R6
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 15:54:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1eqmGZ-0008GC-V1
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 15:54:28 -0500
References: <20180223235142.21501-1-jsnow@redhat.com>
	<20180223235142.21501-18-jsnow@redhat.com>
	<9ceca0a2-788d-9a1a-985f-a6916a5f2bcc@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <d918a3fd-aa6b-4b58-4814-84f9fb438b99@redhat.com>
Date: Tue, 27 Feb 2018 15:54:04 -0500
MIME-Version: 1.0
In-Reply-To: <9ceca0a2-788d-9a1a-985f-a6916a5f2bcc@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC v4 17/21] blockjobs: add PENDING status and
 event
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org
Cc: kwolf@redhat.com, pkrempa@redhat.com, jtc@redhat.com, qemu-devel@nongnu.org



On 02/27/2018 03:05 PM, Eric Blake wrote:
> On 02/23/2018 05:51 PM, John Snow wrote:
>> For jobs utilizing the new manual workflow, we intend to prohibit
>> them from modifying the block graph until the management layer provide=
s
>> an explicit ACK via block-job-finalize to move the process forward.
>>
>> To distinguish this runstate from "ready" or "waiting," we add a new
>> "pending" event.
>>
>> For now, the transition from PENDING to CONCLUDED/ABORTING is automati=
c,
>> but a future commit will add the explicit block-job-finalize step.
>>
>> Transitions:
>> Waiting -> Pending:=C2=A0=C2=A0 Normal transition.
>> Pending -> Concluded: Normal transition.
>> Pending -> Aborting:=C2=A0 Late transactional failures and cancellatio=
ns.
>>
>> Removed Transitions:
>> Waiting -> Concluded: Jobs must go to PENDING first.
>>
>> Verbs:
>> Cancel: Can be applied to a pending job.
>>
>=20
>> +##
>> +# @BLOCK_JOB_PENDING:
>> +#
>> +# Emitted when a block job is awaiting explicit authorization to
>> finalize graph
>> +# changes via @block-job-finalize. If this job is part of a
>> transaction, it will
>> +# not emit this event until the transaction has converged first.
>=20
> Same question of whether this new event is always emitted (and older
> clients presumably ignore it), or only emitted for clients that
> requested new-style state management.
>=20

Old style jobs will skip the broadcast of the event, but will still
transition to the state. However, since transition is synchronous, you
likely won't see this state show up in a query for old style jobs.

That was the intent, anyway.

I wanted to be nonintrusive, and felt that this event was likely not
useful in any way unless we were using the new state management scheme.
In the old style, this event will be fully synchronous with COMPLETED or
CANCELLED, for instance.

--js
