Received: from eggs.gnu.org ([2001:4830:134:3::10]:58528)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cYIs8-0008VH-7w
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 15:48:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cYIs4-0004Ws-A1
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 15:48:20 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57492)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1cYIs4-0004Wk-3s
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 15:48:16 -0500
References: <1485422212-31546-1-git-send-email-ashijeetacharya@gmail.com>
	<20170128194157.0c82cc8a@bahia.lan>
	<CAC2QTZZaaMgiiJbXgnLzBF+02=XnzKsofP7fwK7oF56maXY8Gg@mail.gmail.com>
	<20170129140329.3646dee3@bahia.lan>
	<CAC2QTZZA53iu0q09D+WA9Sn4q9K2pFXmT0CiU9a4=TPiMM9EzQ@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <f950c6d5-2972-c844-8bbd-47dfe2aa7074@redhat.com>
Date: Mon, 30 Jan 2017 15:48:14 -0500
MIME-Version: 1.0
In-Reply-To: <CAC2QTZZA53iu0q09D+WA9Sn4q9K2pFXmT0CiU9a4=TPiMM9EzQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] migrate: Migration aborts abruptly for
 machine "none"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ashijeet Acharya <ashijeetacharya@gmail.com>, Greg Kurz <groug@kaod.org>
Cc: Thomas Huth <thuth@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, "dgilbert@redhat.com" <dgilbert@redhat.com>, Juan Quintela <quintela@redhat.com>



On 29/01/2017 08:19, Ashijeet Acharya wrote:
> Also, Paolo has a similar opinion to yours that we should fix it
> instead of blocking it. He suggests to migrate only the device states
> and skip all the RAM related stuff. Maybe he can explain it better
> when he is available.

Yes, there is even support already in ram_migration_cleanup for not
allocating the bitmap:

    struct BitmapRcu *bitmap =3D migration_bitmap_rcu;
    atomic_rcu_set(&migration_bitmap_rcu, NULL);
    if (bitmap) {
        memory_global_dirty_log_stop();
        call_rcu(bitmap, migration_bitmap_free, rcu);
    }

I think you should just iterate until you find no more misbehaving code.
 The allocation is one, but ram_find_and_save_block should also return 0
if QLIST_FIRST_RCU(&ram_list.blocks) is NULL, for example.

Paolo
