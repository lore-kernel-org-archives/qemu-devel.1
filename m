Received: from eggs.gnu.org ([2001:4830:134:3::10]:40963)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1gCPpU-00023M-3X
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 09:56:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1gCPpO-0000du-TN
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 09:56:11 -0400
Date: Tue, 16 Oct 2018 15:56:00 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20181016155600.31de8883@redhat.com>
In-Reply-To: <1539696820-273275-1-git-send-email-imammedo@redhat.com>
References: <1539696820-273275-1-git-send-email-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] call HotplugHandler->plug() as the last
 step in device realization
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, stefanha@redhat.com, cohuck@redhat.com, qemu-s390x@nongnu.org, david@gibson.dropbear.id.au, qemu-ppc@nongnu.org

On Tue, 16 Oct 2018 15:33:40 +0200
Igor Mammedov <imammedo@redhat.com> wrote:

> When [2] was fixed it was agreed that adding and calling post_plug()
> callback after device_reset() was low risk approach to hotfix issue
> right before release. So it was merged instead of moving already
> existing plug() callback after device_reset() is called which would
> be more risky and require all plug() callbacks audit.
> 
> Looking at the current plug() callbacks, it doesn't seem that moving
> plug() callback after device_reset() is breaking anything, so here
> goes agreed upon [3] proper fix which essentially reverts [1][2]
> and moves plug() callback after device_reset().
> This way devices always comes to plug() stage, after it's been fully
> initialized (including being reset), which fixes race condition [2]
> without need for an extra post_plug() callback.
> 
>  1. (25e897881 "qdev: add HotplugHandler->post_plug() callback")
>  2. (8449bcf94 "virtio-scsi: fix hotplug ->reset() vs event race")
>  3. https://www.mail-archive.com/qemu-devel@nongnu.org/msg549915.html
> 
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> ---
> TODO:
>  remove usage of Error** from plug() callback, we need to factor out
>  pre_plug part from plug() callbacks, before proceeding with it.
>  DavidH has recently finished it for pc-dimm/memory_devices, cpus
>  mostly have pre_plug parts factored out, but there still are parts
>  that could fail so it needs some more work to eliminate failure points
>  from plug() callbacks. Meanwhile, I'll plan to treat other misc
>  handlers (pci[e]/acpi/usb/...) and introduce pre_plug() where
>  necessary.

Forgot to CC spapr/s390 folks to give it an extra scrutiny.
