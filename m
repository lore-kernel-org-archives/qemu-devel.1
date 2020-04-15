Return-Path: <SRS0=EwQe=57=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BB49C2BA19
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2020 09:26:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6757620768
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2020 09:26:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MTTBmOyB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6757620768
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46664 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jOeJb-0002MW-Jy
	for qemu-devel@archiver.kernel.org; Wed, 15 Apr 2020 05:26:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36007)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1jOeIx-0001wY-Ix
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 05:26:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1jOeIv-0006sh-Gb
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 05:25:59 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:44216
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1jOeIv-0006sF-9o
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 05:25:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586942756;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XOTwVrLy82/BG89A5g+xV3D6HOhq0pkh39+pOc5+WI0=;
 b=MTTBmOyBy2ZLe36w9OaoR7KYkYZ2+riWlSKgNDD+1FBH8UCCbQUE0TfbYdu18a9uSXk8Wk
 A1Riyo+PYoMyU9Ugc4V2PzdraQkcKEIHDinTnTcz64T0xzMDJnlgN7NdFroxplEZbdBDOg
 KoDF6JvpXJubqmmJpACTP2XQ/nAlWMQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-36-irtT5uUjMzmlpeGxQVrIQA-1; Wed, 15 Apr 2020 05:25:50 -0400
X-MC-Unique: irtT5uUjMzmlpeGxQVrIQA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A30A58017FD;
 Wed, 15 Apr 2020 09:25:49 +0000 (UTC)
Received: from localhost (unknown [10.40.208.30])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 70ADC60BE2;
 Wed, 15 Apr 2020 09:25:47 +0000 (UTC)
Date: Wed, 15 Apr 2020 11:25:46 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Philipp Eppelt <1871842@bugs.launchpad.net>
Subject: Re: [Bug 1871842] [NEW] AMD CPUID leaf 0x8000'0008 reported number
 of cores inconsistent with ACPI.MADT
Message-ID: <20200415112546.68ca1f15@redhat.com>
In-Reply-To: <42f0624d-b0fb-5d96-2921-8994c28b9937@kernkonzept.com>
References: <158643709116.17430.15995069125716778943.malonedeb@wampee.canonical.com>
 <20200409160037.431ec776@redhat.com>
 <5f7b85c6-09af-1064-f7f8-66ea7abf3ae3@amd.com>
 <4ac73ad4-db45-f2a8-ddcd-a162a6c0eb73@kernkonzept.com>
 <42f0624d-b0fb-5d96-2921-8994c28b9937@kernkonzept.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 14 Apr 2020 13:27:34 -0000
Philipp Eppelt <1871842@bugs.launchpad.net> wrote:

> Hi,
> 
> I have to clarify some things mentioned in my last post:
> 
> I only tested the change with an emulated EPYC-v2 CPU, I cannot test on
> a physical EPYC CPU at the moment. However, I doubt that the results
> will be different regarding the 0x8000_0008.ECX result.
> 
> The topology information printed is from the EPYC-v2 CPU model. I try to
> get access to the machine and have a look if -cpu host affects this
> topology.
> 
> So there is still the open question for the -enable-kvm -cpu host -smp 4
> case. Shouldn't in this case the topology of the host CPU be reported?
topology was never affected by the choice of -cpu, it's up to users to
define it using -smp the way they prefer.
 

