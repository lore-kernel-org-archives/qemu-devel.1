Received: from eggs.gnu.org ([2001:4830:134:3::10]:33484)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1eOuAX-00049N-AN
	for qemu-devel@nongnu.org; Tue, 12 Dec 2017 18:41:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1eOuAS-0003TV-9S
	for qemu-devel@nongnu.org; Tue, 12 Dec 2017 18:41:01 -0500
From: John Snow <jsnow@redhat.com>
References: <20171128121055.6954-1-den@openvz.org>
	<20171128121055.6954-3-den@openvz.org>
	<c3b6f42e-25b2-205f-b8ad-822321ef0645@redhat.com>
	<7247ee82-c932-58d1-8a79-6af8c3665f0f@openvz.org>
Message-ID: <ab351bc9-b939-d320-d09d-a5ddb0ff3a73@redhat.com>
Date: Tue, 12 Dec 2017 18:40:49 -0500
MIME-Version: 1.0
In-Reply-To: <7247ee82-c932-58d1-8a79-6af8c3665f0f@openvz.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 2/2] ide: fix crash in IDE cdrom read
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Denis V. Lunev" <den@openvz.org>
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org, qemu-stable@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>

Hi Den, the long email about IDE stuff:

On 11/30/2017 07:01 AM, Denis V. Lunev wrote:
> On 11/29/2017 02:50 AM, John Snow wrote:
>>
>> On 11/28/2017 07:10 AM, Denis V. Lunev wrote:
>>> There is the following crash reported from the field in QEMU 2.9:
>>>     bdrv_inc_in_flight (bs=3Dbs@entry=3D0x0)
>>>     blk_aio_prwv
>>>     blk_aio_preadv
>>>     ide_buffered_readv
>>>     cd_read_sector
>> Is ide_atapi_cmd_reply_end missing from the call stack here for some
>> reason? ide_data_readw /should/ have end_transfer_func set to that if =
it
>> was processing an ATAPI command; otherwise it shouldn't be able to get
>> here under normal circumstances...
> this is my fault. I have lost this line while removing unnecessary into
> from callstack. Here if the full one.
>=20

Well, at least we're back on terra firma here.

I'm going to talk myself through what the problem looks like here, and I
have some questions for you at the bottom of the email, so you can just
skim if you're not interested in the details.

