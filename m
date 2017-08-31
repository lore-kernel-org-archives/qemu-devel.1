Received: from eggs.gnu.org ([2001:4830:134:3::10]:50111)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dnQjI-0007jW-Iz
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 10:46:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dnQj9-0007dX-0O
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 10:46:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59534)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1dnQj8-0007dL-MR
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 10:45:50 -0400
References: <20170830170601.15855-1-david@redhat.com>
	<20170830170601.15855-4-david@redhat.com>
	<09179efb-0930-bd84-ff22-1f4b23fa6a8e@redhat.com>
	<55b99307-b817-1cb2-f5c8-901b877735cc@redhat.com>
	<63bc0433-dd9f-2b75-7885-5460949c821b@redhat.com>
	<8a4d349c-33c5-0e63-d11b-274d64e854fa@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <5d498419-06b7-8de2-0b3e-014de0f3be71@redhat.com>
Date: Thu, 31 Aug 2017 16:45:44 +0200
MIME-Version: 1.0
In-Reply-To: <8a4d349c-33c5-0e63-d11b-274d64e854fa@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 03/11] s390x: store cpu states inside
 machine state
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, Aurelien Jarno <aurelien@aurel32.net>, cohuck@redhat.com, borntraeger@de.ibm.com, Alexander Graf <agraf@suse.de>

On 31.08.2017 16:36, David Hildenbrand wrote:
> On 31.08.2017 16:31, Thomas Huth wrote:
>> On 31.08.2017 16:23, David Hildenbrand wrote:
>>>
>>>>> +struct S390CPU;
>>>>
>>>> You define a "struct S390CPU" here ...
>>>>
>>>>>  typedef struct S390CcwMachineState {
>>>>>      /*< private >*/
>>>>>      MachineState parent_obj;
>>>>>  
>>>>>      /*< public >*/
>>>>> +    S390CPU **cpus;
>>>>
>>>> ... but use the typedef'ed S390CPU here ... looks somewhat suspicious, I
>>>> wonder whether the typedef is really in the right place?
>>>
>>> General question: how much do we care about headers that are not consistent?
>>>
>>> E.g. shall I forward declare or simply ignore if compilers don't bite me?
>>
>> My remark was not so much about your patch, but about the original
>> definition instead: "struct S390CPU" is declared in target/s390x/cpu.h,
>> but "typedef struct S390CPU S390CPU" is in target/s390x/cpu-qom.h. I
>> think they should rather be declared in the same header file instead. Or
> 
> I agree, will have a look.
> 
>> your "struct S390CPU;" forward declaration should go into cpu-qom.h
>> instead, right in front of the typedef.
>>
> 
> Let me rephrase my question:
> 
> include/hw/s390x/s390-virtio-ccw.h does not include cpu.h/cpu-qom.h
> 
> If compilers don't complain, do we have to forward declare at all? (I
> think it is cleaner, but I would like to know what is suggested)

Well, doing a forward declaration with "struct S390CPU;" and then using
the typedef'd "S390CPU" without "struct" does not make much sense -
these are two "different" types. If you can use "S390CPU" here without
the "struct S390CPU;" declaration, that means the cpu-qom.h header got
included indirectly already - so I'd suggest to simply remove the
"struct S390CPU;" forward declaration from your patch.

 Thomas
