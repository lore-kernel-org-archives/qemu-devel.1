Return-Path: <SRS0=hXcz=7S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3C79C433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 19:00:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C14C12077D
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 19:00:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="hwyv6/9h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C14C12077D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41588 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jhHZU-0007EI-UE
	for qemu-devel@archiver.kernel.org; Fri, 05 Jun 2020 15:00:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58070)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <darren.kenny@oracle.com>)
 id 1jhHYW-00062r-1Q
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 14:59:04 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:52244)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <darren.kenny@oracle.com>)
 id 1jhHYU-00068a-Mu
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 14:59:03 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
 by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 055IqGOX175720;
 Fri, 5 Jun 2020 18:58:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : in-reply-to : references : date : message-id : mime-version :
 content-type; s=corp-2020-01-29;
 bh=mEwLn/lcDvz7CiSjvFuPruXwaX7o1O/FT75no123XME=;
 b=hwyv6/9hDt/X4gOqHjy0c40aO+xTCX709AQY227XFIzG9qOpT5HHcwALPqxup5c7o6UQ
 rZAOySfkp9qnkQ3rBAT/FHNo0R3meEkPwm4QiJrg/YR8nCt6+nOZuvEade3/kBgqex64
 oCvK8WdbYxipsn0Qvk9V/dNWFNvMqWRobD2DLkzFDDW1fndinerxuosQdMUwS/W4FiOH
 K1fWl+AjB7yX+GxaWABqS8n7fTx8v6r76LJxoVpDizBTBQ2VwOxeUXDe9qmJXUyGunj4
 xZMeBu3yl+wel3+KT2hhM/nGzXCw1QXOYxPxKUFFOypAK+qpvOsqjPwoQPeOaSANJYXx qQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
 by userp2120.oracle.com with ESMTP id 31f92649ut-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 05 Jun 2020 18:58:59 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
 by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 055IrcIT061319;
 Fri, 5 Jun 2020 18:58:58 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
 by aserp3030.oracle.com with ESMTP id 31f925twyb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 05 Jun 2020 18:58:58 +0000
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
 by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 055Iwu4a020495;
 Fri, 5 Jun 2020 18:58:56 GMT
Received: from starbug-mbp.localdomain (/79.97.215.145)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Fri, 05 Jun 2020 11:58:56 -0700
Received: by starbug-mbp.localdomain (Postfix, from userid 501)
 id 7EC6659BC5C; Fri,  5 Jun 2020 19:58:51 +0100 (IST)
From: Darren Kenny <darren.kenny@oracle.com>
To: Alexander Bulekov <alxndr@bu.edu>
Subject: Re: [PATCH v2] fuzz: add oss-fuzz build.sh script
In-Reply-To: <20200605182459.akripxavanjpv6rb@mozz.bu.edu>
References: <20200605175028.5626-1-alxndr@bu.edu>
 <m2a71hv1gf.fsf@oracle.com> <20200605182459.akripxavanjpv6rb@mozz.bu.edu>
Date: Fri, 05 Jun 2020 19:58:51 +0100
Message-ID: <m23679uyok.fsf@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9643
 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 mlxlogscore=999
 malwarescore=0 bulkscore=0 mlxscore=0 spamscore=0 suspectscore=2
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2006050139
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9643
 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 adultscore=0
 suspectscore=2 cotscore=-2147483648 bulkscore=0 clxscore=1015
 impostorscore=0 priorityscore=1501 malwarescore=0 mlxlogscore=999
 spamscore=0 lowpriorityscore=0 mlxscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006050139
Received-SPF: pass client-ip=156.151.31.85;
 envelope-from=darren.kenny@oracle.com; helo=userp2120.oracle.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/05 14:59:01
X-ACL-Warn: Detected OS   = Linux 3.1-3.10 [fuzzy]
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, UNPARSEABLE_RELAY=0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: bsd@redhat.com, qemu-devel@nongnu.org, stefanha@redhat.com, f4bug@amsat.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Friday, 2020-06-05 at 14:24:59 -04, Alexander Bulekov wrote:
> Hi Darren,
>
> On 200605 1858, Darren Kenny wrote:
>> Hi Alex,
>> 
>> From looking at another OSS Fuzz project recently (a coincidence) I
>> wonder if we could make this script work so that it can be run outside
>> of the OSS-Fuzz environment?
>> 
>> Specifically, for example, if $OUT is not set, then creating a subdir in
>> the build directory, and setting it to be that.
>> 
> For $OUT, do you think it would be better to require it as
> a user-configurable environment variable? My concern is that making it
> a subdirectory of the build dir would mean that the pc-bios files exist 
> located in $OUT/../pc-bios. This doesn't reflect OSS-Fuzz, where we
> specifically have to copy them to $OUT/pc-bios/
>

The script is copying them in to $OUT near the end still, isn't it?
That should be fine if it is, shouldn't it? Or am I missing something?

Thanks,

Darren.

