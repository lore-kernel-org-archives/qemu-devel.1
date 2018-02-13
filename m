Received: from eggs.gnu.org ([2001:4830:134:3::10]:33219)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dplotnikov@virtuozzo.com>) id 1eld1k-000406-V1
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 11:01:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dplotnikov@virtuozzo.com>) id 1eld1i-0003bv-AL
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 11:01:53 -0500
References: <fd5f5f12-e081-6f19-54af-3b560139bb78@redhat.com>
	<5cf19623-72ac-fb8b-2054-a60d42419ec6@redhat.com>
	<20180111130427.GG8326@redhat.com>
	<20180213105024.GC5083@localhost.localdomain>
	<20180213143001.GA2354@rkaganb.sw.ru> <20180213143615.GN573@redhat.com>
	<20180213144521.GI5083@localhost.localdomain>
	<20180213144838.GO573@redhat.com> <20180213145913.GE2378@work-vm>
	<6845a694-aa22-90e8-7a9b-ce0283be450c@virtuozzo.com>
	<20180213150503.GF2378@work-vm>
From: Denis Plotnikov <dplotnikov@virtuozzo.com>
Message-ID: <26142d76-940a-01e7-fb13-f2a841301e92@virtuozzo.com>
Date: Tue, 13 Feb 2018 19:01:40 +0300
MIME-Version: 1.0
In-Reply-To: <20180213150503.GF2378@work-vm>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-block]  [PATCH 1/2] Add save-snapshot,
 load-snapshot and delete-snapshot to QAPI
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, "Denis V. Lunev" <den@virtuozzo.com>
Cc: "=?UTF-8?Q?Daniel_P._Berrang=c3=a9?=" <berrange@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Roman Kagan <rkagan@virtuozzo.com>, Richard Palethorpe <richiejp@f-m.fm>, Qemu-block <qemu-block@nongnu.org>, quintela@redhat.com, qemu-devel@nongnu.org, armbru@redhat.com, Max Reitz <mreitz@redhat.com>, rpalethorpe@suse.com, aarcange@redhat.com



On 13.02.2018 18:05, Dr. David Alan Gilbert wrote:
> * Denis V. Lunev (den@virtuozzo.com) wrote:
>> On 02/13/2018 05:59 PM, Dr. David Alan Gilbert wrote:
>>> * Daniel P. Berrang=C3=A9 (berrange@redhat.com) wrote:
>>>> On Tue, Feb 13, 2018 at 03:45:21PM +0100, Kevin Wolf wrote:
>>>>> Am 13.02.2018 um 15:36 hat Daniel P. Berrang=C3=A9 geschrieben:
>>>>>> On Tue, Feb 13, 2018 at 05:30:02PM +0300, Roman Kagan wrote:
>>>>>>> On Tue, Feb 13, 2018 at 11:50:24AM +0100, Kevin Wolf wrote:
>>>>>>>> Am 11.01.2018 um 14:04 hat Daniel P. Berrange geschrieben:
>>>>>>>>> Then you could just use the regular migrate QMP commands for load=
ing
>>>>>>>>> and saving snapshots.
>>>>>>>> Yes, you could. I think for a proper implementation you would want=
 to do
>>>>>>>> better, though. Live migration provides just a stream, but that's =
not
>>>>>>>> really well suited for snapshots. When a RAM page is dirtied, you =
just
>>>>>>>> want to overwrite the old version of it in a snapshot [...]
>>>>>>> This means the point in time where the guest state is snapshotted i=
s not
>>>>>>> when the command is issued, but any unpredictable amount of time la=
ter.
>>>>>>>
>>>>>>> I'm not sure this is what a user expects.
>>>>>>>
>>>>>>> A better approach for the save part appears to be to stop the vcpus=
,
>>>>>>> dump the device state, resume the vcpus, and save the memory conten=
ts in
>>>>>>> the background, prioritizing the old copies of the pages that chang=
e.
>>>>>>> No multiple copies of the same page would have to be saved so the s=
tream
>>>>>>> format would be fine.  For the load part the usual inmigrate should
>>>>>>> work.
>>>>>> No, that's policy decision that doesn't matter from QMP pov. If the =
mgmt
>>>>>> app wants the snapshot to be wrt to the initial time, it can simply
>>>>>> invoke the "stop" QMP command before doing the live migration and
>>>>>> "cont" afterwards.
>>>>> That would be non-live. I think Roman means a live snapshot that save=
s
>>>>> the state at the beginning of the operation. Basically the difference
>>>>> between blockdev-backup (state at the beginning) and blockdev-mirror
>>>>> (state at the end), except for a whole VM.
>>>> That doesn't seem practical unless you can instantaneously write out
>>>> the entire guest RAM to disk without blocking, or can somehow snapshot
>>>> the RAM so you can write out a consistent view of the original RAM,
>>>> while the guest continues to dirty RAM pages.
>>> People have suggested doing something like that with userfault write
>>> mode; but the same would also be doable just by write protecting the
>>> whole of RAM and then following the faults.
>>
>> nope, userfault fd does not help :( We have tried, the functionality is =
not
>> enough. Better to have small extension to KVM to protect all memory
>> and notify QEMU with accessed address.
>=20
> Can you explain why? I thought the write-protect mode of userfaultfd was
> supposed to be able to do that; cc'ing in Andrea

Hi everybody

Yes, that's true but it isn't implemented yet in the kernel

...
userfaultfd_register

         if (uffdio_register.mode & UFFDIO_REGISTER_MODE_WP) {
                 vm_flags |=3D VM_UFFD_WP;
                 /*
                  * FIXME: remove the below error constraint by
                  * implementing the wprotect tracking mode.
                  */
                 ret =3D -EINVAL;
                 goto out;
         }

and I don't feel like doing that taking into account that somebody has=20
it done already
but when it's done I'll use it with pleasure.

KVM need to tiny wini modification to be made in its mmu part which=20
would tell to the userspace the fault address. This is a simple solution=20
which can be used while we're living without userfaultfd.

>=20
> Dave
>=20
>> Den
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
>=20

--=20
Best,
Denis
