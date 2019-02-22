Received: from eggs.gnu.org ([209.51.188.92]:38769)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gx6dP-000538-1x
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 03:56:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gx6dN-0004eJ-6p
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 03:56:42 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:45136)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gx6dM-00049q-Tx
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 03:56:41 -0500
Received: by mail-wr1-f68.google.com with SMTP id w17so1428258wrn.12
	for <qemu-devel@nongnu.org>; Fri, 22 Feb 2019 00:56:13 -0800 (PST)
References: <20190221184857.22434-1-alex.bennee@linaro.org>
	<e080ce0b-5b14-ae9c-28c7-8254db3b648a@redhat.com>
	<87wols3nxl.fsf@zen.linaroharston>
	<5e9e1a86-ab39-dfcb-9562-54eaf38a6deb@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <2eda3793-a9e7-195e-993d-0b5b09a83e53@redhat.com>
Date: Fri, 22 Feb 2019 09:56:05 +0100
MIME-Version: 1.0
In-Reply-To: <5e9e1a86-ab39-dfcb-9562-54eaf38a6deb@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v3] hw/block: better reporting on pflash
 backing file mismatch
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laszlo Ersek <lersek@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Cc: stappers@stappers.nl, qemu-devel@nongnu.org, armbru@redhat.com

On 2/22/19 9:09 AM, Laszlo Ersek wrote:
> On 02/21/19 21:07, Alex Bennée wrote:
>> Laszlo Ersek <lersek@redhat.com> writes:
>>
>>> On 02/21/19 19:48, Alex Bennée wrote:
>>>> It looks like there was going to be code to check we had some sort of
>>>> alignment so lets replace it with an actual check. This is a bit more
>>>> useful than the enigmatic "failed to read the initial flash content"
>>>> when we attempt to read the number of bytes the device should have.
>>>>
>>>> This is a potential confusing stumbling block when you move from using
>>>> -bios to using -drive if=pflash,file=blob,format=raw,readonly for
>>>> loading your firmware code. To mitigate that we automatically pad in
>>>> the read-only case.
>>>>
>>>> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
>>>>
>>>> ---
>>>> v3
>>>>   - tweak commit title/commentary
>>>>   - use total_len instead of device_len for checks
>>>>   - if the device is read-only do the padding for them
>>>>   - accept baking_len > total_len (how to warn_report with NULL *errp?)
>>>> ---
>>>>  hw/block/pflash_cfi01.c | 28 +++++++++++++++++++++-------
[...]>>>> +                total_len = backing_len;
>>>> +            } else {
>>>> +                error_setg(errp, "device(s) needs %" PRIu64 " bytes, "
>>>
>>> (4) not too important, I'm just curious: why the optional plural?
>>
>> I discovered the difference between device_len and total_len and found
>> (for some reason) the efivars came out as multiple devices.
> 
> It is true that the executable code is in one chip, and the UEFI
> varstore in another (in the most common & most recommended setup
> anyway); however, the varstore itself doesn't need multiple chips, and
> more importantly, I think the realize function of any given single chip
> should only report errors about that one chip. (Unless we have some

I agree with László.

> higher level invariant binding the chips together, but I'm unaware of
> any such in this case.)
> 
> If I understand correctly, when we set the error here, QEMU will produce
> an error report that is tied to the specific pflash chip / command line
> option that triggered the error. That looks like the right thing to me.
> 
> Again I don't really insist on plural vs. singular here, I just wanted
> to understand your train of thought.
> 
> Thanks!
> Laszlo
