Received: from eggs.gnu.org ([2001:4830:134:3::10]:55485)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dwUqk-000066-F0
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 10:59:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dwUqj-0004dg-J5
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 10:59:10 -0400
Date: Mon, 25 Sep 2017 16:58:42 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170925145842.GB7999@localhost.localdomain>
References: <20170710163029.129912-1-vsementsov@virtuozzo.com>
	<20170710163029.129912-4-vsementsov@virtuozzo.com>
	<20170711130650.GD2223@work-vm>
	<2394bb38-de82-8621-eeae-14ffea68869b@virtuozzo.com>
	<b802048c-f5c0-efff-5550-6faed26023cd@redhat.com>
	<1078f013-e554-1d75-d1e8-f24daace5965@virtuozzo.com>
	<20170919190634.GK2107@work-vm> <87bmm5k2zs.fsf@secure.laptop>
	<20170925132312.GA7999@localhost.localdomain>
	<a1145c5e-4b70-a5ab-b828-ba51a9a3f9e3@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a1145c5e-4b70-a5ab-b828-ba51a9a3f9e3@virtuozzo.com>
Subject: Re: [Qemu-devel] ping Re: [PATCH v7 03/16] migration: split common
 postcopy out of ram postcopy
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Cc: Juan Quintela <quintela@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, peter.maydell@linaro.org, famz@redhat.com, stefanha@redhat.com, qemu-block@nongnu.org, qemu-devel@nongnu.org, armbru@redhat.com, lirans@il.ibm.com, pbonzini@redhat.com, den@openvz.org, mreitz@redhat.com, John Snow <jsnow@redhat.com>

Am 25.09.2017 um 16:31 hat Vladimir Sementsov-Ogievskiy geschrieben:
> 25.09.2017 16:23, Kevin Wolf wrote:
> > Am 20.09.2017 um 13:45 hat Juan Quintela geschrieben:
> > > "Dr. David Alan Gilbert" <dgilbert@redhat.com> wrote:
> > > > * Vladimir Sementsov-Ogievskiy (vsementsov@virtuozzo.com) wrote:
> > > > > ping for 1-3
> > > > > Can we merge them?
> > > > I see all of them have R-b's; so lets try and put them in the next
> > > > migration merge.
> > > > 
> > > > Quintela: Sound good?
> > > Yeap.
> > This patch broke qemu-iotests 181 ('Test postcopy live migration with
> > shared storage'):
> > 
> > --- /home/kwolf/source/qemu/tests/qemu-iotests/181.out  2017-06-16 19:19:53.000000000 +0200
> > +++ 181.out.bad 2017-09-25 15:20:40.787582000 +0200
> > @@ -21,18 +21,16 @@
> >   === Do some I/O on the destination ===
> >   QEMU X.Y.Z monitor - type 'help' for more information
> > -(qemu) qemu-io disk "read -P 0x55 0 64k"
> > +(qemu) QEMU_PROG: Expected vmdescription section, but got 0
> > +QEMU_PROG: Failed to get "write" lock
> > +Is another process using the image?
> > +qemu-io disk "read -P 0x55 0 64k"
> >   read 65536/65536 bytes at offset 0
> >   64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> >   (qemu)
> >   (qemu) qemu-io disk "write -P 0x66 1M 64k"
> > -wrote 65536/65536 bytes at offset 1048576
> > -64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> > -
> > -=== Shut down and check image ===
> > -
> > -(qemu) quit
> > -(qemu)
> > -(qemu) quit
> > -No errors were found on the image.
> > -*** done
> > +QEMU_PROG: block/io.c:1359: bdrv_aligned_pwritev: Assertion `child->perm & BLK_PERM_WRITE' failed.
> > +./common.config: Aborted                 (core dumped) ( if [ -n "${QEMU_NEED_PID}" ]; then
> > +echo $BASHPID > "${QEMU_TEST_DIR}/qemu-${_QEMU_HANDLE}.pid";
> > +fi; exec "$QEMU_PROG" $QEMU_OPTIONS "$@" )
> > +Timeout waiting for ops/sec on handle 1
> 
> Not sure about locking (don't see this error on my old kernel without OFD
> locking), but it looks like that
> 181 test should be fixed to set postcopy-ram capability on target too (which
> was considered as correct way on list)

Whatever you think the preferred way to set up postcopy migration is: If
something worked before this patch and doesn't after it, that's a
regression and breaks backwards compatibility.

If we were talking about a graceful failure, maybe we could discuss
whether carefully and deliberately breaking compatibility could be
justified in this specific case. But the breakage is neither mentioned
in the commit message nor is it graceful, so I can only call it a bug.

Kevin
