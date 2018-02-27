Received: from eggs.gnu.org ([2001:4830:134:3::10]:35649)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1eql5M-0006wl-82
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 14:38:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1eql5L-0007n8-6b
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 14:38:48 -0500
References: <20180223235142.21501-1-jsnow@redhat.com>
	<20180223235142.21501-8-jsnow@redhat.com>
	<14553f87-de62-8da5-752b-febc0e815dab@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <9562ab17-03e4-e879-4dda-4d8ac0f90625@redhat.com>
Date: Tue, 27 Feb 2018 14:38:41 -0500
MIME-Version: 1.0
In-Reply-To: <14553f87-de62-8da5-752b-febc0e815dab@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC v4 07/21] blockjobs: add block_job_verb
 permission table
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



On 02/27/2018 02:25 PM, Eric Blake wrote:
> On 02/23/2018 05:51 PM, John Snow wrote:
>> Which commands ("verbs") are appropriate for jobs in which state is
>> also somewhat burdensome to keep track of.
>>
>> As of this commit, it looks rather useless, but begins to look more
>> interesting the more states we add to the STM table.
>>
>> A recurring theme is that no verb will apply to an 'undefined' job.
>=20
> Back to the argument of whether we even want that state.
>=20

By design, it is intended to reject all commands.

Though, what I can do is just remove the UNDEFINED state but have the
"CREATED" state start at "1" still. In effect, this gives you the empty
row and column for the 'UNDEFINED' state, except now it's *literally*
undefined.

However, the transition then needs to be set explicitly. The way the
code is written now, the status *only* ever changes from the transition
function, which makes it easy to search for and reason about all
possible transition points which I consider a feature of the design.

>>
>> =3D=3D=3D=3D=3D=3D=3D
>> Changes
>> =3D=3D=3D=3D=3D=3D=3D
>>
>> (1)
>>
>> To facilitate "nice" error checking, all five major block-job verb
>> interfaces in blockjob.c now support an errp parameter:
>>
>> - block_job_user_cancel is added as a new interface.
>> - block_job_user_pause gains an errp paramter
>> - block_job_user_resume gains an errp parameter
>> - block_job_set_speed already had an errp parameter.
>> - block_job_complete already had an errp parameter.
>>
>> (2)
>>
>> block-job-pause and block-job-resume will no longer no-op when trying
>> to pause an already paused job, or trying to resume a job that isn't
>> paused. These functions will now report that they did not perform the
>> action requested because it was not possible.
>>
>> iotests have been adjusted to address this new behavior.
>=20
> Seems reasonable.=C2=A0 Hopefully shouldn't trip up libvirt too badly (=
if
> libvirt attempted a redundant job transition that used to silently
> succeed and now fails, the failure message should be pretty obvious tha=
t
> it was a no-op attempt).
>=20

Yeah, it's arguable whether or not this is an API change.

(A) I'm not prohibiting anything that would have worked before. I am
just notifying the client that whatever they were trying to do had no
effect.

(B) That notification is an error, though, so some code paths that may
have relied on jamming pause signals into the pipe may be surprised at
the new response.

If I can get away with it, I obviously prefer to warn the user that the
pause/resume had no effect or couldn't be applied.

>>
>> (3)
>>
>> block-job-complete doesn't worry about checking !block_job_started,
>> because the permission table guards against this.
>>
>> (4)
>>
>> test-bdrv-drain's job implementation needs to announce that it is
>> 'ready' now, in order to be completed.
>>
>> Signed-off-by: John Snow <jsnow@redhat.com>
>> ---
>=20
> Reviewed-by: Eric Blake <eblake@redhat.com>
>=20
