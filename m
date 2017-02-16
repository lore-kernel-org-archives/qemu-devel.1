Received: from eggs.gnu.org ([2001:4830:134:3::10]:60082)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1ceIVQ-0004oA-De
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 04:37:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1ceIVL-0005qR-HD
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 04:37:40 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60858)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1ceIVL-0005qM-8h
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 04:37:35 -0500
References: <20170215182732.GN24672@redhat.com>
	<5ae6dee4-779b-7073-4192-21554b8a2b62@redhat.com>
	<20170216093203.GA7346@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <a964ee79-d160-207d-34e8-de480fdf3e23@redhat.com>
Date: Thu, 16 Feb 2017 10:37:31 +0100
MIME-Version: 1.0
In-Reply-To: <20170216093203.GA7346@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
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
Cc: qemu-devel@nongnu.org, Eduardo Otubo <eduardo.otubo@profitbricks.com>

On 16.02.2017 10:32, Daniel P. Berrange wrote:
> On Thu, Feb 16, 2017 at 09:38:59AM +0100, Thomas Huth wrote:
>> On 15.02.2017 19:27, Daniel P. Berrange wrote:
>>> The current impl of seccomp in QEMU is intentionally allowing a huge range
>>> of system calls to be executed. The goal was that running '-sandbox on'
>>> should never break any feature of QEMU, so naturally any syscall that can
>>> executed on any codepath QEMU takes must be allowed.
>>>
>>> This is good for usability because users don't need to understand the technical
>>> details of the sandbox technology, they merely say "on" and it "just works".
>>> Conversely though, this is bad for security because QEMU has to allow a huge
>>> range of system calls to be used due to its broad functionality.
>>>
>>> During initial discussions for seccomp back in 2012 it was suggested, there
>>> might be alternate policies developed for QEMU which deny some features, but
>>> improve security overall. To best of my knowledge, this has never been discussed
>>> again since then.
>>>
>>>
>>> In addition, since initially merging, there has been a steady stream of patches
>>> to whitelist further syscalls that were missing. Some of these were missing due
>>> to newly added functionality in QEMU since the original seccomp impl, while
>>> others have been missing since day 1. It is reasonable to expect that there are
>>> still many syscalls missing in the whitelist. In just a couple of minutes of
>>> comparing the whitelist vs global syscall list it was possible to identify two
>>> further missing syscalls. The '-netdev bridge,br=virbr0' network backend fails
>>> because setuid is blocked, preventing execution of the qemu-bridge-helper
>>> program. If built against glibc < 2.9, or running on kernel < 2.6.27 it will
>>> fail to call eventfd() because we only permit eventfd2() syscall, not the
>>> older eventfd() syscall used on older Linux. Some ifup scripts used with the
>>> -netdev arg may also break due to lack of chmod, flock, getxattr permissions.
>>> This risk of missing syscalls is why -sandbox defaults to off, and we've never
>>> considered defaulting it to on.
>>>
>>>
>>> The fundamental problem is that building a whitelist of syscalls used by QEMU
>>> emulators is an intractable problem. QEMU on my system links to 183 different
>>> shared libraries and there is no way in the world that anyone can figure out
>>> which code paths QEMU triggers in these libraries and thus identify which
>>> syscalls will be genuinely needed.
>>>
>>> Thus a whitelist based approach for QEMU is doomed to always be missing some
>>> syscalls, resulting in uneccessary abrts of QEMU when it tickles some edge
>>> case. If you are lucky the abort() happens at startup so you see it quickly
>>> and can address it. If you are unlucky the abort() happens after your VM has
>>> been running for days/week/months and you loose data.
>>>
>>> IOW, seccomp integration as it currently exists today in QEMU offers minimal
>>> security benefits, while at the same time causing spurious crashes which may
>>> cause user data loss from aborting a running VM, discouraging users from using
>>> even the minimal protection it offers.
>>>
>>> I think we need to rework our seccomp support so that we can have a high enough
>>> level of confidence in it, that it could be enabled by default. At the same time
>>> we need to make it do something more tangibly useful from a security POV.
>>>
>>>
>>> First we need to admit that whitelisting is a failed approach, and switch to
>>> using blacklisting. Unless we do this, we'll never have high enough confidence
>>> to enable it by default - something that's never turned on might as well not
>>> exist at all.
>>>
>>>
>>> There is a reasonable easily identifiable set of syscalls that QEMU should
>>> never be permitted to use, no matter what configuration it is in, what helpers
>>> it spawns, or what libraries it links to. eg reboot, swapon, swapoff,  syslog,
>>> mount, unmount, kexec_*, etc - any syscall that affects global system state,
>>> rather than process local state should be forbidden.
>>>
>>> There are some syscalls that are simply hardcoded to return ENOSYS which can
>>> be trivially blacklisted. afs_syscall, break, fattach, ftime, etc (see the
>>> man page 'unimplemented(2)').
>>>
>>> There are some syscalls which are considered obsolete - they were previously
>>> useful, but no modern code would call them, as they have been superceeded.
>>> For example, readdir replaced by getdents. We could blacklist these by default
>>> but provide a way to allow use of obsolete syscalls if running on older systems.
>>> e.g. '-sandbox on,obsolete=allow'. They might be obsolete enough that we decide
>>> to just block them permanently with no opt in - would need to analyse when
>>> their replacements appeared in widespread use.
>>>
>>> There might be a few more syscalls which we can determine are never valid to
>>> use in QEMU or any library or helper program it might run. I expect this list
>>> to be very small though, given the impossibility of auditing code paths through
>>> millions of lines of code QEMU links to.
>>>
>>> Everything else should be allowed.
>>>
>>> At this point we have a highly reliable "-sandbox on" which we're not having
>>> to constantly patch.
>>>
>>> From here we need a way to allow a user to opt-in to more restrictive policies,
>>> accepting that it will block certain features. For example, there should be a
>>> a way to disable any means to elevate privileges from QEMU or things it spawns.
>>> e.g. '-sandbox on,elevateprivileges=deny'.
>>>
>>> This would not only block the variuous set*uid|gid functions via seccomp, but
>>> should also prctl(PR_SET_NO_NEW_PRIVS). This would allows the user to optin to
>>> a restrictive world if they know they'll not require things like the setuid
>>> bridge helper.
>>>
>>> Similarly there should be an '-sandbox on,spawn=deny' which prevents the ability
>>> to fork/exec processes at all, whether privileged or not. This would block
>>> features like the qemu bridge helper, SMB server, ifup/down scripts, migration
>>> exec: protocol. These are all rarely used features though, so an opt-in to block
>>> their use is reasonable & desirable.
>>>
>>> A -sandbox on,resourcecontrol=deny, which prevents QEMU from setting stuff like
>>> process affinity, schedular priority, etc. Some uses of QEMU might need them,
>>> but normally such controls are left to the mgmt app above QEMU to set prior to
>>> the exec() of QEMU.
>>
>> I like your proposal! I just wanted to add an idea for an additional
>> parameter (not sure whether it is feasible, though): Something like
>> "-sandbox on,network=off" ... i.e. forbid all system calls that are used
>> for networking. Rationale: Sometimes your VM does not need any
>> networking, and you want to make sure that a malicious guest can also
>> not reach your local network in that case.
> 
> This is pretty tricky. Even if there is not obviously configured network
> backend in QEMU, there's plenty of scope for things in libraries to
> be using networking. Something want a fully qualified hostname ? That'll
> trigger UDP / TCP connections to a DNS resolver. Running with the SDL
> or GTK display frontends - those use networking over UNIX sockets to
> talk to a display server. Linked to glib2 ? That'll connect to DConf
> over DBus UNIX socket in the background. etc

Oh, too bad. Aren't there at least some system calls which could be used
to block TCP/IP connections, while we still allow local UNIX sockets?
... hmm, maybe that's rather something to solve at the SELinux level
instead...

 Thomas
