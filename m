Received: from eggs.gnu.org ([2001:4830:134:3::10]:37391)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <den@virtuozzo.com>) id 1elbw6-0000Cp-62
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 09:51:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <den@virtuozzo.com>) id 1elbw0-0003pq-68
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 09:51:56 -0500
References: <20180107122336.29333-1-richiejp@f-m.fm>
	<fd5f5f12-e081-6f19-54af-3b560139bb78@redhat.com>
	<5cf19623-72ac-fb8b-2054-a60d42419ec6@redhat.com>
	<20180111130427.GG8326@redhat.com>
	<20180213105024.GC5083@localhost.localdomain>
	<20180213143001.GA2354@rkaganb.sw.ru> <20180213143615.GN573@redhat.com>
	<20180213144521.GI5083@localhost.localdomain>
	<20180213144838.GO573@redhat.com>
From: "Denis V. Lunev" <den@virtuozzo.com>
Message-ID: <29531119-45d2-2d11-914e-7997122c4b29@virtuozzo.com>
Date: Tue, 13 Feb 2018 17:51:45 +0300
MIME-Version: 1.0
In-Reply-To: <20180213144838.GO573@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
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
To: "=?UTF-8?Q?Daniel_P._Berrang=c3=a9?=" <berrange@redhat.com>, Kevin Wolf <kwolf@redhat.com>
Cc: Roman Kagan <rkagan@virtuozzo.com>, Richard Palethorpe <richiejp@f-m.fm>, Qemu-block <qemu-block@nongnu.org>, quintela@redhat.com, qemu-devel@nongnu.org, armbru@redhat.com, Max Reitz <mreitz@redhat.com>, rpalethorpe@suse.com, dgilbert@redhat.com, Denis Plotnikov <dplotnikov@virtuozzo.com>

On 02/13/2018 05:48 PM, Daniel P. Berrang=C3=A9 wrote:
> On Tue, Feb 13, 2018 at 03:45:21PM +0100, Kevin Wolf wrote:
>> Am 13.02.2018 um 15:36 hat Daniel P. Berrang=C3=A9 geschrieben:
>>> On Tue, Feb 13, 2018 at 05:30:02PM +0300, Roman Kagan wrote:
>>>> On Tue, Feb 13, 2018 at 11:50:24AM +0100, Kevin Wolf wrote:
>>>>> Am 11.01.2018 um 14:04 hat Daniel P. Berrange geschrieben:
>>>>>> Then you could just use the regular migrate QMP commands for loading
>>>>>> and saving snapshots.
>>>>> Yes, you could. I think for a proper implementation you would want to=
 do
>>>>> better, though. Live migration provides just a stream, but that's not
>>>>> really well suited for snapshots. When a RAM page is dirtied, you jus=
t
>>>>> want to overwrite the old version of it in a snapshot [...]
>>>> This means the point in time where the guest state is snapshotted is n=
ot
>>>> when the command is issued, but any unpredictable amount of time later=
.
>>>>
>>>> I'm not sure this is what a user expects.
>>>>
>>>> A better approach for the save part appears to be to stop the vcpus,
>>>> dump the device state, resume the vcpus, and save the memory contents =
in
>>>> the background, prioritizing the old copies of the pages that change.
>>>> No multiple copies of the same page would have to be saved so the stre=
am
>>>> format would be fine.  For the load part the usual inmigrate should
>>>> work.
>>> No, that's policy decision that doesn't matter from QMP pov. If the mgm=
t
>>> app wants the snapshot to be wrt to the initial time, it can simply
>>> invoke the "stop" QMP command before doing the live migration and
>>> "cont" afterwards.
>> That would be non-live. I think Roman means a live snapshot that saves
>> the state at the beginning of the operation. Basically the difference
>> between blockdev-backup (state at the beginning) and blockdev-mirror
>> (state at the end), except for a whole VM.
> That doesn't seem practical unless you can instantaneously write out
> the entire guest RAM to disk without blocking, or can somehow snapshot
> the RAM so you can write out a consistent view of the original RAM,
> while the guest continues to dirty RAM pages.
>
> Regards,
> Daniel
we have working prototype of that right now, not yet ready to be
submitted even as RFC. In practice here we are spoken about
snapshots with memory as "The equivalent HMP command is savevm."
Thus all Roman's concerns are here.

Den
