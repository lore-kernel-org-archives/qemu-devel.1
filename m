Return-Path: <SRS0=CCzH=3V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CEAAC35249
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Feb 2020 23:49:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1722A20658
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Feb 2020 23:49:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BIK80a7D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1722A20658
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51664 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iy2W7-0002d7-8n
	for qemu-devel@archiver.kernel.org; Sat, 01 Feb 2020 18:49:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56830)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iy2VN-00028S-8Y
 for qemu-devel@nongnu.org; Sat, 01 Feb 2020 18:48:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iy2VL-0008S0-T5
 for qemu-devel@nongnu.org; Sat, 01 Feb 2020 18:48:49 -0500
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:56256)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iy2VI-0008PZ-Pj; Sat, 01 Feb 2020 18:48:45 -0500
Received: by mail-wm1-x341.google.com with SMTP id q9so11940376wmj.5;
 Sat, 01 Feb 2020 15:48:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:autocrypt:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=dySa8/8ujBRlo7j2x6KLB6y+ixgO5/bnoi5m+xJLlOI=;
 b=BIK80a7DOiKTKFCXsEkfqBnvTlNVllqwRymMNgTKhvNvolZ9r59kIveWsPp4Ku/KeP
 41t7ph4oqjE9/Wuok2dpwPYOEMY+4hiVlF/e1BJ7lmGJMjwL8yRhgrqXyFA6GXON8LiD
 Bqox1KTthKGqr0rQFxN5VT3Fn3w9HfnsoiD/xwdhzNmI5FLTc8yJ+lgS+/dpj3WsPFIJ
 gG4HLlOzv7mWV6C0J65iD2X9wHYM99jUsmQoQ6UuTmMZQ64Bh3PGBIAf2Pl6iKK+S10K
 jKCRrVbvuatx81YQPw1xJaqXhKzEx3Ranl6DqaAvse4pAhSvolk1edeVUlPgJ2LJr31G
 P6/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=dySa8/8ujBRlo7j2x6KLB6y+ixgO5/bnoi5m+xJLlOI=;
 b=B3vgrIm/Y2/a7Och/HADW5falUrG6gunrOl4kXS7qDAO6HtpiXjCvSQbuKvODp/DiL
 05tcpODWleZOF72+ONfI4fgv814/bjpNA6fWcSK0nUx1mguk7CiNYHue+p8Y5mnSk6vX
 KpjA2yEGGfom7LMmA/wv1TIXY8h7Kf10aBfpbWYJRfqNDo5buosTp62R4zHOYt3Bq1dT
 ZkeAHy/9z9uSpZqrZnyizxQKTLQzJkdVNYRQUJRxTtIRAOHllNDDRDU3QUzbTsG8H6mp
 gqII1pIjPlJXaI/NKKEAs2e3HwlpSk/V+YPoPGPR84FfKiqCPzna01LWclUOxOGBd0m+
 M2xw==
X-Gm-Message-State: APjAAAU/mtSaAKuYcPpEvwIwXxaUgton0W8mjv9eCMnqOlc8/7Y3/MQZ
 5sqhnklHcv0zoJIqCdBVBj8=
X-Google-Smtp-Source: APXvYqw/mo+3uz/O/xx18l+68Zwv2Ngkie33dgstRSaXwkF/jrRXX27MoN6TcKkWPcWvAfRbYkaAHA==
X-Received: by 2002:a05:600c:d7:: with SMTP id
 u23mr20602928wmm.145.1580600923362; 
 Sat, 01 Feb 2020 15:48:43 -0800 (PST)
Received: from [192.168.1.35] (162.red-83-52-55.dynamicip.rima-tde.net.
 [83.52.55.162])
 by smtp.gmail.com with ESMTPSA id c9sm18565516wrq.44.2020.02.01.15.48.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 01 Feb 2020 15:48:42 -0800 (PST)
