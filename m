Return-Path: <SRS0=0rPh=D4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE2A7C388F9
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 15:49:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EFCD52177B
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 15:49:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="LnBC6fyt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFCD52177B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60278 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVGMj-00010g-0f
	for qemu-devel@archiver.kernel.org; Wed, 21 Oct 2020 11:49:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47468)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pasic@linux.ibm.com>)
 id 1kVGM2-0000Xm-K0; Wed, 21 Oct 2020 11:48:46 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:38588)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pasic@linux.ibm.com>)
 id 1kVGLy-0007fz-Db; Wed, 21 Oct 2020 11:48:45 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 09LFXjMg122607; Wed, 21 Oct 2020 11:48:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=date : from : to : cc :
 subject : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=pp1;
 bh=Y0S87/7c7wgSV6Vi2AwmXMkI4LUwel0UpcfopIhC/Yk=;
 b=LnBC6fytwq6GC7wMSWiY3XeY6SlSz7CDsTxzlwD+itAHqYw7tt+exm+DdBz2uenxEinJ
 UMdaKOzQDRqDmB/PPq+sqRQqckBVpAkdEqnKT+sLEjcQw33pL7gy0Q/OTotNRxIuRXtT
 wxNTSY/Equ9weJN+EXWkgNRiIu43uFp+aw3l0xfurmLRl7HJNWkeQSGInf6OS/Yl1Tuy
 Kw9K3ZahLDy74ro9Ptmuhe59gVHAsoXn0dwKnmG9iOiC3mxZpSKpQdth7qsgnRygkayB
 yP/+oau5eUoNL4Ns7ScUdmIBoc9Mz/FYoDuDqjDlMMbIYPgkksJTI0LwISZJFWtNX1hW mA== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 34aqh50v69-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 21 Oct 2020 11:48:37 -0400
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 09LFXumx123901;
 Wed, 21 Oct 2020 11:48:37 -0400
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com
 [169.51.49.102])
 by mx0a-001b2d01.pphosted.com with ESMTP id 34aqh50v59-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 21 Oct 2020 11:48:37 -0400
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
 by ppma06ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 09LFWA7w027165;
 Wed, 21 Oct 2020 15:48:35 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com
 (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
 by ppma06ams.nl.ibm.com with ESMTP id 347qvhcfwf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 21 Oct 2020 15:48:35 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com
 (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
 by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 09LFmWrF25886992
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 21 Oct 2020 15:48:32 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 27196A405B;
 Wed, 21 Oct 2020 15:48:32 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id AAD32A4054;
 Wed, 21 Oct 2020 15:48:31 +0000 (GMT)
Received: from oc2783563651 (unknown [9.145.57.168])
 by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Wed, 21 Oct 2020 15:48:31 +0000 (GMT)
Date: Wed, 21 Oct 2020 17:48:30 +0200
From: Halil Pasic <pasic@linux.ibm.com>
To: Janosch Frank <frankja@linux.ibm.com>
Subject: Re: [PATCH 1/2] s390x: pv: Remove sclp boundary checks
Message-ID: <20201021174830.40192dc5.pasic@linux.ibm.com>
In-Reply-To: <20201021134345.110173-2-frankja@linux.ibm.com>
References: <20201021134345.110173-1-frankja@linux.ibm.com>
 <20201021134345.110173-2-frankja@linux.ibm.com>
Organization: IBM
X-Mailer: Claws Mail 3.11.1 (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235, 18.0.737
 definitions=2020-10-21_06:2020-10-20,
 2020-10-21 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 impostorscore=0
 mlxlogscore=999 clxscore=1015 priorityscore=1501 spamscore=0 bulkscore=0
 adultscore=0 lowpriorityscore=0 phishscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2010210115
Received-SPF: pass client-ip=148.163.156.1; envelope-from=pasic@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/21 09:43:57
X-ACL-Warn: Detected OS   = Linux 3.x [generic] [fuzzy]
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
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
Cc: thuth@redhat.com, david@redhat.com, cohuck@redhat.com,
 qemu-devel@nongnu.org, borntraeger@de.ibm.com, qemu-s390x@nongnu.org,
 mhartmay@linux.ibm.com, walling@linux.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 21 Oct 2020 09:43:44 -0400
Janosch Frank <frankja@linux.ibm.com> wrote:

> The SCLP boundary cross check is done by the Ultravisor for a
> protected guest, hence we don't need to do it. As QEMU doesn't get a
> valid SCCB address in protected mode this is even problematic and can
> lead to QEMU reporting a false boundary cross error.
> 
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> Reported-by: Marc Hartmayer <mhartmay@linux.ibm.com>
> Fixes: db13387ca0 ("s390/sclp: rework sclp boundary checks")
> Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
> Tested-by: Marc Hartmayer <mhartmay@linux.ibm.com>

Acked-by: Halil Pasic <pasic@linux.ibm.com>

> ---
>  hw/s390x/sclp.c | 5 -----
>  1 file changed, 5 deletions(-)
> 
> diff --git a/hw/s390x/sclp.c b/hw/s390x/sclp.c
> index 00f1e4648d..0cf2290826 100644
> --- a/hw/s390x/sclp.c
> +++ b/hw/s390x/sclp.c
> @@ -285,11 +285,6 @@ int sclp_service_call_protected(CPUS390XState *env, uint64_t sccb,
>          goto out_write;
>      }
>  
> -    if (!sccb_verify_boundary(sccb, be16_to_cpu(work_sccb->h.length), code)) {
> -        work_sccb->h.response_code = cpu_to_be16(SCLP_RC_SCCB_BOUNDARY_VIOLATION);
> -        goto out_write;
> -    }
> -
>      sclp_c->execute(sclp, work_sccb, code);
>  out_write:
>      s390_cpu_pv_mem_write(env_archcpu(env), 0, work_sccb,


