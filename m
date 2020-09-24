Return-Path: <SRS0=QZTr=DB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E36F4C4727F
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 21:50:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6D9BB21D20
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 21:50:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="LxhciMad"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D9BB21D20
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39912 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLZ8h-0007ms-Eq
	for qemu-devel@archiver.kernel.org; Thu, 24 Sep 2020 17:50:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51576)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1kLZ7u-0006uh-1R
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 17:50:06 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:51872)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1kLZ7s-00076g-3d
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 17:50:05 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
 by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08OLnZFp154037;
 Thu, 24 Sep 2020 21:50:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=3Ku9NKFIut/X/hk5wJ9BGrVXWq7TpwvNvUfozUork4U=;
 b=LxhciMadOf0SqZy1/W9AxsEOVKqldkezb4BnFk2icD2TY3ZYR+3ffIin8+MD+pK8Fzdh
 lhk2SRex9giwEaGePvLRNmhOXnLq+BVonR7vmAPrbudKFSSP+yUgkRmcvJ2GnwtmCtLn
 qEokf0qbXNBcqH91tA/kIY8kjxtAZB/RsJh8Bdz5yTuhrvfkCmXDCzY55kiWXoU+nMeS
 WblK9qQDQ+C7JPXIflnJDRYMmC/+ZwwstN3Bet1Jx8yrSQVAsBdGc3X1/tGRBnCXcq3N
 51JSQ1MhcB9yxw7GKQRTAhKPu32BxCyMJONgfFizCvS4vq6/3tEa4s3plMA51KLc02dE PA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
 by aserp2130.oracle.com with ESMTP id 33qcpu7n6j-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 24 Sep 2020 21:50:02 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
 by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08OLUYkv160483;
 Thu, 24 Sep 2020 21:50:01 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
 by aserp3030.oracle.com with ESMTP id 33nujrex1b-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 24 Sep 2020 21:50:01 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
 by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 08OLo0rs016997;
 Thu, 24 Sep 2020 21:50:00 GMT
Received: from [10.39.244.100] (/10.39.244.100)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Thu, 24 Sep 2020 14:50:00 -0700
Subject: Re: [PATCH V1 05/32] savevm: QMP command for cprload
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
References: <1596122076-341293-1-git-send-email-steven.sistare@oracle.com>
 <1596122076-341293-6-git-send-email-steven.sistare@oracle.com>
 <654553cb-e071-0498-fe66-78ddda3942e9@redhat.com>
 <c135f2e5-10d5-81f5-7251-cead777428aa@oracle.com>
 <20200911171809.GM3310@work-vm>
From: Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
Message-ID: <d991fe19-d5a9-36a7-3d8f-0730fe9da06b@oracle.com>
Date: Thu, 24 Sep 2020 17:49:58 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200911171809.GM3310@work-vm>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9754
 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 malwarescore=0
 mlxlogscore=999 phishscore=0 adultscore=0 spamscore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009240155
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9754
 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 mlxlogscore=999
 adultscore=0 bulkscore=0 mlxscore=0 lowpriorityscore=0 priorityscore=1501
 phishscore=0 spamscore=0 malwarescore=0 clxscore=1011 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009240156
Received-SPF: pass client-ip=141.146.126.79;
 envelope-from=steven.sistare@oracle.com; helo=aserp2130.oracle.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/24 17:43:55
X-ACL-Warn: Detected OS   = Linux 3.1-3.10 [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.199,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.214, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: "Daniel P. Berrange" <berrange@redhat.com>,
 Juan Quintela <quintela@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/11/2020 1:18 PM, Dr. David Alan Gilbert wrote:
> * Steven Sistare (steven.sistare@oracle.com) wrote:
>> On 7/30/2020 12:14 PM, Eric Blake wrote:
>>> On 7/30/20 10:14 AM, Steve Sistare wrote:
>>>> Provide the cprload QMP command.Â  The VM is created from the file produced
>>>> by the cprsave command.Â  Guest RAM is restored in-place from the shared
>>>> memory backend file, and guest block devices are used as is.Â  The contents
>>>> of such devices must not be modified between the cprsave and cprload
>>>> operations.Â  If the VM was running at cprsave time, then VM execution
>>>> resumes.
>>>
>>> Is it always wise to unconditionally resume, or might this command need an additional optional knob that says what state (paused or running) to move into?
>>
>> This can already be done.  Issue a stop command before cprsave, then cprload will finish in a
>> paused state.
>>
>> Also, cprsave re-execs and leaves the guest in a paused state.  One can
>>
>> send device add commands, then send cprload which continues
>> .
> 
> You're suffering here because you're reinventing stuff rather than
> reusing existing migration paths.
> With the existing migration code we require the qemu
> to be started with -incoming ... so we know it's in a clean
> state ready for being loaded, and we've already got the -S
> mechanism that dictates whether or not the VM autostarts
> (regardless of the saved state in the image).  The management
> layers find this pretty useful if they need to wire some networking
> or storage up at the point they know they've got a VM image that's
> loaded OK.

I am not seeing the issue here.  The manager can hot plug with cprsave as
easily as with migration, at the same transition points.  I don't see what
migration paths should be reused here.

CPR                                     Migration

- cprsave restarts qemu with the env    - qemu -S -incoming defer
var QEMU_START_FREEZE set, which
clears autostart just like -S.
(see patch 15)

- command-line devices created          - command-line devices created

- vmstate is prelaunch                  - vmstate is inmigrate

- manager sends hotplug commands        - manager sends hotplug commands

- manager sends cprload                 - manager sends migrate_incoming

It would perhaps be more correct for cprsave to leave the vm in the preconfig
state.

I don't feel like I'm suffering.  At least not yet :)

- Steve

>>>> Syntax:
>>>> Â Â  {'command':'cprload', 'data':{'file':'str'}}
>>>>
>>>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>>>> Signed-off-by: Maran Wilson <maran.wilson@oracle.com>
>>>> ---
>>>
>>>> +++ b/qapi/migration.json
>>>> @@ -1635,3 +1635,14 @@
>>>> Â  ##
>>>> Â  { 'command': 'cprsave', 'data': { 'file': 'str', 'mode': 'str' } }
>>>> Â  +##
>>>> +# @cprload:
>>>> +#
>>>> +# Start virtual machine from checkpoint file that was created earlier using
>>>> +# the cprsave command.
>>>> +#
>>>> +# @file: name of checkpoint file
>>>> +#
>>>> +# Since 5.0
>>>
>>> another 5.2 instance. I'll quit pointing it out for the rest of the series.
>>
>> Will find and fix all, thanks.
>>
>> - Steve
>>

