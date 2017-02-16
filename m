Received: from eggs.gnu.org ([2001:4830:134:3::10]:47017)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1ceHam-0003s3-8I
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 03:39:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1ceHah-0000f8-AX
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 03:39:08 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38518)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1ceHah-0000f1-1h
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 03:39:03 -0500
References: <20170215182732.GN24672@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <5ae6dee4-779b-7073-4192-21554b8a2b62@redhat.com>
Date: Thu, 16 Feb 2017 09:38:59 +0100
MIME-Version: 1.0
In-Reply-To: <20170215182732.GN24672@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] RFC: How to make seccomp reliable and useful ?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: Eduardo Otubo <eduardo.otubo@profitbricks.com>

On 15.02.2017 19:27, Daniel P. Berrange wrote:
> The current impl of seccomp in QEMU is intentionally allowing a huge ra=
nge
> of system calls to be executed. The goal was that running '-sandbox on'
> should never break any feature of QEMU, so naturally any syscall that c=
an
> executed on any codepath QEMU takes must be allowed.
>=20
> This is good for usability because users don't need to understand the t=
echnical
> details of the sandbox technology, they merely say "on" and it "just wo=
rks".
> Conversely though, this is bad for security because QEMU has to allow a=
 huge
> range of system calls to be used due to its broad functionality.
>=20
> During initial discussions for seccomp back in 2012 it was suggested, t=
here
> might be alternate policies developed for QEMU which deny some features=
, but
> improve security overall. To best of my knowledge, this has never been =
discussed
> again since then.
>=20
>=20
> In addition, since initially merging, there has been a steady stream of=
 patches
> to whitelist further syscalls that were missing. Some of these were mis=
sing due
> to newly added functionality in QEMU since the original seccomp impl, w=
hile
> others have been missing since day 1. It is reasonable to expect that t=
here are
> still many syscalls missing in the whitelist. In just a couple of minut=
es of
> comparing the whitelist vs global syscall list it was possible to ident=
ify two
> further missing syscalls. The '-netdev bridge,br=3Dvirbr0' network back=
end fails
> because setuid is blocked, preventing execution of the qemu-bridge-help=
er
> program. If built against glibc < 2.9, or running on kernel < 2.6.27 it=
 will
> fail to call eventfd() because we only permit eventfd2() syscall, not t=
he
> older eventfd() syscall used on older Linux. Some ifup scripts used wit=
h the
> -netdev arg may also break due to lack of chmod, flock, getxattr permis=
sions.
> This risk of missing syscalls is why -sandbox defaults to off, and we'v=
e never
> considered defaulting it to on.
>=20
>=20
> The fundamental problem is that building a whitelist of syscalls used b=
y QEMU
> emulators is an intractable problem. QEMU on my system links to 183 dif=
ferent
> shared libraries and there is no way in the world that anyone can figur=
e out
> which code paths QEMU triggers in these libraries and thus identify whi=
ch
> syscalls will be genuinely needed.
>=20
> Thus a whitelist based approach for QEMU is doomed to always be missing=
 some
> syscalls, resulting in uneccessary abrts of QEMU when it tickles some e=
dge
> case. If you are lucky the abort() happens at startup so you see it qui=
ckly
> and can address it. If you are unlucky the abort() happens after your V=
M has
> been running for days/week/months and you loose data.
>=20
> IOW, seccomp integration as it currently exists today in QEMU offers mi=
nimal
> security benefits, while at the same time causing spurious crashes whic=
h may
> cause user data loss from aborting a running VM, discouraging users fro=
m using
> even the minimal protection it offers.
>=20
> I think we need to rework our seccomp support so that we can have a hig=
h enough
> level of confidence in it, that it could be enabled by default. At the =
same time
> we need to make it do something more tangibly useful from a security PO=
V.
>=20
>=20
> First we need to admit that whitelisting is a failed approach, and swit=
ch to
> using blacklisting. Unless we do this, we'll never have high enough con=
fidence
> to enable it by default - something that's never turned on might as wel=
l not
> exist at all.
>=20
>=20
> There is a reasonable easily identifiable set of syscalls that QEMU sho=
uld
> never be permitted to use, no matter what configuration it is in, what =
helpers
> it spawns, or what libraries it links to. eg reboot, swapon, swapoff,  =
syslog,
> mount, unmount, kexec_*, etc - any syscall that affects global system s=
tate,
> rather than process local state should be forbidden.
>=20
> There are some syscalls that are simply hardcoded to return ENOSYS whic=
h can
> be trivially blacklisted. afs_syscall, break, fattach, ftime, etc (see =
the
> man page 'unimplemented(2)').
>=20
> There are some syscalls which are considered obsolete - they were previ=
ously
> useful, but no modern code would call them, as they have been superceed=
ed.
> For example, readdir replaced by getdents. We could blacklist these by =
default
> but provide a way to allow use of obsolete syscalls if running on older=
 systems.
> e.g. '-sandbox on,obsolete=3Dallow'. They might be obsolete enough that=
 we decide
> to just block them permanently with no opt in - would need to analyse w=
hen
> their replacements appeared in widespread use.
>=20
> There might be a few more syscalls which we can determine are never val=
id to
> use in QEMU or any library or helper program it might run. I expect thi=
s list
> to be very small though, given the impossibility of auditing code paths=
 through
> millions of lines of code QEMU links to.
>=20
> Everything else should be allowed.
>=20
> At this point we have a highly reliable "-sandbox on" which we're not h=
aving
> to constantly patch.
>=20
> From here we need a way to allow a user to opt-in to more restrictive p=
olicies,
> accepting that it will block certain features. For example, there shoul=
d be a
> a way to disable any means to elevate privileges from QEMU or things it=
 spawns.
> e.g. '-sandbox on,elevateprivileges=3Ddeny'.
>=20
> This would not only block the variuous set*uid|gid functions via seccom=
p, but
> should also prctl(PR_SET_NO_NEW_PRIVS). This would allows the user to o=
ptin to
> a restrictive world if they know they'll not require things like the se=
tuid
> bridge helper.
>=20
> Similarly there should be an '-sandbox on,spawn=3Ddeny' which prevents =
the ability
> to fork/exec processes at all, whether privileged or not. This would bl=
ock
> features like the qemu bridge helper, SMB server, ifup/down scripts, mi=
gration
> exec: protocol. These are all rarely used features though, so an opt-in=
 to block
> their use is reasonable & desirable.
>=20
> A -sandbox on,resourcecontrol=3Ddeny, which prevents QEMU from setting =
stuff like
> process affinity, schedular priority, etc. Some uses of QEMU might need=
 them,
> but normally such controls are left to the mgmt app above QEMU to set p=
rior to
> the exec() of QEMU.

I like your proposal! I just wanted to add an idea for an additional
parameter (not sure whether it is feasible, though): Something like
"-sandbox on,network=3Doff" ... i.e. forbid all system calls that are use=
d
for networking. Rationale: Sometimes your VM does not need any
networking, and you want to make sure that a malicious guest can also
not reach your local network in that case.

 Thomas
