Return-Path: <SRS0=5yua=6H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 560FFC54FCB
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 15:09:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2174F20857
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 15:09:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="R9KG+tw7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2174F20857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45244 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRdTz-0000Ft-B7
	for qemu-devel@archiver.kernel.org; Thu, 23 Apr 2020 11:09:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42036)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jag.raman@oracle.com>) id 1jRdSH-0006fI-41
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 11:07:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <jag.raman@oracle.com>) id 1jRdS4-0000bH-LM
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 11:07:56 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:57988)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jag.raman@oracle.com>)
 id 1jRdS4-0000au-5B
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 11:07:44 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
 by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03NF2kVF024083;
 Thu, 23 Apr 2020 15:07:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=qx0FICjMEBzVvbLvhMIZiHrVcME0HmWCXxWyCeFWI1o=;
 b=R9KG+tw7FbTV+Y3gZyu/06H/DDnSb3izPgb/LO8s1UOKeccibNrTi6Nqbu3n4dfB36iP
 BKHM4673NjAtz5zqg/RAFCA9NotIDc6Kz73X3pgujBRz6SQR5uSWu6MURcz5hZpan2C0
 CKvghH28K9YONVXfJtJuW9fG2G59tR7B0K8EdUh8PrpmeHv75ZVnJCqybMymcX+F19yS
 b36oD/a2mx3renU2UEoJZ/f2yqOP4onE3lnFK2kiQqZYF88D0adhc4k8tDvYzTDiiCRM
 n+SOajRbvL9nWM5LjLUYcyMxxxwkJPgEoKvX17JLffel9OmXBrjH0IHIO34dBkGOi3iM VQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
 by aserp2120.oracle.com with ESMTP id 30jvq4v43d-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 23 Apr 2020 15:07:23 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
 by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03NF1r9D150094;
 Thu, 23 Apr 2020 15:07:22 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
 by userp3020.oracle.com with ESMTP id 30k7qv9rk6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 23 Apr 2020 15:07:22 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
 by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 03NF7Kcl006942;
 Thu, 23 Apr 2020 15:07:20 GMT
Received: from [10.39.224.123] (/10.39.224.123)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Thu, 23 Apr 2020 08:07:19 -0700
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 11.5 \(3445.9.1\))
Subject: Re: [PATCH RESEND v6 06/36] monitor: destaticize HMP commands
From: Jag Raman <jag.raman@oracle.com>
In-Reply-To: <3cca22d6-349c-10e0-c0ff-9c75f32e56e2@redhat.com>
Date: Thu, 23 Apr 2020 11:07:50 -0400
Content-Transfer-Encoding: quoted-printable
Message-Id: <517D1E24-5BA3-4ADB-B1A2-5B083C9201A2@oracle.com>
References: <cover.1587614626.git.elena.ufimtseva@oracle.com>
 <3dc3603df5b83576c7ec65589f144d44419cee52.1587614626.git.elena.ufimtseva@oracle.com>
 <3cca22d6-349c-10e0-c0ff-9c75f32e56e2@redhat.com>
To: =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@redhat.com>
X-Mailer: Apple Mail (2.3445.9.1)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9600
 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 spamscore=0 mlxlogscore=999
 adultscore=0 suspectscore=0 bulkscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004230118
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9600
 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 lowpriorityscore=0 malwarescore=0
 mlxscore=0 adultscore=0 mlxlogscore=999 phishscore=0 impostorscore=0
 clxscore=1011 bulkscore=0 spamscore=0 priorityscore=1501 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004230118
Received-SPF: pass client-ip=141.146.126.78; envelope-from=jag.raman@oracle.com;
 helo=aserp2120.oracle.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/23 11:07:42
X-ACL-Warn: Detected OS   = Linux 3.x [generic] [fuzzy]
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
Cc: Elena Ufimtseva <elena.ufimtseva@oracle.com>, fam@euphon.net,
 swapnil.ingle@nutanix.com, john.g.johnson@oracle.com, qemu-devel@nongnu.org,
 kraxel@redhat.com, quintela@redhat.com, mst@redhat.com, armbru@redhat.com,
 kanth.ghatraju@oracle.com, felipe@nutanix.com, thuth@redhat.com,
 ehabkost@redhat.com, konrad.wilk@oracle.com, dgilbert@redhat.com,
 liran.alon@oracle.com, stefanha@redhat.com, pbonzini@redhat.com,
 rth@twiddle.net, kwolf@redhat.com, berrange@redhat.com, mreitz@redhat.com,
 ross.lagerwall@citrix.com, marcandre.lureau@gmail.com,
 thanos.makatos@nutanix.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



> On Apr 23, 2020, at 10:14 AM, Philippe Mathieu-Daud=C3=A9 =
<philmd@redhat.com> wrote:
>=20
> Why 'destaticize HMP commands=E2=80=99?

Hi Philippe,

Both QEMU & the remote process links the QMP code. QEMU uses
all of the QMP commands, whereas, the remote process only uses a
subset of this. Therefore, the =E2=80=98static=E2=80=99 functions which =
don=E2=80=99t have a
reference cause build errors (like defined but not used). Therefore,
we decided to destaticize the ones that are causing the build failure.

On a different note, Dave had previously suggested destacizing only the
HMP functions used by the remote process. However, we found out that =
this is
not possible because without all these functions, the build error still =
reproduces.
We did confirm that all the functions we have destaticized are necessary =
to
help with build of the remote process.

Thank you very much!
--
Jag

>=20
> On 4/23/20 6:13 AM, elena.ufimtseva@oracle.com wrote:
>> From: Jagannathan Raman <jag.raman@oracle.com>
>> Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
>> Signed-off-by: John G Johnson <john.g.johnson@oracle.com>
>> Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
>> Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
>> ---
>>  hmp-commands.hx            |  4 +-
>>  monitor/misc.c             | 76 =
+++++++++++++++++++-------------------
>>  monitor/monitor-internal.h | 38 +++++++++++++++++++
>>  3 files changed, 78 insertions(+), 40 deletions(-)
>=20


