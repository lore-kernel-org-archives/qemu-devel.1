Received: from eggs.gnu.org ([2001:4830:134:3::10]:46976)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1euI3u-0006wi-Vg
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 08:27:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1euI3q-00038m-UZ
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 08:27:54 -0500
Received: from indium.canonical.com ([91.189.90.7]:60304)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1euI3q-00037y-KB
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 08:27:50 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1euI3n-0007sG-Sa
	for <qemu-devel@nongnu.org>; Fri, 09 Mar 2018 13:27:47 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 104982E82BF
	for <qemu-devel@nongnu.org>; Fri,  9 Mar 2018 13:20:40 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 09 Mar 2018 13:07:50 -0000
From: =?utf-8?b?TWFydGluICJldG8iICBNacWhw7p0aA==?= <1754656@bugs.launchpad.net>
Reply-To: Bug 1754656 <1754656@bugs.launchpad.net>
Sender: bounces@canonical.com
Message-Id: <152060087104.31174.3517029871758682734.malonedeb@wampee.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1754656] [NEW] Please solve graceful (ACPI)
 poweroff issue, using signals, most importantly SIGTERM
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Public bug reported:

Version:

QEMU emulator version 2.11.1

Introduction:

This is call for action to get attention of somebody in QEMU
project/organization, who is capable of actually doing something about
this pressing issue. This might be TLDR for some, but that's only
because of the complexity of the issue. Please read this with open mind.

Problem:

As QEMU users, we need (it is a requirement) to have some mechanism in
place, to somehow convert simple POSIX signal sent form host, into
graceful ACPI shutdown of the guest. This signal, due various historical
reasons and daemon design, must be SIGTERM foremost.

Status quo:

After wading through mailing lists and bug tracker I concluded that this
is "political" problem and I am in search of somebody, a "politician"
within QEMU project, who will help us reach conclusion to this problem.

First I will present analysis of the situation, and then propose some
suggestions for solutions.

Even then, any of these proposals might be, potentially, seen as
problematic in eyes of QEMU maintainers, developers, dictators, long
term users or their dogs.

That's why we need somebody willing, "higher up the chain" or whatever,
to orchestrate discussion so that we can actually reach consensus in the
matter, solution that is acceptable to **everyone**.

Analysis:

Each QEMU emulated virtual machine (vm), running in the host system, is
represented by single qemu-* process (followed by several threads). Thus
for all intents and purposes, any such instantiated vm, must be seen as
it's own, separate, daemon.

I repeat running qemu-* vm **is a daemon**.

QEMU provides incredible IO redirection capabilities, so we don't need
to get into issues of logging, console and monitor redirections and
such, as this is already a (perfectly) solved problem.

What we cannot currently do, at least easily, reliably and simply, is to
shutdown guest gracefully from "outside".

That is not a problem for those of us, who use some kind of higher level
orchestrator (I think one of them is virsh, but this is not important in
this matter) that takes care of this by communicating with QEMU directly
(I guess this is done by sending commands to internal monitor by pipe
(or socket) held open by mentioned orchestrator).

However it is a problem for those of us, who run qemu-* processes bare
or supervised.

Let's say I, as administrator, want to implement vm instance as supervised =
service.
I can use any supervisor for that, systemd even. Let us not get into into s=
upervisor wars.

At basic level almost all supervisors are similar. Supervisor usually is
yet another process, that "leads" the qemu-* one.

In case of systemd it is PID1, but in case of other supervision schemes,
like daemontools, runit, s6 or nosh, it is separate '*supervise' process
instead.

When such supervisor is tearing down the service, "leading"/supervising,
parent will send SIGTERM to it's child qemu-* process.

This behaviour is almost universal among all supervisors. This due the
fact, that it is customary for daemons to cease all operations and exit
cleanly when receiving SGITERM signal. If daemon child fails to exit
within configurable timeframe, supervisor deals with it by the means of
SIGKILL.

As such, one would expect, similarly, for qemu-* process to send ACPI
shutdown event to guest internally (roughly equivalent to
'system_powerdown' monitor command) on SIGTERM reception.

But this is not what happens!

