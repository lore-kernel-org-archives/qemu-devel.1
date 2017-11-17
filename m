Received: from eggs.gnu.org ([2001:4830:134:3::10]:47824)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eFlKo-0000fS-6Z
	for qemu-devel@nongnu.org; Fri, 17 Nov 2017 13:25:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eFlKj-0005bf-CU
	for qemu-devel@nongnu.org; Fri, 17 Nov 2017 13:25:50 -0500
Received: from indium.canonical.com ([91.189.90.7]:49032)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1eFlKj-0005bD-2Z
	for qemu-devel@nongnu.org; Fri, 17 Nov 2017 13:25:45 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1eFlKh-0002uD-3j
	for <qemu-devel@nongnu.org>; Fri, 17 Nov 2017 18:25:43 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 19E6D2E80C0
	for <qemu-devel@nongnu.org>; Fri, 17 Nov 2017 18:25:43 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 17 Nov 2017 18:17:20 -0000
From: Neil Skrypuch <1732959@bugs.launchpad.net>
Reply-To: Bug 1732959 <1732959@bugs.launchpad.net>
Sender: bounces@canonical.com
Message-Id: <151094264088.1535.6755029665700711915.malonedeb@chaenomeles.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1732959] [NEW] [regression] Clock jump on source
 VM after migration
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

We (ab)use migration + block mirroring to perform transparent zero
downtime VM backups. Basically:

1) do a block mirror of the source VM's disk
2) migrate the source VM to a destination VM using the disk copy
3) cancel the block mirroring
4) resume the source VM
5) shut down the destination VM gracefully and move the disk to backup

Relatively recently, the source VM's clock started jumping after step
#4. More specifically, the clock jumps an amount of time proportional to
the time since it was last migrated. With a week between migrations,
clock jumps between ~2.5s and ~12s have been observed. For a particular
host, the amount of clock jump is fairly consistent, but there is a
large variation from one host to the next (this is likely down to
hardware variations and the amount of NTP adjusted clock drift on the
host).

This is caused by a kernel regression which I was able to bisect. The
result of the bisect was:

108b249c453dd7132599ab6dc7e435a7036c193f is the first bad commit
commit 108b249c453dd7132599ab6dc7e435a7036c193f
Author: Paolo Bonzini <pbonzini@redhat.com>
Date:   Thu Sep 1 14:21:03 2016 +0200

    KVM: x86: introduce get_kvmclock_ns
    =

    Introduce a function that reads the exact nanoseconds value that is
    provided to the guest in kvmclock.  This crystallizes the notion of
    kvmclock as a thin veneer over a stable TSC, that the guest will
    (hopefully) convert with NTP.  In other words, kvmclock is *not* a
    paravirtualized host-to-guest NTP.
    =

    Drop the get_kernel_ns() function, that was used both to get the base
    value of the master clock and to get the current value of kvmclock.
    The former use is replaced by ktime_get_boot_ns(), the latter is
    the purpose of get_kernel_ns().
    =

    This also allows KVM to provide a Hyper-V time reference counter that
    is synchronized with the time that is computed from the TSC page.
    =

    Reviewed-by: Roman Kagan <rkagan@virtuozzo.com>
    Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

I am able to reproduce the issue with much newer kernels as well,
including 4.12.5 and 4.9.6.

Reliably reproducing the problem in isolation is difficult, as one must
run a VM for many hours before the clock jump from this bug is
noticeable over the clock jump inherent with a pause and resume of the
VM. The reproducer I am including is set to run the VM for 18 hours
before migration and looks for >=3D 150 ms of clock jump. On different
hardware, you may need to let the VM run for more than 18 hours to
reliably reproduce the issue.

To reproduce the issue, please see the attached reproducer. The host
needs to have perl, screen and socat installed for the backup script to
work. Both the host and guest need to be running NTP (and NTP must
autostart at boot in the guest). The host needs to be able to SSH into
the guest using SSH keys (to measure the clock jump), so you will need
to configure the network and SSH keys appropriately, then change the
hardcoded IP address in checktime.sh and test.sh. I have only tested
with CentOS 7 guests.

The qemu command that gets run is in .kvmscreen (the destination VM's
command line is programmatically constructed from this command as well),
you may need to tweak the bridge configuration. Also, although the
reproducer is relatively self contained, it has several built in
assumptions that will break if the image file is not in the /var/lib/kvm
directory or if the monitor file is not in the /var/lib/kvm/monitor
directory, or if the /backup directory does not exist. Finally, if you
change the process name or socket name in .kvmscreen, you'll need to
adjust the cleanup section in test.sh.

With all of the above in place, run test.sh and check back in a little
over 18 hours, part of the output should include something along these
lines:

Target not found (wanted 150, at 10)

- or -

Target found (wanted 150, found 340)

If the target is reported as found, that means that we have probably
reproduced the described issue.

