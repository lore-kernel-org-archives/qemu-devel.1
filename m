Return-Path: <SRS0=M8fn=UR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15123C31E5B
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2019 16:46:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D16E121855
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2019 16:46:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="T/cifKLn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D16E121855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59828 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hdHFL-0007w0-PV
	for qemu-devel@archiver.kernel.org; Tue, 18 Jun 2019 12:46:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36870)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <liran.alon@oracle.com>) id 1hdGLA-0003Hw-DM
 for qemu-devel@nongnu.org; Tue, 18 Jun 2019 11:48:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <liran.alon@oracle.com>) id 1hdGL8-0000v8-0I
 for qemu-devel@nongnu.org; Tue, 18 Jun 2019 11:48:07 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:39756)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <liran.alon@oracle.com>)
 id 1hdGL7-0000Kg-Ji
 for qemu-devel@nongnu.org; Tue, 18 Jun 2019 11:48:05 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
 by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5IFhstc181357;
 Tue, 18 Jun 2019 15:47:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2018-07-02; bh=eQ0nzYc0ULSE4m2y4q5Mz8s0ptpwHBMMjmAA5sE9wTU=;
 b=T/cifKLn+gaKLiMPSbleb/QR4ykPfNCEo5Qp2Jzyn83zQJgmLZMXNxtFIPIJyro9vRhM
 LIsz4r5fvmSwY/wNij1IViAOP48noN1JeistJsBBH54+HtgIMaXksSJ4AiC6SSEEL2yp
 78sJo8wh8bmiAGme/ZmGdhmCFQzV/4i/ooc3gbmjmxxR0sZyd9qJZnO681Qs1NCz8MEA
 wc07PVV7u6caNdjm3uFTtd1Uo+0EHxtWAAFS/NwAsEprotwtAD0H18rmUhKxRagvcHIe
 OeHoTKHdEnCfYpbVbu7qm0b4ADNp9hjcRZ4tDbtkPAEqR83hHOFZLY6H4N+Puj71377k Ag== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
 by userp2120.oracle.com with ESMTP id 2t4saqdb6m-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 18 Jun 2019 15:47:49 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
 by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5IFiQqd181563;
 Tue, 18 Jun 2019 15:45:49 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
 by aserp3020.oracle.com with ESMTP id 2t5mgc1dhm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 18 Jun 2019 15:45:48 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
 by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x5IFjmor019118;
 Tue, 18 Jun 2019 15:45:48 GMT
Received: from [192.168.14.112] (/109.67.217.108)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Tue, 18 Jun 2019 08:45:48 -0700
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 11.1 \(3445.4.7\))
From: Liran Alon <liran.alon@oracle.com>
In-Reply-To: <20190618090752.GD2850@work-vm>
Date: Tue, 18 Jun 2019 18:45:43 +0300
Content-Transfer-Encoding: quoted-printable
Message-Id: <350BC330-8877-4B93-A8B3-0C001AEDD879@oracle.com>
References: <20190617175658.135869-1-liran.alon@oracle.com>
 <20190617175658.135869-9-liran.alon@oracle.com>
 <20190618090752.GD2850@work-vm>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
X-Mailer: Apple Mail (2.3445.4.7)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9291
 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=944
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906180124
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9291
 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=998 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906180124
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 156.151.31.85
Subject: Re: [Qemu-devel] [QEMU PATCH v3 8/9] KVM: i386: Add support for
 KVM_CAP_EXCEPTION_PAYLOAD
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
Cc: ehabkost@redhat.com, kvm@vger.kernel.org, maran.wilson@oracle.com,
 mtosatti@redhat.com, qemu-devel@nongnu.org,
 Nikita Leshenko <nikita.leshchenko@oracle.com>, pbonzini@redhat.com,
 jmattson@google.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



> On 18 Jun 2019, at 12:07, Dr. David Alan Gilbert <dgilbert@redhat.com> =
wrote:
>=20
> * Liran Alon (liran.alon@oracle.com) wrote:
>> Kernel commit c4f55198c7c2 ("kvm: x86: Introduce =
KVM_CAP_EXCEPTION_PAYLOAD")
>> introduced a new KVM capability which allows userspace to correctly
>> distinguish between pending and injected exceptions.
>>=20
>> This distinguish is important in case of nested virtualization =
scenarios
>> because a L2 pending exception can still be intercepted by the L1 =
hypervisor
>> while a L2 injected exception cannot.
>>=20
>> Furthermore, when an exception is attempted to be injected by QEMU,
>> QEMU should specify the exception payload (CR2 in case of #PF or
>> DR6 in case of #DB) instead of having the payload already delivered =
in
>> the respective vCPU register. Because in case exception is injected =
to
>> L2 guest and is intercepted by L1 hypervisor, then payload needs to =
be
>> reported to L1 intercept (VMExit handler) while still preserving
>> respective vCPU register unchanged.
>>=20
>> This commit adds support for QEMU to properly utilise this new KVM
>> capability (KVM_CAP_EXCEPTION_PAYLOAD).
>=20
> Does this kvm capability become a requirement for the nested migration
> then? If so, is it wired into the blockers?
>=20
> Dave
>=20

That=E2=80=99s a very good point.
Yes this capability is required in order to correctly migrate VMs =
running nested hypervisors.
I agree that I should add a migration blocker for nested in case it =
isn=E2=80=99t present.
Nice catch.

-Liran



