Received: from eggs.gnu.org ([2001:4830:134:3::10]:42638)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1cONPT-0002JX-MN
	for qemu-devel@nongnu.org; Tue, 03 Jan 2017 06:37:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1cONPQ-0001eG-H8
	for qemu-devel@nongnu.org; Tue, 03 Jan 2017 06:37:43 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38950)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1cONPQ-0001dz-Al
	for qemu-devel@nongnu.org; Tue, 03 Jan 2017 06:37:40 -0500
Date: Tue, 3 Jan 2017 12:37:36 +0100
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20170103123736.28058223@nial.brq.redhat.com>
In-Reply-To: <4D4A9683-A287-48CD-9D76-41850225B34C@binghamton.edu>
References: <4D4A9683-A287-48CD-9D76-41850225B34C@binghamton.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] QEMU online/offline cpu
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ozgur O Kilic <okilic1@binghamton.edu>
Cc: kvm@vger.kernel.org, qemu-devel@nongnu.org, Peter Krempa <pkrempa@redhat.com>

On Mon, 2 Jan 2017 23:27:50 +0300
Ozgur O Kilic <okilic1@binghamton.edu> wrote:

> Hi
> 
> I am trying to understand how QEMU threads respond to set a vCPU online or offline. 
> 
> Specifically, what happens to QEMU thread if in the guest, we execute:
> 
> echo 0 > /sys/devices/system/cpu/cpu1/online
> Is the corresponding QEMU thread paused?
on success CPU executes play_dead() and isn't used/scheduled by guest.

However it's still possible to online it back using
echo 1 > /sys/devices/system/cpu/cpu1/online

If you need to prevent that happening you should use QEMU's
device_del command via HMP/QMP interface.
For x86 it would trigger ACPI based CPU hot-unplug action after which
vCPU object in QMEU would be destroyed and corresponding KVM thread
be parked and corresponding CPU object /sys/devices/system/cpu/cpuXX
in guest is removed. To use that CPU again in guest, one should
hotplug it back in QEMU using device_add.

details of ACPI based cpu hot(un)plug qemu<->guest protocol are described in
QEMU/docs/specs/acpi_cpu_hotplug.txt file. x86 ACPI based implementation is
mostly contained in QEMU/hw/acpi/cpu* files.

Wiki page http://wiki.qemu.org/Features/CPUHotplug is rather outdated,
I'll update it to reflect currently implemented hotplug interfaces/targets.

PS:
cpu hot-unplug is recently new feature so one should use recent
qemu/libvirt versions.

> Thank you
> Ozgur Ozan Kilic