Instead, qemu-* just flushes pending IO and kills the guest instantly.

Then, on next vm "boot", guest detects this as power failure event, and
performs fsck checks and other things, it is supposed to do in case of
power failure. We are not mentioning possible data loss that might have
happened due to this behavior, either.

Some supervisors (like systemd for example) might provide feature to
change "termiante operations" signal to something else like SIGTERM, but
that is not universal supervisor feature by any means. Default action
for any proper daemon is to cleanly terminate on SIGTERM.

That is why we need ability to somehow instruct QEMU to **always**
perform graceful ACPI shutdown on SIGTERM.

Potential reply to this bug saying that one should send
'system_powerdown' over monitor connection won't fly!

As it is not always possible (nor required) to hook into supervisor's
signal processing (main reason being intentional supervisor simplicity
in search of extreme reliability, and de facto standardized behavior of
daemons to exit cleanly on SIGTERM).

More over, in situations like machine reboot, most supervisors won't
play around with signal remapping, they will simply send out SIGTERM to
all supervised processes. We want our qemu-* instances to come up
undamaged from such action (on next host reboot) and not have them stuck
in fscks (or worse - ending up damaged) .

If this can be extended further, inside QEMU, with internal signal to
action remapping, the better, but supporting graceful shutdown on
SIGTERM is hard requirement.

Proposed solutions:

0. modify QEMU so that it emits ACPI shutdown event equivalent to 'system_p=
owerdown' monitor command by default
   - this seems to be a "no go", with backwards compat. and "current users =
expectations" =

     cited as the reasons
   - I won't go into a fact that QEMU changed option handling without BOLD =
notice few times

1. add single switch '-graceful-shutdown-on-sgiterm'
   - this was rejected when person tried to submit patch implementing somet=
hing similar =

     to what I am requesting, only bound to SIGHUP
   - that person (implementing graceful poweroff on SIGHUP) was wrong, almo=
st no =

     supervision scheme in existence sends out SIGHUP on service terminatio=
n request, =

     although all supervisors are able to send out SIGHUP when instructed
   - in daemons SIGHUP is usually reserved for "daemon reload" which can be=
 interpreted
     like "reboot" in QEMU context
   - if we see qemu-* proces for what it is, a daemon, it must react proper=
ly to SIGTERM foremost

2. add ability to map internal monitor action commands to few signals like =
SIGTERM, SIGHUP, SIGINTR, SIGUSR1, SIGUSR2, SIGALARM etc
   - this seems like best solution to me, that allows us to satisfy both =

     backwards compat. and "current users" requirement, yet allows us =

     to use qemu-* with proper supervision, and it even adds something extr=
a =

     (I know some of these signals are used internally by QEMU)
   - QEMU already has options parsing infrastructure in place to handle thi=
s nicely, something like:
     : -signal SIGTERM,monitorcommand=3Dsystem_powerdown -signal SIGHUP,mon=
itorcommand=3Dsystem_reset
     would be great in this case

3. add ability to map signals to executable scripts
   - with this scheme QEMU would spawn child on signal reception, and this =

     script would then be used to perform the action
   - this solution is most complex, most convoluted and most "flexible"
   - for example with definition like this:
     :  -signal SIGTERM,script=3Dsignals/sigterm
     qemu would perform this sequence of tasks:
       - on SIGTERM qemu-* would spawn child script ./signals/sigterm
         - this script would then pull out monitor fd descriptor from some =
kind of fd holder
         - would write 'system_powerdown' command into monitor fd and termi=
nate
       - qemu-* would then read the command from monitor
       - qemu-* would then interpret read-in command and gracefully termina=
te
   - option parsing infrastructure is in place and QEMU is able to spawn an=
d reap it's own children
     which is proven by network up/down scripts
    =


Of these, it seems that 0. and 1. are simplest to implement, yet
"politically" unimplementable.

More over QEMU people seem to be hard set on SIGTERM meaning "killing
unresponsive guest".

2. seems like most reasonable proposal that has potential to make
everyone happy. It is also most reliable because internal QEMU command
dispatch would have least chances to fail.