> (gdb) bt
> #0=C2=A0 bdrv_inc_in_flight (bs=3Dbs@entry=3D0x0) at block/io.c:561
> #1=C2=A0 0x000055b224160d37 in blk_aio_prwv (blk=3D0x55b2265405a0,
> =C2=A0=C2=A0=C2=A0 offset=3Doffset@entry=3D285122560, bytes=3D2048,
> qiov=3Dqiov@entry=3D0x55b22a31de20,
> =C2=A0=C2=A0=C2=A0 co_entry=3Dco_entry@entry=3D0x55b224160400 <blk_aio_=
read_entry>,
> =C2=A0=C2=A0=C2=A0 flags=3Dflags@entry=3D0, cb=3Dcb@entry=3D0x55b224048=
e00
> <ide_buffered_readv_cb>,
> =C2=A0=C2=A0=C2=A0 opaque=3Dopaque@entry=3D0x55b22a31de00) at block/blo=
ck-backend.c:1151
> #2=C2=A0 0x000055b224160db5 in blk_aio_preadv (blk=3D<optimized out>,
> =C2=A0=C2=A0=C2=A0 offset=3Doffset@entry=3D285122560, qiov=3Dqiov@entry=
=3D0x55b22a31de20,
> =C2=A0=C2=A0=C2=A0 flags=3Dflags@entry=3D0, cb=3Dcb@entry=3D0x55b224048=
e00
> <ide_buffered_readv_cb>,
> =C2=A0=C2=A0=C2=A0 opaque=3Dopaque@entry=3D0x55b22a31de00) at block/blo=
ck-backend.c:1256
> #3=C2=A0 0x000055b22404bd8d in ide_buffered_readv (s=3Ds@entry=3D0x55b2=
2a712a68,
> =C2=A0=C2=A0=C2=A0 sector_num=3D556880, iov=3Diov@entry=3D0x55b22a712d6=
0,
> =C2=A0=C2=A0=C2=A0 nb_sectors=3Dnb_sectors@entry=3D4,
> =C2=A0=C2=A0=C2=A0 cb=3Dcb@entry=3D0x55b22404f2a0 <cd_read_sector_cb>,
> =C2=A0=C2=A0=C2=A0 opaque=3Dopaque@entry=3D0x55b22a712a68) at hw/ide/co=
re.c:637
> #4=C2=A0 0x000055b22404e2c1 in cd_read_sector (s=3D0x55b22a712a68)
> =C2=A0=C2=A0=C2=A0 at hw/ide/atapi.c:198
> #5=C2=A0 ide_atapi_cmd_reply_end (s=3D0x55b22a712a68) at hw/ide/atapi.c=
:272
> #6=C2=A0 0x000055b224049704 in ide_data_readw (opaque=3D<optimized out>=
,
> =C2=A0=C2=A0=C2=A0 addr=3D<optimized out>) at hw/ide/core.c:2263
> #7=C2=A0 0x000055b223edd7f0 in portio_read (opaque=3D0x55b22a836000, ad=
dr=3D0,
> size=3D2)
> =C2=A0=C2=A0=C2=A0 at /usr/src/debug/qemu-2.9.0/ioport.c:180
> #8=C2=A0 0x000055b223ee8e3b in memory_region_read_accessor (mr=3D0x55b2=
2a836000,
> =C2=A0=C2=A0=C2=A0 addr=3D0, value=3D0x7f843b5be7c0, size=3D2, shift=3D=
0, mask=3D65535, attrs=3D...)
> =C2=A0=C2=A0=C2=A0 at /usr/src/debug/qemu-2.9.0/memory.c:435
> #9=C2=A0 0x000055b223ee6369 in access_with_adjusted_size (addr=3Daddr@e=
ntry=3D0,
> =C2=A0=C2=A0=C2=A0 value=3Dvalue@entry=3D0x7f843b5be7c0, size=3Dsize@en=
try=3D2,
> =C2=A0=C2=A0=C2=A0 access_size_min=3D<optimized out>, access_size_max=3D=
<optimized out>,
> =C2=A0=C2=A0=C2=A0 access=3Daccess@entry=3D0x55b223ee8e10 <memory_regio=
n_read_accessor>,
> =C2=A0=C2=A0=C2=A0 mr=3Dmr@entry=3D0x55b22a836000, attrs=3Dattrs@entry=3D=
...)
> =C2=A0=C2=A0=C2=A0 at /usr/src/debug/qemu-2.9.0/memory.c:592
> #10 0x000055b223ee9d36 in memory_region_dispatch_read1 (attrs=3D..., si=
ze=3D2,
> =C2=A0=C2=A0=C2=A0 pval=3D0x7f843b5be7c0, addr=3D0, mr=3D0x55b22a836000=
)
> =C2=A0=C2=A0=C2=A0 at /usr/src/debug/qemu-2.9.0/memory.c:1238
> #11 memory_region_dispatch_read (mr=3Dmr@entry=3D0x55b22a836000,
> =C2=A0=C2=A0=C2=A0 addr=3Daddr@entry=3D0, pval=3Dpval@entry=3D0x7f843b5=
be7c0, size=3Dsize@entry=3D2,
> =C2=A0=C2=A0=C2=A0 attrs=3Dattrs@entry=3D...) at /usr/src/debug/qemu-2.=
9.0/memory.c:1269
> #12 0x000055b223e9bdb2 in address_space_read_continue (
> =C2=A0=C2=A0=C2=A0 as=3Das@entry=3D0x55b2247db8c0 <address_space_io>, a=
ddr=3Daddr@entry=3D496,
> ---Type <return> to continue, or q <return> to quit---
> =C2=A0=C2=A0=C2=A0 attrs=3D..., attrs@entry=3D...,
> =C2=A0=C2=A0=C2=A0 buf=3Dbuf@entry=3D0x7f844dc103fe <Address 0x7f844dc1=
03fe out of bounds>,
> =C2=A0=C2=A0=C2=A0 len=3Dlen@entry=3D2, addr1=3D0, l=3D2, mr=3D0x55b22a=
836000)
> =C2=A0=C2=A0=C2=A0 at /usr/src/debug/qemu-2.9.0/exec.c:2844
> #13 0x000055b223e9be67 in address_space_read_full (
> =C2=A0=C2=A0=C2=A0 as=3D0x55b2247db8c0 <address_space_io>, addr=3Daddr@=
entry=3D496, attrs=3D...,
> =C2=A0=C2=A0=C2=A0 buf=3Dbuf@entry=3D0x7f844dc103fe <Address 0x7f844dc1=
03fe out of bounds>,
> =C2=A0=C2=A0=C2=A0 len=3D2, len@entry=3D602521191) at /usr/src/debug/qe=
mu-2.9.0/exec.c:2895
> #14 0x000055b223e9bfce in address_space_read (len=3D602521191,
> =C2=A0=C2=A0=C2=A0 buf=3D0x7f844dc103fe <Address 0x7f844dc103fe out of =
bounds>, attrs=3D...,
> =C2=A0=C2=A0=C2=A0 addr=3D496, as=3D<optimized out>)
> =C2=A0=C2=A0=C2=A0 at /usr/src/debug/qemu-2.9.0/include/exec/memory.h:1=
718
> #15 address_space_rw (as=3D<optimized out>, addr=3Daddr@entry=3D496, at=
trs=3D...,
> =C2=A0=C2=A0=C2=A0 attrs@entry=3D...,
> =C2=A0=C2=A0=C2=A0 buf=3Dbuf@entry=3D0x7f844dc103fe <Address 0x7f844dc1=
03fe out of bounds>,
> =C2=A0=C2=A0=C2=A0 len=3Dlen@entry=3D2, is_write=3Dis_write@entry=3Dfal=
se)
> =C2=A0=C2=A0=C2=A0 at /usr/src/debug/qemu-2.9.0/exec.c:2909
> #16 0x000055b223ee5271 in kvm_handle_io (count=3D512, size=3D2,
> =C2=A0=C2=A0=C2=A0 direction=3D<optimized out>, data=3D<optimized out>,=
 attrs=3D..., port=3D496)
