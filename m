Received: from eggs.gnu.org ([2001:4830:134:3::10]:33643)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jemmy858585@gmail.com>) id 1fGGRe-0004bI-AQ
	for qemu-devel@nongnu.org; Wed, 09 May 2018 00:11:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jemmy858585@gmail.com>) id 1fGGRd-0001FS-25
	for qemu-devel@nongnu.org; Wed, 09 May 2018 00:11:14 -0400
Received: from mail-it0-x244.google.com ([2607:f8b0:4001:c0b::244]:33666)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jemmy858585@gmail.com>)
	id 1fGGRc-0001Ej-Qf
	for qemu-devel@nongnu.org; Wed, 09 May 2018 00:11:12 -0400
Received: by mail-it0-x244.google.com with SMTP id t7-v6so15793430itf.0
	for <qemu-devel@nongnu.org>; Tue, 08 May 2018 21:11:12 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180508171021.GR2500@work-vm>
References: <1525701137-9384-1-git-send-email-lidongchen@tencent.com>
	<87muxa6pmd.fsf@secure.laptop> <20180508171021.GR2500@work-vm>
From: 858585 jemmy <jemmy858585@gmail.com>
Date: Wed, 9 May 2018 12:11:11 +0800
Message-ID: <CAOGPPbc332NMJkqJsMQ-xsjK-nM1g-Wme9CAvq+VZvnJ_bJyDA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 1/2] migration: implement
 io_set_aio_fd_handler function for RDMA QIOChannel
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Juan Quintela <quintela@redhat.com>
Cc: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, Gal Shachaf <galsha@mellanox.com>, Aviad Yehezkel <aviadye@mellanox.com>, adido@mellanox.com, Lidong Chen <lidongchen@tencent.com>

On Wed, May 9, 2018 at 1:10 AM, Dr. David Alan Gilbert
<dgilbert@redhat.com> wrote:
> * Juan Quintela (quintela@redhat.com) wrote:
>> Lidong Chen <jemmy858585@gmail.com> wrote:
>> > if qio_channel_rdma_readv return QIO_CHANNEL_ERR_BLOCK, the destinatio=
n qemu
>> > crash.
>> >
>> > The backtrace is:
>> > (gdb) bt
>> >     #0  0x0000000000000000 in ?? ()
>> >     #1  0x00000000008db50e in qio_channel_set_aio_fd_handler (ioc=3D0x=
38111e0, ctx=3D0x3726080,
>> >         io_read=3D0x8db841 <qio_channel_restart_read>, io_write=3D0x0,=
 opaque=3D0x38111e0) at io/channel.c:
>> >     #2  0x00000000008db952 in qio_channel_set_aio_fd_handlers (ioc=3D0=
x38111e0) at io/channel.c:438
>> >     #3  0x00000000008dbab4 in qio_channel_yield (ioc=3D0x38111e0, cond=
ition=3DG_IO_IN) at io/channel.c:47
>> >     #4  0x00000000007a870b in channel_get_buffer (opaque=3D0x38111e0, =
buf=3D0x440c038 "", pos=3D0, size=3D327
>> >         at migration/qemu-file-channel.c:83
>> >     #5  0x00000000007a70f6 in qemu_fill_buffer (f=3D0x440c000) at migr=
ation/qemu-file.c:299
>> >     #6  0x00000000007a79d0 in qemu_peek_byte (f=3D0x440c000, offset=3D=
0) at migration/qemu-file.c:562
>> >     #7  0x00000000007a7a22 in qemu_get_byte (f=3D0x440c000) at migrati=
on/qemu-file.c:575
>> >     #8  0x00000000007a7c78 in qemu_get_be32 (f=3D0x440c000) at migrati=
on/qemu-file.c:655
>> >     #9  0x00000000007a0508 in qemu_loadvm_state (f=3D0x440c000) at mig=
ration/savevm.c:2126
>> >     #10 0x0000000000794141 in process_incoming_migration_co (opaque=3D=
0x0) at migration/migration.c:366
>> >     #11 0x000000000095c598 in coroutine_trampoline (i0=3D84033984, i1=
=3D0) at util/coroutine-ucontext.c:1
>> >     #12 0x00007f9c0db56d40 in ?? () from /lib64/libc.so.6
>> >     #13 0x00007f96fe858760 in ?? ()
>> >     #14 0x0000000000000000 in ?? ()
>> >
>> > RDMA QIOChannel not implement io_set_aio_fd_handler. so
>> > qio_channel_set_aio_fd_handler will access NULL pointer.
>> >
>> > Signed-off-by: Lidong Chen <lidongchen@tencent.com>
>> > ---
>>
>>
>> Hi
>>
>> could you resend, it don't compile for me :-(
>
> This really sits after the other set of rdma changes.
> I doubt this path is reachable without the previous set.
>
> Dave

