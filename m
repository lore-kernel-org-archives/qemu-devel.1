Received: from eggs.gnu.org ([2001:4830:134:3::10]:40390)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1ds67P-0005TG-E3
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 07:46:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1ds67L-0001nk-Et
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 07:46:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36662)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1ds67L-0001ms-5j
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 07:46:07 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 2D257C0587E3
	for <qemu-devel@nongnu.org>; Wed, 13 Sep 2017 11:46:06 +0000 (UTC)
Date: Wed, 13 Sep 2017 12:45:58 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170913114558.GF3067@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20170808162629.32493-1-quintela@redhat.com>
	<20170808162629.32493-16-quintela@redhat.com>
	<20170811152949.GU2554@redhat.com> <87r2vadels.fsf@secure.laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87r2vadels.fsf@secure.laptop>
Subject: Re: [Qemu-devel] [PATCH v6 15/19] migration: Create thread
 infrastructure for multifd recv side
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Juan Quintela <quintela@redhat.com>
Cc: qemu-devel@nongnu.org, lvivier@redhat.com, dgilbert@redhat.com, peterx@redhat.com

On Wed, Sep 13, 2017 at 01:26:07PM +0200, Juan Quintela wrote:
> "Daniel P. Berrange" <berrange@redhat.com> wrote:
> > On Tue, Aug 08, 2017 at 06:26:25PM +0200, Juan Quintela wrote:
> >> We make the locking and the transfer of information specific, even if we
> >> are still receiving things through the main thread.
> >> 
> >> Signed-off-by: Juan Quintela <quintela@redhat.com>
> >> 
> >> --
> >> 
> >> We split when we create the main channel and where we start the main
> >> migration thread, so we wait for the creation of the other threads.
> >> 
> >> Use multifd_clear_group().
> >> ---
> >>  migration/migration.c |  7 ++++---
> >>  migration/migration.h |  1 +
> >>  migration/ram.c       | 55 +++++++++++++++++++++++++++++++++++++++++++++++----
> >>  migration/socket.c    |  2 +-
> >>  4 files changed, 57 insertions(+), 8 deletions(-)
> >
> >
> >> diff --git a/migration/socket.c b/migration/socket.c
> >> index 5dd6f42..3af9f7c 100644
> >> --- a/migration/socket.c
> >> +++ b/migration/socket.c
> >> @@ -183,12 +183,12 @@ static gboolean
> >> socket_accept_incoming_migration(QIOChannel *ioc,
> >>  
> >>      qio_channel_set_name(QIO_CHANNEL(sioc), "migration-socket-incoming");
> >>      migration_channel_process_incoming(QIO_CHANNEL(sioc));
> >> -    object_unref(OBJECT(sioc));
> >
> > AFAICT, migration_channel_process_incoming() acquires its own reference
> > on 'sioc', so removing this object_unref means the code is now leaking a
> > reference
> 
> Nack.
> 
> I did it and ended with a segmentation fault because reference count was
> bad.
> 
> (qemu) 
> Thread 6 "multifdrecv_0" received signal SIGSEGV, Segmentation fault.
> [Switching to Thread 0x7fff9f9ff700 (LWP 10065)]
> 0x00005555559c12f8 in type_is_ancestor (type=0xb60f18247c894860, 
>     target_type=0x555556531b30) at /mnt/kvm/qemu/cleanup/qom/object.c:217
> 217	    while (type) {
> (gdb) bt
> #0  0x00005555559c12f8 in type_is_ancestor (type=0xb60f18247c894860, target_type=0x555556531b30) at /mnt/kvm/qemu/cleanup/qom/object.c:217
> #1  0x00005555559c1dbb in object_class_dynamic_cast (class=class@entry=0x7ffff2cb3ce8 <main_arena+520>, typename=typename@entry=0x555555aa6d91 "qio-channel")
>     at /mnt/kvm/qemu/cleanup/qom/object.c:691
> #2  0x00005555559c1ed2 in object_class_dynamic_cast_assert (class=0x7ffff2cb3ce8 <main_arena+520>, typename=typename@entry=0x555555aa6d91 "qio-channel", file=file@entry=0x555555b88208 "/mnt/kvm/qemu/cleanup/io/channel.c", line=line@entry=56, func=func@entry=0x555555b884e0 <__func__.22671> "qio_channel_readv_full")
>     at /mnt/kvm/qemu/cleanup/qom/object.c:723
> #3  0x0000555555a3d4d7 in qio_channel_readv_full (ioc=0x5555568c5a00, iov=0x7fff900008c0, niov=15, fds=0x0, nfds=0x0, errp=0x7fff9f9fe950)
>     at /mnt/kvm/qemu/cleanup/io/channel.c:56
> #4  0x0000555555a3ddc2 in qio_channel_readv (errp=0x7fff9f9fe950, niov=<optimized out>, iov=<optimized out>, ioc=0x5555568c5a00)
>     at /mnt/kvm/qemu/cleanup/io/channel.c:197
> #5  0x0000555555a3ddc2 in qio_channel_readv_all_eof (ioc=0x5555568c5a00, iov=<optimized out>, niov=<optimized out>, errp=errp@entry=0x7fff9f9fe950)
>     at /mnt/kvm/qemu/cleanup/io/channel.c:106
> #6  0x0000555555a3de79 in qio_channel_readv_all (ioc=<optimized out>, iov=<optimized out>, niov=<optimized out>, errp=errp@entry=0x7fff9f9fe950)
>     at /mnt/kvm/qemu/cleanup/io/channel.c:142
> #7  0x0000555555794768 in multifd_recv_thread (opaque=0x5555570e5e00)
> ---Type <return> to continue, or q <return> to quit---up
>     at /mnt/kvm/qemu/cleanup/migration/ram.c:722
> #8  0x00007ffff2cc036d in start_thread (arg=0x7fff9f9ff700)
>     at pthread_create.c:456
> #9  0x00007ffff29f8bbf in clone ()
>     at ../sysdeps/unix/sysv/linux/x86_64/clone.S:97
> (gdb) up
> 
> Removing this unref fixed things, so I think that the accounting is good
> (famous last words).

No, this is just papering over a bug elsewhere. The multifd_new_channel
metohd needs to be acquiring a reference for the multifd_recv_thread to
hold onto.


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
