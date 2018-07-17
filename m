Received: from eggs.gnu.org ([2001:4830:134:3::10]:49985)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1ffRbm-0007Kg-IJ
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 11:09:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1ffRbj-00016p-CM
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 11:09:46 -0400
Date: Tue, 17 Jul 2018 17:09:41 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
In-Reply-To: <CAFEAcA-Lu=gZWQOROa+oEwaWP8FWSY__=jneDQZVK=mFXAcFMw@mail.gmail.com>
Message-ID: <alpine.BSF.2.21.1807171644120.57515@zero.eik.bme.hu>
References: <20180716195851.0FE177456B7@zero.eik.bme.hu>
	<CAFEAcA-Lu=gZWQOROa+oEwaWP8FWSY__=jneDQZVK=mFXAcFMw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Subject: [Qemu-devel] Profiling results (was: Re: [PATCH] Do not enable QOM
 debugging by default)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org

On Mon, 16 Jul 2018, Peter Maydell wrote:
> Is this coming up as significant in profiling? In the past we've

This seems to depend on the workload. From the cases I'm interested in 
AROS and AmigaOS on qemu-system-ppc -M sam460ex does not seem to be 
effected much (object_class_dynamic_cast_assert is not in top 10 with <2%) 
but for MorphOS on mac99 this seems to be significant. This is with 
default configure (--enable-qom-cast-debug):

%       cum. %     linenr info                 symbol name
9.7057   9.7057    exec-all.h:410              helper_lookup_tb_ptr
8.0330  17.7387    object.c:711                object_class_dynamic_cast_assert
6.9411  24.6798    cputlb.c:793                io_readx
6.3219  31.0017    sm501_template.h:62         draw_line16_32
5.3601  36.3617    cputlb.c:114                tlb_flush_nocheck
3.6170  39.9787    translate-all.c:749         page_trylock_add
3.1188  43.0975    translate-all.c:803         page_collection_lock
3.0405  46.1380    exec.c:3025                 iotlb_to_section
2.7044  48.8424    softmmu_template.h:112      helper_ret_ldub_mmu
2.4154  51.2578    memory.c:1350               memory_region_access_valid

and improves a bit (but not much) with --disable-qom-cast-debug

%        cum. %     linenr info                 symbol name
10.2063  10.2063    exec-all.h:410              helper_lookup_tb_ptr
  7.1581  17.3644    object.c:711                object_class_dynamic_cast_assert
  5.9297  23.2941    sm501_template.h:62         draw_line16_32
  5.9227  29.2168    cputlb.c:793                io_readx
  5.3030  34.5198    cputlb.c:114                tlb_flush_nocheck
  3.6445  38.1643    memory.c:1350               memory_region_access_valid
  3.5499  41.7142    softmmu_template.h:112      helper_ret_ldub_mmu
  3.0383  44.7525    translate-all.c:803         page_collection_lock
  2.9735  47.7260    memory.c:1415               memory_region_dispatch_read
  2.9503  50.6763    translate-all.c:749         page_trylock_add

But the workloads may not have been 100% identical so this is not 
conclusive, maybe this debug code is not that expensive at the moment.

AROS on sam460ex has a different profile:

%        cum. %     linenr info                 symbol name
8.9905   8.9905     translate-all.c:749         page_trylock_add
8.7658  17.7563     exec-all.h:410              helper_lookup_tb_ptr
7.7349  25.4911     translate-all.c:803         page_collection_lock
5.8246  31.3158     cputlb.c:924                victim_tlb_hit
3.1640  34.4797     cpus.c:347                  cpu_get_clock
3.1538  37.6335     translate-all.c:788         tb_page_addr_cmp
2.7969  40.4304     exec.c:435                  address_space_translate_internal
2.6647  43.0951     memory.c:571                access_with_adjusted_size
2.0615  45.1567     exec.c:569                  flatview_do_translate
1.9586  47.1153     memory.c:1350               memory_region_access_valid

Would anyone be able to guess what are the places that should be looked at 
or what to check to get more info on this?

Regards,
BALATON Zoltan
