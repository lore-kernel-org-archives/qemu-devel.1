Received: from eggs.gnu.org ([2001:4830:134:3::10]:48211)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dIGFb-0005gL-Nj
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 11:18:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dIGFV-0004CI-PZ
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 11:18:31 -0400
Received: from mail-wr0-x22c.google.com ([2a00:1450:400c:c0c::22c]:33630)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dIGFV-0004C8-Ii
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 11:18:25 -0400
Received: by mail-wr0-x22c.google.com with SMTP id v104so55724565wrb.0
	for <qemu-devel@nongnu.org>; Tue, 06 Jun 2017 08:18:25 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <b690a50d-4ab3-830c-93a3-5f2b4b027448@greensocs.com>
References: <1488276185-31168-1-git-send-email-fred.konrad@greensocs.com>
	<b690a50d-4ab3-830c-93a3-5f2b4b027448@greensocs.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 6 Jun 2017 16:18:04 +0100
Message-ID: <CAFEAcA94RykH0U33F0aGEYRs_FXF_NNuwQAX_mOf4wVde0s9BQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 00/10] Clock framework API.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: KONRAD Frederic <fred.konrad@greensocs.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Edgar Iglesias <edgar.iglesias@xilinx.com>, Alistair Francis <alistair.francis@xilinx.com>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, Mark Burton <mark.burton@greensocs.com>

On 24 May 2017 at 08:35, KONRAD Frederic <fred.konrad@greensocs.com> wrote:
> Le 28/02/2017 =C3=A0 11:02, fred.konrad@greensocs.com a =C3=A9crit :
>> This is the third version of the clock framework API it contains:
>>
>>   * The first 6 patches which introduce the framework.
>>   * The 7th patch which introduces a fixed-clock model.
>>   * The rest which gives an example how to model a PLL from the existing
>>     zynqmp-crf extracted from the qemu xilinx tree.
>>
>> No specific behavior is expected yet when the CRF register set is access=
ed
>> but
>> the user can see for example the dp_video_ref and vpll_to_lpd rate
>> changing in
>> the monitor with the "info qtree" command when the vpll_ctrl register is
>> modified.

Some top-level review:

* I like the documentation, this is very helpful
* consider tracepoints rather than DPRINTF macro
* qemu_clk_device_add_clock() does a g_strdup, but when is this freed?
  (consider devices which are hot-unpluggable)
* similarly, what if a device with a clock with a lot of child nodes
  is destroyed? how are the ClkList structs freed?
* interaction with migration -- how is the "this clock is at this rate"
  state intended to be migrated?
* I'll leave the review of the xilinx patches to the xilinx folk
* the 'introduce zynqmp_crf' patch is missing any signoffs
  (in particular if it's from the xilinx tree it will need
  signoff from them)

thanks
-- PMM
