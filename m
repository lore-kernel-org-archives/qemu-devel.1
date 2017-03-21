Received: from eggs.gnu.org ([2001:4830:134:3::10]:49086)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <caoj.fnst@cn.fujitsu.com>) id 1cqEey-0003FO-Pf
	for qemu-devel@nongnu.org; Tue, 21 Mar 2017 03:56:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <caoj.fnst@cn.fujitsu.com>) id 1cqEev-0007a6-Re
	for qemu-devel@nongnu.org; Tue, 21 Mar 2017 03:56:52 -0400
Received: from [59.151.112.132] (port=26472 helo=heian.cn.fujitsu.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <caoj.fnst@cn.fujitsu.com>) id 1cqEev-0007Y0-Ew
	for qemu-devel@nongnu.org; Tue, 21 Mar 2017 03:56:49 -0400
References: <1488180523-18137-1-git-send-email-caoj.fnst@cn.fujitsu.com>
	<20170313160619.28622002@t450s.home> <58CFD01F.1060508@cn.fujitsu.com>
	<20170320083056.3f2a5603@t450s.home>
From: Cao jin <caoj.fnst@cn.fujitsu.com>
Message-ID: <58D0DEC8.6080507@cn.fujitsu.com>
Date: Tue, 21 Mar 2017 16:05:28 +0800
MIME-Version: 1.0
In-Reply-To: <20170320083056.3f2a5603@t450s.home>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] vfio pci: kernel support of error recovery
 only for non fatal error
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, qemu-devel@nongnu.org, mst@redhat.com, izumi.taku@jp.fujitsu.com



On 03/20/2017 10:30 PM, Alex Williamson wrote:
> On Mon, 20 Mar 2017 20:50:39 +0800
> Cao jin <caoj.fnst@cn.fujitsu.com> wrote:
> 
>> Sorry for late.
>>
>> On 03/14/2017 06:06 AM, Alex Williamson wrote:
>>> On Mon, 27 Feb 2017 15:28:43 +0800
>>> Cao jin <caoj.fnst@cn.fujitsu.com> wrote:
>>>   
>>>> 0. What happens now (PCIE AER only)
>>>>    Fatal errors cause a link reset.
>>>>    Non fatal errors don't.
>>>>    All errors stop the VM eventually, but not immediately
>>>>    because it's detected and reported asynchronously.
>>>>    Interrupts are forwarded as usual.
>>>>    Correctable errors are not reported to guest at all.
>>>>    Note: PPC EEH is different. This focuses on AER.  
>>>
>>> Perhaps you're only focusing on AER, but don't the error handlers we're
>>> using support both AER and EEH generically?  I don't think we can
>>> completely disregard how this affects EEH behavior, if at all.
>>>   
>>
>> After taking a rough look at the EEH,  find that EEH always feed
>> error_detected with pci_channel_io_frozen, from perspective of
>> error_detected, EEH is not affected.  
>>
>> I am not sure about a question: when assign devices in spapr host,
>> should all functions/devices in a PE be bound to vfio? I am kind of
>> confused about the relationship between a PE & a tce iommu group
> 
> AIUI, yes all devices within the PE are part of the same IOMMU group
> and therefore all endpoints must be bound to vfio or pci-stub.
> 

Thanks. Then I think this approach won't affect EEH. I was considering
the same issue you mentioned for slot_reset may affect EEH, but if they
all must be bound to vfio, seems the issue won't happen to EEH.

-- 
Sincerely,
Cao jin
