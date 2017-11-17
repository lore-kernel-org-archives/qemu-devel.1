Received: from eggs.gnu.org ([2001:4830:134:3::10]:39178)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eFhHw-0001OL-6V
	for qemu-devel@nongnu.org; Fri, 17 Nov 2017 09:06:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eFhHs-0001n9-68
	for qemu-devel@nongnu.org; Fri, 17 Nov 2017 09:06:36 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37390)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1eFhHs-0001lN-0D
	for qemu-devel@nongnu.org; Fri, 17 Nov 2017 09:06:32 -0500
Date: Fri, 17 Nov 2017 14:06:20 +0000
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20171117140620.GS25830@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <1510899814-19372-1-git-send-email-yang.zhong@intel.com>
	<20171117135409.GA3669@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
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
Cc: Yang Zhong <yang.zhong@intel.com>, weidong.huang@huawei.com, zhang.zhanghailiang@huawei.com, liujunjie23@huawei.com, wangxinxin.wang@huawei.com, stone.xulei@huawei.com, qemu-devel@nongnu.org, anthony.xu@intel.com, arei.gonglei@huawei.com, pbonzini@redhat.com

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

If you pass '0' the docs say that the minimum amount is left in the
heap, per M_TOP_PAD, which is 128kb.

Strangely the mallopt(3) man page suggests, that free() should automatically
trim the heap when its size exceeds M_TOP_TRIM, which is again 128kb by
default.  So I'm puzzelled by malloc_trim() would be needed unless there
are scenarios in which free() won't trim, that aren't mentioned in the
manpage.

Also, how does malloc_trim interact with tcmalloc.so that people often
use in preference to glibc's built in malloc ?

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
