Received: from eggs.gnu.org ([2001:4830:134:3::10]:54447)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dBHNV-0003aP-KX
	for qemu-devel@nongnu.org; Thu, 18 May 2017 05:05:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dBHNR-0002Ce-L1
	for qemu-devel@nongnu.org; Thu, 18 May 2017 05:05:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47256)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1dBHNR-0002Bc-Bi
	for qemu-devel@nongnu.org; Thu, 18 May 2017 05:05:45 -0400
References: <1495035337-13337-1-git-send-email-thuth@redhat.com>
	<0721f18a-fc66-0be3-7462-76eb60de7f55@redhat.com>
	<394772e4-949a-b92f-6879-7b9e343e10d3@redhat.com>
	<0cb4c90d-cfcc-3d12-44b5-c979f20ec7b9@redhat.com>
	<d352caf1-90c5-558c-1d25-cfd91d4e24fc@de.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <47701282-594e-8ddd-9969-25097be0d77d@redhat.com>
Date: Thu, 18 May 2017 11:05:37 +0200
MIME-Version: 1.0
In-Reply-To: <d352caf1-90c5-558c-1d25-cfd91d4e24fc@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC PATCH] target/s390x/cpu_models: Set some
 additional feature bits for the "qemu" CPU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christian Borntraeger <borntraeger@de.ibm.com>, David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>
Cc: mmarek@suse.com, mbenes@suse.cz, Aurelien Jarno <aurelien@aurel32.net>, "Jason J. Herne" <jjherne@linux.vnet.ibm.com>

On 18.05.2017 11:00, Christian Borntraeger wrote:
> On 05/18/2017 10:48 AM, David Hildenbrand wrote:
>> On 18.05.2017 03:55, Thomas Huth wrote:
>>> On 17.05.2017 18:49, David Hildenbrand wrote:
>>>> On 17.05.2017 17:35, Thomas Huth wrote:
>>>>> Currently we only present the plain z900 feature bits to the guest,
>>>>> but QEMU already emulates some additional features (but not all of
>>>>> the next CPU generation, so we can not use the next CPU level as
>>>>> default yet). Since newer Linux kernels are checking the feature bits
>>>>> and refuse to work if a required feature is missing, we should present
>>>>> as much of the supported features as possible when we are running
>>>>> with the default "qemu" CPU.
>>>>> This patch now adds the "stfle", "extended immediate" and "stckf"
>>>>> facility bits to the "qemu" CPU, which are already supported facilities.
>>>>> It is unfortunately still not enough to run e.g. recent Fedora kernels,
>>>>> but at least it's a first step into the right direction.
>>>>>
>>>>
>>>> Three things:
>>>>
>>>> 1. Should we care about backwards compatibility? I think so. This should
>>>> be fixed up using compat machine properties. (qemu model is a
>>>> migration-safe model and could e.g. be used in KVM setups, too).
>>>
>>> Theoretically, I agree, but do we really care about backwards
>>> compatibility at this point in time? All major distro kernels (except
>>> Debian, I think) currently do not work in QEMU, so there is currently
>>> not that much that can be migrated...
>>> And currently, the "qemu" CPU is the very same as the "z900" CPU, so you
>>> might also get along with simply using "-cpu z900" on the destination
>>> instead, I guess.
>>
>> If possible, I would like to avoid changing migration safe CPU model.
>> And I guess it shouldn't be too hard for now (unless we really change
>> the base model to e.g. a z9, then some more work might have to be done)
>>
>> I think for now, setting "stfle=off" on "s390-cpu-qemu" for compat
>> machines should do the trick.
>>
>>>
>>>> 2. I would recommend to not enable STFLE for now. Why?
>>>>
>>>> It is/was an indication that the system is running on a z9 (and
>>>> implicitly has the basic features). This was not only done because
>>>> people were lazy, but because this bit was implicitly connected to other
>>>> machine properties.
>>>
>>> Uh, that's ugly!
>>>
>>>> One popular example is the "DAT-enhancement facility 2". It introduced
>>>> the "LOAD PAGE TABLE ENTRY ADDRESS" instruction, but no facility bit was
>>>> introduced. SO there is no way to check if the instruction is available
>>>> and actually working.
>>>
>>> Does the Linux kernel use this instruction at all? I just grep'ed
>>> through the kernel sources and did not find it. If the Linux kernel does
>>> not use it, I think we should ignore this interdependency and just
>>> provide the STFLE feature bit to the guest - since recent Linux kernels
>>> depend on it.
>>
>> Yes, current linux doesn't use it, I don't remember if previous versions
>> did. Most likely not. The question is if they relied on the stfle==z9
>> assumption. The STFLE facility really is special in that sense.
>>
>>>
>>>> Please note that we added a feature representation for this facility,
>>>> because this would allow us later on to at least model removal of such a
>>>> facility (if HW actually would drop it) on a CPU model level.
>>>
>>> What about STFLE bit 78, according to my version of the POP, it says:
>>>
>>> "The enhanced-DAT facility 2 is installed in the
>>>  z/Architecture architectural mode."
>>>
>>> ?
>>
>> As Aurelien already mentioned, there seemed to be different ways to
>> enhance DAT :) enhanced-DAT facility 2 is 2GB page support.
>>
>>>
>>>> 3. This introduces some inconsistency. s390x/cpu_models.c:set_feature()
>>>> explicitly tests for such inconsistencies.
>>>>
>>>> So your QEMU CPU model would have a feature, but you would not be able
>>>> to run that model using QEMU when manually specifying it on the command
>>>> line. Especially, expanding the "qemu" model and feeding it back to QEMU
>>>> will fail.
>>>
>>> I've checked that I can also successfully disable the features again at
>>> the command line, using "-cpu qemu,eimm=false" for example, so not sure
>>> what exactly you're talking about here. Could you please elaborate?
>>
>> Assume libvirt/the user expands the CPU model name "qemu" via
>> "qmp-expand-cpu-model "qemu", you will get something like
>>
>> "z900-base,.....,stfle=on"
>>
>> If you feed that to QEMU using "-cpu z900-base,...,stfle=on", QEMU will
>> detect the inconsistency when setting the property and abort. However,
>> "-cpu qemu" will succeed. Please note that these checks actually make
>> sense for KVM:
>>
> 
> Jason (now on cc) has a patch prepared for other reasons that disabled features
> for given machines. I kept the ESOP example in that patch.
> That would allow us to disable STFLE for old machines but enable it for 2.10
[...]
> Maybe we should split that out and merge such a patch sooner than the
> (yet in development) other changes?

Yes, that sounds like a good idea, I think we could use the same
mechanism here, too, so please split it out and submit it earlier!

 Thanks a lot,
  Thomas
