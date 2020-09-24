Return-Path: <SRS0=QZTr=DB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D21A8C4363D
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 21:48:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7421421D20
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 21:48:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="UW0uowW4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7421421D20
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34996 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLZ6X-0005ff-Hs
	for qemu-devel@archiver.kernel.org; Thu, 24 Sep 2020 17:48:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50434)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1kLZ4E-0004dY-Lx
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 17:46:18 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:48990)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1kLZ49-0006lQ-4s
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 17:46:18 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
 by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08OLTXSo119996;
 Thu, 24 Sep 2020 21:46:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=wTXDraqtejfCZc8l+KT1RzlmyLfWal0dId/IB/EiSIQ=;
 b=UW0uowW41qVFETPwnzuAE67zEB1TtK4H9693ceqv42JdbIo3E27NHiVQujoPg7eH08il
 n3VoD4bGZrfuFHeHZ14VswnzTLeDXlf55Aq5d7SJ9+oXInEotgjuxJ2ded0rpBWfTMMj
 JrBKS4f/mIp4Cr+xpohZGjMJ9Z2i0JERAvClzlE41/rgdHOfPY0KjEfYr8SkJOKRy3bC
 tJlsejh03/jyRKeXoOJChYSaNQ8aXtsSykH4aRmFstnltV/WGjxtO9QF7g99GCku1DDc
 f3JyquGsdLSEGwrpYqDHQ1NYG4QOZMS+VfcRISYbx5H3+/O80YY+CNZrN0fxldxhh8AL Xg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
 by aserp2130.oracle.com with ESMTP id 33qcpu7mra-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 24 Sep 2020 21:46:10 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
 by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08OLVX6s056789;
 Thu, 24 Sep 2020 21:44:10 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
 by userp3030.oracle.com with ESMTP id 33nux3fbcq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 24 Sep 2020 21:44:09 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
 by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 08OLi8dg016803;
 Thu, 24 Sep 2020 21:44:08 GMT
Received: from [10.39.244.100] (/10.39.244.100)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Thu, 24 Sep 2020 14:44:07 -0700
Subject: Re: [PATCH V1 04/32] savevm: HMP Command for cprsave
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
References: <1596122076-341293-1-git-send-email-steven.sistare@oracle.com>
 <1596122076-341293-5-git-send-email-steven.sistare@oracle.com>
 <20200911165716.GL3310@work-vm>
From: Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
Message-ID: <ae5bf659-c25e-8af4-ba14-a5a21476758f@oracle.com>
Date: Thu, 24 Sep 2020 17:44:05 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200911165716.GL3310@work-vm>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9754
 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 mlxscore=0 adultscore=0
 bulkscore=0 mlxlogscore=999 phishscore=0 suspectscore=2 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009240155
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9754
 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2
 mlxlogscore=999
 adultscore=0 bulkscore=0 mlxscore=0 lowpriorityscore=0 priorityscore=1501
 phishscore=0 spamscore=0 malwarescore=0 clxscore=1015 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009240155
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

On 9/11/2020 12:57 PM, Dr. David Alan Gilbert wrote:
> * Steve Sistare (steven.sistare@oracle.com) wrote:
>> Enable HMP access to the cprsave QMP command.
>>
>> Usage: cprsave <filename> <mode>
>>
>> Signed-off-by: Maran Wilson <maran.wilson@oracle.com>
>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> 
> I realise that the current mode is currently only 'reboot' - can you
> please give us a clue as to why you've got a mode argument that's
> currently only got one mode?

Patch 14 adds the restart mode.
I factored the patches by capability to make the review easier, first
presenting the reboot patches, then the restart patches.

- Steve

>> ---
>>  hmp-commands.hx       | 18 ++++++++++++++++++
>>  include/monitor/hmp.h |  1 +
>>  monitor/hmp-cmds.c    | 10 ++++++++++
>>  3 files changed, 29 insertions(+)
>>
>> diff --git a/hmp-commands.hx b/hmp-commands.hx
>> index 60f395c..c8defd9 100644
>> --- a/hmp-commands.hx
>> +++ b/hmp-commands.hx
>> @@ -354,6 +354,24 @@ SRST
>>  ERST
>>  
>>      {
>> +        .name       = "cprsave",
>> +        .args_type  = "file:s,mode:s",
>> +        .params     = "file 'reboot'",
>> +        .help       = "create a checkpoint of the VM in file",
>> +        .cmd        = hmp_cprsave,
>> +    },
>> +
>> +SRST
>> +``cprsave`` *tag*
>> +  Stop VCPUs, create a checkpoint of the whole virtual machine and save it
>> +  in *file*.
>> +  If *mode* is 'reboot', the checkpoint can be cprload'ed after a host kexec
>> +  reboot.
>> +  exec() /usr/bin/qemu-exec if it exists, else exec /usr/bin/qemu-system-x86_64,
>> +  passing all the original command line arguments.  The VCPUs remain paused.
>> +ERST
>> +
>> +    {
>>          .name       = "delvm",
>>          .args_type  = "name:s",
>>          .params     = "tag",
>> diff --git a/include/monitor/hmp.h b/include/monitor/hmp.h
>> index c986cfd..af8ee23 100644
>> --- a/include/monitor/hmp.h
>> +++ b/include/monitor/hmp.h
>> @@ -59,6 +59,7 @@ void hmp_balloon(Monitor *mon, const QDict *qdict);
>>  void hmp_loadvm(Monitor *mon, const QDict *qdict);
>>  void hmp_savevm(Monitor *mon, const QDict *qdict);
>>  void hmp_delvm(Monitor *mon, const QDict *qdict);
>> +void hmp_cprsave(Monitor *mon, const QDict *qdict);
>>  void hmp_migrate_cancel(Monitor *mon, const QDict *qdict);
>>  void hmp_migrate_continue(Monitor *mon, const QDict *qdict);
>>  void hmp_migrate_incoming(Monitor *mon, const QDict *qdict);
>> diff --git a/monitor/hmp-cmds.c b/monitor/hmp-cmds.c
>> index ae4b6a4..59196ed 100644
>> --- a/monitor/hmp-cmds.c
>> +++ b/monitor/hmp-cmds.c
>> @@ -1139,6 +1139,16 @@ void hmp_announce_self(Monitor *mon, const QDict *qdict)
>>      qapi_free_AnnounceParameters(params);
>>  }
>>  
>> +void hmp_cprsave(Monitor *mon, const QDict *qdict)
>> +{
>> +    Error *err = NULL;
>> +
>> +    qmp_cprsave(qdict_get_try_str(qdict, "file"),
>> +                qdict_get_try_str(qdict, "mode"),
>> +                &err);
>> +    hmp_handle_error(mon, err);
>> +}
>> +
>>  void hmp_migrate_cancel(Monitor *mon, const QDict *qdict)
>>  {
>>      qmp_migrate_cancel(NULL);
>> -- 
>> 1.8.3.1
>>

