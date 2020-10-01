Return-Path: <SRS0=M6H1=DI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01467C4727F
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 13:59:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A77320872
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 13:59:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="VXXEegTS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A77320872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47462 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNz71-00088D-M0
	for qemu-devel@archiver.kernel.org; Thu, 01 Oct 2020 09:59:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57098)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <konrad.wilk@oracle.com>)
 id 1kNz6J-0007g6-N9
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 09:58:27 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:55224)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <konrad.wilk@oracle.com>)
 id 1kNz6F-0004VE-EF
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 09:58:27 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
 by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 091Drr3G155611;
 Thu, 1 Oct 2020 13:58:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=8s675BCnZ8XFZkkfrKEMmvVBlSk8uzbv4H9K/BsZtns=;
 b=VXXEegTSzX0C9QutPwXEUIg09vfZE3zb5RQ1M7R1RkEu5tw/5z6joqkcS5SGft2cIiXz
 C1oPwpmWOfQX9NtfPV2E8OQLZEnVtrAXFIw9B2B6TY8x/5nkaXW/dUgtMr4L1ZFS3bVI
 Hrk1jQBMmxr2wW9Udy+F7Jzd8EX7IJgvOlGRdzckvOfhkujZnPdjAsqjs5UoCPKkp7nt
 lLfu291ERpCgGFVzw1yNzLKby2k8DPCf6fLMAqSS2Xb/J3Hd+liJLLSI1OYjXcUrPQdd
 BH1Py4v/6je2lt7kA0OWWXKdW7eb4vgBeiktmQ3CwcLi38D1jA/AMocERP0E4v2jSyP8 Fg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
 by aserp2130.oracle.com with ESMTP id 33su5b68xe-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 01 Oct 2020 13:58:15 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
 by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 091Dnp4c024203;
 Thu, 1 Oct 2020 13:56:14 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
 by userp3030.oracle.com with ESMTP id 33tfk1km0h-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 01 Oct 2020 13:56:14 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
 by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 091DuDwj010651;
 Thu, 1 Oct 2020 13:56:13 GMT
Received: from char.us.oracle.com (/10.152.32.25)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Thu, 01 Oct 2020 06:56:12 -0700
Received: by char.us.oracle.com (Postfix, from userid 1000)
 id 8E2966A5D95; Thu,  1 Oct 2020 09:57:42 -0400 (EDT)
Date: Thu, 1 Oct 2020 09:57:42 -0400
From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
To: Darren Kenny <darren.kenny@oracle.com>
Subject: Re: About 'qemu-security' mailing list
Message-ID: <20201001135742.GA28956@char.us.oracle.com>
References: <nycvar.YSQ.7.78.906.2009111910280.36374@xnncv>
 <CAFEAcA_9BVbqFCHJqS8jj6L3OqVNc60NCjAjRs516VyLH2EFfw@mail.gmail.com>
 <20200914101517.GD579094@stefanha-x1.localdomain>
 <nycvar.YSQ.7.78.906.2009151536090.10832@xnncv>
 <20200916111025.GA756728@stefanha-x1.localdomain>
 <nycvar.YSQ.7.78.906.2009181031500.10832@xnncv>
 <m2362z8dvx.fsf@oracle.com>
 <nycvar.YSQ.7.78.906.2010011502290.830962@xnncv>
 <m2mu166uyg.fsf@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m2mu166uyg.fsf@oracle.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9760
 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 spamscore=0 mlxscore=0
 phishscore=0 adultscore=0 bulkscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2010010119
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9760
 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 suspectscore=0
 lowpriorityscore=0 spamscore=0 clxscore=1031 mlxscore=0 impostorscore=0
 malwarescore=0 phishscore=0 adultscore=0 bulkscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2010010119
Received-SPF: pass client-ip=141.146.126.79;
 envelope-from=konrad.wilk@oracle.com; helo=aserp2130.oracle.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/01 09:58:19
X-ACL-Warn: Detected OS   = Linux 3.1-3.10 [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
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
Cc: peter.maydell@linaro.org, Stefan Hajnoczi <stefanha@gmail.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, P J P <ppandit@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

. monster snip..
> > Maybe we could start with a moderated list and improvise as we go forward?
> 
> I really think that encryption of the details of a vulnerability is
> important, if somehow it gets intercepted - which is not that difficult
> with e-mail - then there is the potential for a malicious party to
> exploit it before a fix is available to distros, and deployed.

.. I found out yesterday that most of the emails around the world are
using TLS which does remove the interception part. The attack is then
to get on say Prasad's box .. and if you do that it really does not
matter if you use encryption or not.

> 
> Something that has happened since the Intel Spectre/Meltdown
> vulnerabilities were initially brought to light is more communication
> between security teams in various orgs. To do this those discussions
> have started being done on Keybase, which provides secure chats as well
> as secured Git repos.
> 
> Has anything like that being considered as the point for subsequent
> discussions on issues post the initial disclosure?

The problem with Keybase was how to review patches. Now if they had a
encrypted mailing list as part of their Git repos that would be awesome.
(Trying to find a "Feature request" but not having much luck :-()

