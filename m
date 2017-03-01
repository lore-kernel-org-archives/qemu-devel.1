Received: from eggs.gnu.org ([2001:4830:134:3::10]:44138)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eduardo.otubo@profitbricks.com>) id 1cjCtl-0001vy-CQ
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 17:39:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eduardo.otubo@profitbricks.com>) id 1cjCti-0007B6-8I
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 17:39:05 -0500
Received: from mail-wm0-x235.google.com ([2a00:1450:400c:c09::235]:37955)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <eduardo.otubo@profitbricks.com>)
	id 1cjCth-00079O-UQ
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 17:39:02 -0500
Received: by mail-wm0-x235.google.com with SMTP id u199so47939949wmd.1
	for <qemu-devel@nongnu.org>; Wed, 01 Mar 2017 14:39:00 -0800 (PST)
Date: Wed, 1 Mar 2017 23:38:56 +0100
From: Eduardo Otubo <eduardo.otubo@profitbricks.com>
Message-ID: <20170301223856.GA20202@vader>
References: <20170215182732.GN24672@redhat.com> <20170215233651.GA30794@vader>
	<20170216093316.GB7346@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170216093316.GB7346@redhat.com>
Subject: Re: [Qemu-devel] RFC: How to make seccomp reliable and useful ?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, pmoore@redhat.com

On Thu, Feb 16, 2017 at 09=33=16AM +0000, Daniel P. Berrange wrote:
> On Thu, Feb 16, 2017 at 12:36:51AM +0100, Eduardo Otubo wrote:
> > On Wed, Feb 15, 2017 at 06=27=32PM +0000, Daniel P. Berrange wrote:

[...]

> > > 
> > > There is a reasonable easily identifiable set of syscalls that QEMU should
> > > never be permitted to use, no matter what configuration it is in, what helpers
> > > it spawns, or what libraries it links to. eg reboot, swapon, swapoff,  syslog,
> > > mount, unmount, kexec_*, etc - any syscall that affects global system state,
> > > rather than process local state should be forbidden.
> > > 
> > > There are some syscalls that are simply hardcoded to return ENOSYS which can
> > > be trivially blacklisted. afs_syscall, break, fattach, ftime, etc (see the
> > > man page 'unimplemented(2)').

I've been working on the blacklist, you can see here:
https://github.com/otubo/qemu/commit/31e603180081474ff35c5897813cb635f8e9a786

I didn't send as an RFC to the list because it's still an on going work,
but if you have any comments, please feel free.

> > > 
> > > There are some syscalls which are considered obsolete - they were previously
> > > useful, but no modern code would call them, as they have been superceeded.
> > > For example, readdir replaced by getdents. We could blacklist these by default
> > > but provide a way to allow use of obsolete syscalls if running on older systems.
> > > e.g. '-sandbox on,obsolete=allow'. They might be obsolete enough that we decide
> > > to just block them permanently with no opt in - would need to analyse when
> > > their replacements appeared in widespread use.

The obsolete part is also on my github (didn't send for the same
reason):
https://github.com/otubo/qemu/commit/54a57eb150ca3e5b67e9a81394c6cfa4ac82a6ff

Also, can't find anywhere a solid list of obsolete system calls, can you
elaborate a little more on how to determine this list?

> > > 
> > > There might be a few more syscalls which we can determine are never valid to
> > > use in QEMU or any library or helper program it might run. I expect this list
> > > to be very small though, given the impossibility of auditing code paths through
> > > millions of lines of code QEMU links to.
> > > 
> > > Everything else should be allowed.
> > > 
> > > At this point we have a highly reliable "-sandbox on" which we're not having
> > > to constantly patch.
> > > 
> > > 
> > > From here we need a way to allow a user to opt-in to more restrictive policies,
> > > accepting that it will block certain features. For example, there should be a
> > > a way to disable any means to elevate privileges from QEMU or things it spawns.
> > > e.g. '-sandbox on,elevateprivileges=deny'.
> > > 
> > > This would not only block the variuous set*uid|gid functions via seccomp, but
> > > should also prctl(PR_SET_NO_NEW_PRIVS). This would allows the user to optin to
> > > a restrictive world if they know they'll not require things like the setuid
> > > bridge helper.

Also, I was re-reading all documentation again, prctl(PR_SET_NO_NEW_PRIVS) is enabled
by default when using seccomp.

> > > 
> > > Similarly there should be an '-sandbox on,spawn=deny' which prevents the ability
> > > to fork/exec processes at all, whether privileged or not. This would block
> > > features like the qemu bridge helper, SMB server, ifup/down scripts, migration
> > > exec: protocol. These are all rarely used features though, so an opt-in to block
> > > their use is reasonable & desirable.
> > > 
> > > A -sandbox on,resourcecontrol=deny, which prevents QEMU from setting stuff like
> > > process affinity, schedular priority, etc. Some uses of QEMU might need them,
> > > but normally such controls are left to the mgmt app above QEMU to set prior to
> > > the exec() of QEMU.
> > > 
> > > 
> > > 
> > > The key is that these are *not* low level knobs controlling system calls, but
> > > moderately high level knobs controlling general concepts. This is a high enough
> > > level of abstraction to enable libvirt to automatically turn them on/off based
> > > on guest config, without libvirt having to know anything detailed about QEMU
> > > code impl for the features.
> > > 
> > > 
> > > Finally, for avoidance of doubt, I'm *not* actually proposing to implement this
> > > myself any time in the forseeable future. This mail came about from the fact
> > > that many people have questioned whether current seccomp code is anything other
> > > than "security theatre". I tend to agree with such an assessment myself, and was
> > > initially intending to just send a patch to remove seccomp, to stimulate some
> > > discussion. Instead, however, I decided to write this mail to see if we can
> > > identify a way forward to make seccomp both reliable and useful. If QEMU had the
> > > kind of approach outlined above, with a default blacklist instead of whitelist,
> > > and some opt-ins for stricter lists, it is something I think libvirt would be
> > > reasonably happy to enable out of the box. That would be a step forward from
> > > today where libvirt would never consider turning seccomp on by default.
> > > 
> > > Perhaps this re-working could be a GSoC idea for some interested student...
> > > 
> > 
> > I'm not a student, thus not eligible GSoC person but I would be more
> > than grateful to take this initiative of yours and transform into some
> > patches so we can make this feature something really useful and
> > reliable.
> 
> Sure, I just threw GSoC out there as one possible idea. If you or anyone
> else has time to work on it, that's great too.
> 
> > Perhaps now is not the right time to terse comments on every idea you
> > gave, I agree with most of them. I wrote the whole implementation of
> > this feature but actually became the maintainer because people approving
> > sycalls and sending pull-requests were too busy, and I could do it. But
> > to be completely honest I had few poor ideas on how to improve it and
> > almost no time to actually do it in the past. Time passed by and all I
> > did was approve new syscalls and turn them into pull-requests.
> > 
> > Let's spin up these ideas and hopefully incorporate into Qemu. Next step
> > I'm gonna dig into every topic and draft a little more. I guess we can
> > keep on this thread, or perhaps in separate ones. From there I can start
> > to write some code.
> 
> ok
> 
> Regards,
> Daniel
> -- 
> |: http://berrange.com      -o-    http://www.flickr.com/photos/dberrange/ :|
> |: http://libvirt.org              -o-             http://virt-manager.org :|
> |: http://entangle-photo.org       -o-    http://search.cpan.org/~danberr/ :|
> 

-- 
Eduardo Otubo
ProfitBricks GmbH
