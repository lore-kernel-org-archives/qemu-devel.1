Return-Path: <SRS0=hH57=EK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27932C2D0A3
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 20:42:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 36A8620637
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 20:42:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="OL0op4OE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36A8620637
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41286 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaPcI-0007Ye-1R
	for qemu-devel@archiver.kernel.org; Wed, 04 Nov 2020 15:42:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47234)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1kaPbe-0006rn-Fi
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 15:42:10 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:50440)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1kaPbc-00005r-CP
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 15:42:09 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
 by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0A4Ke46J067256;
 Wed, 4 Nov 2020 20:42:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=IXZUb/wdZLKkxzr+7r9dVUdABFA16J3kpOOiHn4aoUw=;
 b=OL0op4OEbZnutl6Y+HwXH/SeV38XCC76nlD6HnL8/SN87sVO1a8PvqiEH0dLj3pAVfNj
 /5gNeH53GjOweNIkk7vsZWco1oFOdNlY0QPksZTWlL74wVAUCV/OqV4ymFIu1sCvhlub
 uut0txyKP3mcOxlkJw1oCtSo9NuELaipRv3ZNU/j8yKUiLK1c3ZXpVcpKbHu8/CGHJxt
 3hEoXoxT3UZCc1GjNjkg+0x9knd7rUe653GDDhp65uxrfXPAWwPep5zNkHXP8mS6WTU/
 XYYxFKKKtb0aQVjfsnQvYnKoSIlJ12RKofpEbmWkqgw/SrBV7SGc2zNm9dNYiJTEEAWA /Q== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
 by aserp2120.oracle.com with ESMTP id 34hhvcgttr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 04 Nov 2020 20:42:04 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
 by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0A4KaXs7166093;
 Wed, 4 Nov 2020 20:40:03 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
 by aserp3020.oracle.com with ESMTP id 34hw0kf9g7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 04 Nov 2020 20:40:03 +0000
Received: from abhmp0020.oracle.com (abhmp0020.oracle.com [141.146.116.26])
 by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0A4Ke10R006873;
 Wed, 4 Nov 2020 20:40:01 GMT
Received: from [10.39.255.100] (/10.39.255.100)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Wed, 04 Nov 2020 12:40:00 -0800
Subject: Re: [PATCH V2] vl: pause option
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
References: <1604332203-435466-1-git-send-email-steven.sistare@oracle.com>
 <d93b83ea-f31d-4e6b-2350-c6d4c9b71448@redhat.com>
From: Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
Message-ID: <5322e622-2ded-c917-8bb5-41d8670dc4dc@oracle.com>
Date: Wed, 4 Nov 2020 15:39:59 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <d93b83ea-f31d-4e6b-2350-c6d4c9b71448@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9795
 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 adultscore=0 bulkscore=0
 mlxscore=0 suspectscore=0 spamscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011040149
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9795
 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 suspectscore=0
 impostorscore=0 malwarescore=0 priorityscore=1501 mlxlogscore=999
 bulkscore=0 phishscore=0 adultscore=0 mlxscore=0 lowpriorityscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011040150
Received-SPF: pass client-ip=141.146.126.78;
 envelope-from=steven.sistare@oracle.com; helo=aserp2120.oracle.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/04 13:42:08
X-ACL-Warn: Detected OS   = Linux 3.1-3.10 [fuzzy]
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/4/2020 2:26 PM, Eric Blake wrote:
> On 11/2/20 9:50 AM, Steve Sistare wrote:
>> Provide the -pause command-line parameter and the QEMU_PAUSE environment
>> variable to pause QEMU during process startup using SIGSTOP and allow a
>> developer to attach a debugger, or observe the process using tools such as
>> strace.  Useful when the QEMU has been launched with some other entity, such
>> as libvirt.  QEMU_PAUSE is checked in a constructor at the highest priority,
>> and can be used to debug other constructors.  The -pause option is checked
>> later, during argument processing in main, but is useful if passing an
>> environment variable from a launcher to qemu is awkard.
>>
>> Usage: qemu -pause, or QEMU_PAUSE=1
>> After attaching a debugger, send SIGCONT to the qemu process to continue.
> 
> Changing behavior via a new environment variable is awkward.  What
> happens, for example, if libvirt inherits this variable set, but is not
> aware of its impact to alter how qemu starts up? 

The env var is intended to only be set by a developer.  The developer is responsible
for sending SIGCONT, not libvirt.  libvirt does not need to understand the semantics
of QEMU_PAUSE.

For libvirt, the developer would add this to the domain definition file, so it only
applies to that domain:

<qemu:commandline>
   <qemu:env name='QEMU_PAUSE' value='1'/>
</qemu:commandline>

>  Can we get by with ONLY a command line option?

The command line option is sufficient most of the time and I would be happy to get
at least that.  The env var is even better, and if I do not push it, someone else
will!

> Also, how does this option differ from what we already have with qemu
> --preconfig?

pause stops the qemu process earlier, so more can be debugged before it occurs.
With preconfig, qemu is still running its event loop and may respond to external
events such as monitor requests, which may be undesirable.

- Steve

>> Example:
>>
>> $ QEMU_PAUSE=1 qemu-system-x86_64 ...
>> QEMU pid 18371 is stopped.
>> [1]+  Stopped
>>                                  $ gdb -p 18371
>>                                  (gdb)
>> $ kill -cont 18371
>>                                  (gdb) break rcu_init
>>                                  (gdb) continue
>>                                  Program received signal SIGCONT, Continued.
>>                                  (gdb) continue
>>                                  Breakpoint 1, rcu_init () at util/rcu.c:380
>>
>> Thanks to Daniel P. Berrange <berrange@redhat.com> for suggesting SIGSTOP.
>>
>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>> ---
>>  qemu-options.hx | 14 ++++++++++++++
>>  softmmu/vl.c    | 23 +++++++++++++++++++++++
>>  2 files changed, 37 insertions(+)
>>
>> diff --git a/qemu-options.hx b/qemu-options.hx
>> index 708583b..42edd70 100644
>> --- a/qemu-options.hx
>> +++ b/qemu-options.hx
>> @@ -3668,6 +3668,20 @@ SRST
>>      option is experimental.
>>  ERST
>>  
>> +DEF("pause", 0, QEMU_OPTION_pause, \
>> +    "-pause          pause the qemu process in main using SIGSTOP.\n"
>> +    "                to pause earlier, before constructors are run, set the\n"
>> +    "                environment variable QEMU_PAUSE=1 before starting qemu.\n",
>> +    QEMU_ARCH_ALL)
>> +
>> +SRST
>> +``-pause``
>> +    Pause the qemu process in main using SIGSTOP.  This is useful for attaching
>> +    a debugger after QEMU has been launched by some other entity.  After
>> +    attaching, send SIGCONT to continue.  To pause earlier, before constructors
>> +    are run, set the environment variable QEMU_PAUSE=1 before starting qemu.
>> +ERST
> 
> Isn't it always possible to provide a wrapper qemu process to be invoked
> by whatever third-party management app (like libvirt), where your
> wrapper then starts the real qemu under gdb to begin with, rather than
> having to hack qemu itself to have a special start-up mode?
> 

