Received: from eggs.gnu.org ([209.51.188.92]:40946)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gmU0u-0005Bh-DD
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 20:41:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gmU0t-0004D6-Iz
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 20:41:04 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:39241)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gmU0t-00044I-Cb
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 20:41:03 -0500
Received: by mail-wr1-f67.google.com with SMTP id t27so4709452wra.6
	for <qemu-devel@nongnu.org>; Wed, 23 Jan 2019 17:41:03 -0800 (PST)
References: <20190122190503.13627-1-philmd@redhat.com>
	<CAFEAcA-iZHdf6DqrNyUS7yEQmV=VNzWgF7HbHrLaZ5C8EL_0dA@mail.gmail.com>
	<20190123093354.GB27270@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <078e621a-21b6-845f-c664-b6b1609b06b4@redhat.com>
Date: Thu, 24 Jan 2019 02:41:00 +0100
MIME-Version: 1.0
In-Reply-To: <20190123093354.GB27270@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] configure: Let SDL support be optional on
 OpenBSD
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Brad Smith <brad@comstyle.com>, Gerd Hoffmann <kraxel@redhat.com>, Fam Zheng <fam@euphon.net>

On 1/23/19 10:33 AM, Daniel P. Berrangé wrote:
> On Tue, Jan 22, 2019 at 07:20:35PM +0000, Peter Maydell wrote:
>> On Tue, 22 Jan 2019 at 19:05, Philippe Mathieu-Daudé <philmd@redhat.com> wrote:
>>>
>>> Currently if we try to build QEMU on OpenBSD with SDL disabled, we get:
>>>
>>>   $ ./configure --cc=x86_64-unknown-openbsd6.1-gcc-4.9.4 --python=python2.7 --disable-sdl
>>>
>>>   ERROR: sdl not found or disabled, can not use sdl audio driver
>>>
>>> Since SDL is not a requirement for OpenBSD, let it be optional (we remove
>>> it from $audio_drv_list but it stays available in $audio_possible_drivers).
>>> If no audio backends are available, QEMU falls back to the null driver.
>>
>>> --- a/configure
>>> +++ b/configure
>>> @@ -828,7 +828,7 @@ NetBSD)
>>>  OpenBSD)
>>>    bsd="yes"
>>>    make="${MAKE-gmake}"
>>> -  audio_drv_list="sdl"
>>> +  audio_drv_list=""
>>>    audio_possible_drivers="sdl"
>>>    HOST_VARIANT_DIR="openbsd"
>>>    supported_os="yes"
>>
>> This will mean that configure will by default not enable
>> a real audio backend, even if we do have sdl.
>>
>> Looking at the logic, "audio_possible_drivers" is only
>> used for printing the help message. The thing that drives
>> which audio drivers to test with is "audio_drv_list",
>> and the expectation is that you put things on that only
>> if it's possible to build with them. (For instance
>> we only add 'dsound' for mingw if the dsound.h header is
>> present, and so on.)

Yes sorry I missed that Peter :S

>> So we need to do one of:
>>  (1) only put "sdl" into audio_drv_list if SDL is
>>      available (this probably doesn't work as we haven't
>>      probed for SDL at the point where we initialize it)
>>  (2) have the sdl probe delete "sdl" from audio_drv_list
>>      if the probe fails
> 
> This one sounds reasonable to me.

I went this way, but encountered unexpected problems, which makes me
wonder who really use OpenBSD... Anyway the discussion deserves another
thread.

>>  (3) some more complicated restructuring :-)
>>      (eg rather than having audio_drv_list be set to an
>>      initial list based on the host OS, just have a full
>>      list of drivers, insist that each has a proper probe
>>      routine, and use whichever ones we can successfully
>>      probe)
> 
> 
> Regards,
> Daniel
> 
