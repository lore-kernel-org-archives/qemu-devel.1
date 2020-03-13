Return-Path: <SRS0=s522=46=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEA28C10DCE
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 22:43:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B95EA2074E
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 22:43:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="MgAxmhFi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B95EA2074E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38680 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCt1p-0006CX-08
	for qemu-devel@archiver.kernel.org; Fri, 13 Mar 2020 18:43:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50864)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <liran.alon@oracle.com>) id 1jCt0T-0005Dy-Vp
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 18:42:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <liran.alon@oracle.com>) id 1jCt0S-0007dr-U3
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 18:42:17 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:54052)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <liran.alon@oracle.com>)
 id 1jCt0S-0007bV-Jy
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 18:42:16 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
 by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02DMede5043740;
 Fri, 13 Mar 2020 22:42:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=gl0wYTlAohtKcl7lOK8JENg+gjTwIfIVl6n/iWSjt10=;
 b=MgAxmhFiFPfkXjGtrgsOOubYtEkHisCEvdN/F1bxvMX3VbkV3lwEJyTDxG4CoxETEN60
 d+6RNaOWUqCG9WklcTM87HeiJZDpnII28zVg1lyuJBoNOpvRgib5LozgD4lieKOf5krm
 selnXU1972hviknbseScSDoxG4Ano7SHBWL8ew+ovo/p4FVMrlHpyJ1TYGlNIfG+FEZV
 t1ZQSh+qFTv+giKBaAmSDbBXvibDJLvZosYiYAa/Ul9ijVOpCpATh3yVVpgYPiwW2WH8
 6bSLonyzwrnl4aejSHZFe09vUeIsqjnUpddRp5NkoWIsCwZA3mtSh4JffydiCAG+D52t lw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
 by aserp2120.oracle.com with ESMTP id 2yqtaex0vg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 13 Mar 2020 22:42:15 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
 by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02DMMOFv033191;
 Fri, 13 Mar 2020 22:42:15 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
 by aserp3030.oracle.com with ESMTP id 2yqtadyy7u-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 13 Mar 2020 22:42:15 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
 by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 02DMgDaW020185;
 Fri, 13 Mar 2020 22:42:14 GMT
Received: from [192.168.14.112] (/109.67.207.210)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Fri, 13 Mar 2020 15:42:13 -0700
Subject: Re: [PATCH v3 08/16] hw/i386/vmport: Define enum for all commands
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20200312165431.82118-1-liran.alon@oracle.com>
 <20200312165431.82118-9-liran.alon@oracle.com>
 <3dbe8a7f-73e3-691b-2e14-c287cafd9e7c@redhat.com>
 <d504b96e-5cfa-ce23-5e66-c2f48853b432@redhat.com>
From: Liran Alon <liran.alon@oracle.com>
Message-ID: <e24688df-ef0d-6119-be75-da60854a56d6@oracle.com>
Date: Sat, 14 Mar 2020 00:42:10 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:68.0)
 Gecko/20100101 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <d504b96e-5cfa-ce23-5e66-c2f48853b432@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9559
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 malwarescore=0
 phishscore=0 bulkscore=0 mlxlogscore=959 spamscore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003130099
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9559
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 impostorscore=0
 lowpriorityscore=0 bulkscore=0 priorityscore=1501 suspectscore=0
 mlxlogscore=999 mlxscore=0 adultscore=0 malwarescore=0 spamscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003130099
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by aserp2120.oracle.com id
 02DMede5043740
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
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
Cc: pbonzini@redhat.com, Nikita Leshenko <nikita.leshchenko@oracle.com>,
 rth@twiddle.net, ehabkost@redhat.com, mst@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 13/03/2020 22:05, Philippe Mathieu-Daud=C3=A9 wrote:
> On 3/13/20 8:59 PM, Philippe Mathieu-Daud=C3=A9 wrote:
>> On 3/12/20 5:54 PM, Liran Alon wrote:
>>> --- a/include/hw/i386/vmport.h
>>> +++ b/include/hw/i386/vmport.h
>>> @@ -4,12 +4,21 @@
>>> =C2=A0 #define TYPE_VMPORT "vmport"
>>> =C2=A0 typedef uint32_t (VMPortReadFunc)(void *opaque, uint32_t addre=
ss);
>>> +typedef enum {
>>> +=C2=A0=C2=A0=C2=A0 VMPORT_CMD_GETVERSION=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 =3D 10,
>
> Can we rename as VMPORT_CMD_GET_VERSION which is easier to read?
Sure. Will do on v4.
>
>>> +=C2=A0=C2=A0=C2=A0 VMPORT_CMD_GETRAMSIZE=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 =3D 20,
>
> Ditto _GET_RAM_SIZE?
Sure. Will do in v4.

-Liran


