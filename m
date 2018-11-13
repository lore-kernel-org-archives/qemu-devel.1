Received: from eggs.gnu.org ([2001:4830:134:3::10]:60350)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1gMfJB-0002Qs-IN
	for qemu-devel@nongnu.org; Tue, 13 Nov 2018 15:29:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1gMfJA-00025F-Ct
	for qemu-devel@nongnu.org; Tue, 13 Nov 2018 15:29:13 -0500
References: <20181111094023.18038-1-mark.cave-ayland@ilande.co.uk>
	<96edc28b-1752-dc4e-ceb8-7078cb041392@redhat.com>
	<20181113131656.GD4830@localhost.localdomain>
From: John Snow <jsnow@redhat.com>
Message-ID: <6bda58a0-67ad-cb4d-37f5-b9ed3bb70278@redhat.com>
Date: Tue, 13 Nov 2018 15:29:03 -0500
MIME-Version: 1.0
In-Reply-To: <20181113131656.GD4830@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for-3.1] fdc: fix segfault in
 fdctrl_stop_transfer() when DMA is disabled
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org, mreitz@redhat.com, hpoussin@reactos.org, martin@duskware.de



On 11/13/18 8:16 AM, Kevin Wolf wrote:
> Am 12.11.2018 um 20:58 hat John Snow geschrieben:
>>
>>
>> On 11/11/18 4:40 AM, Mark Cave-Ayland wrote:
>>> Commit c8a35f1cf0f "fdc: use IsaDma interface instead of global DMA_*
>>> functions" accidentally introduced a segfault in fdctrl_stop_transfer() for
>>> non-DMA transfers.
>>>
>>> If fdctrl->dma_chann has not been configured then the fdctrl->dma interface
>>> reference isn't initialised during isabus_fdc_realize(). Unfortunately
>>> fdctrl_stop_transfer() unconditionally references the DMA interface when
>>> finishing the transfer causing a NULL pointer dereference.
>>>
>>> Fix the issue by adding a check in fdctrl_stop_transfer() so that the DMA
>>> interface reference and release method is only invoked if fdctrl->dma_chann
>>> has been set.
>>>
>>> (This issue was discovered by Martin testing a recent change in the NetBSD
>>> installer under qemu-system-sparc)
>>>
>>> Reported-by: Martin Husemann <martin@duskware.de>
>>> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
>>> ---
>>>  hw/block/fdc.c | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/hw/block/fdc.c b/hw/block/fdc.c
>>> index 2e9c1e1e2f..6f19f127a5 100644
>>> --- a/hw/block/fdc.c
>>> +++ b/hw/block/fdc.c
>>> @@ -1617,7 +1617,7 @@ static void fdctrl_stop_transfer(FDCtrl *fdctrl, uint8_t status0,
>>>      fdctrl->fifo[5] = cur_drv->sect;
>>>      fdctrl->fifo[6] = FD_SECTOR_SC;
>>>      fdctrl->data_dir = FD_DIR_READ;
>>> -    if (!(fdctrl->msr & FD_MSR_NONDMA)) {
>>> +    if (fdctrl->dma_chann != -1 && !(fdctrl->msr & FD_MSR_NONDMA)) {
>>>          IsaDmaClass *k = ISADMA_GET_CLASS(fdctrl->dma);
>>>          k->release_DREQ(fdctrl->dma, fdctrl->dma_chann);
>>>      }
>>>
>>
>> Thanks.
>>
>> Reviewed-by: John Snow <jsnow@redhat.com>
>>
>> ... Kevin, would you mind staging this one-off for the next RC?
> 
> No problem, I'm applying this to my block branch. However, my pull
> request for -rc1 is already merged, so this will have to wait until next
> week and -rc2.
> 
> Kevin
> 

I think that should be fine. Thank you!
