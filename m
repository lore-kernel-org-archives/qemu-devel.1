Return-Path: <SRS0=tJVC=74=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37C83C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2020 16:27:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 015C1207F5
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2020 16:27:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c0LIYHKL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 015C1207F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60484 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jkrx9-0005fK-4u
	for qemu-devel@archiver.kernel.org; Mon, 15 Jun 2020 12:27:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55846)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jkrw3-0004Fe-J9
 for qemu-devel@nongnu.org; Mon, 15 Jun 2020 12:26:11 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:37828
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jkrw1-0005zg-Fl
 for qemu-devel@nongnu.org; Mon, 15 Jun 2020 12:26:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592238368;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=00FXCB2yidhJiULOJDZcEYz8JWa1gwYhziImrZ06J3Q=;
 b=c0LIYHKLvT4LlCEa6rcgrweNwUcxG2ZMX5OoHnstsppVFnx4Kc5mG8x+Q7kPoiGlnteqTN
 83QviHiC5lePCZFbFpT9YfMi+u5phxiCAaPnlBtyciPgEZg+QeukjPWlnIbQrsyWEMTmRL
 dB2Yl9kkAf1DBd7yaZniYWECydVNFt0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-87-2GzG0F6KOpegitOqR8HYwg-1; Mon, 15 Jun 2020 12:26:06 -0400
X-MC-Unique: 2GzG0F6KOpegitOqR8HYwg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C17F91981086;
 Mon, 15 Jun 2020 16:20:17 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-112-214.ams2.redhat.com [10.36.112.214])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 93A489034B;
 Mon, 15 Jun 2020 16:19:57 +0000 (UTC)
Subject: Re: [PATCH] bios-tables-test: Fix "-tpmdev: invalid option"
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Eric Auger <eric.auger@redhat.com>, eric.auger.pro@gmail.com,
 stefanb@linux.ibm.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 peter.maydell@linaro.org, mst@redhat.com, imammedo@redhat.com
References: <20200615135051.2213-1-eric.auger@redhat.com>
 <aa595991-7f3a-fd83-026b-1b35aaf9c49e@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <34566599-4194-f092-774e-4c60eca647a4@redhat.com>
Date: Mon, 15 Jun 2020 18:19:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <aa595991-7f3a-fd83-026b-1b35aaf9c49e@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/15 01:43:27
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 15/06/2020 16.57, Philippe Mathieu-Daudé wrote:
> On 6/15/20 3:50 PM, Eric Auger wrote:
>> When configure is run with "--disable-tpm", the bios-tables-test
>> q35/tis test fails with "-tpmdev: invalid option".
>>
>> Skip the test if CONFIG_TPM is unset.
>>
>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>> Reported-by: Philippe Mathieu-Daudé <philmd@redhat.com>
>> ---
>>  tests/qtest/bios-tables-test.c | 4 ++++
>>  1 file changed, 4 insertions(+)
>>
>> diff --git a/tests/qtest/bios-tables-test.c b/tests/qtest/bios-tables-test.c
>> index 53f104a9c5..b482f76c03 100644
>> --- a/tests/qtest/bios-tables-test.c
>> +++ b/tests/qtest/bios-tables-test.c
>> @@ -882,6 +882,7 @@ uint64_t tpm_tis_base_addr;
>>  static void test_acpi_tcg_tpm(const char *machine, const char *tpm_if,
>>                                uint64_t base)
>>  {
>> +#ifdef CONFIG_TPM
>>      gchar *tmp_dir_name = g_strdup_printf("qemu-test_acpi_%s_tcg_%s.XXXXXX",
>>                                            machine, tpm_if);
>>      char *tmp_path = g_dir_make_tmp(tmp_dir_name, NULL);
>> @@ -924,6 +925,9 @@ static void test_acpi_tcg_tpm(const char *machine, const char *tpm_if,
>>      g_free(tmp_path);
>>      g_free(tmp_dir_name);
>>      free_test_data(&data);
>> +#else
>> +    g_test_skip("TPM disabled");
>> +#endif
>>  }
>>  
>>  static void test_acpi_q35_tcg_tpm_tis(void)
>>
> 
> This is simpler than Thomas' version.
> 
> Fixes: 5da7c35e25 ("bios-tables-test: Add Q35/TPM-TIS test")
> Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>

Your version is indeed nicer than mine, so let's use yours!

Reviewed-by: Thomas Huth <thuth@redhat.com>


