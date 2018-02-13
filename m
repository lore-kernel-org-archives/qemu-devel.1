Received: from eggs.gnu.org ([2001:4830:134:3::10]:36723)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <den@virtuozzo.com>) id 1elbuQ-0007EO-F5
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 09:50:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <den@virtuozzo.com>) id 1elbuM-0002Ki-Ez
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 09:50:14 -0500
References: <20180107122336.29333-1-richiejp@f-m.fm>
	<fd5f5f12-e081-6f19-54af-3b560139bb78@redhat.com>
	<5cf19623-72ac-fb8b-2054-a60d42419ec6@redhat.com>
	<20180111130427.GG8326@redhat.com>
	<20180213105024.GC5083@localhost.localdomain>
	<20180213143001.GA2354@rkaganb.sw.ru>
	<20180213144310.GH5083@localhost.localdomain>
From: "Denis V. Lunev" <den@virtuozzo.com>
Message-ID: <975ba086-ff39-b416-d1b7-01d8ad00f8e5@virtuozzo.com>
Date: Tue, 13 Feb 2018 17:50:01 +0300
MIME-Version: 1.0
In-Reply-To: <20180213144310.GH5083@localhost.localdomain>
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
To: Kevin Wolf <kwolf@redhat.com>, Roman Kagan <rkagan@virtuozzo.com>, "Daniel P. Berrange" <berrange@redhat.com>, Richard Palethorpe <richiejp@f-m.fm>, Qemu-block <qemu-block@nongnu.org>, quintela@redhat.com, qemu-devel@nongnu.org, armbru@redhat.com, Max Reitz <mreitz@redhat.com>, rpalethorpe@suse.com, dgilbert@redhat.com, Denis Plotnikov <dplotnikov@virtuozzo.com>

On 02/13/2018 05:43 PM, Kevin Wolf wrote:
> Am 13.02.2018 um 15:30 hat Roman Kagan geschrieben:
>> On Tue, Feb 13, 2018 at 11:50:24AM +0100, Kevin Wolf wrote:
>>> Am 11.01.2018 um 14:04 hat Daniel P. Berrange geschrieben:
>>>> Then you could just use the regular migrate QMP commands for loading
>>>> and saving snapshots.
>>> Yes, you could. I think for a proper implementation you would want to d=
o
>>> better, though. Live migration provides just a stream, but that's not
>>> really well suited for snapshots. When a RAM page is dirtied, you just
>>> want to overwrite the old version of it in a snapshot [...]
>> This means the point in time where the guest state is snapshotted is not
>> when the command is issued, but any unpredictable amount of time later.
>>
>> I'm not sure this is what a user expects.
> I don't think it's necessarily a big problem as long as you set the
> expectations right, but good point anyway.
>
>> A better approach for the save part appears to be to stop the vcpus,
>> dump the device state, resume the vcpus, and save the memory contents
>> in the background, prioritizing the old copies of the pages that
>> change.
> So basically you would let the guest fault whenever it writes to a page
> that is not saved yet, and then save it first before you make the page
> writable again? Essentially blockdev-backup, except for RAM.
>
>> No multiple copies of the same page would have to be saved so the
>> stream format would be fine.  For the load part the usual inmigrate
>> should work.
> This is true.
>
> I think it will require changes to the qcow2 driver, though. Currently,
> you write the VM state into the active layer and then take the disk
> snapshot so that the VM state is automatically snapshotted as well.
> Afterwards, the VM state is discarded again in the active layer.
>
> If you want to take the snapshot at the point in time when the command
> was issued, you first need to create a qcow2 snapshot to save the disk
> state, but then continue to write the VM state into that snapshot, even
> though it's not the active layer.
>
> In fact I think this would be more elegant than writing the VM state
> into the active layer and then discarding it again, but inactive
> snapshots haven't been writable so far, so that will require some
> changes.
>
> I'm sure that Denis has already some thoughts on this, though.
>
> Kevin
This patchset looks quite similar I have initiated in 2015
=C2=A0=C2=A0=C2=A0 https://lists.gnu.org/archive/html/qemu-devel/2015-11/ms=
g03486.html

Current agreement on the topic from migration and block layer
maintainers is that for QAPI we should have the following:

1. savevm and load VM commands should accept block device to
=C2=A0=C2=A0=C2=A0 store VM state.
2. saveVM and load VM should be made asynchronous to avoid
=C2=A0=C2=A0=C2=A0 huge downtime during memory and state storing

The design should take (1) and (2) into the account. Right now
Denis Plotnikov is working (internally) on (2).

Den
