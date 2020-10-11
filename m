Return-Path: <SRS0=+Fwv=DS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69C4EC433DF
	for <qemu-devel@archiver.kernel.org>; Sun, 11 Oct 2020 20:30:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE5FD20776
	for <qemu-devel@archiver.kernel.org>; Sun, 11 Oct 2020 20:30:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="dMwc3D50"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE5FD20776
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44782 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kRhzM-0006xs-MC
	for qemu-devel@archiver.kernel.org; Sun, 11 Oct 2020 16:30:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56294)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1kRhyB-0005u1-8C; Sun, 11 Oct 2020 16:29:27 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:13972)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1kRhy8-0004gt-IN; Sun, 11 Oct 2020 16:29:26 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 09BK2iWx019182; Sun, 11 Oct 2020 16:28:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=ZzWoxCfIlVsxH62Lip+bG8LSe19By1P7I1gUTAQG/to=;
 b=dMwc3D508fUyccIero8tj5PtCllpoB+KzBSlNIn+Cgimj2+xUaz3hX0OnjtrVlHsA0Cy
 /EEDxZ0b+Y0r4ibUuH1z+J/Jw/renr6zxqz/E9fNqsCJZMtiVVJpYKadvV2sdbJYASBh
 fCw7vL+3L2Ng+ltb9l8WSgL5CWLYm0oPxqboeUf2yeZmY1GeKXxiPp0f+urG2IOPc7JU
 1/m6GvZPWvRORTTnQEEoeU3WNyywxhQFNaEUotJWs7yfj32AP7uAimUMN9WEzK3+sOHz
 ZSUyWfT+VY24vePgg8j+jaZOPV+i7v/RHEz04qMT/jnVvqWBo62M3QJQouyryZ+8/qOB Lg== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 3448hcrhk0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 11 Oct 2020 16:28:59 -0400
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 09BKSxBE151346;
 Sun, 11 Oct 2020 16:28:59 -0400
Received: from ppma05wdc.us.ibm.com (1b.90.2fa9.ip4.static.sl-reverse.com
 [169.47.144.27])
 by mx0a-001b2d01.pphosted.com with ESMTP id 3448hcrhjn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 11 Oct 2020 16:28:59 -0400
Received: from pps.filterd (ppma05wdc.us.ibm.com [127.0.0.1])
 by ppma05wdc.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 09BKR50k003729;
 Sun, 11 Oct 2020 20:28:57 GMT
Received: from b03cxnp08028.gho.boulder.ibm.com
 (b03cxnp08028.gho.boulder.ibm.com [9.17.130.20])
 by ppma05wdc.us.ibm.com with ESMTP id 3434k8jtg5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 11 Oct 2020 20:28:57 +0000
