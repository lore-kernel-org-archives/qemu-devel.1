Return-Path: <SRS0=VLgg=X4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69CA9C10F14
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Oct 2019 10:50:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 34A622086A
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Oct 2019 10:50:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="m06moV/M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34A622086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34614 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFygo-0007ev-Qy
	for qemu-devel@archiver.kernel.org; Thu, 03 Oct 2019 06:50:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58287)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <darren.kenny@oracle.com>) id 1iFyg1-0007Bv-J2
 for qemu-devel@nongnu.org; Thu, 03 Oct 2019 06:49:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <darren.kenny@oracle.com>) id 1iFyfz-0006ix-42
 for qemu-devel@nongnu.org; Thu, 03 Oct 2019 06:49:40 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:44620)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <darren.kenny@oracle.com>)
 id 1iFyfy-0006hx-QY
 for qemu-devel@nongnu.org; Thu, 03 Oct 2019 06:49:39 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
 by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x93An7Jr098282;
 Thu, 3 Oct 2019 10:49:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2019-08-05;
 bh=wgtj7vCd2UoOMjZbDvRXUnhEyyU/efLjqJqeflz2pr8=;
 b=m06moV/M+sOvqcM7j2lOSl0V+02n64S/OVFXdYETfTCEJ5/6lSAT5EmHV9CuQG9EKM5J
 saOMoKLeKKi4VvORGp37cLMTMn4zc3dFQ4S/JsRtFq76wqFBxr1KxkNv/DBjj8MK+WO4
 llbLEm7QEhNCWhuZ2e4HCpj70c4Kbafv05LAHiy1CMz2fCQHeS0cIBwMLmkNlGqHATqh
 lDN+iQM+sU8QoHG1ddXcyO/PguM0inn/xpO2KG5DI4LwPqoG8KnHFgnlXVPfYXjxH3Tb
 71+xQGSjePwOGGPht6OomqO4kXHRqCnX2NTPleElmFEuCRNHH7rURvBsw7/cow+26Fbj Mw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
 by userp2130.oracle.com with ESMTP id 2v9xxv32tp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 03 Oct 2019 10:49:34 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
 by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x93An4gw048946;
 Thu, 3 Oct 2019 10:49:34 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
 by userp3020.oracle.com with ESMTP id 2vc9dnjq1d-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 03 Oct 2019 10:49:34 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
 by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x93AnVEe024226;
 Thu, 3 Oct 2019 10:49:31 GMT
Received: from starbug-mbp.localdomain (/10.169.111.26)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Thu, 03 Oct 2019 03:49:31 -0700
Received: from starbug-mbp (localhost [127.0.0.1])
 by starbug-mbp.localdomain (Postfix) with SMTP id DFB8F4759E37;
 Thu,  3 Oct 2019 11:49:28 +0100 (IST)
Date: Thu, 3 Oct 2019 11:49:28 +0100
From: Darren Kenny <darren.kenny@oracle.com>
To: qemu-devel@nongnu.org
Subject: Qemu/KVM fuzzing - next steps
Message-ID: <20191003104928.crwjanhymtmwdboc@starbug-mbp>
Mail-Followup-To: qemu-devel@nongnu.org, pbonzini@redhat.com,
 bsd@redhat.com, stefanha@redhat.com, rth@twiddle.net, alxndr@bu.edu
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
User-Agent: NeoMutt/20180716
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9398
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910030100
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9398
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910030100
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
Cc: darren.kenny@oracle.com, alxndr@bu.edu, bsd@redhat.com, stefanha@redhat.com,
 pbonzini@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,

I've been following Alexander's fuzzing changes from the GSoC
project, and it's looking like an excellent start on the
introduction of fuzzing into the world of Qemu/KVM.

I had a couple of off-list e-mails with Stefan and Alexander, to get
some idea of what the intent was going forward, and it was suggested
that we should discuss things in the open on the list to allow
everyone to contribute.

Unfortunately, I'm probably not going to be able to make it to the
KVMForum at the end of the month, so guess I'll have to settle for
e-mail for now :)

It is my understanding that the primary focus is to work on a
solution that would permit integration into Google's OSSFuzz
service[1] to allow for continuous fuzzing and automatic reporting
of issues found.

Once Alexander lands his patches, things will be 1 step closer to
this goal.

The question then is, well what next?

From what Stefan said to me, the intention is to work on expanding
the scope of the fuzzing, adding more test cases for a wider range
of machine and devices types.

I hope to be able to help out here, since this is an area that I'm
also interested in with my work in Oracle Linux's virtualization
team.

How would you like to move forward? Is there an ordered list of
device or machines that we'd like to focus on anywhere? If not,
could we create one?

Thanks,

Darren.

[1] - https://github.com/google/oss-fuzz

