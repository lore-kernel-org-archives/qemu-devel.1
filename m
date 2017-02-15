Received: from eggs.gnu.org ([2001:4830:134:3::10]:44716)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1ce4Ip-0008Jf-GH
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 13:27:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1ce4Il-0000y8-Es
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 13:27:43 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49088)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1ce4Il-0000xP-23
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 13:27:39 -0500
Date: Wed, 15 Feb 2017 18:27:32 +0000
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170215182732.GN24672@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Subject: [Qemu-devel] RFC: How to make seccomp reliable and useful ?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Eduardo Otubo <eduardo.otubo@profitbricks.com>

The current impl of seccomp in QEMU is intentionally allowing a huge range
of system calls to be executed. The goal was that running '-sandbox on'
should never break any feature of QEMU, so naturally any syscall that can
executed on any codepath QEMU takes must be allowed.

This is good for usability because users don't need to understand the technical
details of the sandbox technology, they merely say "on" and it "just works".
Conversely though, this is bad for security because QEMU has to allow a huge
range of system calls to be used due to its broad functionality.

During initial discussions for seccomp back in 2012 it was suggested, there
might be alternate policies developed for QEMU which deny some features, but
improve security overall. To best of my knowledge, this has never been discussed
again since then.


In addition, since initially merging, there has been a steady stream of patches
to whitelist further syscalls that were missing. Some of these were missing due
to newly added functionality in QEMU since the original seccomp impl, while
others have been missing since day 1. It is reasonable to expect that there are
still many syscalls missing in the whitelist. In just a couple of minutes of
comparing the whitelist vs global syscall list it was possible to identify two
further missing syscalls. The '-netdev bridge,br=virbr0' network backend fails
because setuid is blocked, preventing execution of the qemu-bridge-helper
program. If built against glibc < 2.9, or running on kernel < 2.6.27 it will
fail to call eventfd() because we only permit eventfd2() syscall, not the
older eventfd() syscall used on older Linux. Some ifup scripts used with the
-netdev arg may also break due to lack of chmod, flock, getxattr permissions.
This risk of missing syscalls is why -sandbox defaults to off, and we've never
considered defaulting it to on.


The fundamental problem is that building a whitelist of syscalls used by QEMU
emulators is an intractable problem. QEMU on my system links to 183 different
shared libraries and there is no way in the world that anyone can figure out
which code paths QEMU triggers in these libraries and thus identify which
syscalls will be genuinely needed.

Thus a whitelist based approach for QEMU is doomed to always be missing some
syscalls, resulting in uneccessary abrts of QEMU when it tickles some edge
case. If you are lucky the abort() happens at startup so you see it quickly
and can address it. If you are unlucky the abort() happens after your VM has
been running for days/week/months and you loose data.

IOW, seccomp integration as it currently exists today in QEMU offers minimal
security benefits, while at the same time causing spurious crashes which may
cause user data loss from aborting a running VM, discouraging users from using
even the minimal protection it offers.

I think we need to rework our seccomp support so that we can have a high enough
level of confidence in it, that it could be enabled by default. At the same time
we need to make it do something more tangibly useful from a security POV.


First we need to admit that whitelisting is a failed approach, and switch to
using blacklisting. Unless we do this, we'll never have high enough confidence
to enable it by default - something that's never turned on might as well not
exist at all.


There is a reasonable easily identifiable set of syscalls that QEMU should
never be permitted to use, no matter what configuration it is in, what helpers
it spawns, or what libraries it links to. eg reboot, swapon, swapoff,  syslog,
mount, unmount, kexec_*, etc - any syscall that affects global system state,
rather than process local state should be forbidden.

There are some syscalls that are simply hardcoded to return ENOSYS which can
be trivially blacklisted. afs_syscall, break, fattach, ftime, etc (see the
man page 'unimplemented(2)').

There are some syscalls which are considered obsolete - they were previously
useful, but no modern code would call them, as they have been superceeded.
For example, readdir replaced by getdents. We could blacklist these by default
but provide a way to allow use of obsolete syscalls if running on older systems.
e.g. '-sandbox on,obsolete=allow'. They might be obsolete enough that we decide
to just block them permanently with no opt in - would need to analyse when
their replacements appeared in widespread use.

There might be a few more syscalls which we can determine are never valid to
use in QEMU or any library or helper program it might run. I expect this list
to be very small though, given the impossibility of auditing code paths through
millions of lines of code QEMU links to.

Everything else should be allowed.

At this point we have a highly reliable "-sandbox on" which we're not having
to constantly patch.


>From here we need a way to allow a user to opt-in to more restrictive policies,
accepting that it will block certain features. For example, there should be a
a way to disable any means to elevate privileges from QEMU or things it spawns.
e.g. '-sandbox on,elevateprivileges=deny'.

This would not only block the variuous set*uid|gid functions via seccomp, but
should also prctl(PR_SET_NO_NEW_PRIVS). This would allows the user to optin to
a restrictive world if they know they'll not require things like the setuid
bridge helper.

Similarly there should be an '-sandbox on,spawn=deny' which prevents the ability
to fork/exec processes at all, whether privileged or not. This would block
features like the qemu bridge helper, SMB server, ifup/down scripts, migration
exec: protocol. These are all rarely used features though, so an opt-in to block
their use is reasonable & desirable.

A -sandbox on,resourcecontrol=deny, which prevents QEMU from setting stuff like
process affinity, schedular priority, etc. Some uses of QEMU might need them,
but normally such controls are left to the mgmt app above QEMU to set prior to
the exec() of QEMU.



The key is that these are *not* low level knobs controlling system calls, but
moderately high level knobs controlling general concepts. This is a high enough
level of abstraction to enable libvirt to automatically turn them on/off based
on guest config, without libvirt having to know anything detailed about QEMU
code impl for the features.


Finally, for avoidance of doubt, I'm *not* actually proposing to implement this
myself any time in the forseeable future. This mail came about from the fact
that many people have questioned whether current seccomp code is anything other
than "security theatre". I tend to agree with such an assessment myself, and was
initially intending to just send a patch to remove seccomp, to stimulate some
discussion. Instead, however, I decided to write this mail to see if we can
identify a way forward to make seccomp both reliable and useful. If QEMU had the
kind of approach outlined above, with a default blacklist instead of whitelist,
and some opt-ins for stricter lists, it is something I think libvirt would be
reasonably happy to enable out of the box. That would be a step forward from
today where libvirt would never consider turning seccomp on by default.

Perhaps this re-working could be a GSoC idea for some interested student...

Regards,
Daniel
-- 
|: http://berrange.com      -o-    http://www.flickr.com/photos/dberrange/ :|
|: http://libvirt.org              -o-             http://virt-manager.org :|
|: http://entangle-photo.org       -o-    http://search.cpan.org/~danberr/ :|
