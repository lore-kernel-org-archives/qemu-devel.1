Received: from eggs.gnu.org ([2001:4830:134:3::10]:35272)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yang.zhong@intel.com>) id 1eNB0T-0000UB-Oy
	for qemu-devel@nongnu.org; Fri, 08 Dec 2017 00:15:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yang.zhong@intel.com>) id 1eNB0P-0002Qa-B7
	for qemu-devel@nongnu.org; Fri, 08 Dec 2017 00:15:29 -0500
Received: from mga17.intel.com ([192.55.52.151]:59335)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yang.zhong@intel.com>)
	id 1eNB0P-0002Pw-1S
	for qemu-devel@nongnu.org; Fri, 08 Dec 2017 00:15:25 -0500
Date: Fri, 8 Dec 2017 13:14:41 +0800
From: Yang Zhong <yang.zhong@intel.com>
Message-ID: <20171208051441.GA8672@yangzhon-Virtual>
References: <1511419276-31212-1-git-send-email-yang.zhong@intel.com>
	<CAJ+F1C+CHLLncN9uWS9wHQ7vAk26Y98TKJ38RZtrtbFEPdO57Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJ+F1C+CHLLncN9uWS9wHQ7vAk26Y98TKJ38RZtrtbFEPdO57Q@mail.gmail.com>
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
To: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@gmail.com>
Cc: qemu-devel@nongnu.org, stefanha@redhat.com, pbonzini@redhat.com, berrange@redhat.com, weidong.huang@huawei.com, arei.gonglei@huawei.com, liujunjie23@huawei.com, wangxinxin.wang@huawei.com, stone.xulei@huawei.com, zhaoshenglong@huawei.com, yang.zhong@intel.com

On Thu, Dec 07, 2017 at 04:33:10PM +0100, Marc-André Lureau wrote:
> Hi
> 
> On Thu, Nov 23, 2017 at 7:41 AM, Yang Zhong <yang.zhong@intel.com> wrote:
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
> 
> Have you opened a bug to glibc malloc (or discussed that issue with
> the glibc malloc developpers) ?
> 
> Or is there a justification that qemu should have its own trim
> heuristic on top of malloc?

  Hello Marc-Andr,
 
  Thanks for your comments!
  I did not open a bug for glibc community, maybe this issue is not new
  issue for them because there are lots of complains about malloc/free 
  issues in the internet. If need, i can file this bug to them.

  Qemu(v2.3) introduce the rcu mechanism for VM performance, but the side 
  effect is heap memory never shrink like below case
  http://lists.nongnu.org/archive/html/qemu-devel/2017-11/msg02748.html 
  
  Glibc let free memory in their free list for next malloc, but the fact 
  is glibc still allocate memory from OS in Qemu. There are lots of memory 
  hole in the heap, escepially the batch malloc and free with rcu mechanism,
  which made heap memory bigger and bigger, and never shrink.

  from the test by mallinfo() and malloc_trim(), i found malloc_trim() not
  only trim heap top free memory, but also can free hole memory in the heap.
  
  This is V2 patch thread and we are talking in V3 patch thread now.
  http://lists.nongnu.org/archive/html/qemu-devel/2017-11/msg04519.html

  Regards,

  Yang
 

> Marc-André Lureau
