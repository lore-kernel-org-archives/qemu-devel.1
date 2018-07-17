Received: from eggs.gnu.org ([2001:4830:134:3::10]:54771)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1ffWrr-0002PF-0R
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 16:46:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1ffWrm-0000hX-1u
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 16:46:43 -0400
Date: Tue, 17 Jul 2018 22:46:35 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
In-Reply-To: <e32447d1-92dd-7508-d388-ed2ac606c1b8@ilande.co.uk>
Message-ID: <alpine.BSF.2.21.1807172232001.51759@zero.eik.bme.hu>
References: <20180716195851.0FE177456B7@zero.eik.bme.hu>
	<CAFEAcA-Lu=gZWQOROa+oEwaWP8FWSY__=jneDQZVK=mFXAcFMw@mail.gmail.com>
	<alpine.BSF.2.21.1807171644120.57515@zero.eik.bme.hu>
	<64174176-84a6-57dc-4b34-d3cd11d585c9@ilande.co.uk>
	<alpine.BSF.2.21.1807172049050.25631@zero.eik.bme.hu>
	<e32447d1-92dd-7508-d388-ed2ac606c1b8@ilande.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Subject: Re: [Qemu-devel] [Qemu-ppc] Profiling results
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org

On Tue, 17 Jul 2018, Mark Cave-Ayland wrote:
> On 17/07/18 20:35, BALATON Zoltan wrote:
>> On Tue, 17 Jul 2018, Mark Cave-Ayland wrote:
>>>> MorphOS on mac99 this seems to be significant. This is with default 
>>>> configure (--enable-qom-cast-debug):
>>>> 
>>>> %?????? cum. %???? linenr info???????????????? symbol name
>>>> 9.7057?? 9.7057??? exec-all.h:410????????????? helper_lookup_tb_ptr
>>>> 8.0330? 17.7387??? object.c:711 object_class_dynamic_cast_assert
>>>> 6.9411? 24.6798??? cputlb.c:793??????????????? io_readx
>>>> 6.3219? 31.0017??? sm501_template.h:62???????? draw_line16_32
>>>> 5.3601? 36.3617??? cputlb.c:114??????????????? tlb_flush_nocheck
>>>> 3.6170? 39.9787??? translate-all.c:749???????? page_trylock_add
>>>> 3.1188? 43.0975??? translate-all.c:803???????? page_collection_lock
>>>> 3.0405? 46.1380??? exec.c:3025???????????????? iotlb_to_section
>>>> 2.7044? 48.8424??? softmmu_template.h:112????? helper_ret_ldub_mmu
>>>> 2.4154? 51.2578??? memory.c:1350?????????????? memory_region_access_valid
>> [...]
>>> My first thought is that there is a QOM cast somewhere in a hot path on -M 
>>> mac99 - can you show us the call stack information from the profile?
>> 
>> Not really. Oprofile that gave me this profile could not display call graph 
>> for this call. I've tried again with the perf tool but I'm not quite sure 
>> how to interpret its results. If I'm not mistaken it points me in the 
>> direction of cpu_asidx_from_attrs, called from iotlb_to_section, called 
>> from io_readx. The object_class_dynamic_cast_assert call likely comes from 
>> OBJECT_CLASS_CHECK, expanded from OBJECT_GET_CLASS, expanded from 
>> CPU_GET_CLASS. Would that make any sense? Any idea what to do about it?
>
> Good question. A quick grep for 'asidx_from_attrs' shows that 
> cc->asidx_from_attrs() isn't set for PPC targets, so as a quick test does 
> replacing the inline function cpu_asidx_from_attrs() in include/qom/cpu.h 
> with a simple "return 0" change the profile at all?

It does seem to lessen its impact but it's still higher than I expected:

%        cum. %     linenr info                 symbol name
10.7949  10.7949    exec-all.h:410              helper_lookup_tb_ptr
  7.8663  18.6612    cputlb.c:793                io_readx
  6.0265  24.6878    cputlb.c:114                tlb_flush_nocheck
  4.0671  28.7548    sm501_template.h:62         draw_line16_32
  4.0559  32.8107    object.c:765                object_class_dynamic_cast_assert
  3.3780  36.1887    memory.c:1350               memory_region_access_valid
  2.8920  39.0808    qemu-thread-posix.c:61      qemu_mutex_lock_impl
  2.7187  41.7995    memory.c:1415               memory_region_dispatch_read
  2.6011  44.4006    qht.c:487                   qht_lookup_custom
  2.5356  46.9362    softmmu_template.h:112      helper_ret_ldub_mmu

Maybe it's called from somewhere else too? I know draw_line16_32 but I 
wonder where could helper_lookup_tb_ptr and tlb flushes come from? Those 
seem to be significant. And io_readx in itself seems to be too high on the 
list too. I wonder if it may have something to do with the background task 
trying to read non-implemented i2c stuff frequently (as discussed in point 
2. in http://zero.eik.bme.hu/~balaton/qemu/amiga/#morphos).

Regards,
BALATON Zoltan
