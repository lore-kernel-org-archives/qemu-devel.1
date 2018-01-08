Received: from eggs.gnu.org ([2001:4830:134:3::10]:40191)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eYV1L-0005nB-7i
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 05:51:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eYV1K-0004yQ-Av
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 05:51:11 -0500
Received: from mail-oi0-x230.google.com ([2607:f8b0:4003:c06::230]:42772)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eYV1K-0004xQ-5p
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 05:51:10 -0500
Received: by mail-oi0-x230.google.com with SMTP id o64so7062036oia.9
	for <qemu-devel@nongnu.org>; Mon, 08 Jan 2018 02:51:09 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <151379548718.11069.3987410517769405650.malone@gac.canonical.com>
References: <151375741208.25451.9053884797959645588.malonedeb@wampee.canonical.com>
	<151379548718.11069.3987410517769405650.malone@gac.canonical.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 8 Jan 2018 10:50:48 +0000
Message-ID: <CAFEAcA_jEVBwkOyWKFp58FurYO4eKqg+kg9mEwXfw45dJqREoA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [Bug 1739378] Re: qemu git master snapshot doesn't
 work
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Bug 1739378 <1739378@bugs.launchpad.net>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 20 December 2017 at 18:44, Dr. David Alan Gilbert
<dgilbert@redhat.com> wrote:
> From a quick look my guess would be the wpgrps_size in sd_vmstate is
> different on the source and destination for some reason

Good guess: I added a pre_save hook to sdcard.c's vmstate,
which reports wpgrps_size as 201, but in the pre_load hook
it is reported as 0.

This seems to be because nothing ever calls the sd_reset()
function. I suspect this is down to the "legacy" handling
of sd card setup in sd_init(), or possibly the generic handling
of reset for devices that connect to SD buses.

(sd_reset() eventually gets called when the guest OS
probes the SD controller and issues a card reset command,
which is why it's correctly set by the time we do a vmsave.)

thanks
-- PMM
