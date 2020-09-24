Return-Path: <SRS0=QZTr=DB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31F35C4363D
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 21:50:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B5D5421D20
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 21:50:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="EM16B3sy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5D5421D20
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37802 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLZ80-0006qJ-Nv
	for qemu-devel@archiver.kernel.org; Thu, 24 Sep 2020 17:50:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51492)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1kLZ7Q-0006R4-T9
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 17:49:36 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:41478)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1kLZ7P-00074Y-0c
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 17:49:36 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
 by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08OLmnGG103064;
 Thu, 24 Sep 2020 21:49:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=Xc+kRrCLnTdH8Fd8qAGNcGopokRvz9kUBtSYSGihfuM=;
 b=EM16B3sy6c6hwnNIZwB2WSozAnVPyiubdXbvonQu5ztBbg+Y88cAjkdEl2OUe+esmNho
 KItTYr9jt2rbQl24R1jdQhpE+xcUtBqLoAW0+jV3qWSlT8y9b66Ret3Yiiw2/Z2pGlP9
 Nf4ATH1HFfR+t5E0zZlVbGyHOBryWHTGZmbykqs7Vkb7bNXPSN5Kv1B9L7QdImijdSn9
 Ruq85fOQZmzUxlWBT9edfiLqur10MTlKMhRMdfuH1e1uz5hhfyXH/C9Gn9Qi9cjemtYN
 eW4hNln6K/cQCkpMZWmDYZBxGmHozpMITXcS8I4lNrPdn+JFsQLl6p7OYnIUQIP4rfRQ Lg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
 by userp2120.oracle.com with ESMTP id 33ndnutsa5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 24 Sep 2020 21:49:30 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
 by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08OLVVCu056564;
 Thu, 24 Sep 2020 21:47:30 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
 by userp3030.oracle.com with ESMTP id 33nux3ffu8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 24 Sep 2020 21:47:30 +0000
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
 by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 08OLlTac016003;
 Thu, 24 Sep 2020 21:47:29 GMT
Received: from [10.39.244.100] (/10.39.244.100)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Thu, 24 Sep 2020 14:47:28 -0700
Subject: Re: [PATCH V1 15/32] vl: QEMU_START_FREEZE env var
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
References: <1596122076-341293-1-git-send-email-steven.sistare@oracle.com>
 <1596122076-341293-16-git-send-email-steven.sistare@oracle.com>
 <20200911184927.GU3310@work-vm>
From: Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
Message-ID: <104a501f-66dc-bc98-90fb-73599374e4b5@oracle.com>
Date: Thu, 24 Sep 2020 17:47:23 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200911184927.GU3310@work-vm>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9754
 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 mlxscore=0 adultscore=0
 bulkscore=0 mlxlogscore=999 phishscore=0 suspectscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009240155
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9754
 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0
 lowpriorityscore=0 phishscore=0 adultscore=0 suspectscore=0 bulkscore=0
 clxscore=1015 impostorscore=0 mlxlogscore=999 mlxscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009240156
Received-SPF: pass client-ip=156.151.31.85;
 envelope-from=steven.sistare@oracle.com; helo=userp2120.oracle.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/24 17:49:33
X-ACL-Warn: Detected OS   = Linux 3.1-3.10 [fuzzy]
X-Spam_score_int: -57
X-Spam_score: -5.8
X-Spam_bar: -----
X-Spam_report: (-5.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.199,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.214, RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H2=-0.001,
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

On 9/11/2020 2:49 PM, Dr. David Alan Gilbert wrote:
> * Steve Sistare (steven.sistare@oracle.com) wrote:
>> For qemu upgrade and restart, we will re-exec() qemu with the same argv.
>> However, qemu must start in a paused state and wait for the cprload command,
>> and the original argv might not contain the -S option.  To avoid modifying
>> argv, provide the QEMU_START_FREEZE environment variable.  If
>> QEMU_START_FREEZE is set, then set autostart=0, like the -S option.
>>
>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> 
> What's wrong with modifying the argv?
> 
> Note, also the trick -incoming defer uses;  the whole point here is that
> we start qemu with   -incoming defer     and then we can issue commands
> to modify the QEMU configuration before we actually reload state.
> 
> Note, even without CPR there might be reasons that you need to modify
> the argv; for example, imagine that since it was originally booted
> someone had hotplug added an extra CPU or RAM or a disk; the new QEMU
> must be started in a state that reflects the state in which the VM was
> at the point when it was saved, not the point at which it was started
> long ago.

The code is simpler if we do not need to parse and massage the argv, and that is 
sufficient for many use cases.  QEMU_START_FREEZE adds only a few lines of code, and 
it's nice to have that choice.

For hot plug, we rely on the management layer to know what devices were plugged
after the initial startup, and re-plug them after restart.  cprsave restarts qemu,
which creates command-line devices.  At this point the manager would send the hotplug 
commands (just like -incoming defer), then send cprload. 

Having said that, if the management layer sometimes performs live migration, and sometimes
performs cpr restart, then we need to strip out any -incoming args from argv before restart.
This can be done in the vendor-specific qemu-exec helper (patch 20).

- Steve

>> ---
>>  softmmu/vl.c | 5 +++++
>>  1 file changed, 5 insertions(+)
>>
>> diff --git a/softmmu/vl.c b/softmmu/vl.c
>> index 951994f..7016e39 100644
>> --- a/softmmu/vl.c
>> +++ b/softmmu/vl.c
>> @@ -4501,6 +4501,11 @@ void qemu_init(int argc, char **argv, char **envp)
>>          exit(0);
>>      }
>>  
>> +    if (getenv("QEMU_START_FREEZE")) {
>> +        unsetenv("QEMU_START_FREEZE");
>> +        autostart = 0;
>> +    }
>> +
>>      if (incoming) {
>>          Error *local_err = NULL;
>>          qemu_start_incoming_migration(incoming, &local_err);
>> -- 
>> 1.8.3.1
>>

