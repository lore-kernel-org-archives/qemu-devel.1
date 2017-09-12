Received: from eggs.gnu.org ([2001:4830:134:3::10]:51989)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rjones@redhat.com>) id 1drhli-00062R-9j
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 05:46:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rjones@redhat.com>) id 1drhlf-000753-6a
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 05:46:10 -0400
Date: Tue, 12 Sep 2017 10:45:59 +0100
From: "Richard W.M. Jones" <rjones@redhat.com>
Message-ID: <20170912094558.GO20914@redhat.com>
References: <20170906085006.26983-1-rjones@redhat.com>
	<20170906101905.GD3753@dhcp-200-186.str.redhat.com>
	<20170906104451.GM20914@redhat.com>
	<20170906113845.GE3753@dhcp-200-186.str.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170906113845.GE3753@dhcp-200-186.str.redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-2.10] qemu-options: Document the -drive
 locking parameter.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, armbru@redhat.com, famz@redhat.com, qemu-trivial@nongnu.org, mjt@tls.msk.ru, berrange@redhat.com

On Wed, Sep 06, 2017 at 01:38:45PM +0200, Kevin Wolf wrote:
> This command line fragment looks correct to me. For me, it seems to
> work. I'm starting a first qemu in the background with default locking
> options:
> 
>     $ x86_64-softmmu/qemu-system-x86_64 -hda /tmp/test.qcow2
> 
> And then starting a second one with a command line resembling yours:
> 
>     $ x86_64-softmmu/qemu-system-x86_64 -device virtio-scsi \
>       -drive file=/tmp/test.qcow2,cache=unsafe,format=qcow2,file.locking=off,id=hd0,if=none \
>       -device scsi-hd,drive=hd0

The problem is with overlays, where file.locking doesn't propagate to
the backing file.  Thus:

  $ qemu-system-x86_64 -drive file=backing,format=raw

while in another terminal:

  $ qemu-img create -b backing -f qcow2 overlay
  $ qemu-system-x86_64 -drive file=overlay,format=qcow2,file.locking=off
  qemu-system-x86_64: Failed to get shared "write" lock
  Is another process using the image?

After some experimentation, I came up with this command which works:

  $ qemu-system-x86_64 -drive file.file.filename=overlay,file.driver=qcow2,file.backing.file.locking=off

Rich.

-- 
Richard Jones, Virtualization Group, Red Hat http://people.redhat.com/~rjones
Read my programming and virtualization blog: http://rwmj.wordpress.com
virt-df lists disk usage of guests without needing to install any
software inside the virtual machine.  Supports Linux and Windows.
http://people.redhat.com/~rjones/virt-df/
