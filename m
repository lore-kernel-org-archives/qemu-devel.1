Return-Path: <SRS0=U3m5=5X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5C15C2BB55
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2020 16:03:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3CCB520768
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2020 16:03:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Hx27tEtG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CCB520768
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49976 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jLqgr-0003RM-2C
	for qemu-devel@archiver.kernel.org; Tue, 07 Apr 2020 12:03:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44161)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <joao.m.martins@oracle.com>) id 1jLqXg-0007eU-6f
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 11:53:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <joao.m.martins@oracle.com>) id 1jLqXf-00062c-47
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 11:53:35 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:41754)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <joao.m.martins@oracle.com>)
 id 1jLqXe-00061a-RT
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 11:53:35 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
 by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 037FqaVK001252;
 Tue, 7 Apr 2020 15:53:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=/AlQo5ZMSYyWL/AGF8EGAc+tUV3HzXcLDhl7dLkG7xQ=;
 b=Hx27tEtGBM7F0r3OvTQCyWVCMBeGU20oaELqqCjeU89ADz/Webw/maw3abJcI9APZ4WD
 wfhO3RW8nDcmz/kZGmYm4S/a0Kt/9lf6hrrZiGQSktXTgf/VNACQPJZvOHsCwtrxul5/
 FesfZ/UHhXTf6gk688fBZ/8ttEnNurpDr6tJQffNOkbfEj82VgfRSUBoBa7QO1lDn4ZG
 8l5oTsv/WyK6+3RGTZBJSYhWyHdZWQSK3zIUpEmpYWzdpNzBZ0E7nCtdia1ho+JhPl6/
 6UlSM7kDQiuqJfcxXMsWzTZjp6d+1q1kRY84CK8k50r8AI/KcxGaramISZT21SohqUmi pQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
 by userp2130.oracle.com with ESMTP id 308ffdbwm0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 07 Apr 2020 15:53:32 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
 by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 037FlTQo155939;
 Tue, 7 Apr 2020 15:51:32 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
 by aserp3020.oracle.com with ESMTP id 30741enkm2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 07 Apr 2020 15:51:32 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
 by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 037FpVTi024103;
 Tue, 7 Apr 2020 15:51:31 GMT
Received: from [10.175.215.143] (/10.175.215.143)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Tue, 07 Apr 2020 08:51:31 -0700
Subject: Re: [PATCH] exec: fetch the alignment of Linux devdax pmem character
 device nodes
To: Paolo Bonzini <pbonzini@redhat.com>, Jingqi Liu <jingqi.liu@intel.com>
References: <20200401031314.11592-1-jingqi.liu@intel.com>
 <c906a3ae-c9d2-5802-5988-3c1d0302109b@oracle.com>
 <b15709c2-bea7-2717-6833-ac4616b88660@redhat.com>
From: Joao Martins <joao.m.martins@oracle.com>
Message-ID: <7de3eccb-f0b4-a858-2fc4-addfc7b198aa@oracle.com>
Date: Tue, 7 Apr 2020 16:51:28 +0100
MIME-Version: 1.0
In-Reply-To: <b15709c2-bea7-2717-6833-ac4616b88660@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9583
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1
 phishscore=0
 malwarescore=0 bulkscore=0 spamscore=0 adultscore=0 mlxlogscore=999
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004070130
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9583
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1
 priorityscore=1501
 impostorscore=0 malwarescore=0 mlxlogscore=999 lowpriorityscore=0
 clxscore=1015 phishscore=0 mlxscore=0 bulkscore=0 adultscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004070130
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
X-Received-From: 156.151.31.86
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
Cc: Dan Williams <dan.j.williams@intel.com>, qemu-devel@nongnu.org,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/7/20 3:31 PM, Paolo Bonzini wrote:
> On 07/04/20 12:59, Joao Martins wrote:
>> Perhaps, you meant instead:
>>
>> 	/sys/dev/char/%d:%d/align
>>
>>  ?
>>
> 
> So it works with that change?

Yeah.

	Joao

