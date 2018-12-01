Received: from eggs.gnu.org ([2001:4830:134:3::10]:41100)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <nicholas.a.hudson@gmail.com>) id 1gT5y2-0008P0-OZ
	for qemu-devel@nongnu.org; Sat, 01 Dec 2018 09:09:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <nicholas.a.hudson@gmail.com>) id 1gT5y1-00056r-V8
	for qemu-devel@nongnu.org; Sat, 01 Dec 2018 09:09:58 -0500
References: <fe1367d1-33f7-21fa-be84-20b9795a2157@gmail.com>
	<CAFEAcA_K6S2pB6cP+RHDZjeACU_ROJ6jkkG-2h7TCyiCkejRug@mail.gmail.com>
From: Nick Hudson <nicholas.a.hudson@gmail.com>
Message-ID: <da2ed5e8-d01b-2887-6015-d26e44eae095@gmail.com>
Date: Sat, 1 Dec 2018 14:09:52 +0000
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_K6S2pB6cP+RHDZjeACU_ROJ6jkkG-2h7TCyiCkejRug@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH v2] Support u-boot noload images for arm as
 used by, NetBSD/evbarm GENERIC kernel.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>


On 30/11/2018 17:18, Peter Maydell wrote:
> On Thu, 29 Nov 2018 at 20:22, Nick Hudson <nicholas.a.hudson@gmail.com> wrote:
>> noload kernels are loaded with the u-boot image header and as a result
>> the header size needs adding to the entry point.  Fake up a hdr so the
>> kernel image is loaded at the right address and the entry point is
>> adjusted appropriately.
>>
>> The bootloader fits in the space that the uboot header would have occupied.
>>
>> Update the load_uimage API to allow passing of load address when an image
>> doesn't specify one.
>>
>> Signed-off-by: Nick Hudson <skrll@netbsd.org>
>> ---
>> diff --git a/include/hw/loader.h b/include/hw/loader.h
>> index 67a0af84ac..10ff0ff76d 100644
>> --- a/include/hw/loader.h
>> +++ b/include/hw/loader.h
>> @@ -163,7 +163,8 @@ int load_aout(const char *filename, hwaddr addr, int max_sz,
>>   /** load_uimage_as:
>>    * @filename: Path of uimage file
>>    * @ep: Populated with program entry point. Ignored if NULL.
>> - * @loadaddr: Populated with the load address. Ignored if NULL.
>> + * @loadaddr: load address if none specified in the image. Populated with the
>> + *            load address. Ignored if NULL.
> This API change will break some existing users. For instance
> hw/microblaze/boot.c does this:
>              hwaddr uentry, loadaddr;
>
>              kernel_size = load_uimage(kernel_filename, &uentry, &loadaddr, 0,
>                                        NULL, NULL);

I did a bit more digging and the same (ab)use of loadaddr to pass

a value is used by load_ramdisk{,_as}.  Hopefully, I can do the same

for kernel_noload?



> which is a legitimate use of the current API, but your changes will
> mean that load_uboot_image() will be using an uninitialized
> variable. Getting every call site that cares about the returned
> result from loadaddr to also provide a valid default load
> address as input is going to be really painful, so I think we
> need to figure out an API for this function that doesn't
> make the input (default load address) argument the same
> parameter as the output (where we actually loaded the image)
> argument.

I have version 3 ready with fixing these callers.


>
> We should also make the load_uboot_image() function print an
> error message if we don't load the file because it needs a
> default load address and the caller didn't pass one
> ("this image format cannot be loaded on this machine type",
> or similar).
Fixed in version 3.
>
> PS: our coding style wants {} on all if()s -- scripts/checkpatch.pl
> can help catch this kind of nit.

There are lots of errors from this without my changes :(


> thanks
> -- PMM


Thanks,

Nick
