Return-Path: <SRS0=tJVC=74=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10171C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2020 15:05:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE83520663
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2020 15:05:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SvNLD0jo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE83520663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56128 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jkqfi-0008O8-3k
	for qemu-devel@archiver.kernel.org; Mon, 15 Jun 2020 11:05:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34122)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1jkqen-0007mI-Jr
 for qemu-devel@nongnu.org; Mon, 15 Jun 2020 11:04:17 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:27542
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1jkqel-0005hk-VM
 for qemu-devel@nongnu.org; Mon, 15 Jun 2020 11:04:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592233455;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rDXHNn4llN8h05BcHUuuVSe1J4X6+/m4EERYE2Xb/9E=;
 b=SvNLD0joqn8qxai5lDVvE3ADP1oWkPSrfp5bcjVnff4IIum7/gq+muzNtKZHfVTIwdetlm
 cORE3L11/rIn0uh0/fwpUcsDuOz/uUJODIM3fO2EYkWOjm3aXBese6r6RIiV8p9xvA3BsF
 Uv55Ey4clJRx13Hd7cc6dm3SGjmer9Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-319-sfaIdtjINXWot2gpB_YCeQ-1; Mon, 15 Jun 2020 11:04:13 -0400
X-MC-Unique: sfaIdtjINXWot2gpB_YCeQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1D9591054FA6
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2020 15:04:09 +0000 (UTC)
Received: from [10.36.114.197] (ovpn-114-197.ams2.redhat.com [10.36.114.197])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 38C5B5D9CC;
 Mon, 15 Jun 2020 15:04:00 +0000 (UTC)
Subject: Re: [PATCH] tests/qtest/bios-tables: Only run the TPM test with
 CONFIG_TPM enabled
To: Thomas Huth <thuth@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org
References: <20200615125402.12898-1-thuth@redhat.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <647f57b4-b25b-7c90-4324-267f254804bb@redhat.com>
Date: Mon, 15 Jun 2020 17:03:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20200615125402.12898-1-thuth@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.120;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/15 01:17:36
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Laurent Vivier <lvivier@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Thomas,

On 6/15/20 2:54 PM, Thomas Huth wrote:
> "make check-qtest" currently fails if configure has been run with
> "--disable-tpm" - the TPM-related tests can only work if the TPM is
> enabled in the build. So let's use the CONFIG_TPM switch to disable
> the test if TPM is not available.
Please forgive me, I did not notice your patch and sent another one :-(

Either fix is fine for me.

Thanks

Eric
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  tests/qtest/bios-tables-test.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/tests/qtest/bios-tables-test.c b/tests/qtest/bios-tables-test.c
> index 53f104a9c5..d170a617d8 100644
> --- a/tests/qtest/bios-tables-test.c
> +++ b/tests/qtest/bios-tables-test.c
> @@ -877,6 +877,8 @@ static void test_acpi_piix4_tcg_numamem(void)
>      free_test_data(&data);
>  }
>  
> +#ifdef CONFIG_TPM
> +
>  uint64_t tpm_tis_base_addr;
>  
>  static void test_acpi_tcg_tpm(const char *machine, const char *tpm_if,
> @@ -931,6 +933,8 @@ static void test_acpi_q35_tcg_tpm_tis(void)
>      test_acpi_tcg_tpm("q35", "tis", 0xFED40000);
>  }
>  
> +#endif /* CONFIG_TPM */
> +
>  static void test_acpi_tcg_dimm_pxm(const char *machine)
>  {
>      test_data data;
> @@ -1094,7 +1098,9 @@ int main(int argc, char *argv[])
>              return ret;
>          }
>  
> +#ifdef CONFIG_TPM
>          qtest_add_func("acpi/q35/tpm-tis", test_acpi_q35_tcg_tpm_tis);
> +#endif
>          qtest_add_func("acpi/piix4", test_acpi_piix4_tcg);
>          qtest_add_func("acpi/piix4/bridge", test_acpi_piix4_tcg_bridge);
>          qtest_add_func("acpi/q35", test_acpi_q35_tcg);
> 