> =C2=A0=C2=A0=C2=A0 at /usr/src/debug/qemu-2.9.0/kvm-all.c:1828
> #17 kvm_cpu_exec (cpu=3Dcpu@entry=3D0x55b229032000)
> =C2=A0=C2=A0=C2=A0 at /usr/src/debug/qemu-2.9.0/kvm-all.c:2058
> #18 0x000055b223ed1c22 in qemu_kvm_cpu_thread_fn (arg=3D0x55b229032000)
> =C2=A0=C2=A0=C2=A0 at /usr/src/debug/qemu-2.9.0/cpus.c:1119
> #19 0x00007f8443993e25 in start_thread (arg=3D0x7f843b5bf700)
> =C2=A0=C2=A0=C2=A0 at pthread_create.c:308
> #20 0x00007f84436c134d in clone ()
> =C2=A0=C2=A0=C2=A0 at ../sysdeps/unix/sysv/linux/x86_64/clone.S:113
>=20
>=20
>=20
>>>     ide_data_readw
>> How do we get here? ide_is_pio_out ought to be false here; do you know
>> what command was being processed? Do you have a reproducer?
>>
>> Knowing both the ATA and ATAPI commands under consideration here would
>> be helpful.
>>
>=20
> if you prefer, I can upload core/binary to some storage.
> Here is the state.
>=20

This might be helpful for me to poke around at, but unfortunately it
looks like I can't see the ATAPI command that was being processed from
the trace given. I don't think there's a way for me to retrieve it from
a core, either.

