Return-Path: <SRS0=WIOf=5A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42080C10DCE
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Mar 2020 12:00:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0353320674
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Mar 2020 12:00:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="kULeeeGM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0353320674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53206 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDRwB-0001w6-1e
	for qemu-devel@archiver.kernel.org; Sun, 15 Mar 2020 08:00:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60091)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <liran.alon@oracle.com>) id 1jDRsv-0000tX-2P
 for qemu-devel@nongnu.org; Sun, 15 Mar 2020 07:56:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <liran.alon@oracle.com>) id 1jDRss-0008Fr-6Q
 for qemu-devel@nongnu.org; Sun, 15 Mar 2020 07:56:48 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:34046)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <liran.alon@oracle.com>)
 id 1jDRsp-0008Bo-Ta
 for qemu-devel@nongnu.org; Sun, 15 Mar 2020 07:56:44 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
 by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02FBhhD0027821;
 Sun, 15 Mar 2020 11:56:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=eW/xyx+b4VS7gIZes2it8lsWRaf1K65L/jtnKm81Eoc=;
 b=kULeeeGM1I7qN6iXW9M0PivWETyt4/xFukEWhVgxMNuhO20+uPxlWOgr35rdLWZt1FFv
 u1kopCVxQFbuoX3vfb7uDxecQhwYKdGaizoQFoNkdxr5z3KbYHDv9qNOkFWKFv7LET8c
 WroYwRcRJaXNpnvmCBsYpb76iKhhw38+daPtXIBsEY50c30jGwLDkr6NOojPaSWtiYuN
 zvL5xTM85JlIprrbbYscdRZjKWTEvAp6DSwF7KOUm13YzO2mwX2Lkl+rOSi/eDNzXUc8
 p1X0/FSlUzVs4xsqiPWvpwA7d1HVIHU6o6CrpdJDUSJ8zZmHbocq2JkZKKMjhBVYA9ld Yw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
 by userp2130.oracle.com with ESMTP id 2yrppqu712-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sun, 15 Mar 2020 11:56:39 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
 by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02FBoQAO164171;
 Sun, 15 Mar 2020 11:56:39 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
 by userp3020.oracle.com with ESMTP id 2ys8ytjdkp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sun, 15 Mar 2020 11:56:39 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
 by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 02FBuci4031559;
 Sun, 15 Mar 2020 11:56:38 GMT
Received: from [192.168.14.112] (/79.179.237.174)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Sun, 15 Mar 2020 04:56:37 -0700
Subject: Re: [PATCH v3 10/16] hw/i386/vmport: Add support for CMD_GETTIME
To: "Michael S. Tsirkin" <mst@redhat.com>
References: <0bc7dac9-41a6-5af2-a1d5-ef1e79f92eea@oracle.com>
 <20200313113049-mutt-send-email-mst@kernel.org>
 <3c0d9308-f56c-0766-9815-241a28d9a246@oracle.com>
 <20200313170914-mutt-send-email-mst@kernel.org>
 <67d158f3-9d6c-cba8-6b3a-87702abdc6f0@oracle.com>
 <20200314151236-mutt-send-email-mst@kernel.org>
 <a9ac1106-67be-5d5d-fd30-669a483f09b0@oracle.com>
 <20200314152119-mutt-send-email-mst@kernel.org>
 <C3D0DD6C-592E-4230-A7D6-FF423265DF03@oracle.com>
 <5f9f6b13-d382-b9a6-52cd-80014c2f01b8@oracle.com>
 <20200314164850-mutt-send-email-mst@kernel.org>
From: Liran Alon <liran.alon@oracle.com>
Message-ID: <641cf9e0-f24d-3387-1db8-0fd768967121@oracle.com>
Date: Sun, 15 Mar 2020 13:56:33 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:68.0)
 Gecko/20100101 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200314164850-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9560
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 mlxlogscore=999 mlxscore=0
 adultscore=0 bulkscore=0 malwarescore=0 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2003150066
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9560
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 bulkscore=0
 suspectscore=0 lowpriorityscore=0 phishscore=0 adultscore=0 clxscore=1015
 impostorscore=0 priorityscore=1501 spamscore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2003150066
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by userp2130.oracle.com id
 02FBhhD0027821
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
Cc: ehabkost@redhat.com, qemu-devel@nongnu.org,
 Nikita Leshenko <nikita.leshchenko@oracle.com>, pbonzini@redhat.com,
 rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 14/03/2020 22:56, Michael S. Tsirkin wrote:
> On Sat, Mar 14, 2020 at 10:05:20PM +0200, Liran Alon wrote:
>> Michael, you can also refer to this VMware time-keeping whitepaper:
>> https://urldefense.com/v3/__https://www.vmware.com/pdf/vmware_timekeep=
ing.pdf__;!!GqivPVa7Brio!K8sfnfvVgKwrQ4SMwX-K6-S5yR4ln9_qZ6o4GzIpQkohfWti=
nlplNhXzFlyUgks$ .
>> According to section "Initializing and Correcting Wall-Clock Time":
>> """
>> VMware Tools can also optionally be used to correct long=E2=80=90term =
drift and
>> errors by periodically
>> resynchronizing the virtual machine=E2=80=99s clock to the host=E2=80=99=
s clock, but the
>> current version at this writing is limited.
>> In particular, in guest operating systems other than NetWare, it does =
not
>> correct errors in which the guest clock
>> is ahead of real time, only those in which the guest clock is behind.
>>
>> """
> This talks about guest time.
> What this does not mention is whether hosts need to employ any mechanis=
ms
> to synchronise wall clock between hosts.
The above mentioned whitepaper also discuss how VMware maintains the=20
wallclock time across migrations (vMotion).
See section "Using VMware Tools Clock Synchronization" in whitepaper.

Specifically, there is an option in .vmx file named=20
"time.synchronize.resume.disk" which:
"""
If set to TRUE, the clock syncs after resuming from suspend and after=20
migrating to a new host using the VMware VMotion feature.
"""

The matching functionality in open-vm-tools can can be seen in=20
services/plugins/timeSync/timeSync.c where ToolsOnLoad()
registers the "Time_Synchronize" RpcCallback, which is=20
TimeSyncTcloHandler(), that is possibly allowed to sync time backwards=20
(Note the "backwardSync" var).

The current patch-series I have submitted doesn't implement this=20
RpcCallback functionality.
That work can be delayed to a future patch-series that will add this=20
extra functionality as-well.

>> If I understand correctly, this seems to validate my assumption that c=
urrent
>> implementation for CMD_GETTIME is sufficient.
> So I am concerned this does not interact well with other time sources
> in QEMU. For example, it's very useful to set guest time with -rtc base
> flag.
>
> Can you use qemu_get_timedate?
>
This is a very good point.
VMware also have the ability that allows user to explicitly set guest=20
time with .vmx "rtc.startTime" option.
(The time-zone can also be set by specifying an offset from UTC with=20
"rtc.diffFromUTC" option)

However, if you will read section "Using VMware Tools Clock=20
Synchronization -> Disabling All Synchronization" in above mentioned=20
whitepaper,
you will notice that in VMware's design, VMPort CMD_GETTIME command is=20
intentionally not synced with virtual CMOS TOD. i.e. The section explicit=
ly
documents that if a user wants to set guest time to fictitious time,=20
user must disable VMware Tools time sync functionality by manipulating
"tools.syncTime" and "time.synchronize.*" configuration options as desire=
d.

Therefore, I think current patch VMPort CMD_GETTIME command=20
implementation is correct.
What do you think?

-Liran




