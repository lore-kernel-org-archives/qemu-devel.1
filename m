Received: from eggs.gnu.org ([2001:4830:134:3::10]:38779)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cZgCJ-00058O-HK
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 10:54:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cZgCI-00034N-Ht
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 10:54:51 -0500
Received: from mail-wm0-x22b.google.com ([2a00:1450:400c:c09::22b]:36843)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cZgCI-00034A-BN
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 10:54:50 -0500
Received: by mail-wm0-x22b.google.com with SMTP id c85so35148171wmi.1
	for <qemu-devel@nongnu.org>; Fri, 03 Feb 2017 07:54:50 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <11420d1c49636c1790e60578ee996e51f0f0b835.1484929304.git.julian@codesourcery.com>
References: <cover.1484929304.git.julian@codesourcery.com>
	<11420d1c49636c1790e60578ee996e51f0f0b835.1484929304.git.julian@codesourcery.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 3 Feb 2017 15:54:28 +0000
Message-ID: <CAFEAcA_k50ECETcVGeoy33RHvTw6VpXdWXkC00-C-nztEDrZZA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH v3 1/7] Add cfgend parameter for ARM CPU
 selection.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Julian Brown <julian@codesourcery.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 20 January 2017 at 16:30, Julian Brown <julian@codesourcery.com> wrote:
> The new "cfgend" parameter can be given after the CPU name,
> e.g. "-cpu=arm926,cfgend=yes". Unlike earlier versions of the patch,
> CPU attribute parsing is left to board initialisation code: for the
> "virt" board, this was being done already, and this patch makes the
> integratorcp board init do so too.
>
> Signed-off-by: Julian Brown <julian@codesourcery.com>

This is sufficiently close to OK that I'm going to fix it up
in target-arm.next. Changes I'm making:

 * use error_report_err() rather than error_report() (I suspect this
   is a conflict with some API change that landed recently)
 * move the integratorcp changes to their own patch
 * drop an unnecessary extra #include;
 * move setting of reset_sctlr above registration of cpregs
   so it actually has an effect

That last one is the important one -- otherwise reset_sctlr
has already been copied into the cpregs data and the
changes to it won't be reflected in the values used for
reset. (You currently work around this with patch 3, which
we can then drop as unnecessary.)

thanks
-- PMM
