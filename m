Return-Path: <SRS0=fJPX=DJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CC23C4363D
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 13:51:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BA4EC20679
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 13:51:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="riP4D1WT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA4EC20679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41724 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kOLTK-0001OZ-Kx
	for qemu-devel@archiver.kernel.org; Fri, 02 Oct 2020 09:51:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51040)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kOLRJ-0008TI-Vi
 for qemu-devel@nongnu.org; Fri, 02 Oct 2020 09:49:38 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:38913)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kOLRH-0006cH-8b
 for qemu-devel@nongnu.org; Fri, 02 Oct 2020 09:49:37 -0400
Received: by mail-wm1-x344.google.com with SMTP id t17so1836665wmi.4
 for <qemu-devel@nongnu.org>; Fri, 02 Oct 2020 06:49:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=RML21w01yLrsBh7+LKzrPlhCw4WlEmlQLil1ya3FxhM=;
 b=riP4D1WTZ3PI/NkXX4SwqF/LocH24eVxPN7WF4t/YWnenOB6wX/RWQGNRJSc5V0x+I
 IMSH/2Zdr/xd71rx0tp9NmjVT/rBPmIPlSZ7ciGHG0WzZVkJZEvvaghQ1uj0Wyvj1M7s
 T/PA68IacURsp5QLySv8Uqr3Uv14ZCGx+lWAqYBYB7euviL+qkLJ/saoMmw5bx76WIF4
 D/Cu+ZEHCbcehsJToaQe1iJI0lLj5g+0KY654giHI1YtDAVXG/G9QLCAy0UwdaHE0fa9
 TIAJlug/2Vflowzja0Ti78jLUCzI+drMKPwTGy+oXhkG3yel/x+AzcwlczDtOA+vw2aJ
 zJNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=RML21w01yLrsBh7+LKzrPlhCw4WlEmlQLil1ya3FxhM=;
 b=PtwgQKp47eCTJZuQZy1ox6KlGoKP/hqUpSxed/Ly5uWDdQSgjYskF090a04c3JFtI3
 4v5OXhuRXqdqxJIyz2wTx4x27wRbrzDtGDfVFt7QRUHmb6oOJAhiwHBdRf6oZ3fKmarl
 kjqKSnSqrR15H0J/IAH8sLe+9P0HYTbJf2c101Zj2ImP6SzmN6LEsOQVzWyI9JhHpRop
 JnFKAQDk4sBCj9kLdYNLSOlRRpV1CSAWf9CXKDRorwPDgsq6dhJXEVtxkc1SAVkVBydL
 uBzq+3NHbcLmNLMtOaq6465wgQlZrNGIKNYsbU1w1LK8ZD7jmy+UL1d2gxZY77VdhlPW
 QsSA==
X-Gm-Message-State: AOAM530zk5nJHs3eHzCqSg3m8ydKkYTRF91HmvWJpmvhXDSHJlzE6xg+
 TZhnxl5GmJQkyaz3TK0Jpd8=
X-Google-Smtp-Source: ABdhPJyA5usdxZwGfWCM4gydYozYhkfOD9SixaF1MSI/lAezulKEUtpOP//7nzqvSgBvTWO+Eww0Yg==
X-Received: by 2002:a1c:b18a:: with SMTP id a132mr2618731wmf.59.1601646573560; 
 Fri, 02 Oct 2020 06:49:33 -0700 (PDT)
Received: from [192.168.1.36] (74.red-83-53-161.dynamicip.rima-tde.net.
 [83.53.161.74])
 by smtp.gmail.com with ESMTPSA id v4sm1754572wml.46.2020.10.02.06.49.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 02 Oct 2020 06:49:32 -0700 (PDT)
Subject: Re: [PATCH v10 3/4] tests/qtest: Introduce tests for Xilinx ZynqMP
 CAN controller
To: Vikram Garhwal <fnu.vikram@xilinx.com>, qemu-devel@nongnu.org
References: <1600121324-31337-1-git-send-email-fnu.vikram@xilinx.com>
 <1600121324-31337-4-git-send-email-fnu.vikram@xilinx.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <45862419-9bb8-ab23-baef-29d4b2c41ffc@amsat.org>
