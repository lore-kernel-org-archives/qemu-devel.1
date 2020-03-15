Return-Path: <SRS0=WIOf=5A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F6AAC0044D
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Mar 2020 00:13:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1806020848
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Mar 2020 00:13:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="DjOBiWdu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1806020848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49616 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDGud-0008JT-8F
	for qemu-devel@archiver.kernel.org; Sat, 14 Mar 2020 20:13:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52905)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <liran.alon@oracle.com>) id 1jDGtk-0007ux-7z
 for qemu-devel@nongnu.org; Sat, 14 Mar 2020 20:12:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <liran.alon@oracle.com>) id 1jDGti-0006Kb-Lf
 for qemu-devel@nongnu.org; Sat, 14 Mar 2020 20:12:55 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:33530)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <liran.alon@oracle.com>)
 id 1jDGti-0006DV-Bv
 for qemu-devel@nongnu.org; Sat, 14 Mar 2020 20:12:54 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
 by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02F09qY6032180;
 Sun, 15 Mar 2020 00:12:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=S6jEfHrVvbO5I6HY/l0fxoISiIgNbxknc9y32dqtf1s=;
 b=DjOBiWduxH+4rCBEfQUu81nyJ5xyiN152zS9TvfWgKMwTdPx6Rwaj8vXc4UNBlMSekjB
 cUVAsb64R4XDrkZsxFRpNGFcMgyMQnkr9lWRfkhplE0dwT+qr04aItwRHQ5tc9iBlJgx
 iRHq2T16lOTFG2n8cl8n3FU1Y4U3ZArrq5nJAKkwV2F9K805fNaOmvWPXG/Y7OiOm9sl
 Ih1OPBhMyeYiJx+buC8lnBI9bu2pQrJ9X+BPVbiUECyyDb1DtI9Vw1slFg4xE6m+ULp8
 LA7pMccsGidi+gxUkOLWzKnDQxZTnqrJJFALXcn13XAq7anhyhc6CtWnvDjSyWZrSjQd vw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
 by userp2120.oracle.com with ESMTP id 2yrqwmss6q-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sun, 15 Mar 2020 00:12:47 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
 by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02F02HsK117547;
 Sun, 15 Mar 2020 00:10:47 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
 by userp3030.oracle.com with ESMTP id 2ys8r9a9sj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sun, 15 Mar 2020 00:10:47 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
 by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 02F0AkXU020552;
 Sun, 15 Mar 2020 00:10:46 GMT
Received: from [192.168.14.112] (/79.179.237.174)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Sat, 14 Mar 2020 17:10:45 -0700
Subject: Re: [PATCH v3 15/16] hw/i386/vmport: Add support for CMD_GETHZ
To: "Michael S. Tsirkin" <mst@redhat.com>
References: <20200312165431.82118-1-liran.alon@oracle.com>
 <20200312165431.82118-16-liran.alon@oracle.com>
 <97784452-8270-e0ab-1164-d3a9fe567006@redhat.com>
 <5a1a347a-102d-2c1e-bb27-e5b05408eb4a@oracle.com>
 <20200314174536-mutt-send-email-mst@kernel.org>
From: Liran Alon <liran.alon@oracle.com>
Message-ID: <3bbb8216-41f5-c9dd-1c29-1b9409305417@oracle.com>
Date: Sun, 15 Mar 2020 02:10:41 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:68.0)
 Gecko/20100101 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200314174536-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9560
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 bulkscore=0 phishscore=0
 malwarescore=0 mlxscore=0 mlxlogscore=999 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2003140131
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9560
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 lowpriorityscore=0 mlxlogscore=999
 mlxscore=0 bulkscore=0 phishscore=0 spamscore=0 suspectscore=0
 malwarescore=0 priorityscore=1501 clxscore=1015 adultscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003140131
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by userp2120.oracle.com id
 02F09qY6032180
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
X-Received-From: 156.151.31.85
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
Cc: ehabkost@redhat.com, qemu-devel@nongnu.org,
 Nikita Leshenko <nikita.leshchenko@oracle.com>, pbonzini@redhat.com,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 14/03/2020 23:52, Michael S. Tsirkin wrote:
> On Sat, Mar 14, 2020 at 12:44:55AM +0200, Liran Alon wrote:
>> On 13/03/2020 22:07, Philippe Mathieu-Daud=C3=A9 wrote:
>>> On 3/12/20 5:54 PM, Liran Alon wrote:
>>>> diff --git a/include/hw/i386/vmport.h b/include/hw/i386/vmport.h
>>>> index 34cc050b1ffa..aee809521aa0 100644
>>>> --- a/include/hw/i386/vmport.h
>>>> +++ b/include/hw/i386/vmport.h
>>>> @@ -12,6 +12,7 @@ typedef enum {
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 VMPORT_CMD_VMMOUSE_DATA=C2=A0=C2=A0=C2=
=A0=C2=A0 =3D 39,
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 VMPORT_CMD_VMMOUSE_STATUS=C2=A0=C2=A0=
 =3D 40,
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 VMPORT_CMD_VMMOUSE_COMMAND=C2=A0 =3D=
 41,
>>>> +=C2=A0=C2=A0=C2=A0 VMPORT_CMD_GETHZ=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =3D 45,
>>> Can you rename to something easier to read, such _GET_FREQS_HZ or nic=
er?
>>>
>> I actually prefer to stick with names similar to open-vm-tools. i.e. S=
imilar
>> to the definitions in lib/include/backdoor_def.h.
> Please, do not copy without attribution. It really applies everywhere,
> I commented on another enum and you fixed it there, but please
> go over your code and try to generally apply the same rules.
This is not a copy of the enum as the other case you replied on.
It's just names "inspired" or "similar" to original names. They are not=20
even the same.
>
>> This helps correlates a command in QEMU code to guest code (in
>> open-vm-tools) that interacts with it.
>> I can rename to just VMPORT_CMD_GET_HZ (Similar to what you suggested =
for
>> previous commands).
>> But I don't have a strong opinion on this. If you still think _GET_FRE=
Q_HZ
>> is preferred, I will rename to that.
>>
>> -Liran
>
> Generally I don't think a hard to read code somewhere is a good reason
> to have hard to read code in QEMU, especially since it tends to
> proliferate.  It seems unlikely that VMPORT_CMD_GETHZ appears verbatim
> anywhere, and applying transformation rules is just too tricky. The bes=
t
> way to map host code to guest code in light of coding style differences
> etc is using comments. You did it in case of the type values, it
> applies equally here.
>
Honestly, even though I used slightly different names than original=20
open-vm-tools code, I think it's quite trivial to coorelate.
Both by similar name (not same), by value and by function. That's why I=20
don't have a strong opinion about the name.
I think VMPORT_CMD_GET_HZ is sufficient, but honestly I would name it=20
however you want. I really don't care.

I don't think any special comment is necessary here for correlation. But=20
I don't mind putting above enum a general comment such as:
/* See open-vm-tools lib/include/backdoor_def.h to match these to guest=20
commands */

-Liran



