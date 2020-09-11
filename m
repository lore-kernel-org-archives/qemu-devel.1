Return-Path: <SRS0=/zFi=CU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B834C433E2
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 14:40:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A9CA4222D5
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 14:40:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="WCazy72U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9CA4222D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57030 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGkDx-0006tV-II
	for qemu-devel@archiver.kernel.org; Fri, 11 Sep 2020 10:40:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56694)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@linux.ibm.com>)
 id 1kGkCN-0005D2-0y; Fri, 11 Sep 2020 10:38:47 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:24192
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@linux.ibm.com>)
 id 1kGkCL-0005Yu-5C; Fri, 11 Sep 2020 10:38:46 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 08BEXO31039794; Fri, 11 Sep 2020 10:38:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : in-reply-to : references : date : message-id : mime-version :
 content-type; s=pp1; bh=B7K/GsvhGJWmu8fQkfzG/vO7AjsMLWcRRHRo79jWRZY=;
 b=WCazy72UWg0kWMCCJBfehlCchVwN8Kato/LBzSkSk/TGtaCwveXp3fT0r5P9zlu8YvfO
 70pUx3r7IUpltPlDf+CppQ/cGpFFBbmcE1nTPZqbXvouvd3zzJ3yworrfSv4wzyymZ/b
 egVdKmz4vp2q0XJRfsMbHPercAfRvbpGT++fWiXv+p47da3FbPAetdUtQcMBxoNnzwc+
 CltwqkM9Mwb66X1WAdL81tTE1+CiDTgfmmysjkFnSH5QgnHdcg8sI5A2pbxWSyxkxpNX
 JmyRJ/D26+aYZwA9/YjM8GnUQ6/gku1Y1QLAnmQmE7MWGgOQLPyQiXHM9JMlHpYS9NkK Cw== 
Received: from ppma01wdc.us.ibm.com (fd.55.37a9.ip4.static.sl-reverse.com
 [169.55.85.253])
 by mx0b-001b2d01.pphosted.com with ESMTP id 33g99buyx9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 11 Sep 2020 10:38:37 -0400
Received: from pps.filterd (ppma01wdc.us.ibm.com [127.0.0.1])
 by ppma01wdc.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 08BEbign020217;
 Fri, 11 Sep 2020 14:38:37 GMT
Received: from b01cxnp22035.gho.pok.ibm.com (b01cxnp22035.gho.pok.ibm.com
 [9.57.198.25]) by ppma01wdc.us.ibm.com with ESMTP id 33c2a9gfvy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 11 Sep 2020 14:38:37 +0000
Received: from b01ledav006.gho.pok.ibm.com (b01ledav006.gho.pok.ibm.com
 [9.57.199.111])
 by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 08BEcbWc54526398
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 11 Sep 2020 14:38:37 GMT
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 15276AC05B;
 Fri, 11 Sep 2020 14:38:37 +0000 (GMT)
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8300FAC05E;
 Fri, 11 Sep 2020 14:38:36 +0000 (GMT)
Received: from localhost (unknown [9.80.239.32])
 by b01ledav006.gho.pok.ibm.com (Postfix) with ESMTPS;
 Fri, 11 Sep 2020 14:38:36 +0000 (GMT)
From: Fabiano Rosas <farosas@linux.ibm.com>
To: qemu-devel@nongnu.org
Subject: Re: [PATCH] spapr: Handle HPT allocation failure in nested guest
In-Reply-To: <20200911043123.204162-1-farosas@linux.ibm.com>
References: <20200911043123.204162-1-farosas@linux.ibm.com>
Date: Fri, 11 Sep 2020 11:38:34 -0300
Message-ID: <87d02sgyz9.fsf@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235, 18.0.687
 definitions=2020-09-11_05:2020-09-10,
 2020-09-11 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0
 malwarescore=0 priorityscore=1501 adultscore=0 phishscore=0
 suspectscore=10 impostorscore=0 mlxlogscore=999 spamscore=0 mlxscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009110114
Received-SPF: pass client-ip=148.163.158.5; envelope-from=farosas@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/11 09:50:13
X-ACL-Warn: Detected OS   = Linux 3.x [generic]
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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
Cc: qemu-ppc@nongnu.org, david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Fabiano Rosas <farosas@linux.ibm.com> writes:

> The nested KVM code does not yet support HPT guests. Calling the
> KVM_CAP_PPC_ALLOC_HTAB ioctl currently leads to KVM setting the guest
> as HPT and erroneously executing code in L1 that should only run in
> hypervisor mode, leading to an exception in the L1 vcpu thread when it
> enters the nested guest.
>
> This can be reproduced with -machine max-cpu-compat=power8 in the L2
> guest command line.
>
> The KVM code has since been modified to fail the ioctl when running in
> a nested environment so QEMU needs to be able to handle that. This
> patch provides an error message informing the user about the lack of
> support for HPT in nested guests.
>

I forgot to add a:

Reported-by: Satheesh Rajendran <sathnaga@linux.vnet.ibm.com>

> Signed-off-by: Fabiano Rosas <farosas@linux.ibm.com>
> ---
>  hw/ppc/spapr.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 9bce1892b5..ea2c755310 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -1483,6 +1483,12 @@ void spapr_reallocate_hpt(SpaprMachineState *spapr, int shift,
>      spapr_free_hpt(spapr);
>  
>      rc = kvmppc_reset_htab(shift);
> +
> +    if (rc == -EOPNOTSUPP) {
> +        error_setg(errp, "HPT not supported in nested guests");
> +        return;
> +    }
> +
>      if (rc < 0) {
>          /* kernel-side HPT needed, but couldn't allocate one */
>          error_setg_errno(errp, errno,

