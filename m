Received: from eggs.gnu.org ([2001:4830:134:3::10]:34354)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1dGWbh-0000St-00
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 16:22:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1dGWbd-0000Je-1E
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 16:22:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56832)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
	id 1dGWbc-0000I9-R7
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 16:22:04 -0400
Date: Thu, 1 Jun 2017 14:22:00 -0600
From: Alex Williamson <alex.williamson@redhat.com>
Message-ID: <20170601142200.0a733c56@w520.home>
In-Reply-To: <1496079043-26694-9-git-send-email-zhi.a.wang@intel.com>
References: <1496079043-26694-1-git-send-email-zhi.a.wang@intel.com>
	<1496079043-26694-9-git-send-email-zhi.a.wang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC 1/6] vfio: Add Intel platform definitions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Zhi Wang <zhi.a.wang@intel.com>
Cc: qemu-devel@nongnu.org, kevin.tian@intel.com, daniel.vetter@ffwll.ch, joonas.lahtinen@linux.intel.com, zhenyuw@linux.intel.com, zhiyuan.lv@intel.com, chuanxiao.dong@intel.com, xiong.y.zhang@intel.com

On Tue, 30 May 2017 01:30:38 +0800
Zhi Wang <zhi.a.wang@intel.com> wrote:

> This patch introduces device descriptions for Intel platforms. Most of
> the Intel device definitions come from i915.
> 
> Suggested-by: Xiong Zhang <xiong.y.zhang@intel.com>
> Signed-off-by: Zhi Wang <zhi.a.wang@intel.com>
> ---
>  hw/vfio/Makefile.objs    |   2 +-
>  hw/vfio/intel-platform.c | 366 +++++++++++++++++++++++++++++++++++++++++++++++
>  hw/vfio/intel-platform.h |  38 +++++
>  hw/vfio/pci-quirks.c     |  28 ++--
>  4 files changed, 421 insertions(+), 13 deletions(-)
>  create mode 100644 hw/vfio/intel-platform.c
>  create mode 100644 hw/vfio/intel-platform.h

Thanks to IGD hardware designers seeing fit to change the
implementation on a whim, this has a non-trivial future maintenance
burden.  Is Intel signing up to support this?  I would suggest being
overly explicit with where each define and function lives in the Linux
kernel so that it doesn't take a great deal of research to lift new
defines here.  Extra points if we could simply include Linux kernel
headers in a way to pick them up automatically.

Along those same lines, there's a subtle behavior change here where
igd_gen() hopes that Intel is eventually converging on a stable layout
and therefore assumes newer devices are compatible with the latest
version we know about.  That's removed here, so it seems we'll always
be trailing the latest hardware.  The comment:

> +        error_report("IGD device %s is unsupported in legacy mode, "
> +                     "try SandyBridge or newer", vdev->vbasedev.name);

is also really no longer accurate.  igd_gen() had code to match older
hardware as specifically unsupported vs only unknown (and assumed to be
supported using the newest generation we know about).  Now the unknown
device could be new or old, so suggesting SandyBridge or newer isn't
helpful advice for a user.

Why "intel-platform"?  Maybe this is subtly trying to indicate that IGD
is really a broken mix of PCI and "platform" devices since it's PCI yet
relies on various non-PCI resources, like stolen memory.  In any case,
it's a bit confusing from a vfio perspective.  Perhaps pci-igd?  Thanks,

Alex
