Return-Path: <SRS0=M6H1=DI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C62CEC4727C
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 11:35:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B9CB20838
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 11:35:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="rfaNa2B/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B9CB20838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38604 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNwsO-000424-Gm
	for qemu-devel@archiver.kernel.org; Thu, 01 Oct 2020 07:35:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47070)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <darren.kenny@oracle.com>)
 id 1kNwrE-00039y-GT
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 07:34:45 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:35956)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <darren.kenny@oracle.com>)
 id 1kNwrB-0000kt-5v
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 07:34:43 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
 by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 091BY6VA004057;
 Thu, 1 Oct 2020 11:34:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : in-reply-to : references : date : message-id : mime-version :
 content-type; s=corp-2020-01-29;
 bh=gZsGw4+ursIrFSW50UK+O6SBcusnyDeLYTofZBjCtd8=;
 b=rfaNa2B/yBVGzlX4WxhlvAr+Jby8OBDHPh8Mvj3LxRm4H03ZBFnAph+dskfRu9PcN+hD
 eWlNQQRPNI5cx4LbY8EdPwv8oOt/DUbwLu3RyHDJQ+EtzOn2OAvdu/uXNaoYZHixBUBp
 CkIHkEvf9UAVPiZJOH1vZkUPtoX1yivd6q4PzETrLAwFh8/VBY/qQdCgmn1HkW6DyPqd
 oCKihxP1Pjqww+a6D4d+wciBfDHVpqLl8lNpRAYxfOTJcBpsK7R4JrRlXShLycbvaXZf
 ChF37wum0jJ6FagRkoTUHuj4Gpo9PAKgqlbfsQdmoocpxXF7YsW2Cu3EMSsQivoRL3Vv Fw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
 by aserp2120.oracle.com with ESMTP id 33swkm5dfg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 01 Oct 2020 11:34:37 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
 by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 091BUXdK015418;
 Thu, 1 Oct 2020 11:34:37 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
 by aserp3020.oracle.com with ESMTP id 33tfj1hg95-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 01 Oct 2020 11:34:37 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
 by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 091BYZQN011642;
 Thu, 1 Oct 2020 11:34:36 GMT
Received: from starbug-mbp.localdomain (/79.97.215.145)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Thu, 01 Oct 2020 04:34:35 -0700
Received: by starbug-mbp.localdomain (Postfix, from userid 501)
 id 55B0318E80AA; Thu,  1 Oct 2020 12:34:31 +0100 (IST)
From: Darren Kenny <darren.kenny@oracle.com>
To: P J P <ppandit@redhat.com>
Subject: Re: About 'qemu-security' mailing list
In-Reply-To: <nycvar.YSQ.7.78.906.2010011502290.830962@xnncv>
References: <nycvar.YSQ.7.78.906.2009111910280.36374@xnncv>
 <CAFEAcA_9BVbqFCHJqS8jj6L3OqVNc60NCjAjRs516VyLH2EFfw@mail.gmail.com>
 <20200914101517.GD579094@stefanha-x1.localdomain>
 <nycvar.YSQ.7.78.906.2009151536090.10832@xnncv>
 <20200916111025.GA756728@stefanha-x1.localdomain>
 <nycvar.YSQ.7.78.906.2009181031500.10832@xnncv>
 <m2362z8dvx.fsf@oracle.com>
 <nycvar.YSQ.7.78.906.2010011502290.830962@xnncv>
Date: Thu, 01 Oct 2020 12:34:31 +0100
Message-ID: <m2mu166uyg.fsf@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9760
 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 mlxlogscore=999 bulkscore=0
 phishscore=0 malwarescore=0 adultscore=0 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2010010101
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9760
 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 mlxscore=0 phishscore=0
 suspectscore=0 mlxlogscore=999 clxscore=1031 priorityscore=1501
 impostorscore=0 lowpriorityscore=0 bulkscore=0 spamscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2010010101
Received-SPF: pass client-ip=141.146.126.78;
 envelope-from=darren.kenny@oracle.com; helo=aserp2120.oracle.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/01 07:34:39
