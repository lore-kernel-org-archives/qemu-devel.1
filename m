Received: from eggs.gnu.org ([2001:4830:134:3::10]:45872)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <hsp.cat7@gmail.com>) id 1gYnXB-0000zU-N9
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 02:41:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <hsp.cat7@gmail.com>) id 1gYnX8-0003Rv-LN
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 02:41:49 -0500
MIME-Version: 1.0
References: <20181213040126.6768-1-david@gibson.dropbear.id.au>
	<CAFEAcA_4xV2M0Tgw6KSSQ7DOhv3r=FhETH_Yhmg2h0UT3AYS9g@mail.gmail.com>
	<950689dd-1946-a42f-6a68-2944b46d53fc@kaod.org>
	<20181217010344.GA5597@umbus.fritz.box>
In-Reply-To: <20181217010344.GA5597@umbus.fritz.box>
From: Howard Spoelstra <hsp.cat7@gmail.com>
Date: Mon, 17 Dec 2018 08:41:32 +0100
Message-ID: <CABLmASGjBW++0SYTvW75XF2tDUX7-EBGYm3jd5OnbRyA8FU_=w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-ppc] [PULL 00/27] ppc-for-4.0 queue 20181213
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, Laurent Vivier <lvivier@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, gkurz@kaod.org, QEMU Developers <qemu-devel@nongnu.org>, spopovyc@redhat.com, qemu-ppc <qemu-ppc@nongnu.org>

