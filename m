Return-Path: <SRS0=s522=46=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5363C10DCE
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 14:24:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 720C9206FA
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 14:24:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="HuOo5SpX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 720C9206FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59656 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jClEN-0004mo-JK
	for qemu-devel@archiver.kernel.org; Fri, 13 Mar 2020 10:24:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46003)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <liran.alon@oracle.com>) id 1jClDc-0003vH-KJ
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 10:23:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <liran.alon@oracle.com>) id 1jClDa-0007YI-7q
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 10:23:20 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:47880)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <liran.alon@oracle.com>)
 id 1jClDZ-0007SR-Un
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 10:23:18 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
 by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02DEJXu7048241;
 Fri, 13 Mar 2020 14:23:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=wYOQNEkO65w4tMQnCURdZSNMWZnjFYSVG5V6BBcmE+0=;
 b=HuOo5SpXpmxF76P3G19rZOCorjS4WMkeScRdGFHGzXZrvDopAp28bDtKHRBFmF7h5htc
 aengtQT3GP3jZD94KJt6GAHGg25MaRNmdadTF7O1L+K16ads5gORn96SZGpHRM+HiPKv
 6F6NFlH/YWUoiiWlUx998lamLTv84OIY57RJSihJ5Sk3bHf9M+jAF7yoKPA51BZTKqgo
 wkCvBTP+Le3VXePdZr0pV9PPfC+dPawFaTkQIaTW9I0lsDh8Ab2CqQH8AU74LcQk7Z9Z
 DMVRCEn+MY9qlOsG3s5Ble9ei4TThd9OVF7hOzSoMNP64ihCN/EJArDOZTSCqTLYwchk wQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
 by userp2120.oracle.com with ESMTP id 2yqtavm3am-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 13 Mar 2020 14:23:15 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
 by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02DEJR2B165579;
 Fri, 13 Mar 2020 14:23:14 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
 by aserp3020.oracle.com with ESMTP id 2yqtaw0mmp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 13 Mar 2020 14:23:14 +0000
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
 by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 02DENC61021485;
 Fri, 13 Mar 2020 14:23:13 GMT
Received: from [192.168.14.112] (/109.67.207.210)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Fri, 13 Mar 2020 07:23:12 -0700
Subject: Re: [PATCH] acpi: Add Windows ACPI Emulated Device Table (WAET)
To: Igor Mammedov <imammedo@redhat.com>
References: <20200311170826.79419-1-liran.alon@oracle.com>
 <20200312172745.1b7b2222@redhat.com>
 <8b3f3166-cc60-eae2-c20d-ad4a593c3e30@oracle.com>
 <20200313110516.6f4ca2b2@redhat.com>
From: Liran Alon <liran.alon@oracle.com>
Message-ID: <6430a6e3-b4ba-07e0-7f12-057216066946@oracle.com>
Date: Fri, 13 Mar 2020 16:23:07 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:68.0)
 Gecko/20100101 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200313110516.6f4ca2b2@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9558
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 bulkscore=0 phishscore=0
 suspectscore=0 mlxscore=0 spamscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2003130075
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9558
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 suspectscore=0
 phishscore=0 priorityscore=1501 clxscore=1015 mlxscore=0 adultscore=0
 spamscore=0 bulkscore=0 mlxlogscore=999 lowpriorityscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2003130075
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
Cc: ehabkost@redhat.com, mst@redhat.com, qemu-devel@nongnu.org,
 Elad Gabay <elad.gabay@oracle.com>, pbonzini@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 13/03/2020 12:05, Igor Mammedov wrote:
> On Thu, 12 Mar 2020 19:28:31 +0200
> Liran Alon <liran.alon@oracle.com> wrote:
>
>> On 12/03/2020 18:27, Igor Mammedov wrote:
>>> On Wed, 11 Mar 2020 19:08:26 +0200
>>> Liran Alon <liran.alon@oracle.com> wrote:
>>>> +
> [...]
>>> we typically do not version ACPI table changes (there might be exceptions
>>> but it should be a justified one).
>>> ACPI tables are considered to be a part of firmware (even though they are
>>> generated by QEMU) so on QEMU upgrade user gets a new firmware along with
>>> new ACPI tables.
>> Hmm... I would have expected as a QEMU user that upgrading QEMU may
>> update my firmware exposed table (Such as ACPI),
>> but only if I don't specify I wish to run on a specific machine-type. In
>> that case, I would've expect to be exposed with exact same firmware
>> information.
> That would be ideal but it's not the case with current QEMU, even with
> specific machine type user will get new firmware when it's started with
> upgraded QEMU which usually ships with new firmware.
>
> mgmt layer theoretically can take care of maintaining different firmwares
> on host and explicitly specify which should be used (though I'm not aware
> of any doing it)
>
> another issue with adding flags consistently for every acpi related
> change would complicate code quite a bit making it hard to read/maintain,
> hence flags are used only when we have to introduce them (i.e when it
> would break guest).
>
>> I understood that this was one of the main reasons why ACPI/SMBIOS
>> generation was moved from SeaBIOS to QEMU.
> If I recall correctly, Michael moved table to QEMU so we won't have to
> extend ABI for constantly growing ACPI interface and then maintain it
> forever, which indeed would require using compat machinery for every
> knob (which is unsustainable).
>
> [...]
>
Ok. Thanks very much for expressing your opinion.
So I would just remove flag and submit v2 without it.

-Liran




