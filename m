Return-Path: <SRS0=s522=46=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C045BC10DCE
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 22:40:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 86D6E2074E
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 22:40:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="rEu48WSc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86D6E2074E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38640 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCsz6-0004Q7-P3
	for qemu-devel@archiver.kernel.org; Fri, 13 Mar 2020 18:40:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49655)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <liran.alon@oracle.com>) id 1jCsyT-0003st-0o
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 18:40:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <liran.alon@oracle.com>) id 1jCsyQ-0001Pp-R0
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 18:40:12 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:52188)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <liran.alon@oracle.com>)
 id 1jCsyQ-0001Na-Ip
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 18:40:10 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
 by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02DMMnee106661;
 Fri, 13 Mar 2020 22:40:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=AG8f2Y6rntReMsBodJIi4bcr0DC/YYvQedA/ZxDGNdk=;
 b=rEu48WScUL/4tmhsOes9snSk1ii30QJwzh+pWTlnH4SZAbtDnMr6ZfNbjIs0MsY5nvnM
 dXr+J34CzfwkD3HHu6yG5OeYIBktZR9jNBjnuVrj2jhfMsh6FfhwJIZeonNBPie20rKo
 PeuE4ehe1P8m9ZnOAet+2VGZsfVuGVNK7NjYNomNpuZE6ZsOhlzSEM7y/086HpafrdVW
 zPF9ihsO9EmtfeeltUPBE6VBDGlT5beRerZTCj7dK8leQR30wWWQCS65kY+uG8BXxGbL
 xpPO4GFA04cQosuUT4JzZyRDygktuCXl1kivIlH+9qqiQPSCpAQNrn2IWNnD4dol+3SC kA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
 by aserp2120.oracle.com with ESMTP id 2yqtaex0pp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 13 Mar 2020 22:40:09 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
 by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02DMNEKa165057;
 Fri, 13 Mar 2020 22:40:08 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
 by userp3030.oracle.com with ESMTP id 2yqtadqwkh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 13 Mar 2020 22:40:08 +0000
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
 by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 02DMe7uL021902;
 Fri, 13 Mar 2020 22:40:07 GMT
Received: from [192.168.14.112] (/109.67.207.210)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Fri, 13 Mar 2020 15:40:07 -0700
Subject: Re: [PATCH v3 08/16] hw/i386/vmport: Define enum for all commands
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20200312165431.82118-1-liran.alon@oracle.com>
 <20200312165431.82118-9-liran.alon@oracle.com>
 <3dbe8a7f-73e3-691b-2e14-c287cafd9e7c@redhat.com>
From: Liran Alon <liran.alon@oracle.com>
Message-ID: <4c87356c-5210-3d7f-f355-f59de97a2ba4@oracle.com>
Date: Sat, 14 Mar 2020 00:40:03 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:68.0)
 Gecko/20100101 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <3dbe8a7f-73e3-691b-2e14-c287cafd9e7c@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9559
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 suspectscore=0
 malwarescore=0 bulkscore=0 adultscore=0 mlxscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
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
 02DMMnee106661
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


On 13/03/2020 21:59, Philippe Mathieu-Daud=C3=A9 wrote:
> On 3/12/20 5:54 PM, Liran Alon wrote:
>> No functional change.
>>
>> Defining an enum for all VMPort commands have the following advantages=
:
>> * It gets rid of the error-prone requirement to update VMPORT_ENTRIES
>> when new VMPort commands are added to QEMU.
>> * It makes it clear to know by looking at one place at the source, wha=
t
>> are all the VMPort commands supported by QEMU.
>>
>> Reviewed-by: Nikita Leshenko <nikita.leshchenko@oracle.com>
>> Signed-off-by: Liran Alon <liran.alon@oracle.com>
>> ---
>> =C2=A0 hw/i386/vmmouse.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 1=
8 ++++++------------
>> =C2=A0 hw/i386/vmport.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 | 11 ++---------
>> =C2=A0 include/hw/i386/vmport.h | 11 ++++++++++-
>
> Please setup scripts/git.orderfile to ease reviews.
>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>
Oh ok. Will do for next submissions.

Thanks,
-Liran


