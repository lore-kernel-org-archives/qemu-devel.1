Received: from eggs.gnu.org ([2001:4830:134:3::10]:42317)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <junyan.he@gmx.com>) id 1fSlDV-0008Td-CT
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 11:28:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <junyan.he@gmx.com>) id 1fSlDQ-0003c0-R6
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 11:28:17 -0400
Received: from mout.gmx.net ([212.227.17.21]:36397)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <junyan.he@gmx.com>) id 1fSlDQ-0003b8-Bu
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 11:28:12 -0400
From: Junyan He <junyan.he@gmx.com>
Sender: Junyan He <junyan.he@hotmail.com>
Date: Tue, 12 Jun 2018 15:27:38 +0000
Message-ID: <HK2PR06MB0531134699538BCF93D65D65EB7F0@HK2PR06MB0531.apcprd06.prod.outlook.com>
References: <1527840629-18648-1-git-send-email-junyan.he@gmx.com>
	<20180612140643.6f6ed34d@redhat.com>
	<HK2PR06MB0531F10A69CBFC1D41402F19EB7F0@HK2PR06MB0531.apcprd06.prod.outlook.com>,
	<20180612165546.0474564f@redhat.com>
In-Reply-To: <20180612165546.0474564f@redhat.com>
Content-Language: en-US
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH V6 0/7] nvdimm: guarantee persistence of
 QEMU writes to persistent memory
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: Haozhong Zhang <haozhong.zhang@intel.com>, "xiaoguangrong.eric@gmail.com" <xiaoguangrong.eric@gmail.com>, "mst@redhat.com" <mst@redhat.com>, "crosthwaite.peter@gmail.com" <crosthwaite.peter@gmail.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "ehabkost@redhat.com" <ehabkost@redhat.com>, "dgilbert@redhat.com" <dgilbert@redhat.com>, "quintela@redhat.com" <quintela@redhat.com>, Junyan He <junyan.he@intel.com>, "stefanha@redhat.com" <stefanha@redhat.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "rth@twiddle.net" <rth@twiddle.net>

According to my understand, the file node on real persistent memory do not =
need to be pmem=3Don

pmem=3Don is a feature for file backend class. For example, if we do not ha=
ve enough hard disk space

and we have enough pmem, we can use file on pmem the same as normal file-ba=
ckend on hard disk.

That is the file-backend on pmem does not necessary to a nvdimm backend, it=
 can be normal file mapping as well.

so

 > detect that backing file is located on pmem storage

may not  be a good manner.


> (1) Maybe we should error out if pmem=3Don but compiled without libpmem
> and add 3rd state pmem=3Dforce for testing purposes.

I think we can print a warning message to give user a hint, it can really h=
elp user

when they mis-configure.


________________________________
From: Qemu-devel <qemu-devel-bounces+junyan.he=3Dgmx.com@nongnu.org> on beh=
alf of Igor Mammedov <imammedo@redhat.com>
Sent: Tuesday, June 12, 2018 2:55:46 PM
To: Junyan He
Cc: Haozhong Zhang; xiaoguangrong.eric@gmail.com; mst@redhat.com; crosthwai=
te.peter@gmail.com; qemu-devel@nongnu.org; ehabkost@redhat.com; dgilbert@re=
dhat.com; quintela@redhat.com; Junyan He; stefanha@redhat.com; pbonzini@red=
hat.com; rth@twiddle.net
Subject: Re: [Qemu-devel] [PATCH V6 0/7] nvdimm: guarantee persistence of Q=
EMU writes to persistent memory

On Tue, 12 Jun 2018 13:38:08 +0000
Junyan He <junyan.he@gmx.com> wrote:

> He have pmem_persist and pmem_memcpy_persist stub functions.
>
> If no libpmem and user really specify pmem=3Don, we just do nothing or ju=
st memcpy.
>
> Real persistent memory always require libpmem support its load/save.
>
> If pmem=3Don and without libpmem, we can think that user want to imitate
>
> pmem=3Don while the HW environment is without real persistent memory exis=
ting.
>
> It may help debug on some machine without real pmem.

For unaware user it would be easy to misconfigure and think that feature
works while it isn't, which cloud lead to data loss.

(1) Maybe we should error out if pmem=3Don but compiled without libpmem
and add 3rd state pmem=3Dforce for testing purposes.

Also can we detect that backing file is located on pmem storage and do [1] =
if it's not?

>
> ________________________________
> From: Qemu-devel <qemu-devel-bounces+junyan.he=3Dgmx.com@nongnu.org> on b=
ehalf of Igor Mammedov <imammedo@redhat.com>
> Sent: Tuesday, June 12, 2018 12:06:43 PM
> To: junyan.he@gmx.com
> Cc: Haozhong Zhang; xiaoguangrong.eric@gmail.com; crosthwaite.peter@gmail=
.com; mst@redhat.com; qemu-devel@nongnu.org; dgilbert@redhat.com; quintela@=
redhat.com; Junyan He; stefanha@redhat.com; pbonzini@redhat.com; rth@twiddl=
e.net; ehabkost@redhat.com
> Subject: Re: [Qemu-devel] [PATCH V6 0/7] nvdimm: guarantee persistence of=
 QEMU writes to persistent memory
