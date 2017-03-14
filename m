Received: from eggs.gnu.org ([2001:4830:134:3::10]:44673)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cnpaa-0006dS-GD
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 12:46:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cnpaW-0004yL-It
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 12:46:24 -0400
Received: from indium.canonical.com ([91.189.90.7]:42808)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1cnpaW-0004xR-DD
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 12:46:20 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1cnpaU-0001sh-NZ
	for <qemu-devel@nongnu.org>; Tue, 14 Mar 2017 16:46:18 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 86D262E80CD
	for <qemu-devel@nongnu.org>; Tue, 14 Mar 2017 16:46:17 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 14 Mar 2017 16:29:41 -0000
From: WhiteWinterWolf <1217339@bugs.launchpad.net>
Reply-To: Bug 1217339 <1217339@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20130827122907.17435.24292.malonedeb@gac.canonical.com>
Message-Id: <20170314162941.24018.11182.malone@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1217339] Re: SIGQUIT to send ACPI-shutdown to
 Guest
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Here is a short patch making Qemu to properly power off the guest when
receiving a SIGHUP signal.

I do not think that the way SIGTERM is handled should be modified as it
is needed to ask Qemu to forcefully close an unresponsive guest without
having to SIGKILL Qemu itself. Regarding SIGINT this is mostly a matter
of user expectation (Ctrl-C result), in doubt I keep the original
behavior.

On the other side, SIGHUP has a much flexible definition making it a
good candidate for the job.

IMHO I think such feature is really useful as it allows to cleanly close
all running VM without having to involve Qemu monitor in any way:

1. Send SIGHUP to all Qemu processes so the guests power off cleanly.
2. After a few time send SIGTERM to the remaining Qemu processes to forcefu=
lly close stuck guests.
3. After a few time send SIGKILL to the remaining Qemu processes to forcefu=
lly close stuck Qemu hypervisor processes.

I find this more convenient than having to fiddle with Qemu monitor to
implement step 1 as it must currently be done.

** Patch added: "1217339-signal_guest_shutdown.patch"
   https://bugs.launchpad.net/qemu/+bug/1217339/+attachment/4837713/+files/=
1217339-signal_guest_shutdown.patch

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1217339

Title:
  SIGQUIT to send ACPI-shutdown to Guest

Status in QEMU:
  New

Bug description:
  When qemu receives SIGQUIT, it should first try to run
  system_powerdown (giving the guest an ACPI signal to begin the
  shutdown process), before ending the whole qemu process.

  At this point there is no way to do a graceful shutdown if you do not
  have access to the monitor and you do not use any wrapper like
  libvirt.

  If, for some reason SIGQUIT would not be accepted as the signal, take
  any free to use signal, like SIGUSR1. There should be a way to get
  ACPI shutdown sent to the guest.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1217339/+subscriptions
