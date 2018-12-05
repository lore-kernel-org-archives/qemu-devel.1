Received: from eggs.gnu.org ([2001:4830:134:3::10]:38799)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1gUY9D-0006by-BO
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 09:27:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1gUY99-0000U6-Tj
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 09:27:31 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47740)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eric.auger@redhat.com>)
	id 1gUY99-0000QQ-3I
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 09:27:27 -0500
References: <154393964026.28192.13536237934563059985.stgit@gimli.home>
	<154394077749.28192.1229512133780284321.stgit@gimli.home>
	<83c490a2-7565-b95c-563f-fb73476e874f@redhat.com>
	<87d0qgrrd0.fsf@dusky.pond.sub.org>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <3821b727-a0ec-5f92-4ec9-f858322457bc@redhat.com>
Date: Wed, 5 Dec 2018 15:27:17 +0100
MIME-Version: 1.0
In-Reply-To: <87d0qgrrd0.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [for-4.0 PATCH v3 3/9] qapi: Define PCIe link
 speed and width properties
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: Geoffrey McRae <geoff@hostfission.com>, Alex Williamson <alex.williamson@redhat.com>, qemu-devel@nongnu.org

Hi Markus,

On 12/5/18 3:16 PM, Markus Armbruster wrote:
> Auger Eric <eric.auger@redhat.com> writes:
> 
>> Hi Alex,
>>
>> On 12/4/18 5:26 PM, Alex Williamson wrote:
>>> Create properties to be able to define speeds and widths for PCIe
>>> links.  The only tricky bit here is that our get and set callbacks
>>> translate from the fixed QAPI automagic enums to those we define
>>> in PCI code to represent the actual register segment value.
>>>
>>> Cc: Eric Blake <eblake@redhat.com>
>>> Cc: Markus Armbruster <armbru@redhat.com>
>>> Tested-by: Geoffrey McRae <geoff@hostfission.com>
>>> Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
>>> ---
>>>  hw/core/qdev-properties.c    |  178 ++++++++++++++++++++++++++++++++++++++++++
>>>  include/hw/qdev-properties.h |    8 ++
>>>  qapi/common.json             |   42 ++++++++++
>>>  3 files changed, 228 insertions(+)
>>>
>>> diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c
>>> index 35072dec1ecf..f5ca5b821a79 100644
>>> --- a/hw/core/qdev-properties.c
>>> +++ b/hw/core/qdev-properties.c
>>> @@ -1327,3 +1327,181 @@ const PropertyInfo qdev_prop_off_auto_pcibar = {
>>>      .set = set_enum,
>>>      .set_default_value = set_default_value_enum,
>>>  };
>>> +
>>> +/* --- PCIELinkSpeed 2_5/5/8/16 -- */
>>> +
>>> +static void get_prop_pcielinkspeed(Object *obj, Visitor *v, const char *name,
>>> +                                   void *opaque, Error **errp)
>>> +{
>>> +    DeviceState *dev = DEVICE(obj);
>>> +    Property *prop = opaque;
>>> +    PCIExpLinkSpeed *p = qdev_get_prop_ptr(dev, prop);
>>> +    PCIELinkSpeed speed;
>>> +
>>> +    switch (*p) {
>>> +    case QEMU_PCI_EXP_LNK_2_5GT:
>>> +        speed = PCIE_LINK_SPEED_2_5;
>>> +        break;
>>> +    case QEMU_PCI_EXP_LNK_5GT:
>>> +        speed = PCIE_LINK_SPEED_5;
>>> +        break;
>>> +    case QEMU_PCI_EXP_LNK_8GT:
>>> +        speed = PCIE_LINK_SPEED_8;
>>> +        break;
>>> +    case QEMU_PCI_EXP_LNK_16GT:
>>> +        speed = PCIE_LINK_SPEED_16;
>>> +        break;
>>> +    default:
>>> +        /* Unreachable */
>>> +        abort();
>> nit: g_assert_not_reached() here and below.
> 
> In my opinion, g_assert_not_reached() & friends are an overly ornate
> reinvention of an old and perfectly adequate wheel.
> 
> A long time ago for reasons since forgotten, the maintainers in charge
> back then demanded abort() instead of assert(0).  Either is fine with
> me.
> 
> I tolerate g_assert_not_reached() in files that already use g_assert().
> This one doesn't.
> 
> In any case, I'd drop the comment.

OK I did not know. In the past I was encouraged to use it.

Thanks

Eric
> 
> Note that I'm not this file's maintainer.
> 
> [...]
> 
