Return-Path: <SRS0=0j61=C7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A716C2D0E2
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 09:25:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 93F362075E
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 09:25:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="SPZstK+P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93F362075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49462 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKeYL-0005Jl-FL
	for qemu-devel@archiver.kernel.org; Tue, 22 Sep 2020 05:25:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36958)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bharata@linux.ibm.com>)
 id 1kKeVS-0001gN-PS; Tue, 22 Sep 2020 05:22:38 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:44200
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bharata@linux.ibm.com>)
 id 1kKeVQ-0005a4-FC; Tue, 22 Sep 2020 05:22:38 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 08M91WlI121761; Tue, 22 Sep 2020 05:22:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=date : from : to : cc :
 subject : message-id : reply-to : references : mime-version : content-type
 : in-reply-to; s=pp1; bh=5DOg86/wUOdfqcNwy75H8+OuoPT7w0m0T8+K6t4UJdI=;
 b=SPZstK+PHZNxjkS95QW7XcEwG5pzFOAR7iUVtvNPcPg1CctV39zeC53RZxo+8PGyQDkJ
 1DNBYNzUmsfWqpeY6eSr+W8GcTgcvlo51+lG5Qptm4XgbbZItUEp4yOR8rkfVRKU05rJ
 IsqQQHGWLeiwTBHnXOKWwpTTW3FeVrpyXDnKztD5jc+Q/yOxpW+wgoKFdBIjTPW6yAZx
 ha8k1eeI27Ahchxd1oaeiNXnjMtMWB+08Sy+eznCDvLJCCCwixgaItImqRn5WuSIAEBH
 EoZxmkoDD0tZrJohsZnSxYZLjnZJGoYawMG0WfJfe4cOBy7NqFiczNH693crDOVGWrAF zw== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0b-001b2d01.pphosted.com with ESMTP id 33qbk5wh4p-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 22 Sep 2020 05:22:29 -0400
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 08M91gud122701;
 Tue, 22 Sep 2020 05:22:28 -0400
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com
 [169.51.49.102])
 by mx0b-001b2d01.pphosted.com with ESMTP id 33qbk5wh47-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 22 Sep 2020 05:22:28 -0400
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
 by ppma06ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 08M9BvSB014317;
 Tue, 22 Sep 2020 09:22:27 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com
 (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
 by ppma06ams.nl.ibm.com with ESMTP id 33n98gtx91-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 22 Sep 2020 09:22:26 +0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com
 [9.149.105.60])
 by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 08M9MORL27984142
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 22 Sep 2020 09:22:24 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C8FEE4203F;
 Tue, 22 Sep 2020 09:22:24 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A36E842042;
 Tue, 22 Sep 2020 09:22:22 +0000 (GMT)
Received: from in.ibm.com (unknown [9.77.201.43])
 by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
 Tue, 22 Sep 2020 09:22:22 +0000 (GMT)
Date: Tue, 22 Sep 2020 14:52:20 +0530
From: Bharata B Rao <bharata@linux.ibm.com>
To: David Hildenbrand <david@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] target-ppc: Add quad precision muladd
 instructions
Message-ID: <20200922092220.GA4843@in.ibm.com>
References: <46207f02-b133-86f4-0e83-3cf9e8486ef7@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <46207f02-b133-86f4-0e83-3cf9e8486ef7@redhat.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235, 18.0.687
 definitions=2020-09-22_06:2020-09-21,
 2020-09-22 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 mlxscore=0
 phishscore=0 priorityscore=1501 impostorscore=0 mlxlogscore=746
 suspectscore=0 lowpriorityscore=0 adultscore=0 clxscore=1011
 malwarescore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009220071
Received-SPF: pass client-ip=148.163.158.5; envelope-from=bharata@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/22 05:22:33
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
Reply-To: bharata@linux.ibm.com
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 qemu-s390x <qemu-s390x@nongnu.org>, nikunj.dadhania@gmail.com,
 qemu-ppc <qemu-ppc@nongnu.org>, Bharata B Rao <bharata@linux.vnet.ibm.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Sep 22, 2020 at 10:04:53AM +0200, David Hildenbrand wrote:
> Hi guys,
> 
> I just stumbled over
> 
> https://lore.kernel.org/qemu-devel/1487140636-19955-1-git-send-email-bharata@linux.vnet.ibm.com/
> 
> while looking for the state of float128_muladd(), as I need that for
> s390x as well.
> 
> @Bharata, did you manage to implement a prototype? Looking into
> float128_mul() makes my head spin.

I did try but couldn't figure out a way to implement some of the
dependent functions. Hence we still don't have quad-precision
multiply-add/sub instructions in ppc.

Regards,
Bharata.

