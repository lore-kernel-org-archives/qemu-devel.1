Received: from eggs.gnu.org ([209.51.188.92]:53003)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1go6ci-0002tD-1D
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 08:06:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1go6cg-0002M2-I5
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 08:06:47 -0500
Received: from mail-ot1-x32b.google.com ([2607:f8b0:4864:20::32b]:42508)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1go6cg-0002Ld-Cy
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 08:06:46 -0500
Received: by mail-ot1-x32b.google.com with SMTP id v23so14512076otk.9
	for <qemu-devel@nongnu.org>; Mon, 28 Jan 2019 05:06:46 -0800 (PST)
MIME-Version: 1.0
References: <87y378n5iy.fsf@dusky.pond.sub.org>
	<CAFEAcA9b+7m1hL9atdm2_0fq66HPGWDhpAfZCRfPbegr2hKyGg@mail.gmail.com>
	<20190128124027.776wwcqrckalvr7x@sirius.home.kraxel.org>
In-Reply-To: <20190128124027.776wwcqrckalvr7x@sirius.home.kraxel.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 28 Jan 2019 13:06:34 +0000
Message-ID: <CAFEAcA-jwBhBXQb-SHT=b_Vy5Sq+M2iaMP2XtVn_2HQvzaEoVQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [libvirt] Configuring pflash devices for OVMF
 firmware
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, Libvirt <libvir-list@redhat.com>, Peter Krempa <pkrempa@redhat.com>, =?UTF-8?B?TMOhc3psw7Mgw4lyc2Vr?= <lersek@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Qemu-block <qemu-block@nongnu.org>

On Mon, 28 Jan 2019 at 12:40, Gerd Hoffmann <kraxel@redhat.com> wrote:
> The tricky part is the access control here.  On physical hardware you
> typically have one flash rom, say 16M below 4G (on x86).
>
> Our pflash device doesn't allow to define multiple regions, so we use
> multiple pflash devices instead, each with different access permissions
> (code vs. vars).  Because of that they are more dynamic than they are on
> phyiscal hardware, x86 sizes them according to the size of the firmware
> images (arm is easier here, we have fixed size and location no matter
> how big the firmware images are).
>
> So I think the options we have are:
>   (a) leave pflash as-is, which pretty much implies physaddr and size
>       must be user-configurable.
>   (b) add support for multiple regions to pflash, so one can attach
>       multiple blockdev at different offsets to a single pflash device.

The latter makes more sense to me -- we should model what the
hardware actually has, because the guest can tell the difference.
(Migration compat is left as an exercise for the reader :-))

thanks
-- PMM
