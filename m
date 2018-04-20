Received: from eggs.gnu.org ([2001:4830:134:3::10]:52746)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1f9X2Q-0003GK-37
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 10:29:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1f9X2L-00023D-5y
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 10:29:22 -0400
Received: from mail-qk0-x242.google.com ([2607:f8b0:400d:c09::242]:37933)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1f9X2L-00022O-0j
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 10:29:17 -0400
Received: by mail-qk0-x242.google.com with SMTP id b39so9099324qkb.5
	for <qemu-devel@nongnu.org>; Fri, 20 Apr 2018 07:29:16 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
References: <20180419220914.959-1-f4bug@amsat.org>
	<20180419220914.959-2-f4bug@amsat.org>
	<CAFEAcA-LYpqaYfdmjzXwMDau8bZH_zxXaRCCL5dRT1p6spjUxQ@mail.gmail.com>
	<f89278ba-b805-e47d-7e5e-d103ab9c4294@amsat.org>
	<CAFEAcA9zuoVDJqZ88jBG0fEpC2imDuj2OAAMpgqiQ=MbtE3QSg@mail.gmail.com>
	<ad37af41-feda-0a6a-89a2-38abd452401c@amsat.org>
Message-ID: <ab476982-0aee-7471-daa2-99f774f43089@amsat.org>
Date: Fri, 20 Apr 2018 11:29:12 -0300
MIME-Version: 1.0
In-Reply-To: <ad37af41-feda-0a6a-89a2-38abd452401c@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, "=?UTF-8?Q?Daniel_P_._Berrang=c3=a9?=" <berrange@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>

>>> On 04/20/2018 05:43 AM, Peter Maydell wrote:
>>> Since we can now safely call serial_mm_init(..., chr=NULL, ...), I'll
>>> work on simplifying and fixing this.
>>
>> Correct. There are a bunch of dubious workarounds in the
>> codebase which try to handle the problem at different levels,
>> but we've decided that the right thing is for the NULL pointer
>> to be dealt with in one place at the bottom (in the qemu_chr_fe_*
>> functions).
> 
> OK, I'll happily clean that :)

Hmmm removing the "if (serial_hds[0])" check I reach:

void serial_realize_core(SerialState *s, Error **errp)
{
    if (!qemu_chr_fe_backend_connected(&s->chr)) {
        error_setg(errp, "Can't create serial device, empty char device");
        return;
    }