> (gdb) p *s
> $3 =3D {bus =3D 0x55b22a7129f0, unit =3D 0 '\000', drive_kind =3D IDE_C=
D,
> =C2=A0 cylinders =3D 0, heads =3D 0, sectors =3D 0, chs_trans =3D 0, nb=
_sectors =3D
> 11588488,
> =C2=A0 mult_sectors =3D 16, identify_set =3D 1,
> =C2=A0 identify_data =3D "\300\205", '\000' <repeats 18 times>, "MQ0000=
 1", ' '
> <repeats 12 times>, "\003\000\000\002\004\000.2+5=C2=A0=C2=A0=C2=A0 EQU=
MD DVR-MO", ' '
> <repeats 28 times>,
> "\000\000\001\000\000\003\000\000\000\000\000\000\a", '\000' <repeats 1=
7
> times>,
> "\a\000\a\000\003\000\264\000\264\000,\001\264\000\000\000\000\000\036\=
000\036",
> '\000' <repeats 15 times>, "\036", '\000' <repeats 15 times>, "? ",
> '\000' <repeats 333 times>, drive_serial =3D 1,
> =C2=A0 drive_serial_str =3D "QM00001", '\000' <repeats 13 times>,
> =C2=A0 drive_model_str =3D "QEMU DVD-ROM", '\000' <repeats 28 times>, w=
wn =3D 0,
> =C2=A0 feature =3D 0 '\000', error =3D 0 '\000', nsector =3D 2, sector =
=3D 0 '\000',
> =C2=A0 lcyl =3D 0 '\000', hcyl =3D 8 '\b', hob_feature =3D 0 '\000',
> =C2=A0 hob_nsector =3D 3 '\003', hob_sector =3D 0 '\000', hob_lcyl =3D =
0 '\000',
> =C2=A0 hob_hcyl =3D 8 '\b', select =3D 32 ' ', status =3D 80 'P', lba48=
 =3D 0 '\000',

status =3D BUSY_STAT
nsector =3D ATAPI_INT_REASON_IO (set in ide_atapi_cmd_reply_end)
byte_count_limit =3D 2048 (hcyl << 8)

> =C2=A0 blk =3D 0x55b2265405a0, version =3D "2.5+\000\000\000\000", even=
ts =3D {
> =C2=A0=C2=A0=C2=A0 eject_request =3D false, new_media =3D false}, sense=
_key =3D 0 '\000',
> =C2=A0 asc =3D 0 '\000', tray_open =3D false, tray_locked =3D false,
> =C2=A0 cdrom_changed =3D 0 '\000', packet_transfer_size =3D 55296,
> =C2=A0 elementary_transfer_size =3D 0, io_buffer_index =3D 2048, lba =3D=
 139220,

packet_transfer_size =3D 55296, (27 cd sectors)
elementary_transfer_size =3D 0,
io_buffer_index =3D 2048,
lba =3D 139220, or 0x021fd4


This is either an initial read request, or a rebuffering.
In the normative case, initial reads look like this:

IDE:
ide_ioport_write
  ide_exec_cmd (0xA0)
    cmd_packet
      ide_transfer_start
        s->end_transfer_func =3D ide_atapi_cmd
        [data_ptr and data_end set to meaningful values]
[Return to guest, await PIO write of scsi cdb]
ide_data_writew
  ide_atapi_cmd
    [soft error if !blk->bs]
    cmd_read_cd
      ide_atapi_cmd_read
        ide_atapi_cmd_read_pio
          ide_atapi_cmd_reply_end
            cd_read_sector
              [segv if !blk->bs]

AHCI:
handle_reg_h2d_fis
  [scsi CDB is copied into s->io_buffer]
  ide_exec_cmd
    cmd_packet
      ide_transfer_start
        [data_ptr and data_end set to transfer scsi cdb]
          ahci_start_transfer
            [shortcut, no transfer]
            s->data_ptr set to s->data_end [*]
              ide_atapi_cmd

* (but data_end likely is still !=3D s->io_buffer)

from here the callback is the same as above: we'll wind up at
cd_read_sector. Neither of these cases match your traceback.

If it was the initial buffering, it would have occurred synchronously
with receipt of the SCSI CDB, but your traces place it as a consequence
of an attempt to read data, so that makes me suspect it's a rebuffering
attempt, and the data in s->io_buffer is... cd data? I guess? did you
have a CD in here at one point?

> =C2=A0 cd_sector_size =3D 2048, atapi_dma =3D 0, acct =3D {bytes =3D 20=
48,

So we're using PIO paths when applicable. The s->feature register being
0 seems to agree.

> =C2=A0=C2=A0=C2=A0 start_time_ns =3D 433417215764666, type =3D BLOCK_AC=
CT_READ}, pio_aiocb
> =3D 0x0,
> =C2=A0 iov =3D {iov_base =3D 0x55b22a8ae000, iov_len =3D 2048}, qiov =3D=
 {
> =C2=A0=C2=A0=C2=A0 iov =3D 0x55b22a712d50, niov =3D 1, nalloc =3D -1, s=
ize =3D 2048},
> =C2=A0 buffered_requests =3D {lh_first =3D 0x0}, io_buffer_offset =3D 0=
,
> =C2=A0 io_buffer_size =3D 0, sg =3D {sg =3D 0x0, nsg =3D 0, nalloc =3D =
0, size =3D 0,
> =C2=A0=C2=A0=C2=A0 dev =3D 0x0, as =3D 0x0}, req_nb_sectors =3D 0,
> =C2=A0 end_transfer_func =3D 0x55b22404e190 <ide_atapi_cmd_reply_end>,
> =C2=A0 data_ptr =3D 0x55b22a8ae800 "", data_end =3D 0x55b22a8ae800 "",
> =C2=A0 io_buffer =3D 0x55b22a8ae000

s->data_ptr  =3D 0x55b22a8ae800
s->data_end  =3D 0x55b22a8ae800
s->io_buffer =3D 0x55b22a8ae000
s->io_buffer_offset =3D 0

Uh, hm. This does not look like an in-progress PIO transfer of any kind..=
.

This says to me that ide_dummy_transfer_stop was called at some point
and nothing has started up in its place.

This seems to conflict with the trace, which looks like a rebuffering.
This looks like... undefined behavior entirely. I am not sure I have a
good guess as to what's happening.

> ")8\"\t\031\"\232\vx.\311l\301\270o$\335\025\257\064F\271\rI,R\342\032\=
315\n=D4=86V\341od\251\023>\024\370\323\060A\256\337\300=ED=85=8B\024\233=
\201U\221T^\202\303\036\"E%\262\230\367=CE=BE\fW\302\360\277\347\334\022\=
253\a\025\216\rj\334z\355>)\230/\021\255%a^\306\001\032",

