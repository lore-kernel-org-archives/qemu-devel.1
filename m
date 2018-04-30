Received: from eggs.gnu.org ([2001:4830:134:3::10]:34488)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fD4tO-0000yy-Id
	for qemu-devel@nongnu.org; Mon, 30 Apr 2018 05:14:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fD4tJ-0000Ur-JW
	for qemu-devel@nongnu.org; Mon, 30 Apr 2018 05:14:42 -0400
Date: Mon, 30 Apr 2018 11:14:15 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180430111415.5a62087e.cohuck@redhat.com>
In-Reply-To: <1524754794-28005-1-git-send-email-thuth@redhat.com>
References: <1524754794-28005-1-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] hw/s390x: Allow to configure the consoles
 with the "-serial" parameter
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, Christian Borntraeger <borntraeger@de.ibm.com>, David Hildenbrand <david@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, qemu-s390x@nongnu.org

On Thu, 26 Apr 2018 16:59:54 +0200
Thomas Huth <thuth@redhat.com> wrote:

> The consoles ("sclpconsole" and "sclplmconsole") can only be configured
> with "-device" and "-chardev" so far. Other machines use the convenience
> option "-serial" to configure the default consoles, even for virtual
> consoles like spapr-vty on the pseries machine. So let's support this
> option on s390x, too. This way we can easily enable the serial console
> here again with "-nodefaults", for example:
> 
> qemu-system-s390x -no-shutdown -nographic -nodefaults -serial mon:stdio
> 
> ... which is way shorter than typing:
> 
> qemu-system-s390x -no-shutdown -nographic -nodefaults \
>   -chardev stdio,id=c1,mux=on -device sclpconsole,chardev=c1 \
>   -mon chardev=c1
> 
> The -serial parameter can also be used if you only want to see the QEMU
> monitor on stdio without using -nodefaults, but not the console output.
> That's something that is pretty impossible with the current code today:
> 
> qemu-system-s390x -no-shutdown -nographic -serial none
> 
> While we're at it, this patch also maps the second -serial option to the
> "sclplmconsole", so that there is now an easy way to configure this second
> console on s390x, too, for example:
> 
> qemu-system-s390x -no-shutdown -nographic -serial null -serial mon:stdio
> 
> Additionally, the new code is also smaller than the old one and we have
> less s390x-specific code in vl.c :-)
> 
> I've also checked that migration still works as expected by migrating
> a guest with console output back and forth between a qemu-system-s390x
> that has this patch and an instance without this patch.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  v2:
>  - Fixed the boot-serial-tester
>  - Switched to the new serial_hd() function
> 
>  hw/s390x/event-facility.c         | 14 +++++++++++
>  hw/s390x/s390-virtio-ccw.c        | 19 +++++++++++++--
>  include/hw/boards.h               |  1 -
>  include/hw/s390x/event-facility.h |  2 ++
>  tests/boot-serial-test.c          |  3 +--
>  vl.c                              | 50 ---------------------------------------
>  6 files changed, 34 insertions(+), 55 deletions(-)

Thanks, applied.
