Return-Path: <SRS0=zj/5=4O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D257FC4BA10
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 13:45:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A60A62467B
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 13:45:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A60A62467B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44542 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6x0P-0005z0-T6
	for qemu-devel@archiver.kernel.org; Wed, 26 Feb 2020 08:45:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46759)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanb@linux.ibm.com>) id 1j6wzV-0005PA-TA
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 08:44:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanb@linux.ibm.com>) id 1j6wzU-0007Sp-An
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 08:44:45 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:40304
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanb@linux.ibm.com>)
 id 1j6wzR-00075v-26; Wed, 26 Feb 2020 08:44:41 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 01QDiCBH100936; Wed, 26 Feb 2020 08:44:39 -0500
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2ydq5ynmn9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 26 Feb 2020 08:44:38 -0500
Received: from m0098413.ppops.net (m0098413.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 01QDicxp102386;
 Wed, 26 Feb 2020 08:44:38 -0500
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com
 [169.62.189.11])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2ydq5ynmma-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 26 Feb 2020 08:44:38 -0500
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
 by ppma03dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 01QDZKWi002313;
 Wed, 26 Feb 2020 13:44:37 GMT
Received: from b01cxnp22035.gho.pok.ibm.com (b01cxnp22035.gho.pok.ibm.com
 [9.57.198.25]) by ppma03dal.us.ibm.com with ESMTP id 2ydcmkpxgt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 26 Feb 2020 13:44:37 +0000
Received: from b01ledav001.gho.pok.ibm.com (b01ledav001.gho.pok.ibm.com
 [9.57.199.106])
 by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 01QDiaiQ50070010
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 26 Feb 2020 13:44:36 GMT
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 265722805A;
 Wed, 26 Feb 2020 13:44:36 +0000 (GMT)
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0C0442805E;
 Wed, 26 Feb 2020 13:44:36 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
 by b01ledav001.gho.pok.ibm.com (Postfix) with ESMTP;
 Wed, 26 Feb 2020 13:44:35 +0000 (GMT)
Subject: Re: [PATCH v3 10/10] test: tpm-tis: Add Sysbus TPM-TIS device test
To: Eric Auger <eric.auger@redhat.com>, eric.auger.pro@gmail.com,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, peter.maydell@linaro.org
References: <20200226102549.12158-1-eric.auger@redhat.com>
 <20200226102549.12158-11-eric.auger@redhat.com>
From: Stefan Berger <stefanb@linux.ibm.com>
Message-ID: <626417fa-8cf3-5e0e-78ec-7f5b77fc0a9f@linux.ibm.com>
Date: Wed, 26 Feb 2020 08:44:35 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20200226102549.12158-11-eric.auger@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.572
 definitions=2020-02-26_04:2020-02-26,
 2020-02-26 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0
 lowpriorityscore=0 adultscore=0 malwarescore=0 mlxlogscore=999
 clxscore=1015 bulkscore=0 suspectscore=2 mlxscore=0 phishscore=0
 priorityscore=1501 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2001150001 definitions=main-2002260102
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by
 mx0b-001b2d01.pphosted.com id 01QDiCBH100936
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 148.163.158.5
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
Cc: marcandre.lureau@redhat.com, lersek@redhat.com, ardb@kernel.org,
 philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/26/20 5:25 AM, Eric Auger wrote:
> The tests themselves are the same as the ISA device ones.
> Only the main() changes as the "tpm-tis-device" device gets
> instantiated. Also the base address of the device is not
> 0xFED40000 anymore but matches the base address of the
> ARM virt platform bus.
>
> Signed-off-by: Eric Auger <eric.auger@redhat.com>

Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>


