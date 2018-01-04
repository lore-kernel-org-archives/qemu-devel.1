Received: from eggs.gnu.org ([2001:4830:134:3::10]:43232)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <gengdongjiu@huawei.com>) id 1eWxZU-0002Ro-4A
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 23:56:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <gengdongjiu@huawei.com>) id 1eWxZP-0005WS-GM
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 23:56:04 -0500
Received: from [45.249.212.35] (port=59898 helo=huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <gengdongjiu@huawei.com>)
	id 1eWxZP-0005Po-4A
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 23:55:59 -0500
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.59])
	by Forcepoint Email with ESMTP id 7569173CE8CD
	for <qemu-devel@nongnu.org>; Thu,  4 Jan 2018 12:55:51 +0800 (CST)
References: <1514440458-10515-1-git-send-email-gengdongjiu@huawei.com>
	<1514440458-10515-8-git-send-email-gengdongjiu@huawei.com>
	<20171228155310.312e95bb@igors-macbook-pro.local>
	<fc9e6c01-3334-f79c-5416-499177234044@huawei.com>
	<20180103143618.322b1b33@redhat.com>
From: gengdongjiu <gengdongjiu@huawei.com>
Message-ID: <d396b171-5710-bf90-b60f-2b0efb7e7239@huawei.com>
Date: Thu, 4 Jan 2018 12:55:44 +0800
MIME-Version: 1.0
In-Reply-To: <20180103143618.322b1b33@redhat.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v14 7/9] ARM: ACPI: Add GPIO notification
 type for hardware RAS error
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

On 2018/1/3 21:36, Igor Mammedov wrote:
> On Wed, 3 Jan 2018 11:48:30 +0800
> gengdongjiu <gengdongjiu@huawei.com> wrote:
> 
>> On 2017/12/28 22:53, Igor Mammedov wrote:
>>> On Thu, 28 Dec 2017 13:54:16 +0800
>>> Dongjiu Geng <gengdongjiu@huawei.com> wrote:
> [...]
>>>> +static void acpi_dsdt_add_error_device(Aml *scope)
>>>> +{
>>>> +    Aml *dev = aml_device(ACPI_HARDWARE_ERROR_DEVICE);
>>>> +    Aml *method;
>>>> +
>>>> +    aml_append(dev, aml_name_decl("_HID", aml_eisaid("PNP0C33")));
>>>> +    aml_append(dev, aml_name_decl("_UID", aml_int(0)));
>>>> +
>>>> +    method = aml_method("_STA", 0, AML_NOTSERIALIZED);
>>>> +    aml_append(method, aml_return(aml_int(0x0f)));  
>>> no need for dummy _STA method, device is assumed to be present if there is no _STA   
>> Igor,
>>   do you mean remove above two line code as shown in [1]?
>> I dump the DSDT table in my host Ubuntu PC for the error device (PNP0C33), it has the _STA, as shown in [2].
>> do we not want to add the _STA for guest?
>>
>> [1]
>> +    method = aml_method("_STA", 0, AML_NOTSERIALIZED);
>> +    aml_append(method, aml_return(aml_int(0x0f)));
> compared to host, yours method does nothing,
> read ACPI6.2 "6.3.7 _STA (Status)" one more time
Thanks for the pointing out.
yes, you are right. As the spec statement[1], Device is assumed to be present if there is no _STA.

[1]:
ACPI6.2 "6.3.7 _STA (Status), Return Value Information"
If a device object (including the processor object) does not have an _STA object, then OSPM
assumes that all of the above bits are set (i.e., the device is present, enabled, shown in the UI,
and functioning).

> 
>> [2]:
>>         Device (WERR)
>>         {
>>             Name (_HID, EisaId ("PNP0C33"))  // _HID: Hardware ID
>>             Method (_STA, 0, NotSerialized)  // _STA: Status
>>             {
>>                 If (LGreaterEqual (OSYS, 0x07D9))
>>                 {
>>                     Return (0x0F)
>>                 }
>>                 Else
>>                 {
>>                     Return (Zero)
>>                 }
>>             }
>>         }
>>>   
>>>> +    aml_append(dev, method);
>>>> +    aml_append(scope, dev);
>>>> +}
>>>> +
> [...]
> 
> 
> .
> 
