Return-Path: <SRS0=QZTr=DB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E774C4727F
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 21:55:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F00E621D20
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 21:55:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="CMvqGan6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F00E621D20
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49904 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLZCe-0003V8-58
	for qemu-devel@archiver.kernel.org; Thu, 24 Sep 2020 17:55:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52286)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1kLZBa-0002E4-Nw
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 17:53:54 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:55364)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1kLZBY-0007Z9-Sv
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 17:53:54 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
 by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08OLoPc4154795;
 Thu, 24 Sep 2020 21:53:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=B+7p1ec6eOXjsctlyNFkiV7VpoeUHraxRUYBIEAtB+Q=;
 b=CMvqGan6qellP15SYHn96eVZR/N0la8aMzA+bx7G8GnNdJz+1/ss9vZCLUWFkmnj2KLE
 B7GDSjE2fFej5V+RlPDYzM/OmURifvSFTCU6UmPWqkQIsPLy8O8xOlXZ0EkBa+z+53Th
 LOTkPecPdiDxWeKzF09/Qov5B/fOLBsaDglKFg4YkSjw2XT6Y1vjTbHeAo2v5vkVzkgU
 anVyPDASphf5cgt+PLjMMYa1uhMDLN1CRKjbNRsWo0U0MA2S+g5VdIvQaRNMohUv4gmL
 5uEIbnxZQRudU8IyH8qwFvk3ZkrIpanZJuPN7i5xQwKhixIM4QFyYFwjMJMu4BqqcESG oA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
 by aserp2130.oracle.com with ESMTP id 33qcpu7nrj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 24 Sep 2020 21:53:50 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
 by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08OLoBrI050370;
 Thu, 24 Sep 2020 21:51:50 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
 by aserp3020.oracle.com with ESMTP id 33r28xj8du-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 24 Sep 2020 21:51:50 +0000
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
 by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 08OLpnru020497;
 Thu, 24 Sep 2020 21:51:49 GMT
Received: from [10.39.244.100] (/10.39.244.100)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Thu, 24 Sep 2020 14:51:49 -0700
Subject: Re: [PATCH V1 12/32] vl: pause option
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
References: <1596122076-341293-1-git-send-email-steven.sistare@oracle.com>
 <1596122076-341293-13-git-send-email-steven.sistare@oracle.com>
 <87r1stdjes.fsf@linaro.org> <b18f2181-902b-a091-9711-93d49ab8aec8@oracle.com>
 <20200911175934.GR3310@work-vm>
From: Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
Message-ID: <0c4c4e76-f869-b70f-83b2-11381890972c@oracle.com>
Date: Thu, 24 Sep 2020 17:51:46 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200911175934.GR3310@work-vm>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9754
 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 mlxlogscore=999
 suspectscore=0 adultscore=0 bulkscore=0 malwarescore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009240156
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9754
 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 mlxlogscore=999
 adultscore=0 bulkscore=0 mlxscore=0 lowpriorityscore=0 priorityscore=1501
 phishscore=0 spamscore=0 malwarescore=0 clxscore=1015 impostorscore=0
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
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org,
 Markus Armbruster <armbru@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/11/2020 1:59 PM, Dr. David Alan Gilbert wrote:
> * Steven Sistare (steven.sistare@oracle.com) wrote:
>> On 7/30/2020 1:03 PM, Alex BennÃ©e wrote:
>>>
>>> Steve Sistare <steven.sistare@oracle.com> writes:
>>>
>>>> Provide the -pause command-line parameter and the QEMU_PAUSE environment
>>>> variable to briefly pause QEMU in main and allow a developer to attach gdb.
>>>> Useful when the developer does not invoke QEMU directly, such as when using
>>>> libvirt.
>>>
>>> How does this differ from -S?
>>
>> The -S flag runs qemu to the main loop but does not start the guest.  Lots of code
>> that you may need to debug runs before you get there.
> 
> You might try the '--preconfig' option - that's pretty early on.
> The other one is adding a chardev and telling it to wait for a server;
> that'll wait until you telnet to the port.
> 
> (Either way, this patch shouldn't really be part of this series, it's a
> separate discussion)

