Return-Path: <SRS0=buBk=6M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6594DC83000
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 16:28:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2AFAF20730
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 16:28:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="g+MHrlXp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2AFAF20730
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37778 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTT6Q-0000sB-3J
	for qemu-devel@archiver.kernel.org; Tue, 28 Apr 2020 12:28:58 -0400
Received: from eggs.gnu.org ([209.51.188.92]:33090)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <joao.m.martins@oracle.com>) id 1jTT4X-0007dq-2C
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 12:28:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <joao.m.martins@oracle.com>) id 1jTT0v-0003A2-Fm
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 12:27:00 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:50092)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1jTT0u-00039N-Q1
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 12:23:17 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
 by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03SGHO8J027600;
 Tue, 28 Apr 2020 16:23:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=dH+cSJ1b6JBTP26QmVQ3CFqr1/2HUyJsolEM5zk87QU=;
 b=g+MHrlXpKnPPGcRQzAQCiLznij2vac+yFpkIjLS7/ydgiUXTDid1V6sEHdUM4zcvU1FD
 ZnajT4jlKXiB03ndAH4p/JaUtUYPWVdSTbvpn8JfaoF1y2op34IusqM8ESi0BRd0lutw
 OrF8j7YI2owrDTL258FkG+fAKi3A+KvPa9fw2VfopwrkLWj0dbwSMArb0i2qIVvJXnhy
 FyH7TiMh0YwuvvsiepibPBHigVOpOS0PvuS+xzwd/C0DiyBc1mjC9P4gG86E16HPZywa
 hUyITm/Jv0pLMtjXhzxgN8ajZfEmdg28UnrmK7aJXh47ywN/hU78FE+ij/zJAw0okcB6 0w== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
 by userp2120.oracle.com with ESMTP id 30p2p06dph-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 28 Apr 2020 16:23:05 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
 by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03SGLvkC111023;
 Tue, 28 Apr 2020 16:23:05 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
 by userp3020.oracle.com with ESMTP id 30mxx05xf9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 28 Apr 2020 16:23:04 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
 by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 03SGN2GI007493;
 Tue, 28 Apr 2020 16:23:02 GMT
Received: from [10.175.178.2] (/10.175.178.2)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Tue, 28 Apr 2020 09:23:02 -0700
Subject: Re: [PATCH v2 2/3] docs/nvdimm: add description of alignment
 requirement of device dax
To: Jingqi Liu <jingqi.liu@intel.com>
References: <20200415033538.43329-1-jingqi.liu@intel.com>
 <20200415033538.43329-3-jingqi.liu@intel.com>
From: Joao Martins <joao.m.martins@oracle.com>
Message-ID: <b520218c-a8f5-101e-1e3e-ad212fe35cdd@oracle.com>
Date: Tue, 28 Apr 2020 17:22:59 +0100
MIME-Version: 1.0
In-Reply-To: <20200415033538.43329-3-jingqi.liu@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9605
 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 spamscore=0 bulkscore=0
 suspectscore=1 mlxlogscore=999 phishscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004280128
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9605
 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 phishscore=0 clxscore=1011
 bulkscore=0 adultscore=0 lowpriorityscore=0 impostorscore=0 malwarescore=0
 mlxscore=0 suspectscore=1 mlxlogscore=999 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004280127
Received-SPF: pass client-ip=156.151.31.85;
 envelope-from=joao.m.martins@oracle.com; helo=userp2120.oracle.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/28 12:23:09
X-ACL-Warn: Detected OS   = Linux 3.x [generic] [fuzzy]
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
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Dan Williams <dan.j.williams@intel.com>,
 Xiao Guangrong <xiaoguangrong.eric@gmail.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/15/20 4:35 AM, Jingqi Liu wrote:
> For device dax (e.g., /dev/dax0.0), the NUM of 'align=NUM' option
> needs to match the alignment requirement of the device dax.
> It must be larger than or equal to the 'align' of device dax.
> 
> Signed-off-by: Jingqi Liu <jingqi.liu@intel.com>
> ---
>  docs/nvdimm.txt | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/docs/nvdimm.txt b/docs/nvdimm.txt
> index 362e99109e..3c7b6dab5f 100644
> --- a/docs/nvdimm.txt
> +++ b/docs/nvdimm.txt
> @@ -132,6 +132,15 @@ address to the page size (getpagesize(2)) by default. However, some
>  types of backends may require an alignment different than the page
>  size. In that case, QEMU v2.12.0 and later provide 'align' option to
>  memory-backend-file to allow users to specify the proper alignment.
> +For device dax (e.g., /dev/dax0.0), this alignment needs to match the
> +alignment requirement of the device dax. The NUM of 'align=NUM' option
> +must be larger than or equal to the 'align' of device dax.
> +We can use the following command to show the 'align' of device dax.
> +
> +    ndctl list -X
> +
> +In order to get the proper 'align' of device dax, you need to install
> +the library 'libdaxctl'.
>  
>  For example, device dax require the 2 MB alignment, so we can use
>  following QEMU command line options to use it (/dev/dax0.0) as the
> 

Given that this series introduces support for libdaxctl, perhaps suggesting in
the docs how you can also query the @align with daxctl tool? e.g.

"We can one of the following commands to show the 'align' of device dax:

     ndctl list -X
     daxctl list -R"

The unlikely reason being that users may only install daxctl-{,libs,devel} and
not ndctl-*. It also covers other users like ACPI HMAT/hmem which are not
instrumented with ndctl.

With that:

  Reviewed-by: Joao Martins <joao.m.martins@oracle.com>

	Joao

