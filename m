Received: from eggs.gnu.org ([2001:4830:134:3::10]:47154)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dIV1w-000094-Uy
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 03:05:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dIV1s-0006iO-Bj
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 03:05:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57718)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dIV1s-0006i3-5L
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 03:05:20 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <cover.1496746390.git.maozy.fnst@cn.fujitsu.com>
	<3579e47c4bb41476406e26685292aaa9153fcc77.1496746391.git.maozy.fnst@cn.fujitsu.com>
	<20170606145250.GG5016@thinpad.lan.raisama.net>
	<a6e6a698-ab28-b956-b13d-d75c9c203838@cn.fujitsu.com>
Date: Wed, 07 Jun 2017 09:05:08 +0200
In-Reply-To: <a6e6a698-ab28-b956-b13d-d75c9c203838@cn.fujitsu.com> (Mao
	Zhongyi's message of "Wed, 7 Jun 2017 13:33:51 +0800")
Message-ID: <87a85k46sb.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
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
To: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>, mst@redhat.com, jasowang@redhat.com, qemu-devel@nongnu.org, marcel@redhat.com, alex.williamson@redhat.com, dmitry@daynix.com, pbonzini@redhat.com, rth@twiddle.net

Mao Zhongyi <maozy.fnst@cn.fujitsu.com> writes:

> Hi, Eduardo
>
> On 06/06/2017 10:52 PM, Eduardo Habkost wrote:
>> On Tue, Jun 06, 2017 at 07:26:30PM +0800, Mao Zhongyi wrote:
>>> Add Error argument for pci_add_capability() to leverage the errp
>>> to pass info on errors. This way is helpful for its callers to
>>> make a better error handling when moving to 'realize'.
[...]
>>> diff --git a/hw/pci/pci.c b/hw/pci/pci.c
>>> index b73bfea..2bba37a 100644
>>> --- a/hw/pci/pci.c
>>> +++ b/hw/pci/pci.c
>>> @@ -2264,15 +2264,13 @@ static void pci_del_option_rom(PCIDevice *pdev)
>>>   * in pci config space
>>>   */
>>>  int pci_add_capability(PCIDevice *pdev, uint8_t cap_id,
>>> -                       uint8_t offset, uint8_t size)
>>> +                       uint8_t offset, uint8_t size,
>>> +                       Error **errp)
>>>  {
>>>      int ret;
>>> -    Error *local_err = NULL;
>>>
>>> -    ret = pci_add_capability2(pdev, cap_id, offset, size, &local_err);
>>> -    if (ret < 0) {
>>> -        error_report_err(local_err);
>>> -    }
>>> +    ret = pci_add_capability2(pdev, cap_id, offset, size, errp);
>>> +
>>>      return ret;
>>>  }
>>
>> pci_add_capability() and pci_add_capability2() now do exactly the
>> same, why are both being kept?  I suggest replacing
>> pci_add_capability2() with pci_add_capability() everywhere (on a
>> separate patch).
>>
>
> Completely remove pci_add_capability and direct use pci_add_capability2()
> everywhere is it a more thorough way?

You're converting pci_add_capability() to Error because you need the
Error for your conversions to realize().

I recommend to change the calls where you need the Error (and only
these) to call pci_add_capability2() instead.

When no calls to pci_add_capability() remain, we remove it.  If that
becomes the case in your series, you remove it.

Okay?