Date: Fri, 2 Oct 2020 15:49:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <1600121324-31337-4-git-send-email-fnu.vikram@xilinx.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x344.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25, NICE_REPLY_A=-0.256,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Laurent Vivier <lvivier@redhat.com>, peter.maydell@linaro.org,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 francisco.iglesias@xilinx.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Vikram,

On 9/15/20 12:08 AM, Vikram Garhwal wrote:
> The QTests perform five tests on the Xilinx ZynqMP CAN controller:
>     Tests the CAN controller in loopback, sleep and snoop mode.
>     Tests filtering of incoming CAN messages.
> 
> Reviewed-by: Francisco Iglesias <francisco.iglesias@xilinx.com>
> Signed-off-by: Vikram Garhwal <fnu.vikram@xilinx.com>
> ---
>  tests/qtest/meson.build     |   1 +
>  tests/qtest/xlnx-can-test.c | 359 ++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 360 insertions(+)
>  create mode 100644 tests/qtest/xlnx-can-test.c
> 
> diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
> index 874b5be..945f86c 100644
> --- a/tests/qtest/meson.build
> +++ b/tests/qtest/meson.build
> @@ -148,6 +148,7 @@ qtests_aarch64 = \
>    (config_all_devices.has_key('CONFIG_TPM_TIS_SYSBUS') ? ['tpm-tis-device-swtpm-test'] : []) +  \
>    ['numa-test',
>     'boot-serial-test',
> +   'xlnx-can-test',
>     'migration-test']
>  
>  qtests_s390x = \
> diff --git a/tests/qtest/xlnx-can-test.c b/tests/qtest/xlnx-can-test.c
> new file mode 100644
> index 0000000..d04189f
> --- /dev/null
> +++ b/tests/qtest/xlnx-can-test.c
> @@ -0,0 +1,359 @@
> +/*
> + * QTests for the Xilinx ZynqMP CAN controller.
> + *
> + * Copyright (c) 2020 Xilinx Inc.
> + *
> + * Written-by: Vikram Garhwal<fnu.vikram@xilinx.com>
> + *
> + * Permission is hereby granted, free of charge, to any person obtaining a copy
> + * of this software and associated documentation files (the "Software"), to deal
> + * in the Software without restriction, including without limitation the rights
> + * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
> + * copies of the Software, and to permit persons to whom the Software is
> + * furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice shall be included in
> + * all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
> + * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
> + * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
> + * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
> + * THE SOFTWARE.
> + */
> +
> +#include "qemu/osdep.h"
> +#include "libqos/libqtest.h"
> +
> +/* Base address. */
> +#define CAN0_BASE_ADDR          0xFF060000
> +#define CAN1_BASE_ADDR          0xFF070000
> +
> +/* Register addresses. */
> +#define R_SRR_OFFSET            0x00
> +#define R_MSR_OFFSET            0x04
> +#define R_SR_OFFSET             0x18
> +#define R_ISR_OFFSET            0x1C
> +#define R_ICR_OFFSET            0x24
> +#define R_TXID_OFFSET           0x30
> +#define R_TXDLC_OFFSET          0x34
> +#define R_TXDATA1_OFFSET        0x38
> +#define R_TXDATA2_OFFSET        0x3C
> +#define R_RXID_OFFSET           0x50
> +#define R_RXDLC_OFFSET          0x54
> +#define R_RXDATA1_OFFSET        0x58
> +#define R_RXDATA2_OFFSET        0x5C
> +#define R_AFR                   0x60
> +#define R_AFMR1                 0x64
> +#define R_AFIR1                 0x68
> +#define R_AFMR2                 0x6C
> +#define R_AFIR2                 0x70
> +#define R_AFMR3                 0x74
> +#define R_AFIR3                 0x78
> +#define R_AFMR4                 0x7C
> +#define R_AFIR4                 0x80
> +
> +/* CAN modes. */
> +#define CONFIG_MODE             0x00
> +#define NORMAL_MODE             0x00
> +#define LOOPBACK_MODE           0x02
> +#define SNOOP_MODE              0x04
> +#define SLEEP_MODE              0x01
> +#define ENABLE_CAN              (1 << 1)
> +#define STATUS_NORMAL_MODE      (1 << 3)
> +#define STATUS_LOOPBACK_MODE    (1 << 1)
> +#define STATUS_SNOOP_MODE       (1 << 12)
> +#define STATUS_SLEEP_MODE       (1 << 2)
> +#define ISR_TXOK                (1 << 1)
> +#define ISR_RXOK                (1 << 4)
> +
> +static void match_rx_tx_data(uint32_t *buf_tx, uint32_t *buf_rx,
> +                             uint8_t can_timestamp)

