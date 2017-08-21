Received: from eggs.gnu.org ([2001:4830:134:3::10]:42597)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1djmpX-0006iZ-JS
	for qemu-devel@nongnu.org; Mon, 21 Aug 2017 09:33:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1djmpR-0005Fr-VR
	for qemu-devel@nongnu.org; Mon, 21 Aug 2017 09:33:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53304)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lvivier@redhat.com>) id 1djmpR-0005FM-Po
	for qemu-devel@nongnu.org; Mon, 21 Aug 2017 09:33:17 -0400
References: <20170821103524.22619-1-david@gibson.dropbear.id.au>
From: Laurent Vivier <lvivier@redhat.com>
Message-ID: <7cb8a876-d416-0594-a95a-de1c28015f5a@redhat.com>
Date: Mon, 21 Aug 2017 15:27:39 +0200
MIME-Version: 1.0
In-Reply-To: <20170821103524.22619-1-david@gibson.dropbear.id.au>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] hw/ppc/spapr: Fix segfault when
 instantiating a 'pc-dimm' without 'memdev'
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>, cohuck@redhat.com
Cc: berrange@redhat.com, thuth@redhat.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org

On 21/08/2017 12:35, David Gibson wrote:
> From: Thomas Huth <thuth@redhat.com>
> 
> QEMU currently crashes when trying to use a 'pc-dimm' on the pseries
> machine without specifying its 'memdev' property. This happens because
> pc_dimm_get_memory_region() does not check whether the 'memdev' property
> has properly been set by the user. Looking closer at this function, it's
> also obvious that it is using &error_abort to call another function - and
> this is bad in a function that is used in the hot-plugging calling chain
> since this can also cause QEMU to exit unexpectedly.
> 
> So let's fix these issues in a proper way now: Add a "Error **errp"
> parameter to pc_dimm_get_memory_region() which we use in case the 'memdev'
> property has not been set by the user, and which we can use instead of
> the &error_abort, and change the callers of get_memory_region() to make
> use of this "errp" parameter for proper error checking.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> Reviewed-by: Igor Mammedov <imammedo@redhat.com>
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> ---
>  hw/i386/pc.c             | 14 ++++++++++++--
>  hw/mem/nvdimm.c          |  2 +-
>  hw/mem/pc-dimm.c         | 14 +++++++++++---
>  hw/ppc/spapr.c           | 42 ++++++++++++++++++++++++++++++------------
>  include/hw/mem/pc-dimm.h |  2 +-
>  5 files changed, 55 insertions(+), 19 deletions(-)
> 

Reviewed-by: Laurent Vivier <lvivier@redhat.com>
