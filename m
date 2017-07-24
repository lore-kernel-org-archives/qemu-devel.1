Received: from eggs.gnu.org ([2001:4830:134:3::10]:34968)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dZkqr-0007Zq-Qq
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 17:25:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dZkqq-00049i-Q3
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 17:25:17 -0400
Received: from mail-wm0-x22b.google.com ([2a00:1450:400c:c09::22b]:38378)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dZkqq-00049W-J0
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 17:25:16 -0400
Received: by mail-wm0-x22b.google.com with SMTP id m85so27568113wma.1
	for <qemu-devel@nongnu.org>; Mon, 24 Jul 2017 14:25:16 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <08765e63-6712-f965-7ea3-ab356b083c60@amsat.org>
References: <20170724182751.18261-1-f4bug@amsat.org>
	<20170724182751.18261-22-f4bug@amsat.org>
	<CAFEAcA_PRH_BuUOTtC=cvRFT7Gtiwt50T6C3avm+Sy13aDS4tg@mail.gmail.com>
	<08765e63-6712-f965-7ea3-ab356b083c60@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 24 Jul 2017 22:24:55 +0100
Message-ID: <CAFEAcA8eQLvAY9CozjNJ+zz0Lm99q=yEw0ap9MXJmsH-XuC4=g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: Eric Blake <eblake@redhat.com>, =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>

On 24 July 2017 at 22:20, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> wro=
te:
> On 07/24/2017 06:09 PM, Peter Maydell wrote:
>>
>> On 24 July 2017 at 19:27, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> =
wrote:
>
> ...
>
>>> diff --git a/hw/arm/sysbus-fdt.c b/hw/arm/sysbus-fdt.c
>>> index d68e3dcdbd..ad0cc49b19 100644
>>> --- a/hw/arm/sysbus-fdt.c
>>> +++ b/hw/arm/sysbus-fdt.c
>>> @@ -315,15 +315,14 @@ static int add_amd_xgbe_fdt_node(SysBusDevice
>>> *sbdev, void *opaque)
>>>       node_path =3D qemu_fdt_node_path(host_fdt, dt_name, vdev->compat,
>>>                                      &error_fatal);
>>>       if (!node_path || !node_path[0]) {
>>> -        error_setg(&error_fatal, "%s unable to retrieve node path for
>>> %s/%s",
>>> +        error_report("%s unable to retrieve node path for %s/%s",
>>>                      __func__, dt_name, vdev->compat);
>>> -    }
>>> -
>>> -    if (node_path[1]) {
>>> -        error_setg(&error_fatal, "%s more than one node matching
>>> %s/%s!",
>>> +        exit(1);
>>> +    } else if (node_path[1]) {
>>> +        error_report("%s more than one node matching %s/%s!",
>>>                      __func__, dt_name, vdev->compat);
>>> +        exit(1);
>>>       }
>>> -
>>>       g_free(dt_name);
>>
>>
>> This doesn't seem like an improvement. Now the
>> error handling in the function is an inconsistent
>> mix of error_report()+exit() and error_setg(&error_fatal).
>
>
> I got this from "qapi/error.h":
>
> 156 * Please don't error_setg(&error_fatal, ...), use error_report() and
> 157 * exit(), because that's more obvious.
> 158 * Likewise, don't error_setg(&error_abort, ...), use assert().
>
> Is this comment outdated?

Probably not, I expect this code predates it. However
my point about inconsistency still stands.

thanks
-- PMM