Hi Juan:
    I should not separate the patchset.  Sorry for this mistake. This
patch is base on another patch.
    http://patchwork.ozlabs.org/patch/909156/
    After Daniel have reviewed this patch, I will send the v4 version
which will include all patch for RDMA live migration.
    Thanks.

>>
>> /mnt/kvm/qemu/cleanup/migration/rdma.c: In function =E2=80=98qio_channel=
_rdma_set_aio_fd_handler=E2=80=99:
>> /mnt/kvm/qemu/cleanup/migration/rdma.c:2877:39: error: =E2=80=98QIOChann=
elRDMA=E2=80=99 {aka =E2=80=98struct QIOChannelRDMA=E2=80=99} has no member=
 named =E2=80=98rdmain=E2=80=99; did you mean =E2=80=98rdma=E2=80=99?
>>          aio_set_fd_handler(ctx, rioc->rdmain->comp_channel->fd,
>>                                        ^~~~~~
>>                                        rdma
>> /mnt/kvm/qemu/cleanup/migration/rdma.c:2880:39: error: =E2=80=98QIOChann=
elRDMA=E2=80=99 {aka =E2=80=98struct QIOChannelRDMA=E2=80=99} has no member=
 named =E2=80=98rdmaout=E2=80=99; did you mean =E2=80=98rdma=E2=80=99?
>>          aio_set_fd_handler(ctx, rioc->rdmaout->comp_channel->fd,
>>                                        ^~~~~~~
>>                                        rdma
>> make: *** [/mnt/kvm/qemu/cleanup/rules.mak:66: migration/rdma.o] Error 1
>>   CC      migration/block.o
>>   CC      ui/vnc.o
>>
>> It seems like
>>
>> > diff --git a/migration/rdma.c b/migration/rdma.c
>> > index 92e4d30..dfa4f77 100644
>> > --- a/migration/rdma.c
>> > +++ b/migration/rdma.c
>> > @@ -2963,6 +2963,21 @@ static GSource *qio_channel_rdma_create_watch(Q=
IOChannel *ioc,
>> >      return source;
>> >  }
>> >
>> > +static void qio_channel_rdma_set_aio_fd_handler(QIOChannel *ioc,
>> > +                                                  AioContext *ctx,
>> > +                                                  IOHandler *io_read,
>> > +                                                  IOHandler *io_write=
,
>> > +                                                  void *opaque)
>> > +{
>> > +    QIOChannelRDMA *rioc =3D QIO_CHANNEL_RDMA(ioc);
>> > +    if (io_read) {
>> > +        aio_set_fd_handler(ctx, rioc->rdmain->comp_channel->fd,
>>
>>         this should be rioc->rdam->comp_channel
>>
>> > +                           false, io_read, io_write, NULL, opaque);
>> > +    } else {
>> > +        aio_set_fd_handler(ctx, rioc->rdmaout->comp_channel->fd,
>>
>> and this rioc-rdma->comp_channel
>>
>> But will preffer if you confirm.
>>
>> Thanks.
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
