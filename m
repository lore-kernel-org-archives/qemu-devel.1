Return-Path: <SRS0=U3m5=5X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 805D2C2BB1D
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2020 11:04:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4CB2F206F7
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2020 11:04:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="EHjFzv28"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CB2F206F7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45234 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jLm1w-0002Oa-EE
	for qemu-devel@archiver.kernel.org; Tue, 07 Apr 2020 07:04:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48394)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <joao.m.martins@oracle.com>) id 1jLm0m-0001Ir-Ak
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 07:03:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <joao.m.martins@oracle.com>) id 1jLm0l-0001hx-0s
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 07:03:19 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:36794)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <joao.m.martins@oracle.com>)
 id 1jLm0k-0000be-NC
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 07:03:18 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
 by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 037AwvFU050175;
 Tue, 7 Apr 2020 11:01:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=wJykV5Qdtt/ZtvZOw4iDo5UNjQtBrxzJ6C1scz4b13A=;
 b=EHjFzv286j8eqnXMLu1Bf2LAvMmcT6Ntp4SGydOxNGGrZqJrSvxZ7FcBbJ2eFuQZZChX
 hPT8UheOlgjePxKvyoO2sG16C+ugbSW60FOpdxRyc6SFN16PDMbV2g2m8qV2jE5vjt96
 WZVEHgi+O5hYHGDdXNLo5FWsJ3UvB+2+rsXCuJxmiZ0Zbbsl/7oH27PnDxK44X4UGHiD
 nMvztigRaxs84WpyhvpFRB5aSglf6vVwv3kRAL1dhTgtU70EUTYg+Ry4eVP2AsAc2IMF
 /K00cFSNookzUR4/uiaUZPBUMpfgWsKCDV//zj+aCU6d/xWc2n2OoIoz5gxGtF8do4tF mg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
 by userp2120.oracle.com with ESMTP id 306jvn42x7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 07 Apr 2020 11:01:15 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
 by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 037AvRYL162376;
 Tue, 7 Apr 2020 10:59:14 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
 by aserp3020.oracle.com with ESMTP id 30741dv9tv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 07 Apr 2020 10:59:14 +0000
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
 by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 037AxDVc001565;
 Tue, 7 Apr 2020 10:59:13 GMT
Received: from [10.175.215.143] (/10.175.215.143)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Tue, 07 Apr 2020 03:59:13 -0700
Subject: Re: [PATCH] exec: fetch the alignment of Linux devdax pmem character
 device nodes
To: Jingqi Liu <jingqi.liu@intel.com>
References: <20200401031314.11592-1-jingqi.liu@intel.com>
From: Joao Martins <joao.m.martins@oracle.com>
Message-ID: <c906a3ae-c9d2-5802-5988-3c1d0302109b@oracle.com>
Date: Tue, 7 Apr 2020 11:59:10 +0100
MIME-Version: 1.0
In-Reply-To: <20200401031314.11592-1-jingqi.liu@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9583
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1
 phishscore=0
 malwarescore=0 bulkscore=0 spamscore=0 adultscore=0 mlxlogscore=999
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004070094
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9583
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 suspectscore=1
 mlxlogscore=999 mlxscore=0 bulkscore=0 adultscore=0 priorityscore=1501
 lowpriorityscore=0 clxscore=1011 malwarescore=0 impostorscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004070094
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
X-Received-From: 156.151.31.85
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Dan Williams <dan.j.williams@intel.com>, qemu-devel@nongnu.org,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 4/1/20 4:13 AM, Jingqi Liu wrote:
> If the backend file is devdax pmem character device, the alignment
> specified by the option 'align=NUM' in the '-object memory-backend-file'
> needs to match the alignment requirement of the devdax pmem character device.
> 
> This patch fetches the devdax pmem file 'align', so that we can compare
> it with the NUM of 'align=NUM'.
> The NUM needs to be larger than or equal to the devdax pmem file 'align'.
> 
> It also fixes the problem that mmap() returns failure in qemu_ram_mmap()
> when the NUM of 'align=NUM' is less than the devdax pmem file 'align'.
> 
> Cc: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Jingqi Liu <jingqi.liu@intel.com>
> ---
>  exec.c | 46 +++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 45 insertions(+), 1 deletion(-)
> 
> diff --git a/exec.c b/exec.c
> index de9d949902..8221abffec 100644
> --- a/exec.c
> +++ b/exec.c
> @@ -1736,6 +1736,42 @@ static int64_t get_file_size(int fd)
>      return size;
>  }
>  
> +static int64_t get_file_align(int fd)
> +{
> +    int64_t align = -1;
> +#if defined(__linux__)
> +    struct stat st;
> +
> +    if (fstat(fd, &st) < 0) {
> +        return -errno;
> +    }
> +
> +    /* Special handling for devdax character devices */
> +    if (S_ISCHR(st.st_mode)) {
> +        g_autofree char *subsystem_path = NULL;
> +        g_autofree char *subsystem = NULL;
> +
> +        subsystem_path = g_strdup_printf("/sys/dev/char/%d:%d/subsystem",
> +                                         major(st.st_rdev), minor(st.st_rdev));
> +        subsystem = g_file_read_link(subsystem_path, NULL);
> +
> +        if (subsystem && g_str_has_suffix(subsystem, "/dax")) {
> +            g_autofree char *align_path = NULL;
> +            g_autofree char *align_str = NULL;
> +
> +            align_path = g_strdup_printf("/sys/dev/char/%d:%d/device/align",
> +                                    major(st.st_rdev), minor(st.st_rdev));
> +

Perhaps, you meant instead:

	/sys/dev/char/%d:%d/align

 ?