Subject: Re: [PATCH] tests: Silent various warnings with pseries
To: Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org
References: <158059697130.1820292.7823434132030453110.stgit@bahia.lan>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Autocrypt: addr=f4bug@amsat.org; keydata=
 mQINBDU8rLoBEADb5b5dyglKgWF9uDbIjFXU4gDtcwiga9wJ/wX6xdhBqU8tlQ4BroH7AeRl
 u4zXP0QnBDAG7EetxlQzcfYbPmxFISWjckDBFvDbFsojrZmwF2/LkFSzlvKiN5KLghzzJhLO
 HhjGlF8deEZz/d/G8qzO9mIw8GIBS8uuWh6SIcG/qq7+y+2+aifaj92EdwU79apZepT/U3vN
 YrfcAuo1Ycy7/u0hJ7rlaFUn2Fu5KIgV2O++hHYtCCQfdPBg/+ujTL+U+sCDawCyq+9M5+LJ
 ojCzP9rViLZDd/gS6jX8T48hhidtbtsFRj/e9QpdZgDZfowRMVsRx+TB9yzjFdMO0YaYybXp
 dg/wCUepX5xmDBrle6cZ8VEe00+UQCAU1TY5Hs7QFfBbjgR3k9pgJzVXNUKcJ9DYQP0OBH9P
 ZbZvM0Ut2Bk6bLBO5iCVDOco0alrPkX7iJul2QWBy3Iy9j02GnA5jZ1Xtjr9kpCqQT+sRXso
 Vpm5TPGWaWljIeLWy/qL8drX1eyJzwTB3A36Ck4r3YmjMjfmvltSZB1uAdo1elHTlFEULpU/
 HiwvvqXQ9koB15U154VCuguvx/Qnboz8GFb9Uw8VyawzVxYVNME7xw7CQF8FYxzj6eI7rBf2
 Dj/II6wxWPgDEy3oUzuNOxTB7sT3b/Ym76yOJzWX5BylXQIJ5wARAQABtDFQaGlsaXBwZSBN
 YXRoaWV1LURhdWTDqSAoRjRCVUcpIDxmNGJ1Z0BhbXNhdC5vcmc+iQJVBBMBCAA/AhsPBgsJ
 CAcDAgYVCAIJCgsEFgIDAQIeAQIXgBYhBPqr514SkXIh3P1rsuPjLCzercDeBQJd660aBQks
 klzgAAoJEOPjLCzercDe2iMP+gMG2dUf+qHz2uG8nTBGMjgK0aEJrKVPodFA+iedQ5Kp3BMo
 jrTg3/DG1HMYdcvQu/NFLYwamUfUasyor1k+3dB23hY09O4xOsYJBWdilkBGsJTKErUmkUO2
 3J/kawosvYtJJSHUpw3N6mwz/iWnjkT8BPp7fFXSujV63aZWZINueTbK7Y8skFHI0zpype9s
 loU8xc4JBrieGccy3n4E/kogGrTG5jcMTNHZ106DsQkhFnjhWETp6g9xOKrzZQbETeRBOe4P
 sRsY9YSG2Sj+ZqmZePvO8LyzGRjYU7T6Z80S1xV0lH6KTMvq7vvz5rd92f3pL4YrXq+e//HZ
 JsiLen8LH/FRhTsWRgBtNYkOsd5F9NvfJtSM0qbX32cSXMAStDVnS4U+H2vCVCWnfNug2TdY
 7v4NtdpaCi4CBBa3ZtqYVOU05IoLnlx0miKTBMqmI05kpgX98pi2QUPJBYi/+yNu3fjjcuS9
 K5WmpNFTNi6yiBbNjJA5E2qUKbIT/RwQFQvhrxBUcRCuK4x/5uOZrysjFvhtR8YGm08h+8vS
 n0JCnJD5aBhiVdkohEFAz7e5YNrAg6kOA5IVRHB44lTBOatLqz7ntwdGD0rteKuHaUuXpTYy
 CRqCVAKqFJtxhvJvaX0vLS1Z2dwtDwhjfIdgPiKEGOgCNGH7R8l+aaM4OPOd
Message-ID: <e98c39d3-570c-ec44-5a33-16db0c466868@amsat.org>
Date: Sun, 2 Feb 2020 00:48:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <158059697130.1820292.7823434132030453110.stgit@bahia.lan>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
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
Cc: Laurent Vivier <lvivier@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Greg,

On 2/1/20 11:46 PM, Greg Kurz wrote:
> Some default features of the pseries machine are only available with
> KVM. Warnings are printed when the pseries machine is used with another
> accelerator:
> 
> qemu-system-ppc64: warning: TCG doesn't support requested feature,
> cap-ccf-assist=on
> qemu-system-ppc64: warning: Firmware Assisted Non-Maskable
> Interrupts(FWNMI) not supported in TCG
> qemu-system-ppc64: warning: TCG doesn't support requested feature,
> cap-ccf-assist=on
> qemu-system-ppc64: warning: Firmware Assisted Non-Maskable
> Interrupts(FWNMI) not supported in TCG
> qemu-system-ppc64: warning: TCG doesn't support requested feature,
> cap-ccf-assist=on
> qemu-system-ppc64: warning: Firmware Assisted Non-Maskable
> Interrupts(FWNMI) not supported in TCG
> 
> This is annoying for CI since it usually runs without KVM. We already
> disable features that emit similar warnings thanks to properties of the
> pseries machine, but this is open-coded in various places. Consolidate
> the set of properties in a single place. Extend it to silent the above
> warnings. And use it in the various tests that start pseries machines.
> 

Due to https://www.mail-archive.com/qemu-devel@nongnu.org/msg675825.html
I'd add:

Reported-by: Peter Maydell <peter.maydell@linaro.org>

