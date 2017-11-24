Received: from eggs.gnu.org ([2001:4830:134:3::10]:39118)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yang.zhong@intel.com>) id 1eI7Um-00013k-TX
	for qemu-devel@nongnu.org; Fri, 24 Nov 2017 01:29:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yang.zhong@intel.com>) id 1eI7Uj-0004vO-DF
	for qemu-devel@nongnu.org; Fri, 24 Nov 2017 01:29:52 -0500
Received: from mga11.intel.com ([192.55.52.93]:19028)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yang.zhong@intel.com>)
	id 1eI7Uj-0004tC-4s
	for qemu-devel@nongnu.org; Fri, 24 Nov 2017 01:29:49 -0500
Date: Fri, 24 Nov 2017 14:29:07 +0800
From: Zhong Yang <yang.zhong@intel.com>
Message-ID: <20171124062907.GA3636@yangzhon-Virtual>
References: <1511419276-31212-1-git-send-email-yang.zhong@intel.com>
	<20171123111943.GD26022@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171123111943.GD26022@stefanha-x1.localdomain>
Subject: Re: [Qemu-devel] [PATCH v2] rcu: reduce more than 7MB heap memory
 by malloc_trim()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, berrange@redhat.com, pbonzini@redhat.com, stone.xulei@huawei.com, arei.gonglei@huawei.com, wangxinxin.wang@huawei.com, weidong.huang@huawei.com, zhang.zhanghailiang@huawei.com, liujunjie23@huawei.com, yang.zhong@intel.com

On Thu, Nov 23, 2017 at 11:19:43AM +0000, Stefan Hajnoczi wrote:
> On Thu, Nov 23, 2017 at 02:41:16PM +0800, Yang Zhong wrote:
> > Since there are some issues in memory alloc/free machenism
> > in glibc for little chunk memory, if Qemu frequently
> > alloc/free little chunk memory, the glibc doesn't alloc
> > little chunk memory from free list of glibc and still
> > allocate from OS, which make the heap size bigger and bigger.
> > 
> > This patch introduce malloc_trim(), which will free heap memory.
> > 
> > Below are test results from smaps file.
> > (1)without patch
> > 55f0783e1000-55f07992a000 rw-p 00000000 00:00 0  [heap]
> > Size:              21796 kB
> > Rss:               14260 kB
> > Pss:               14260 kB
> > 
> > (2)with patch
> > 55cc5fadf000-55cc61008000 rw-p 00000000 00:00 0  [heap]
> > Size:              21668 kB
> > Rss:                6940 kB
> > Pss:                6940 kB
> > 
> > Signed-off-by: Yang Zhong <yang.zhong@intel.com>
> > ---
> >  configure  | 4 ++++
> >  util/rcu.c | 6 ++++++
> >  2 files changed, 10 insertions(+)
> > 
> > diff --git a/configure b/configure
> > index 0e856bb..5b463d4 100755
> > --- a/configure
> > +++ b/configure
> > @@ -6012,6 +6012,10 @@ if test "$opengl" = "yes" ; then
> >    fi
> >  fi
> >  
> > +if test "$tcmalloc" = "yes" || test "$jemalloc" = "yes" ; then
> > +  echo "CONFIG_NONGLIBMALLOC=y" >> $config_host_mak
> 
> malloc(3) is provided by glibc, not glib, so the name
> CONFIG_NONGLIBMALLOC is confusing.
> 
> I suggest calling it CONFIG_MALLOC_TRIM instead:
> 
>   # Even if malloc_trim() is available, these non-libc memory allocators
>   # do not support it.
>   if test "$tcmalloc" = "yes" || test "$jemalloc" = "yes" ; then
>       if test "$malloc_trim" = "yes" ; then
>           echo "Disabling malloc_trim with non-libc memory allocator"
>       fi
>       malloc_trim="no"
>   fi
> 
>   if test "$malloc_trim" != "no" ; then
>       cat > $TMPC << EOF
>   #include <malloc.h>
>   int main(void) { malloc_trim(0); return 0; }
>   EOF
>       if compile_prog "" "" ; then
>           malloc_trim="yes"
>       else
>           malloc_trim="no"
>       fi
>   fi
> 
>   ...
> 
>   if test "$malloc_trim" = "yes" ; then
>       echo "CONFIG_MALLOC_TRIM=y" >> $config_host_mak
>   fi
> 
> Then the code in rcu.c just has to #ifdef CONFIG_MALLOC_TRIM and there's
> no need for Linux-specific checks.  If other operating systems support
> malloc_trim() then QEMU will use it by default.

  Hello Stefan,

  Thanks for your detailed infomation!

  I did test with this new patch, which are okay, thanks again!

  I will send V3 patch soon, please help review again! thanks!

  Regards,

  Yang
