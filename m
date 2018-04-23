Received: from eggs.gnu.org ([2001:4830:134:3::10]:56930)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fAdSx-0004EZ-IW
	for qemu-devel@nongnu.org; Mon, 23 Apr 2018 11:33:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fAdSw-00085u-Na
	for qemu-devel@nongnu.org; Mon, 23 Apr 2018 11:33:19 -0400
Received: from mail-ot0-x22b.google.com ([2607:f8b0:4003:c0f::22b]:44790)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fAdSw-00085c-Ir
	for qemu-devel@nongnu.org; Mon, 23 Apr 2018 11:33:18 -0400
Received: by mail-ot0-x22b.google.com with SMTP id g7-v6so8436787otj.11
	for <qemu-devel@nongnu.org>; Mon, 23 Apr 2018 08:33:18 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <f937a232-fbb3-9b83-74fc-e19930dfbf9c@amsat.org>
References: <20180421211652.14794-1-f4bug@amsat.org>
	<CAFEAcA_mSu00gEHgmfdpcvtaqfn7X0wbkUX54TCUW_FG+iURWQ@mail.gmail.com>
	<20180423031639.GB19804@umbus.fritz.box>
	<a3fc65b6-d906-fbfa-0102-a5382b15df8e@amsat.org>
	<CAFEAcA8T=aDjRAxxRWOKJuhDJa1ROjQ43cvaTG5B44+=d9SVLQ@mail.gmail.com>
	<73a63694-d656-959c-cd68-a26c28fbbf72@amsat.org>
	<f937a232-fbb3-9b83-74fc-e19930dfbf9c@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 23 Apr 2018 16:32:57 +0100
Message-ID: <CAFEAcA8prvR20De9houvPfTJ-k5dDVPo7=nu6Cs87cdqMPv-hw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] loader: Fix misaligned member access
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: David Gibson <david@gibson.dropbear.id.au>, =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, Paul Burton <paul.burton@mips.com>, QEMU Developers <qemu-devel@nongnu.org>

On 23 April 2018 at 15:26, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> wr=
ote:
>> On 04/23/2018 11:04 AM, Peter Maydell wrote:
>>> On 23 April 2018 at 14:57, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org=
> wrote:
>>>> On 04/23/2018 12:16 AM, David Gibson wrote:
>>>>> On Sun, Apr 22, 2018 at 11:41:20AM +0100, Peter Maydell wrote:
>>>>>> If we need to do an unaligned load, then ldl_p() is the
>>>>>> right way to do it. (We could also just do
>>>>>>  *addr =3D ldl_be_p(prop) but we maybe don't want to
>>>>>> bake in knowledge that FDT is big-endian).
>>>>
>>>> Since it is, ldl_be_p() seems the clever/cleaner way indeed, but then =
we
>>>> assume we know the underlying type of fdt32_t; while using memcpy we
>>>> respect the FDT API.
>>>
>>>  *addr =3D fdt32_to_cpu(ldl_p(prop));
>>>
>>> is better than a raw memcpy still.
>
> ldl_p() is target-specific, I'd prefer loader code to be target agnostic.
>
> Since FDT is big-endian, are you OK I use, as you suggested,
>
>     *addr =3D ldq_be_p(prop);
>
> (with a comment about FDT being BE)?

Oops, yes, forgot that ldq_p is the target-endian version.
ldq_he_p() is the "load in host endianness" function, so
   *addr =3D fdt64_to_cpu(ldq_he_p(prop));

Sorry for the confusion.

-- PMM
