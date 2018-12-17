Received: from eggs.gnu.org ([2001:4830:134:3::10]:56564)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1gYpsp-0007op-1Y
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 05:12:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1gYpsi-0000S3-57
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 05:12:18 -0500
Received: from 15.mo5.mail-out.ovh.net ([178.33.107.29]:40687)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1gYpsh-0000Qj-P6
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 05:12:12 -0500
Received: from player779.ha.ovh.net (unknown [10.109.160.230])
	by mo5.mail-out.ovh.net (Postfix) with ESMTP id 654D9203B4F
	for <qemu-devel@nongnu.org>; Mon, 17 Dec 2018 11:12:06 +0100 (CET)
References: <20181213040126.6768-1-david@gibson.dropbear.id.au>
	<CAFEAcA_4xV2M0Tgw6KSSQ7DOhv3r=FhETH_Yhmg2h0UT3AYS9g@mail.gmail.com>
	<950689dd-1946-a42f-6a68-2944b46d53fc@kaod.org>
	<20181217010344.GA5597@umbus.fritz.box>
	<b66a8dcb-dadc-ff8b-d054-14620961cb4a@kaod.org>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <dc15e6c7-e411-bcc7-d799-498be6b1e6be@kaod.org>
Date: Mon, 17 Dec 2018 11:11:50 +0100
MIME-Version: 1.0
In-Reply-To: <b66a8dcb-dadc-ff8b-d054-14620961cb4a@kaod.org>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 00/27] ppc-for-4.0 queue 20181213
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Peter Maydell <peter.maydell@linaro.org>, groug@kaod.org, Laurent Vivier <lvivier@redhat.com>, spopovyc@redhat.com, qemu-ppc <qemu-ppc@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>

