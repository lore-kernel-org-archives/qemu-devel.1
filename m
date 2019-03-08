Received: from eggs.gnu.org ([209.51.188.92]:57108)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1h2Ga0-0001xg-L3
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 09:34:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1h2GZy-0004CW-Pt
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 09:34:31 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:35826)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1h2GZy-00041m-HL
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 09:34:30 -0500
Received: by mail-wm1-f65.google.com with SMTP id y15so12651076wma.0
	for <qemu-devel@nongnu.org>; Fri, 08 Mar 2019 06:34:30 -0800 (PST)
References: <20190307130323.9353-1-armbru@redhat.com>
	<20190307130323.9353-7-armbru@redhat.com>
	<a8a862f1-1f1e-818a-2ac6-bd54375c4dc3@redhat.com>
	<87wol9bfwm.fsf@dusky.pond.sub.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <27f8fd02-e697-e0a4-f409-4db68d085e20@redhat.com>
Date: Fri, 8 Mar 2019 15:34:26 +0100
MIME-Version: 1.0
In-Reply-To: <87wol9bfwm.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v3 06/14] sam460ex: Don't size flash memory
 to match backing image
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, qemu-block@nongnu.org, alex.bennee@linaro.org, mreitz@redhat.com, qemu-ppc@nongnu.org, lersek@redhat.com

On 3/8/19 3:27 PM, Markus Armbruster wrote:
> Philippe Mathieu-Daudé <philmd@redhat.com> writes:
> 
>> On 3/7/19 2:03 PM, Markus Armbruster wrote:
>>> Machine "sam460ex" maps its flash memory at address 0xFFF00000.  When
>>> no image is supplied, its size is 1MiB (0x100000), and 512KiB of ROM
>>> get mapped on top of its second half.  Else, it's the size of the
>>> image rounded up to the next multiple of 64KiB.
>>>
>>> The rounding is actually useless: pflash_cfi01_realize() fails with
>>> "failed to read the initial flash content" unless it's a no-op.
>>>
>>> I have no idea what happens when the pflash's size exceeds 1MiB.
>>> Useful outcomes seem unlikely.
>>
>> You now have! [*] "Hardwiring address lines leaves part of the hardware
>> unaddressable." Anything bigger than 1MiB mapped at 0xFFF00000 only has
>> the first MiB addressable. IOW anything above 1MiB is unaddressable, but
>> you still can map a such bigger flash.
>>
>> [*] https://lists.gnu.org/archive/html/qemu-devel/2019-03/msg01380.html
> 
> Well, that's what would happen with real hardware.  But this device
> model doesn't actually model address lines.  It simply asks
> pflash_cfi01_register() to map blk_getlength() bytes at the base
> address.  If you ask it to map gigabytes, it'll happily do so (as long
> as malloc plays along).

Ah, I misunderstood your commit message then. About the QEMU crippled
model, your commit description makes sense. Thus:

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
