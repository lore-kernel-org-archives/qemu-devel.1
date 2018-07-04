Received: from eggs.gnu.org ([2001:4830:134:3::10]:46470)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fahEx-0008PY-35
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 08:50:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fahEt-0000pn-Vk
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 08:50:35 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:55456 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1fahEt-0000pd-MS
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 08:50:31 -0400
References: <86b43998-fc9e-75bf-564c-a64d72163793@huawei.com>
	<20180702131518.GF2155@stefanha-x1.localdomain>
	<c3e76f29-9259-f56d-6829-8abd6dd7da88@huawei.com>
	<0c86fe57-ed34-f44f-83af-ecdf36f7605b@huawei.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <646e7b03-4c10-7868-fb7d-6a5e2c34de0e@redhat.com>
Date: Wed, 4 Jul 2018 14:50:26 +0200
MIME-Version: 1.0
In-Reply-To: <0c86fe57-ed34-f44f-83af-ecdf36f7605b@huawei.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] question: disk missing in the guest contingently
 when hotplug several virtio scsi disks consecutively.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: l00284672 <lizhengui@huawei.com>, Stefan Hajnoczi <stefanha@gmail.com>
Cc: famz@redhat.com, kwolf@redhat.com, "Fangyi (C)" <eric.fangyi@huawei.com>, qemu-devel@nongnu.org, David Hildenbrand <david@redhat.com>

On 03/07/2018 15:30, l00284672 wrote:
> I got a solution, the patch is below:
>=20
> diff --git a/hw/scsi/scsi-disk.c b/hw/scsi/scsi-disk.c
> index 608fb18..4cdc2bb 100644
> --- a/hw/scsi/scsi-disk.c
> +++ b/hw/scsi/scsi-disk.c
> @@ -2184,7 +2184,9 @@ static void scsi_disk_reset(DeviceState *dev)
> =A0=A0=A0=A0 SCSIDiskState *s =3D DO_UPCAST(SCSIDiskState, qdev.qdev, d=
ev);
> =A0=A0=A0=A0 uint64_t nb_sectors;
>=20
> -=A0=A0=A0 scsi_device_purge_requests(&s->qdev, SENSE_CODE(RESET));
> +=A0=A0=A0 if (dev->realized) {
> +=A0=A0=A0=A0=A0=A0 scsi_device_purge_requests(&s->qdev, SENSE_CODE(RES=
ET));
> +=A0=A0=A0 }
>=20
> =A0=A0=A0=A0 blk_get_geometry(s->qdev.conf.blk, &nb_sectors);
> =A0=A0=A0=A0 nb_sectors /=3D s->qdev.blocksize / 512;
>=20
> The commit
> https://git.qemu.org/?p=3Dqemu.git;a=3Dcommitdiff;h=3De9447f35718439c1a=
ffdee3ef69b2fee50c8106c;hp=3D4c64d5b52ed5287bb31489bba39cf41628230bc
> introduced this problem.
>=20
> I=A0 think=A0 there should not be any IO requests brefore device is
> realized, but I have no idea=A0 how to avoid it after calling
> virtio_scsi_push_event.

virtio_scsi_push_event is called too soon.  David, now that you have
introduced pre_plug in HotplugHandler, it seems to me that the "plug"
callback should be called after dev->realized is set to true.

In general, this means splitting the existing plug callbacks into a
pre_plug that checks for errors and a plug that does the operation.
However, the one use of pre_plug that you introduced for memory hotplug
has a plug callback that returns errors (namely pc_memory_plug via
pc_dimm_plug, where it sets properties).  I must be missing something,
why are properties being set after the realize method is called?  Could
these operations actually fail, or could the object_set_property_* calls
use &error_abort as the error pointer?

Thanks,

Paolo

