Received: from eggs.gnu.org ([2001:4830:134:3::10]:45488)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1e2kbK-0005Wy-Cv
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 17:01:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1e2kbG-0001nJ-62
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 17:01:06 -0400
Received: from indium.canonical.com ([91.189.90.7]:47834)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1e2kbG-0001mn-03
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 17:01:02 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1e2kbD-0003gK-Ms
	for <qemu-devel@nongnu.org>; Thu, 12 Oct 2017 21:00:59 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id AC0FA2E80C9
	for <qemu-devel@nongnu.org>; Thu, 12 Oct 2017 21:00:59 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 12 Oct 2017 20:53:36 -0000
From: William Tambe <1723161@bugs.launchpad.net>
Reply-To: Bug 1723161 <1723161@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <150782239801.1729.1327212510076491094.malonedeb@chaenomeles.canonical.com>
	<150783628168.1135.15807112276961556760.malone@chaenomeles.canonical.com>
Message-Id: <CAF8i9mNY+efACC5FfQ8xqBpoLeYxLB8dE4OSxbVVVxht21O6kg@mail.gmail.com>
Errors-To: bounces@canonical.com
Subject: Re: [Qemu-devel] [Bug 1723161] Re: Migration failing in qemu-2.10.1
 but working qemu-2.9.1 and earlier with same options
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Hi David,

Please let me know if you have preferred name.

I am an AMD employee.

Including my colleagues to this thread ...

The only error on the source side is the migration failure reported on
the source monitor when doing "info migration" .

It was indeed something related to the pflash, because migration will
work when removing the following entries:
-drive if=3Dpflash,format=3Draw,unit=3D0,file=3DOVMF_CODE.fd,readonly
-drive if=3Dpflash,format=3Draw,unit=3D1,file=3DOVMF_VARS.fd

I will take a look at the migration/block.c block_load code as you
suggested.

Sincerely,
William Tambe


On Thu, Oct 12, 2017 at 2:24 PM, Dr. David Alan Gilbert
<dgilbert@redhat.com> wrote:
> Interesting; As a test could you try removing the cdrom entry (I doubt th=
at'll help but it's worth a go).
> Also, is it possible for you to try a bisection?
>
> If I was to guess, I'd bet it's something relating to the pflash, but I
> don't know; it's unfortunate the block migration doesn't say what it got
> upset by.
>
> Are there no errors on the source side?
>
> Assuming there are no errors on the source side, I'd have to suggest
> taking a printf to migration/block.c block_load to find out which exit
> it's falling out of in there (at least I think that's what would cause
> that error)
>
> --
> You received this bug notification because you are subscribed to the bug
> report.
> https://bugs.launchpad.net/bugs/1723161
>
> Title:
>   Migration failing in qemu-2.10.1 but working qemu-2.9.1 and earlier
>   with same options
>
> Status in QEMU:
>   New
>
> Bug description:
>
>   Qemu-2.10.1 migration failing with the following error:
>   Receiving block device images
>   qemu-system-x86_64: error while loading section id 2(block)
>   qemu-system-x86_64: load of migration failed: Input/output error
>
>   Migration is setup on the destination system of the migration using:
>   -incoming tcp:0:4444
>
>   Migration is initiated from the source using the following commands in =
its qemu monitor:
>   migrate -b "tcp:localhost:4444"
>
>   The command-line used in both the source and destination is:
>   qemu-system-x86_64 \
>           -nodefaults \
>           -pidfile vm0.pid \
>           -enable-kvm \
>           -machine q35 \
>           -cpu host -smp 2 \
>           -m 4096M \
>           -drive if=3Dpflash,format=3Draw,unit=3D0,file=3DOVMF_CODE.fd,re=
adonly \
>           -drive if=3Dpflash,format=3Draw,unit=3D1,file=3DOVMF_VARS.fd \
>           -drive file=3D${HDRIVE},format=3Dqcow2 \
>           -drive media=3Dcdrom \
>           -usb -device usb-tablet \
>           -vga std -vnc :0 \
>           -net nic,macaddr=3D${TAPMACADDR} -net user,net=3D192.168.2.0/24=
,dhcpstart=3D192.168.2.10 \
>           -serial stdio \
>           -monitor unix:${MONITORSOCKET},server,nowait
>
> To manage notifications about this bug go to:
> https://bugs.launchpad.net/qemu/+bug/1723161/+subscriptions

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1723161

Title:
  Migration failing in qemu-2.10.1 but working qemu-2.9.1 and earlier
  with same options

Status in QEMU:
  New

Bug description:
  =

  Qemu-2.10.1 migration failing with the following error:
  Receiving block device images
  qemu-system-x86_64: error while loading section id 2(block)
  qemu-system-x86_64: load of migration failed: Input/output error

  Migration is setup on the destination system of the migration using:
  -incoming tcp:0:4444

  Migration is initiated from the source using the following commands in it=
s qemu monitor:
  migrate -b "tcp:localhost:4444"

  The command-line used in both the source and destination is:
  qemu-system-x86_64 \
          -nodefaults \
          -pidfile vm0.pid \
          -enable-kvm \
          -machine q35 \
          -cpu host -smp 2 \
          -m 4096M \
          -drive if=3Dpflash,format=3Draw,unit=3D0,file=3DOVMF_CODE.fd,read=
only \
          -drive if=3Dpflash,format=3Draw,unit=3D1,file=3DOVMF_VARS.fd \
          -drive file=3D${HDRIVE},format=3Dqcow2 \
          -drive media=3Dcdrom \
          -usb -device usb-tablet \
          -vga std -vnc :0 \
          -net nic,macaddr=3D${TAPMACADDR} -net user,net=3D192.168.2.0/24,d=
hcpstart=3D192.168.2.10 \
          -serial stdio \
          -monitor unix:${MONITORSOCKET},server,nowait

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1723161/+subscriptions