... hmm

0x29 56 34 09 19

0x29 is... almost a read command (0x28) but it isn't. 0x29 shouldn't map
to anything, actually. So this must be data we've buffered, or something
left over from god knows what.

>=20
> =C2=A0 io_buffer_total_len =3D 131076, cur_io_buffer_offset =3D 0,
> =C2=A0 cur_io_buffer_len =3D 0, end_transfer_fn_idx =3D 0 '\000',
> =C2=A0 sector_write_timer =3D 0x55b22a45d5c0, irq_count =3D 0, ext_erro=
r =3D 0 '\000',
> =C2=A0 mdata_size =3D 0, mdata_storage =3D 0x0, media_changed =3D 0,
> =C2=A0 dma_cmd =3D IDE_DMA_READ, smart_enabled =3D 1 '\001', smart_auto=
save =3D 1
> '\001',
> =C2=A0 smart_errors =3D 0, smart_selftest_count =3D 0 '\000',
> ---Type <return> to continue, or q <return> to quit---
> =C2=A0 smart_selftest_data =3D 0x55b22a827000 "", ncq_queues =3D 0}
> (gdb)
>=20
> In general, I can upload the binary and core to the location
> you want. Send it to me in person. By the way. I am staring to
> receive these crashes in number. 2-3 in a day BUT from one
> specific host. This could be important.
>=20
>>>     portio_read
>>>     memory_region_read_accessor
>>>     access_with_adjusted_size
>>>     memory_region_dispatch_read1
>>>     memory_region_dispatch_read
>>>     address_space_read_continue
>>>     address_space_read_full
>>>     address_space_read
>>>     address_space_rw
>>>     kvm_handle_io
>>>     kvm_cpu_exec
>>>     qemu_kvm_cpu_thread_fn
>>>     start_thread
>>>     clone
>> The thing that looks to be incongruent here is that we appear to be
>> servicing a ATAPI reply; that reply is either the kind that uses
>> preformatted data in a buffer, or the kind that buffers a read.
>>
>> If it buffers a read, it should require CHECK_READY which requires a m=
edium.
>>
>> If it does not buffer a read, it should not be able to invoke
>> cd_read_sector or any bdrv function from ide_data_readw.
>>
>> If it neither serves preformatted data nor buffers a read, it should n=
ot
>> allow ide_data_readw to perform any action at all.
> the guest could misbehave! This is not a reason to crash.
> For example there is a race or something like this. What
> if the guest will execute read from the device without
> ANY sanity checks? QEMU should not crash. This is the point
> and this is the approach taken in the original patch.
>=20

