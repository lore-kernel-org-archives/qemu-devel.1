Return-Path: <SRS0=QZTr=DB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 670B3C4363D
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 21:55:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 021772399A
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 21:55:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="JSmGnyHT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 021772399A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51516 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLZD1-0004A9-VY
	for qemu-devel@archiver.kernel.org; Thu, 24 Sep 2020 17:55:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52088)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1kLZAT-0000x3-Dz
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 17:52:45 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:54280)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1kLZAR-0007Ta-Jx
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 17:52:45 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
 by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08OLo3ET154391;
 Thu, 24 Sep 2020 21:52:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=WYF/qeYkttnU8RjYrk+qgjHK/vum9vcISwLimyeJyts=;
 b=JSmGnyHTEyegJsvWTeqaoACayrWMffRAT5oFOMeGzUfCVTUCrEwutViiZvNlZpV1KLW+
 eSHpCeUk+OyDg2r4Bz3uRfHjwY3kB7DjU2I4PvCv5zZKBaiPFpzFEgM6qL92qdqmtOIi
 ws3seKQ1sOURAqKxyBrlz4ceUYmTjvWLmpUgbFI4/3A3qclEupm33OzfuZZizKvjbnom
 eeDnlTkIO4Lr3IPjEyq7yM19vAu62gyBWtaoxO9Hsm6GNqeb3hW5uYArWNdFMcZQf0mA
 CllHW88H/fZn00ytpt1HI8WWt060DOXKbLwSspXOanH+5eNq3GOMOgPTrutsYNJJmhIm Fg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
 by aserp2130.oracle.com with ESMTP id 33qcpu7njy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 24 Sep 2020 21:52:41 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
 by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08OLoCR8050509;
 Thu, 24 Sep 2020 21:50:41 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
 by aserp3020.oracle.com with ESMTP id 33r28xj7ea-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 24 Sep 2020 21:50:40 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
 by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 08OLoe0T017524;
 Thu, 24 Sep 2020 21:50:40 GMT
Received: from [10.39.244.100] (/10.39.244.100)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Thu, 24 Sep 2020 14:50:39 -0700
Subject: Re: [PATCH V1 08/32] savevm: HMP command for cprinfo
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
References: <1596122076-341293-1-git-send-email-steven.sistare@oracle.com>
 <1596122076-341293-9-git-send-email-steven.sistare@oracle.com>
 <20200911172729.GN3310@work-vm>
From: Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
Message-ID: <bba478b7-5d11-7607-f205-daabd7fe1314@oracle.com>
Date: Thu, 24 Sep 2020 17:50:37 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200911172729.GN3310@work-vm>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9754
 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 mlxlogscore=999
 suspectscore=2 adultscore=0 bulkscore=0 malwarescore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009240156
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9754
 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2
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

On 9/11/2020 1:27 PM, Dr. David Alan Gilbert wrote:
> * Steve Sistare (steven.sistare@oracle.com) wrote:
>> Enable HMP access to the cprinfo QMP command.
>>
>> Usage: cprinfo
>>
>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> 
> As with Eric's comment on the qemp I don't think you need it;
> for HMP alll you really need is something that lists it in the help.

We need an architected stable interface to know that a qemu instance supports
cpr.  I don't think parsing help is good enough.  The hmp interface is great
for use in bash; easy to use and efficient.

> (Also I'd expect an info  cpr   to be a possibility that could give
> some information about it - e.g. if you've just saved/can save/loaded a
> CPR image)

Yes, that occurred to me.  We could add some flags in the future and remain
backwards compatible.  I should start now with a sub-command schema to make future 
expansion cleaner:
  "cprinfo modes" - return supported modes, eg "reboot restart"

- Steve

>> ---
>>  hmp-commands.hx       | 13 +++++++++++++
>>  include/monitor/hmp.h |  1 +
>>  monitor/hmp-cmds.c    | 10 ++++++++++
>>  3 files changed, 24 insertions(+)
>>
>> diff --git a/hmp-commands.hx b/hmp-commands.hx
>> index cb67150..7517876 100644
>> --- a/hmp-commands.hx
>> +++ b/hmp-commands.hx
>> @@ -354,6 +354,19 @@ SRST
>>  ERST
>>  
>>      {
>> +        .name       = "cprinfo",
>> +        .args_type  = "",
>> +        .params     = "",
>> +        .help       = "return list of modes supported by cprsave",
>> +        .cmd        = hmp_cprinfo,
>> +    },
>> +
>> +SRST
>> +``cprinfo`` *tag*
>> +  Return a space-delimited list of modes supported by cprsave.
>> +ERST
>> +
>> +    {
>>          .name       = "cprsave",
>>          .args_type  = "file:s,mode:s",
>>          .params     = "file 'reboot'",
>> diff --git a/include/monitor/hmp.h b/include/monitor/hmp.h
>> index 7b8cdfd..919b9a9 100644
>> --- a/include/monitor/hmp.h
>> +++ b/include/monitor/hmp.h
>> @@ -59,6 +59,7 @@ void hmp_balloon(Monitor *mon, const QDict *qdict);
>>  void hmp_loadvm(Monitor *mon, const QDict *qdict);
>>  void hmp_savevm(Monitor *mon, const QDict *qdict);
>>  void hmp_delvm(Monitor *mon, const QDict *qdict);
>> +void hmp_cprinfo(Monitor *mon, const QDict *qdict);
>>  void hmp_cprsave(Monitor *mon, const QDict *qdict);
>>  void hmp_cprload(Monitor *mon, const QDict *qdict);
>>  void hmp_migrate_cancel(Monitor *mon, const QDict *qdict);
>> diff --git a/monitor/hmp-cmds.c b/monitor/hmp-cmds.c
>> index ba95737..2f6af07 100644
>> --- a/monitor/hmp-cmds.c
>> +++ b/monitor/hmp-cmds.c
>> @@ -1139,6 +1139,16 @@ void hmp_announce_self(Monitor *mon, const QDict *qdict)
>>      qapi_free_AnnounceParameters(params);
>>  }
>>  
>> +void hmp_cprinfo(Monitor *mon, const QDict *qdict)
>> +{
>> +    Error *err = NULL;
>> +    char *res = qmp_cprinfo(&err);
>> +
>> +    monitor_printf(mon, "%s\n", res);
>> +    g_free(res);
>> +    hmp_handle_error(mon, err);
>> +}
>> +
>>  void hmp_cprsave(Monitor *mon, const QDict *qdict)
>>  {
>>      Error *err = NULL;
>> -- 
>> 1.8.3.1
>>

