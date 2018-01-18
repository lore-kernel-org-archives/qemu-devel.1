Received: from eggs.gnu.org ([2001:4830:134:3::10]:46909)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ecCp0-0007YW-6H
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 11:13:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ecCow-0002Nb-7v
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 11:13:46 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57206)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1ecCow-0002Ma-1Y
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 11:13:42 -0500
References: <20180112125854.18261-1-kraxel@redhat.com>
	<20180112125854.18261-11-kraxel@redhat.com>
	<CAFEAcA8UAbOvZuhxwjD2zAA7GBGucD8MAf5E0h05tb3NXKdGqw@mail.gmail.com>
	<20180118133643.GP19695@redhat.com>
	<b56b41f6-f048-00bf-d5fb-a1ed20ddeb09@redhat.com>
	<20180118141256.GS19695@redhat.com>
	<85686228-03dd-a7fc-1477-f27d09de5007@redhat.com>
	<CAFEAcA9sFenca+n37VOjQ3tUJLV_Vt0A7iwNdj=WbOvrMP6Pbg@mail.gmail.com>
	<5eb947cb-6481-9081-0574-306858f985e0@redhat.com>
	<d7719996-d418-48f8-61c8-7de24f8138b2@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <1c036781-756c-5f63-3fb5-ff7b537dba97@redhat.com>
Date: Thu, 18 Jan 2018 17:13:07 +0100
MIME-Version: 1.0
In-Reply-To: <d7719996-d418-48f8-61c8-7de24f8138b2@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PULL 10/14] ui: fix VNC client throttling when
 audio capture is active
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: Gerd Hoffmann <kraxel@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>

On 18/01/2018 17:06, Thomas Huth wrote:
> On 18.01.2018 16:33, Paolo Bonzini wrote:
>> On 18/01/2018 15:50, Peter Maydell wrote:
>>> On 18 January 2018 at 14:46, Paolo Bonzini <pbonzini@redhat.com> wrote:
>>>> On 18/01/2018 15:12, Daniel P. Berrange wrote:
>>>>>> In addition to that, do we support a >= 2 GiB framebuffer at all? (Even
>>>>>> with unsigned ints, Coverity would rightly complain about a truncated
>>>>>> 32-bit multiplication being assigned to a 64-bit value).
>>>>> client_width/client_height are values that are initialized from the
>>>>> graphics card frontend config, and thus limited by amount of video
>>>>> RAM QEMU allows.   bytes_per_pixel is limited to 8/16/32.
>>>>>
>>>>> So I think we're safe from 2GB overflow in any normal case.
>>>>>
>>>>> That said, VGA RAM size is configurable, so I'm curious what would happen
>>>>> if someone configured an insanely large VGA RAM and asked for a big frame
>>>>> buffer in guest.
>>>>>
>>>>> VNC is protocol limited to uint16 for width/height size, and so is X11
>>>>> so I imagine some exploding behavour would follow :-)
>>>>
>>>> Indeed, and even 2^16 x 2^16 * 32bpp is already 34 bits.  So perhaps we
>>>> should limit VNC to 16384 pixels on each axis (maximum frame buffer size
>>>> 1 GiB).
>>>
>>> Google says you can already get graphics cards that can do 15360x8640,
>>> which is really quite close to that 16384 limit...
>>
>> Then we can do 32767 * 16384 * 4, but I'm a bit afraid of off-by-ones.
> 
> Simply limit it to 30000 * 20000 ?

That's too much (exceeds 2^31-1 at 32bpp), but yeah, 30720*17280 is
twice what Peter found and it's safe.

Paolo
