Received: from eggs.gnu.org ([2001:4830:134:3::10]:34393)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1eHQaK-0005UF-Bm
	for qemu-devel@nongnu.org; Wed, 22 Nov 2017 03:40:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1eHQaI-0001p0-NF
	for qemu-devel@nongnu.org; Wed, 22 Nov 2017 03:40:44 -0500
References: <20171113162053.58795-1-vsementsov@virtuozzo.com>
	<01108daa-fed3-c142-bbd6-0ecc4c8b795d@redhat.com>
	<cd0a2e5e-f788-0e5a-dec7-f428479f3b89@virtuozzo.com>
	<8c61f43c-5f56-8c1b-a2fe-f954d34dc687@redhat.com>
	<40392ab9-ec2a-30ed-ddab-a557682a4192@virtuozzo.com>
	<4e4e28d7-aebc-4a86-e691-99afdcca27f5@redhat.com>
	<20171121172324.GC11073@localhost.localdomain>
	<1a8e9d48-5be1-e014-41ee-a1164f32dd17@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <8575f295-6f1a-8b75-36bb-f9d49d96e21b@virtuozzo.com>
Date: Wed, 22 Nov 2017 11:40:28 +0300
MIME-Version: 1.0
In-Reply-To: <1a8e9d48-5be1-e014-41ee-a1164f32dd17@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH for-2.12 0/4] qmp dirty bitmap API
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, famz@redhat.com, armbru@redhat.com, mnestratov@virtuozzo.com, mreitz@redhat.com, nshirokovskiy@virtuozzo.com, stefanha@redhat.com, den@openvz.org, pbonzini@redhat.com

22.11.2017 03:10, John Snow wrote:
>
> On 11/21/2017 12:23 PM, Kevin Wolf wrote:
>> Am 17.11.2017 um 22:35 hat John Snow geschrieben:
>>>>>> usage is like this:
>>>>>>
>>>>>> 1. we have dirty bitmap bitmap0 for incremental backup.
>>>>>>
>>>>>> 2. prepare image fleecing (create temporary image with backing=3Dour=
_disk)
>>>>>> 3. in qmp transaction:
>>>>>>  =C2=A0=C2=A0=C2=A0 - disable bitmap0
>>>>>>  =C2=A0=C2=A0=C2=A0 - create bitmap1
>>>>>>  =C2=A0=C2=A0=C2=A0 - start image fleecing (backup sync=3Dnone our_d=
isk -> temp_disk)
>>>>> This could probably just be its own command, though:
>>>>>
>>>>> block-job-fleece node=3Dfoobar bitmap=3Dbitmap0 etc=3Detera etc=3Dete=
ra
>>>>>
>>>>> Could handle forking the bitmap. I'm not sure what the arguments woul=
d
>>>>> look like, but we could name the NBD export here, too. (Assuming the
>>>>> server is already started and we just need to create the share.)
>>>>>
>>>>> Then, we can basically do what mirror does:
>>>>>
>>>>> (1) Cancel
>>>>> (2) Complete
>>>>>
>>>>> Cancel would instruct QEMU to keep the bitmap changes (i.e. roll back=
),
>>>>> and Complete would instruct QEMU to discard the changes.
>>>>>
>>>>> This way we don't need to expose commands like split or merge that wi=
ll
>>>>> almost always be dangerous to use over QMP.
>>>>>
>>>>> In fact, a fleecing job would be really convenient even without a
>>>>> bitmap, because it'd still be nice to have a convenience command for =
it.
>>>>> Using an existing infrastructure and understood paradigm is just a bo=
nus.
>>>> 1. If I understand correctly, Kevin and Max said in their report in
>>>> Prague about new block-job approach,
>>>>  =C2=A0 using filter nodes, so I'm not sure that this is a good Idea t=
o
>>>> introduce now new old-style block-job, where we can
>>>>  =C2=A0 do without it.
>>> We could do without it, but it might be a lot better to have everything
>>> wrapped up in a command that's easy to digest instead of releasing 10
>>> smaller commands that have to be executed in a very specific way in
>>> order to work correctly.
>>>
>>> I'm thinking about the complexity of error checking here with all the
>>> smaller commands, versus error checking on a larger workflow we
>>> understand and can quality test better.
>>>
>>> I'm not sure that filter nodes becoming the new normal for block jobs
>>> precludes our ability to use the job-management API as a handle for
>>> managing the lifetime of a long-running task like fleecing, but I'll
>>> check with Max and Kevin about this.
>> We have a general tendency at least in the block layer, but in fact I
>> think in qemu in general, to switch from exposing high-level
>> functionality to exposing lower-level operations via QAPI.
>>
> I am aware of that, yeah. I worry about going too far to the other
> extreme in some cases. Even at the API level where we don't care about
> the feelings of, or the ease-of-use by a robot, if a certain action
> requires several API commands to be issued in a very specific order,
> that increases our test matrix and it increases the complexity in the
> management API.
>
> There's a middle ground, I think.
>
> "Fleecing" is one of those cases where we can already fleece today with
> component commands, but a composite command that encapsulates that
> functionality would be helpful.

