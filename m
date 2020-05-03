Return-Path: <SRS0=KEGy=6R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48250C28CBC
	for <qemu-devel@archiver.kernel.org>; Sun,  3 May 2020 14:20:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 136852073E
	for <qemu-devel@archiver.kernel.org>; Sun,  3 May 2020 14:20:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 136852073E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59568 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVFTu-0001xY-81
	for qemu-devel@archiver.kernel.org; Sun, 03 May 2020 10:20:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36244)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1jVFSU-0007z7-Iw; Sun, 03 May 2020 10:19:06 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:28740
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1jVFST-00015o-FQ; Sun, 03 May 2020 10:19:06 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 043E2RPj133906; Sun, 3 May 2020 10:19:02 -0400
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0b-001b2d01.pphosted.com with ESMTP id 30s50ep90r-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 03 May 2020 10:19:02 -0400
Received: from m0098414.ppops.net (m0098414.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 043EDAGb153748;
 Sun, 3 May 2020 10:19:02 -0400
Received: from ppma03wdc.us.ibm.com (ba.79.3fa9.ip4.static.sl-reverse.com
 [169.63.121.186])
 by mx0b-001b2d01.pphosted.com with ESMTP id 30s50ep90j-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 03 May 2020 10:19:02 -0400
Received: from pps.filterd (ppma03wdc.us.ibm.com [127.0.0.1])
 by ppma03wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 043EFmQA012093;
 Sun, 3 May 2020 14:19:01 GMT
Received: from b01cxnp22034.gho.pok.ibm.com (b01cxnp22034.gho.pok.ibm.com
 [9.57.198.24]) by ppma03wdc.us.ibm.com with ESMTP id 30s0g6a22q-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 03 May 2020 14:19:01 +0000
Received: from b01ledav006.gho.pok.ibm.com (b01ledav006.gho.pok.ibm.com
 [9.57.199.111])
 by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 043EJ1D948300516
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sun, 3 May 2020 14:19:01 GMT
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 27C54AC05F;
 Sun,  3 May 2020 14:19:01 +0000 (GMT)
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 152F9AC05B;
 Sun,  3 May 2020 14:19:01 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
 by b01ledav006.gho.pok.ibm.com (Postfix) with ESMTP;
 Sun,  3 May 2020 14:19:01 +0000 (GMT)
Subject: Re: [PATCH 2/2] arm/acpi: Add the TPM2.0 device under the DSDT
To: Eric Auger <eric.auger@redhat.com>, eric.auger.pro@gmail.com,
 peter.maydell@linaro.org, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 imammedo@redhat.com, shannon.zhaosl@gmail.com, mst@redhat.com
References: <20200502203536.15011-1-eric.auger@redhat.com>
 <20200502203536.15011-3-eric.auger@redhat.com>
From: Stefan Berger <stefanb@linux.ibm.com>
Message-ID: <1d961c0b-7176-2d9e-04d8-5839a16ec889@linux.ibm.com>
Date: Sun, 3 May 2020 10:19:00 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200502203536.15011-3-eric.auger@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.676
 definitions=2020-05-03_09:2020-05-01,
 2020-05-03 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0
 clxscore=1015 impostorscore=0 adultscore=0 priorityscore=1501
 malwarescore=0 phishscore=0 mlxscore=0 spamscore=0 mlxlogscore=999
 bulkscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2005030127
Received-SPF: pass client-ip=148.163.158.5; envelope-from=stefanb@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/03 10:19:04
X-ACL-Warn: Detected OS   = Linux 3.x [generic]
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, KHOP_DYNAMIC=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001,
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
Cc: marcandre.lureau@redhat.com, drjones@redhat.com, gshan@redhat.com,
 lersek@redhat.com, ardb@kernel.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/2/20 4:35 PM, Eric Auger wrote:
> In case it is dynamically instantiated, add the TPM 2.0 device object
> under the DSDT table in the ACPI namespace. Its HID is MSFT0101
> while its current resource settings (CRS) property is initialized
> with the guest physical address and MMIO size of the device.
>
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> ---
>   hw/arm/virt-acpi-build.c | 34 ++++++++++++++++++++++++++++++++++
>   1 file changed, 34 insertions(+)
>
> diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
> index cc5863eaf2..0cb9cdb2ce 100644
> --- a/hw/arm/virt-acpi-build.c
> +++ b/hw/arm/virt-acpi-build.c
> @@ -45,6 +45,7 @@
>   #include "hw/pci/pcie_host.h"
>   #include "hw/pci/pci.h"
>   #include "hw/arm/virt.h"
> +#include "hw/platform-bus.h"
>   #include "sysemu/numa.h"
>   #include "sysemu/reset.h"
>   #include "sysemu/tpm.h"
> @@ -362,6 +363,38 @@ static void acpi_dsdt_add_power_button(Aml *scope)
>       aml_append(scope, dev);
>   }
>   
> +static void acpi_dsdt_add_tpm(Aml *scope, VirtMachineState *vms)
> +{
> +    hwaddr pbus_base = vms->memmap[VIRT_PLATFORM_BUS].base;
> +    PlatformBusDevice *pbus = PLATFORM_BUS_DEVICE(vms->platform_bus_dev);
> +    MemoryRegion *sbdev_mr;
> +    SysBusDevice *sbdev;
> +    hwaddr tpm_base;
> +
> +    sbdev = (SysBusDevice *)object_dynamic_cast(OBJECT(tpm_find()),
> +                                                TYPE_SYS_BUS_DEVICE);
> +    if (!sbdev) {
> +        return;
> +    }
> +
> +    tpm_base = platform_bus_get_mmio_addr(pbus, sbdev, 0);
> +    assert(tpm_base != -1);
> +
> +    tpm_base += pbus_base;
> +
> +    sbdev_mr = sysbus_mmio_get_region(sbdev, 0);
> +
> +    Aml *dev = aml_device("TPM0");
> +    aml_append(dev, aml_name_decl("_HID", aml_string("MSFT0101")));
> +    aml_append(dev, aml_name_decl("_UID", aml_int(0)));
> +
> +    Aml *crs = aml_resource_template();
> +    aml_append(crs,
> +               aml_memory32_fixed(tpm_base, sbdev_mr->size, AML_READ_WRITE));
> +    aml_append(dev, aml_name_decl("_CRS", crs));
> +    aml_append(scope, dev);
> +}
> +
>   static void
>   build_iort(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
>   {
> @@ -785,6 +818,7 @@ build_dsdt(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
>       }
>   
>       acpi_dsdt_add_power_button(scope);
> +    acpi_dsdt_add_tpm(scope, vms);
>   
>       aml_append(dsdt, scope);
>   

Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>



