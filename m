Return-Path: <SRS0=QZTr=DB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5D21C4363D
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 21:45:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3DA0920758
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 21:45:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="dpZ/F2R8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DA0920758
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58810 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLZ3j-0003hd-Dp
	for qemu-devel@archiver.kernel.org; Thu, 24 Sep 2020 17:45:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50076)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1kLZ2V-0002qT-3v
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 17:44:31 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:35188)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1kLZ2S-0006Rv-GU
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 17:44:30 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
 by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08OLTJS3053572;
 Thu, 24 Sep 2020 21:44:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=CZHfx3iFIyf8b/VDYv9wByaEzZRnWf8Dx4bmnGNPYTQ=;
 b=dpZ/F2R8THH9TbacarTnuXuFAskkiVnee2iOxMmLxnFAPJ//QfXaTi/G0BOx2Mmx3iyK
 w/eCVTMzRlI/9MKOSzpDrgcSeozSicYC1R5P95LJy4VJHY7V5753/ti70SvxpAiVasSu
 NgZqaYEOf8tiZe3RXl+iAZBBSwBFZERcH4fD+yAaaX9HPuYLpiemQzmQzHp8rhS5+w4P
 dFtzcyBz/PxlHjmmeR3bgC+AzvsZH4qdoQorWce+ePS5oIpUY2pvsfxovU6aBOGarvZu
 LM73QxcgZqJaLk5fDC7fLwqZYzyKfICIJeVH8/xbU5GmbKaKOvAVtOfbL0hE4hK4tDPS 7Q== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
 by aserp2120.oracle.com with ESMTP id 33q5rgs1t4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 24 Sep 2020 21:44:25 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
 by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08OLUWHQ167961;
 Thu, 24 Sep 2020 21:44:25 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
 by userp3020.oracle.com with ESMTP id 33nurwtjcr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 24 Sep 2020 21:44:25 +0000
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
 by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 08OLiMb3023169;
 Thu, 24 Sep 2020 21:44:22 GMT
Received: from [10.39.244.100] (/10.39.244.100)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Thu, 24 Sep 2020 14:44:22 -0700
Subject: Re: [PATCH V1 14/32] savevm: VMS_RESTART and cprsave restart
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
References: <1596122076-341293-1-git-send-email-steven.sistare@oracle.com>
 <1596122076-341293-15-git-send-email-steven.sistare@oracle.com>
 <20200911184449.GT3310@work-vm>
From: Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
Message-ID: <62836926-686b-c70c-9225-f511156de37a@oracle.com>
Date: Thu, 24 Sep 2020 17:44:20 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200911184449.GT3310@work-vm>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9754
 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 malwarescore=0
 phishscore=0 mlxlogscore=999 bulkscore=0 mlxscore=0 suspectscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009240155
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9754
 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 impostorscore=0
 clxscore=1015 suspectscore=0 phishscore=0 malwarescore=0
 priorityscore=1501 mlxlogscore=999 adultscore=0 bulkscore=0 mlxscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009240155
Received-SPF: pass client-ip=141.146.126.78;
 envelope-from=steven.sistare@oracle.com; helo=aserp2120.oracle.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/24 16:42:31
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

On 9/11/2020 2:44 PM, Dr. David Alan Gilbert wrote:
> * Steve Sistare (steven.sistare@oracle.com) wrote:
>> Add the VMS_RESTART variant of vmstate, for use when upgrading qemu in place
>> on the same host without a reboot.  Invoke it using:
>>   cprsave <filename> restart
>>
>> VMS_RESTART supports guest ram mapped by private anonymous memory, versus
>> VMS_REBOOT which requires that guest ram be mapped by persistent shared
>> memory.  Subsequent patches complete its implementation.
>>
>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> 
> You should find with the enum like Eric suggests this mostly disappears;
> but also you might want to put it after the patches that implement it.

Sure.  If this gets too small I will add it to the implementation patch.
I cannot move this after the impl, because the impl has additional uses of VMS_RESTART.

- Steve

