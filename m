Received: from eggs.gnu.org ([2001:4830:134:3::10]:37471)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fNfgb-0004JX-Nm
	for qemu-devel@nongnu.org; Tue, 29 May 2018 10:33:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fNfgX-0007vp-HW
	for qemu-devel@nongnu.org; Tue, 29 May 2018 10:33:17 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170724182751.18261-1-f4bug@amsat.org>
	<20170724182751.18261-22-f4bug@amsat.org>
	<CAFEAcA_PRH_BuUOTtC=cvRFT7Gtiwt50T6C3avm+Sy13aDS4tg@mail.gmail.com>
	<ae090923-3523-3e56-fbc1-65b270680939@amsat.org>
	<e0d37c83-537a-5288-b033-e5be3b8858ca@redhat.com>
	<c1078250-30a0-0d4c-d830-88591fb6ba43@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <713f16f9-3faa-7644-38c6-0797252d5922@amsat.org>
Date: Tue, 29 May 2018 11:33:07 -0300
MIME-Version: 1.0
In-Reply-To: <c1078250-30a0-0d4c-d830-88591fb6ba43@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH for 2.10 21/35] arm/sysbus-fdt: fix null
 pointer dereference
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>

Hi Eric,

On 07/24/2017 06:57 PM, Eric Blake wrote:
> On 07/24/2017 04:52 PM, Eric Blake wrote:
>> On 07/24/2017 04:48 PM, Philippe Mathieu-Daudé wrote:
>>> On 07/24/2017 06:09 PM, Peter Maydell wrote:
>>>> On 24 July 2017 at 19:27, Philippe Mathieu-Daudé <f4bug@amsat.org> wrote:
>>>>> Use error_report() + exit() instead of error_setg(&error_fatal).
>>>>>
>>>>> hw/arm/sysbus-fdt.c:322:9: warning: Array access (from variable
>>>>> 'node_path') results in a null pointer dereference
>>>>>      if (node_path[1]) {
>>>>>          ^~~~~~~~~~~~
>>>>
>>>> I don't understand what this warning is trying to say.
>>>> We can't get to this point with a NULL node_path,
>>>> because of the previous conditional, which is using
>>>> error_setg(&error_fatal).
>>>
>>> Ok I see, Clang is unaware than error_setg(&error_fatal) is a noreturn.
>>
>> Indeed, and that's because error_setg(&error_fatal) is not in preferred
>> form.
>>
>>>
>>> Patch dropped.
>>
>> That's a shame.  Rather, we should patch this file (and others) to avoid
>> all the inconsistent uses of error_setg(&error_*), to comply with the
>> error.h documentation.

I started to port/clean this up.
To avoid future inconsistencies, do you think we should/can enforce this
check in checkpatch (which is stricter than human review)?
Is the "Qemu error function tests" section a good place to put this check?

> 
> In other words, switching to the preferred spelling in the following files:
> device_tree.c
> hw/arm/sysbus-fdt.c
> hw/block/fdc.c
> hw/ppc/spapr_drc.c
> 
> is desirable, and has the added benefit of also silencing a Coverity
> false positive.  But it should be done in terms of switching to the
> preferred spelling, as it touches more instances than just the one that
> shuts up Coverity.
> 
