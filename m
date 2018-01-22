Received: from eggs.gnu.org ([2001:4830:134:3::10]:48355)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eddYX-0000ro-QJ
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 09:58:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eddYX-0006yl-4N
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 09:58:41 -0500
Received: from mail-ot0-x232.google.com ([2607:f8b0:4003:c0f::232]:39758)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eddYW-0006yL-V0
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 09:58:41 -0500
Received: by mail-ot0-x232.google.com with SMTP id d9so7675327oth.6
	for <qemu-devel@nongnu.org>; Mon, 22 Jan 2018 06:58:40 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <cdea624dfb8279e1bd1e7c52472e42458b1c2829.1516386853.git.alistair.francis@xilinx.com>
References: <cover.1516386853.git.alistair.francis@xilinx.com>
	<cdea624dfb8279e1bd1e7c52472e42458b1c2829.1516386853.git.alistair.francis@xilinx.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 22 Jan 2018 14:58:19 +0000
Message-ID: <CAFEAcA-gsYLrb+Ew=Ew76ac8PyADs8Tj+gOyRgc610yi3201jA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v4 2/3] xlnx-zynqmp-rtc: Add basic time
 support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Alistair Francis <alistair23@gmail.com>, Edgar Iglesias <edgar.iglesias@xilinx.com>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>

On 19 January 2018 at 18:35, Alistair Francis
<alistair.francis@xilinx.com> wrote:
> Allow the guest to determine the time set from the QEMU command line.
>
> This includes adding a trace event to debug the new time.
>
> The migration logic was copied from the PL031 migration logic.

Unfortunately, that logic won't work for your case. The PL031
presave/postload functions were added in commit b0f26631bc5
and are there to handle a change in the semantics of a pre-existing
tick offset field in the vmstate. In your case there is no tick
offset field at all, and just adding one like this will cause
migration from the previous QEMU version to break.

>  static const VMStateDescription vmstate_rtc = {
>      .name = TYPE_XLNX_ZYNQMP_RTC,
>      .version_id = 1,
>      .minimum_version_id = 1,
> +    .pre_save = rtc_pre_save,
> +    .post_load = rtc_post_load,
>      .fields = (VMStateField[]) {
>          VMSTATE_UINT32_ARRAY(regs, XlnxZynqMPRTC, XLNX_ZYNQMP_RTC_R_MAX),
> +        VMSTATE_UINT32(tick_offset_vmstate, XlnxZynqMPRTC),
>          VMSTATE_END_OF_LIST(),
>      }
>  };

For migration compatibility here you'll need to put the new field
into its own subsection, and then in pre-load and/or post-load you
can handle the "inbound data is from an old version".

thanks
-- PMM
