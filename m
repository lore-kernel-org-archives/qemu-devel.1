Return-Path: <SRS0=OEAU=5Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9694AC2D0EA
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2020 09:30:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 61BB6206F5
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2020 09:30:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="pOfTGM6r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61BB6206F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33150 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jM72R-00070O-K6
	for qemu-devel@archiver.kernel.org; Wed, 08 Apr 2020 05:30:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39111)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <joao.m.martins@oracle.com>) id 1jM70q-0006Cr-PJ
 for qemu-devel@nongnu.org; Wed, 08 Apr 2020 05:28:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <joao.m.martins@oracle.com>) id 1jM70n-0004cA-57
 for qemu-devel@nongnu.org; Wed, 08 Apr 2020 05:28:47 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:51308)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <joao.m.martins@oracle.com>)
 id 1jM70m-0004bD-SM
 for qemu-devel@nongnu.org; Wed, 08 Apr 2020 05:28:45 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
 by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0389Rlg4038037;
 Wed, 8 Apr 2020 09:28:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=kJjUjwqK4T/05E0rHBgx6sDy6vbuUKKQ/Oe5tFRP9ac=;
 b=pOfTGM6rv1MACsgjj4YRVobw88duzNGgi0dEVW5EC3izqZUPL//sJV9tKCnHuI+YUU5a
 WTSa0X8KXXwmAlsrxxrdQTzjV6jGf2RyuwwRd6RXKSiOxou2uq4OOscow8ZTvn43qlVv
 nxZtxSLrNcsZdHmXJf8yWx1OCoHIUa3WIoae1Y9ZSXcv8fZE+wjL3guYM95sZ4b9hI/D
 FMmeJH+eFf+r46jJB+IfCL3lfjtijxcgIFGuy5OUeEJiw/z96CZd1omUpIML8JcxNA95
 G17Q4BO0dEUAYGi6NEcoCnpK10PV8+pIfCDdfqg4KL5zMhmoN+s+ofxg0GOIajYAQr3j jw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
 by aserp2120.oracle.com with ESMTP id 3091m0t932-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 08 Apr 2020 09:28:41 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
 by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0389Qhw8119029;
 Wed, 8 Apr 2020 09:28:41 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
 by aserp3030.oracle.com with ESMTP id 309ag1dhsv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 08 Apr 2020 09:28:40 +0000
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
 by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0389Sdmc017865;
 Wed, 8 Apr 2020 09:28:39 GMT
Received: from [10.175.198.250] (/10.175.198.250)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Wed, 08 Apr 2020 02:28:39 -0700
Subject: Re: [PATCH] exec: fetch the alignment of Linux devdax pmem character
 device nodes
To: "Liu, Jingqi" <jingqi.liu@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Dan Williams <dan.j.williams@intel.com>
References: <20200401031314.11592-1-jingqi.liu@intel.com>
 <c906a3ae-c9d2-5802-5988-3c1d0302109b@oracle.com>
 <b15709c2-bea7-2717-6833-ac4616b88660@redhat.com>
 <7de3eccb-f0b4-a858-2fc4-addfc7b198aa@oracle.com>
 <6b809ac5-1251-c80e-bbf6-82aa47333c1b@intel.com>
From: Joao Martins <joao.m.martins@oracle.com>
Message-ID: <9a001cb3-a81c-2c42-b957-5b841686672e@oracle.com>
Date: Wed, 8 Apr 2020 10:28:35 +0100
MIME-Version: 1.0
In-Reply-To: <6b809ac5-1251-c80e-bbf6-82aa47333c1b@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9584
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 spamscore=0 malwarescore=0
 phishscore=0 mlxscore=0 bulkscore=0 mlxlogscore=999 suspectscore=1
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004080078
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9584
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 mlxlogscore=999 mlxscore=0
 priorityscore=1501 phishscore=0 suspectscore=1 bulkscore=0
 lowpriorityscore=0 impostorscore=0 malwarescore=0 clxscore=1015
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004080078
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by aserp2120.oracle.com id
 0389Rlg4038037
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
Cc: qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/8/20 2:16 AM, Liu, Jingqi wrote:
> On 4/7/2020 11:51 PM, Joao Martins wrote:
>> On 4/7/20 3:31 PM, Paolo Bonzini wrote:
>>> On 07/04/20 12:59, Joao Martins wrote:
>>>> Perhaps, you meant instead:
>>>>
>>>> 	/sys/dev/char/%d:%d/align
>>>>
>>>>   ?
>>>>
> Hi Joao,
>=20
> In my machine with real NVDIMM, the devdax device is as follows:
>=20
> $ ll /dev/dax0.0
> crw------- 1 root root 250, 6 3=E6=9C=88=C2=A0 25 15:16 /dev/dax0.0
>=20
> $ ls /sys/dev/char/250\:6/align
> ls: cannot access '/sys/dev/char/250:6/align': No such file or director=
y
>=20
> $ ls /sys/dev/char/250\:6/device/align
>=20
> /sys/dev/char/250:6/device/align
>=20
> So:
> The file of "/sys/dev/char/%d:%d/align" does not exist.
> It should be "/sys/dev/char/%d:%d/device/align".
>=20
The 'align' (without the ../) was my mistake as I was testing with other =
wip
patches.

Albeit, still retain my comment to 'device/align' as it is relying on an
deprecated path, so perhaps we should look other alternatives.

I had the deprecated dax class disabled (DEV_DAX_PMEM_COMPAT=3Dn), and 'd=
evice'
does not exist on that cases.



> Anyone has a real NVDIMM can help double check. Thanks.
>=20
> Hi Dan,
>=20
> You may have a real NVDIMM, in what directory is the 'align' file ?
>=20
> Thanks,
>=20
> Jingqi
>=20
>>> So it works with that change?
>> Yeah.
>>
>> 	Joao