The stuff quoted above isn't participatory, it's mandatory. I don't know
how we're bypassing CHECK_READY. I want to understand what's happening
before I pepper in sanity checks.

in 2.9.0, you have this code:

    if ((cmd->flags & CHECK_READY) &&
        (!media_present(s) || !blk_is_inserted(s->blk)))
    {
        ide_atapi_cmd_error(s, NOT_READY, ASC_MEDIUM_NOT_PRESENT);
        return;
    }

with media_present defined as:

static inline int media_present(IDEState *s)
{
    return !s->tray_open && s->nb_sectors > 0;
}

... however, from your gdb output, we do have:

tray_open =3D false
nb_sectors =3D 11588488

but blk_is_inserted is still going to check for the presence of 'bs'
attached to the Block Backend, so this check should still prevent us
from executing a read command out of the gate.

Is the guest executing a read and then are we racing with the removal of
the bds? Do you expect a CD to be inserted on this guest?

nb_sectors I would expect to be 0; based on ide_cd_change_cb:

    blk_get_geometry(s->blk, &nb_sectors);

this should set nb_sectors to 0 if there's no blk->bs.

I'm sort of lost, I can't really easily construct what exactly happened
here.

>=20
>>> Indeed, the CDROM device without media has blk->bs =3D=3D NULL. We sh=
ould
>>> check that the media is really available for the device like has been=
 done