Received: from b03ledav004.gho.boulder.ibm.com
 (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
 by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 09BKSu6F47907238
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sun, 11 Oct 2020 20:28:57 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C88C278060;
 Sun, 11 Oct 2020 20:28:56 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 877CE7805E;
 Sun, 11 Oct 2020 20:28:55 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
 by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
 Sun, 11 Oct 2020 20:28:55 +0000 (GMT)
Subject: Re: [PATCH 04/10] hw/isa: Add the ISA_IRQ_TPM_DEFAULT definition
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org
References: <20201011193229.3210774-1-f4bug@amsat.org>
 <20201011193229.3210774-5-f4bug@amsat.org>
From: Stefan Berger <stefanb@linux.ibm.com>
Message-ID: <1976a77d-8799-5f2a-1dcb-5c8dbdb21a3f@linux.ibm.com>
Date: Sun, 11 Oct 2020 16:28:55 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20201011193229.3210774-5-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235, 18.0.687
 definitions=2020-10-11_12:2020-10-09,
 2020-10-11 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 mlxscore=0
 lowpriorityscore=0 impostorscore=0 suspectscore=0 malwarescore=0
 clxscore=1011 mlxlogscore=999 phishscore=0 bulkscore=0 adultscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2010110186
Received-SPF: pass client-ip=148.163.156.1; envelope-from=stefanb@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/11 16:29:20
X-ACL-Warn: Detected OS   = Linux 3.x [generic] [fuzzy]
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-block@nongnu.org,
 Stefan Berger <stefanb@linux.vnet.ibm.com>, qemu-trivial@nongnu.org,
 =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Laurent Vivier <lvivier@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 Corey Minyard <minyard@acm.org>, Paolo Bonzini <pbonzini@redhat.com>,
 John Snow <jsnow@redhat.com>, Richard Henderson <rth@twiddle.net>,
 Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>,
 qemu-ppc@nongnu.org, Igor Mammedov <imammedo@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/11/20 3:32 PM, Philippe Mathieu-Daudé wrote:
> The TPM TIS device uses IRQ #5 by default. Add this
> default definition to the IsaIrqNumber enum.
>
> Avoid magic values in the code, replace them by the
> newly introduced definition.
>
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
>   include/hw/isa/isa.h   | 1 +
>   hw/i386/acpi-build.c   | 2 +-
>   hw/ipmi/isa_ipmi_bt.c  | 2 +-
>   hw/ipmi/isa_ipmi_kcs.c | 2 +-
>   hw/tpm/tpm_tis_isa.c   | 2 +-
>   5 files changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/include/hw/isa/isa.h b/include/hw/isa/isa.h
> index 519296d5823..e4f2aed004f 100644
> --- a/include/hw/isa/isa.h
> +++ b/include/hw/isa/isa.h
> @@ -11,6 +11,7 @@
>   enum IsaIrqNumber {
>       ISA_IRQ_KBD_DEFAULT =  1,
>       ISA_IRQ_SER_DEFAULT =  4,
> +    ISA_IRQ_TPM_DEFAULT =  5,
>       ISA_NUM_IRQS        = 16
>   };
>
> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> index 45ad2f95334..2b6038ab015 100644
> --- a/hw/i386/acpi-build.c
> +++ b/hw/i386/acpi-build.c
> @@ -1886,7 +1886,7 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
>                       Rewrite to take IRQ from TPM device model and
>                       fix default IRQ value there to use some unused IRQ
>                    */
> -                /* aml_append(crs, aml_irq_no_flags(TPM_TIS_IRQ)); */
> +                /* aml_append(crs, aml_irq_no_flags(ISA_IRQ_TPM_DEFAULT)); */
>                   aml_append(dev, aml_name_decl("_CRS", crs));
>
>                   tpm_build_ppi_acpi(tpm, dev);
> diff --git a/hw/ipmi/isa_ipmi_bt.c b/hw/ipmi/isa_ipmi_bt.c
> index b7c2ad557b2..13a92bd2c44 100644
> --- a/hw/ipmi/isa_ipmi_bt.c
> +++ b/hw/ipmi/isa_ipmi_bt.c
> @@ -137,7 +137,7 @@ static void *isa_ipmi_bt_get_backend_data(IPMIInterface *ii)
>
>   static Property ipmi_isa_properties[] = {
>       DEFINE_PROP_UINT32("ioport", ISAIPMIBTDevice, bt.io_base,  0xe4),
> -    DEFINE_PROP_INT32("irq",   ISAIPMIBTDevice, isairq,  5),
> +    DEFINE_PROP_INT32("irq", ISAIPMIBTDevice, isairq, ISA_IRQ_TPM_DEFAULT),
>       DEFINE_PROP_END_OF_LIST(),
>   };
>
> diff --git a/hw/ipmi/isa_ipmi_kcs.c b/hw/ipmi/isa_ipmi_kcs.c
> index 7dd6bf0040a..c956b539688 100644
> --- a/hw/ipmi/isa_ipmi_kcs.c
> +++ b/hw/ipmi/isa_ipmi_kcs.c
> @@ -144,7 +144,7 @@ static void *isa_ipmi_kcs_get_backend_data(IPMIInterface *ii)
>
>   static Property ipmi_isa_properties[] = {
>       DEFINE_PROP_UINT32("ioport", ISAIPMIKCSDevice, kcs.io_base,  0xca2),
> -    DEFINE_PROP_INT32("irq",   ISAIPMIKCSDevice, isairq,  5),
> +    DEFINE_PROP_INT32("irq", ISAIPMIKCSDevice, isairq, ISA_IRQ_TPM_DEFAULT),
>       DEFINE_PROP_END_OF_LIST(),
>   };


I don't know what these devices do but this looks like an unwanted clash.


> diff --git a/hw/tpm/tpm_tis_isa.c b/hw/tpm/tpm_tis_isa.c
> index 6fd876eebf1..5a4afda42df 100644
> --- a/hw/tpm/tpm_tis_isa.c
> +++ b/hw/tpm/tpm_tis_isa.c
> @@ -91,7 +91,7 @@ static void tpm_tis_isa_reset(DeviceState *dev)
>   }
>
>   static Property tpm_tis_isa_properties[] = {
> -    DEFINE_PROP_UINT32("irq", TPMStateISA, state.irq_num, TPM_TIS_IRQ),
> +    DEFINE_PROP_UINT32("irq", TPMStateISA, state.irq_num, ISA_IRQ_TPM_DEFAULT),
>       DEFINE_PROP_TPMBE("tpmdev", TPMStateISA, state.be_driver),
>       DEFINE_PROP_BOOL("ppi", TPMStateISA, state.ppi_enabled, true),
>       DEFINE_PROP_END_OF_LIST(),



