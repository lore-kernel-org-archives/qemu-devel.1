Received: from eggs.gnu.org ([2001:4830:134:3::10]:41550)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dMuFS-0001re-4w
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 06:49:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dMuFR-0006tY-92
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 06:49:34 -0400
Date: Mon, 19 Jun 2017 12:49:15 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170619104915.GC6113@noname.redhat.com>
References: <7ec58051-d835-a485-7578-2022351c9712@gmail.com>
	<20170619072727.GA6113@noname.redhat.com>
	<6324ce25-8fa8-9204-d15b-32f20fb71e4b@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6324ce25-8fa8-9204-d15b-32f20fb71e4b@gmail.com>
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
To: Xie Changlong <xiechanglong.d@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <famz@redhat.com>, Max Reitz <mreitz@redhat.com>, armbru@redhat.com

Am 19.06.2017 um 12:27 hat Xie Changlong geschrieben:
> =E5=9C=A8 6/19/2017 3:27 PM, Kevin Wolf =E5=86=99=E9=81=93:
> >Am 18.06.2017 um 09:21 hat Xie Changlong geschrieben:
> >>In device hot-remove scenario, if we don't probe acpiphp module on
> >>the guest, 'device_del' will never emit DEVICE_DELETED event(because
> >>guest will not write to __EJ0) . So we can confirm that hot-remove
> >>failed. But IIUC, there is no event such as DEVICE_ADDED, so
> >>1) How can we confirm hotplug('device_add') successfully?
> >>2) It seems when hot-plug disk, we don't care acpiphp module status
> >>on the guest, am I right?
> >>3) Why there is no DEVICE_ADDED like event?
> >
> >device_add doesn't need guest cooperation, so it is immediately
> >completed when the QMP command returns success.
> >
>=20
> That's what i though too. But I have a question, if we don't proble
> acpiphp on the guest, and execute below commands:
>=20
> Hot plug:
> (qemu) drive_add 0
> file=3D/resource/changlox/test.raw,id=3Ddrive-virtio-disk1,if=3Dnone
> (qemu) device_add virtio-blk-pci,drive=3Ddrive-virtio-disk1,id=3Dvirtio=
-disk1
>=20
> Hot remove:
> (qemu) device_del virtio-disk1
> (qemu) drive_del drive-virtio-disk1
> (qemu) qom-list /machine/peripheral
> type (string)
> virtio-disk1 (child<virtio-blk-pci>)
> (qemu) info block
> foo (#block122): suse1.qcow2 (qcow2)
>     Cache mode:       writeback, direct
>     Backing file:     suse.qcow2.orgin (chain depth: 1)
>=20
> ide1-cd0: [not inserted]
>     Removable device: not locked, tray closed
>=20
> floppy0: [not inserted]
>     Removable device: not locked, tray closed
>=20
> sd0: [not inserted]
>     Removable device: not locked, tray closed
> (qemu) drive_add 0
> file=3D/resource/changlox/test.raw,id=3Ddrive-virtio-disk1,if=3Dnone
> Duplicate ID 'drive-virtio-disk1' for drive
>=20
> 'info block' shows nothing, but we can't add drive who's id
> is'drive-virtio-disk1' too.

Yes, the old BlockBackend is only fully freed when the guest actually
unplugs the device. Specifically, we would have to free the QemuOpts
in DriveInfo that keeps the ID reserved. Currently, it is only freed
when the BlockBackend is destroyed:

    blockdev_auto_del()
        blk_unref()
            blk_delete()
                drive_info_del()

We can't free the DriveInfo earlier because it's still needed while the
guest device is still alive.

I'm not sure, but it may be possible to free just the QemuOpts in
monitor_remove_blk(), so that the ID can immediately be reused.

Markus, would you know?

> There is a more serious situation, we
> could *never* destory device memory with 'device_del', it's memory
> leak to me if the guest os never support hot-plug and the user don't
> know this information.

The user sees that they never get a DEVICE_REMOVED event, so in some way
the do know about it.

Kevin