On 12/17/18 9:04 AM, C=E9dric Le Goater wrote:
> On 12/17/18 2:03 AM, David Gibson wrote:
>> On Fri, Dec 14, 2018 at 06:49:55PM +0100, C=E9dric Le Goater wrote:
>>> On 12/14/18 5:03 PM, Peter Maydell wrote:
>>>> On Thu, 13 Dec 2018 at 04:01, David Gibson <david@gibson.dropbear.id=
.au> wrote:
>>>>>
>>>>> The following changes since commit 4b3aab204204ca742836219b97b538d9=
0584f4f2:
>>>>>
>>>>>   Merge remote-tracking branch 'remotes/vivier2/tags/trivial-patche=
s-pull-request' into staging (2018-12-11 22:26:44 +0000)
>>>>>
>>>>> are available in the Git repository at:
>>>>>
>>>>>   git://github.com/dgibson/qemu.git tags/ppc-for-4.0-20181213
>>>>>
>>>>> for you to fetch changes up to 67888a17b6683600ae3fa64ca275c737ba8a=
9a45:
>>>>>
>>>>>   spapr/xive: use the VCPU id as a NVT identifier (2018-12-13 09:44=
:04 +1100)
>>>>>
>>>>> ----------------------------------------------------------------
>>>>> ppc patch queue 2018-12-13
>>>>>
>>>>> Here's the first ppc and spapr pull request for 4.0.  Highlights ar=
e:
>>>>>
>>>>>  * The start of support for the POWER9 "XIVE" interrupt controller
>>>>>    (not complete enough to use yet, but we're getting there)
>>>>>  * A number of g_new vs. g_malloc cleanups
>>>>>  * Some IRQ wiring cleanups
>>>>>  * A fix for how we advertise NUMA nodes to the guest for pseries
>>>>>
>>>>> ---------------------------------------------------------------
>>>>
>>>>
>>>> Compile errors in the windows cross-build.=20
>>>
>>> are you compiling with the mingw64-* packages ? as documented in :
>>>
>>> 	https://wiki.qemu.org/Hosts/W32
>>>
>>>> These look like
>>>> they're assumptions that "long" is 64 bits, which it is not on Windo=
ws.
>>>> For instance the PPC_BIT macro should be using the ULL suffix, not U=
L
>>>> ("UL" is almost always a bug: either the constant is 32-bit, in
>>>> which case "U" is what you want, or it's 64-bit and you need "ULL").
>>>
>>> ok. These definitions come from our skiboot firmware which I wanted=20
>>> to keep as it was. It seems I will need to adapt.
>>>
>>>> Using __builtin_ffsl() directly in target/ppc/cpu.h also looks
>>>> a bit dubious -- this should be rephrased to use ctz32() or ctz64()
>>>> instead.
>>>
>>> ok. I will work on a fix.
>>
>> So, I tried to confirm the problem, before applying C=E9dric's fix, bu=
t
>> I don't seem to be able to.  I'm getting a bunch of failures in the
>> windows cross-build on master, which look like gcc8 problems - but
>> nothing new or different in my tree.
>>
>> $ ./configure --cross-prefix=3Di686-w64-mingw32-
>=20
> I am still using f28. Another reason to update.

I gave it a try on a f29 with :=20

  $ x86_64-w64-mingw32-gcc --version=20
  x86_64-w64-mingw32-gcc (GCC) 8.2.0 20180726 (Fedora MinGW 8.2.0-3.fc29)

and it compiles if configured with --disable-werror as suggested by Howar=
d.

Anyhow, we need to discuss a little more on the cpu.h fix, regarding the =
ctz,=20
and the hcalls also need some fixing :

  -        qemu_log_mask(LOG_GUEST_ERROR, "XIVE: Unknown LISN %lx\n", lis=
n);
  +        qemu_log_mask(LOG_GUEST_ERROR, "XIVE: Unknown LISN " TARGET_FM=
T_lx "\n",
  +                      lisn);


For v9.=20

Thanks,
=20
C.

 =20
>> [...]
>>
>> $ make -k
>>
>> 	CHK version_gen.h
>>   CC      block/sheepdog.o
>> block/sheepdog.c: In function 'find_vdi_name':
>> block/sheepdog.c:1239:5: error: 'strncpy' specified bound 256 equals d=
estination size [-Werror=3Dstringop-truncation]
>>      strncpy(buf + SD_MAX_VDI_LEN, tag, SD_MAX_VDI_TAG_LEN);
>>      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> cc1: all warnings being treated as errors
>> make: *** [/home/dwg/src/qemu/rules.mak:69: block/sheepdog.o] Error 1
>>   CC      hw/acpi/core.o
>> In function 'acpi_table_install',
>>     inlined from 'acpi_table_add' at hw/acpi/core.c:296:5:
>> hw/acpi/core.c:184:9: error: 'strncpy' specified bound 4 equals destin=
ation size [-Werror=3Dstringop-truncation]
>>          strncpy(ext_hdr->sig, hdrs->sig, sizeof ext_hdr->sig);
>>          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> hw/acpi/core.c:203:9: error: 'strncpy' specified bound 6 equals destin=
ation size [-Werror=3Dstringop-truncation]
>>          strncpy(ext_hdr->oem_id, hdrs->oem_id, sizeof ext_hdr->oem_id=
);
>>          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~
>> hw/acpi/core.c:207:9: error: 'strncpy' specified bound 8 equals destin=
ation size [-Werror=3Dstringop-truncation]
>>          strncpy(ext_hdr->oem_table_id, hdrs->oem_table_id,
>>          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>                  sizeof ext_hdr->oem_table_id);
>>                  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> hw/acpi/core.c:216:9: error: 'strncpy' specified bound 4 equals destin=
ation size [-Werror=3Dstringop-truncation]
>>          strncpy(ext_hdr->asl_compiler_id, hdrs->asl_compiler_id,
>>          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>                  sizeof ext_hdr->asl_compiler_id);
>>                  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> cc1: all warnings being treated as errors
>> make: *** [/home/dwg/src/qemu/rules.mak:69: hw/acpi/core.o] Error 1
>>   CC      hw/acpi/aml-build.o
>> hw/acpi/aml-build.c: In function 'build_header':
>> hw/acpi/aml-build.c:1535:9: error: 'strncpy' specified bound 6 equals =
destination size [-Werror=3Dstringop-truncation]
>>          strncpy((char *)h->oem_id, oem_id, sizeof h->oem_id);
>>          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> hw/acpi/aml-build.c:1541:9: error: 'strncpy' specified bound 8 equals =
destination size [-Werror=3Dstringop-truncation]
>>          strncpy((char *)h->oem_table_id, oem_table_id, sizeof(h->oem_=
table_id));
>>          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~~~~~~~
>> cc1: all warnings being treated as errors
>> make: *** [/home/dwg/src/qemu/rules.mak:69: hw/acpi/aml-build.o] Error=
 1
>>   CC      migration/global_state.o
>> migration/global_state.c: In function 'global_state_store_running':
>> migration/global_state.c:45:5: error: 'strncpy' specified bound 100 eq=
uals destination size [-Werror=3Dstringop-truncation]
>>      strncpy((char *)global_state.runstate,
>>      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>             state, sizeof(global_state.runstate));
>>             ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> cc1: all warnings being treated as errors
>> make: *** [/home/dwg/src/qemu/rules.mak:69: migration/global_state.o] =
Error 1
>> make: Target 'all' not remade because of errors.
>>
>>
>>>
>>> Thanks,
>>>
>>> C.
>>>
>>>
>>>> In file included from /home/petmay01/qemu-for-merges/hw/intc/xive.c:=
13:0:
>>>> /home/petmay01/qemu-for-merges/hw/intc/xive.c: In function 'xive_rou=
ter_notify':
>>>> /home/petmay01/qemu-for-merges/target/ppc/cpu.h:76:33: error: overfl=
ow
>>>> in implicit constant conversion [-Werror=3Doverflow]
>>>>  #define PPC_BITMASK(bs, be)     ((PPC_BIT(bs) - PPC_BIT(be)) | PPC_=
BIT(bs))
>>>>                                  ^
>>>> /home/petmay01/qemu-for-merges/target/ppc/cpu.h:84:50: note: in
>>>> definition of macro 'MASK_TO_LSH'
>>>>  # define MASK_TO_LSH(m)          (__builtin_ffsl(m) - 1)
>>>>                                                   ^
>>>> /home/petmay01/qemu-for-merges/include/hw/ppc/xive_regs.h:129:34:
>>>> note: in expansion of macro 'GETFIELD'
>>>>  #define GETFIELD_BE64(m, v)      GETFIELD(m, be64_to_cpu(v))
>>>>                                   ^
>>>> /home/petmay01/qemu-for-merges/hw/intc/xive.c:1366:28: note: in
>>>> expansion of macro 'GETFIELD_BE64'
>>>>                             GETFIELD_BE64(EAS_END_BLOCK, eas.w),
>>>>                             ^
>>>> /home/petmay01/qemu-for-merges/include/hw/ppc/xive_regs.h:120:25:
>>>> note: in expansion of macro 'PPC_BITMASK'
>>>>  #define EAS_END_BLOCK   PPC_BITMASK(4, 7)        /* Destination END=
 block# */
>>>>                          ^
>>>> /home/petmay01/qemu-for-merges/hw/intc/xive.c:1366:42: note: in
>>>> expansion of macro 'EAS_END_BLOCK'
>>>>                             GETFIELD_BE64(EAS_END_BLOCK, eas.w),
>>>>                                           ^
>>>> /home/petmay01/qemu-for-merges/target/ppc/cpu.h:89:46: error: right
>>>> shift count is negative [-Werror=3Dshift-count-negative]
>>>>  #define GETFIELD(m, v)          (((v) & (m)) >> MASK_TO_LSH(m))
>>>>                                               ^
>>>> /home/petmay01/qemu-for-merges/include/hw/ppc/xive_regs.h:129:34:
>>>> note: in expansion of macro 'GETFIELD'
>>>>  #define GETFIELD_BE64(m, v)      GETFIELD(m, be64_to_cpu(v))
>>>>                                   ^
>>>> /home/petmay01/qemu-for-merges/hw/intc/xive.c:1366:28: note: in
>>>> expansion of macro 'GETFIELD_BE64'
>>>>                             GETFIELD_BE64(EAS_END_BLOCK, eas.w),
>>>>                             ^
>>>> /home/petmay01/qemu-for-merges/target/ppc/cpu.h:76:33: error: overfl=
ow
>>>> in implicit constant conversion [-Werror=3Doverflow]
>>>>  #define PPC_BITMASK(bs, be)     ((PPC_BIT(bs) - PPC_BIT(be)) | PPC_=
BIT(bs))
>>>>                                  ^
>>>> /home/petmay01/qemu-for-merges/target/ppc/cpu.h:84:50: note: in
>>>> definition of macro 'MASK_TO_LSH'
>>>>  # define MASK_TO_LSH(m)          (__builtin_ffsl(m) - 1)
>>>>                                                   ^
>>>> /home/petmay01/qemu-for-merges/include/hw/ppc/xive_regs.h:129:34:
>>>> note: in expansion of macro 'GETFIELD'
>>>>  #define GETFIELD_BE64(m, v)      GETFIELD(m, be64_to_cpu(v))
>>>>                                   ^
>>>> /home/petmay01/qemu-for-merges/hw/intc/xive.c:1367:28: note: in
>>>> expansion of macro 'GETFIELD_BE64'
>>>>                             GETFIELD_BE64(EAS_END_INDEX, eas.w),
>>>>                             ^
>>>> /home/petmay01/qemu-for-merges/include/hw/ppc/xive_regs.h:121:25:
>>>> note: in expansion of macro 'PPC_BITMASK'
>>>>  #define EAS_END_INDEX   PPC_BITMASK(8, 31)       /* Destination END=
 index */
