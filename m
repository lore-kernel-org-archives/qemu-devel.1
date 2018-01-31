Received: from eggs.gnu.org ([2001:4830:134:3::10]:60541)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <msuchanek@suse.de>) id 1egxF8-0006Yj-Uz
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 13:36:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <msuchanek@suse.de>) id 1egxF8-0005KQ-52
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 13:36:22 -0500
Date: Wed, 31 Jan 2018 19:36:13 +0100
From: Michal =?UTF-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>
Message-ID: <20180131193613.3512fbaa@kitsune.suse.cz>
In-Reply-To: <1a65c254-64b7-5a41-1c15-823f5d30779d@redhat.com>
References: <151372207410.18061.3050483309114042068.malonedeb@chaenomeles.canonical.com>
	<151376591662.17755.1284403896485862270.malone@chaenomeles.canonical.com>
	<1a65c254-64b7-5a41-1c15-823f5d30779d@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Bug 1739304] Re: Passing a directory to (eg.)
 -cdrom results in misleading error message
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>
Cc: Bug 1739304 <1739304@bugs.launchpad.net>, qemu-devel@nongnu.org, "Dr.
	David Alan Gilbert" <dgilbert@redhat.com>, Qemu-block <qemu-block@nongnu.org>

On Wed, 20 Dec 2017 21:57:00 -0500
John Snow <jsnow@redhat.com> wrote:

> On 12/20/2017 05:31 AM, Dr. David Alan Gilbert wrote:
> > Yep, can repeat it here, it seems pretty random which error it
> > gives:
> > 
> > [dgilbert@dgilbert-t530 try]$ ./x86_64-softmmu/qemu-system-x86_64
> > -cdrom /tmp qemu-system-x86_64: -cdrom /tmp: Could not refresh
> > total sector count: Invalid argument [dgilbert@dgilbert-t530
> > try]$ ./x86_64-softmmu/qemu-system-x86_64 -cdrom /var
> > qemu-system-x86_64: -cdrom /var: Could not read image for
> > determining its format: File too large
> > 
> > 
> > ** Changed in: qemu
> >        Status: New => Confirmed
> >   
> 
> Looks like directories play funny games.
> 

...

> specifically:
> 
> (gdb) s
> 1963	    size = lseek(s->fd, 0, SEEK_END);
> (gdb) s
> 1964	    if (size < 0) {
> (gdb) print size
> $37 = 9223372036854775807
> 
> cool, cool, cool. This value is 0x7fffffffffffffff and errno isn't
> set. cool and good function.

Indeed: The behavior of lseek() on devices which are incapable of
seeking is implementation-defined.

> 
> so, lseek on a folder returns crazy nonsense. Perhaps we ought to
> actually specifically disallow folders, we don't appear to.

It probably returns -1 which it is supposed to do on error. It should
also set errno in that case, though.

So this is probably bug in the error handling code in lseek.

Thanks

Michal
