Received: from eggs.gnu.org ([2001:4830:134:3::10]:34436)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yang.zhong@intel.com>) id 1dItbP-0006T1-Ha
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 05:19:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yang.zhong@intel.com>) id 1dItbM-0000Cw-Ci
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 05:19:39 -0400
Received: from mga03.intel.com ([134.134.136.65]:60296)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yang.zhong@intel.com>)
	id 1dItbL-0000Cd-VI
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 05:19:36 -0400
Date: Thu, 8 Jun 2017 17:19:27 +0800
From: Zhong Yang <yang.zhong@intel.com>
Message-ID: <20170608091927.GB21945@yangzhon-Virtual>
References: <1496383606-18060-1-git-send-email-yang.zhong@intel.com>
	<bba5be37-e002-b65e-41b9-358e7f6a3ec9@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bba5be37-e002-b65e-41b9-358e7f6a3ec9@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 0/4] tcg: split the tcg code and
 separate tcg files
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, eblake@redhat.com, laurent.desnogues@gmail.com, anthony.xu@intel.com, yang.zhong@intel.com

O Wed, Jun 07, 2017 at 03:28:55PM +0200, Paolo Bonzini wrote:
> 
> 
> On 02/06/2017 08:06, Yang Zhong wrote:
> > In order to disable tcg, the first phase is to split some
> > tcg code and separate those tcg related files into one
> > directory. The next phase will disable tcg more easily and
> > cleanly.
> >   
> > In the first phase, there are four patches to deal with split 
> > code and separate files.
> > 1)split the tcg exec code.
> >   a)split the tcg accelerators from accel.c file and re-name
> >     tcg accelerator to tcg-all.c, like kvm-all.c did.
> >   b)create one accel directory, which will include kvm,
> >     tcg and general exec files.
> > 2)move cputlb.c, cpu-exec-common.c and cpu-exec.c related tcg
> >   exec file into accel/tcg/ subdirectory.
> > 3)move tcg related backend files into accel/tcg/ directory
> >   those files include translate-all.(ch), translate-common.c,
> >   tci.c and tcg-runtime.c.
> > 4)move kvm and exec.c file.
> >   a)move kvm related accelerator files into accel/kvm/ directory.
> >   b)move exec.c in accel/ directory.
> >   c)stubs/ directory was created for kvm and tcg stub files.
> > 
> > after those changes are done, the file tree like below
> > accel
> > ├── accel.c
> > ├── exec.c
> > ├── kvm
> > │   ├── kvm-all.c
> > │   ├── Makefile.objs
> > │   └── trace-events
> > ├── Makefile.objs
> > ├── stubs
> > │   ├── kvm-stub.c
> > │   └── Makefile.objs
> > └── tcg
> >     ├── cpu-exec.c
> >     ├── cpu-exec-common.c
> >     ├── cputlb.c
> >     ├── Makefile.objs
> >     ├── tcg-all.c
> >     ├── tcg-runtime.c
> >     ├── tci.c
> >     ├── trace-events
> >     ├── translate-all.c
> >     ├── translate-all.h
> >     └── translate-common.c
> > 3 directories, 19 files
> > 
> > v3: squash patches and move tcg related backend files to accel/tcg/ 
> >     according to Paolo's comments.
> >     add kvm and tcg exec related patches into one patchset.
> > 
> > 
> > Yang Zhong (4):
> >   accel: split the tcg accelerator from accel.c file
> >   tcg: move tcg related files into accel/tcg/ subdirectory
> >   tcg: move tcg backend files into accel/tcg/
> >   accel: move kvm related accelerator files into accel/
> > 
> >  Makefile.objs                                      |  3 +-
> >  Makefile.target                                    | 10 +---
> >  accel/Makefile.objs                                |  5 ++
> >  accel.c => accel/accel.c                           | 27 ----------
> >  exec.c => accel/exec.c                             |  0
> >  accel/kvm/Makefile.objs                            |  1 +
> >  kvm-all.c => accel/kvm/kvm-all.c                   |  2 +-
> >  accel/kvm/trace-events                             | 13 +++++
> >  accel/stubs/Makefile.objs                          |  1 +
> >  kvm-stub.c => accel/stubs/kvm-stub.c               |  0
> >  accel/tcg/Makefile.objs                            |  4 ++
> >  cpu-exec-common.c => accel/tcg/cpu-exec-common.c   |  0
> >  cpu-exec.c => accel/tcg/cpu-exec.c                 |  2 +-
> >  cputlb.c => accel/tcg/cputlb.c                     |  0
> >  accel/tcg/tcg-all.c                                | 61 ++++++++++++++++++++++
> >  tcg-runtime.c => accel/tcg/tcg-runtime.c           |  0
> >  tci.c => accel/tcg/tci.c                           |  0
> >  accel/tcg/trace-events                             | 10 ++++
> >  translate-all.c => accel/tcg/translate-all.c       |  2 +-
> >  translate-all.h => accel/tcg/translate-all.h       |  0
> >  translate-common.c => accel/tcg/translate-common.c |  0
> >  configure                                          |  2 +-
> >  trace-events                                       | 21 --------
> >  23 files changed, 103 insertions(+), 61 deletions(-)
> >  create mode 100644 accel/Makefile.objs
> >  rename accel.c => accel/accel.c (87%)
> >  rename exec.c => accel/exec.c (100%)
> >  create mode 100644 accel/kvm/Makefile.objs
> >  rename kvm-all.c => accel/kvm/kvm-all.c (99%)
> >  create mode 100644 accel/kvm/trace-events
> >  create mode 100644 accel/stubs/Makefile.objs
> >  rename kvm-stub.c => accel/stubs/kvm-stub.c (100%)
> >  create mode 100644 accel/tcg/Makefile.objs
> >  rename cpu-exec-common.c => accel/tcg/cpu-exec-common.c (100%)
> >  rename cpu-exec.c => accel/tcg/cpu-exec.c (99%)
> >  rename cputlb.c => accel/tcg/cputlb.c (100%)
> >  create mode 100644 accel/tcg/tcg-all.c
> >  rename tcg-runtime.c => accel/tcg/tcg-runtime.c (100%)
> >  rename tci.c => accel/tcg/tci.c (100%)
> >  create mode 100644 accel/tcg/trace-events
> >  rename translate-all.c => accel/tcg/translate-all.c (99%)
> >  rename translate-all.h => accel/tcg/translate-all.h (100%)
> >  rename translate-common.c => accel/tcg/translate-common.c (100%)
> > 
> 
> Queued, thanks (except I'm not sure why you're moving exec.c, so I've
> undone that, and tcg-runtime.c probably fits better in tcg/).
> 
  Thanks Paolo for your great help!

  as for exec.c, i ever thought this file is related with system and moved it to here.

  You are right, tcg-runtime.c is BSD Licenced file, which should be moved to tcg/.
  Whether can i release V4 for those moving?  thanks!

  Regards,

  Yang. 
 
> Paolo
