Received: from eggs.gnu.org ([2001:4830:134:3::10]:38123)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cjN95-0003N3-5Y
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 04:35:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cjN91-0004wS-GN
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 04:35:35 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49360)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1cjN91-0004wK-Ag
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 04:35:31 -0500
Received: from smtp.corp.redhat.com (int-mx16.intmail.prod.int.phx2.redhat.com
	[10.5.11.28])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7BC1480F6B
	for <qemu-devel@nongnu.org>; Thu,  2 Mar 2017 09:35:31 +0000 (UTC)
Date: Thu, 2 Mar 2017 09:35:26 +0000
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170302093526.GB29835@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20170215182732.GN24672@redhat.com> <20170215233651.GA30794@vader>
	<20170216093316.GB7346@redhat.com> <20170301223856.GA20202@vader>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170301223856.GA20202@vader>
Subject: Re: [Qemu-devel] RFC: How to make seccomp reliable and useful ?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, pmoore@redhat.com

On Wed, Mar 01, 2017 at 11:38:56PM +0100, Eduardo Otubo wrote:
> On Thu, Feb 16, 2017 at 09=33=16AM +0000, Daniel P. Berrange wrote:
> > On Thu, Feb 16, 2017 at 12:36:51AM +0100, Eduardo Otubo wrote:
> > > On Wed, Feb 15, 2017 at 06=27=32PM +0000, Daniel P. Berrange wrote:
> 
> [...]
> 
> > > > 
> > > > There is a reasonable easily identifiable set of syscalls that QEMU should
> > > > never be permitted to use, no matter what configuration it is in, what helpers
> > > > it spawns, or what libraries it links to. eg reboot, swapon, swapoff,  syslog,
> > > > mount, unmount, kexec_*, etc - any syscall that affects global system state,
> > > > rather than process local state should be forbidden.
> > > > 
> > > > There are some syscalls that are simply hardcoded to return ENOSYS which can
> > > > be trivially blacklisted. afs_syscall, break, fattach, ftime, etc (see the
> > > > man page 'unimplemented(2)').
> 
> I've been working on the blacklist, you can see here:
> https://github.com/otubo/qemu/commit/31e603180081474ff35c5897813cb635f8e9a786
> 
> I didn't send as an RFC to the list because it's still an on going work,
> but if you have any comments, please feel free.
> 
> > > > 
> > > > There are some syscalls which are considered obsolete - they were previously
> > > > useful, but no modern code would call them, as they have been superceeded.
> > > > For example, readdir replaced by getdents. We could blacklist these by default
> > > > but provide a way to allow use of obsolete syscalls if running on older systems.
> > > > e.g. '-sandbox on,obsolete=allow'. They might be obsolete enough that we decide
> > > > to just block them permanently with no opt in - would need to analyse when
> > > > their replacements appeared in widespread use.
> 
> The obsolete part is also on my github (didn't send for the same
> reason):
> https://github.com/otubo/qemu/commit/54a57eb150ca3e5b67e9a81394c6cfa4ac82a6ff
> 
> Also, can't find anywhere a solid list of obsolete system calls, can you
> elaborate a little more on how to determine this list?

Systemd has such a list in ./src/shared/seccomp-util.c
Look for the array containing SYSCALL_FILTER_SET_OBSOLETE


Regards,
Daniel
-- 
|: http://berrange.com      -o-    http://www.flickr.com/photos/dberrange/ :|
|: http://libvirt.org              -o-             http://virt-manager.org :|
|: http://entangle-photo.org       -o-    http://search.cpan.org/~danberr/ :|
