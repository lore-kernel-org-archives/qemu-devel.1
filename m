Return-Path: <SRS0=mi2X=WI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAE72C31E40
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Aug 2019 13:58:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8EB57206C2
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Aug 2019 13:58:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8EB57206C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45832 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hxAqY-0007IX-RG
	for qemu-devel@archiver.kernel.org; Mon, 12 Aug 2019 09:58:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58631)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <cohuck@redhat.com>) id 1hxAq9-0006hz-Uy
 for qemu-devel@nongnu.org; Mon, 12 Aug 2019 09:58:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cohuck@redhat.com>) id 1hxAq8-000236-QT
 for qemu-devel@nongnu.org; Mon, 12 Aug 2019 09:58:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57466)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cohuck@redhat.com>)
 id 1hxAq8-00021w-Gv; Mon, 12 Aug 2019 09:58:24 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 95DBEC075BD2;
 Mon, 12 Aug 2019 13:58:23 +0000 (UTC)
Received: from gondolin (dhcp-192-181.str.redhat.com [10.33.192.181])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1D2057D489;
 Mon, 12 Aug 2019 13:58:19 +0000 (UTC)
Date: Mon, 12 Aug 2019 15:58:17 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: David Hildenbrand <david@redhat.com>
Message-ID: <20190812155817.2edb133c.cohuck@redhat.com>
In-Reply-To: <94fc262e-b8d7-df09-1461-f10a9874d954@redhat.com>
References: <20190805152947.28536-1-david@redhat.com>
 <20190805152947.28536-2-david@redhat.com>
 <e68f8298-8946-37f1-2e65-afa73a45604e@redhat.com>
 <bbf905b3-6f32-c478-4e6e-81c341f5601a@redhat.com>
 <20190812154045.10393873.cohuck@redhat.com>
 <94fc262e-b8d7-df09-1461-f10a9874d954@redhat.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.31]); Mon, 12 Aug 2019 13:58:23 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH-for-4.2 v1 1/9] s390x/mmu: Better ASC
 selection in s390_cpu_get_phys_page_debug()
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
Cc: Thomas Huth <thuth@redhat.com>, Janosch Frank <frankja@linux.ibm.com>,
 qemu-devel@nongnu.org, Ilya Leoshkevich <iii@linux.ibm.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 12 Aug 2019 15:45:25 +0200
David Hildenbrand <david@redhat.com> wrote:

> On 12.08.19 15:40, Cornelia Huck wrote:
> > On Mon, 12 Aug 2019 09:52:56 +0200
> > David Hildenbrand <david@redhat.com> wrote:
> >   
> >> On 12.08.19 09:12, Thomas Huth wrote:  
> >>> On 8/5/19 5:29 PM, David Hildenbrand wrote:    
> >>>> Let's select the ASC before calling the function and use MMU_DATA_LOAD.
> >>>> This is a preparation to:
> >>>> - Remove the ASC magic depending on the access mode from mmu_translate
> >>>> - Implement IEP support, where we could run into access exceptions
> >>>>   trying to fetch instructions
> >>>>
> >>>> Signed-off-by: David Hildenbrand <david@redhat.com>
> >>>> ---
> >>>>  target/s390x/helper.c | 10 +++++++++-
> >>>>  1 file changed, 9 insertions(+), 1 deletion(-)
> >>>>
> >>>> diff --git a/target/s390x/helper.c b/target/s390x/helper.c
> >>>> index 13ae9909ad..08166558a0 100644
> >>>> --- a/target/s390x/helper.c
> >>>> +++ b/target/s390x/helper.c
> >>>> @@ -58,7 +58,15 @@ hwaddr s390_cpu_get_phys_page_debug(CPUState *cs, vaddr vaddr)
> >>>>          vaddr &= 0x7fffffff;
> >>>>      }
> >>>>  
> >>>> -    if (mmu_translate(env, vaddr, MMU_INST_FETCH, asc, &raddr, &prot, false)) {
> >>>> +    /*
> >>>> +     * We want to read the code, however, not run into access exceptions    
> >>>
> >>> Is this really a safe assumption here that we always use this to
> >>> translate code addresses and not data addresses? ... I don't think so.
> >>> For example with the "gva2gpa" HMP command, I'd rather expect that it
> >>> also works with the secondary space mode...?    
> >>
> >> Well, it's what current code does. I am not changing that behavior.  
> > 
> > Agreed, that is not actively breaking something.
> >   
> >>
> >> While it is in general broken to have a single interface to debug
> >> code+data (which is only a problem on s390x), it makes a lot of sense if
> >> you think about single-stepping through disassembled code using the
> >> gdbstub. Or dumping code where you crashed.  
> > 
> > What about the memsave interface?  
> 
> I guess the same problem:
> 
> "save to disk virtual memory dump starting at @var{addr} of size
> @var{size}" -  which virtual memory (code vs. data)? These old interface
> are really x86 specific (meaning: it made sense this way for x86)

So, the general verdict is "gnarly interface, but at least not broken
for Linux guests", I guess.

> 
> I'd like to note that if our KVM guest is in AR mode, we would now no
> longer be able to crash it :) (well, a nice side-effect of instruction
> fetches not going via AR mode).

Heh :)

Q: What do we need to consider beyond Linux guests? Probably not much,
given that they would be broken already...