Additionally, a special filter node is needed to synchronize reads from=20
fleecing node
and COW-requests in backup, like in block/replication.

>
> In this case, I worry about adding low-level commands for bitmaps that
> will almost always be incorrect to use except in conjunction with other
> commands -- and even then generally only useful when issued via
> transaction specifically.
>
> (You might be able to make the case to me that we should add these
> commands but ONLY as transaction primitives, foregoing their traditional
> standalone QMP command counterparts.)

merge is ok without transaction.
transaction is needed only to start a new bitmap and initiate fleecing=20
in the same time.

and I do not see anything difficult in it. backup-related staff uses=20
transactions anyway, as
we need to backup several disks at once.

However, if it is OK to implement these commands only as transaction, we=20
can go that way.

>
> If I capitulate and let the more targeted primitives into QEMU instead
> of an encompassing job, it means a higher number of QMP commands
> overall, more tests, and more interfaces to test and maintain.

I'm not sure that implementing, testing and maintaining fleecing-job=20
would be simpler
than for these three simple commands. Number or QMP commands is not=20
equal to=C2=A0 the
overall interface complexity.

>
> Maybe I am being wrong-headed, but I actually think a new job would
> actually give us less to maintain, test and verify than several new
> primitives would, especially when considering that these primitives will
> in general only be used by transactions with other commands anyway, it
> increases the evidence that the right paradigm here is a new job, not
> more transaction primitives.
>
> ...maybe. I won't draw a line in the sand, but it's an approach I would
> like you to consider.
>
>> If we expose high-level commands, then every new use case will require a
>> change in both qemu and libvirt. With low-level commands, often libvirt
>> already has all of the required tools to implement what it needs.
>>
> I am receptive to how "big" commands often need to change frequently,
> though. Primitives certainly have a purity of design about them that
> larger job commands do not possess.
>
>> So I do see good reasons for exposing low-level commands.
>>
>>
>> On another note, I would double check before adding a new block job type
>> that this is the right way to go. We have recently noticed that many, if
>> not all, of the existing block jobs (at least mirror, commit and backup)
>> are so similar that they implement the same things multiple times and
>> are just lacking different options and have different bugs. I'm
>> seriously considering merging all of them into a single job type
>> internally that just provides options that effectively turn it into one
>> of the existing job types.
>>
> I'm not particularly opposed. At the very, very least "backup" and
> "mirror" are pretty much the same thing and "stream" and "commit" are
> basically the same.
>
> Forcing the backuppy-job and the consolidatey-job together seems like an
> ever-so-slightly harder case to make, but I suppose the truth of the
> matter in all cases is that we're copying data from one node to another..=
.
>
>> So even if we want to tie the bitmap management to a block job, we
>> should consider adding it as an option to the existing backup job rather
>> than adding a completely new fourth job type that again does almost the
>> same except for some bitmap mangement stuff on completion.
>>
> ...except here, where fleecing does not necessarily copy data in the
> same way.
>
> (It probably could re-use the copy-on-write notifiers that will be
> replaced by filter nodes, but I don't see it reusing much else.)
>
> We could try it before I naysay it, but where fleecing is concerned
> we're not using QEMU to move any bits around. It does feel pretty
> categorically different from the first four jobs.
>
> I wouldn't want to see the franken-job be drowned in conditional
> branches for 5,000 options, either. Eliminating some redundancy is good,
> but asserting that all existing jobs (and this possible new one too)
> should all be the same makes me worry that the resulting code would be
> too complex to work with.
>
> ...Maybe? Try it!
>
>> Kevin
>>


--=20
Best regards,
Vladimir
