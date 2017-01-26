Received: from eggs.gnu.org ([2001:4830:134:3::10]:54509)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1cWfa1-0001PP-9B
	for qemu-devel@nongnu.org; Thu, 26 Jan 2017 03:38:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1cWfZw-0006tW-Dq
	for qemu-devel@nongnu.org; Thu, 26 Jan 2017 03:38:53 -0500
Received: from mout.kundenserver.de ([212.227.126.135]:62046)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1cWfZw-0006tG-3D
	for qemu-devel@nongnu.org; Thu, 26 Jan 2017 03:38:48 -0500
References: <1485377117-18105-1-git-send-email-thuth@redhat.com>
	<f60c6090-0ca8-8ce9-8015-4e8e34123a5a@vivier.eu>
	<CAKmqyKMyzquxEGTF4Un_1WvwBNXOoJU1g67_9fFarVy-yeff+Q@mail.gmail.com>
	<8a528a03-d97e-7c16-70f6-229b80563b2d@redhat.com>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <ed3e0263-ebe5-790b-b1a2-2af4d17a5a58@vivier.eu>
Date: Thu, 26 Jan 2017 09:38:37 +0100
MIME-Version: 1.0
In-Reply-To: <8a528a03-d97e-7c16-70f6-229b80563b2d@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] hw/core/generic-loader: Fix crash when
 running without CPU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, Alistair Francis <alistair.francis@xilinx.com>
Cc: "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>

Le 26/01/2017 à 06:50, Thomas Huth a écrit :
> On 26.01.2017 00:26, Alistair Francis wrote:
>> On Wed, Jan 25, 2017 at 12:52 PM, Laurent Vivier <laurent@vivier.eu> wrote:
>>> Le 25/01/2017 à 21:45, Thomas Huth a écrit :
>>>> When running QEMU with "-M none -device loader,file=kernel.elf", it
>>>> currently crashes with a segmentation fault, because the "none"-machine
>>>> does not have any CPU by default and the generic loader code tries
>>>> to dereference s->cpu. Fix it by adding an appropriate check for a
>>>> NULL pointer.
>>>>
>>>> Reported-by: Laurent Vivier <laurent@vivier.eu>
>>>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>>>> ---
>>>>  hw/core/generic-loader.c | 9 +++++----
>>>>  1 file changed, 5 insertions(+), 4 deletions(-)
>>>>
>>>> diff --git a/hw/core/generic-loader.c b/hw/core/generic-loader.c
>>>> index 58f1f02..4601267 100644
>>>> --- a/hw/core/generic-loader.c
>>>> +++ b/hw/core/generic-loader.c
>>>> @@ -137,20 +137,21 @@ static void generic_loader_realize(DeviceState *dev, Error **errp)
>>>>  #endif
>>>>
>>>>      if (s->file) {
>>>> +        AddressSpace *as = s->cpu ? s->cpu->as :  NULL;
>>>
>>> Should we just abort if s->cpu is NULL?
>>
>> I agree, what is the use case where you are loading images without a CPU?
>>
>> If there is a use case (maybe some KVM thing?) then this patch looks fine to me.
> 
> I think there is no real use case yet. But this fix is 1) simpler than
> doing an error_report() + exit() here, and 2) maybe the vision of
> constructing machines on the fly with QEMU will eventually come true one
> day in the distant future, so with that patch here, the code would
> already be prepared for the case when QEMU gets started without CPUs and
> the CPUs are then later added via QOM...
> Well, I don't mind ... if you prefer an error message instead, feel free
> to suggest another patch. I'm fine as long as we do not simply crash
> with a segmentation fault here.

OK, the use of NULL as "as" seems reasonable (this is what uses
load_elf()), so:

Reviewed-by: Laurent Vivier <laurent@vivier.eu>