> In all emulated-CPU cases it's on the user to define the topology or to
> live with the generated one (although I think preferring multi-socket
> systems is outdated, but it's likely just the case in my 'world').
> 
> 
> Cheers,
> Philipp
> 
> 
> On 4/14/20 10:24 AM, Philipp Eppelt wrote:
> > Hi,
> > 
> > thanks for looking into this so quickly.
> > 
> > With this patch applied ontop of git commit
> > f3bac27cc1e303e1860cc55b9b6889ba39dee587 I still have the issue and it
> > reports the same numbers. I like the new usage of the ApicIdSize field.
> > 
> > 
> > I looked into the mentioned pc_smp_parse() and had it print the topology
> > for -smp 4:
> > 
> > qemu-system-x86_64: warning: cpu topology: sockets (4) , dies (1) ,
> > cores (1) , threads (1) , maxcpus (4), cpus (4)
> > 
> > and with -smp 4,cores=4:
> > 
> > qemu-system-x86_64: warning: cpu topology: sockets (1) , dies (1) ,
> > cores (4) , threads (1) , maxcpus (4), cpus (4)
> > 
> > As far as I understand it, these are the numbers the cpuid:8000'0008
> > code relies on:
> > `cs->nr_cores`, `cs->nr_threads` with `cs` being of type CPUState.
> > 
> > So I think the issue is rooted with the preferring sockets over cores
> > when the -smp cmdline option is parsed, as stated in hw/i386/pc.c:729.
> > 
> > I guess this is the same code for Intel and AMD CPUs alike and this
> > issue just didn't surface for us on Intel CPUs, as they don't have this
> > CPUID leaf and we don't look at the topology.
> > 
> > This seems to boil down to a more careful use of the -smp option on my end.
> > 
> > Thanks again for looking into this.
> > 
> > Cheers,
> > Philipp
> > 
> > 
> > 
> > On 4/10/20 2:12 AM, Babu Moger wrote:  
> >> Philipp,
> >>   Can you please check if this patch works for you.
> >>
> >> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> >> index 90ffc5f..e467fee 100644
> >> --- a/target/i386/cpu.c
> >> +++ b/target/i386/cpu.c
> >> @@ -5831,10 +5831,17 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t
> >> index, uint32_t count,
> >>          }
> >>          *ebx = env->features[FEAT_8000_0008_EBX];
> >>          *ecx = 0;
> >> -        *edx = 0;
> >>          if (cs->nr_cores * cs->nr_threads > 1) {
> >> -            *ecx |= (cs->nr_cores * cs->nr_threads) - 1;
> >> +            unsigned long max_apicids, bits_required;
> >> +
> >> +            max_apicids = (cs->nr_cores * cs->nr_threads) - 1;
> >> +            if (max_apicids) {
> >> +                /* Find out the number of bits to represent all the
> >> apicids */
> >> +                bits_required = find_last_bit(&max_apicids,
> >> BITS_PER_BYTE) + 1;
> >> +                *ecx |= bits_required << 12 | max_apicids;
> >> +            }
> >>          }
> >> +        *edx = 0;
> >>          break;
> >>      case 0x8000000A:
> >>          if (env->features[FEAT_8000_0001_ECX] & CPUID_EXT3_SVM) {
> >>
> >>
> >> On 4/9/20 9:00 AM, Igor Mammedov wrote:  
> >>> On Thu, 09 Apr 2020 12:58:11 -0000
> >>> Philipp Eppelt <1871842@bugs.launchpad.net> wrote:
> >>>  
> >>>> Public bug reported:
> >>>>
> >>>> Setup:
> >>>> CPU: AMD EPYC-v2 or host's EPYC cpu
> >>>> Linux 64-bit fedora host; Kernel version 5.5.15-200.fc31
> >>>> qemu version: self build
> >>>> git-head: f3bac27cc1e303e1860cc55b9b6889ba39dee587
> >>>> config: Configured with: '../configure' '--target-list=x86_64-softmmu,mips64el-softmmu,mips64-softmmu,mipsel-softmmu,mips-softmmu,i386-softmmu,aarch64-softmmu,arm-softmmu' '--prefix=/opt/qemu-master'
> >>>>
> >>>> Cmdline: 
> >>>> qemu-system-x86_64 -kernel /home/peppelt/code/l4/internal/.build-x86_64/bin/amd64_gen/bootstrap -append "" -initrd "./fiasco/.build-x86_64/fiasco , ... " -serial stdio -nographic -monitor none -nographic -monitor none -cpu EPYC-v2 -m 4G -smp 4 
> >>>>
> >>>> Issue:
> >>>> We are developing an microkernel operating system called L4Re. We recently got an AMD EPYC server for testing and we couldn't execute SMP tests of our system when running Linux + qemu + VM w/ L4Re.
> >>>> In fact, the kernel did not recognize any APs at all. On AMD CPUs the kernel checks for the number of cores reported in CPUID leaf 0x8000_0008.ECX[NC] or [ApicIdSize].  [0][1]
> >>>>
> >>>> The physical machine reports for leaf 0x8000_0008:  EAX: 0x3030 EBX: 0x18cf757 ECX: 0x703f EDX: 0x1000
> >>>> The lower four bits of ECX are the [NC] field and all set.
> >>>>
> >>>> When querying inside qemu with -enable-kvm -cpu host -smp 4 (basically as replacement and addition to the above cmdline) the CPUID leaf shows: EAX: 0x3024, EBX: 0x1001000, ECX: 0x0, EDX: 0x0
> >>>> Note, ECX is zero. Indicating that this is no SMP capabale CPU.
> >>>>
> >>>> I'm debugging it using my local machine and the QEMU provided EPYC-v2
> >>>> CPU model and it is reproducible there as well and reports:  EAX:
> >>>> 0x3028, EBX: 0x0, ECX: 0x0, EDX: 0x0
> >>>>
> >>>> I checked other AMD based CPU models (phenom, opteron_g3/g5) and they behave the same. [2] shows the CPUID 0x8000'0008 handling in the QEMU source.
> >>>> I believe that behavior here is wrong as ECX[NC] should report the number of cores per processor, as stated in the AMD manual [2] p.584. In my understanding -smp 4 should then lead to ECX[NC] = 0x3.
> >>>>
> >>>> The following table shows my findings with the -smp option:
> >>>> Option | Qemu guest observed ECX value
> >>>> -smp 4 | 0x0
> >>>> -smp 4,cores=4  | 0x3
> >>>> -smp 4,cores=2,thread=2 | 0x3
> >>>> -smp 4,cores=4,threads=2 | QEMU boot error: topology false.
> >>>>
> >>>> Now, I'm asking myself how the terminology of the AMD manual maps to QEMU's -smp option.
> >>>> Obviously, nr_cores and nr_threads correspond to the cores and threads options on the cmdline and cores * threads <= 4 (in this example), but what corresponds the X in -smp X to?  
> >>> I'd say X corresponds to number of logical CPUs.
> >>> Depending on presence of other options these are distributed among them in magical manner
> >>> (see pc_smp_parse() for starters)
> >>>  
> >>>> Querying 0x8000'0008 on the physical processor results in different
> >>>> reports than quering QEMU's model as does it with -enable-kvm -cpu host.
> >>>>
> >>>> Furthermore, the ACPI.MADT shows 4 local APICs to be present while the
> >>>> CPU leave reports a single core processor.  
> >>> it matches -smp X as it should be.
> >>>  
> >>>>
> >>>> This leads me to the conclusion that CPUID 0x8000'0008.ECX reports the
> >>>> wrong number.  
> >>> CCed author of recent epyc patches who might know how AMD should work better than me.
> >>>  
> >>>>
> >>>> Please let me know, if you need more information from my side.
> >>>>
> >>>>
> >>>> [0] https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgithub.com%2Fkernkonzept%2Ffiasco%2Fblob%2F522ccc5f29ab120213cf02d71328e2b879cbbd19%2Fsrc%2Fkern%2Fia32%2Fkernel_thread-ia32.cpp%23L109&amp;data=02%7C01%7Cbabu.moger%40amd.com%7C57569f7959744399655b08d7dc8e6e24%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637220379083511672&amp;sdata=hcFJzLAVQoIh5IN9CP%2F9cUQNOZoBnpRA6FliJur1wzQ%3D&amp;reserved=0
> >>>> [1] https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgithub.com%2Fkernkonzept%2Ffiasco%2Fblob%2F522ccc5f29ab120213cf02d71328e2b879cbbd19%2Fsrc%2Fkern%2Fia32%2Fcpu-ia32.cpp%23L1120&amp;data=02%7C01%7Cbabu.moger%40amd.com%7C57569f7959744399655b08d7dc8e6e24%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637220379083511672&amp;sdata=ANJIbYKbwfq2bDelH%2FRLKnDPIUZc1BwxHspmgxLU7gs%3D&amp;reserved=0
> >>>> [2] https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgithub.com%2Fqemu%2Fqemu%2Fblob%2Ff2a8261110c32c4dccd84e774d8dd7a0524e00fb%2Ftarget%2Fi386%2Fcpu.c%23L5835&amp;data=02%7C01%7Cbabu.moger%40amd.com%7C57569f7959744399655b08d7dc8e6e24%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637220379083511672&amp;sdata=oj3mv9e5YOzUsfUjXK44gC8LybyWgMKo8JBIrRR%2BmDA%3D&amp;reserved=0
> >>>> [3] https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fwww.amd.com%2Fsystem%2Ffiles%2FTechDocs%2F24594.pdf&amp;data=02%7C01%7Cbabu.moger%40amd.com%7C57569f7959744399655b08d7dc8e6e24%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637220379083511672&amp;sdata=7Yr3J9ihlqSqXCXKN5JJNTByO3NGI%2BGMz2EqBF2Y4hw%3D&amp;reserved=0
> >>>>
> >>>> ** Affects: qemu
> >>>>      Importance: Undecided
> >>>>          Status: New
> >>>>  
> >>>  
> >>  
> >   
> 


