Received: from eggs.gnu.org ([2001:4830:134:3::10]:60942)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1d83Vf-0002gM-Ca
	for qemu-devel@nongnu.org; Tue, 09 May 2017 07:40:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1d83Vc-00053Y-64
	for qemu-devel@nongnu.org; Tue, 09 May 2017 07:40:55 -0400
Received: from indium.canonical.com ([91.189.90.7]:50218)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1d83Vb-00053N-Vk
	for qemu-devel@nongnu.org; Tue, 09 May 2017 07:40:52 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1d83Va-00061Q-3q
	for <qemu-devel@nongnu.org>; Tue, 09 May 2017 11:40:50 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 194F72E80C8
	for <qemu-devel@nongnu.org>; Tue,  9 May 2017 11:40:50 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 09 May 2017 11:26:26 -0000
From: ChristianEhrhardt <1689499@bugs.launchpad.net>
Reply-To: Bug 1689499 <1689499@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <149431685971.9593.12799784331390412455.malonedeb@gac.canonical.com>
	<149432646134.2379.8594283579460179963.malone@gac.canonical.com>
Message-Id: <CAATJJ0L55yKdbPccbT_Mqhn22eKpuYX0S2-TT8zhXOcqgKNpug@mail.gmail.com>
Errors-To: bounces@canonical.com
Subject: Re: [Qemu-devel] [Bug 1689499] Re: copy-storage-all/inc does not
 easily converge with load going on
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

On Tue, May 9, 2017 at 12:41 PM, Dr. David Alan Gilbert <dgilbert@redhat.com
> wrote:

> Interesting.
> That's quite a big difference, so if you could bisect it down it would be
> interesting to figure out where the change occurred.
>

Hi David,
if it turns out to stay reproducible enough I can certainly try somewhen
next week.

What happens if you just make it a 'disk' workload without the memory
> stress?
>

Will do so along my checks if it triggers reliably enough for a bisect.


> What network interface (1G/10G etc) are you migrating over and what
> bandwidth limit have you got set?
>

No explicit bandwith limit set, the connection itself is only virtual
(migrating two libvirt/qemu stacks in between lxd containers) so other than
networking overhead this is usually really fast.
I quickly sniffed with iperf on a few of the test hosts and speed was
around 30-120 GBit/s which should qualify as "fast enough".

I'll get back to you once I found the time to verify reproducibility and
hopefully a bisect.
I beg your pardon as this might need a few days (to free up my tasks as
well a system capable to do so).

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1689499

Title:
  copy-storage-all/inc does not easily converge with load going on

Status in QEMU:
  New

Bug description:
  Hi,
  for now this is more a report to discuss than a "bug", but I wanted to be=
 sure if there are things I might overlook.

  I'm regularly testing the qemu's we have in Ubuntu which currently are
  2.0, 2.5, 2.6.1, 2.8 plus a bunch of patches. And for all sorts of
  verification upstream every now and then.

  I recently realized that the migration options around --copy-storage-[all=
/inc] seem to have got worse at converging on migration. Although it is not=
 a hard commit that is to be found, it just seems more likely to occur the =
newer the qemu versions is. I assume that is partially due to guest perform=
ance optimization that keep it busy.
  To a user it appears as a hanging migration being locked up.

  But let me outline what actually happens:
  - Setup without shared storage
  - Migration using --copy-storage-all/--copy-storage-inc
  - Working fine with idle guests
  - If the guests is busy the migration does take like forever (1 vCPU that=
 are busy with 1 CPU, 1 memory and one disk hogging processes)
  - statistically seems to trigger more likely on newer qemu's (might be a =
red herring)

  The background workloads are most trivial burners:
  - cpu: md5sum /dev/urandom
  - memory: stress-ng -m 1 --vm-keep --vm-bytes 256M
  - disk: while /bin/true; do dd if=3D/dev/urandom of=3D/var/tmp/mjb.1 bs=
=3D4M count=3D100; done

  We are talking about ~1-2 minutes on qemu 2.5 (4 tries x 3
  architectures) and 2-10+ hours on >=3Dqemu 2.6.1.

  I say it is likely not a bug, but more a discussion as I can easily avoid=
 hanging via either:
  - timeouts (--timeout, ...) to abort or suspend to migrate it
  - --auto-converge ( I had only one try, but it seemed to help by slowing =
down the load generators)

  So you might say "that is all as it should be, and the users can use
  the further options to mitigate" and I'm all fine with that. In that
  case the bug still serves as a "searchable" document of some kind for
  others triggering the same case. But if anything comes to your mind
  that need better handling around this case lets start to discuss more
  deeply about it.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1689499/+subscriptions