Both buf_tx/buf_rx should be const.

> +{
> +    uint16_t size = 0;
> +    uint8_t len = 4;
> +
> +    while (size < len) {
> +        if (R_RXID_OFFSET + 4 * size == R_RXDLC_OFFSET)  {
> +            g_assert_cmpint(buf_rx[size], ==, buf_tx[size] + can_timestamp);
> +        } else {
> +            g_assert_cmpint(buf_rx[size], ==, buf_tx[size]);
> +        }
> +
> +        size++;
> +    }
> +}
> +
> +static void read_data(QTestState *qts, uint64_t can_base_addr, uint32_t *buf_rx)
> +{
> +    uint32_t int_status;
> +
> +    /* Read the interrupt on CAN rx. */
> +    int_status = qtest_readl(qts, can_base_addr + R_ISR_OFFSET) & ISR_RXOK;
> +
> +    g_assert_cmpint(int_status, ==, ISR_RXOK);
> +
> +    /* Read the RX register data for CAN. */
> +    buf_rx[0] = qtest_readl(qts, can_base_addr + R_RXID_OFFSET);
> +    buf_rx[1] = qtest_readl(qts, can_base_addr + R_RXDLC_OFFSET);
> +    buf_rx[2] = qtest_readl(qts, can_base_addr + R_RXDATA1_OFFSET);
> +    buf_rx[3] = qtest_readl(qts, can_base_addr + R_RXDATA2_OFFSET);
> +
> +    /* Clear the RX interrupt. */
> +    qtest_writel(qts, CAN1_BASE_ADDR + R_ICR_OFFSET, ISR_RXOK);
> +}
> +
> +static void send_data(QTestState *qts, uint64_t can_base_addr, uint32_t *buf_tx)
> +{

buf_tx should be const.

> +    uint32_t int_status;
> +
> +    /* Write the TX register data for CAN. */
> +    qtest_writel(qts, can_base_addr + R_TXID_OFFSET, buf_tx[0]);
> +    qtest_writel(qts, can_base_addr + R_TXDLC_OFFSET, buf_tx[1]);
> +    qtest_writel(qts, can_base_addr + R_TXDATA1_OFFSET, buf_tx[2]);
> +    qtest_writel(qts, can_base_addr + R_TXDATA2_OFFSET, buf_tx[3]);
> +
> +    /* Read the interrupt on CAN for tx. */
> +    int_status = qtest_readl(qts, can_base_addr + R_ISR_OFFSET) & ISR_TXOK;
> +
> +    g_assert_cmpint(int_status, ==, ISR_TXOK);
> +
> +    /* Clear the interrupt for tx. */
> +    qtest_writel(qts, CAN0_BASE_ADDR + R_ICR_OFFSET, ISR_TXOK);
> +}
> +
> +/*
> + * This test will be transferring data from CAN0 and CAN1 through canbus. CAN0
> + * initiate the data transfer to can-bus, CAN1 receives the data. Test compares
> + * the data sent from CAN0 with received on CAN1.
> + */
> +static void test_can_bus(void)
> +{
> +    uint32_t buf_tx[4] = { 0xFF, 0x80000000, 0x12345678, 0x87654321 };

buf_tx should be const (similarly in the followng tests).

Can probably be cleaned on top of this patch, so:
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> +    uint32_t buf_rx[4] = { 0x00, 0x00, 0x00, 0x00 };
> +    uint32_t status = 0;
> +    uint8_t can_timestamp = 1;
> +
> +    QTestState *qts = qtest_init("-machine xlnx-zcu102"
> +                " -object can-bus,id=canbus0"
> +                " -machine xlnx-zcu102.canbus0=canbus0"
> +                " -machine xlnx-zcu102.canbus1=canbus0"
> +                );
> +
> +    /* Configure the CAN0 and CAN1. */
> +    qtest_writel(qts, CAN0_BASE_ADDR + R_SRR_OFFSET, ENABLE_CAN);
> +    qtest_writel(qts, CAN0_BASE_ADDR + R_MSR_OFFSET, NORMAL_MODE);
> +    qtest_writel(qts, CAN1_BASE_ADDR + R_SRR_OFFSET, ENABLE_CAN);
> +    qtest_writel(qts, CAN1_BASE_ADDR + R_MSR_OFFSET, NORMAL_MODE);
> +
> +    /* Check here if CAN0 and CAN1 are in normal mode. */
> +    status = qtest_readl(qts, CAN0_BASE_ADDR + R_SR_OFFSET);
> +    g_assert_cmpint(status, ==, STATUS_NORMAL_MODE);
> +
> +    status = qtest_readl(qts, CAN1_BASE_ADDR + R_SR_OFFSET);
> +    g_assert_cmpint(status, ==, STATUS_NORMAL_MODE);
> +
> +    send_data(qts, CAN0_BASE_ADDR, buf_tx);
> +
> +    read_data(qts, CAN1_BASE_ADDR, buf_rx);
> +    match_rx_tx_data(buf_tx, buf_rx, can_timestamp);
> +
> +    qtest_quit(qts);
> +}
> +
> +/*
> + * This test is performing loopback mode on CAN0 and CAN1. Data sent from TX of
> + * each CAN0 and CAN1 are compared with RX register data for respective CAN.
> + */
> +static void test_can_loopback(void)
> +{
> +    uint32_t buf_tx[4] = { 0xFF, 0x80000000, 0x12345678, 0x87654321 };
> +    uint32_t buf_rx[4] = { 0x00, 0x00, 0x00, 0x00 };
> +    uint32_t status = 0;
> +
> +    QTestState *qts = qtest_init("-machine xlnx-zcu102"
> +                " -object can-bus,id=canbus0"
> +                " -machine xlnx-zcu102.canbus0=canbus0"
> +                " -machine xlnx-zcu102.canbus1=canbus0"
> +                );
> +
> +    /* Configure the CAN0 in loopback mode. */
> +    qtest_writel(qts, CAN0_BASE_ADDR + R_SRR_OFFSET, CONFIG_MODE);
> +    qtest_writel(qts, CAN0_BASE_ADDR + R_MSR_OFFSET, LOOPBACK_MODE);
> +    qtest_writel(qts, CAN0_BASE_ADDR + R_SRR_OFFSET, ENABLE_CAN);
> +
> +    /* Check here if CAN0 is set in loopback mode. */
> +    status = qtest_readl(qts, CAN0_BASE_ADDR + R_SR_OFFSET);
> +
> +    g_assert_cmpint(status, ==, STATUS_LOOPBACK_MODE);
> +
> +    send_data(qts, CAN0_BASE_ADDR, buf_tx);
> +    read_data(qts, CAN0_BASE_ADDR, buf_rx);
> +    match_rx_tx_data(buf_tx, buf_rx, 0);
> +
> +    /* Configure the CAN1 in loopback mode. */
> +    qtest_writel(qts, CAN1_BASE_ADDR + R_SRR_OFFSET, CONFIG_MODE);
> +    qtest_writel(qts, CAN1_BASE_ADDR + R_MSR_OFFSET, LOOPBACK_MODE);
> +    qtest_writel(qts, CAN1_BASE_ADDR + R_SRR_OFFSET, ENABLE_CAN);
> +
> +    /* Check here if CAN1 is set in loopback mode. */
> +    status = qtest_readl(qts, CAN1_BASE_ADDR + R_SR_OFFSET);
> +
> +    g_assert_cmpint(status, ==, STATUS_LOOPBACK_MODE);
> +
> +    send_data(qts, CAN1_BASE_ADDR, buf_tx);
> +    read_data(qts, CAN1_BASE_ADDR, buf_rx);
> +    match_rx_tx_data(buf_tx, buf_rx, 0);
> +
> +    qtest_quit(qts);
> +}
> +
> +/*
> + * Enable filters for CAN1. This will filter incoming messages with ID. In this
> + * test message will pass through filter 2.
> + */
> +static void test_can_filter(void)
> +{
> +    uint32_t buf_tx[4] = { 0x14, 0x80000000, 0x12345678, 0x87654321 };
> +    uint32_t buf_rx[4] = { 0x00, 0x00, 0x00, 0x00 };
> +    uint32_t status = 0;
> +    uint8_t can_timestamp = 1;
> +
> +    QTestState *qts = qtest_init("-machine xlnx-zcu102"
> +                " -object can-bus,id=canbus0"
> +                " -machine xlnx-zcu102.canbus0=canbus0"
> +                " -machine xlnx-zcu102.canbus1=canbus0"
> +                );
> +
> +    /* Configure the CAN0 and CAN1. */
> +    qtest_writel(qts, CAN0_BASE_ADDR + R_SRR_OFFSET, ENABLE_CAN);
> +    qtest_writel(qts, CAN0_BASE_ADDR + R_MSR_OFFSET, NORMAL_MODE);
> +    qtest_writel(qts, CAN1_BASE_ADDR + R_SRR_OFFSET, ENABLE_CAN);
> +    qtest_writel(qts, CAN1_BASE_ADDR + R_MSR_OFFSET, NORMAL_MODE);
> +
> +    /* Check here if CAN0 and CAN1 are in normal mode. */
> +    status = qtest_readl(qts, CAN0_BASE_ADDR + R_SR_OFFSET);
> +    g_assert_cmpint(status, ==, STATUS_NORMAL_MODE);
> +
> +    status = qtest_readl(qts, CAN1_BASE_ADDR + R_SR_OFFSET);
> +    g_assert_cmpint(status, ==, STATUS_NORMAL_MODE);
> +
> +    /* Set filter for CAN1 for incoming messages. */
> +    qtest_writel(qts, CAN1_BASE_ADDR + R_AFR, 0x0);
> +    qtest_writel(qts, CAN1_BASE_ADDR + R_AFMR1, 0xF7);
> +    qtest_writel(qts, CAN1_BASE_ADDR + R_AFIR1, 0x121F);
> +    qtest_writel(qts, CAN1_BASE_ADDR + R_AFMR2, 0x5431);
> +    qtest_writel(qts, CAN1_BASE_ADDR + R_AFIR2, 0x14);
> +    qtest_writel(qts, CAN1_BASE_ADDR + R_AFMR3, 0x1234);
> +    qtest_writel(qts, CAN1_BASE_ADDR + R_AFIR3, 0x5431);
> +    qtest_writel(qts, CAN1_BASE_ADDR + R_AFMR4, 0xFFF);
> +    qtest_writel(qts, CAN1_BASE_ADDR + R_AFIR4, 0x1234);
> +
> +    qtest_writel(qts, CAN1_BASE_ADDR + R_AFR, 0xF);
> +
> +    send_data(qts, CAN0_BASE_ADDR, buf_tx);
> +
> +    read_data(qts, CAN1_BASE_ADDR, buf_rx);
> +    match_rx_tx_data(buf_tx, buf_rx, can_timestamp);
> +
> +    qtest_quit(qts);
> +}
> +
> +/* Testing sleep mode on CAN0 while CAN1 is in normal mode. */
> +static void test_can_sleepmode(void)
> +{
> +    uint32_t buf_tx[4] = { 0x14, 0x80000000, 0x12345678, 0x87654321 };
> +    uint32_t buf_rx[4] = { 0x00, 0x00, 0x00, 0x00 };
> +    uint32_t status = 0;
> +    uint8_t can_timestamp = 1;
> +
> +    QTestState *qts = qtest_init("-machine xlnx-zcu102"
> +                " -object can-bus,id=canbus0"
> +                " -machine xlnx-zcu102.canbus0=canbus0"
> +                " -machine xlnx-zcu102.canbus1=canbus0"
> +                );
> +
> +    /* Configure the CAN0. */
> +    qtest_writel(qts, CAN0_BASE_ADDR + R_SRR_OFFSET, CONFIG_MODE);
> +    qtest_writel(qts, CAN0_BASE_ADDR + R_MSR_OFFSET, SLEEP_MODE);
> +    qtest_writel(qts, CAN0_BASE_ADDR + R_SRR_OFFSET, ENABLE_CAN);
> +
> +    qtest_writel(qts, CAN1_BASE_ADDR + R_SRR_OFFSET, ENABLE_CAN);
> +    qtest_writel(qts, CAN1_BASE_ADDR + R_MSR_OFFSET, NORMAL_MODE);
> +
> +    /* Check here if CAN0 is in SLEEP mode and CAN1 in normal mode. */
> +    status = qtest_readl(qts, CAN0_BASE_ADDR + R_SR_OFFSET);
> +    g_assert_cmpint(status, ==, STATUS_SLEEP_MODE);
> +
> +    status = qtest_readl(qts, CAN1_BASE_ADDR + R_SR_OFFSET);
> +    g_assert_cmpint(status, ==, STATUS_NORMAL_MODE);
> +
> +    send_data(qts, CAN1_BASE_ADDR, buf_tx);
> +
> +    /*
> +     * Once CAN1 sends data on can-bus. CAN0 should exit sleep mode.
> +     * Check the CAN0 status now. It should exit the sleep mode and receive the
> +     * incoming data.
> +     */
> +    status = qtest_readl(qts, CAN0_BASE_ADDR + R_SR_OFFSET);
> +    g_assert_cmpint(status, ==, STATUS_NORMAL_MODE);
> +
> +    read_data(qts, CAN0_BASE_ADDR, buf_rx);
> +
> +    match_rx_tx_data(buf_tx, buf_rx, can_timestamp);
> +
> +    qtest_quit(qts);
> +}
> +
> +/* Testing Snoop mode on CAN0 while CAN1 is in normal mode. */
> +static void test_can_snoopmode(void)
> +{
> +    uint32_t buf_tx[4] = { 0x14, 0x80000000, 0x12345678, 0x87654321 };
> +    uint32_t buf_rx[4] = { 0x00, 0x00, 0x00, 0x00 };
> +    uint32_t status = 0;
> +    uint8_t can_timestamp = 1;
> +
> +    QTestState *qts = qtest_init("-machine xlnx-zcu102"
> +                " -object can-bus,id=canbus0"
> +                " -machine xlnx-zcu102.canbus0=canbus0"
> +                " -machine xlnx-zcu102.canbus1=canbus0"
> +                );
> +
> +    /* Configure the CAN0. */
> +    qtest_writel(qts, CAN0_BASE_ADDR + R_SRR_OFFSET, CONFIG_MODE);
> +    qtest_writel(qts, CAN0_BASE_ADDR + R_MSR_OFFSET, SNOOP_MODE);
> +    qtest_writel(qts, CAN0_BASE_ADDR + R_SRR_OFFSET, ENABLE_CAN);
> +
> +    qtest_writel(qts, CAN1_BASE_ADDR + R_SRR_OFFSET, ENABLE_CAN);
> +    qtest_writel(qts, CAN1_BASE_ADDR + R_MSR_OFFSET, NORMAL_MODE);
> +
> +    /* Check here if CAN0 is in SNOOP mode and CAN1 in normal mode. */
> +    status = qtest_readl(qts, CAN0_BASE_ADDR + R_SR_OFFSET);
> +    g_assert_cmpint(status, ==, STATUS_SNOOP_MODE);
> +
> +    status = qtest_readl(qts, CAN1_BASE_ADDR + R_SR_OFFSET);
> +    g_assert_cmpint(status, ==, STATUS_NORMAL_MODE);
> +
> +    send_data(qts, CAN1_BASE_ADDR, buf_tx);
> +
> +    read_data(qts, CAN0_BASE_ADDR, buf_rx);
> +
> +    match_rx_tx_data(buf_tx, buf_rx, can_timestamp);
> +
> +    qtest_quit(qts);
> +}
> +
> +int main(int argc, char **argv)
> +{
> +    g_test_init(&argc, &argv, NULL);
> +
> +    qtest_add_func("/net/can/can_bus", test_can_bus);
> +    qtest_add_func("/net/can/can_loopback", test_can_loopback);
> +    qtest_add_func("/net/can/can_filter", test_can_filter);
> +    qtest_add_func("/net/can/can_test_snoopmode", test_can_snoopmode);
> +    qtest_add_func("/net/can/can_test_sleepmode", test_can_sleepmode);
> +
> +    return g_test_run();
> +}
> 