> ---
>   tests/qtest/Makefile.include            |  5 ++
>   tests/qtest/tpm-tis-device-swtpm-test.c | 76 +++++++++++++++++++++
>   tests/qtest/tpm-tis-device-test.c       | 87 ++++++++++++++++++++++++=
+
>   3 files changed, 168 insertions(+)
>   create mode 100644 tests/qtest/tpm-tis-device-swtpm-test.c
>   create mode 100644 tests/qtest/tpm-tis-device-test.c
>
> diff --git a/tests/qtest/Makefile.include b/tests/qtest/Makefile.includ=
e
> index 44aac68b25..383b0ab217 100644
> --- a/tests/qtest/Makefile.include
> +++ b/tests/qtest/Makefile.include
> @@ -130,6 +130,8 @@ check-qtest-arm-y +=3D hexloader-test
>   check-qtest-arm-$(CONFIG_PFLASH_CFI02) +=3D pflash-cfi02-test
>  =20
>   check-qtest-aarch64-y +=3D arm-cpu-features
> +check-qtest-aarch64-$(CONFIG_TPM_TIS_SYSBUS) +=3D tpm-tis-device-test
> +check-qtest-aarch64-$(CONFIG_TPM_TIS_SYSBUS) +=3D tpm-tis-device-swtpm=
-test
>   check-qtest-aarch64-y +=3D numa-test
>   check-qtest-aarch64-y +=3D boot-serial-test
>   check-qtest-aarch64-y +=3D migration-test
> @@ -302,7 +304,10 @@ tests/qtest/tpm-crb-swtpm-test$(EXESUF): tests/qte=
st/tpm-crb-swtpm-test.o tests/
>   tests/qtest/tpm-crb-test$(EXESUF): tests/qtest/tpm-crb-test.o tests/q=
test/tpm-emu.o $(test-io-obj-y)
>   tests/qtest/tpm-tis-swtpm-test$(EXESUF): tests/qtest/tpm-tis-swtpm-te=
st.o tests/qtest/tpm-emu.o \
>   	tests/qtest/tpm-util.o tests/qtest/tpm-tests.o $(test-io-obj-y)
> +tests/qtest/tpm-tis-device-swtpm-test$(EXESUF): tests/qtest/tpm-tis-de=
vice-swtpm-test.o tests/qtest/tpm-emu.o \
> +	tests/qtest/tpm-util.o tests/qtest/tpm-tests.o $(test-io-obj-y)
>   tests/qtest/tpm-tis-test$(EXESUF): tests/qtest/tpm-tis-test.o tests/q=
test/tpm-tis-util.o tests/qtest/tpm-emu.o $(test-io-obj-y)
> +tests/qtest/tpm-tis-device-test$(EXESUF): tests/qtest/tpm-tis-device-t=
est.o tests/qtest/tpm-tis-util.o tests/qtest/tpm-emu.o $(test-io-obj-y)
>  =20
>   # QTest rules
>  =20
> diff --git a/tests/qtest/tpm-tis-device-swtpm-test.c b/tests/qtest/tpm-=
tis-device-swtpm-test.c
> new file mode 100644
> index 0000000000..7b20035142
> --- /dev/null
> +++ b/tests/qtest/tpm-tis-device-swtpm-test.c
> @@ -0,0 +1,76 @@
> +/*
> + * QTest testcase for Sysbus TPM TIS talking to external swtpm and swt=
pm
> + * migration
> + *
> + * Copyright (c) 2018 IBM Corporation
> + *  with parts borrowed from migration-test.c that is:
> + *     Copyright (c) 2016-2018 Red Hat, Inc. and/or its affiliates
> + *
> + * Authors:
> + *   Stefan Berger <stefanb@linux.vnet.ibm.com>
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or =
later.
> + * See the COPYING file in the top-level directory.
> + */
> +
> +#include "qemu/osdep.h"
> +#include <glib/gstdio.h>
> +
> +#include "libqtest.h"
> +#include "qemu/module.h"
> +#include "tpm-tests.h"
> +#include "hw/acpi/tpm.h"
> +
> +uint64_t tpm_tis_base_addr =3D 0xc000000;
> +#define MACHINE_OPTIONS "-machine virt,gic-version=3Dmax -accel tcg"
> +
> +typedef struct TestState {
> +    char *src_tpm_path;
> +    char *dst_tpm_path;
> +    char *uri;
> +} TestState;
> +
> +static void tpm_tis_swtpm_test(const void *data)
> +{
> +    const TestState *ts =3D data;
> +
> +    tpm_test_swtpm_test(ts->src_tpm_path, tpm_util_tis_transfer,
> +                        "tpm-tis-device", MACHINE_OPTIONS);
> +}
> +
> +static void tpm_tis_swtpm_migration_test(const void *data)
> +{
> +    const TestState *ts =3D data;
> +
> +    tpm_test_swtpm_migration_test(ts->src_tpm_path, ts->dst_tpm_path, =
ts->uri,
> +                                  tpm_util_tis_transfer, "tpm-tis-devi=
ce",
> +                                  MACHINE_OPTIONS);
> +}
> +
> +int main(int argc, char **argv)
> +{
> +    int ret;
> +    TestState ts =3D { 0 };
> +
> +    ts.src_tpm_path =3D g_dir_make_tmp("qemu-tpm-tis-device-swtpm-test=
.XXXXXX",
> +                                     NULL);
> +    ts.dst_tpm_path =3D g_dir_make_tmp("qemu-tpm-tis-device-swtpm-test=
.XXXXXX",
> +                                     NULL);
> +    ts.uri =3D g_strdup_printf("unix:%s/migsocket", ts.src_tpm_path);
> +
> +    module_call_init(MODULE_INIT_QOM);
> +    g_test_init(&argc, &argv, NULL);
> +
> +    qtest_add_data_func("/tpm/tis-swtpm/test", &ts, tpm_tis_swtpm_test=
);
> +    qtest_add_data_func("/tpm/tis-swtpm-migration/test", &ts,
> +                        tpm_tis_swtpm_migration_test);
> +    ret =3D g_test_run();
> +
> +    g_rmdir(ts.dst_tpm_path);
> +    g_free(ts.dst_tpm_path);
> +    g_rmdir(ts.src_tpm_path);
> +    g_free(ts.src_tpm_path);
> +    g_free(ts.uri);
> +
> +    return ret;
> +}
> diff --git a/tests/qtest/tpm-tis-device-test.c b/tests/qtest/tpm-tis-de=
vice-test.c
> new file mode 100644
> index 0000000000..63ed36440f
> --- /dev/null
> +++ b/tests/qtest/tpm-tis-device-test.c
> @@ -0,0 +1,87 @@
> +/*
> + * QTest testcase for SYSBUS TPM TIS
> + *
> + * Copyright (c) 2018 Red Hat, Inc.
> + * Copyright (c) 2018 IBM Corporation
> + *
> + * Authors:
> + *   Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> + *   Stefan Berger <stefanb@linux.vnet.ibm.com>
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or =
later.
> + * See the COPYING file in the top-level directory.
> + */
> +
> +#include "qemu/osdep.h"
> +#include <glib/gstdio.h>
> +
> +#include "io/channel-socket.h"
> +#include "libqtest-single.h"
> +#include "qemu/module.h"
> +#include "tpm-emu.h"
> +#include "tpm-util.h"
> +#include "tpm-tis-util.h"
> +
> +/*
> + * As the Sysbus tpm-tis-device is instantiated on the ARM virt
> + * platform bus and it is the only sysbus device dynamically
> + * instantiated, it gets plugged at its base address
> + */
> +uint64_t tpm_tis_base_addr =3D 0xc000000;
> +
> +int main(int argc, char **argv)
> +{
> +    char *tmp_path =3D g_dir_make_tmp("qemu-tpm-tis-device-test.XXXXXX=
", NULL);
> +    GThread *thread;
> +    TestState test;
> +    char *args;
> +    int ret;
> +
> +    module_call_init(MODULE_INIT_QOM);
> +    g_test_init(&argc, &argv, NULL);
> +
> +    test.addr =3D g_new0(SocketAddress, 1);
> +    test.addr->type =3D SOCKET_ADDRESS_TYPE_UNIX;
> +    test.addr->u.q_unix.path =3D g_build_filename(tmp_path, "sock", NU=
LL);
> +    g_mutex_init(&test.data_mutex);
> +    g_cond_init(&test.data_cond);
> +    test.data_cond_signal =3D false;
> +
> +    thread =3D g_thread_new(NULL, tpm_emu_ctrl_thread, &test);
> +    tpm_emu_test_wait_cond(&test);
> +
> +    args =3D g_strdup_printf(
> +        "-machine virt,gic-version=3Dmax -accel tcg "
> +        "-chardev socket,id=3Dchr,path=3D%s "
> +        "-tpmdev emulator,id=3Ddev,chardev=3Dchr "
> +        "-device tpm-tis-device,tpmdev=3Ddev",
> +        test.addr->u.q_unix.path);
> +    qtest_start(args);
> +
> +    qtest_add_data_func("/tpm-tis/test_check_localities", &test,
> +                        tpm_tis_test_check_localities);
> +
> +    qtest_add_data_func("/tpm-tis/test_check_access_reg", &test,
> +                        tpm_tis_test_check_access_reg);
> +
> +    qtest_add_data_func("/tpm-tis/test_check_access_reg_seize", &test,
> +                        tpm_tis_test_check_access_reg_seize);
> +
> +    qtest_add_data_func("/tpm-tis/test_check_access_reg_release", &tes=
t,
> +                        tpm_tis_test_check_access_reg_release);
> +
> +    qtest_add_data_func("/tpm-tis/test_check_transmit", &test,
> +                        tpm_tis_test_check_transmit);
> +
> +    ret =3D g_test_run();
> +
> +    qtest_end();
> +
> +    g_thread_join(thread);
> +    g_unlink(test.addr->u.q_unix.path);
> +    qapi_free_SocketAddress(test.addr);
> +    g_rmdir(tmp_path);
> +    g_free(tmp_path);
> +    g_free(args);
> +    return ret;
> +}



