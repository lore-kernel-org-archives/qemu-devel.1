Received: from eggs.gnu.org ([2001:4830:134:3::10]:52807)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jemmy858585@gmail.com>) id 1fCHHt-0004zC-4l
	for qemu-devel@nongnu.org; Sat, 28 Apr 2018 00:16:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jemmy858585@gmail.com>) id 1fCHHr-0006VU-Cb
	for qemu-devel@nongnu.org; Sat, 28 Apr 2018 00:16:41 -0400
Received: from mail-it0-x232.google.com ([2607:f8b0:4001:c0b::232]:55329)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jemmy858585@gmail.com>)
	id 1fCHHr-0006Ul-5F
	for qemu-devel@nongnu.org; Sat, 28 Apr 2018 00:16:39 -0400
Received: by mail-it0-x232.google.com with SMTP id 144-v6so4310071iti.5
	for <qemu-devel@nongnu.org>; Fri, 27 Apr 2018 21:16:37 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180427091603.GD32172@redhat.com>
References: <1524666934-8064-1-git-send-email-lidongchen@tencent.com>
	<1524666934-8064-5-git-send-email-lidongchen@tencent.com>
	<20180426173641.GN2631@work-vm>
	<CAOGPPbcPb4F2m_o4jPn2ELRK19=Yr=P+QRi4r_-eVhzmV0d5kA@mail.gmail.com>
	<20180427091603.GD32172@redhat.com>
From: 858585 jemmy <jemmy858585@gmail.com>
Date: Sat, 28 Apr 2018 12:16:36 +0800
Message-ID: <CAOGPPbcG4-FiV1d134g5YA8z4cNrdzELED3rpR+NrJzc2OfwcA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 4/5] migration: implement bi-directional
 RDMA QIOChannel
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Juan Quintela <quintela@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, Gal Shachaf <galsha@mellanox.com>, Aviad Yehezkel <aviadye@mellanox.com>, licq@mellanox.com, adido@mellanox.com, Lidong Chen <lidongchen@tencent.com>

On Fri, Apr 27, 2018 at 5:16 PM, Daniel P. Berrang=C3=A9 <berrange@redhat.c=
om> wrote:
> On Fri, Apr 27, 2018 at 03:56:38PM +0800, 858585 jemmy wrote:
>> On Fri, Apr 27, 2018 at 1:36 AM, Dr. David Alan Gilbert
>> <dgilbert@redhat.com> wrote:
>> > * Lidong Chen (jemmy858585@gmail.com) wrote:
>> >> This patch implements bi-directional RDMA QIOChannel. Because differe=
nt
>> >> threads may access RDMAQIOChannel concurrently, this patch use RCU to=
 protect it.
>> >>
>> >> Signed-off-by: Lidong Chen <lidongchen@tencent.com>
>> >
>> > I'm a bit confused by this.
>> >
>> > I can see it's adding RCU to protect the rdma structures against
>> > deletion from multiple threads; that I'm OK with in principal; is that
>> > the only locking we need? (I guess the two directions are actually
>> > separate RDMAContext's so maybe).
>>
>> The qio_channel_rdma_close maybe invoked by migration thread and
>> return path thread
>> concurrently, so I use a mutex to protect it.
>
> Hmm, that is not good - concurrent threads calling close must not be
> allowed to happen even with non-RDMA I/O chanels.
>
> For example, with the QIOChannelSocket, one thread can call close
> which sets the fd =3D -1, another thread can race with this and either
> end up calling close again on the same FD or calling close on -1.
> Either way the second thread will get an error from close() when
> it should have skipped the close() and returned success. Perhaps
> migration gets lucky and this doesn't result in it being marked
> as failed, but it is still not good.
>
> So only one thread should be calling close().

for live migration, source qemu invokes qemu_fclose in different
threads, include main thread,
migration thread, return path thread.
destination qemu invokes qemu_fclose in main thread, listen thread and
COLO incoming thread.

so I prefer to add a lock for QEMUFile struct, like this:

int qemu_fclose(QEMUFile *f)
{
    int ret;
    qemu_fflush(f);
    ret =3D qemu_file_get_error(f);

    if (f->ops->close) {
+        qemu_mutex_lock(&f->lock);
        int ret2 =3D f->ops->close(f->opaque);
+       qemu_mutex_unlock(&f->lock);
        if (ret >=3D 0) {
            ret =3D ret2;
        }
    }
    /* If any error was spotted before closing, we should report it
     * instead of the close() return value.
     */
    if (f->last_error) {
        ret =3D f->last_error;
    }
    g_free(f);
    trace_qemu_file_fclose();
    return ret;
}

Any suggestion?

>
>> If one thread invoke qio_channel_rdma_writev, another thread invokes
>> qio_channel_rdma_readv,
>> two threads will use separate RDMAContext, so it does not need a lock.
>>
>> If two threads invoke qio_channel_rdma_writev concurrently, it will
>> need a lock to protect.
>> but I find source qemu migration thread only invoke
>> qio_channel_rdma_writev, the return path
>> thread only invokes qio_channel_rdma_readv.
>
> QIOChannel impls are only intended to cope with a single thread doing
> I/O in each direction. If you have two threads needing to read, or
> two threads needing to write, the layer above should provide locking
> to ensure correct ordering  of I/O oprations.

yes, so I think RCU is enough, we do not need more lock.

>
>> The destination qemu only invoked qio_channel_rdma_readv by main
>> thread before postcopy and or
>> listen thread after postcopy.
>>
>> The destination qemu have already protected it by using
>> qemu_mutex_lock(&mis->rp_mutex) when writing data to
>> source qemu.
>>
>> But should we use qemu_mutex_lock to protect qio_channel_rdma_writev
>> and qio_channel_rdma_readv?
>> to avoid some change in future invoke qio_channel_rdma_writev or
>> qio_channel_rdma_readv concurrently?
>
>>
>> >
>> > But is there nothing else to make the QIOChannel bidirectional?
>> >
>> > Also, a lot seems dependent on listen_id, can you explain how that's
>> > being used.
>>
>> The destination qemu is server side, so listen_id is not zero. the
>> source qemu is client side,
>> the listen_id is zero.
>> I use listen_id to determine whether qemu is destination or source.
>>
>> for the destination qemu, if write data to source, it need use the
>> return_path rdma, like this:
>>     if (rdma->listen_id) {
>>         rdma =3D rdma->return_path;
>>     }
>>
>> for the source qemu, if read data from destination, it also need use
>> the return_path rdma.
>>     if (!rdma->listen_id) {
>>         rdma =3D rdma->return_path;
>>     }
>
> This feels uncessarily complex to me. Why not just change QIOCHannelRMDA
> struct, so that it has 2 RDMA context pointers eg
>
> struct QIOChannelRDMA {
>     QIOChannel parent;
>     RDMAContext *rdmain;
>     RDMAContext *rdmaout;
>     QEMUFile *file;
>     bool blocking; /* XXX we don't actually honour this yet */
> };

The reason is the parameter of some function is RDMAContext.
like qemu_rdma_accept, rdma_start_outgoing_migration.
It's easier to implement return path.

so I should add some comment to the code.

>
>
>
> Regards,
> Daniel
> --
> |: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
> |: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
> |: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