The version of QEMU in use does not appear to matter. At one point I
tested every major version from 2.4 to 2.9 (inclusive) and reproduced
the issue in all of them.

This was initially observed on two different Gentoo hosts. I have also
started to see this issue happening with four different RHEL 7 hosts as
of the upgrade to RHEL 7.4. This is not too surprising as it appears
that the above commit has been backported into RHEL 7. All hosts and
guests are 64-bit.

** Affects: qemu
     Importance: Undecided
         Status: New

** Attachment added: "qemu-clock-jump-reproducer.tar.bz2"
   https://bugs.launchpad.net/bugs/1732959/+attachment/5010639/+files/qemu-=
clock-jump-reproducer.tar.bz2

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1732959

Title:
  [regression] Clock jump on source VM after migration

Status in QEMU:
  New

Bug description:
  We (ab)use migration + block mirroring to perform transparent zero
  downtime VM backups. Basically:

  1) do a block mirror of the source VM's disk
  2) migrate the source VM to a destination VM using the disk copy
  3) cancel the block mirroring
  4) resume the source VM
  5) shut down the destination VM gracefully and move the disk to backup

  Relatively recently, the source VM's clock started jumping after step
  #4. More specifically, the clock jumps an amount of time proportional
  to the time since it was last migrated. With a week between
  migrations, clock jumps between ~2.5s and ~12s have been observed. For
  a particular host, the amount of clock jump is fairly consistent, but
  there is a large variation from one host to the next (this is likely
  down to hardware variations and the amount of NTP adjusted clock drift
  on the host).

  This is caused by a kernel regression which I was able to bisect. The
  result of the bisect was:

  108b249c453dd7132599ab6dc7e435a7036c193f is the first bad commit
  commit 108b249c453dd7132599ab6dc7e435a7036c193f
  Author: Paolo Bonzini <pbonzini@redhat.com>
  Date:   Thu Sep 1 14:21:03 2016 +0200

      KVM: x86: introduce get_kvmclock_ns
      =

      Introduce a function that reads the exact nanoseconds value that is
      provided to the guest in kvmclock.  This crystallizes the notion of
      kvmclock as a thin veneer over a stable TSC, that the guest will
      (hopefully) convert with NTP.  In other words, kvmclock is *not* a
      paravirtualized host-to-guest NTP.
      =

      Drop the get_kernel_ns() function, that was used both to get the base
      value of the master clock and to get the current value of kvmclock.
      The former use is replaced by ktime_get_boot_ns(), the latter is
      the purpose of get_kernel_ns().
      =

      This also allows KVM to provide a Hyper-V time reference counter that
      is synchronized with the time that is computed from the TSC page.
      =

      Reviewed-by: Roman Kagan <rkagan@virtuozzo.com>
      Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

  I am able to reproduce the issue with much newer kernels as well,
  including 4.12.5 and 4.9.6.

  Reliably reproducing the problem in isolation is difficult, as one
  must run a VM for many hours before the clock jump from this bug is
  noticeable over the clock jump inherent with a pause and resume of the
  VM. The reproducer I am including is set to run the VM for 18 hours
  before migration and looks for >=3D 150 ms of clock jump. On different
  hardware, you may need to let the VM run for more than 18 hours to
  reliably reproduce the issue.

  To reproduce the issue, please see the attached reproducer. The host
  needs to have perl, screen and socat installed for the backup script
  to work. Both the host and guest need to be running NTP (and NTP must
  autostart at boot in the guest). The host needs to be able to SSH into
  the guest using SSH keys (to measure the clock jump), so you will need
  to configure the network and SSH keys appropriately, then change the
  hardcoded IP address in checktime.sh and test.sh. I have only tested
  with CentOS 7 guests.

  The qemu command that gets run is in .kvmscreen (the destination VM's
  command line is programmatically constructed from this command as
  well), you may need to tweak the bridge configuration. Also, although
  the reproducer is relatively self contained, it has several built in
  assumptions that will break if the image file is not in the
  /var/lib/kvm directory or if the monitor file is not in the
  /var/lib/kvm/monitor directory, or if the /backup directory does not
  exist. Finally, if you change the process name or socket name in
  .kvmscreen, you'll need to adjust the cleanup section in test.sh.

  With all of the above in place, run test.sh and check back in a little
  over 18 hours, part of the output should include something along these
  lines:

  Target not found (wanted 150, at 10)

  - or -

  Target found (wanted 150, found 340)

  If the target is reported as found, that means that we have probably
  reproduced the described issue.

  The version of QEMU in use does not appear to matter. At one point I
  tested every major version from 2.4 to 2.9 (inclusive) and reproduced
  the issue in all of them.

  This was initially observed on two different Gentoo hosts. I have also
  started to see this issue happening with four different RHEL 7 hosts
  as of the upgrade to RHEL 7.4. This is not too surprising as it
  appears that the above commit has been backported into RHEL 7. All
  hosts and guests are 64-bit.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1732959/+subscriptions
