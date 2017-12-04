Received: from eggs.gnu.org ([2001:4830:134:3::10]:50953)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yang.zhong@intel.com>) id 1eLpgZ-0000HS-7z
	for qemu-devel@nongnu.org; Mon, 04 Dec 2017 07:17:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yang.zhong@intel.com>) id 1eLpgW-0008It-3f
	for qemu-devel@nongnu.org; Mon, 04 Dec 2017 07:17:23 -0500
Received: from mga05.intel.com ([192.55.52.43]:5158)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yang.zhong@intel.com>)
	id 1eLpgV-0008Il-Qv
	for qemu-devel@nongnu.org; Mon, 04 Dec 2017 07:17:20 -0500
Date: Mon, 4 Dec 2017 20:16:39 +0800
From: Yang Zhong <yang.zhong@intel.com>
Message-ID: <20171204121639.GB32151@yangzhon-Virtual>
References: <1511505030-3669-1-git-send-email-yang.zhong@intel.com>
	<5A1A5C6E.9060409@huawei.com>
	<20171201105622.GB26237@yangzhon-Virtual>
	<74cccd14-e485-90d4-82d9-03355c05faca@redhat.com>
	<20171204120322.GA32151@yangzhon-Virtual>
	<20171204120705.GE20203@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171204120705.GE20203@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3] rcu: reduce more than 7MB heap memory
 by malloc_trim()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>, pbonzini@redhat.com, stefanha@redhat.com
Cc: qemu-devel@nongnu.org, weidong.huang@huawei.com, arei.gonglei@huawei.com, liujunjie23@huawei.com, wangxinxin.wang@huawei.com, stone.xulei@huawei.com, zhang.zhanghailiang@huawei.com, zhaoshenglong@huawei.com, yang.zhong@intel.com

On Mon, Dec 04, 2017 at 12:07:05PM +0000, Daniel P. Berrange wrote:
> On Mon, Dec 04, 2017 at 08:03:22PM +0800, Yang Zhong wrote:
> > On Fri, Dec 01, 2017 at 01:52:49PM +0100, Paolo Bonzini wrote:
> > > On 01/12/2017 11:56, Yang Zhong wrote:
> > > >   This issue should be caused by much times of system call by malloc_trim(),
> > > >   Shannon's test script include 60 scsi disks and 31 ioh3420 devices. We need 
> > > >   trade-off between VM perforamance and memory optimization. Whether below 
> > > >   method is suitable?
> > > > 
> > > >   int num=1;
> > > >   ......
> > > > 
> > > >   #if defined(CONFIG_MALLOC_TRIM)
> > > >         if(!(num++%5))
> > > >         {
> > > >              malloc_trim(4 * 1024 * 1024);
> > > >         }
> > > >   #endif
> > > >  
> > > >   Any comments are welcome! Thanks a lot!
> > > 
> > > Indeed something like this will do, perhaps only trim once per second?
> > > 
> >   Hello Paolo,
> > 
> >   Thanks for comments!
> >   If we do trim once per second, maybe the frequency is a little high, what'e
> >   more, we need maintain one timer to call this, this also cost cpu resource.
> > 
> >   I added the log and did the test here with my test qemu command, when VM bootup,
> >   which did more than 600 times free operations and 9 times memory trim in rcu 
> >   thread. If i use our ClearContainer qemu command, the memory trim will down 
> >   to 6 times. As for Shannon's test command, the malloc trim number will abosultly 
> >   increse.
> > 
> >   In my above method, the trim is only executed in the multiple of 5, which will
> >   reduce trim times and do not heavily impact VM bootup performance. 
> > 
> >   I also want to use synchronize_rcu() and free() to replace call_rcu(), but this
> >   method serialize to malloc() and free(), which will reduce VM performance.
> > 
> >   The ultimate aim is to reduce trim system call during the VM bootup and running.
> >   It's appreciated that if you have better suggestions.
> 
> Does configuring QEMU to use tcmalloc or jemalloc instead of glibc's malloc
> give you the performance & menmory usage that you require? If so, it might
> not be worth bothering to hack around problems in glibc's malloc at all.
> 
> 
  Hello Daniel,

  Thanks for comment!
  I used the tcmalloc and jemalloc to do compared test, it's pity that there is no heap
  item in smaps file with jemalloc, the glibc and tcmalloc result as below:

  ##glibc malloc
  5618c0a98000-5618c1cde000 rw-p 00000000 00:00 0                          [heap]
  Size:              18712 kB
  KernelPageSize:        4 kB
  MMUPageSize:           4 kB
  Rss:               10536 kB
  Pss:               10536 kB
 
  ##tcmalloc
  557f79119000-557f7af46000 rw-p 00000000 00:00 0                          [heap]
  Size:              30900 kB
  Rss:               20244 kB
  Pss:               20244 kB

  The result show the Rss with tcmalloc is higher than glibc's.

  Regards,

  Yang

> Regards,
> Daniel
> -- 
> |: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
> |: https://libvirt.org         -o-            https://fstop138.berrange.com :|
> |: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
