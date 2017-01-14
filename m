Received: from eggs.gnu.org ([2001:4830:134:3::10]:35507)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1cSM7x-0001s2-5f
	for qemu-devel@nongnu.org; Sat, 14 Jan 2017 06:04:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1cSM7u-00038g-1X
	for qemu-devel@nongnu.org; Sat, 14 Jan 2017 06:04:05 -0500
Received: from mout.kundenserver.de ([212.227.126.133]:57307)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1cSM7t-00038Q-PS
	for qemu-devel@nongnu.org; Sat, 14 Jan 2017 06:04:01 -0500
References: <1484376662-32063-1-git-send-email-thuth@redhat.com>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <2296ffa3-8bb9-4652-ebd6-4da5b09596ca@vivier.eu>
Date: Sat, 14 Jan 2017 12:03:48 +0100
MIME-Version: 1.0
In-Reply-To: <1484376662-32063-1-git-send-email-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] hw/core/null-machine: Add the possibility
 to instantiate a CPU, RAM and kernel
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Eduardo Habkost <ehabkost@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Daniel Berrange <berrange@redhat.com>, Max Filippov <jcmvbkbc@gmail.com>, Alistair Francis <alistair.francis@xilinx.com>

Le 14/01/2017 à 07:51, Thomas Huth a écrit :
> Sometimes it is useful to have just a machine with CPU and RAM, without
> any further hardware in it, e.g. if you just want to do some instruction
> debugging for TCG with a remote GDB attached to QEMU, or run some embedded
> code with the "-semihosting" QEMU parameter. qemu-system-m68k already
> features a "dummy" machine, and xtensa a "sim" machine for exactly this
> purpose.
> All target architectures have nowadays also a "none" machine, which would
> be a perfect match for this, too - but it currently does not allow to add
> CPU, RAM or a kernel yet. Thus let's add these possibilities in a generic
> way to the "none" machine, too, so that we hopefully do not need additional
> "dummy" machines in the future anymore (and maybe can also get rid of the
> already existing "dummy"/"sim" machines one day).
> Note that the default behaviour of the "none" machine is not changed, i.e.
> no CPU and no RAM is instantiated by default. You've explicitely got to
> specify the CPU model with "-cpu" and the amount of RAM with "-m" to get
> these new features.

Did you try to use the generic-loader to load the kernel?

Something like "-device loader,file=vmlinux" instead of adding this part
in the none machine?

Perhaps we could also add a cpu this way, as they are already available
in the device list for the machine that allows hotplug.

With the same idea, we could also have a "-device ram,size=XXX" to add
ram (not DIMM).

I think is is the idea behind the none machine:

commit b4a738bf93c3137b92d532e59d60edccc4e1ea96
Author: Anthony Liguori <aliguori@us.ibm.com>
Date:   Wed Aug 22 15:22:05 2012 -0500

    boards: add a 'none' machine type to all platforms

    This allows any QEMU binary to be executed with:

      $QEMU_BINARY -M none -qmp stdio

    Without errors from missing options that are required by various
boards.  This
    also provides a mode that we can use in the future to construct machines
    entirely through QMP commands.

Laurent
