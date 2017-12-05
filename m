Received: from eggs.gnu.org ([2001:4830:134:3::10]:43621)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1eMA9R-0004s7-Lk
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 05:08:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1eMA9N-0005pY-Kt
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 05:08:33 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:33458)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.vnet.ibm.com>)
	id 1eMA9N-0005oO-DF
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 05:08:29 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	vB5A7ko2100410
	for <qemu-devel@nongnu.org>; Tue, 5 Dec 2017 05:08:26 -0500
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2enrfr2w73-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 05 Dec 2017 05:08:25 -0500
Received: from localhost
	by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.vnet.ibm.com>;
	Tue, 5 Dec 2017 10:08:23 -0000
References: <20171201143136.62497-1-pasic@linux.vnet.ibm.com>
	<20171201143136.62497-3-pasic@linux.vnet.ibm.com>
	<012d3c95-a552-9bfb-38c4-f1bab1bea854@redhat.com>
From: Halil Pasic <pasic@linux.vnet.ibm.com>
Date: Tue, 5 Dec 2017 11:08:18 +0100
MIME-Version: 1.0
In-Reply-To: <012d3c95-a552-9bfb-38c4-f1bab1bea854@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Message-Id: <c5a418db-a68b-52b6-7569-4b1bfd33dbbb@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH 2/3] s390x/css: advertise
 unrestricted cssids
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, Boris Fiuczynski <fiuczy@linux.vnet.ibm.com>, Cornelia Huck <cohuck@redhat.com>
Cc: Shalini Chellathurai Saroja <shalini@linux.vnet.ibm.com>, qemu-devel@nongnu.org, Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org, Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>



On 12/05/2017 09:28 AM, Thomas Huth wrote:
> On 01.12.2017 15:31, Halil Pasic wrote:
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
>> +            " or not (read only, always true)",
> 
> I'd maybe remove the "always true" in the description here, since that
> might create wrong assumptions with regards to future versions or lead
> to bad code in the upper layers. If someone reads "always true", they
> simply might omit the check of the value of this property. If we then
> ever want to change it to "false" again, we're in trouble (sure, we
> could simply completely remove the property again, but we have to
> remember to do that instead of setting it to false ... so let's better
> play safe right now already, ok?)
> 
>  Thomas
> 

Libvirt intends to check for the existence of the property and ignore
it's value. I've been told in Libvirt capabilities are usually tied
to existence. For inspecting the value one would have to work on an
instance. I don't think that would work with Libvirt's capability
probing scheme well.

So what you describe is basically like intended. I was not to document
always true though, but then Connie had a version with always true
and I got convinced it ain't a bad idea. If both Connie and you agree
that 'always true' is to be dropped I'm fine with dropping it.

Thanks for the review!

Halil
