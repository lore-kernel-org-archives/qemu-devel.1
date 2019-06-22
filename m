Return-Path: <SRS0=QkNH=UV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54EF0C43613
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Jun 2019 00:46:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1FDFF2070B
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Jun 2019 00:46:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="zBYngyrh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FDFF2070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38592 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1heUAj-0003Yt-8M
	for qemu-devel@archiver.kernel.org; Fri, 21 Jun 2019 20:46:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50648)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <liran.alon@oracle.com>) id 1heU99-0002d8-T9
 for qemu-devel@nongnu.org; Fri, 21 Jun 2019 20:44:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <liran.alon@oracle.com>) id 1heU97-000455-9u
 for qemu-devel@nongnu.org; Fri, 21 Jun 2019 20:44:47 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:41612)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <liran.alon@oracle.com>)
 id 1heU96-00040E-TL
 for qemu-devel@nongnu.org; Fri, 21 Jun 2019 20:44:45 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
 by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5M0hvbf184839;
 Sat, 22 Jun 2019 00:44:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2018-07-02; bh=0pcFFU3ampzWJDEmRw5Lhug74KQ+edltrPniNUhvuZs=;
 b=zBYngyrhzgQ9AibRMh4NeQw5aCQnqmGe1LXy2AQEsSW/+HUGxiS98cldUGbjnniD+izk
 z978z/9EjPhsupydM12vpDs2+4eqmoewfdaN/qFyRXSEWlcU+EhAZTzhvmq8sx9GBSEN
 IbWOL9DDfh8izC7Ik9+bZMRirpgNoOhchCjfsZzZ8dl27ekda8s5zf4ZBODc9cBLO/Ly
 tUNCWWxH+3OSTgsxdNLyqMXsonQwyq/P7zkbNyLnJ6Fdd5+5cLoPg+AGdjRTPWtsTTp0
 lpHWB4QszGa9S7U3hbBA0quia/2pKW4rwg+mAOp9w7H1sXdNCYh8zhgjPBSzF+F5jFNK ag== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
 by aserp2120.oracle.com with ESMTP id 2t7809rs81-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sat, 22 Jun 2019 00:44:42 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
 by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5M0hhTa119982;
 Sat, 22 Jun 2019 00:44:42 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
 by userp3030.oracle.com with ESMTP id 2t99f2g9vu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sat, 22 Jun 2019 00:44:42 +0000
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
 by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x5M0ie94005852;
 Sat, 22 Jun 2019 00:44:41 GMT
Received: from [192.168.14.112] (/109.64.216.174)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Fri, 21 Jun 2019 17:44:40 -0700
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 11.1 \(3445.4.7\))
From: Liran Alon <liran.alon@oracle.com>
In-Reply-To: <01713909-71dd-99e6-40bf-a2b93dfbd578@redhat.com>
Date: Sat, 22 Jun 2019 03:44:37 +0300
Content-Transfer-Encoding: quoted-printable
Message-Id: <323EE54C-1A7B-48FD-922C-74BEFBB1C3D6@oracle.com>
References: <20190621213712.16222-1-liran.alon@oracle.com>
 <01713909-71dd-99e6-40bf-a2b93dfbd578@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
X-Mailer: Apple Mail (2.3445.4.7)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9295
 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906220005
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9295
 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906220005
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 141.146.126.78
Subject: Re: [Qemu-devel] [PATCH 0/2] target/i386: kvm: Fix treatment of AMD
 SVM in nested migration
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
Cc: qemu-devel@nongnu.org, dgilbert@redhat.com, maran.wilson@oracle.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



> On 22 Jun 2019, at 2:59, Paolo Bonzini <pbonzini@redhat.com> wrote:
>=20
> On 21/06/19 23:37, Liran Alon wrote:
>> However, during discussion made after merge, it was realised that =
since QEMU commit
>> 75d373ef9729 ("target-i386: Disable SVM by default in KVM mode"), an =
AMD vCPU that
>> is virtualized by KVM doesn't expose SVM by default, even if you use =
"-cpu host".
>> Therefore, it is unlikely that vCPU expose SVM CPUID flag when user =
is not running
>> an SVM workload inside guest.
>=20
> libvirt has "host-model" mode, which constructs a "-cpu
> model,+feature,+feature" command line option that matches the host as
> good as possible.  This lets libvirt check migratability while =
retaining
> a lot of the benefits of "-cpu host", and is the default for OpenStack
> for example.  I need to check if libvirt adds SVM to this =
configuration,
> if it does the QEMU commit you mention is unfortunately not enough.
>=20
> Paolo

Hmm nice catch. I haven=E2=80=99t thought about it (Not familiar much =
with libvirt).
I agree that if libvirt adds SVM to this configuration than we must not =
block
migration for an AMD vCPU that is exposed with SVM=E2=80=A6 :(

Please update once you figure out libvirt behaviour regarding this,
-Liran


