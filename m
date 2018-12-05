Received: from eggs.gnu.org ([2001:4830:134:3::10]:57451)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gUXi0-0000T4-Nj
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 08:59:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gUXhy-0004xD-EX
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 08:59:24 -0500
Date: Wed, 5 Dec 2018 08:58:57 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20181205085132-mutt-send-email-mst@kernel.org>
References: <20181130151712.2312-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181130151712.2312-1-peter.maydell@linaro.org>
Subject: Re: [Qemu-devel] [PATCH 00/10] Remove deprecated load_image()
 function
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, patches@linaro.org, Stefan Hajnoczi <stefanha@redhat.com>, Eric Blake <eblake@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Li Zhijian <lizhijian@cn.fujitsu.com>, Philip Li <philip.li@intel.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Alexander Graf <agraf@suse.de>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, David Gibson <david@gibson.dropbear.id.au>, Igor Mammedov <imammedo@redhat.com>, qemu-block@nongnu.org, qemu-ppc@nongnu.org

On Fri, Nov 30, 2018 at 03:17:02PM +0000, Peter Maydell wrote:
> This patchset removes the load_image() function, which we noted
> in a comment as being deprecated in 2008 but were still using
> in a handful of places. All the use cases are bugs of some
> kind or another, either straightforward "no length checking
> at all" or "doesn't cope with the file getting larger between
> get_image_size()'s length check and the read in load_image()".
> IRC consensus was that this doesn't rise to the level of a
> security issue since the images being loaded should either
> be trusted or the management layer app should be fencing things
> off to ensure they don't change underfoot.
> 
> The replacement is either:
>  * g_file_get_contents(), in places where we were previously
>    explicitly g_malloc()ing a buffer to load the image
>  * load_image_size(), in places where we load the image
>    into a pre-existing buffer, MemoryRegion, etc
> 
> The final patch in the series adds a documentation comment
> for load_image_size().
> 
> Notes:
>  * tested only with "make check"
>  * I'm not a huge fan of load_image_size()'s "truncate overlength
>    images" (as opposed to considering that an error), but I've
>    documented what we have, rather than what we might like to have
>  * some of the callsites of load_image() had no error checking;
>    I've added it as part of the changeover
> 
> thanks
> -- PMM
> 
> Peter Maydell (10):
>   hw/ppc/mac_newworld, mac_oldworld: Don't use load_image()
>   hw/ppc/ppc405_boards: Don't use load_image()
>   hw/smbios/smbios.c: Don't use load_image()
>   hw/pci/pci.c: Don't use load_image()
>   hw/i386/pc.c: Don't use load_image()
>   hw/i386/multiboot.c: Don't use load_image()
>   hw/block/tc58128.c: Don't use load_image()
>   device_tree.c: Don't use load_image()
>   hw/core/loader.c: Remove load_image()
>   include/hw/loader.h: Document load_image_size()
> 
>  include/hw/loader.h    | 17 ++++++++++++++++-
>  device_tree.c          |  2 +-
>  hw/block/tc58128.c     |  3 ++-
>  hw/core/loader.c       | 25 -------------------------
>  hw/i386/multiboot.c    |  6 +++++-
>  hw/i386/pc.c           | 22 ++++++++++++----------
>  hw/pci/pci.c           |  6 +++++-
>  hw/ppc/mac_newworld.c  | 10 ++++------
>  hw/ppc/mac_oldworld.c  | 10 ++++------
>  hw/ppc/ppc405_boards.c | 12 ++++++++----
>  hw/smbios/smbios.c     |  2 +-
>  11 files changed, 58 insertions(+), 57 deletions(-)


Reviewed-by: Michael S. Tsirkin <mst@redhat.com>


> -- 
> 2.19.1