>>>>                          ^
>>>> /home/petmay01/qemu-for-merges/hw/intc/xive.c:1367:42: note: in
>>>> expansion of macro 'EAS_END_INDEX'
>>>>                             GETFIELD_BE64(EAS_END_INDEX, eas.w),
>>>>                                           ^
>>>> /home/petmay01/qemu-for-merges/target/ppc/cpu.h:89:46: error: right
>>>> shift count is negative [-Werror=3Dshift-count-negative]
>>>>  #define GETFIELD(m, v)          (((v) & (m)) >> MASK_TO_LSH(m))
>>>>                                               ^
>>>> /home/petmay01/qemu-for-merges/include/hw/ppc/xive_regs.h:129:34:
>>>> note: in expansion of macro 'GETFIELD'
>>>>  #define GETFIELD_BE64(m, v)      GETFIELD(m, be64_to_cpu(v))
>>>>                                   ^
>>>> /home/petmay01/qemu-for-merges/hw/intc/xive.c:1367:28: note: in
>>>> expansion of macro 'GETFIELD_BE64'
>>>>                             GETFIELD_BE64(EAS_END_INDEX, eas.w),
>>>>                             ^
>>>> /home/petmay01/qemu-for-merges/hw/intc/xive.c: In function
>>>> 'xive_eas_pic_print_info':
>>>> /home/petmay01/qemu-for-merges/target/ppc/cpu.h:76:33: error: overfl=
ow
>>>> in implicit constant conversion [-Werror=3Doverflow]
>>>>  #define PPC_BITMASK(bs, be)     ((PPC_BIT(bs) - PPC_BIT(be)) | PPC_=
BIT(bs))
>>>>                                  ^
>>>> /home/petmay01/qemu-for-merges/target/ppc/cpu.h:84:50: note: in
>>>> definition of macro 'MASK_TO_LSH'
>>>>  # define MASK_TO_LSH(m)          (__builtin_ffsl(m) - 1)
>>>>                                                   ^
>>>> /home/petmay01/qemu-for-merges/include/hw/ppc/xive_regs.h:129:34:
>>>> note: in expansion of macro 'GETFIELD'
>>>>  #define GETFIELD_BE64(m, v)      GETFIELD(m, be64_to_cpu(v))
>>>>                                   ^
>>>> /home/petmay01/qemu-for-merges/hw/intc/xive.c:1400:31: note: in
>>>> expansion of macro 'GETFIELD_BE64'
>>>>                     (uint8_t)  GETFIELD_BE64(EAS_END_BLOCK, eas->w),
>>>>                                ^
>>>> /home/petmay01/qemu-for-merges/include/hw/ppc/xive_regs.h:120:25:
>>>> note: in expansion of macro 'PPC_BITMASK'
>>>>  #define EAS_END_BLOCK   PPC_BITMASK(4, 7)        /* Destination END=
 block# */
