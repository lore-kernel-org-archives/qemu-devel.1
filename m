Received: from eggs.gnu.org ([2001:4830:134:3::10]:48906)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <florolf@n621.de>) id 1eyJW7-00030K-EW
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 11:49:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <florolf@n621.de>) id 1eyJW3-0004h9-Ob
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 11:49:38 -0400
Received: from nyx.n621.de ([176.9.182.227]:34974)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <florolf@n621.de>) id 1eyJW3-0004fC-HI
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 11:49:35 -0400
Date: Tue, 20 Mar 2018 16:49:32 +0100
From: Florian Larysch <fl@n621.de>
Message-ID: <20180320154932.GC15157@nyx.n621.de>
References: <20180320093135.26422-1-fl@n621.de>
	<d5ad61b8-1570-0234-fd2a-97dfb174de59@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d5ad61b8-1570-0234-fd2a-97dfb174de59@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-2.12] os: truncate pidfile on creation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, sw@weilnetz.de

On Tue, Mar 20, 2018 at 09:50:19AM -0500, Eric Blake wrote:
> However, I have to wonder if we have the opposite problem - when the
> file exists (truncated) but has not yet been written, how often do
> we have a race where someone can see the empty file?
> 
> Should we be going even further and writing the pid into a temporary
> file and then rename(2)ing that file onto the real destination, so
> that if the pid file exists at all, it has stable contents that
> can't cause confusion?

I thought about doing that, but the window of opportunity is
sufficiently small that this probably not a problem.

Furthermore, the second purpose of the pid file is to provide mutual
exclusion between qemu instances using the same pid file by means of the
lockf() call. Given that the lock is associated with the inode, doing a
rename() would defeat this if we didn't reopen the file before calling
lockf(). However, doing that would in turn allow a race between multiple
qemu instances (possibly resulting in the incorrect pid remaining in the
file). That could also be fixed, but makes the whole affair even more
complicated; not sure if this is worth the benefits.

> >diff --git a/os-win32.c b/os-win32.c
> >index 586a7c7d49..85dbad7af8 100644
> >--- a/os-win32.c
> >+++ b/os-win32.c
> >@@ -108,7 +108,7 @@ int qemu_create_pidfile(const char *filename)
> >      memset(&overlap, 0, sizeof(overlap));
> >      file = CreateFile(filename, GENERIC_WRITE, FILE_SHARE_READ, NULL,
> >-                      OPEN_ALWAYS, FILE_ATTRIBUTE_NORMAL, NULL);
> >+                      CREATE_ALWAYS, FILE_ATTRIBUTE_NORMAL, NULL);
> 
> I assume this is right (at least for looking comparable to the POSIX
> case), although I'm trusting you here.

I adapted this for consistency reasons, but I don't have a Windows
platform available to test on. I based this on [1] and [2], which seems
reasonable, but I'd be happy if someone who is familiar with the Windows
API could ack this (get_maintainer.pl suggested Stefan Weil, who is
CC'ed).

[1] https://msdn.microsoft.com/en-us/library/windows/desktop/aa363858(v=vs.85).aspx
[2] https://stackoverflow.com/questions/14469607/difference-between-open-always-and-create-always-in-createfile-of-windows-api

Florian
