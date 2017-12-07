Received: from eggs.gnu.org ([2001:4830:134:3::10]:56862)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1eMkDZ-000160-5C
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 19:39:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1eMkDY-0002mV-1u
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 19:39:13 -0500
References: <20171113162053.58795-1-vsementsov@virtuozzo.com>
	<01108daa-fed3-c142-bbd6-0ecc4c8b795d@redhat.com>
	<cd0a2e5e-f788-0e5a-dec7-f428479f3b89@virtuozzo.com>
	<8c61f43c-5f56-8c1b-a2fe-f954d34dc687@redhat.com>
	<40392ab9-ec2a-30ed-ddab-a557682a4192@virtuozzo.com>
	<4e4e28d7-aebc-4a86-e691-99afdcca27f5@redhat.com>
	<40da8b0d-8039-634c-f50e-1d6326d7fca5@virtuozzo.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <37d0e96a-d572-3290-61e7-87e59de2f59b@redhat.com>
Date: Wed, 6 Dec 2017 19:38:57 -0500
MIME-Version: 1.0
In-Reply-To: <40da8b0d-8039-634c-f50e-1d6326d7fca5@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-2.12 0/4] qmp dirty bitmap API
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: kwolf@redhat.com, famz@redhat.com, armbru@redhat.com, mnestratov@virtuozzo.com, mreitz@redhat.com, nshirokovskiy@virtuozzo.com, stefanha@redhat.com, den@openvz.org, pbonzini@redhat.com



On 11/30/2017 07:10 AM, Vladimir Sementsov-Ogievskiy wrote:
> 18.11.2017 00:35, John Snow wrote:
>>
>> On 11/17/2017 03:22 AM, Vladimir Sementsov-Ogievskiy wrote:
>>> 17.11.2017 06:10, John Snow wrote:
>>>> On 11/16/2017 03:17 AM, Vladimir Sementsov-Ogievskiy wrote:
>>>>> 16.11.2017 00:20, John Snow wrote:
>>>>>> On 11/13/2017 11:20 AM, Vladimir Sementsov-Ogievskiy wrote:
>>>>>>> Hi all.
>>>>>>>
>>>>>>> There are three qmp commands, needed to implement external backup
>>>>>>> API.
>>>>>>>
>>>>>>> Using these three commands, client may do all needed bitmap
>>>>>>> management by
>>>>>>> hand:
>>>>>>>
>>>>>>> on backup start we need to do a transaction:
>>>>>>> =C2=A0=C2=A0 {disable old bitmap, create new bitmap}
>>>>>>>
>>>>>>> on backup success:
>>>>>>> =C2=A0=C2=A0 drop old bitmap
>>>>>>>
>>>>>>> on backup fail:
>>>>>>> =C2=A0=C2=A0 enable old bitmap
>>>>>>> =C2=A0=C2=A0 merge new bitmap to old bitmap
>>>>>>> =C2=A0=C2=A0 drop new bitmap
>>>>>>>
>>>>>> Can you give me an example of how you expect these commands to be
>>>>>> used,
>>>>>> and why they're required?
>>>>>>
>>>>>> I'm a little weary about how error-prone these commands might be
>>>>>> and the
>>>>>> potential for incorrect usage seems... high. Why do we require the=
m?
>>>>> It is needed for incremental backup. It looks like bad idea to expo=
rt
>>>>> abdicate/reclaim functionality, it is simpler
>>>>> and clearer to allow user to merge/enable/disable bitmaps by hand.
>>>>>
>>>>> usage is like this:
>>>>>
>>>>> 1. we have dirty bitmap bitmap0 for incremental backup.
>>>>>
>>>>> 2. prepare image fleecing (create temporary image with
>>>>> backing=3Dour_disk)
>>>>> 3. in qmp transaction:
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0 - disable bitmap0
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0 - create bitmap1
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0 - start image fleecing (backup sync=3Dnone=
 our_disk -> temp_disk)
>>>> This could probably just be its own command, though:
>>>>
>>>> block-job-fleece node=3Dfoobar bitmap=3Dbitmap0 etc=3Detera etc=3Det=
era
>>>>
>>>> Could handle forking the bitmap. I'm not sure what the arguments wou=
ld
>>>> look like, but we could name the NBD export here, too. (Assuming the
>>>> server is already started and we just need to create the share.)
>>>>
>>>> Then, we can basically do what mirror does:
>>>>
>>>> (1) Cancel
>>>> (2) Complete
>>>>
>>>> Cancel would instruct QEMU to keep the bitmap changes (i.e. roll bac=
k),
>>>> and Complete would instruct QEMU to discard the changes.
>>>>
>>>> This way we don't need to expose commands like split or merge that w=
ill
>>>> almost always be dangerous to use over QMP.
>>>>
>>>> In fact, a fleecing job would be really convenient even without a
>>>> bitmap, because it'd still be nice to have a convenience command for
>>>> it.
>>>> Using an existing infrastructure and understood paradigm is just a
>>>> bonus.
>>> 1. If I understand correctly, Kevin and Max said in their report in
>>> Prague about new block-job approach,
>>> =C2=A0=C2=A0 using filter nodes, so I'm not sure that this is a good =
Idea to
>>> introduce now new old-style block-job, where we can
>>> =C2=A0=C2=A0 do without it.
>>>
>> We could do without it, but it might be a lot better to have everythin=
g
>> wrapped up in a command that's easy to digest instead of releasing 10
>> smaller commands that have to be executed in a very specific way in
>> order to work correctly.
>>
>> I'm thinking about the complexity of error checking here with all the
>> smaller commands, versus error checking on a larger workflow we
>> understand and can quality test better.
>>
>> I'm not sure that filter nodes becoming the new normal for block jobs
>> precludes our ability to use the job-management API as a handle for
>> managing the lifetime of a long-running task like fleecing, but I'll
>> check with Max and Kevin about this.
>>
>>> 2. there is the following scenario: customers needs a possibility to
>>> create a backup of data changed since some
>>> point in time. So, maintaining several static and one (or several) ac=
tiv
>>> bitmaps with a possiblity of merge some of them
>>> and create a backup using this merged bitmap may be convenient.
>>>
>> I think the ability to copy bitmaps and issue differential backups wou=
ld
>> be sufficient in all cases I could think of...
>=20
> so, instead of keeping several static bitmaps with ability to merge the=
m,
> you propose to keep several active bitmaps and copy them to make a back=
up?
>=20
> so, instead of new qmp command for merge, add new qmp command for copy?
>=20
> in case of static bitmaps, we can implement saving/loading them to the
> image to free RAM space,
> so it is better.
>=20
> or what do you propose for=C2=A0 [2] ?
>=20
>=20
>=20
>

I'm sorry, I don't think I understand.

"customers needs a possibility to create a backup of data changed since
some point in time."

Is that not the existing case for a simple incremental backup? Granted,
the point in time was decided when we created the bitmap or when we made
the last backup, but it is "since some point in time."

If you mean to say an arbitrary point in time after-the-fact, I don't
see how the API presented here helps enable that functionality.

(by "arbitrary point in time after-the-fact I mean for example: Say a
user installs a malicious application in a VM on Thursday, but the
bitmap was created on Monday. The user wants to go back to Wednesday
evening, but we have no record of that point in time, so we cannot go
back to it.)

Can you elaborate on what you're trying to accomplish so I make sure I'm
considering you carefully?
