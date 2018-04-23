Received: from eggs.gnu.org ([2001:4830:134:3::10]:43769)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fAcQ7-0003im-0u
	for qemu-devel@nongnu.org; Mon, 23 Apr 2018 10:26:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fAcQ3-00031D-PU
	for qemu-devel@nongnu.org; Mon, 23 Apr 2018 10:26:19 -0400
Received: from mail-qt0-x234.google.com ([2607:f8b0:400d:c0d::234]:33044)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fAcQ3-00030y-Kx
	for qemu-devel@nongnu.org; Mon, 23 Apr 2018 10:26:15 -0400
Received: by mail-qt0-x234.google.com with SMTP id f16-v6so14042331qth.0
	for <qemu-devel@nongnu.org>; Mon, 23 Apr 2018 07:26:15 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
References: <20180421211652.14794-1-f4bug@amsat.org>
	<CAFEAcA_mSu00gEHgmfdpcvtaqfn7X0wbkUX54TCUW_FG+iURWQ@mail.gmail.com>
	<20180423031639.GB19804@umbus.fritz.box>
	<a3fc65b6-d906-fbfa-0102-a5382b15df8e@amsat.org>
	<CAFEAcA8T=aDjRAxxRWOKJuhDJa1ROjQ43cvaTG5B44+=d9SVLQ@mail.gmail.com>
	<73a63694-d656-959c-cd68-a26c28fbbf72@amsat.org>
Message-ID: <f937a232-fbb3-9b83-74fc-e19930dfbf9c@amsat.org>
Date: Mon, 23 Apr 2018 11:26:11 -0300
MIME-Version: 1.0
In-Reply-To: <73a63694-d656-959c-cd68-a26c28fbbf72@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] loader: Fix misaligned member access
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: David Gibson <david@gibson.dropbear.id.au>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, Paul Burton <paul.burton@mips.com>, QEMU Developers <qemu-devel@nongnu.org>

> On 04/23/2018 11:04 AM, Peter Maydell wrote:
>> On 23 April 2018 at 14:57, Philippe Mathieu-Daudé <f4bug@amsat.org> wrote:
>>> On 04/23/2018 12:16 AM, David Gibson wrote:
>>>> On Sun, Apr 22, 2018 at 11:41:20AM +0100, Peter Maydell wrote:
>>>>> If we need to do an unaligned load, then ldl_p() is the
>>>>> right way to do it. (We could also just do
>>>>>  *addr = ldl_be_p(prop) but we maybe don't want to
>>>>> bake in knowledge that FDT is big-endian).
>>>
>>> Since it is, ldl_be_p() seems the clever/cleaner way indeed, but then we
>>> assume we know the underlying type of fdt32_t; while using memcpy we
>>> respect the FDT API.
>>
>>  *addr = fdt32_to_cpu(ldl_p(prop));
>>
>> is better than a raw memcpy still.

ldl_p() is target-specific, I'd prefer loader code to be target agnostic.

Since FDT is big-endian, are you OK I use, as you suggested,

    *addr = ldq_be_p(prop);

(with a comment about FDT being BE)?
