Received: from eggs.gnu.org ([2001:4830:134:3::10]:52772)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dRzqh-0000pX-1t
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 07:49:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dRzqc-0000Sk-K9
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 07:49:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60286)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1dRzqc-0000Qr-B6
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 07:48:58 -0400
Date: Mon, 3 Jul 2017 12:48:46 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170703114845.GB2206@work-vm>
References: <20170628190047.26159-1-dgilbert@redhat.com>
	<20170629185525.GC2399@work-vm>
	<CAJ+F1CKEEaRTfNiGU3cDYedqRYD9a+teG7t-F1YhGte3J-EbfA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <CAJ+F1CKEEaRTfNiGU3cDYedqRYD9a+teG7t-F1YhGte3J-EbfA@mail.gmail.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC 00/29] postcopy+vhost-user/shared ram
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@gmail.com>
Cc: qemu-devel@nongnu.org, a.perevalov@samsung.com, maxime.coquelin@redhat.com, mst@redhat.com, quintela@redhat.com, peterx@redhat.com, lvivier@redhat.com, aarcange@redhat.com

* Marc-Andr=E9 Lureau (marcandre.lureau@gmail.com) wrote:
> Hi
>=20
> On Thu, Jun 29, 2017 at 8:56 PM Dr. David Alan Gilbert <dgilbert@redhat=
.com>
> wrote:
>=20
> > * Dr. David Alan Gilbert (git) (dgilbert@redhat.com) wrote:
> > > From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> > >
> > > Hi,
> > >   This is a RFC/WIP series that enables postcopy migration
> > > with shared memory to a vhost-user process.
> > > It's based off current-head + Juan's load_cleanup series, and
> > > Alexey's bitmap series (v4).  It's very lightly tested and seems
> > > to work, but it's quite rough.
> >
> > Marc-Andr=E9 asked if I had a git with it all applied; so here we are=
:
> > https://github.com/dagrh/qemu/commits/vhost
> > git@github.com:dagrh/qemu.git on the vhost branch
> >
> >
> I started looking at the series, but I am not familiar with ufd/postcop=
y.

I'm similarly unfamiliar with the vhost code when I started this (which
probably shows!).
The main thing about ufd is that a process registers with the ufd system
and registers an area of memory with it;  accesses to the memory block
until the page is available, a message is sent down the ufd, and whoever
receives that message may then respond by atomically copying a page into
memory, or wakeing the process when it knows the page is there.
This is the first time we've tried to use userfaultfd with shared memory
and it does need a very recent kernel for it (4.11.0 or rhel 7.4 beta)

> Could you update vhost-user.txt to describe the new messages?

See below; I'll add that in.

> Otherwise,
> make check hangs in /x86_64/vhost-user/connect-fail (might be an unrela=
ted
> regression?) Thanks

Entirely possible I broke it; I'll have a look - at the moment I'm more
interested in comments on the structure of this set.

Dave

diff --git a/docs/interop/vhost-user.txt b/docs/interop/vhost-user.txt
index 481ab56e35..fec4cd0ffe 100644
--- a/docs/interop/vhost-user.txt
+++ b/docs/interop/vhost-user.txt
@@ -273,6 +273,14 @@ Once the source has finished migration, rings will b=
e stopped by
 the source. No further update must be done before rings are
 restarted.

+In postcopy migration the slave is started before all the memory has bee=
n
+received from the source host, and care must be taken to avoid accessing=
 pages
+that have yet to be received.  The slave opens a 'userfault'-fd and regi=
sters
+the memory with it; this fd is then passed back over to the master.
+The master services requests on the userfaultfd for pages that are acces=
sed
+and when the page is available it performs WAKE ioctl's on the userfault=
fd
+to wake the stalled slave.
+
 IOMMU support
 -------------

@@ -326,6 +334,7 @@ Protocol features
 #define VHOST_USER_PROTOCOL_F_REPLY_ACK      3
 #define VHOST_USER_PROTOCOL_F_MTU            4
 #define VHOST_USER_PROTOCOL_F_SLAVE_REQ      5
+#define VHOST_USER_PROTOCOL_F_POSTCOPY       6

 Master message types
 --------------------
@@ -402,12 +411,17 @@ Master message types
       Id: 5
       Equivalent ioctl: VHOST_SET_MEM_TABLE
       Master payload: memory regions description
+      Slave payload: (postcopy only) memory regions description

       Sets the memory map regions on the slave so it can translate the v=
ring
       addresses. In the ancillary data there is an array of file descrip=
tors
       for each memory mapped region. The size and ordering of the fds ma=
tches
       the number and ordering of memory regions.

+      When postcopy-listening has been received, SET_MEM_TABLE replies w=
ith
+      the bases of the memory mapped regions to the master.  It must hav=
e mmap'd
+      the regions and enabled userfaultfd on them.
+
  * VHOST_USER_SET_LOG_BASE

       Id: 6
@@ -580,6 +594,29 @@ Master message types
       This request should be send only when VIRTIO_F_IOMMU_PLATFORM feat=
ure
       has been successfully negotiated.

+ * VHOST_USER_POSTCOPY_ADVISE
+      Id: 23
+      Master payload: N/A
+      Slave payload: userfault fd + u64
+
+      Master advises slave that a migration with postcopy enabled is und=
erway,
+      the slave must open a userfaultfd for later use.
+      Note that at this stage the migration is still in precopy mode.
+
+ * VHOST_USER_POSTCOPY_LISTEN
+      Id: 24
+      Master payload: N/A
+
+      Master advises slave that a transition to postcopy mode has happen=
ed.
+
+ * VHOST_USER_POSTCOPY_END
+      Id: 25
+      Slave payload: u64
+
+      Master advises that postcopy migration has now completed.  The
+      slave must disable the userfaultfd. The response is an acknowledge=
ment
+      only.
+
 Slave message types
 -------------------


> --=20
> Marc-Andr=E9 Lureau
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
