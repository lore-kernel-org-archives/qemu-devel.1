Return-Path: <SRS0=9X/F=UF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6F29C04AB5
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 15:19:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A58A820673
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 15:19:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ntNHBmzJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A58A820673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:33850 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYuAN-0000t8-R3
	for qemu-devel@archiver.kernel.org; Thu, 06 Jun 2019 11:18:59 -0400
Received: from eggs.gnu.org ([209.51.188.92]:37885)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liran.alon@oracle.com>) id 1hYu7l-0007e3-Iy
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 11:16:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liran.alon@oracle.com>) id 1hYu7h-000172-Gx
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 11:16:16 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:49850)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <liran.alon@oracle.com>)
	id 1hYu7e-0000yM-CJ
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 11:16:11 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
	by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id
	x56F8SfK141206; Thu, 6 Jun 2019 15:16:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
	h=content-type :
	mime-version : subject : from : in-reply-to : date : cc :
	content-transfer-encoding : message-id : references : to;
	s=corp-2018-07-02; bh=CDTQkCO4/rg3QJcNgNb8TlhA+WG8dT+HhuIZhAIvmlk=;
	b=ntNHBmzJluXNHKghC41bd3b74UVG1VXqMAUe4Duob/0ZvtQ2h6BlKm0szUw42GwuTiXh
	OySzagHV9oNMk6Ivp7kYqjmTaYvJQxqcR588UYOhgg8t0BvGa12sXoc9/rI9GPu26e1l
	ausm2ic8C3ihGF67bXQBjBE9jfqpFlNsplzwo8vRUwyBxlrMtqqsRqobS/p9mEOFik/J
	eJ+xGmX4IWfwROe0qwAFpMg8Di9i3XrLfqq4svbkzk2RM8hXgq5DZ48b8HKypCSeuNiR
	UF5VsGJbxQBwwDu9wbkUOl6lAFjUYog+Eu8LVPHPsunA7J6NhRBOlStXg5/44KN6mUsv
	VQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
	by userp2120.oracle.com with ESMTP id 2suj0qs1pm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 06 Jun 2019 15:16:07 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
	by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id
	x56FEY5H171001; Thu, 6 Jun 2019 15:16:07 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
	by userp3020.oracle.com with ESMTP id 2swnhatc6p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 06 Jun 2019 15:16:06 +0000
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
	by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x56FG5B7014511;
	Thu, 6 Jun 2019 15:16:06 GMT
Received: from [10.30.3.6] (/213.57.127.2)
	by default (Oracle Beehive Gateway v4.0)
	with ESMTP ; Thu, 06 Jun 2019 08:16:05 -0700
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 11.1 \(3445.4.7\))
From: Liran Alon <liran.alon@oracle.com>
In-Reply-To: <20190606133138.GM2788@work-vm>
Date: Thu, 6 Jun 2019 18:16:02 +0300
Content-Transfer-Encoding: quoted-printable
Message-Id: <041C1ABE-48B4-487A-B0EF-67F0FBFCA8BE@oracle.com>
References: <38B8F53B-F993-45C3-9A82-796A0D4A55EC@oracle.com>
	<20190606084222.GA2788@work-vm>
	<862DD946-EB3C-405A-BE88-4B22E0B9709C@oracle.com>
	<20190606092358.GE2788@work-vm>
	<8F3FD038-12DB-44BC-A262-3F1B55079753@oracle.com>
	<20190606103958.GJ2788@work-vm>
	<B7A9A778-9BD5-449E-A8F3-5D8E3471F4A6@oracle.com>
	<20190606110737.GK2788@work-vm>
	<3F6B41CD-C7E2-4A61-875C-F61AE45F2A58@oracle.com>
	<20190606133138.GM2788@work-vm>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
X-Mailer: Apple Mail (2.3445.4.7)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9280
	signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
	malwarescore=0
	phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
	adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
	engine=8.0.1-1810050000 definitions=main-1906060104
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9280
	signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
	priorityscore=1501 malwarescore=0
	suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
	lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999
	adultscore=0
	classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
	definitions=main-1906060104
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 156.151.31.85
Subject: Re: [Qemu-devel] QEMU/KVM migration backwards compatibility broken?
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
	kvm list <kvm@vger.kernel.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


> On 6 Jun 2019, at 16:31, Dr. David Alan Gilbert <dgilbert@redhat.com> =
wrote:
>=20
>>>=20
>>> So we still need to tie subsections to machine types; that way
>>> you don't send them to old qemu's and there for you don't have the
>>> problem of the qemu receiving something it doesn't know.
>>=20
>> I agree that if there is no way to skip a VMState subsection in the =
stream, then we must
>> have a way to specify to source QEMU to prevent sending this =
subsection to destination=E2=80=A6
>>=20
>> I would suggest though that instead of having a flag tied to =
machine-type, we will have a QMP command
>> that can specify names of subsections we explicitly wish to be =
skipped sending to destination even if their .needed() method returns =
true.
>=20
> I don't like the thought of generically going behind the devices back;
> it's pretty rare to have to do this, so adding a qmp command to tweak
> properties that we've already got seems to make more sense to me.
>=20
>> This seems like a more explicit approach and doesn=E2=80=99t come =
with the down-side of forever not migrating this VMState subsection
> Dave

If I understand you correctly, this is what you propose:
1) Have a .post_load() method for VMState subsections that depend on =
kernel capability to fail migration in case capability do not exist.
2) For specific problematic VMState subsections, add property such that =
it=E2=80=99s .needed() method will return false in case the property is =
set to false (value is true by default).
3) Have a QMP command that allows dynamically changing the value of =
these properties.
4) Properties values are still tied to machine-type? I think not right?

I instead propose the following:
1) Same as (1) above.
2) Add a MigrationParameter (and matching MigrationCapability) named =
=E2=80=9Cavoid_state=E2=80=9D that specifies list of subsection names to =
avoid sending in migration even if their .needed() method will return =
false. i.e. We will modify migration/vmstate.c to not even call =
.needed() method of such subsection.

I believe the second proposal have the following advantages:
1) Less error-prone: .needed() methods are written only once and don=E2=80=
=99t need to take into account additional properties when calculating if =
they are required or not. Just depend on guest state.
2) Generic: We don=E2=80=99t require additional patch to add a new =
property to support avoiding sending some subsection in case it =
doesn=E2=80=99t matter for some workload. As we have discovered only =
late after msr_smi_count was added (by me) at that point. Second =
approach allows avoid sending any subsection that is deemed not =
important to guest workload by migration admin.
3) Not tied to machine-type: Properties are usually tied to machine-type =
as they need to remain same forever for the lifetime of the guest. =
However, migration parameters are per-migration and are meant to be =
tweaked and changed. This allows a guest that used to run on old QEMU =
and moved to new QEMU to now have better state saved for it=E2=80=99s =
next future migrations.

Currently we indeed have very rare cases like this ([git grep =
\"x-migrate | wc -l] product only 4 results=E2=80=A6) but I=E2=80=99m =
not sure it=E2=80=99s not only because we haven=E2=80=99t analysed =
carefully the case of
restored properties that it=E2=80=99s property depend on kernel =
capability.

As a start thought, we can start by at least agreeing to implement (1) =
and consider the property VS MigrationParameter discussion for a later =
time.

What do you think?

-Liran