>=20
> On 2018/7/3 15:20, l00284672 wrote:
>> The disk missing due to calling scsi_probe_lun failed in guest. The
>> guest code is below:
>> static int scsi_probe_lun(struct scsi_device *sdev, unsigned char
>> *inq_result,
>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 int result_len, int *bflags)
>>
>> {
>> .........
>> =A0=A0 =A0result =3D scsi_execute_req(sdev,=A0 scsi_cmd, DMA_FROM_DEVI=
CE,
>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 inq_re=
sult, try_inquiry_len, &sshdr,
>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 HZ / 2=
 + HZ * scsi_inq_timeout, 3,
>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 &resid=
);
>>
>> .........
>> }
>>
>> The scsi inqury request from guest is cancelled by qemu. The qemu bt
>> is below:
>>
>> (gdb) bt
>> #0=A0 scsi_req_cancel_async (req=3D0x7f86d00055c0, notifier=3D0x0) at
>> hw/scsi/scsi-bus.c:1825
>> #1=A0 0x000055b50ac254c7 in scsi_device_purge_requests
>> (sdev=3Dsdev@entry=3D0x55b50f9a8990, sense=3D...) at hw/scsi/scsi-bus.=
c:1925
>> #2=A0 0x000055b50ac1d337 in scsi_disk_reset (dev=3D0x55b50f9a8990) at
>> hw/scsi/scsi-disk.c:2186
>> #3=A0 0x000055b50ab95d91 in device_set_realized (obj=3D<optimized out>=
,
>> value=3D<optimized out>, errp=3D0x7ffedda81898) at hw/core/qdev.c:949
>> #4=A0 0x000055b50acd167e in property_set_bool (obj=3D0x55b50f9a8990,
>> v=3D<optimized out>, name=3D<optimized out>, opaque=3D0x55b50f9c1b50,
>> errp=3D0x7ffedda81898) at qom/object.c:1854
>> #5=A0 0x000055b50acd5091 in object_property_set_qobject
>> (obj=3Dobj@entry=3D0x55b50f9a8990, value=3Dvalue@entry=3D0x55b50f99735=
0,
>> name=3Dname@entry=3D0x55b50ae0260b "realized",
>> =A0=A0=A0 errp=3Derrp@entry=3D0x7ffedda81898) at qom/qom-qobject.c:27
>> #6=A0 0x000055b50acd3210 in object_property_set_bool
>> (obj=3D0x55b50f9a8990, value=3D<optimized out>, name=3D0x55b50ae0260b
>> "realized", errp=3D0x7ffedda81898) at qom/object.c:1157
>> #7=A0 0x000055b50ab1e0b5 in qdev_device_add
>> (opts=3Dopts@entry=3D0x55b50ceb9880, errp=3Derrp@entry=3D0x7ffedda8197=
8) at
>> qdev-monitor.c:627
>> #8=A0 0x000055b50ab1e68b in qmp_device_add (qdict=3D<optimized out>,
>> ret_data=3D<optimized out>, errp=3D0x7ffedda819c0) at qdev-monitor.c:8=
07
>> #9=A0 0x000055b50ad78787 in do_qmp_dispatch (errp=3D0x7ffedda819b8,
>> request=3D0x55b50c9605c0) at qapi/qmp-dispatch.c:114
>> #10 qmp_dispatch (request=3Drequest@entry=3D0x55b50d447000) at
>> qapi/qmp-dispatch.c:141
>> #11 0x000055b50aa3a102 in handle_qmp_command (parser=3D<optimized out>=
,
>> tokens=3D<optimized out>) at
>> /mnt/sdb/lzg/code/UVP_2.5_CODE/qemu/monitor.c:3907
>> #12 0x000055b50ad7da54 in json_message_process_token
>> (lexer=3D0x55b50c5d4458, input=3D0x55b50c55a6e0, type=3DJSON_RCURLY, x=
=3D181,
>> y=3D1449) at qobject/json-streamer.c:105
>> #13 0x000055b50ad9fdfb in json_lexer_feed_char
>> (lexer=3Dlexer@entry=3D0x55b50c5d4458, ch=3D125 '}',
>> flush=3Dflush@entry=3Dfalse) at qobject/json-lexer.c:319
>> #14 0x000055b50ad9febe in json_lexer_feed (lexer=3D0x55b50c5d4458,
>> buffer=3D<optimized out>, size=3D<optimized out>) at qobject/json-lexe=
r.c:369
>> #15 0x000055b50ad7db19 in json_message_parser_feed (parser=3D<optimize=
d
>> out>, buffer=3D<optimized out>, size=3D<optimized out>) at
>> qobject/json-streamer.c:124
>> #16 0x000055b50aa389bb in monitor_qmp_read (opaque=3D<optimized out>,
>> buf=3D<optimized out>, size=3D<optimized out>) at
>> /mnt/sdb/lzg/code/UVP_2.5_CODE/qemu/monitor.c:3937
>> #17 0x000055b50ab23e26 in tcp_chr_read (chan=3D<optimized out>,
>> cond=3D<optimized out>, opaque=3D0x55b50c5d0fa0) at qemu-char.c:3253
>> #18 0x00007f8754cc499a in g_main_context_dispatch () from
>> /usr/lib64/libglib-2.0.so.0
>> #19 0x000055b50acded8c in glib_pollfds_poll () at main-loop.c:228
>> #20 os_host_main_loop_wait (timeout=3D<optimized out>) at main-loop.c:=
273
>> #21 main_loop_wait (nonblocking=3D<optimized out>) at main-loop.c:521
>> #22 0x000055b50a9ff8ff in main_loop () at vl.c:2095
>>
>> static void device_set_realized(Object *obj, bool value, Error **errp)
>> {
>> =A0=A0 =A0.......
>> =A0=A0 =A0if (hotplug_ctrl) {
>> =A0=A0 =A0hotplug_handler_plug(hotplug_ctrl, dev, &local_err);
>> }
>>
>> .......
>> =A0=A0 =A0if (dev->hotplugged) {
>> =A0=A0 =A0=A0=A0 =A0device_reset(dev);
>> =A0=A0 =A0}
>> =A0=A0 =A0......
>> }
>>
>> The hotplug_handler_plug call virtio_scsi_hotplug.=A0 If iothread hand=
le
>> a request between=A0 hotplug_handler_plug and=A0 device_reset, the req=
uest
>> will be cancelled by
>> scsi_device_purge_requests in device_reset.
>>
>> On 2018/7/2 21:15, Stefan Hajnoczi wrote:
>>> On Wed, Jun 27, 2018 at 06:33:16PM +0800, l00284672 wrote:
>>>> Hi, I found a bug that disk missing (not all disks missing ) in the
>>>> guest
>>>> contingently when hotplug several virtio scsi disks consecutively.=A0
>>>> After
>>>> rebooting the guest,
>>> For the record, there is also a bug report here:
>>>
>>> https://bugs.launchpad.net/qemu/+bug/1779120
>>>
>>> I plan to reproduce this issue soon.
>>>
>>> Stefan
>>
>=20
