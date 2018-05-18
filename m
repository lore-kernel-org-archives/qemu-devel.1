Received: from eggs.gnu.org ([2001:4830:134:3::10]:45269)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fJeHP-0003aU-I1
	for qemu-devel@nongnu.org; Fri, 18 May 2018 08:14:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fJeHM-000508-Cx
	for qemu-devel@nongnu.org; Fri, 18 May 2018 08:14:39 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:44722 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1fJeHM-0004zj-6s
	for qemu-devel@nongnu.org; Fri, 18 May 2018 08:14:36 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 73D4581663C0
	for <qemu-devel@nongnu.org>; Fri, 18 May 2018 12:14:35 +0000 (UTC)
Date: Fri, 18 May 2018 14:14:30 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180518121430.GC4833@localhost.localdomain>
References: <20180515234017.2277-1-quintela@redhat.com>
	<20180515234017.2277-11-quintela@redhat.com>
	<20180518085902.GB4833@localhost.localdomain>
	<20180518103441.GD2478@work-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20180518103441.GD2478@work-vm>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 10/40] migration: Delay start of migration
 main routines
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org, lvivier@redhat.com, peterx@redhat.com, berrange@redhat.com

Am 18.05.2018 um 12:34 hat Dr. David Alan Gilbert geschrieben:
> * Kevin Wolf (kwolf@redhat.com) wrote:
> > Am 16.05.2018 um 01:39 hat Juan Quintela geschrieben:
> > > We need to make sure that we have started all the multifd threads.
> > >=20
> > > Signed-off-by: Juan Quintela <quintela@redhat.com>
> > > Reviewed-by: Daniel P. Berrang=E9 <berrange@redhat.com>
> >=20
> > This commit makes qemu-iotests 091 hang for me. Either it breaks
> > backward compatibility intentionally and we need to update the test
> > case, or there is a bug somewhere.
>=20
> It's not an intentional break.
> And the avocado tcp and exec migrations pass OK, so hmm.

In case it helps, 169 fails as well and I got a core dump of an aborting
QEMU process:

(gdb) bt
#0  0x00007ff079f779fb in raise () at /lib64/libc.so.6
#1  0x00007ff079f79800 in abort () at /lib64/libc.so.6
#2  0x00007ff079f700da in __assert_fail_base () at /lib64/libc.so.6
#3  0x00007ff079f70152 in  () at /lib64/libc.so.6
#4  0x000055c2126f067b in bdrv_close_all () at block.c:3375
#5  0x000055c2123c54a6 in main (argc=3D<optimized out>, argv=3D<optimized=
 out>, envp=3D<optimized out>) at vl.c:4682

If I understand correctly, that assertion failure means that someone is
still holding a reference to a block device after all user-owned
references have been closed. I suppose this was the source qemu and
the migration hasn't been completed properly, though I haven't looked at
the code yet and this idea might be completely wrong.

Anyway, 091 is certainly the simpler test case to play with, but maybe
this gives you another hint.

Kevin
