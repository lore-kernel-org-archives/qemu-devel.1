Return-Path: <SRS0=s522=46=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D285C10DCE
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 22:45:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA25C2074D
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 22:45:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Vo+D4mh1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA25C2074D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38718 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCt3y-0007X5-6c
	for qemu-devel@archiver.kernel.org; Fri, 13 Mar 2020 18:45:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53205)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <liran.alon@oracle.com>) id 1jCt3B-0006ki-4w
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 18:45:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <liran.alon@oracle.com>) id 1jCt3A-0002qG-58
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 18:45:05 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:55596)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <liran.alon@oracle.com>)
 id 1jCt39-0002o1-Sa
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 18:45:04 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
 by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02DMcfvZ048577;
 Fri, 13 Mar 2020 22:45:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=rttZv9D+yyQD9THzqEsPvx4DrMoETrq+GBLY7aTP1xQ=;
 b=Vo+D4mh1Je6uTHtao5A53PvnOuCvTHsPzbeL7UoNBLqnpNVYgcZPXoAWBtjcdgIrW0Uf
 SCUXRwt+3RpO1RGbLPW716v6V4bjZdSYb/n0lsHQ0WkFJURvgzUpExrGCQbiRoY8LPgl
 fokD/l3QL29hHiQ1dlUOTv7sxh2caWz9fY6DDMTl5053hE7dH3LNHY6PQPcAmIu/euNp
 u2D85mO0NALhP67jAnqASNlaeGPYGPTIeU46vQMRP9TupqGnFDhgdOxPUaBgAQFGZp92
 t3fwKPYSzx1qMpPw4T/3USgizbVgEc3gMEJ+JnKV3X+68Y5S5zj39j8hCFjKkreccwnM JQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
 by userp2130.oracle.com with ESMTP id 2yrf9g0u96-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 13 Mar 2020 22:45:01 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
 by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02DMMgtN033524;
 Fri, 13 Mar 2020 22:45:01 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
 by aserp3030.oracle.com with ESMTP id 2yqtae02p9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 13 Mar 2020 22:45:00 +0000
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
 by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 02DMixYd023921;
 Fri, 13 Mar 2020 22:44:59 GMT
Received: from [192.168.14.112] (/109.67.207.210)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Fri, 13 Mar 2020 15:44:59 -0700
Subject: Re: [PATCH v3 15/16] hw/i386/vmport: Add support for CMD_GETHZ
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20200312165431.82118-1-liran.alon@oracle.com>
 <20200312165431.82118-16-liran.alon@oracle.com>
 <97784452-8270-e0ab-1164-d3a9fe567006@redhat.com>
From: Liran Alon <liran.alon@oracle.com>
Message-ID: <5a1a347a-102d-2c1e-bb27-e5b05408eb4a@oracle.com>
Date: Sat, 14 Mar 2020 00:44:55 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:68.0)
 Gecko/20100101 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <97784452-8270-e0ab-1164-d3a9fe567006@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9559
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 malwarescore=0
 phishscore=0 bulkscore=0 mlxlogscore=999 spamscore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003130099
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9559
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 lowpriorityscore=0
 priorityscore=1501 mlxscore=0 phishscore=0 mlxlogscore=999 suspectscore=0
 impostorscore=0 spamscore=0 malwarescore=0 adultscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2003130099
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by userp2130.oracle.com id
 02DMcfvZ048577
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
Cc: pbonzini@redhat.com, Nikita Leshenko <nikita.leshchenko@oracle.com>,
 rth@twiddle.net, ehabkost@redhat.com, mst@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 13/03/2020 22:07, Philippe Mathieu-Daud=C3=A9 wrote:
> On 3/12/20 5:54 PM, Liran Alon wrote:
>>
>> diff --git a/include/hw/i386/vmport.h b/include/hw/i386/vmport.h
>> index 34cc050b1ffa..aee809521aa0 100644
>> --- a/include/hw/i386/vmport.h
>> +++ b/include/hw/i386/vmport.h
>> @@ -12,6 +12,7 @@ typedef enum {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 VMPORT_CMD_VMMOUSE_DATA=C2=A0=C2=A0=C2=A0=
=C2=A0 =3D 39,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 VMPORT_CMD_VMMOUSE_STATUS=C2=A0=C2=A0 =3D=
 40,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 VMPORT_CMD_VMMOUSE_COMMAND=C2=A0 =3D 41=
,
>> +=C2=A0=C2=A0=C2=A0 VMPORT_CMD_GETHZ=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =3D 45,
>
> Can you rename to something easier to read, such _GET_FREQS_HZ or nicer=
?
>
I actually prefer to stick with names similar to open-vm-tools. i.e.=20
Similar to the definitions in lib/include/backdoor_def.h.
This helps correlates a command in QEMU code to guest code (in=20
open-vm-tools) that interacts with it.
I can rename to just VMPORT_CMD_GET_HZ (Similar to what you suggested=20
for previous commands).
But I don't have a strong opinion on this. If you still think=20
_GET_FREQ_HZ is preferred, I will rename to that.

-Liran


