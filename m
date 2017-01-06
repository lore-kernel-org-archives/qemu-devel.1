Received: from eggs.gnu.org ([2001:4830:134:3::10]:49203)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cPX1S-00052E-JI
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 11:05:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cPX1Q-0001M8-TR
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 11:05:42 -0500
Received: from mx1.redhat.com ([209.132.183.28]:28212)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1cPX1Q-0001Lj-Ay
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 11:05:40 -0500
Received: from int-mx13.intmail.prod.int.phx2.redhat.com
	(int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 71D18C04B92E
	for <qemu-devel@nongnu.org>; Fri,  6 Jan 2017 16:05:40 +0000 (UTC)
Date: Fri, 6 Jan 2017 16:05:35 +0000
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170106160535.GR31112@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20170106155543.12827-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170106155543.12827-1-berrange@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 00/47] Switch all subdirs over to
 modular trace.h file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>

On Fri, Jan 06, 2017 at 03:54:56PM +0000, Daniel P. Berrange wrote:
> This is the final part of my trace events refactoring.
> 
> Previously we merged code that split trace-events up
> into one file per sub-directory. We also merged code
> to the code-generator that enables us to generate
> and use multiple independant sets of trace events.
> 
> This is the final glue that makes use of these two
> earlier changes, so that we actually generate a
> separate trace.h & trace.c file per sub-directory.
> 
> The result is that when adding a new trace event to
> a file, only files in that sub-directory get rebuilt.
> Theoretically the build is faster too, since each
> source file includes a much smaller trace.h that
> only contains probes relevant to it. In reality this
> speed benefit is probably marginal & lost in the noise.
> 
> The first patch introduces the new Makefile rules to
> handle modular building.
> 
> The next 43 patches convert over each sub-directory.
> They are totally boring and repetative. The only
> exception is the patch for target/s390x which hit
> a bit of makefile pain, explained in its commit msg.
> 
> The 45th patch removes the old, now unused, Makefile
> rules for non-modular trace building.
> 
> The 46th patch documents the new approach
> 
> The final patch is just a small tweak to error
> reporting, unrelated to the refactoring.

Oh I should say I tested this with

 ./configure --enable-trace-backends=log,simple,ust,nop,dtrace,ftrace,syslog

ie, all user + system emulators enabled and all trace backends
enabled.

Before rebasing to current git master I had also done the
same, testing against each patch in the series, so it should
be fully bisectable. It's also been through the standard travis
tests.

Regards,
Daniel
-- 
|: http://berrange.com      -o-    http://www.flickr.com/photos/dberrange/ :|
|: http://libvirt.org              -o-             http://virt-manager.org :|
|: http://entangle-photo.org       -o-    http://search.cpan.org/~danberr/ :|
