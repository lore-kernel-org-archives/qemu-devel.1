Return-Path: <SRS0=LLOU=EL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED3D4C4741F
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 15:21:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E97F20715
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 15:21:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="WwNG6o+p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E97F20715
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40958 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kah4M-0000hh-U0
	for qemu-devel@archiver.kernel.org; Thu, 05 Nov 2020 10:20:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56262)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1kah2g-00082v-AW
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 10:19:14 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:53950)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1kah2d-0005MX-Ms
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 10:19:13 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
 by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0A5FDiI6044562;
 Thu, 5 Nov 2020 15:19:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=QsgVntZrkomx2mjMzpbByx5Bjbf6rIu5QODEeG9vCvM=;
 b=WwNG6o+pcLA2XHzUFj5+r9L8u7DigJxAGkT4NlXrHJaQI8oTVGWCSr3UQGr8cToPRvzo
 ddTKj1480+1xm6atoOD08CxWH443XtKOiSu2r7pki29DkYi0Dn1mGLnJWiQUaq3nC7cB
 qS339o/da/azIYa+3fC9CsyedjipsnssEl7DV4ZgePsLKUUDIWkXOIZWZilPtY4nqVlY
 Zd6RpRIrBfg3qr3ODlPIrZoF2G11+lFfFOC9hQ5huWpDAZuwhU3V8ZidLoAIWgzqLwN2
 M5g6v2r3+JZ+daNy3Eh3EG5IyI8lOJWGwqe3a8E5Z0RlH5Dhj5GEvjCa5ceZwEHYGPMB iA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
 by aserp2130.oracle.com with ESMTP id 34hhb2ccye-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 05 Nov 2020 15:19:08 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
 by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0A5FAta8040701;
 Thu, 5 Nov 2020 15:19:07 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
 by aserp3030.oracle.com with ESMTP id 34jf4cbfxb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 05 Nov 2020 15:19:07 +0000
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
 by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0A5FJ6Pu010751;
 Thu, 5 Nov 2020 15:19:07 GMT
Received: from [10.39.202.216] (/10.39.202.216)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Thu, 05 Nov 2020 07:19:06 -0800
Subject: Re: [PATCH V2] vl: pause option
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
References: <1604332203-435466-1-git-send-email-steven.sistare@oracle.com>
 <d93b83ea-f31d-4e6b-2350-c6d4c9b71448@redhat.com> <87imakby2n.fsf@linaro.org>
 <db5462f0-f96f-2498-3aa3-ec322462ba22@oracle.com>
 <20201105150712.GO630142@redhat.com>
From: Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
Message-ID: <05158c4c-a255-4f10-9207-f82a791e1c35@oracle.com>
Date: Thu, 5 Nov 2020 10:19:06 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201105150712.GO630142@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9795
 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 suspectscore=0 mlxscore=0
 bulkscore=0 malwarescore=0 mlxlogscore=999 phishscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011050105
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9795
 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 phishscore=0 suspectscore=0
 clxscore=1015 mlxlogscore=999 impostorscore=0 malwarescore=0
 lowpriorityscore=0 adultscore=0 spamscore=0 priorityscore=1501 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011050105
Received-SPF: pass client-ip=141.146.126.79;
 envelope-from=steven.sistare@oracle.com; helo=aserp2130.oracle.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/05 10:19:10
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
 qemu-devel@nongnu.org, "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/5/2020 10:07 AM, Daniel P. Berrangé wrote:
> On Thu, Nov 05, 2020 at 09:55:21AM -0500, Steven Sistare wrote:
>> On 11/4/2020 4:40 PM, Alex Bennée wrote:
>>> Eric Blake <eblake@redhat.com> writes:
>>>> On 11/2/20 9:50 AM, Steve Sistare wrote:
>>>>> Provide the -pause command-line parameter and the QEMU_PAUSE environment
>>>>> variable to pause QEMU during process startup using SIGSTOP and allow a
>>>>> developer to attach a debugger, or observe the process using tools such as
>>>>> strace.  Useful when the QEMU has been launched with some other entity, such
>>>>> as libvirt.  QEMU_PAUSE is checked in a constructor at the highest priority,
>>>>> and can be used to debug other constructors.  The -pause option is checked
>>>>> later, during argument processing in main, but is useful if passing an
>>>>> environment variable from a launcher to qemu is awkard.
>>>>>
>>>>> Usage: qemu -pause, or QEMU_PAUSE=1
>>>>> After attaching a debugger, send SIGCONT to the qemu process to continue.
>>>>
>>>> Changing behavior via a new environment variable is awkward.  What
>>>> happens, for example, if libvirt inherits this variable set, but is not
>>>> aware of its impact to alter how qemu starts up?  Can we get by with
>>>> ONLY a command line option?
>>>>
>>>> Also, how does this option differ from what we already have with qemu
>>>> --preconfig?
>>>
>>> In the original discussion:
>>>
>>>   Subject: [PATCH V1 12/32] vl: pause option
>>>   Date: Thu, 30 Jul 2020 08:14:16 -0700
>>>   Message-Id: <1596122076-341293-13-git-send-email-steven.sistare@oracle.com>
>>>
>>> it seems the idea was to stop qemu as early as possible for debugging
>>> when launched by some other launcher which wasn't modifiable except by
>>> pass through configuration to QEMU's command line.
>>>
>>> <snip>
>>>
>>>> Isn't it always possible to provide a wrapper qemu process to be invoked
>>>> by whatever third-party management app (like libvirt), where your
>>>> wrapper then starts the real qemu under gdb to begin with, rather than
>>>> having to hack qemu itself to have a special start-up mode?
>>>
>>> I agree - this feels like a bit of an over complication as a debug
>>> helper. How many times can a failure to launch by some binary blob not
>>> be debugged by either a gdb follow-fork or a copying of the command line
>>> and running gdb --args?
>>
>> Follow fork is awkward and error prone when the launcher performs many forks before forking
>> qemu. gdb --args does not work when the launcher sets up an environment for qemu to run
>> in, pre-opening fd's being just one example.  For developers, often the "launcher" is a 
>> script that performs setup and passes the myriad qemu options.  Even in that case, it is
>> easier to add a flag or set an env var to enable debugging. The pause option is fast 
>> (for the user) and reliable.
> 
> What is your launcher ?  Are you using libvirt, or something else ?
> 
> If the goal is simply to make it easy to attach GDB right at the start of
> QEMU execution, then could this feature be supported by the launcher itself
> in an easier way.
> 
> eg, immediately before the execve(qemu, ....) syscall, the launcher can
> simply send SIGSTOP to itself.  You can now fire up GDB, attach to it,
> and be able to watch execution from the very momement of execve(),
> which is even earlier than this patch allows for, and still avoids the
> need to follow across forks. 

My launcher is part of our container environment.  But I also use libvirt, and scripts.
Putting the hook inside qemu makes it work for all environments.

The V2 patch uses your SIGSTOP idea (which you previously suggested to me, thanks), but I found that
by fiddling with signal masks, I could make the handshake easier for the user.  See the example in the 
V2 patch message, versus the example I just sent in my last email.

- Steve

