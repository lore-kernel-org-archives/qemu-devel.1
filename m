Received: from eggs.gnu.org ([2001:4830:134:3::10]:45681)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rjones@redhat.com>) id 1crS8s-0000nI-JB
	for qemu-devel@nongnu.org; Fri, 24 Mar 2017 12:32:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rjones@redhat.com>) id 1crS8o-000208-Kj
	for qemu-devel@nongnu.org; Fri, 24 Mar 2017 12:32:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49566)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <rjones@redhat.com>) id 1crS8o-0001xu-EW
	for qemu-devel@nongnu.org; Fri, 24 Mar 2017 12:32:42 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id EB39561E48
	for <qemu-devel@nongnu.org>; Fri, 24 Mar 2017 16:32:40 +0000 (UTC)
Date: Fri, 24 Mar 2017 16:32:38 +0000
From: "Richard W.M. Jones" <rjones@redhat.com>
Message-ID: <20170324163238.GH13825@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [Qemu-devel] Random hangs in the emulated ISA serial console,
 caused by glib2 change
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Frediano Ziglio <fziglio@redhat.com>
Cc: pbonzini@redhat.com

Hello Frediano,

I'm tracking a rather difficult bug in qemu, where it appears that
events in the glib loop are "lost".  This is characterized by the
emulated qemu serial console hanging until someone presses a key.
This is normally disguised in the busy main loop of qemu (since some
other event turns up often and "bumps" things along), but in my
application there are no processes running inside the qemu guest and
so I hit these hangs rather frequently.

The BZ with all the details is:

  https://bugzilla.redhat.com/show_bug.cgi?id=1435432

I eventually tracked this down to a single glib2 commit:

  e4ee3079c5afc3c1c3d2415f20c3e8605728f074 is the first bad commit
  commit e4ee3079c5afc3c1c3d2415f20c3e8605728f074
  Author: Frediano Ziglio <fziglio@redhat.com>
  Date:   Mon Jan 25 14:59:24 2016 +0000

      Do not wake up main loop if change is from same thread
    
      This reduce the frequency the loop is waked up adding and removing
      file descriptors or timeouts.
      Considering that to support recursion events are removed from list and
      added again this reduce iteration number a lot.
    
      Signed-off-by: Frediano Ziglio <fziglio@redhat.com>
    
      https://bugzilla.gnome.org/show_bug.cgi?id=761102

  :040000 040000 bb42e86b5a2c962322a84b52c939f16df2c43034 8d31e66a35fb3ae1e72fa7a34ad861bfd332bd84 M	glib

Reverting the commit on top of glib2 git HEAD fixes the problem
in qemu.

So I guess I have a question: Is this change supposed to be
completely neutral to programs using glib, or should qemu make
a corresponding change?

Rich.

-- 
Richard Jones, Virtualization Group, Red Hat http://people.redhat.com/~rjones
Read my programming and virtualization blog: http://rwmj.wordpress.com
virt-p2v converts physical machines to virtual machines.  Boot with a
live CD or over the network (PXE) and turn machines into KVM guests.
http://libguestfs.org/virt-v2v
