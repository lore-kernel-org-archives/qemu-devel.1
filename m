Received: from eggs.gnu.org ([2001:4830:134:3::10]:49833)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1cwd7b-0004Bs-Ri
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 19:16:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1cwd7X-0005Ro-RZ
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 19:16:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44548)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jsnow@redhat.com>) id 1cwd7X-0005Rc-Lm
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 19:16:47 -0400
References: <20170323173928.14439-1-pbonzini@redhat.com>
	<20170323173928.14439-2-pbonzini@redhat.com>
	<af7e2b04-4815-6e78-bba7-6b0a277797e1@amsat.org>
From: John Snow <jsnow@redhat.com>
Message-ID: <8915c199-636a-420a-e338-dff563fabb54@redhat.com>
Date: Fri, 7 Apr 2017 19:16:45 -0400
MIME-Version: 1.0
In-Reply-To: <af7e2b04-4815-6e78-bba7-6b0a277797e1@amsat.org>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 01/10] blockjob: remove unnecessary check
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: Jeff Cody <jcody@redhat.com>



On 04/07/2017 06:54 PM, Philippe Mathieu-Daud=E9 wrote:
> Hi Paolo,
>=20
> On 03/23/2017 02:39 PM, Paolo Bonzini wrote:
>> !job is always checked prior to the call, drop it from here.
>=20
> I agree with you this is currently true, *but* block_job_user_paused()
> is exported in "block/blockjob.h" so any future access (external to
> blockdev.c) could eventually happen with job =3D=3D NULL.
> I'd  NACK this patch for for this reason, but I checked and there is no
> access to this function outside of blockdev.c, so I think the best is t=
o
> make block_job_user_paused() static (removing the public declaration)
> and safely drop the !job check, what do you think?
>=20

Sure, but I would consider this a strict improvement as asking for the
paused status of NULL should be an error, not zero.

Anyway, this function exists almost entirely for the sake of blockdev,
so deleting it out of the public jobs interface isn't a very nice thing
to do.

The "proper" thing might be to add *errp, but that's a lot of paint for
a really tiny shed.

"IMO, etc." I've already spent more time on this email than it'd take to
code that, so whichever way the wind blows is fine with me.

--js

>>
>> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>> ---
>>  blockjob.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/blockjob.c b/blockjob.c
>> index 9b619f385..a9fb624 100644
>> --- a/blockjob.c
>> +++ b/blockjob.c
>> @@ -480,7 +480,7 @@ static bool block_job_should_pause(BlockJob *job)
>>
>>  bool block_job_user_paused(BlockJob *job)
>>  {
>> -    return job ? job->user_paused : 0;
>> +    return job->user_paused;
>>  }
>>
>>  void coroutine_fn block_job_pause_point(BlockJob *job)
>>