> Signed-off-by: Greg Kurz <groug@kaod.org>
> ---
> 
> This patch fixes the warnings observed with David's latest pull request.
> 
>  tests/qtest/boot-serial-test.c    |    3 ++-
>  tests/qtest/libqos/libqos-spapr.h |    8 ++++++++
>  tests/qtest/prom-env-test.c       |    3 ++-
>  tests/qtest/pxe-test.c            |    7 ++++---
>  4 files changed, 16 insertions(+), 5 deletions(-)
> 
> diff --git a/tests/qtest/boot-serial-test.c b/tests/qtest/boot-serial-test.c
> index 8e8c5b0a0f0c..85a361428697 100644
> --- a/tests/qtest/boot-serial-test.c
> +++ b/tests/qtest/boot-serial-test.c
> @@ -15,6 +15,7 @@
>  
>  #include "qemu/osdep.h"
>  #include "libqtest.h"
> +#include "libqos/libqos-spapr.h"
>  
>  static const uint8_t kernel_mcf5208[] = {
>      0x41, 0xf9, 0xfc, 0x06, 0x00, 0x00,     /* lea 0xfc060000,%a0 */
> @@ -112,7 +113,7 @@ static testdef_t tests[] = {
>      { "ppc64", "40p", "-m 192", "Memory: 192M" },
>      { "ppc64", "mac99", "", "PowerPC,970FX" },
>      { "ppc64", "pseries",
> -      "-machine cap-cfpc=broken,cap-sbbc=broken,cap-ibs=broken",
> +      "-machine " PSERIES_DEFAULT_CAPABILITIES,
>        "Open Firmware" },
>      { "ppc64", "powernv8", "", "OPAL" },
>      { "ppc64", "powernv9", "", "OPAL" },
> diff --git a/tests/qtest/libqos/libqos-spapr.h b/tests/qtest/libqos/libqos-spapr.h
> index dcb5c43ad37d..e4460d08ae6e 100644
> --- a/tests/qtest/libqos/libqos-spapr.h
> +++ b/tests/qtest/libqos/libqos-spapr.h
> @@ -7,4 +7,12 @@ QOSState *qtest_spapr_vboot(const char *cmdline_fmt, va_list ap);
>  QOSState *qtest_spapr_boot(const char *cmdline_fmt, ...);
>  void qtest_spapr_shutdown(QOSState *qs);
>  
> +/* List of capabilities needed to silent warnings with TCG */
> +#define PSERIES_DEFAULT_CAPABILITIES             \
> +    "cap-cfpc=broken,"                           \
> +    "cap-sbbc=broken,"                           \
> +    "cap-ibs=broken,"                            \
> +    "cap-ccf-assist=off,"                        \
> +    "cap-fwnmi-mce=off"
> +
>  #endif
> diff --git a/tests/qtest/prom-env-test.c b/tests/qtest/prom-env-test.c
> index 9be52c766fe3..60e6ec315335 100644
> --- a/tests/qtest/prom-env-test.c
> +++ b/tests/qtest/prom-env-test.c
> @@ -21,6 +21,7 @@
>  
>  #include "qemu/osdep.h"
>  #include "libqtest.h"
> +#include "libqos/libqos-spapr.h"
>  
>  #define MAGIC   0xcafec0de
>  #define ADDRESS 0x4000
> @@ -54,7 +55,7 @@ static void test_machine(const void *machine)
>       */
>      if (strcmp(machine, "pseries") == 0) {
>          extra_args = "-nodefaults"
> -            " -machine cap-cfpc=broken,cap-sbbc=broken,cap-ibs=broken";
> +            " -machine " PSERIES_DEFAULT_CAPABILITIES;
>      }
>  
>      qts = qtest_initf("-M %s -accel tcg %s -prom-env 'use-nvramrc?=true' "
> diff --git a/tests/qtest/pxe-test.c b/tests/qtest/pxe-test.c
> index f68d0aadbb4d..1161a773a4a7 100644
> --- a/tests/qtest/pxe-test.c
> +++ b/tests/qtest/pxe-test.c
> @@ -17,6 +17,7 @@
>  #include "qemu-common.h"
>  #include "libqtest.h"
>  #include "boot-sector.h"
> +#include "libqos/libqos-spapr.h"
>  
>  #define NETNAME "net0"
>  
> @@ -46,15 +47,15 @@ static testdef_t x86_tests_slow[] = {
>  
>  static testdef_t ppc64_tests[] = {
>      { "pseries", "spapr-vlan",
> -      "-machine cap-cfpc=broken,cap-sbbc=broken,cap-ibs=broken,vsmt=8" },
> +      "-machine vsmt=8," PSERIES_DEFAULT_CAPABILITIES },
>      { "pseries", "virtio-net-pci",
> -      "-machine cap-cfpc=broken,cap-sbbc=broken,cap-ibs=broken,vsmt=8" },
> +      "-machine vsmt=8," PSERIES_DEFAULT_CAPABILITIES },
>      { NULL },
>  };
>  
>  static testdef_t ppc64_tests_slow[] = {
>      { "pseries", "e1000",
> -      "-machine cap-cfpc=broken,cap-sbbc=broken,cap-ibs=broken,vsmt=8" },
> +      "-machine vsmt=8," PSERIES_DEFAULT_CAPABILITIES },
>      { NULL },
>  };
>  
> 
> 

