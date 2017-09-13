Received: from eggs.gnu.org ([2001:4830:134:3::10]:34261)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1ds5xN-00072p-5Z
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 07:35:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1ds5xJ-0001AT-OT
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 07:35:49 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:36843)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.vnet.ibm.com>)
	id 1ds5xJ-00019B-FE
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 07:35:45 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v8DBZMPk120664
	for <qemu-devel@nongnu.org>; Wed, 13 Sep 2017 07:35:44 -0400
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2cy388t92g-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 13 Sep 2017 07:35:43 -0400
Received: from localhost
	by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.vnet.ibm.com>;
	Wed, 13 Sep 2017 12:35:41 +0100
References: <20170905111645.18068-1-pasic@linux.vnet.ibm.com>
	<20170905111645.18068-2-pasic@linux.vnet.ibm.com>
	<20170906141846.0be413fb.cohuck@redhat.com>
	<bd30a18f-6d22-e5a7-6e8c-08f628466cc4@linux.vnet.ibm.com>
	<20170906145158.252cf0cd.cohuck@redhat.com>
	<27c027c4-58b4-9031-648e-9fd2fa1e5fa8@linux.vnet.ibm.com>
	<20170913115335.58995e36.cohuck@redhat.com>
From: Halil Pasic <pasic@linux.vnet.ibm.com>
Date: Wed, 13 Sep 2017 13:35:36 +0200
MIME-Version: 1.0
In-Reply-To: <20170913115335.58995e36.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Message-Id: <e356920f-f35f-2dc8-bdf2-6febce2c340d@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH 1/5] s390x/css: introduce css data stream
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>, Pierre Morel <pmorel@linux.vnet.ibm.com>, qemu-devel@nongnu.org



On 09/13/2017 11:53 AM, Cornelia Huck wrote:
> On Mon, 11 Sep 2017 18:36:00 +0200
> Halil Pasic <pasic@linux.vnet.ibm.com> wrote:
> 
>> On 09/06/2017 02:51 PM, Cornelia Huck wrote:
>>>>>> +void ccw_dstream_init(CcwDataStream *cds, CCW1 const *ccw, ORB const *orb)
>>>>>> +{
>>>>>> +    /*
>>>>>> +     * We don't support MIDA (an optional facility) yet and we
>>>>>> +     * catch this earlier. Just for expressing the precondition.
>>>>>> +     */
>>>>>> +    assert(!(orb->ctrl1 & ORB_CTRL1_MASK_MIDAW));    
>>>>> I don't know, this is infrastructure, should it trust its callers? If
>>>>> you keep the assert, please make it g_assert().    
>>>>
>>>> Why g_assert? I think g_assert comes form a test framework, this is not
>>>> test code.  
>>> g_assert() is glib, no?
>>>   
>>
>> It lives in GLib > GLib Utilities > Testing:
>> https://developer.gnome.org/glib/stable/glib-Testing.html
>>
>> The description of "Testing" starts like this: "GLib provides a framework
>> for writing and maintaining unit tests in parallel to the code they are
>> testing. The API is designed according to established concepts found in
>> the other test frameworks (JUnit, NUnit, RUnit), which in turn is based
>> on smalltalk unit testing concepts."
>>
>> So yes, it's both glib and testing framework. This is why I
>> ask why should one use g_assert in not-unit-test code.
> 
> I have searched the archives, but unfortunately was not able to come to
> a conclusion. Checkpatch advises against using anything but g_assert or
> g_assert_not_reached in anything but test code, but that is because
> those other g_asserts can be made non-fatal. g_assert_not_reached does
> not seem to have a non-glib equivalent.
> 

I think the standard library equivalent of g_assert_not_reached is
assert(false).

Yeah, checkpatch does not advise against using g_assert and
g_assert_not_reached in non-test code, but it does not advise against
using standard lib assert.

> I have it somewhere in the back of my mind that g_assert should be
> preferred...
> 

OK, I will use g_assert.