>>>>                          ^
>>>> /home/petmay01/qemu-for-merges/hw/intc/xive.c:1400:45: note: in
>>>> expansion of macro 'EAS_END_BLOCK'
>>>>                     (uint8_t)  GETFIELD_BE64(EAS_END_BLOCK, eas->w),
>>>>                                              ^
>>>> /home/petmay01/qemu-for-merges/target/ppc/cpu.h:89:46: error: right
>>>> shift count is negative [-Werror=3Dshift-count-negative]
>>>>  #define GETFIELD(m, v)          (((v) & (m)) >> MASK_TO_LSH(m))
>>>>                                               ^
>>>> /home/petmay01/qemu-for-merges/include/hw/ppc/xive_regs.h:129:34:
>>>> note: in expansion of macro 'GETFIELD'
>>>>  #define GETFIELD_BE64(m, v)      GETFIELD(m, be64_to_cpu(v))
>>>>                                   ^
>>>> /home/petmay01/qemu-for-merges/hw/intc/xive.c:1400:31: note: in
>>>> expansion of macro 'GETFIELD_BE64'
>>>>                     (uint8_t)  GETFIELD_BE64(EAS_END_BLOCK, eas->w),
>>>>                                ^
>>>> /home/petmay01/qemu-for-merges/include/hw/ppc/xive_regs.h:120:25:
>>>> note: in expansion of macro 'PPC_BITMASK'
>>>>  #define EAS_END_BLOCK   PPC_BITMASK(4, 7)        /* Destination END=
 block# */
