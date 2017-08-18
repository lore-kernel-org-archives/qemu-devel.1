Received: from eggs.gnu.org ([2001:4830:134:3::10]:47530)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dil9P-0000CE-KS
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 13:33:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dil9M-0000Ro-I9
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 13:33:39 -0400
Received: from mail-qk0-x243.google.com ([2607:f8b0:400d:c09::243]:37688)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dil9M-0000Ra-Dx
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 13:33:36 -0400
Received: by mail-qk0-x243.google.com with SMTP id x77so9318953qka.4
	for <qemu-devel@nongnu.org>; Fri, 18 Aug 2017 10:33:36 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <cover.1501280035.git.alistair.francis@xilinx.com>
	<2897c32f34b415aadcf43a5ae296cf5f6e15e757.1501280035.git.alistair.francis@xilinx.com>
	<87valqw9x0.fsf@dusky.pond.sub.org>
	<CAKmqyKPA6v3RpZAFOibfNeOZVzai5phfXo2njDkD6PxsBgqVrw@mail.gmail.com>
	<87lgmluw2g.fsf@dusky.pond.sub.org>
	<ab184e25-19f5-5fd2-494a-7ea04e48f6c7@redhat.com>
	<87fucq86wh.fsf@dusky.pond.sub.org>
	<CAKmqyKOnhGZ6Ei+gSdmOBjHGpVt+G6_J4VF6GVkTCAt1_8GV4w@mail.gmail.com>
	<e7220fad-0b73-68af-20d4-6522789b17c3@amsat.org>
	<87efs95tkl.fsf@dusky.pond.sub.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <6a65e5ee-90f9-e1b2-3cc8-7c71d52118a3@amsat.org>
Date: Fri, 18 Aug 2017 14:33:32 -0300
MIME-Version: 1.0
In-Reply-To: <87efs95tkl.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 5/5] Convert single line fprintf() to
 warn_report()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: Alistair Francis <alistair.francis@xilinx.com>, Paolo Bonzini <pbonzini@redhat.com>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>

On 08/18/2017 02:32 AM, Markus Armbruster wrote:
> Philippe Mathieu-Daudé <f4bug@amsat.org> writes:
> 
>> On 08/17/2017 02:55 PM, Alistair Francis wrote:
>>>>> On 15/08/2017 09:30, Markus Armbruster wrote:
>>>>>> The stupid fix is to repeat libraries until the link succeeds:
>>>>>>
>>>>>>       test-util-obj-y = libqemuutil.a libqemustub.a libqemuutil.a
>>>>>>
>> [...]
>>>>>>
>>>>>> Sticking '-Wp,-(' and '-Wp,-)' into the command line I get from make V=1
>>>>>> doesn't work for me, though.
>>>>>>
>>>>>> The smart solution is not to have .a reference each other.
>>>>>
>>>>> Nah, I think we should teach those new kids on the block about -lX11
>>>>> instead. :)
>>>
>>> This sounds scary...
>>>
>>>>>
>>>>>> Paolo, what do you think?
>>>>>
>>>>> Another possibility is to just merge the two static libraries into one.
>>>>
>>>> Sounds good to me!
>>>
>>> I feel like I have opened a can of worms.
>>
>> you are good at it! IIRC it all started with a 1-line change in
>> tcp_chr_wait_connected() more than 2 months ago :)
>>
>>>
>>> I can try and combine libqemustub.a into libqemuutil.a is that the
>>> solution? I just want to make sure before I start this.
>>
>> IMHO your series is OK like this, add a "TODO remove once
>> libqemuutil.a circular dep is resolved" comment in the Makefile is
>> enough, and let this issue for another time.
> 
> I disagree.
> 
> If merging the two .a is beyond your reach (I hope it isn't), then the
> spot to mess up is this one:
> 
>      # TODO bla bla explain bla
>      test-util-obj-y = libqemuutil.a libqemustub.a libqemuutil.a
> 

I was talking about the first patch:

+tests/test-cutils$(EXESUF): tests/test-cutils.o util/cutils.o 
$(test-qom-obj-y)

not merging circularly :)