3. is most flexible and can also be combined with 2. Reliability wise,
there is slight chance signal handling script will fail to execute,
leaving qemu-* at the mercy of supervisor (timeouted SIGKILL).

Both 2 and 3 should probably provide configurable timeout after which
QEMU would perform default action (eg. as it does now).

Conclusion:

I hope QEMU project members understand severity of the issue and are
open to listed solutions. It might be that proposed solutions don't
match QEMU project "spirit" perfectly. If so, I urge people capable of
resolving this, to propose their versions.

The fact is, that with proliferation of systemd, popularity of
alternative supervisors is on the rise as well, but even under systemd,
unintuitive handling of SIGTERM by bare QEMU processes is a problem.

Further Reading:

https://patchwork.kernel.org/patch/9626293/

 - Daniel P. Berrange says:
   "Because QEMU already designate that as doing an immediate stop - ie it'=
ll
    allow QEMU block layer to flush pending I/O, but it will not wait for t=
he
    guest to shutdown.  If we change that behaviour we'll break anyone who
    is already relying on SIGHUP - qemu might never exit at all if the guest
    ignores the ACPI request"

 - this behaviour is incorrect if we perceive qemu-* process as daemon, pro=
per,
   yet it is, supposedly, entrenched in QEMU userbase
 - signals remapping capability would allow us to keep the "old" behavior f=
or entrenched users
   while it would allow administrators and orchestrator writers to select s=
ignal disposition =

   they actually need

https://bugs.launchpad.net/qemu/+bug/1217339 =

and =

https://lists.nongnu.org/archive/html/qemu-devel/2017-03/msg03039.html

 - on my QEMU version of 2.11.1 SIGTERM just kills the guest without proper=
 shutdown
   - although thread says exit is graceful
 - dicussion is problematic in several ways:
   - SIGTERM is not intended to "terminate unresponsive guest" eg "terminat=
e daemon uncleanly"
     in any sane daemon in existence
     - it means "terminate gracefully"
     - if "terminate unresponsive guest" was true meaning of SIGTERM, datab=
ases like =

       mariadb or postgers would kill themselves on SIGTERM, leaving data i=
n =

       inconsistent state, which they, of course, do not!
   - some kind of "signal tapping" similar to "port tapping" is suggested
     - this is non-obvious and error prone and nonstandard (no normal super=
visor =

       will play such signal tapping games)
     - signal remapping makes more sense in this regard

** Affects: qemu
     Importance: Undecided
         Status: New

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1754656

Title:
  Please solve graceful (ACPI) poweroff issue, using signals, most
  importantly SIGTERM

Status in QEMU:
  New

Bug description:
  Version:

  QEMU emulator version 2.11.1

  Introduction:

  This is call for action to get attention of somebody in QEMU
  project/organization, who is capable of actually doing something about
  this pressing issue. This might be TLDR for some, but that's only
  because of the complexity of the issue. Please read this with open
  mind.

  Problem:

  As QEMU users, we need (it is a requirement) to have some mechanism in
  place, to somehow convert simple POSIX signal sent form host, into
  graceful ACPI shutdown of the guest. This signal, due various
  historical reasons and daemon design, must be SIGTERM foremost.

  Status quo:

  After wading through mailing lists and bug tracker I concluded that
  this is "political" problem and I am in search of somebody, a
  "politician" within QEMU project, who will help us reach conclusion to
  this problem.

  First I will present analysis of the situation, and then propose some
  suggestions for solutions.

  Even then, any of these proposals might be, potentially, seen as
  problematic in eyes of QEMU maintainers, developers, dictators, long
  term users or their dogs.

  That's why we need somebody willing, "higher up the chain" or
  whatever, to orchestrate discussion so that we can actually reach
  consensus in the matter, solution that is acceptable to **everyone**.

  Analysis:

  Each QEMU emulated virtual machine (vm), running in the host system,
  is represented by single qemu-* process (followed by several threads).
  Thus for all intents and purposes, any such instantiated vm, must be
  seen as it's own, separate, daemon.

  I repeat running qemu-* vm **is a daemon**.

  QEMU provides incredible IO redirection capabilities, so we don't need
  to get into issues of logging, console and monitor redirections and
  such, as this is already a (perfectly) solved problem.

  What we cannot currently do, at least easily, reliably and simply, is
  to shutdown guest gracefully from "outside".

  That is not a problem for those of us, who use some kind of higher
  level orchestrator (I think one of them is virsh, but this is not
  important in this matter) that takes care of this by communicating
  with QEMU directly (I guess this is done by sending commands to
  internal monitor by pipe (or socket) held open by mentioned
  orchestrator).

  However it is a problem for those of us, who run qemu-* processes bare
  or supervised.

  Let's say I, as administrator, want to implement vm instance as supervise=
