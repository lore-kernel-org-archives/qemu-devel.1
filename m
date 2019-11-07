Return-Path: <SRS0=+ldK=Y7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8577DC5DF60
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2019 14:38:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F6FC214D8
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2019 14:38:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="rcGgJCEd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F6FC214D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43520 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iSiw3-0007wW-1P
	for qemu-devel@archiver.kernel.org; Thu, 07 Nov 2019 09:38:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48184)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <darren.kenny@oracle.com>) id 1iSiq7-0001l3-Ia
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 09:32:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <darren.kenny@oracle.com>) id 1iSiq5-0003OT-KK
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 09:32:47 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:41028)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <darren.kenny@oracle.com>)
 id 1iSiq3-0003MK-Iu
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 09:32:45 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
 by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xA7EOH28019035;
 Thu, 7 Nov 2019 14:32:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=2xBKTGN/88ja9dwYdafrH8Y04Zq974dnCfHKTXSiSPA=;
 b=rcGgJCEdgCLdCZUUs8CAY2D7kNxiXZ04U8YgfsNWPIi85ccOBKYjVk/xYIAiOFFiGT6F
 R29sWs7sdEEBPGw6wPaq/3xjByCTgcDan7FtoGaOAVrLHv2q08uSeXPvLZZbpv+hniJW
 098Q386zTWGEYgTRwf5fsEnKXF+zD6IJOL+VY3eVzdwkzJKYucb0XN7F5YMhjX2Scgx/
 57tFqvoGvtWFiaJTHfi54pVBg6+1U4lgRg0iNYKwgVbxDOO8TdYP5BM1vF/IUcGzERPj
 rtFw4OzqLzfaFFCRucBKI0htej9VnULcu71MCo5Nev0r08tF5Ly3j71TQHj9exlxLBY5 0w== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
 by aserp2120.oracle.com with ESMTP id 2w41w0xhh8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 07 Nov 2019 14:32:41 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
 by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xA7EOBGe075668;
 Thu, 7 Nov 2019 14:32:41 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
 by aserp3020.oracle.com with ESMTP id 2w4k2vad3y-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 07 Nov 2019 14:32:41 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
 by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id xA7EWdb2001391;
 Thu, 7 Nov 2019 14:32:39 GMT
Received: from starbug-mbp.localdomain (/10.175.193.46)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Thu, 07 Nov 2019 06:32:39 -0800
Received: from starbug-mbp (localhost [127.0.0.1])
 by starbug-mbp.localdomain (Postfix) with SMTP id 900244B2C302;
 Thu,  7 Nov 2019 14:32:37 +0000 (GMT)
Date: Thu, 7 Nov 2019 14:32:37 +0000
From: Darren Kenny <darren.kenny@oracle.com>
To: "Oleinik, Alexander" <alxndr@bu.edu>
Subject: Re: [PATCH v4 08/20] tests: provide test variables to other targets
Message-ID: <20191107143237.swmy3xmqc5ujwvs5@starbug-mbp>
Mail-Followup-To: "Oleinik, Alexander" <alxndr@bu.edu>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
References: <20191030144926.11873-1-alxndr@bu.edu>
 <20191030144926.11873-9-alxndr@bu.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <20191030144926.11873-9-alxndr@bu.edu>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9433
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1910280000 definitions=main-1911070143
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9433
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1910280000
 definitions=main-1911070143
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
X-Received-From: 141.146.126.78
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
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Oct 30, 2019 at 02:49:54PM +0000, Oleinik, Alexander wrote:
>From: Alexander Oleinik <alxndr@bu.edu>
>
>Before, when tests/Makefile.include was included, the contents would be
>ignored if config-host.mak was defined. Moving the ifneq responsible for
>this allows a target to depend on both testing-related and host-related
>objects. For example the virtual-device fuzzer relies on both
>libqtest/libqos objects and softmmu objects.
>
>Signed-off-by: Alexander Oleinik <alxndr@bu.edu>

Reviewed-by: Darren Kenny <darren.kenny@oracle.com>

>---
> tests/Makefile.include | 3 ++-
> 1 file changed, 2 insertions(+), 1 deletion(-)
>
>diff --git a/tests/Makefile.include b/tests/Makefile.include
>index 34ec03391c..67853d10c3 100644
>--- a/tests/Makefile.include
>+++ b/tests/Makefile.include
>@@ -27,7 +27,6 @@ check-help:
> 	@echo "Default options are -k and (for $(MAKE) V=1) --verbose; they can be"
> 	@echo "changed with variable GTESTER_OPTIONS."
>
>-ifneq ($(wildcard config-host.mak),)
> export SRC_PATH
>
> # TODO don't duplicate $(SRC_PATH)/Makefile's qapi-py here
>@@ -873,6 +872,8 @@ tests/test-qga$(EXESUF): tests/test-qga.o $(qtest-obj-y)
>
> SPEED = quick
>
>+ifneq ($(wildcard config-host.mak),)
>+
> # gtester tests, possibly with verbose output
> # do_test_tap runs all tests, even if some of them fail, while do_test_human
> # stops at the first failure unless -k is given on the command line
>-- 
>2.23.0
>
>