>>> in SCSI code.
>>>
>>> May be the patch adds a bit more check than necessary, but this is no=
t be
>>> the problem. We should always stay on the safe side.
>>>
>>> Signed-off-by: Denis V. Lunev <den@openvz.org>
>>> CC: John Snow <jsnow@redhat.com>
>>> CC: Kevin Wolf <kwolf@redhat.com>
>>> CC: Stefan Hajnoczi <stefanha@redhat.com>
>>> ---
>>>  hw/ide/atapi.c | 32 ++++++++++++++++++++++++++++----
>>>  hw/ide/core.c  |  4 ++--
>>>  2 files changed, 30 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/hw/ide/atapi.c b/hw/ide/atapi.c
>>> index c0509c8bf5..fa50c0ccf6 100644
>>> --- a/hw/ide/atapi.c
>>> +++ b/hw/ide/atapi.c
>>> @@ -119,6 +119,11 @@ cd_read_sector_sync(IDEState *s)
>>> =20
>>>      trace_cd_read_sector_sync(s->lba);
>>> =20
>>> +    if (!blk_is_available(s->blk)) {
>>> +        ret =3D -ENOMEDIUM;
>>> +        goto fail;
>>> +    }
>>> +
>>>      switch (s->cd_sector_size) {
>>>      case 2048:
>>>          ret =3D blk_pread(s->blk, (int64_t)s->lba << ATAPI_SECTOR_BI=
TS,
>>> @@ -132,8 +137,8 @@ cd_read_sector_sync(IDEState *s)
>>>          }
>>>          break;
>>>      default:
>>> -        block_acct_invalid(blk_get_stats(s->blk), BLOCK_ACCT_READ);
>>> -        return -EIO;
>>> +        ret =3D -EIO;
>>> +        goto fail;
>>>      }
>>> =20
>>>      if (ret < 0) {
>>> @@ -145,6 +150,10 @@ cd_read_sector_sync(IDEState *s)
>>>      }
>>> =20
>>>      return ret;
>>> +
>>> +fail:
>>> +    block_acct_invalid(blk_get_stats(s->blk), BLOCK_ACCT_READ);
>>> +    return ret;
>>>  }
>>> =20
>>>  static void cd_read_sector_cb(void *opaque, int ret)
>>> @@ -174,9 +183,15 @@ static void cd_read_sector_cb(void *opaque, int =
ret)
>>> =20
>>>  static int cd_read_sector(IDEState *s)
>>>  {
>>> +    int err;
>>> +
>>>      if (s->cd_sector_size !=3D 2048 && s->cd_sector_size !=3D 2352) =
{
>>> -        block_acct_invalid(blk_get_stats(s->blk), BLOCK_ACCT_READ);
>>> -        return -EINVAL;
>>> +        err =3D -EINVAL;
>>> +        goto fail;
>>> +    }
>>> +    if (!blk_is_available(s->blk)) {
>>> +        err =3D -ENOMEDIUM;
>>> +        goto fail;
>>>      }
>>> =20
>>>      s->iov.iov_base =3D (s->cd_sector_size =3D=3D 2352) ?
>>> @@ -195,6 +210,10 @@ static int cd_read_sector(IDEState *s)
>>> =20
>>>      s->status |=3D BUSY_STAT;
>>>      return 0;
>>> +
>>> +fail:
>>> +    block_acct_invalid(blk_get_stats(s->blk), BLOCK_ACCT_READ);
>>> +    return err;
>>>  }
>>> =20
>>>  void ide_atapi_cmd_ok(IDEState *s)
>>> @@ -404,6 +423,11 @@ static void ide_atapi_cmd_read_dma_cb(void *opaq=
ue, int ret)
>>>          goto eot;
>>>      }
>>> =20
>>> +    if (!blk_is_available(s->blk)) {
>>> +        ide_atapi_cmd_read_dma_cb(s, -ENOMEDIUM);
>>> +        return;
>>> +    }
>>> +
>> I'm not sure this is OK, because it's an error but not setting the sen=
se
>> code or raising an IRQ; it's only calling ide_set_inactive, so this
>> might be a problem. Normally the error code from the data read is
>> handled earlier in the call by ide_handle_rw_error which can set the
>> proper codes.
>>
> this follows the approach used by the error handling in this call.
> I this code is not made worse. We can hit to the same processing
> with the different error upper.
>=20
>>>      s->io_buffer_index =3D 0;
>>>      if (s->cd_sector_size =3D=3D 2352) {
>>>          n =3D 1;
>>> diff --git a/hw/ide/core.c b/hw/ide/core.c
>>> index 471d0c928b..71780fc9d1 100644
>>> --- a/hw/ide/core.c
>>> +++ b/hw/ide/core.c
>>> @@ -758,7 +758,7 @@ static void ide_sector_read(IDEState *s)
>>> =20
>>>      trace_ide_sector_read(sector_num, n);
>>> =20
>>> -    if (!ide_sect_range_ok(s, sector_num, n)) {
>>> +    if (!ide_sect_range_ok(s, sector_num, n) || !blk_is_available(s-=
>blk)) {
>>>          ide_rw_error(s);
>>>          block_acct_invalid(blk_get_stats(s->blk), BLOCK_ACCT_READ);
>>>          return;
>>> @@ -1023,7 +1023,7 @@ static void ide_sector_write(IDEState *s)
>>> =20
>>>      trace_ide_sector_write(sector_num, n);
>>> =20
>>> -    if (!ide_sect_range_ok(s, sector_num, n)) {
>>> +    if (!ide_sect_range_ok(s, sector_num, n) || !blk_is_available(s-=
>blk)) {
>>>          ide_rw_error(s);
>>>          block_acct_invalid(blk_get_stats(s->blk), BLOCK_ACCT_WRITE);
>>>          return;
>>>
>> Since it's not a new regression (this is being reported against 2.9) I
>> am somewhat hesitant to rush it into 2.11-rc3 without a little more in=
fo.
>>
>> That said, here's a list of the ATAPI commands we service that either
>> return or CAN return data, but do not enforce CHECK_READY:
>>
>>     [ 0x03 ] =3D { cmd_request_sense,                 ALLOW_UA },
>>     [ 0x12 ] =3D { cmd_inquiry,                       ALLOW_UA },
>>     [ 0x46 ] =3D { cmd_get_configuration,             ALLOW_UA },
>>     [ 0x4a ] =3D { cmd_get_event_status_notification, ALLOW_UA },
>>     [ 0x5a ] =3D { cmd_mode_sense, /* (10) */         0 },
>>     [ 0xbd ] =3D { cmd_mechanism_status,              0 },
>>
>> These six all invoke ide_atapi_cmd_reply in some way (which allows the
>> guest to begin reading the reply via PIO mechanisms if DMA is not set)=
:
>>
>> cmd_request_sense:     ide_atapi_cmd_reply(s, 18, max_len);
>> cmd_inquiry:           ide_atapi_cmd_reply(s, idx, max_len);
>> cmd_get_configuration: ide_atapi_cmd_reply(s, len, max_len);
>> cmd_get_event_status_notification:
>>                        ide_atapi_cmd_reply(s, used_len, max_len);
>> cmd_mode_sense:        ide_atapi_cmd_reply(s, 16, max_len);
>>                        ide_atapi_cmd_reply(s, 24, max_len);
>>                        ide_atapi_cmd_reply(s, 30, max_len);
>> cmd_mechanism_status:  ide_atapi_cmd_reply(s, 8, max_len);
>>
>> ide_atapi_cmd_reply itself sets lba to -1, which should inform
>> ide_atapi_cmd_reply_end not to attempt to buffer any new data. These
>> *should* be safe. The reply sizes are also all small enough that they
>> are almost certainly getting buffered in one single transfer without
>> attempting to buffer more data.
>>
>> In the normative PIO case then, reads will consume from this buffer
>> until empty, then we'll call ide_atapi_cmd_reply_end through
>> end_transfer_func and hit the end of transfer logic.
>>
>> I'm not sure I see how this crash is happening; it doesn't look like
>> this path allows for invoking the block read functions and everything
>> else is guarded by NONDATA or CHECK_READY.
>>
>> Unless this is an interesting interaction with ide_atapi_cmd_reply
>> setting the DRQ bit which may trick the pio read function to allow PIO
>> reads to come in during this time?
>>
>> Hypothetically:
>>
>> cmd_packet sets end_transfer_func to ide_atapi_cmd so it can process
>> further once that PIO is completed. (The PIO may be emulated
>> synchronously, in the case of AHCI.) In the true PIO case, it may be
>> asynchronous.
>>
>> Now, in the AHCI case, the guest has control back and the CDROM is now
>> executing a command to, perhaps, read data via DMA. Then,
>> simultaneously, the guest issues a PIO read and because the DRQ bit is
>> set for DMA, the PIO read also goes through.
>>
>> This still requires a media, though... and a very broken guest doing
>> something naughty on purpose.
>>
>> I can't quite connect the dots to see how this crash is possible in
>> general... it'd help to have:
>>
>> - The ATAPI command being processed at the time
>> - The IDE command being processed at the time
>> - s->status
>>
>> as a minimum, and then perhaps optionally some of the ATAPI loop
>> variables, like packet_transfer_size, elementary_transfer_size, and
>> io_buffer_index. Or a reproducer!
>>
>> Sorry I'm not more help and I wrote too much again :(
> imho this does not matter. Once again - the guest can misbehave.

I never said that if a guest acting out of spec was the problem I
wouldn't fix it. I just want to find the root cause.

If this has been broken since 2.9, 2.11-rc3 is too late for a bandaid
applied to something I can't diagnose. Let's discuss this for 2.12 and I
will keep trying to figure out what the root cause is.


Some questions for you:

(1) Is the guest Linux? Do we know why this one machine might be
tripping up QEMU? (Is it running a fuzzer, a weird OS, etc...?)
(2) Does the VM actually have a CDROM inserted at some point? Is it
possible we're racing on some kind of eject or graph manipulation failure=
?
(3) Is this using AHCI or IDE?


If I can't figure it out within a week or so from here I'll just check
in the band-aid with some /* FIXME */ comments attached.

--js
