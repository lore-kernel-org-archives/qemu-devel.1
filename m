Received: from eggs.gnu.org ([2001:4830:134:3::10]:42261)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eldS4-00039h-VS
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 11:29:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eldS1-0005PD-09
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 11:29:04 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:49344 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1eldS0-0005P3-RH
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 11:29:00 -0500
Date: Tue, 13 Feb 2018 16:28:57 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180213162857.GV573@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <embe7de3dd-331d-44fe-9c32-75916c902fb6@ndc-wkst-2>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <embe7de3dd-331d-44fe-9c32-75916c902fb6@ndc-wkst-2>
Subject: Re: [Qemu-devel] QEMU leaves pidfile behind on exit
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Shaun Reitan <shaun.reitan@ndchost.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com

On Fri, Feb 09, 2018 at 07:12:59PM +0000, Shaun Reitan wrote:
> QEMU leaves the pidfile behind on a clean exit when using the option
> -pidfile /var/run/qemu.pid.
> 
> Should QEMU leave it behind or should it clean up after itself?
> 
> I'm willing to take a crack at a patch to fix the issue, but before I do, I
> want to make sure that leaving the pidfile behind was not intentional?

If QEMU deletes the pidfile on exit then, with the current pidfile
acquisition logic, there's a race condition possible:

To acquire we do

 1. fd = open()
 2. lockf(fd)

If the first QEMU that currently owns the pidfile unlinks in, while
a second qemu is in betweeen steps 1 & 2, the second QEMU will
acquire the pidfile successfully (which is fine) but the pidfile
is now unlinked. This is not fine, because a 3rd qemu can now come
and try to acquire the pidfile (by creating a new one) and succeed,
despite the second qemu still owning the (now unlinked) pidfile.

It is possible to deal with this race by making qemu_create_pidfile
more intelligent [1]. It would have todo

  1. fd = open(filename)
  2. fstat(fd)
  3. lockf(fd)
  4. stat(filename)

It must then compare the results of 2 + 4 to ensure the pidfile it
acquired is the same as the one on disk. With this change, it would
be safe for QEMU to delete the pidfile on exit.

Regards,
Daniel

[1] See the equiv libvirt logic for pidfile acquisition in
     https://libvirt.org/git/?p=libvirt.git;a=blob;f=src/util/virpidfile.c;h=58ab29f77f2cfb8583447112dae77a07446bc627;hb=HEAD#l384
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
