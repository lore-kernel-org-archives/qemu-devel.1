Return-Path: <SRS0=wemX=7X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 870BDC433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 16:40:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 59996206F4
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 16:40:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59996206F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36908 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jj3mW-0003bi-Jn
	for qemu-devel@archiver.kernel.org; Wed, 10 Jun 2020 12:40:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41106)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1jj3l2-0001Du-27; Wed, 10 Jun 2020 12:39:20 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:58332
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1jj3l0-0007ph-Fc; Wed, 10 Jun 2020 12:39:19 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 05AGX3Sf074688; Wed, 10 Jun 2020 12:39:16 -0400
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0b-001b2d01.pphosted.com with ESMTP id 31k1c8m26e-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 10 Jun 2020 12:39:15 -0400
Received: from m0098414.ppops.net (m0098414.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 05AGX48f074865;
 Wed, 10 Jun 2020 12:39:15 -0400
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com
 [169.63.214.131])
 by mx0b-001b2d01.pphosted.com with ESMTP id 31k1c8m267-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 10 Jun 2020 12:39:15 -0400
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
 by ppma01dal.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 05AGZ4TH016637;
 Wed, 10 Jun 2020 16:39:14 GMT
Received: from b01cxnp22035.gho.pok.ibm.com (b01cxnp22035.gho.pok.ibm.com
 [9.57.198.25]) by ppma01dal.us.ibm.com with ESMTP id 31hygyh31n-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 10 Jun 2020 16:39:14 +0000
Received: from b01ledav004.gho.pok.ibm.com (b01ledav004.gho.pok.ibm.com
 [9.57.199.109])
 by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 05AGdDqD49742320
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 10 Jun 2020 16:39:13 GMT
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A5567112062;
 Wed, 10 Jun 2020 16:39:13 +0000 (GMT)
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9329F112061;
 Wed, 10 Jun 2020 16:39:13 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
 by b01ledav004.gho.pok.ibm.com (Postfix) with ESMTP;
 Wed, 10 Jun 2020 16:39:13 +0000 (GMT)
Subject: Re: [PATCH v2 4/5] bios-tables-test: Add Q35/TPM-TIS test
To: Eric Auger <eric.auger@redhat.com>, eric.auger.pro@gmail.com,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, peter.maydell@linaro.org,
 mst@redhat.com, shannon.zhaosl@gmail.com, imammedo@redhat.com
References: <20200609125409.24179-1-eric.auger@redhat.com>
 <20200609125409.24179-5-eric.auger@redhat.com>
From: Stefan Berger <stefanb@linux.ibm.com>
Message-ID: <657c5530-728f-fd1d-fd4e-e0ca62cdd029@linux.ibm.com>
Date: Wed, 10 Jun 2020 12:39:13 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200609125409.24179-5-eric.auger@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216, 18.0.687
 definitions=2020-06-10_10:2020-06-10,
 2020-06-10 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015
 impostorscore=0 mlxlogscore=999 spamscore=0 suspectscore=2 bulkscore=0
 adultscore=0 priorityscore=1501 lowpriorityscore=0 mlxscore=0
 cotscore=-2147483648 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2006100126
Received-SPF: pass client-ip=148.163.158.5; envelope-from=stefanb@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/10 12:38:09
X-ACL-Warn: Detected OS   = Linux 3.x [generic] [fuzzy]
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: marcandre.lureau@redhat.com, drjones@redhat.com, lersek@redhat.com,
 ardb@kernel.org, philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/9/20 8:54 AM, Eric Auger wrote:
> Test tables specific to the TPM-TIS instantiation.
> The TPM2 is added in the framework. Also the DSDT
> is updated with the TPM. The new function should be
> be usable for CRB as well, later one.
>
> Signed-off-by: Eric Auger <eric.auger@redhat.com>

Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>