>>>>                          ^
>>>> /home/petmay01/qemu-for-merges/hw/intc/xive.c:1400:45: note: in
>>>> expansion of macro 'EAS_END_BLOCK'
>>>>                     (uint8_t)  GETFIELD_BE64(EAS_END_BLOCK, eas->w),
>>>>                                              ^
>>>> /home/petmay01/qemu-for-merges/target/ppc/cpu.h:89:46: error: right
>>>> shift count is negative [-Werror=3Dshift-count-negative]
>>>>  #define GETFIELD(m, v)          (((v) & (m)) >> MASK_TO_LSH(m))
>>>>                                               ^
>>>> /home/petmay01/qemu-for-merges/include/hw/ppc/xive_regs.h:129:34:
>>>> note: in expansion of macro 'GETFIELD'
>>>>  #define GETFIELD_BE64(m, v)      GETFIELD(m, be64_to_cpu(v))
>>>>                                   ^
>>>> /home/petmay01/qemu-for-merges/hw/intc/xive.c:1400:31: note: in
>>>> expansion of macro 'GETFIELD_BE64'
>>>>                     (uint8_t)  GETFIELD_BE64(EAS_END_BLOCK, eas->w),
>>>>                                ^
>>>> /home/petmay01/qemu-for-merges/target/ppc/cpu.h:76:33: error: overfl=
ow
>>>> in implicit constant conversion [-Werror=3Doverflow]
>>>>  #define PPC_BITMASK(bs, be)     ((PPC_BIT(bs) - PPC_BIT(be)) | PPC_=
BIT(bs))
>>>>                                  ^
>>>> /home/petmay01/qemu-for-merges/target/ppc/cpu.h:84:50: note: in
>>>> definition of macro 'MASK_TO_LSH'
>>>>  # define MASK_TO_LSH(m)          (__builtin_ffsl(m) - 1)
>>>>                                                   ^
>>>> /home/petmay01/qemu-for-merges/include/hw/ppc/xive_regs.h:129:34:
>>>> note: in expansion of macro 'GETFIELD'
>>>>  #define GETFIELD_BE64(m, v)      GETFIELD(m, be64_to_cpu(v))
>>>>                                   ^
>>>> /home/petmay01/qemu-for-merges/hw/intc/xive.c:1401:31: note: in
>>>> expansion of macro 'GETFIELD_BE64'
>>>>                     (uint32_t) GETFIELD_BE64(EAS_END_INDEX, eas->w),
>>>>                                ^
>>>> /home/petmay01/qemu-for-merges/include/hw/ppc/xive_regs.h:121:25:
>>>> note: in expansion of macro 'PPC_BITMASK'
>>>>  #define EAS_END_INDEX   PPC_BITMASK(8, 31)       /* Destination END=
 index */
>>>>                          ^
>>>> /home/petmay01/qemu-for-merges/hw/intc/xive.c:1401:45: note: in
>>>> expansion of macro 'EAS_END_INDEX'
>>>>                     (uint32_t) GETFIELD_BE64(EAS_END_INDEX, eas->w),
>>>>                                              ^
>>>> /home/petmay01/qemu-for-merges/target/ppc/cpu.h:89:46: error: right
>>>> shift count is negative [-Werror=3Dshift-count-negative]
>>>>  #define GETFIELD(m, v)          (((v) & (m)) >> MASK_TO_LSH(m))
>>>>                                               ^
>>>> /home/petmay01/qemu-for-merges/include/hw/ppc/xive_regs.h:129:34:
>>>> note: in expansion of macro 'GETFIELD'
>>>>  #define GETFIELD_BE64(m, v)      GETFIELD(m, be64_to_cpu(v))
>>>>                                   ^
>>>> /home/petmay01/qemu-for-merges/hw/intc/xive.c:1401:31: note: in
>>>> expansion of macro 'GETFIELD_BE64'
>>>>                     (uint32_t) GETFIELD_BE64(EAS_END_INDEX, eas->w),
>>>>                                ^
>>>>
>>>>
>>>> thanks
>>>> -- PMM
>>>>
>>>
>>
>=20
