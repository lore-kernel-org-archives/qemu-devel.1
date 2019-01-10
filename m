Received: from eggs.gnu.org ([209.51.188.92]:47928)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ghaNA-000624-JM
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 08:27:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ghaN8-0005Z5-QG
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 08:27:48 -0500
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:47056)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ghaN7-0005Xt-A1
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 08:27:46 -0500
Received: by mail-oi1-x241.google.com with SMTP id x202so9221019oif.13
	for <qemu-devel@nongnu.org>; Thu, 10 Jan 2019 05:27:43 -0800 (PST)
MIME-Version: 1.0
References: <1541672153-15529-1-git-send-email-gengdongjiu@huawei.com>
	<1541672153-15529-11-git-send-email-gengdongjiu@huawei.com>
In-Reply-To: <1541672153-15529-11-git-send-email-gengdongjiu@huawei.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 10 Jan 2019 13:27:31 +0000
Message-ID: <CAFEAcA_toKXMDAcjTseB2WquCXkEKqh=GODiG1-tEUa32xy2bQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v15 10/10] target-arm: kvm64: handle SIGBUS
 signal from kernel or KVM
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Dongjiu Geng <gengdongjiu@huawei.com>
Cc: Igor Mammedov <imammedo@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, kvm-devel <kvm@vger.kernel.org>, Shannon Zhao <shannon.zhaosl@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>

On Thu, 8 Nov 2018 at 10:18, Dongjiu Geng <gengdongjiu@huawei.com> wrote:
>
> Add SIGBUS signal handler. In this handler, it checks the SIGBUS type,
> translates the host VA delivered by host to guest PA, then fill this PA
> to guest APEI GHES memory, then notify guest according to the SIGBUS type.
> There are two kinds of SIGBUS that QEMU needs to handle, which are
> BUS_MCEERR_AO and BUS_MCEERR_AR.

> +bool ghes_record_errors(uint32_t notify, uint64_t physical_address)
> +{
> +    uint64_t error_block_addr, read_ack_register_addr;
> +    int read_ack_register = 0, loop = 0;
> +    uint64_t start_addr = le32_to_cpu(ges.ghes_addr_le);
> +    bool ret = GHES_CPER_FAIL;
> +    const uint8_t error_source_id[] = { 0xff, 0xff, 0xff, 0xff,
> +                                        0xff, 0xff, 0xff, 0, 1};
> +
> +    /*
> +     * | +---------------------+ ges.ghes_addr_le
> +     * | |error_block_address0|
> +     * | +---------------------+
> +     * | |error_block_address1|
> +     * | +---------------------+ --+--
> +     * | |    .............    | GHES_ADDRESS_SIZE
> +     * | +---------------------+ --+--
> +     * | |error_block_addressN|
> +     * | +---------------------+
> +     * | | read_ack_register0  |
> +     * | +---------------------+ --+--
> +     * | | read_ack_register1  | GHES_ADDRESS_SIZE
> +     * | +---------------------+ --+--
> +     * | |   .............     |
> +     * | +---------------------+
> +     * | | read_ack_registerN  |
> +     * | +---------------------+ --+--
> +     * | |      CPER           |   |
> +     * | |      ....           | GHES_MAX_RAW_DATA_LENGT
> +     * | |      CPER           |   |
> +     * | +---------------------+ --+--
> +     * | |    ..........       |
> +     * | +---------------------+
> +     * | |      CPER           |
> +     * | |      ....           |
> +     * | |      CPER           |
> +     * | +---------------------+
> +     */
> +    if (physical_address && notify < ACPI_HEST_NOTIFY_RESERVED) {

Why is a zero physical address special here? Shouldn't we be
able to report "the memory backing physaddr 0 has a fault" ?

thanks
-- PMM
