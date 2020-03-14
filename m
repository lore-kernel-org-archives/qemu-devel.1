Return-Path: <SRS0=i8Yf=47=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FBE1C0044D
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Mar 2020 19:09:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 21A2020789
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Mar 2020 19:09:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="agvoetRq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21A2020789
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47577 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDC9k-0002rE-CQ
	for qemu-devel@archiver.kernel.org; Sat, 14 Mar 2020 15:09:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55822)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <liran.alon@oracle.com>) id 1jDC97-0002LW-BR
 for qemu-devel@nongnu.org; Sat, 14 Mar 2020 15:08:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <liran.alon@oracle.com>) id 1jDC96-0002Pv-1E
 for qemu-devel@nongnu.org; Sat, 14 Mar 2020 15:08:29 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:58304)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <liran.alon@oracle.com>)
 id 1jDC95-0002Nw-BP
 for qemu-devel@nongnu.org; Sat, 14 Mar 2020 15:08:27 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
 by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02EIwdka158374;
 Sat, 14 Mar 2020 19:08:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=AXD9+4ZHnk9tUvOJHn19tVQgrYCXcoMqDy0JPizqG+k=;
 b=agvoetRqd421XfO7eaODL8UKFKY18DfrrrYkkJIqK+2uBepa5U/opAsTdsBRXyLLX6gZ
 +KbfJ4diRY/5Iqp/Yv2lw2p5FAAZz8W7Qs+9PC40chIwcjDZ5cqzvA20UleUEq6ORX3l
 fuhsQBKYC5BdJRPBV7FUavEqW0IG2Zg72cK10fSY3xzHFa2PZXJnCWDeg0L+KrkklHo0
 NaaqTMGnQa1JcRHlY7jZsAy85uaLiLJRFluqkrnppR2xcqISNijcZ/eonjaXvXe1yo0x
 S04U/Mb9QHa0vTyjT9A9y+bp410VbHhcKRh+ecpP32F/Op5kpY9xDfMqQmuZ4PyW+D8U qg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
 by userp2130.oracle.com with ESMTP id 2yrppqsh61-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sat, 14 Mar 2020 19:08:25 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
 by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02EJ8PHY149946;
 Sat, 14 Mar 2020 19:08:25 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
 by aserp3030.oracle.com with ESMTP id 2yrna9wgt8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sat, 14 Mar 2020 19:08:24 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
 by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 02EJ8Mb3006613;
 Sat, 14 Mar 2020 19:08:23 GMT
Received: from [192.168.14.112] (/79.179.237.174)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Sat, 14 Mar 2020 12:08:22 -0700
Subject: Re: [PATCH v3 07/16] hw/i386/vmport: Introduce vmport.h
To: "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
References: <20200312165431.82118-1-liran.alon@oracle.com>
 <20200312165431.82118-8-liran.alon@oracle.com>
 <13b98a16-6465-e1c9-5f52-0f338c60fbd5@redhat.com>
 <d81dc7a5-2b20-1792-c1df-ecdb8a964fa7@oracle.com>
 <2f168ddb-34e3-a286-080c-261dcb8ee6bb@redhat.com>
 <20200314142319-mutt-send-email-mst@kernel.org>
From: Liran Alon <liran.alon@oracle.com>
Message-ID: <af965793-13a3-1b52-b518-e16cf75526e3@oracle.com>
Date: Sat, 14 Mar 2020 21:08:18 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:68.0)
 Gecko/20100101 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200314142319-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9560
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 suspectscore=0
 mlxlogscore=999 mlxscore=0 malwarescore=0 spamscore=0 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003140103
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9560
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 bulkscore=0
 suspectscore=0 lowpriorityscore=0 phishscore=0 adultscore=0 clxscore=1015
 impostorscore=0 priorityscore=1501 spamscore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2003140102
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by userp2130.oracle.com id
 02EIwdka158374
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
Cc: pbonzini@redhat.com, rth@twiddle.net, qemu-devel@nongnu.org,
 ehabkost@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 14/03/2020 20:25, Michael S. Tsirkin wrote:
> On Sat, Mar 14, 2020 at 09:31:31AM +0100, Philippe Mathieu-Daud=C3=A9 w=
rote:
>> On 3/13/20 11:38 PM, Liran Alon wrote:
>>> On 13/03/2020 21:57, Philippe Mathieu-Daud=C3=A9 wrote:
>>>> On 3/12/20 5:54 PM, Liran Alon wrote:
>>>>> No functional change. This is mere refactoring.
>>>>>
>>>>> Suggested-by: Michael S. Tsirkin <mst@redhat.com>
>>>>> Signed-off-by: Liran Alon <liran.alon@oracle.com>
>>>>> ---
>>>>>  =C2=A0 hw/i386/pc.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 1 +
>>>>>  =C2=A0 hw/i386/vmmouse.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 |=C2=A0 1 +
>>>>>  =C2=A0 hw/i386/vmport.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 |=C2=A0 1 +
>>>>>  =C2=A0 include/hw/i386/pc.h=C2=A0=C2=A0=C2=A0=C2=A0 | 13 ---------=
----
>>>>>  =C2=A0 include/hw/i386/vmport.h | 16 ++++++++++++++++
>>>> What about moving it to hw/i386/vmport.h (no under include/)?
>>>>
>>>> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>>>>
>>>>
>>> Can you explain the logic that separates between hw/i386/*.h to
>>> include/hw/i386/*.h?
>> Headers in the include/hw/ namespace can be consumed by all machine ta=
rgets.
>> If this is a target-specific device, having it local to the target
>> (hw/i386/) protect generic code (and other targets) of using it. This =
helps
>> detecting wrong dependencies between components.
> I think it's true. However when headers were moved to include we
> weren't always able to do this correctly. So some i386
> specific headers are under include.
>
OK. So if I understand correctly, you also support moving this header to=20
hw/i386/ instead of include/hw/i386/.
So I will do so in v4.

Thanks,
-Liran



