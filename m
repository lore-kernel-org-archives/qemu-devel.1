Received: from eggs.gnu.org ([2001:4830:134:3::10]:46040)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lists@philjordan.eu>) id 1dYWOh-0004gB-1U
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 07:47:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lists@philjordan.eu>) id 1dYWOf-0006SL-Vh
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 07:47:07 -0400
Received: from mail-ua0-x235.google.com ([2607:f8b0:400c:c08::235]:32768)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <lists@philjordan.eu>) id 1dYWOf-0006S6-Pb
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 07:47:05 -0400
Received: by mail-ua0-x235.google.com with SMTP id 80so43527519uas.0
	for <qemu-devel@nongnu.org>; Fri, 21 Jul 2017 04:47:05 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <alpine.BSF.2.21.1707211235480.66319@zero.eik.bme.hu>
References: <3E24AFDE-D25A-416B-A600-3C2221C3A9F1@gmail.com>
	<CAGCz3vu5x59+mKg8011=DRyZQKbuBV2F20ZpPnG1TOCxsOb+mQ@mail.gmail.com>
	<20170721092026.GD17693@redhat.com>
	<20170721114623.57b3be1d@nial.brq.redhat.com>
	<alpine.BSF.2.21.1707211235480.66319@zero.eik.bme.hu>
From: Phil Dennis-Jordan <lists@philjordan.eu>
Date: Fri, 21 Jul 2017 13:46:44 +0200
Message-ID: <CAGCz3vu7qdNQKp7aHU35Hj7GxsT_WqGEJbb6XNyaAn=wmHYiZA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] Commit 77af8a2b95b79699de650965d5228772743efe84
 breaks Windows 2000 support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: Igor Mammedov <imammedo@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>, Phil Dennis-Jordan <phil@philjordan.eu>, ehabkost@redhat.com, "qemu-devel@nongnu.org qemu-devel" <qemu-devel@nongnu.org>, Programmingkid <programmingkidx@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>

On Fri, Jul 21, 2017 at 12:50 PM, BALATON Zoltan <balaton@eik.bme.hu> wrote:
> On Fri, 21 Jul 2017, Igor Mammedov wrote:
>>
>> On Fri, 21 Jul 2017 10:20:26 +0100
>> "Daniel P. Berrange" <berrange@redhat.com> wrote:
>>>
>>> On Thu, Jul 20, 2017 at 09:29:33PM +0200, Phil Dennis-Jordan wrote:
>>>>
>>>> On Thu, Jul 20, 2017 at 6:40 PM, Programmingkid
>>>> <programmingkidx@gmail.com> wrote:
>>>>>
>>>>> I noticed that Windows 2000 does not boot up in QEMU recently. After
>>>>> bisecting the issue I found the offending commit:
>>>>
>>>>
>>>> Ouch. I reckon we have 2 options for fixing this:
>>>>
>>>> 1. Export two FADTs, one ACPI 1.0, one ACPI 2.0. The latter would need
>>>> to be pointed to by an XSDT, which Qemu currently doesn't implement at
>>>> all as far as I'm aware. Any ideas on how SeaBIOS or OVMF would handle
>>>> this? Any likely other OS regressions?
>>>>
>>>> 2. Select FADT version with an option. This one is definitely safe,
>>>> but adds yet another option.
>>>>
>>>> Thoughts?
>>>
>>>
>>> The original comit below claims the change does not impact guest ABI
>>> compatibility, so do we understand why Windows broke ?
>>
>> Author made a reasonable effort to test with variety of guest OSes upto
>> vanilla WinXP, we can't blame ourselves for not testing OS that's is not
>> available.
>>
>> Well we don't know why w2k breaks, only that it bisects to this commit.
>
>
> I don't know if this helps but I've found that this same commit also broke
> booting OS X on q35 with OVMF and Clover (some old versions I had and worked
> before this commit). See here:
> http://lists.nongnu.org/archive/html/qemu-devel/2017-06/msg04306.html
>
> Maybe it's simpler to debug as these are open source but it's still not very
> clear why they fail because it starts to boot OS X but hangs during kernel
> init (and maybe Win2K fails to boot because of something else). I think I've
> seen this with OVMF 58f025afd and Clover 3354 (or around that, not
> completely sure about these versions).

OVMF had 2 bugs that totally mucked up the ACPI tables if Qemu didn't
supply its loader commands "just so", and modified ACPI 2.0-5.0 FADTs
in such a way that they were no longer valid. These are fixed in
198a46d and 072060a, which are about a year newer than 58f025afd, so
it's no surprise this combination doesn't work. I have no idea if
Clover on top makes any difference.
