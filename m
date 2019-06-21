Return-Path: <SRS0=2JTU=UU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09F32C43613
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2019 17:55:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CC04B2070B
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2019 17:55:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="w4af91lO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC04B2070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37130 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1heNlE-0003He-0F
	for qemu-devel@archiver.kernel.org; Fri, 21 Jun 2019 13:55:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34399)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <liran.alon@oracle.com>) id 1heNkN-0002rn-UP
 for qemu-devel@nongnu.org; Fri, 21 Jun 2019 13:54:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <liran.alon@oracle.com>) id 1heNkM-0003YX-Vt
 for qemu-devel@nongnu.org; Fri, 21 Jun 2019 13:54:47 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:58406)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <liran.alon@oracle.com>)
 id 1heNkM-0003Vs-LL
 for qemu-devel@nongnu.org; Fri, 21 Jun 2019 13:54:46 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
 by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5LHnbls003481;
 Fri, 21 Jun 2019 17:54:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2018-07-02; bh=UBGKF/8CtSmjB4UllsCvtGV0k2KVy+E0/wIloRtM1h8=;
 b=w4af91lOi3q+g+DLG/6IYrEQ8iaHlhwIj98Bq9QRE80HtimF1bqsXCDMnKFVPv1uubOD
 2gCVypdvlR/jP8IfBPRnK+m1AjTRRJSLsz47aW6VFYXKt+35axWaRphtgdPPzGG4JuDk
 rFCmlVUkPTkoG5rrxYxc03JzZqq9qOAYvDAEHgvhsidRA9XK3mC/qbrUQSwNmMSytaYr
 0VvyHMMWtz7orYxyl/olaQxO+X/dbCEpJaHkfHqhevHC6p3BxYSKuSbZTutN7vwTF7b1
 PYThAXOvrwRojBQ1ZtFerB8O+rdf1HSFnh12tpB16FpZUzrqkY+on5p8GvxkqqMIMyX9 lA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
 by userp2130.oracle.com with ESMTP id 2t7809qtnr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 21 Jun 2019 17:54:42 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
 by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5LHrv0b106650;
 Fri, 21 Jun 2019 17:54:41 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
 by userp3030.oracle.com with ESMTP id 2t77ypaw0m-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 21 Jun 2019 17:54:41 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
 by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x5LHseXO028705;
 Fri, 21 Jun 2019 17:54:40 GMT
Received: from [192.168.14.112] (/109.64.216.174)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Fri, 21 Jun 2019 10:54:40 -0700
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 11.1 \(3445.4.7\))
From: Liran Alon <liran.alon@oracle.com>
In-Reply-To: <ab9169bb-5254-c928-c5f0-59fc3a7cd6d2@redhat.com>
Date: Fri, 21 Jun 2019 20:54:37 +0300
Content-Transfer-Encoding: quoted-printable
Message-Id: <B532E827-847B-4D5C-A7D1-ACCA42D97D20@oracle.com>
References: <1561116620-22245-1-git-send-email-pbonzini@redhat.com>
 <1561116620-22245-23-git-send-email-pbonzini@redhat.com>
 <96A3CC63-2B7D-44C2-AA9A-C02AF8FC3691@oracle.com>
 <150eb2f8-3b1a-e0ab-df36-adcbd601055d@redhat.com>
 <672D2B0A-E79C-467A-A9F0-57DC414842C3@oracle.com>
 <ab9169bb-5254-c928-c5f0-59fc3a7cd6d2@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
X-Mailer: Apple Mail (2.3445.4.7)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9295
 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906210139
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9295
 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906210139
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 156.151.31.86
Subject: Re: [Qemu-devel] [PULL 22/25] target/i386: kvm: Add nested
 migration blocker only when kernel lacks required capabilities
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



> On 21 Jun 2019, at 20:27, Paolo Bonzini <pbonzini@redhat.com> wrote:
>=20
> On 21/06/19 17:07, Liran Alon wrote:
>>> So, overall I prefer not to block migration.
>> I=E2=80=99m not sure I agree.
>> It is quite likely that vCPU is currently in guest-mode while you are =
migrating=E2=80=A6
>> A good hypervisor tries to maximise CPU time to be in guest-mode =
rather than host-mode. :)
>=20
> True, but it is even more likely that they are not using KVM at all =
and
> just happen to have the CPUID flag set. :)
>=20
> Paolo

Since QEMU commit 75d373ef9729 ("target-i386: Disable SVM by default in =
KVM mode"),
An AMD vCPU that is virtualized by KVM don=E2=80=99t expose SVM by =
default. Even if you use "-cpu host".
Therefore, it is unlikely that vCPU expose SVM CPUID flag when user is =
not running any nSVM
workload inside guest. Unless I=E2=80=99m missing something obvious.
Otherwise, I would have agreed with you.

-Liran=

