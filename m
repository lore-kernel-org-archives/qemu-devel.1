Received: from eggs.gnu.org ([2001:4830:134:3::10]:59407)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yang.zhong@intel.com>) id 1dGIeD-0001tt-Pr
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 01:27:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yang.zhong@intel.com>) id 1dGIe9-0003f6-Qw
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 01:27:49 -0400
Received: from mga09.intel.com ([134.134.136.24]:48028)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yang.zhong@intel.com>)
	id 1dGIe9-0003aE-I2
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 01:27:45 -0400
Date: Thu, 1 Jun 2017 13:27:36 +0800
From: Zhong Yang <yang.zhong@intel.com>
Message-ID: <20170601052736.GA17625@yangzhon-Virtual>
References: <1496212144-14947-1-git-send-email-yang.zhong@intel.com>
	<c5d963e7-ef71-0ed5-aaae-01d492e4fd8b@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c5d963e7-ef71-0ed5-aaae-01d492e4fd8b@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 0/6] tcg: move the tcg files into tcg/
 subdirectory.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Eric Blake <eblake@redhat.com>, Laurent Desnogues <laurent.desnogues@gmail.com>, anthony.xu@intel.com, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

 Wed, May 31, 2017 at 02:54:05PM +0200, Paolo Bonzini wrote:
> 
> 
> On 31/05/2017 08:28, Yang Zhong wrote:
> > Move the tcg related files into tcg/ subdirectory, which will make
> > the code more clean in qemu. Next step, we will base on those changes 
> > to disable tcg.
> 
> You should also move cpu-exec.c, cpu-exec-common.c and cputlb.c.
>
  In fact, there are other two patchsets for those files. Since this patchset
  is only for moving TCG backend files into tcg/ subdirectory, i firstly upload
  this patchset.

  Let me explain my plan here, 

  In order to disable tcg, the first phase is to split some
  tcg code and separate those tcg related files into one
  directory. The next phase will disable tcg more easily and
  cleanly.

  In the first phase, there are three patchsets to
  deal with split code and separate the files.
  1) split the tcg exec code.
     a)split the tcg accelerators from accel.c file and re-name
       tcg accelerator to tcg-all.c, like kvm-all.c did.
     b)create one accel directory, which will include kvm,
       tcg and general exec files.
     c)move tcg exec files into ./accel/tcg directory.
  2) move tcg related backend files into tcg/ directory
     those files include translate-all.(ch), translate-common.c,
     tci.c and tcg-runtime.c.
  3) move kvm exec and exec.c file.
     a)move kvm related exec files into ./accel/kvm directory.
     b)move exec.c in ./accel directory.

  after 1) and 3) done, the file tree like below:
  accel/
  ├── accel.c
  ├── exec.c
  ├── kvm
  │   ├── kvm-all.c
  │   ├── kvm-stub.c
  │   ├── Makefile.objs
  │   └── trace-events
  ├── Makefile.objs
  └── tcg
      ├── cpu-exec.c
      ├── cpu-exec-common.c
      ├── cputlb.c
      ├── Makefile.objs
      ├── tcg-all.c
      └── trace-events
  
  please help me check whether this kind of arrange is suitable? 


> Also, feel free to squash everything in a single patch.

  for the tcg/ subdirectory, i will make those 6 patchset to one single patch. thanks!

> Thanks,
> 
> Paolo
> 
> > Yang Zhong (6):
> >   tcg: move tcg-runtime.c to tcg/ subdirectory
> >   tcg: move translate-all.c to tcg/ subdirectory
> >   tcg: move tcg header file
> >   tcg: move translate-common.c to tcg/ subdirectory
> >   tcg: move tci.c to tcg/ subdirectory
> >   tcg: change tcg related file's compile definition
> > 
> >  Makefile.objs                                | 1 +
> >  Makefile.target                              | 8 ++------
> >  tcg/Makefile.objs                            | 2 ++
> >  tcg-runtime.c => tcg/tcg-runtime.c           | 0
> >  tci.c => tcg/tci.c                           | 0
> >  tcg/trace-events                             | 6 ++++++
> >  translate-all.c => tcg/translate-all.c       | 2 +-
> >  translate-all.h => tcg/translate-all.h       | 0
> >  translate-common.c => tcg/translate-common.c | 0
> >  trace-events                                 | 3 ---
> >  10 files changed, 12 insertions(+), 10 deletions(-)
> >  create mode 100644 tcg/Makefile.objs
> >  rename tcg-runtime.c => tcg/tcg-runtime.c (100%)
> >  rename tci.c => tcg/tci.c (100%)
> >  create mode 100644 tcg/trace-events
> >  rename translate-all.c => tcg/translate-all.c (99%)
> >  rename translate-all.h => tcg/translate-all.h (100%)
> >  rename translate-common.c => tcg/translate-common.c (100%)
> > 