On Mon, Dec 17, 2018 at 4:31 AM David Gibson
<david@gibson.dropbear.id.au> wrote:
>
> On Fri, Dec 14, 2018 at 06:49:55PM +0100, C=C3=A9dric Le Goater wrote:
> > On 12/14/18 5:03 PM, Peter Maydell wrote:
> > > On Thu, 13 Dec 2018 at 04:01, David Gibson <david@gibson.dropbear.id.=
au> wrote:
> > >>
> > >> The following changes since commit 4b3aab204204ca742836219b97b538d90=
584f4f2:
> > >>
> > >>   Merge remote-tracking branch 'remotes/vivier2/tags/trivial-patches=
-pull-request' into staging (2018-12-11 22:26:44 +0000)
> > >>
> > >> are available in the Git repository at:
> > >>
> > >>   git://github.com/dgibson/qemu.git tags/ppc-for-4.0-20181213
> > >>
> > >> for you to fetch changes up to 67888a17b6683600ae3fa64ca275c737ba8a9=
a45:
> > >>
> > >>   spapr/xive: use the VCPU id as a NVT identifier (2018-12-13 09:44:=
04 +1100)
> > >>
> > >> ----------------------------------------------------------------
> > >> ppc patch queue 2018-12-13
> > >>
> > >> Here's the first ppc and spapr pull request for 4.0.  Highlights are=
:
> > >>
> > >>  * The start of support for the POWER9 "XIVE" interrupt controller
> > >>    (not complete enough to use yet, but we're getting there)
> > >>  * A number of g_new vs. g_malloc cleanups
> > >>  * Some IRQ wiring cleanups
> > >>  * A fix for how we advertise NUMA nodes to the guest for pseries
> > >>
> > >> ---------------------------------------------------------------
> > >
> > >
> > > Compile errors in the windows cross-build.
> >
> > are you compiling with the mingw64-* packages ? as documented in :
> >
> >       https://wiki.qemu.org/Hosts/W32
> >
> > > These look like
> > > they're assumptions that "long" is 64 bits, which it is not on Window=
s.
> > > For instance the PPC_BIT macro should be using the ULL suffix, not UL
> > > ("UL" is almost always a bug: either the constant is 32-bit, in
> > > which case "U" is what you want, or it's 64-bit and you need "ULL").
> >
> > ok. These definitions come from our skiboot firmware which I wanted
> > to keep as it was. It seems I will need to adapt.
> >
> > > Using __builtin_ffsl() directly in target/ppc/cpu.h also looks
> > > a bit dubious -- this should be rephrased to use ctz32() or ctz64()
> > > instead.
> >
> > ok. I will work on a fix.
>
> So, I tried to confirm the problem, before applying C=C3=A9dric's fix, bu=
t
> I don't seem to be able to.  I'm getting a bunch of failures in the
> windows cross-build on master, which look like gcc8 problems - but
> nothing new or different in my tree.
>
> $ ./configure --cross-prefix=3Di686-w64-mingw32-
>
> [...]
>
> $ make -k
>
>         CHK version_gen.h
>   CC      block/sheepdog.o
> block/sheepdog.c: In function 'find_vdi_name':
> block/sheepdog.c:1239:5: error: 'strncpy' specified bound 256 equals dest=
ination size [-Werror=3Dstringop-truncation]
>      strncpy(buf + SD_MAX_VDI_LEN, tag, SD_MAX_VDI_TAG_LEN);
>      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> cc1: all warnings being treated as errors
> make: *** [/home/dwg/src/qemu/rules.mak:69: block/sheepdog.o] Error 1
>   CC      hw/acpi/core.o
> In function 'acpi_table_install',
>     inlined from 'acpi_table_add' at hw/acpi/core.c:296:5:
> hw/acpi/core.c:184:9: error: 'strncpy' specified bound 4 equals destinati=
on size [-Werror=3Dstringop-truncation]
>          strncpy(ext_hdr->sig, hdrs->sig, sizeof ext_hdr->sig);
>          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> hw/acpi/core.c:203:9: error: 'strncpy' specified bound 6 equals destinati=
on size [-Werror=3Dstringop-truncation]
>          strncpy(ext_hdr->oem_id, hdrs->oem_id, sizeof ext_hdr->oem_id);
>          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> hw/acpi/core.c:207:9: error: 'strncpy' specified bound 8 equals destinati=
on size [-Werror=3Dstringop-truncation]
>          strncpy(ext_hdr->oem_table_id, hdrs->oem_table_id,
>          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>                  sizeof ext_hdr->oem_table_id);
>                  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> hw/acpi/core.c:216:9: error: 'strncpy' specified bound 4 equals destinati=
on size [-Werror=3Dstringop-truncation]
>          strncpy(ext_hdr->asl_compiler_id, hdrs->asl_compiler_id,
>          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>                  sizeof ext_hdr->asl_compiler_id);
>                  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> cc1: all warnings being treated as errors
> make: *** [/home/dwg/src/qemu/rules.mak:69: hw/acpi/core.o] Error 1
>   CC      hw/acpi/aml-build.o
> hw/acpi/aml-build.c: In function 'build_header':
> hw/acpi/aml-build.c:1535:9: error: 'strncpy' specified bound 6 equals des=
tination size [-Werror=3Dstringop-truncation]
>          strncpy((char *)h->oem_id, oem_id, sizeof h->oem_id);
>          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> hw/acpi/aml-build.c:1541:9: error: 'strncpy' specified bound 8 equals des=
tination size [-Werror=3Dstringop-truncation]
>          strncpy((char *)h->oem_table_id, oem_table_id, sizeof(h->oem_tab=
le_id));
>          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~~~~
> cc1: all warnings being treated as errors
> make: *** [/home/dwg/src/qemu/rules.mak:69: hw/acpi/aml-build.o] Error 1
>   CC      migration/global_state.o
> migration/global_state.c: In function 'global_state_store_running':
> migration/global_state.c:45:5: error: 'strncpy' specified bound 100 equal=
s destination size [-Werror=3Dstringop-truncation]
>      strncpy((char *)global_state.runstate,
>      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>             state, sizeof(global_state.runstate));
>             ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> cc1: all warnings being treated as errors
> make: *** [/home/dwg/src/qemu/rules.mak:69: migration/global_state.o] Err=
or 1
> make: Target 'all' not remade because of errors.
>
>
> >
> > Thanks,
> >
> > C.
> >
> >
> > > In file included from /home/petmay01/qemu-for-merges/hw/intc/xive.c:1=
3:0:
> > > /home/petmay01/qemu-for-merges/hw/intc/xive.c: In function 'xive_rout=
er_notify':
> > > /home/petmay01/qemu-for-merges/target/ppc/cpu.h:76:33: error: overflo=
w
> > > in implicit constant conversion [-Werror=3Doverflow]
> > >  #define PPC_BITMASK(bs, be)     ((PPC_BIT(bs) - PPC_BIT(be)) | PPC_B=
IT(bs))
> > >                                  ^
> > > /home/petmay01/qemu-for-merges/target/ppc/cpu.h:84:50: note: in
> > > definition of macro 'MASK_TO_LSH'
> > >  # define MASK_TO_LSH(m)          (__builtin_ffsl(m) - 1)
> > >                                                   ^
> > > /home/petmay01/qemu-for-merges/include/hw/ppc/xive_regs.h:129:34:
> > > note: in expansion of macro 'GETFIELD'
> > >  #define GETFIELD_BE64(m, v)      GETFIELD(m, be64_to_cpu(v))
> > >                                   ^
> > > /home/petmay01/qemu-for-merges/hw/intc/xive.c:1366:28: note: in
> > > expansion of macro 'GETFIELD_BE64'
> > >                             GETFIELD_BE64(EAS_END_BLOCK, eas.w),
> > >                             ^
> > > /home/petmay01/qemu-for-merges/include/hw/ppc/xive_regs.h:120:25:
> > > note: in expansion of macro 'PPC_BITMASK'
> > >  #define EAS_END_BLOCK   PPC_BITMASK(4, 7)        /* Destination END =
block# */
> > >                          ^
> > > /home/petmay01/qemu-for-merges/hw/intc/xive.c:1366:42: note: in
> > > expansion of macro 'EAS_END_BLOCK'
> > >                             GETFIELD_BE64(EAS_END_BLOCK, eas.w),
> > >                                           ^
> > > /home/petmay01/qemu-for-merges/target/ppc/cpu.h:89:46: error: right
> > > shift count is negative [-Werror=3Dshift-count-negative]
> > >  #define GETFIELD(m, v)          (((v) & (m)) >> MASK_TO_LSH(m))
> > >                                               ^
> > > /home/petmay01/qemu-for-merges/include/hw/ppc/xive_regs.h:129:34:
> > > note: in expansion of macro 'GETFIELD'
> > >  #define GETFIELD_BE64(m, v)      GETFIELD(m, be64_to_cpu(v))
> > >                                   ^
> > > /home/petmay01/qemu-for-merges/hw/intc/xive.c:1366:28: note: in
> > > expansion of macro 'GETFIELD_BE64'
> > >                             GETFIELD_BE64(EAS_END_BLOCK, eas.w),
> > >                             ^
> > > /home/petmay01/qemu-for-merges/target/ppc/cpu.h:76:33: error: overflo=
w
> > > in implicit constant conversion [-Werror=3Doverflow]
> > >  #define PPC_BITMASK(bs, be)     ((PPC_BIT(bs) - PPC_BIT(be)) | PPC_B=
IT(bs))
> > >                                  ^
> > > /home/petmay01/qemu-for-merges/target/ppc/cpu.h:84:50: note: in
> > > definition of macro 'MASK_TO_LSH'
> > >  # define MASK_TO_LSH(m)          (__builtin_ffsl(m) - 1)
> > >                                                   ^
> > > /home/petmay01/qemu-for-merges/include/hw/ppc/xive_regs.h:129:34:
> > > note: in expansion of macro 'GETFIELD'
> > >  #define GETFIELD_BE64(m, v)      GETFIELD(m, be64_to_cpu(v))
> > >                                   ^
> > > /home/petmay01/qemu-for-merges/hw/intc/xive.c:1367:28: note: in
> > > expansion of macro 'GETFIELD_BE64'
> > >                             GETFIELD_BE64(EAS_END_INDEX, eas.w),
> > >                             ^
> > > /home/petmay01/qemu-for-merges/include/hw/ppc/xive_regs.h:121:25:
> > > note: in expansion of macro 'PPC_BITMASK'
> > >  #define EAS_END_INDEX   PPC_BITMASK(8, 31)       /* Destination END =
index */
> > >                          ^
> > > /home/petmay01/qemu-for-merges/hw/intc/xive.c:1367:42: note: in
> > > expansion of macro 'EAS_END_INDEX'
> > >                             GETFIELD_BE64(EAS_END_INDEX, eas.w),
> > >                                           ^
> > > /home/petmay01/qemu-for-merges/target/ppc/cpu.h:89:46: error: right
> > > shift count is negative [-Werror=3Dshift-count-negative]
> > >  #define GETFIELD(m, v)          (((v) & (m)) >> MASK_TO_LSH(m))
> > >                                               ^
> > > /home/petmay01/qemu-for-merges/include/hw/ppc/xive_regs.h:129:34:
> > > note: in expansion of macro 'GETFIELD'
> > >  #define GETFIELD_BE64(m, v)      GETFIELD(m, be64_to_cpu(v))
> > >                                   ^
> > > /home/petmay01/qemu-for-merges/hw/intc/xive.c:1367:28: note: in
> > > expansion of macro 'GETFIELD_BE64'
> > >                             GETFIELD_BE64(EAS_END_INDEX, eas.w),
> > >                             ^
> > > /home/petmay01/qemu-for-merges/hw/intc/xive.c: In function
> > > 'xive_eas_pic_print_info':
> > > /home/petmay01/qemu-for-merges/target/ppc/cpu.h:76:33: error: overflo=
w
> > > in implicit constant conversion [-Werror=3Doverflow]
> > >  #define PPC_BITMASK(bs, be)     ((PPC_BIT(bs) - PPC_BIT(be)) | PPC_B=
IT(bs))
> > >                                  ^
> > > /home/petmay01/qemu-for-merges/target/ppc/cpu.h:84:50: note: in
> > > definition of macro 'MASK_TO_LSH'
> > >  # define MASK_TO_LSH(m)          (__builtin_ffsl(m) - 1)
> > >                                                   ^
> > > /home/petmay01/qemu-for-merges/include/hw/ppc/xive_regs.h:129:34:
> > > note: in expansion of macro 'GETFIELD'
> > >  #define GETFIELD_BE64(m, v)      GETFIELD(m, be64_to_cpu(v))
> > >                                   ^
> > > /home/petmay01/qemu-for-merges/hw/intc/xive.c:1400:31: note: in
> > > expansion of macro 'GETFIELD_BE64'
> > >                     (uint8_t)  GETFIELD_BE64(EAS_END_BLOCK, eas->w),
> > >                                ^
> > > /home/petmay01/qemu-for-merges/include/hw/ppc/xive_regs.h:120:25:
> > > note: in expansion of macro 'PPC_BITMASK'
> > >  #define EAS_END_BLOCK   PPC_BITMASK(4, 7)        /* Destination END =
block# */
> > >                          ^
> > > /home/petmay01/qemu-for-merges/hw/intc/xive.c:1400:45: note: in
> > > expansion of macro 'EAS_END_BLOCK'
> > >                     (uint8_t)  GETFIELD_BE64(EAS_END_BLOCK, eas->w),
> > >                                              ^
> > > /home/petmay01/qemu-for-merges/target/ppc/cpu.h:89:46: error: right
> > > shift count is negative [-Werror=3Dshift-count-negative]
> > >  #define GETFIELD(m, v)          (((v) & (m)) >> MASK_TO_LSH(m))
> > >                                               ^
> > > /home/petmay01/qemu-for-merges/include/hw/ppc/xive_regs.h:129:34:
> > > note: in expansion of macro 'GETFIELD'
> > >  #define GETFIELD_BE64(m, v)      GETFIELD(m, be64_to_cpu(v))
> > >                                   ^
> > > /home/petmay01/qemu-for-merges/hw/intc/xive.c:1400:31: note: in
> > > expansion of macro 'GETFIELD_BE64'
> > >                     (uint8_t)  GETFIELD_BE64(EAS_END_BLOCK, eas->w),
> > >                                ^
> > > /home/petmay01/qemu-for-merges/include/hw/ppc/xive_regs.h:120:25:
> > > note: in expansion of macro 'PPC_BITMASK'
> > >  #define EAS_END_BLOCK   PPC_BITMASK(4, 7)        /* Destination END =
block# */
> > >                          ^
> > > /home/petmay01/qemu-for-merges/hw/intc/xive.c:1400:45: note: in
> > > expansion of macro 'EAS_END_BLOCK'
> > >                     (uint8_t)  GETFIELD_BE64(EAS_END_BLOCK, eas->w),
> > >                                              ^
> > > /home/petmay01/qemu-for-merges/target/ppc/cpu.h:89:46: error: right
> > > shift count is negative [-Werror=3Dshift-count-negative]
> > >  #define GETFIELD(m, v)          (((v) & (m)) >> MASK_TO_LSH(m))
> > >                                               ^
> > > /home/petmay01/qemu-for-merges/include/hw/ppc/xive_regs.h:129:34:
> > > note: in expansion of macro 'GETFIELD'
> > >  #define GETFIELD_BE64(m, v)      GETFIELD(m, be64_to_cpu(v))
> > >                                   ^
> > > /home/petmay01/qemu-for-merges/hw/intc/xive.c:1400:31: note: in
> > > expansion of macro 'GETFIELD_BE64'
> > >                     (uint8_t)  GETFIELD_BE64(EAS_END_BLOCK, eas->w),
> > >                                ^
> > > /home/petmay01/qemu-for-merges/target/ppc/cpu.h:76:33: error: overflo=
w
> > > in implicit constant conversion [-Werror=3Doverflow]
> > >  #define PPC_BITMASK(bs, be)     ((PPC_BIT(bs) - PPC_BIT(be)) | PPC_B=
IT(bs))
> > >                                  ^
> > > /home/petmay01/qemu-for-merges/target/ppc/cpu.h:84:50: note: in
> > > definition of macro 'MASK_TO_LSH'
> > >  # define MASK_TO_LSH(m)          (__builtin_ffsl(m) - 1)
> > >                                                   ^
> > > /home/petmay01/qemu-for-merges/include/hw/ppc/xive_regs.h:129:34:
> > > note: in expansion of macro 'GETFIELD'
> > >  #define GETFIELD_BE64(m, v)      GETFIELD(m, be64_to_cpu(v))
> > >                                   ^
> > > /home/petmay01/qemu-for-merges/hw/intc/xive.c:1401:31: note: in
> > > expansion of macro 'GETFIELD_BE64'
> > >                     (uint32_t) GETFIELD_BE64(EAS_END_INDEX, eas->w),
> > >                                ^
> > > /home/petmay01/qemu-for-merges/include/hw/ppc/xive_regs.h:121:25:
> > > note: in expansion of macro 'PPC_BITMASK'
> > >  #define EAS_END_INDEX   PPC_BITMASK(8, 31)       /* Destination END =
index */
> > >                          ^
> > > /home/petmay01/qemu-for-merges/hw/intc/xive.c:1401:45: note: in
> > > expansion of macro 'EAS_END_INDEX'
> > >                     (uint32_t) GETFIELD_BE64(EAS_END_INDEX, eas->w),
> > >                                              ^
> > > /home/petmay01/qemu-for-merges/target/ppc/cpu.h:89:46: error: right
> > > shift count is negative [-Werror=3Dshift-count-negative]
> > >  #define GETFIELD(m, v)          (((v) & (m)) >> MASK_TO_LSH(m))
> > >                                               ^
> > > /home/petmay01/qemu-for-merges/include/hw/ppc/xive_regs.h:129:34:
> > > note: in expansion of macro 'GETFIELD'
> > >  #define GETFIELD_BE64(m, v)      GETFIELD(m, be64_to_cpu(v))
> > >                                   ^
> > > /home/petmay01/qemu-for-merges/hw/intc/xive.c:1401:31: note: in
> > > expansion of macro 'GETFIELD_BE64'
> > >                     (uint32_t) GETFIELD_BE64(EAS_END_INDEX, eas->w),
> > >                                ^
> > >
> > >
> > > thanks
> > > -- PMM
> > >
> >
>
> --
> David Gibson                    | I'll have my music baroque, and my code
> david AT gibson.dropbear.id.au  | minimalist, thank you.  NOT _the_ _othe=
r_
>                                 | _way_ _around_!
> http://www.ozlabs.org/~dgibson

Hi,

We had a discussion about the strncpy errors and windows builds
SIGSEGV-ing here:
https://lists.nongnu.org/archive/html/qemu-devel/2018-08/msg03310.html

A solution was suggested here:
https://lists.nongnu.org/archive/html/qemu-devel/2018-08/msg03761.html.

Nevertheless, I still compile with --disable-werror and
--disable-stack-protector to get a working binary. (Cross-compiling on
Fedora 29).

Best,
Howard