X-ACL-Warn: Detected OS   = Linux 3.1-3.10 [fuzzy]
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
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
Cc: Stefan Hajnoczi <stefanha@gmail.com>,
 =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thursday, 2020-10-01 at 16:05:58 +0530, P J P wrote:
>   Hello Darren,
>
> +-- On Wed, 30 Sep 2020, Darren Kenny wrote --+
> | While that is true, some aliases have managed to do something here by having 
> | a single key for the alias, and behind the scenes that re-encrypts the 
> | e-mail for each member of that alias (trying to avoid the 'list' term a 
> | little here)
> | 
> | An example of this is the 'distro's list, e.g.: 
> | - https://oss-security.openwall.org/wiki/mailing-lists/distros
>
> * Yes, true. But it accepts non-encrypted reports too IIUC.

I believe so.

I wonder, in the case of non-encrypted reports, it would be better to
suggest that in that case, it would only be an initial contact, no
significant details.

After that some discussion could be done on reproducers, etc on a more
secure list.

>
> * I'm not sure how is the 'behind the scenes re-encryption' workflow for 
>   non-member reporters.
>  
>   - Ex. say 2-3 non-member reporter(s) send an encrypted report with their 
>     public keys.
>

AFAIK the original message needs to be encrypted with a specific key,
which is on the website above - so all reporters would be using that.

>   - A list member triaging such issue, would have to select their individual 
>     keys for each reply.

Maybe, honestly not had to deal with it personally.

>
>
> | If you're looking to announce before a security issue is fixed, it may just 
> | be better to keep it to the qemu-security members, which should try to 
> | include at least 1, if not more, members from interested distros.
>
> * No, I didn't mean an '-announce' list for non-security members. I was more 
>   wondering about how to handle reproducers and other artefacts sent to the
>   list.

The storage of reproducers would indeed be good to have in something
like Gitlab - but that'd require someone to extract it and store it, but
under what naming would be another issue... But really that's behind the
scenes.

>
> * Proposed 'qemu-security' list is meant to have representatives from 
>   downstream QEMU user communities.

Excellent, that would be good.

>
>
> | I know from past kernel security issues, it is still important to a distro 
> | to be able to reproduce any issues if a PoC is provided.
>
> * Yes, that's true. It should be okay in that case to keep the reproducers and 
>   such artefacts on the list then.
>  
>

...

>
> | I would agree that Gitlab may be better here, if it would work - Gitlab
> | can certainly be configured to restrict access to specific projects, but
> | I'm not sure how that would play into logging an issue if you can't even
> | see the project in question as a non-member of the security team.
>
> * True. Reporters may need to open/create GitLab account to report issues.

Hmm, it's here that I think it becomes difficult for everyone to log an
issue, even with an account, you may not be able to log an issue on a
project that is otherwise secured.

>
> To summarise:
> =============
>   - Bugzilla or GitLab issues would entail reporters create an account there 
>     to report issues.
>
>   - On a moderated 'qemu-security' list, even a non-member shall be able to 
>     report issues via email.
>
>   - Many voices have said 'Yes' for a moderated 'qemu-security' list.
>
>   - Whether to have an encrypted list or otherwise, is an open question.
>  
>     + Encrypted list(ex. -distros) is possible. But it accepts non-encrypted 
>       mails too IIUC.
>
>     + Mandatory encryption would entail reporters create/share their keys.  
>       It may become tricky, if reporters are non-members.
>
>   - It should be okay to keep reproducers etc. artefacts on the list..?
>     List archives shall not be publicly accessible.
>
>
> Maybe we could start with a moderated list and improvise as we go forward?

I really think that encryption of the details of a vulnerability is
important, if somehow it gets intercepted - which is not that difficult
with e-mail - then there is the potential for a malicious party to
exploit it before a fix is available to distros, and deployed.

Something that has happened since the Intel Spectre/Meltdown
vulnerabilities were initially brought to light is more communication
between security teams in various orgs. To do this those discussions
have started being done on Keybase, which provides secure chats as well
as secured Git repos.

Has anything like that being considered as the point for subsequent
discussions on issues post the initial disclosure?

Thanks,

Darren.


