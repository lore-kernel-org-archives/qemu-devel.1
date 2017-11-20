Received: from eggs.gnu.org ([2001:4830:134:3::10]:46901)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yang.zhong@intel.com>) id 1eGhes-0001IK-V4
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 03:42:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yang.zhong@intel.com>) id 1eGhep-0006NA-RZ
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 03:42:26 -0500
Received: from mga02.intel.com ([134.134.136.20]:25727)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yang.zhong@intel.com>)
	id 1eGhep-0006LM-H9
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 03:42:23 -0500
Date: Mon, 20 Nov 2017 16:41:41 +0800
From: Zhong Yang <yang.zhong@intel.com>
Message-ID: <20171120084141.GA6622@yangzhon-Virtual>
References: <1510899814-19372-1-git-send-email-yang.zhong@intel.com>
	<20171117135409.GA3669@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171117135409.GA3669@stefanha-x1.localdomain>
Subject: Re: [Qemu-devel] [PATCH] rcu: reduce half heap memory size by
 malloc_trim()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, anthony.xu@intel.com, stone.xulei@huawei.com, arei.gonglei@huawei.com, wangxinxin.wang@huawei.com, weidong.huang@huawei.com, zhang.zhanghailiang@huawei.com, liujunjie23@huawei.com, yang.zhong@intel.com

On Fri, Nov 17, 2017 at 01:54:09PM +0000, Stefan Hajnoczi wrote:
> On Fri, Nov 17, 2017 at 02:23:34PM +0800, Yang Zhong wrote:
> > diff --git a/util/rcu.c b/util/rcu.c
> > index ca5a63e..8d491a6 100644
> > --- a/util/rcu.c
> > +++ b/util/rcu.c
> > @@ -26,6 +26,7 @@
> >   * IBM's contributions to this file may be relicensed under LGPLv2 or later.
> >   */
> >  
> > +#include <malloc.h>
> 
> This header file is not mentioned in the C99 standard or POSIX.  It is
> probably not available on all host OSes that QEMU supports.  Please use
> #ifdef CONFIG_LINUX.
> 
  Hello Stefan,

  Thanks for your remind! 
  
  Regards,

  Yang 
> >  #include "qemu/osdep.h"
> >  #include "qemu-common.h"
> >  #include "qemu/rcu.h"
> > @@ -272,6 +273,9 @@ static void *call_rcu_thread(void *opaque)
> >              node->func(node);
> >          }
> >          qemu_mutex_unlock_iothread();
> > +#ifdef CONFIG_LINUX
> > +        malloc_trim(0);
> > +#endif
> 
> It is important that the rcu thread isn't overzealous in minimizing heap
> size if that means ordinary malloc(3) calls will experience latency
> spikes.  Please leave a few MB free so that malloc(3) doesn't take the
> slow path.
> 
  Hello Stefan,

  From the Qemu bootup procedure, the qemu malloc chunk memory from OS, not
  from glibc free list which is freed before by Qemu. Maybe there are some 
  issues in glibc memory mechanism. I will continue to fine this parameter
  to get better balance, Many thanks!

  Regards,

  Yang 

> Stefan
