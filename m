Received: from eggs.gnu.org ([2001:4830:134:3::10]:46735)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1ewmtL-0000vK-DW
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 06:47:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1ewmtI-00046i-CM
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 06:47:19 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:50460 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1ewmtI-00046C-5U
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 06:47:16 -0400
References: <20171124134644.490-1-otubo@redhat.com>
	<1d5665fa-f425-25b5-041e-5f226192296c@redhat.com>
	<20171127084035.GA2718@vader>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <a04427bc-3f63-9eda-dfcb-2702c4e7efcd@redhat.com>
Date: Fri, 16 Mar 2018 11:46:57 +0100
MIME-Version: 1.0
In-Reply-To: <20171127084035.GA2718@vader>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCHv3] dma/i82374: avoid double creation of
 i82374 device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Otubo <otubo@redhat.com>
Cc: ehabkost@redhat.com, armbru@redhat.com, mjt@tls.msk.ru, agraf@suse.de, qemu-devel@nongnu.org, pbonzini@redhat.com

On 27.11.2017 09:40, Eduardo Otubo wrote:
> On Fri, Nov 24, 2017 at 06:44:59PM +0100, Thomas Huth wrote:
>>  Hi Eduardo,
>>
>> On 24.11.2017 14:46, Eduardo Otubo wrote:
>>> v3:
>>>  * Removed all unecessary local_err
>>>  * Change return of isa_bus_dma() and DMA_init() from void to int8_t,
>>>    returning -EBUSY on error and 0 on success
>>>  * Added qdev_cleanup_nofail() in case isa_bus_dma() returns error. The
>>>    cleanup looks safe, but please review if I didn't miss any detail
>>>
>>> v2:
>>>  * Removed user_creatable=false and replaced by error handling using
>>>    Error **errp and error_propagate();
>>
>> Version changelog should go below the "---" separator, otherwise it will
>> be included in the git changelog as well, which is kind of ugly.
>>
>>> QEMU fails when used with the following command line:
>>>
>>>     ./ppc64-softmmu/qemu-system-ppc64 -S -machine 40p,accel=tcg -device i82374
>>>     qemu-system-ppc64: hw/isa/isa-bus.c:110: isa_bus_dma: Assertion `!bus->dma[0] && !bus->dma[1]' failed.
>>>     Aborted (core dumped)
>>>
>>> The 40p machine type already created the device i82374. If specified in the
>>> command line, it will try to create it again, hence generating the error. The
>>> function isa_bus_dma() isn't supposed to be called twice for the same bus. One
>>> way to avoid this problem is to set user_creatable=false.
>>
>> You don't do that user_creatable=false here anymore, so please remove it
>> from the description.
>>
>>> A possible fix in a near future would be making
>>> isa_bus_dma()/DMA_init()/i82374_realize() return an error instead of asserting
>>> as well.
>>
>> You should rephrase that sentence as well.
>>
> 
> Well, I think one mistake lead to another here. I've always put the changelog
> before the --- and that's why the old commit message. For example:
> 2f668be77501c0232a84aafb6a066c9915987f0e. But I guess on that context it made
> sense to use the changelog since the commit message was too simplistic. I'm
> gonna fix this on the v3 then, among other thigs that I need to fix. Thanks for
> the heads up :)

 Hi,

did you ever send a v4? The problem seems still to persist...

 Thomas
