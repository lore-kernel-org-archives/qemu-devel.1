Received: from eggs.gnu.org ([2001:4830:134:3::10]:59266)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1f3cLD-00023t-95
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 02:56:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1f3cL8-0007vK-N3
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 02:56:19 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:55060 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1f3cL8-0007v7-Gx
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 02:56:14 -0400
Date: Wed, 4 Apr 2018 14:56:09 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180404065609.GJ26441@xz-mi>
References: <20180404025201.11921-1-famz@redhat.com>
	<20180404050347.GI26441@xz-mi>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180404050347.GI26441@xz-mi>
Subject: Re: [Qemu-devel] [PATCH 0/3] Add a CentOS test image to run docker
 tests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>, pbonzini@redhat.com, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

On Wed, Apr 04, 2018 at 01:03:47PM +0800, Peter Xu wrote:
> On Wed, Apr 04, 2018 at 10:51:58AM +0800, Fam Zheng wrote:
> > Docker testing on patchew has long suffered from 'make check' hangings. The
> > cleanness of VM testing is the cure. Now let's add a CentOS 7 image to run the
> > tests.  It's purely ad-hoc, but hopefully still easy to understand and use for
> > everyone.
> > 
> > The first patch makes passing source code from host to the container in VM
> > working, and is a nice clean up.
> > 
> > The second patch makes caches work, to speed up repetitive runs like on
> > patchew.
> > 
> > The last patch adds the new image that does the job. Two out of three docker
> > tests running on patchew.org are added to the image. I'll wait for Peter to fix
> > the 'docker-test-quick@centos6' hanging (oob test) before adding it too.
> 
> This hang does not happen on centos7 (tested myself manually).  I
> consider this can be related to different default versions of glib2:
> 
> centos6: glib2-2.28.8-9.el6.x86_64
> centos7: glib2-2.50.3-3.el7.x86_64
> 
> (both fetched from docker.io)
> 
> qmp-test hangs at oob-test, while QEMU failed to respond to SIGTERM
> when trying to take a lock:
> 
> #0  0x00007f18eed02334 in __lll_lock_wait () from /lib64/libpthread.so.0
> #1  0x00007f18eecfd5d8 in _L_lock_854 () from /lib64/libpthread.so.0
> #2  0x00007f18eecfd4a7 in pthread_mutex_lock () from /lib64/libpthread.so.0
> #3  0x00007f18eb476c9d in ?? () from /lib64/libglib-2.0.so.0
> #4  0x0000000000aa6672 in aio_context_unref (ctx=0x225b600) at /root/qemu/util/async.c:497
> #5  0x000000000065851c in iothread_instance_finalize (obj=0x225b380) at /root/qemu/iothread.c:129
> #6  0x0000000000962d79 in object_deinit (obj=0x225b380, type=0x2199960) at /root/qemu/qom/object.c:462
> #7  0x0000000000962e0d in object_finalize (data=0x225b380) at /root/qemu/qom/object.c:476
> #8  0x0000000000964146 in object_unref (obj=0x225b380) at /root/qemu/qom/object.c:924
> #9  0x0000000000965880 in object_finalize_child_property (obj=0x2257640, name=0x225aca0 "mon_iothread", opaque=0x225b380) at /root/qemu/qom/object.c:1436
> #10 0x0000000000962c33 in object_property_del_child (obj=0x2257640, child=0x225b380, errp=0x0) at /root/qemu/qom/object.c:436
> #11 0x0000000000962d26 in object_unparent (obj=0x225b380) at /root/qemu/qom/object.c:455
> #12 0x0000000000658f00 in iothread_destroy (iothread=0x225b380) at /root/qemu/iothread.c:365
> #13 0x00000000004c67a8 in monitor_cleanup () at /root/qemu/monitor.c:4663
> #14 0x0000000000669e27 in main (argc=16, argv=0x7ffe33ce3a08, envp=0x7ffe33ce3a90) at /root/qemu/vl.c:4749
> 
> Currently I have no quick idea on why the lock was held by anyone
> else (I suppose that's the GMainContext's lock), and I'm not sure
> whether it could be a glib bug.

I posted a patch for this to workaround the possible glib bug:

  [PATCH for-2.12] iothread: workaround glib bug which hangs qmp-test

Let's see whether we can accept that.  Thanks,

-- 
Peter Xu