>
> ---
>
> v2 -> v3:
> - use test_acpi_tcg_tpm() helper and stick to the current
>    qtest_add_func model
> - hardcode TPM_TIS_ADDR_BASE
> ---
>   tests/qtest/bios-tables-test.c | 58 ++++++++++++++++++++++++++++++++++
>   tests/qtest/Makefile.include   |  1 +
>   2 files changed, 59 insertions(+)
>
> diff --git a/tests/qtest/bios-tables-test.c b/tests/qtest/bios-tables-test.c
> index c9843829b3..53f104a9c5 100644
> --- a/tests/qtest/bios-tables-test.c
> +++ b/tests/qtest/bios-tables-test.c
> @@ -57,6 +57,9 @@
>   #include "qemu/bitmap.h"
>   #include "acpi-utils.h"
>   #include "boot-sector.h"
> +#include "tpm-emu.h"
> +#include "hw/acpi/tpm.h"
> +
>   
>   #define MACHINE_PC "pc"
>   #define MACHINE_Q35 "q35"
> @@ -874,6 +877,60 @@ static void test_acpi_piix4_tcg_numamem(void)
>       free_test_data(&data);
>   }
>   
> +uint64_t tpm_tis_base_addr;
> +
> +static void test_acpi_tcg_tpm(const char *machine, const char *tpm_if,
> +                              uint64_t base)
> +{
> +    gchar *tmp_dir_name = g_strdup_printf("qemu-test_acpi_%s_tcg_%s.XXXXXX",
> +                                          machine, tpm_if);
> +    char *tmp_path = g_dir_make_tmp(tmp_dir_name, NULL);
> +    TestState test;
> +    test_data data;
> +    GThread *thread;
> +    char *args, *variant = g_strdup_printf(".%s", tpm_if);
> +
> +    tpm_tis_base_addr = base;
> +
> +    module_call_init(MODULE_INIT_QOM);
> +
> +    test.addr = g_new0(SocketAddress, 1);
> +    test.addr->type = SOCKET_ADDRESS_TYPE_UNIX;
> +    test.addr->u.q_unix.path = g_build_filename(tmp_path, "sock", NULL);
> +    g_mutex_init(&test.data_mutex);
> +    g_cond_init(&test.data_cond);
> +    test.data_cond_signal = false;
> +
> +    thread = g_thread_new(NULL, tpm_emu_ctrl_thread, &test);
> +    tpm_emu_test_wait_cond(&test);
> +
> +    memset(&data, 0, sizeof(data));
> +    data.machine = machine;
> +    data.variant = variant;
> +
> +    args = g_strdup_printf(
> +        " -chardev socket,id=chr,path=%s"
> +        " -tpmdev emulator,id=dev,chardev=chr"
> +        " -device tpm-%s,tpmdev=dev",
> +        test.addr->u.q_unix.path, tpm_if);
> +
> +    test_acpi_one(args, &data);
> +
> +    g_thread_join(thread);
> +    g_unlink(test.addr->u.q_unix.path);
> +    qapi_free_SocketAddress(test.addr);
> +    g_rmdir(tmp_path);
> +    g_free(variant);
> +    g_free(tmp_path);
> +    g_free(tmp_dir_name);
> +    free_test_data(&data);
> +}
> +
> +static void test_acpi_q35_tcg_tpm_tis(void)
> +{
> +    test_acpi_tcg_tpm("q35", "tis", 0xFED40000);
> +}
> +
>   static void test_acpi_tcg_dimm_pxm(const char *machine)
>   {
>       test_data data;
> @@ -1037,6 +1094,7 @@ int main(int argc, char *argv[])
>               return ret;
>           }
>   
> +        qtest_add_func("acpi/q35/tpm-tis", test_acpi_q35_tcg_tpm_tis);
>           qtest_add_func("acpi/piix4", test_acpi_piix4_tcg);
>           qtest_add_func("acpi/piix4/bridge", test_acpi_piix4_tcg_bridge);
>           qtest_add_func("acpi/q35", test_acpi_q35_tcg);
> diff --git a/tests/qtest/Makefile.include b/tests/qtest/Makefile.include
> index 9e5a51d033..5023fa413d 100644
> --- a/tests/qtest/Makefile.include
> +++ b/tests/qtest/Makefile.include
> @@ -262,6 +262,7 @@ tests/qtest/hd-geo-test$(EXESUF): tests/qtest/hd-geo-test.o $(libqos-obj-y)
>   tests/qtest/boot-order-test$(EXESUF): tests/qtest/boot-order-test.o $(libqos-obj-y)
>   tests/qtest/boot-serial-test$(EXESUF): tests/qtest/boot-serial-test.o $(libqos-obj-y)
>   tests/qtest/bios-tables-test$(EXESUF): tests/qtest/bios-tables-test.o \
> +        tests/qtest/tpm-emu.o $(test-io-obj-y) \
>   	tests/qtest/boot-sector.o tests/qtest/acpi-utils.o $(libqos-obj-y)
>   tests/qtest/pxe-test$(EXESUF): tests/qtest/pxe-test.o tests/qtest/boot-sector.o $(libqos-obj-y)
>   tests/qtest/microbit-test$(EXESUF): tests/qtest/microbit-test.o