>> ---
>>  hmp-commands.hx             | 4 +++-
>>  include/migration/vmstate.h | 1 +
>>  migration/savevm.c          | 4 +++-
>>  monitor/qmp-cmds.c          | 2 +-
>>  qapi/migration.json         | 1 +
>>  5 files changed, 9 insertions(+), 3 deletions(-)
>>
>> diff --git a/hmp-commands.hx b/hmp-commands.hx
>> index 7517876..11a2089 100644
>> --- a/hmp-commands.hx
>> +++ b/hmp-commands.hx
>> @@ -369,7 +369,7 @@ ERST
>>      {
>>          .name       = "cprsave",
>>          .args_type  = "file:s,mode:s",
>> -        .params     = "file 'reboot'",
>> +        .params     = "file 'restart'|'reboot'",
>>          .help       = "create a checkpoint of the VM in file",
>>          .cmd        = hmp_cprsave,
>>      },
>> @@ -380,6 +380,8 @@ SRST
>>    in *file*.
>>    If *mode* is 'reboot', the checkpoint can be cprload'ed after a host kexec
>>    reboot.
>> +  If *mode* is 'restart', the checkpoint can be cprload'ed after restarting
>> +  qemu.
>>    exec() /usr/bin/qemu-exec if it exists, else exec /usr/bin/qemu-system-x86_64,
>>    passing all the original command line arguments.  The VCPUs remain paused.
>>  ERST
>> diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
>> index c58551a..8239b84 100644
>> --- a/include/migration/vmstate.h
>> +++ b/include/migration/vmstate.h
>> @@ -162,6 +162,7 @@ typedef enum {
>>      VMS_MIGRATE  = (1U << 1),
>>      VMS_SNAPSHOT = (1U << 2),
>>      VMS_REBOOT   = (1U << 3),
>> +    VMS_RESTART  = (1U << 4),
>>      VMS_MODE_ALL = ~0U
>>  } VMStateMode;
>>  
>> diff --git a/migration/savevm.c b/migration/savevm.c
>> index 00f493b..38cc63a 100644
>> --- a/migration/savevm.c
>> +++ b/migration/savevm.c
>> @@ -2708,6 +2708,8 @@ void save_cpr_snapshot(const char *file, const char *mode, Error **errp)
>>  
>>      if (!strcmp(mode, "reboot")) {
>>          op = VMS_REBOOT;
>> +    } else if (!strcmp(mode, "restart")) {
>> +        op = VMS_RESTART;
>>      } else {
>>          error_setg(errp, "cprsave: bad mode %s", mode);
>>          return;
>> @@ -2973,7 +2975,7 @@ void load_cpr_snapshot(const char *file, Error **errp)
>>          return;
>>      }
>>  
>> -    ret = qemu_loadvm_state(f, VMS_REBOOT);
>> +    ret = qemu_loadvm_state(f, VMS_REBOOT | VMS_RESTART);
>>      qemu_fclose(f);
>>      if (ret < 0) {
>>          error_setg(errp, "Error %d while loading VM state", ret);
>> diff --git a/monitor/qmp-cmds.c b/monitor/qmp-cmds.c
>> index 8c400e6..8a74c6e 100644
>> --- a/monitor/qmp-cmds.c
>> +++ b/monitor/qmp-cmds.c
>> @@ -164,7 +164,7 @@ void qmp_cont(Error **errp)
>>  
>>  char *qmp_cprinfo(Error **errp)
>>  {
>> -    return g_strdup("reboot");
>> +    return g_strdup("reboot restart");
>>  }
>>  
>>  void qmp_cprsave(const char *file, const char *mode, Error **errp)
>> diff --git a/qapi/migration.json b/qapi/migration.json
>> index 8190b16..d22992b 100644
>> --- a/qapi/migration.json
>> +++ b/qapi/migration.json
>> @@ -1639,6 +1639,7 @@
>>  #
>>  # @file: name of checkpoint file
>>  # @mode: 'reboot' : checkpoint can be cprload'ed after a host kexec reboot.
>> +#        'restart': checkpoint can be cprload'ed after restarting qemu.
>>  #
>>  # Since 5.0
>>  ##
>> -- 
>> 1.8.3.1
>>

