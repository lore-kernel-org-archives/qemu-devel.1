Received: from eggs.gnu.org ([209.51.188.92]:40927)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gw5vL-0005cN-Pb
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 08:59:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gw5vK-000717-IJ
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 08:59:03 -0500
References: <20190219115937.21587-1-stefanha@redhat.com>
	<2598979f-d8b5-4324-3ca4-f87802d4a9d1@redhat.com>
	<30c66aaa-2807-69cd-2395-dcd49e59b136@virtuozzo.com>
	<CAJSP0QVk-aisqUW8feav3XNLebC182TRY7LaMrVa-cP87n43ig@mail.gmail.com>
	<acd120ca-6e26-ab84-b0f7-39e0f2e56b75@redhat.com>
	<2cdd547c-0b67-8569-13cd-64e2c2c2a564@virtuozzo.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <57e56932-ccc7-a36e-ecfd-83f7bca2c4c4@redhat.com>
Date: Tue, 19 Feb 2019 14:58:42 +0100
MIME-Version: 1.0
In-Reply-To: <2cdd547c-0b67-8569-13cd-64e2c2c2a564@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH] iotests: drop unnecessary
 accel=kvm
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, Stefan Hajnoczi <stefanha@gmail.com>
Cc: Kevin Wolf <kwolf@redhat.com>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

On 19/02/2019 14.36, Vladimir Sementsov-Ogievskiy wrote:
> 19.02.2019 16:20, Thomas Huth wrote:
>> On 19/02/2019 14.07, Stefan Hajnoczi wrote:
>>> On Tue, Feb 19, 2019 at 12:12 PM Vladimir Sementsov-Ogievskiy
>>> <vsementsov@virtuozzo.com> wrote:
>>>> 19.02.2019 15:02, Thomas Huth wrote:
>>>>> On 19/02/2019 12.59, Stefan Hajnoczi wrote:
>>>>>> Tests 235 and 238 do not require the kvm accelerator.  TCG works fine.
>>>>>>
>>>>>> Use the default accelerator instead of requiring kvm.
>>>>>>
>>>>>> Suggested-by: Thomas Huth <thuth@redhat.com>
>>>>>> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
>>>>>> ---
>>>>>>    tests/qemu-iotests/235 | 1 -
>>>>>>    tests/qemu-iotests/238 | 1 -
>>>>>>    2 files changed, 2 deletions(-)
>>>>>>
>>>>>> diff --git a/tests/qemu-iotests/235 b/tests/qemu-iotests/235
>>>>>> index d6edd97ab4..329da8f0c2 100755
>>>>>> --- a/tests/qemu-iotests/235
>>>>>> +++ b/tests/qemu-iotests/235
>>>>>> @@ -49,7 +49,6 @@ qemu_img_create('-f', iotests.imgfmt, '-o', 'preallocation=metadata', disk,
>>>>>>                    str(size))
>>>>>>
>>>>>>    vm = QEMUMachine(iotests.qemu_prog)
>>>>>> -vm.add_args('-machine', 'accel=kvm')
>>>>>
>>>>> According to the initial commit log of 235:
>>>>>
>>>>>    "iotests: simple mirror test with kvm on 1G image"
>>>>>
>>>>> ... so I assume KVM was used on purpose here?
>>>>
>>>> As I remember kvm is not really necessary, and test have a comment about it:
>>>> # And it didn't reproduce if at least one of the following:
>>>> ...
>>>> # 3. drop kvm and use iotests.VM() (maybe, because of qtest) (however, it still
>>>> #    reproduces, if just drop kvm, but gdb failed to produce full backtraces
>>>> #    for me)
>>>>
>>>> But the comment should be updated with this patch.
>>>
>>> Will fix in v2.
>>
>> Any chance that you could even make it somehow work with -M accel=qtest
>> instead? ... in case someone compiled their QEMU with --disable-tcg, too
>> ...?
> 
> I didn't investigate why bug not reproduced with qtest.. I think, the simplest
> option should be a helper like iotests.needs_tcg(), to skip the test if
> it is unsupported.
> 
> Or you case is that kvm is OK for you but tcg is not? Stefan, do you have strong reason
> for removing kvm from iotests? Could it be something like
> 
>    if not iotests.supports_tcg():
>       vm.add_args('-machine', 'accel=kvm')
> 
> ?

You can also use "accel=kvm:tcg" which tries to use kvm first and then
falls back to tcg if KVM is not available.

I just have this weird condition where I try to compile qemu with
--disable-tcg, and then run the iotests on a CI system where KVM is also
not available at runtime. So qtest is the only available accelerator
there...

 Thomas
