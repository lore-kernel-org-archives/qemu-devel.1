Received: from eggs.gnu.org ([2001:4830:134:3::10]:54664)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1fEd79-0001y0-6v
	for qemu-devel@nongnu.org; Fri, 04 May 2018 11:59:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1fEd76-000181-5Q
	for qemu-devel@nongnu.org; Fri, 04 May 2018 11:59:19 -0400
References: <20180504042044.10318-1-mdroth@linux.vnet.ibm.com>
	<20180504113724.64b7b1c0@bahia.lan>
	<152543629398.15508.17426624020859105239@sif>
	<20180504155028.75f1ad45@bahia.lan>
From: Laurent Vivier <lvivier@redhat.com>
Message-ID: <8f8e9939-fae0-46dd-87b6-b461d3ce89af@redhat.com>
Date: Fri, 4 May 2018 17:59:04 +0200
MIME-Version: 1.0
In-Reply-To: <20180504155028.75f1ad45@bahia.lan>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH] target/ppc: only save guest
 timebase once after stopping
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>, Michael Roth <mdroth@linux.vnet.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, qemu-stable@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, Paolo Bonzini <pbonzini@redhat.com>

On 04/05/2018 15:50, Greg Kurz wrote:
> On Fri, 04 May 2018 07:18:13 -0500
> Michael Roth <mdroth@linux.vnet.ibm.com> wrote:
> 
>> Quoting Greg Kurz (2018-05-04 04:37:24)
>>> On Thu,  3 May 2018 23:20:44 -0500
>>> Michael Roth <mdroth@linux.vnet.ibm.com> wrote:
>>>   
>>>> In some cases (e.g. spapr) we record guest timebase after qmp_stop()
>>>> via a runstate hook so we can restore it on qmp_cont(). If a migration
>>>> occurs in between those events we end up saving it again, this time
>>>> based on the current timebase the guest would be seeing had it been
>>>> running. This has the effect of advancing the guest timebase while
>>>> it is stopped, which is not what the code intends.
>>>>   
>>>
>>> Hi Mike,
>>>
>>> The current behavior was introduced by:
>>>
>>> commit 42043e4f1241eeb77f87f5816b5cf0b6e9583ed7
>>> Author: Laurent Vivier <lvivier@redhat.com>
>>> Date:   Fri Jan 27 13:24:58 2017 +0100
>>>
>>>     spapr: clock should count only if vm is running
>>>
>>> and we have this in the changelog:
>>>
>>>     We keep timebase_pre_save to reduce the clock difference on
>>>     migration like in:
>>>         6053a86 kvmclock: reduce kvmclock difference on migration
>>>
>>>
>>> So your patch totally negates ^^ ? Also, I can't see a case where  
>>
>> Yah... this is a bit confusing. On one hand, the patch/summary is clearly
>> trying to avoid the guest time from advancing while it is stopped, which
>> is in the spirit of this patch. But at the same time it is trying to
>> compensate for loss of time (relative to host) due to downtime window.
>>
> 
> Yeah... not sure why Laurent decided to address both in the same patch...
> maybe just because we already had the pre_save hook ?

Well, it seemed to be a good idea to do like it is done for x86 [1]

But I think you should remove the timebase_pre_save() function (and the
comment) instead of adding a new flag.

Thanks,
Laurent

[1] the idea was proposed by Paolo:
https://lists.gnu.org/archive/html/qemu-devel/2017-01/msg05862.html