d service.
  I can use any supervisor for that, systemd even. Let us not get into into=
 supervisor wars.

  At basic level almost all supervisors are similar. Supervisor usually
  is yet another process, that "leads" the qemu-* one.

  In case of systemd it is PID1, but in case of other supervision
  schemes, like daemontools, runit, s6 or nosh, it is separate
  '*supervise' process instead.

  When such supervisor is tearing down the service,
  "leading"/supervising, parent will send SIGTERM to it's child qemu-*
  process.

  This behaviour is almost universal among all supervisors. This due the
  fact, that it is customary for daemons to cease all operations and
  exit cleanly when receiving SGITERM signal. If daemon child fails to
  exit within configurable timeframe, supervisor deals with it by the
  means of SIGKILL.

  As such, one would expect, similarly, for qemu-* process to send ACPI
  shutdown event to guest internally (roughly equivalent to
  'system_powerdown' monitor command) on SIGTERM reception.

  But this is not what happens!

  Instead, qemu-* just flushes pending IO and kills the guest instantly.

  Then, on next vm "boot", guest detects this as power failure event,
  and performs fsck checks and other things, it is supposed to do in
  case of power failure. We are not mentioning possible data loss that
  might have happened due to this behavior, either.

  Some supervisors (like systemd for example) might provide feature to
  change "termiante operations" signal to something else like SIGTERM,
  but that is not universal supervisor feature by any means. Default
  action for any proper daemon is to cleanly terminate on SIGTERM.

  That is why we need ability to somehow instruct QEMU to **always**
  perform graceful ACPI shutdown on SIGTERM.

  Potential reply to this bug saying that one should send
  'system_powerdown' over monitor connection won't fly!

  As it is not always possible (nor required) to hook into supervisor's
  signal processing (main reason being intentional supervisor simplicity
  in search of extreme reliability, and de facto standardized behavior
  of daemons to exit cleanly on SIGTERM).

  More over, in situations like machine reboot, most supervisors won't
  play around with signal remapping, they will simply send out SIGTERM
  to all supervised processes. We want our qemu-* instances to come up
  undamaged from such action (on next host reboot) and not have them
  stuck in fscks (or worse - ending up damaged) .

  If this can be extended further, inside QEMU, with internal signal to
  action remapping, the better, but supporting graceful shutdown on
  SIGTERM is hard requirement.

  Proposed solutions:

  0. modify QEMU so that it emits ACPI shutdown event equivalent to 'system=
_powerdown' monitor command by default
     - this seems to be a "no go", with backwards compat. and "current user=
s expectations" =

       cited as the reasons
     - I won't go into a fact that QEMU changed option handling without BOL=
D notice few times

  1. add single switch '-graceful-shutdown-on-sgiterm'
     - this was rejected when person tried to submit patch implementing som=
ething similar =

       to what I am requesting, only bound to SIGHUP
     - that person (implementing graceful poweroff on SIGHUP) was wrong, al=
most no =

       supervision scheme in existence sends out SIGHUP on service terminat=
ion request, =

       although all supervisors are able to send out SIGHUP when instructed
     - in daemons SIGHUP is usually reserved for "daemon reload" which can =
be interpreted
       like "reboot" in QEMU context
     - if we see qemu-* proces for what it is, a daemon, it must react prop=
erly to SIGTERM foremost

  2. add ability to map internal monitor action commands to few signals lik=
e SIGTERM, SIGHUP, SIGINTR, SIGUSR1, SIGUSR2, SIGALARM etc
     - this seems like best solution to me, that allows us to satisfy both =

       backwards compat. and "current users" requirement, yet allows us =

       to use qemu-* with proper supervision, and it even adds something ex=
