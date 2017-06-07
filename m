Received: from eggs.gnu.org ([2001:4830:134:3::10]:55567)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maozy.fnst@cn.fujitsu.com>) id 1dIXMV-00061Z-PP
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 05:34:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <maozy.fnst@cn.fujitsu.com>) id 1dIXMR-0004gX-71
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 05:34:47 -0400
Received: from [59.151.112.132] (port=32287 helo=heian.cn.fujitsu.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maozy.fnst@cn.fujitsu.com>) id 1dIXMQ-0004ff-Qj
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 05:34:43 -0400
References: <cover.1496746390.git.maozy.fnst@cn.fujitsu.com>
	<3579e47c4bb41476406e26685292aaa9153fcc77.1496746391.git.maozy.fnst@cn.fujitsu.com>
	<20170606145250.GG5016@thinpad.lan.raisama.net>
	<a6e6a698-ab28-b956-b13d-d75c9c203838@cn.fujitsu.com>
	<87a85k46sb.fsf@dusky.pond.sub.org>
From: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>
Message-ID: <9c29fcc1-9997-f4c9-53da-cbbb11182b87@cn.fujitsu.com>
Date: Wed, 7 Jun 2017 17:33:16 +0800
MIME-Version: 1.0
In-Reply-To: <87a85k46sb.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 5/7] pci: Make errp the last parameter
 of pci_add_capability()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>, mst@redhat.com, jasowang@redhat.com, qemu-devel@nongnu.org, marcel@redhat.com, alex.williamson@redhat.com, dmitry@daynix.com, pbonzini@redhat.com, rth@twiddle.net

Hi, Markus

On 06/07/2017 03:05 PM, Markus Armbruster wrote:
> Mao Zhongyi <maozy.fnst@cn.fujitsu.com> writes:
>
>> Hi, Eduardo
>>
>> On 06/06/2017 10:52 PM, Eduardo Habkost wrote:
>>> On Tue, Jun 06, 2017 at 07:26:30PM +0800, Mao Zhongyi wrote:
>>>> Add Error argument for pci_add_capability() to leverage the errp
>>>> to pass info on errors. This way is helpful for its callers to
>>>> make a better error handling when moving to 'realize'.
> [...]
>>>> diff --git a/hw/pci/pci.c b/hw/pci/pci.c
>>>> index b73bfea..2bba37a 100644
>>>> --- a/hw/pci/pci.c
>>>> +++ b/hw/pci/pci.c
>>>> @@ -2264,15 +2264,13 @@ static void pci_del_option_rom(PCIDevice *pdev)
>>>>   * in pci config space
>>>>   */
>>>>  int pci_add_capability(PCIDevice *pdev, uint8_t cap_id,
>>>> -                       uint8_t offset, uint8_t size)
>>>> +                       uint8_t offset, uint8_t size,
>>>> +                       Error **errp)
>>>>  {
>>>>      int ret;
>>>> -    Error *local_err = NULL;
>>>>
>>>> -    ret = pci_add_capability2(pdev, cap_id, offset, size, &local_err);
>>>> -    if (ret < 0) {
>>>> -        error_report_err(local_err);
>>>> -    }
>>>> +    ret = pci_add_capability2(pdev, cap_id, offset, size, errp);
>>>> +
>>>>      return ret;
>>>>  }
>>>
>>> pci_add_capability() and pci_add_capability2() now do exactly the
>>> same, why are both being kept?  I suggest replacing
>>> pci_add_capability2() with pci_add_capability() everywhere (on a
>>> separate patch).
>>>
>>
>> Completely remove pci_add_capability and direct use pci_add_capability2()
>> everywhere is it a more thorough way?
>
> You're converting pci_add_capability() to Error because you need the
> Error for your conversions to realize().

it's true.

>
> I recommend to change the calls where you need the Error (and only
> these) to call pci_add_capability2() instead.
>
> When no calls to pci_add_capability() remain, we remove it.  If that
> becomes the case in your series, you remove it.
>
> Okay?

This is a gentle way of doing it. After read the code I found only
parts need to be replaced by pci_add_capability2() in my series as
follow your advice, this is no problem. But it means that the remaining
replacement will be reworked in the future, although it can be fixed
absolutely in a separate patch now. Of course, this is just my own
opinion, consider the reason for git history I would rather hear your
advice. :)

Thanks
Mao
