Received: from eggs.gnu.org ([2001:4830:134:3::10]:36278)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f9XGD-0002H2-11
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 10:43:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f9XGC-0002p3-16
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 10:43:37 -0400
Received: from mail-oi0-x244.google.com ([2607:f8b0:4003:c06::244]:44734)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1f9XGB-0002ol-K1
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 10:43:35 -0400
Received: by mail-oi0-x244.google.com with SMTP id e80-v6so793077oig.11
	for <qemu-devel@nongnu.org>; Fri, 20 Apr 2018 07:43:35 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <ab476982-0aee-7471-daa2-99f774f43089@amsat.org>
References: <20180419220914.959-1-f4bug@amsat.org>
	<20180419220914.959-2-f4bug@amsat.org>
	<CAFEAcA-LYpqaYfdmjzXwMDau8bZH_zxXaRCCL5dRT1p6spjUxQ@mail.gmail.com>
	<f89278ba-b805-e47d-7e5e-d103ab9c4294@amsat.org>
	<CAFEAcA9zuoVDJqZ88jBG0fEpC2imDuj2OAAMpgqiQ=MbtE3QSg@mail.gmail.com>
	<ad37af41-feda-0a6a-89a2-38abd452401c@amsat.org>
	<ab476982-0aee-7471-daa2-99f774f43089@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 20 Apr 2018 15:43:14 +0100
Message-ID: <CAFEAcA828qK5DJy8yqO=d8LyaPthVb_qj3VQBZh_rY40TeZotg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 1/2] hw/isa/superio: Fix inconsistent use
 of Chardev->be
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>

On 20 April 2018 at 15:29, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> wr=
ote:
>>>> On 04/20/2018 05:43 AM, Peter Maydell wrote:
>>>> Since we can now safely call serial_mm_init(..., chr=3DNULL, ...), I'l=
l
>>>> work on simplifying and fixing this.
>>>
>>> Correct. There are a bunch of dubious workarounds in the
>>> codebase which try to handle the problem at different levels,
>>> but we've decided that the right thing is for the NULL pointer
>>> to be dealt with in one place at the bottom (in the qemu_chr_fe_*
>>> functions).
>>
>> OK, I'll happily clean that :)
>
> Hmmm removing the "if (serial_hds[0])" check I reach:
>
> void serial_realize_core(SerialState *s, Error **errp)
> {
>     if (!qemu_chr_fe_backend_connected(&s->chr)) {
>         error_setg(errp, "Can't create serial device, empty char device")=
;
>         return;
>     }

Yeah. That check is unnecessary; nothing fails to work if it is
removed. I've got a patch deleting it in my "drop MAX_SERIAL_PORTS"
series.

thanks
-- PMM