>
> On Fri,  1 Jun 2018 16:10:22 +0800
> junyan.he@gmx.com wrote:
>
> > From: Junyan He <junyan.he@intel.com>
> >
> > QEMU writes to vNVDIMM backends in the vNVDIMM label emulation and
> > live migration. If the backend is on the persistent memory, QEMU needs
> > to take proper operations to ensure its writes persistent on the
> > persistent memory. Otherwise, a host power failure may result in the
> > loss the guest data on the persistent memory.
>
> extra question, what are expected behavior when QEMU is built without
> libpmem and user specifies pmem=3Don for backend?
>
> >
> > This v3 patch series is based on Marcel's patch "mem: add share
> > parameter to memory-backend-ram" [1] because of the changes in patch 1.
> >
> > [1] https://lists.gnu.org/archive/html/qemu-devel/2018-02/msg03858.html
> >
> > Previous versions can be found at
> > v5: https://lists.gnu.org/archive/html/qemu-devel/2018-05/msg02258.html
> > V4: https://lists.gnu.org/archive/html/qemu-devel/2018-02/msg06993.html
> > v3: https://lists.gnu.org/archive/html/qemu-devel/2018-02/msg04365.html
> > v2: https://lists.gnu.org/archive/html/qemu-devel/2018-02/msg01579.html
> > v1: https://lists.gnu.org/archive/html/qemu-devel/2017-12/msg05040.html
> >
> > Changes in v6:
> > * (Patch 1) Expose all ram block flags rather than redefine the flags.
> > * (Patch 4) Use pkg-config rather the hard check when configure.
> > * (Patch 7) Sync and flush all the pmem data when migration completes,
> > rather than sync pages one by one in previous version.
> >
> > Changes in v5:
> > * (Patch 9) Add post copy check and output some messages for nvdimm.
> >
> > Changes in v4:
> > * (Patch 2) Fix compilation errors found by patchew.
> >
> > Changes in v3:
> > * (Patch 5) Add a is_pmem flag to ram_handle_compressed() and handle
> > PMEM writes in it, so we don't need the _common function.
> > * (Patch 6) Expose qemu_get_buffer_common so we can remove the
> > unnecessary qemu_get_buffer_to_pmem wrapper.
> > * (Patch 8) Add a is_pmem flag to xbzrle_decode_buffer() and handle
> > PMEM writes in it, so we can remove the unnecessary
> > xbzrle_decode_buffer_{common, to_pmem}.
> > * Move libpmem stubs to stubs/pmem.c and fix the compilation failures
> > of test-{xbzrle,vmstate}.c.
> >
> > Changes in v2:
> > * (Patch 1) Use a flags parameter in file ram allocation functions.
> > * (Patch 2) Add a new option 'pmem' to hostmem-file.
> > * (Patch 3) Use libpmem to operate on the persistent memory, rather
> > than re-implementing those operations in QEMU.
> > * (Patch 5-8) Consider the write persistence in the migration path.
> >
> >
> > Junyan:
> > [1/7] memory, exec: Expose all memory block related flags.
> > [6/7] migration/ram: Add check and info message to nvdimm post copy.
> > [7/7] migration/ram: ensure write persistence on loading all date to PM=
EM.
> >
> > Haozhong:
> > [5/7] mem/nvdimm: ensure write persistence to PMEM in label emulation
> >
> > Haozhong & Junyan:
> > [2/7] memory, exec: switch file ram allocation functions to 'flags' par=
ameters
> > [3/7] hostmem-file: add the 'pmem' option
> > [4/7] configure: add libpmem support
> >
> >
> > Signed-off-by: Haozhong Zhang <haozhong.zhang@intel.com>
> > Signed-off-by: Junyan He <junyan.he@intel.com>
> >
> > ---
> > backends/hostmem-file.c | 28 +++++++++++++++++++++++++++-
> > configure               | 29 +++++++++++++++++++++++++++++
> > docs/nvdimm.txt         | 14 ++++++++++++++
> > exec.c                  | 36 ++++++++++++++----------------------
> > hw/mem/nvdimm.c         |  9 ++++++++-
> > include/exec/memory.h   | 31 +++++++++++++++++++++++++++++--
> > include/exec/ram_addr.h | 28 ++++++++++++++++++++++++++--
> > include/qemu/pmem.h     | 24 ++++++++++++++++++++++++
> > memory.c                |  8 +++++---
> > migration/ram.c         | 18 ++++++++++++++++++
> > numa.c                  |  2 +-
> > qemu-options.hx         |  7 +++++++
> > stubs/Makefile.objs     |  1 +
> > stubs/pmem.c            | 23 +++++++++++++++++++++++
> > 14 files changed, 226 insertions(+), 32 deletions(-)
>
>
