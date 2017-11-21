Received: from eggs.gnu.org ([2001:4830:134:3::10]:42153)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yang.zhong@intel.com>) id 1eGz7l-0006oZ-Bk
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 22:21:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yang.zhong@intel.com>) id 1eGz7i-00082Z-93
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 22:21:25 -0500
Received: from mga05.intel.com ([192.55.52.43]:63914)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yang.zhong@intel.com>)
	id 1eGz7h-00081a-Uq
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 22:21:22 -0500
Date: Tue, 21 Nov 2017 11:20:41 +0800
From: Zhong Yang <yang.zhong@intel.com>
Message-ID: <20171121032041.GB8063@yangzhon-Virtual>
References: <1510899814-19372-1-git-send-email-yang.zhong@intel.com>
	<20171117135409.GA3669@stefanha-x1.localdomain>
	<20171120084141.GA6622@yangzhon-Virtual>
	<20171120140344.GE4516@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171120140344.GE4516@stefanha-x1.localdomain>
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
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, weidong.huang@huawei.com, arei.gonglei@huawei.com, liujunjie23@huawei.com, wangxinxin.wang@huawei.com, stone.xulei@huawei.com, anthony.xu@intel.com, zhang.zhanghailiang@huawei.com, famz@redhat.com, berrange@redhat.com, yang.zhong@intel.com

On Mon, Nov 20, 2017 at 02:03:44PM +0000, Stefan Hajnoczi wrote:
> On Mon, Nov 20, 2017 at 04:41:41PM +0800, Zhong Yang wrote:
> > On Fri, Nov 17, 2017 at 01:54:09PM +0000, Stefan Hajnoczi wrote:
> > > On Fri, Nov 17, 2017 at 02:23:34PM +0800, Yang Zhong wrote:
> > > > @@ -272,6 +273,9 @@ static void *call_rcu_thread(void *opaque)
> > > >              node->func(node);
> > > >          }
> > > >          qemu_mutex_unlock_iothread();
> > > > +#ifdef CONFIG_LINUX
> > > > +        malloc_trim(0);
> > > > +#endif
> > > 
> > > It is important that the rcu thread isn't overzealous in minimizing heap
> > > size if that means ordinary malloc(3) calls will experience latency
> > > spikes.  Please leave a few MB free so that malloc(3) doesn't take the
> > > slow path.
> > > 
> >   Hello Stefan,
> > 
> >   From the Qemu bootup procedure, the qemu malloc chunk memory from OS, not
> >   from glibc free list which is freed before by Qemu. Maybe there are some 
> >   issues in glibc memory mechanism. I will continue to fine this parameter
> >   to get better balance, Many thanks!
> 
> I was suggesting malloc_trim(4 * 1024 * 1024) or similar instead of
> malloc_trim(0).
>  
  Hello Stefan,

  Thanks for your suggestion!
  I tried your suggested changes, malloc_trim(4 * 1024 * 1024), the heap size with
  this change almost same with malloc_trim(0), thanks!

  Regards,

  Yang   
 
> Stefan
