Received: from eggs.gnu.org ([2001:4830:134:3::10]:44178)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cRMtL-00045R-4M
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 12:40:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cRMtI-00018P-1A
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 12:40:55 -0500
Received: from mx1.redhat.com ([209.132.183.28]:30271)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1cRMtH-00017w-Qy
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 12:40:51 -0500
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
	(int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D01A8C0467D1
	for <qemu-devel@nongnu.org>; Wed, 11 Jan 2017 17:40:51 +0000 (UTC)
Date: Wed, 11 Jan 2017 17:40:45 +0000
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170111174045.GT12072@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20170106155543.12827-1-berrange@redhat.com>
	<20170106155543.12827-3-berrange@redhat.com>
	<20170110163713.GA19869@stefanha-x1.localdomain>
	<eabc1ecd-439c-69cc-facb-281699a4d26e@redhat.com>
	<20170111171202.GG9269@stefanha-x1.localdomain>
	<20170111171646.GR12072@redhat.com>
	<6d64c194-bb64-9ac2-3281-9a9329f6a52b@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6d64c194-bb64-9ac2-3281-9a9329f6a52b@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 02/47] trace: switch io/ directory to
 modular trace.h file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org

On Wed, Jan 11, 2017 at 06:34:40PM +0100, Paolo Bonzini wrote:
> 
> 
> On 11/01/2017 18:16, Daniel P. Berrange wrote:
> > I've been trying to get such relative includes to work most of today
> > and not having much luck. The problem is that while it works in 95%
> > of the time, there are some source files and header files which need
> > to include trace.h files not in their local directory
> 
> Which are they?  I wouldn't have expected that to happen.

It is indirect - particularly Xen - include/hw/xen/xen_common.h hsa
some trace points and that is included from many different source
files. Likewise with include/exec/cpu_ldst_template.h


> > and we can't
> > use relative includes for that, since the relative include gets
> > resolved wrt the source file doing the #include, but the trace.h
> > file is in $BUILD_DIR.
> 
> Why would #include "../foo/trace.h" be resolved against the source
> file's path only, and not against all -I directories?

If we have a plain "../trace.h", then it can end up hitting the
wrong file, because there are many -I dirs listed and most of
them contain a trace.h file, so if it matches on the 2nd -I
dir and you need the one from the 3rd -I dir it gets "fun".

Having all the trace.h files included with path from the root
is alot simpler to understand IMHO than just plain "trace.h"
and hoping the -I order is going to ensure the right one is
found

Regards,
Daniel
-- 
|: http://berrange.com      -o-    http://www.flickr.com/photos/dberrange/ :|
|: http://libvirt.org              -o-             http://virt-manager.org :|
|: http://entangle-photo.org       -o-    http://search.cpan.org/~danberr/ :|
