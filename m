Received: from eggs.gnu.org ([2001:4830:134:3::10]:59125)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eEIYG-0007eT-CH
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 12:29:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eEIYF-0003UY-Kp
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 12:29:40 -0500
Received: from mail-wr0-x232.google.com ([2a00:1450:400c:c0c::232]:56221)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eEIYF-0003UI-DK
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 12:29:39 -0500
Received: by mail-wr0-x232.google.com with SMTP id l8so15084199wre.12
	for <qemu-devel@nongnu.org>; Mon, 13 Nov 2017 09:29:39 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_bXripv8_O8aRuDbdYQ3oWeVzdb8GO=o9j2oddYrg-0A@mail.gmail.com>
References: <CAFEAcA_bXripv8_O8aRuDbdYQ3oWeVzdb8GO=o9j2oddYrg-0A@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 13 Nov 2017 17:29:17 +0000
Message-ID: <CAFEAcA9DK=rb-9Jei+U3xhcVM_oscpY09nANoy4QUpfNeqOMVA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] using "qemu-img convert -O qcow2" to convert qcow
 v1 to v2 creates a qcow v3 file?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Developers <qemu-devel@nongnu.org>
Cc: Qemu-block <qemu-block@nongnu.org>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>

On 13 November 2017 at 17:14, Peter Maydell <peter.maydell@linaro.org> wrote:
> I have a qcow v1 file which I created by mistake (forgetting that
> you need to tell qemu-img create 'qcow2' and not just 'qcow'),
> which I want to convert to a v2 file so I can put snapshots into
> it. But when I try to do this with qemu-img convert it creates a
> v3 file instead:
>
> $ file hda-old.qcow
> hda-old.qcow: QEMU QCOW Image (v1), 5368709120 bytes
> $ build/x86/qemu-img convert -O qcow2 hda-old.qcow hda.qcow2
> $ file hda.qcow2
> hda.qcow2: QEMU QCOW Image (v3), 5368709120 bytes
>
> and if you then try to use that in QEMU it complains:
>
> qemu-system-aarch64: -drive if=none,file=hda.qcow2,format=qcow,id=hd:
> Unsupported qcow version 3

ah, this means it wants "format=qcow2".

This is pretty confusing, especially the error message, the
output of "file", and the fact that "format=qcow" can't just
DTRT if it gets a qcow version 3 (2?), since it can clearly
identify what it's got.

thanks
-- PMM
