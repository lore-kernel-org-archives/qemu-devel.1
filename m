Received: from eggs.gnu.org ([2001:4830:134:3::10]:48570)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1eLsLR-0002E5-Jp
	for qemu-devel@nongnu.org; Mon, 04 Dec 2017 10:07:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1eLsLN-0007EG-JP
	for qemu-devel@nongnu.org; Mon, 04 Dec 2017 10:07:45 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:40688)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.vnet.ibm.com>)
	id 1eLsLN-0007Dg-Bi
	for qemu-devel@nongnu.org; Mon, 04 Dec 2017 10:07:41 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	vB4F70Um006825
	for <qemu-devel@nongnu.org>; Mon, 4 Dec 2017 10:07:35 -0500
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2en6re78n1-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 04 Dec 2017 10:07:34 -0500
Received: from localhost
	by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.vnet.ibm.com>;
	Mon, 4 Dec 2017 15:07:32 -0000
References: <20171201143136.62497-1-pasic@linux.vnet.ibm.com>
	<20171201143136.62497-3-pasic@linux.vnet.ibm.com>
	<20171204121511.0abe9ca2.cohuck@redhat.com>
From: Halil Pasic <pasic@linux.vnet.ibm.com>
Date: Mon, 4 Dec 2017 16:07:27 +0100
MIME-Version: 1.0
In-Reply-To: <20171204121511.0abe9ca2.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <f237126d-0815-8433-6ef7-1c1ba2e5a956@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH 2/3] s390x/css: advertise unrestricted
 cssids
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: Shalini Chellathurai Saroja <shalini@linux.vnet.ibm.com>, qemu-devel@nongnu.org, Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org, Boris Fiuczynski <fiuczy@linux.vnet.ibm.com>, Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>



On 12/04/2017 12:15 PM, Cornelia Huck wrote:
> On Fri,  1 Dec 2017 15:31:35 +0100
> Halil Pasic <pasic@linux.vnet.ibm.com> wrote:
> 
>> Let us advertise the changes introduced by "s390x/css: unrestrict cssids"
>> to the management software (so it can tell are cssids unrestricted or
>> restricted).
>>
>> Signed-off-by: Halil Pasic <pasic@linux.vnet.ibm.com>
>> ---
>>
>> Boris says having the property on the virtual-css-bridge is good form
>> Libvirt PoV. @Shalini: could you verify that things work out fine
>> (provided we get at least a preliminary blessing from Connie).
>>
>> Consider squashing into "s390x/css: unrestrict cssids".
>> ---
>>  hw/s390x/css-bridge.c | 11 +++++++++++
>>  1 file changed, 11 insertions(+)
>>
>> diff --git a/hw/s390x/css-bridge.c b/hw/s390x/css-bridge.c
>> index c4a9735d71..c7e8998680 100644
>> --- a/hw/s390x/css-bridge.c
>> +++ b/hw/s390x/css-bridge.c
>> @@ -123,6 +123,11 @@ static Property virtual_css_bridge_properties[] = {
>>      DEFINE_PROP_END_OF_LIST(),
>>  };
>>  
>> +static bool prop_get_true(Object *obj, Error **errp)
>> +{
>> +    return true;
>> +}
>> +
>>  static void virtual_css_bridge_class_init(ObjectClass *klass, void *data)
>>  {
>>      HotplugHandlerClass *hc = HOTPLUG_HANDLER_CLASS(klass);
>> @@ -131,6 +136,12 @@ static void virtual_css_bridge_class_init(ObjectClass *klass, void *data)
>>      hc->unplug = ccw_device_unplug;
>>      set_bit(DEVICE_CATEGORY_BRIDGE, dc->categories);
>>      dc->props = virtual_css_bridge_properties;
>> +    object_class_property_add_bool(klass, "cssid-unrestricted",
>> +                                   prop_get_true, NULL, NULL);
>> +    object_class_property_set_description(klass, "cssid-unrestricted",
>> +            "A css device can use any  cssid, regardless whether virtual"
> 
> extra space -----------------------------^
> 

Nod.

>> +            " or not (read only, always true)",

Do we need "." here ----------------------------^ ?

>> +            NULL);
>>  }
>>  
>>  static const TypeInfo virtual_css_bridge_info = {
> 
> Looks reasonable. If this works as expected, I'll squash it into the
> previous patch.
> 

I've just asked Shalini to verify the libvirt perspective.

Supposed we verify this works as expected, I read I don't have to spin
a v2 and you are going to fix the issues found yourself. Right?
