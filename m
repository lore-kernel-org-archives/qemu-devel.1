Received: from eggs.gnu.org ([2001:4830:134:3::10]:38344)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dO2bB-0001R9-Ke
	for qemu-devel@nongnu.org; Thu, 22 Jun 2017 09:56:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dO2bA-0005r2-FZ
	for qemu-devel@nongnu.org; Thu, 22 Jun 2017 09:56:41 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <7ec58051-d835-a485-7578-2022351c9712@gmail.com>
	<20170619072727.GA6113@noname.redhat.com>
	<6324ce25-8fa8-9204-d15b-32f20fb71e4b@gmail.com>
	<20170619104915.GC6113@noname.redhat.com>
Date: Thu, 22 Jun 2017 15:56:23 +0200
In-Reply-To: <20170619104915.GC6113@noname.redhat.com> (Kevin Wolf's message
	of "Mon, 19 Jun 2017 12:49:15 +0200")
Message-ID: <8737asjfco.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Question] How can we confirm hot-plug disk
 succesfully?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: Xie Changlong <xiechanglong.d@gmail.com>, Fam Zheng <famz@redhat.com>, qemu-block@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

Kevin Wolf <kwolf@redhat.com> writes:

> Am 19.06.2017 um 12:27 hat Xie Changlong geschrieben:
>> =E5=9C=A8 6/19/2017 3:27 PM, Kevin Wolf =E5=86=99=E9=81=93:
>> >Am 18.06.2017 um 09:21 hat Xie Changlong geschrieben:
>> >>In device hot-remove scenario, if we don't probe acpiphp module on
>> >>the guest, 'device_del' will never emit DEVICE_DELETED event(because
>> >>guest will not write to __EJ0) . So we can confirm that hot-remove
>> >>failed. But IIUC, there is no event such as DEVICE_ADDED, so
>> >>1) How can we confirm hotplug('device_add') successfully?
>> >>2) It seems when hot-plug disk, we don't care acpiphp module status
>> >>on the guest, am I right?
>> >>3) Why there is no DEVICE_ADDED like event?
>> >
>> >device_add doesn't need guest cooperation, so it is immediately
>> >completed when the QMP command returns success.
>> >
>>=20
>> That's what i though too. But I have a question, if we don't proble
>> acpiphp on the guest, and execute below commands:
>>=20
>> Hot plug:
>> (qemu) drive_add 0
>> file=3D/resource/changlox/test.raw,id=3Ddrive-virtio-disk1,if=3Dnone
>> (qemu) device_add virtio-blk-pci,drive=3Ddrive-virtio-disk1,id=3Dvirtio-=
disk1
>>=20
>> Hot remove:
>> (qemu) device_del virtio-disk1
>> (qemu) drive_del drive-virtio-disk1
>> (qemu) qom-list /machine/peripheral
>> type (string)
>> virtio-disk1 (child<virtio-blk-pci>)
>> (qemu) info block
>> foo (#block122): suse1.qcow2 (qcow2)
>>     Cache mode:       writeback, direct
>>     Backing file:     suse.qcow2.orgin (chain depth: 1)
>>=20
>> ide1-cd0: [not inserted]
>>     Removable device: not locked, tray closed
>>=20
>> floppy0: [not inserted]
>>     Removable device: not locked, tray closed
>>=20
>> sd0: [not inserted]
>>     Removable device: not locked, tray closed
>> (qemu) drive_add 0
>> file=3D/resource/changlox/test.raw,id=3Ddrive-virtio-disk1,if=3Dnone
>> Duplicate ID 'drive-virtio-disk1' for drive
>>=20
>> 'info block' shows nothing, but we can't add drive who's id
>> is'drive-virtio-disk1' too.
>
> Yes, the old BlockBackend is only fully freed when the guest actually
> unplugs the device. Specifically, we would have to free the QemuOpts
> in DriveInfo that keeps the ID reserved. Currently, it is only freed
> when the BlockBackend is destroyed:
>
>     blockdev_auto_del()
>         blk_unref()
>             blk_delete()
>                 drive_info_del()
>
> We can't free the DriveInfo earlier because it's still needed while the
> guest device is still alive.
>
> I'm not sure, but it may be possible to free just the QemuOpts in
> monitor_remove_blk(), so that the ID can immediately be reused.
>
> Markus, would you know?

It's complicated :)

=3D Abstract discussion =3D

QemuOpts enforces unique IDs.

The things configured by QemuOpts often also have unique IDs.

If a certain kind of thing is always created from a QemuOpts, and it
keeps its QemuOpts alive until it dies itself, then needn't enfore
unique IDs itself.  If it does anyway, these errors are unreachable.

If it can be created without QemuOpts, or its QemuOpts can die early,
then it has to enforce unique IDs itself.  This can lead to inconsistent
error messages: if the clash is detected by QemuOpts, QemuOpts reports
it, but if its only detected by the thing, the thing reports it.

If your thing enforces unique IDs itself, and nothing needs its
QemuOpts, then it can destroy it at any time.  Note that -writeconfig
needs all QemuOpts created for command line options left of it.

With the benefit of hindsight: QemuOpts tries to do too much.  It should
just parse option arguments (treating "id" like any other parameter) and
optionally accumulate parsed option arguments, so you can act on them
later (command line works that way).

=3D Concrete discussion =3D

Initially, every block backend had a unique name, but this has changed,
and I don't know for sure whether block backends rely in QemuOpts for
enforcing uniqueness now, and what else might need the QemuOpts.

HMP drive_del has awkward semantics that require removing the name from
the backend in some cases.  I guess the QemuOpts ID should also go away
then, but I'm not sure, it's been too long since I messed around in that
particular swamp.

Sorry I can't give more definite answers.

>> There is a more serious situation, we
>> could *never* destory device memory with 'device_del', it's memory
>> leak to me if the guest os never support hot-plug and the user don't
>> know this information.
>
> The user sees that they never get a DEVICE_REMOVED event, so in some way
> the do know about it.

Concur.  There is no leak, we simply can't unplug.  We can't even tell
the user that we can't unplug.  ACPI unplug is an afterthought, and it
shows.