tra =

       (I know some of these signals are used internally by QEMU)
     - QEMU already has options parsing infrastructure in place to handle t=
his nicely, something like:
       : -signal SIGTERM,monitorcommand=3Dsystem_powerdown -signal SIGHUP,m=
onitorcommand=3Dsystem_reset
       would be great in this case

  3. add ability to map signals to executable scripts
     - with this scheme QEMU would spawn child on signal reception, and thi=
s =

       script would then be used to perform the action
     - this solution is most complex, most convoluted and most "flexible"
     - for example with definition like this:
       :  -signal SIGTERM,script=3Dsignals/sigterm
       qemu would perform this sequence of tasks:
         - on SIGTERM qemu-* would spawn child script ./signals/sigterm
           - this script would then pull out monitor fd descriptor from som=
e kind of fd holder
           - would write 'system_powerdown' command into monitor fd and ter=
minate
         - qemu-* would then read the command from monitor
         - qemu-* would then interpret read-in command and gracefully termi=
nate
     - option parsing infrastructure is in place and QEMU is able to spawn =
and reap it's own children
       which is proven by network up/down scripts
      =


  Of these, it seems that 0. and 1. are simplest to implement, yet
  "politically" unimplementable.

  More over QEMU people seem to be hard set on SIGTERM meaning "killing
  unresponsive guest".

  2. seems like most reasonable proposal that has potential to make
  everyone happy. It is also most reliable because internal QEMU command
  dispatch would have least chances to fail.

  3. is most flexible and can also be combined with 2. Reliability wise,
  there is slight chance signal handling script will fail to execute,
  leaving qemu-* at the mercy of supervisor (timeouted SIGKILL).

  Both 2 and 3 should probably provide configurable timeout after which
  QEMU would perform default action (eg. as it does now).

  Conclusion:

  I hope QEMU project members understand severity of the issue and are
  open to listed solutions. It might be that proposed solutions don't
  match QEMU project "spirit" perfectly. If so, I urge people capable of
  resolving this, to propose their versions.

  The fact is, that with proliferation of systemd, popularity of
  alternative supervisors is on the rise as well, but even under
  systemd, unintuitive handling of SIGTERM by bare QEMU processes is a
  problem.

  Further Reading:

  https://patchwork.kernel.org/patch/9626293/

   - Daniel P. Berrange says:
     "Because QEMU already designate that as doing an immediate stop - ie i=
t'll
      allow QEMU block layer to flush pending I/O, but it will not wait for=
 the
      guest to shutdown.  If we change that behaviour we'll break anyone who
      is already relying on SIGHUP - qemu might never exit at all if the gu=
est
      ignores the ACPI request"

   - this behaviour is incorrect if we perceive qemu-* process as daemon, p=
roper,
     yet it is, supposedly, entrenched in QEMU userbase
   - signals remapping capability would allow us to keep the "old" behavior=
 for entrenched users
     while it would allow administrators and orchestrator writers to select=
 signal disposition =

     they actually need

  https://bugs.launchpad.net/qemu/+bug/1217339 =

  and =

  https://lists.nongnu.org/archive/html/qemu-devel/2017-03/msg03039.html

   - on my QEMU version of 2.11.1 SIGTERM just kills the guest without prop=
er shutdown
     - although thread says exit is graceful
   - dicussion is problematic in several ways:
     - SIGTERM is not intended to "terminate unresponsive guest" eg "termin=
ate daemon uncleanly"
       in any sane daemon in existence
       - it means "terminate gracefully"
       - if "terminate unresponsive guest" was true meaning of SIGTERM, dat=
abases like =

         mariadb or postgers would kill themselves on SIGTERM, leaving data=
 in =

         inconsistent state, which they, of course, do not!
     - some kind of "signal tapping" similar to "port tapping" is suggested
       - this is non-obvious and error prone and nonstandard (no normal sup=
ervisor =

         will play such signal tapping games)
       - signal remapping makes more sense in this regard

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1754656/+subscriptions