Sure, I will pull it from the series.

- Steve

>> - Steve
>>>> Usage:
>>>>   qemu -pause <seconds>
>>>>   or
>>>>   export QEMU_PAUSE=<seconds>
>>>>
>>>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>>>> ---
>>>>  qemu-options.hx |  9 +++++++++
>>>>  softmmu/vl.c    | 15 ++++++++++++++-
>>>>  2 files changed, 23 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/qemu-options.hx b/qemu-options.hx
>>>> index 708583b..8505cf2 100644
>>>> --- a/qemu-options.hx
>>>> +++ b/qemu-options.hx
>>>> @@ -3668,6 +3668,15 @@ SRST
>>>>      option is experimental.
>>>>  ERST
>>>>  
>>>> +DEF("pause", HAS_ARG, QEMU_OPTION_pause, \
>>>> +    "-pause secs    Pause for secs seconds on entry to main.\n", QEMU_ARCH_ALL)
>>>> +
>>>> +SRST
>>>> +``--pause secs``
>>>> +    Pause for a number of seconds on entry to main.  Useful for attaching
>>>> +    a debugger after QEMU has been launched by some other entity.
>>>> +ERST
>>>> +
>>>
>>> It seems like having an option to race with the debugger is just asking
>>> for trouble.
>>>
>>>>  DEF("S", 0, QEMU_OPTION_S, \
>>>>      "-S              freeze CPU at startup (use 'c' to start execution)\n",
>>>>      QEMU_ARCH_ALL)
>>>> diff --git a/softmmu/vl.c b/softmmu/vl.c
>>>> index 8478778..951994f 100644
>>>> --- a/softmmu/vl.c
>>>> +++ b/softmmu/vl.c
>>>> @@ -2844,7 +2844,7 @@ static void create_default_memdev(MachineState *ms, const char *path)
>>>>  
>>>>  void qemu_init(int argc, char **argv, char **envp)
>>>>  {
>>>> -    int i;
>>>> +    int i, seconds;
>>>>      int snapshot, linux_boot;
>>>>      const char *initrd_filename;
>>>>      const char *kernel_filename, *kernel_cmdline;
>>>> @@ -2882,6 +2882,13 @@ void qemu_init(int argc, char **argv, char **envp)
>>>>      QemuPluginList plugin_list = QTAILQ_HEAD_INITIALIZER(plugin_list);
>>>>      int mem_prealloc = 0; /* force preallocation of physical target memory */
>>>>  
>>>> +    if (getenv("QEMU_PAUSE")) {
>>>> +        seconds = atoi(getenv("QEMU_PAUSE"));
>>>> +        printf("Pausing %d seconds for debugger. QEMU PID is %d\n",
>>>> +               seconds, getpid());
>>>> +        sleep(seconds);
>>>> +    }
>>>> +
>>>>      os_set_line_buffering();
>>>>  
>>>>      error_init(argv[0]);
>>>> @@ -3204,6 +3211,12 @@ void qemu_init(int argc, char **argv, char **envp)
>>>>              case QEMU_OPTION_gdb:
>>>>                  add_device_config(DEV_GDB, optarg);
>>>>                  break;
>>>> +            case QEMU_OPTION_pause:
>>>> +                seconds = atoi(optarg);
>>>> +                printf("Pausing %d seconds for debugger. QEMU PID is %d\n",
>>>> +                            seconds, getpid());
>>>> +                sleep(seconds);
>>>> +                break;
>>>>              case QEMU_OPTION_L:
>>>>                  if (is_help_option(optarg)) {
>>>>                      list_data_dirs = true;
>>>
>>>
>>

