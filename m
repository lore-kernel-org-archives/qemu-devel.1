Received: from eggs.gnu.org ([2001:4830:134:3::10]:54882)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1eqmCi-0000nf-Vy
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 15:50:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1eqmCi-0006AF-2w
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 15:50:29 -0500
References: <20180223235142.21501-1-jsnow@redhat.com>
	<20180223235142.21501-17-jsnow@redhat.com>
	<f475702e-fd2b-c1f2-ae32-4d34791f67ce@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <048dacc1-b256-778f-4c8a-e5662cb587e6@redhat.com>
Date: Tue, 27 Feb 2018 15:50:18 -0500
MIME-Version: 1.0
In-Reply-To: <f475702e-fd2b-c1f2-ae32-4d34791f67ce@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC v4 16/21] blockjobs: add waiting status
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



On 02/27/2018 03:00 PM, Eric Blake wrote:
> On 02/23/2018 05:51 PM, John Snow wrote:
>> For jobs that are stuck waiting on others in a transaction, it would
>> be nice to know that they are no longer "running" in that sense, but
>> instead are waiting on other jobs in the transaction.
>>
>> Jobs that are "waiting" in this sense cannot be meaningfully altered
>> any longer as they have left their running loop. The only meaningful
>> user verb for jobs in this state is "cancel," which will cancel the
>> whole transaction, too.
>>
>> Transitions:
>> Running -> Waiting:=C2=A0=C2=A0 Normal transition.
>> Ready=C2=A0=C2=A0 -> Waiting:=C2=A0=C2=A0 Normal transition.
>> Waiting -> Aborting:=C2=A0 Transactional cancellation.
>> Waiting -> Concluded: Normal transition.
>>
>> Removed Transitions:
>> Running -> Concluded: Jobs must go to WAITING first.
>> Ready=C2=A0=C2=A0 -> Concluded: Jobs must go to WAITING fisrt.
>=20
> s/fisrt/first/
>=20
>> +++ b/blockjob.c
>=20
>> @@ -3934,6 +3938,29 @@
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 'offset': 'int',
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 'speed' : 'int' } }
>> =C2=A0 +##
>> +# @BLOCK_JOB_WAITING:
>> +#
>> +# Emitted when a block job that is part of a transction has stopped
>> work and is
>=20
> s/transction/transaction/
>=20
>> +# waiting for other jobs in the transaction to reach the same state.
>=20
> Is this event emitted only for 'new-style' transactions (old drivers
> will never see it, because they don't request new style), or always (ol=
d
> drivers will see, but presumably ignore, it)?
>=20

...! Actually, I meant to remove the WAITING *event* entirely, this is a
mistake.

It's purely an informational state that clients likely cannot make any
real use of, because regardless of old or new style, jobs will
transition automatically to "PENDING."

That said, old or new, the state is visible from query-block-jobs.

--js
