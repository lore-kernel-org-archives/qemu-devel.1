Received: from eggs.gnu.org ([2001:4830:134:3::10]:33191)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1f1jLW-0007hu-Iv
	for qemu-devel@nongnu.org; Thu, 29 Mar 2018 22:00:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1f1jLR-0006FM-Kz
	for qemu-devel@nongnu.org; Thu, 29 Mar 2018 22:00:50 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:59512 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1f1jLR-0006Eu-Fr
	for qemu-devel@nongnu.org; Thu, 29 Mar 2018 22:00:45 -0400
References: <20180328163630.48576-1-dgilbert@redhat.com>
	<20180328163630.48576-6-dgilbert@redhat.com>
	<780d6d45-84a6-34db-e65f-3d38a6d0ea66@redhat.com>
	<20180329080846.GA2982@work-vm>
	<50fe8034-d0c1-94ea-40fc-b97b10ff5d8f@redhat.com>
	<20180329084400.GB2982@work-vm>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <5c248db3-0e3c-320e-142e-6c29e1b28dd5@redhat.com>
Date: Fri, 30 Mar 2018 10:00:29 +0800
MIME-Version: 1.0
In-Reply-To: <20180329084400.GB2982@work-vm>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 5/6] e1000: Choose which set of props to
 migrate
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: pbonzini@redhat.com, eswierk@skyportsystems.com, qemu-devel@nongnu.org, peterx@redhat.com, quintela@redhat.com



On 2018=E5=B9=B403=E6=9C=8829=E6=97=A5 16:44, Dr. David Alan Gilbert wrot=
e:
> * Jason Wang (jasowang@redhat.com) wrote:
>>
>> On 2018=E5=B9=B403=E6=9C=8829=E6=97=A5 16:08, Dr. David Alan Gilbert w=
rote:
>>> * Jason Wang (jasowang@redhat.com) wrote:
>>>> On 2018=E5=B9=B403=E6=9C=8829=E6=97=A5 00:36, Dr. David Alan Gilbert=
 (git) wrote:
>>>>> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
>>>>>
>>>>> When we're using the subsection we migrate both
>>>>> the 'props' and 'tso_props' data; when we're not using
>>>>> the subsection (to migrate to 2.11 or old machine types) we've
>>>>> got to choose what to migrate in the main structure.
>>>>>
>>>>> If we're using the subsection migrate 'props' in the main structure=
.
>>>>> If we're not using the subsection then migrate the last one
>>>>> that changed, which gives behaviour similar to the old behaviour.
>>>>>
>>>>>
>>>> But only after migration. Why not simply switch back to the old beha=
vior if
>>>> migrate_tso_props if false?
>>> Because:
>>>     1) We know it's a broken behaviour so it's better not to unfix it
>>>     2) The fix doesn't change guest visible behaviour other than actu=
ally
>>>        sending the right packets; so there's no reason to make the fi=
x
>>>        itself dependent on the machine type.
>>>     3) Gating the fix itself on the flag is actually more complex and
>>>        would need checking the flag in lots of places that are alread=
y
>>>        pretty complex, rather than what this does which is just check=
 it
>>>        in one place at migration.
>> It looks to me it was just something like:
>>
>>  =C2=A0=C2=A0=C2=A0 struct e1000x_txd_props *props =3D tp->cptse && ch=
kflag(TSO) ?
>> &tp->tso_props : &tp->props;
> is that the only thing that would change?

Looks like and we can avoid using tricks like patch 4.

>
>> Btw, did this patch work when:
>>
>> migrate A to B
>> migrate B to C
>>
>> But there's no tx during B?
> Hmm, good question; I only tried it keeping the stream alive during
> migration.
> Lets see what happens.
>
> For this code to be used we have to be running with an old machine
> type/property.
> That means A->B will have either come from 2.11 or a 2.12 with this sam=
e
> patch.
> But given patch 2 that duplicates on loading; that means A->B should
> end up with B having the same data in both sets of props, and
> thus it doesn't matter which set this patch picks.

Yes it is. I think I would agree with your idea now consider it was=20
slightly better than using the old behavior.

Thanks

>
> Dave
>
>> Thanks
>>
>>> Dave
>>>> Thanks
>>>>
>>> --
>>> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
>>>
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
>
