Received: from eggs.gnu.org ([2001:4830:134:3::10]:39088)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fG65I-0005zZ-3A
	for qemu-devel@nongnu.org; Tue, 08 May 2018 13:07:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fG65E-0003qV-N0
	for qemu-devel@nongnu.org; Tue, 08 May 2018 13:07:28 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:54306 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1fG65E-0003ow-Hi
	for qemu-devel@nongnu.org; Tue, 08 May 2018 13:07:24 -0400
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <1525701137-9384-1-git-send-email-lidongchen@tencent.com> (Lidong
	Chen's message of "Mon, 7 May 2018 21:52:16 +0800")
References: <1525701137-9384-1-git-send-email-lidongchen@tencent.com>
Reply-To: quintela@redhat.com
Date: Tue, 08 May 2018 19:09:30 +0200
Message-ID: <87muxa6pmd.fsf@secure.laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
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
To: Lidong Chen <jemmy858585@gmail.com>
Cc: dgilbert@redhat.com, berrange@redhat.com, qemu-devel@nongnu.org, galsha@mellanox.com, aviadye@mellanox.com, adido@mellanox.com, Lidong Chen <lidongchen@tencent.com>

Lidong Chen <jemmy858585@gmail.com> wrote:
> if qio_channel_rdma_readv return QIO_CHANNEL_ERR_BLOCK, the destination q=
emu
> crash.
>
> The backtrace is:
> (gdb) bt
>     #0  0x0000000000000000 in ?? ()
>     #1  0x00000000008db50e in qio_channel_set_aio_fd_handler (ioc=3D0x381=
11e0, ctx=3D0x3726080,
>         io_read=3D0x8db841 <qio_channel_restart_read>, io_write=3D0x0, op=
aque=3D0x38111e0) at io/channel.c:
>     #2  0x00000000008db952 in qio_channel_set_aio_fd_handlers (ioc=3D0x38=
111e0) at io/channel.c:438
>     #3  0x00000000008dbab4 in qio_channel_yield (ioc=3D0x38111e0, conditi=
on=3DG_IO_IN) at io/channel.c:47
>     #4  0x00000000007a870b in channel_get_buffer (opaque=3D0x38111e0, buf=
=3D0x440c038 "", pos=3D0, size=3D327
>         at migration/qemu-file-channel.c:83
>     #5  0x00000000007a70f6 in qemu_fill_buffer (f=3D0x440c000) at migrati=
on/qemu-file.c:299
>     #6  0x00000000007a79d0 in qemu_peek_byte (f=3D0x440c000, offset=3D0) =
at migration/qemu-file.c:562
>     #7  0x00000000007a7a22 in qemu_get_byte (f=3D0x440c000) at migration/=
qemu-file.c:575
>     #8  0x00000000007a7c78 in qemu_get_be32 (f=3D0x440c000) at migration/=
qemu-file.c:655
>     #9  0x00000000007a0508 in qemu_loadvm_state (f=3D0x440c000) at migrat=
ion/savevm.c:2126
>     #10 0x0000000000794141 in process_incoming_migration_co (opaque=3D0x0=
) at migration/migration.c:366
>     #11 0x000000000095c598 in coroutine_trampoline (i0=3D84033984, i1=3D0=
) at util/coroutine-ucontext.c:1
>     #12 0x00007f9c0db56d40 in ?? () from /lib64/libc.so.6
>     #13 0x00007f96fe858760 in ?? ()
>     #14 0x0000000000000000 in ?? ()
>
> RDMA QIOChannel not implement io_set_aio_fd_handler. so
> qio_channel_set_aio_fd_handler will access NULL pointer.
>
> Signed-off-by: Lidong Chen <lidongchen@tencent.com>
> ---


Hi

could you resend, it don't compile for me :-(


/mnt/kvm/qemu/cleanup/migration/rdma.c: In function =E2=80=98qio_channel_rd=
ma_set_aio_fd_handler=E2=80=99:
/mnt/kvm/qemu/cleanup/migration/rdma.c:2877:39: error: =E2=80=98QIOChannelR=
DMA=E2=80=99 {aka =E2=80=98struct QIOChannelRDMA=E2=80=99} has no member na=
med =E2=80=98rdmain=E2=80=99; did you mean =E2=80=98rdma=E2=80=99?
         aio_set_fd_handler(ctx, rioc->rdmain->comp_channel->fd,
                                       ^~~~~~
                                       rdma
/mnt/kvm/qemu/cleanup/migration/rdma.c:2880:39: error: =E2=80=98QIOChannelR=
DMA=E2=80=99 {aka =E2=80=98struct QIOChannelRDMA=E2=80=99} has no member na=
med =E2=80=98rdmaout=E2=80=99; did you mean =E2=80=98rdma=E2=80=99?
         aio_set_fd_handler(ctx, rioc->rdmaout->comp_channel->fd,
                                       ^~~~~~~
                                       rdma
make: *** [/mnt/kvm/qemu/cleanup/rules.mak:66: migration/rdma.o] Error 1
  CC      migration/block.o
  CC      ui/vnc.o

It seems like

> diff --git a/migration/rdma.c b/migration/rdma.c
> index 92e4d30..dfa4f77 100644
> --- a/migration/rdma.c
> +++ b/migration/rdma.c
> @@ -2963,6 +2963,21 @@ static GSource *qio_channel_rdma_create_watch(QIOC=
hannel *ioc,
>      return source;
>  }
>=20=20
> +static void qio_channel_rdma_set_aio_fd_handler(QIOChannel *ioc,
> +                                                  AioContext *ctx,
> +                                                  IOHandler *io_read,
> +                                                  IOHandler *io_write,
> +                                                  void *opaque)
> +{
> +    QIOChannelRDMA *rioc =3D QIO_CHANNEL_RDMA(ioc);
> +    if (io_read) {
> +        aio_set_fd_handler(ctx, rioc->rdmain->comp_channel->fd,

        this should be rioc->rdam->comp_channel

> +                           false, io_read, io_write, NULL, opaque);
> +    } else {
> +        aio_set_fd_handler(ctx, rioc->rdmaout->comp_channel->fd,

and this rioc-rdma->comp_channel

But will preffer if you confirm.

Thanks.
