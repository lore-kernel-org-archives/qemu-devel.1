Return-Path: <SRS0=QZTr=DB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DBE6C4363D
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 20:44:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9EF3E21D7F
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 20:44:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="CLKWv3lZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9EF3E21D7F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41518 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLY61-0003VS-N9
	for qemu-devel@archiver.kernel.org; Thu, 24 Sep 2020 16:44:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37890)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1kLY4c-0002WB-UJ
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 16:42:40 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:40816)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1kLY4a-0007Sn-7g
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 16:42:38 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
 by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08OKdMso141605;
 Thu, 24 Sep 2020 20:42:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=PRfuYakB0fWApPGo/AgAWPmvBPJQyHklWcGUA/0lSIo=;
 b=CLKWv3lZ78MRG2N48Id/W90q8AzhhmMOvvBUoeXveStsBbs8BPTWejf/CVBqB+ycOOxl
 1hi2gRCPJ9HgDidyQvIA3egy80U/RJkdBmvBCII7rLbBwKbOE18GiTaONpe3JIyd5Rao
 0jWjwwmbO/75iwprJJzYdIu6wA8ApmXxcKtoJrYYZS3YTKL+kbsWV/fxGWcbyj7RPyfG
 wBJza0sdbIkoVB9uJyIoNt4x7Vg8yV61SgmvY9px16n9Qkw/9MyRMTFe9OLxgwR3BbNb
 piOoFyMEpXxd+MKFXrOcjGOij0qQoKW2klIs6wZ/L0AV8gopV0cDUloTpQh7PmsPoKEt ew== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
 by aserp2120.oracle.com with ESMTP id 33q5rgrt4f-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 24 Sep 2020 20:42:30 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
 by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08OKfUJi047070;
 Thu, 24 Sep 2020 20:42:29 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
 by userp3030.oracle.com with ESMTP id 33nux3djuc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 24 Sep 2020 20:42:29 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
 by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 08OKgRoF015092;
 Thu, 24 Sep 2020 20:42:27 GMT
Received: from [10.39.244.100] (/10.39.244.100)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Thu, 24 Sep 2020 13:42:27 -0700
Subject: Re: [PATCH V1 11/32] cpu: disable ticks when suspended
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
References: <1596122076-341293-1-git-send-email-steven.sistare@oracle.com>
 <1596122076-341293-12-git-send-email-steven.sistare@oracle.com>
 <20200911175318.GQ3310@work-vm>
From: Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
Message-ID: <9b3fa2f8-2457-6c67-dd6e-c861cbd6f309@oracle.com>
Date: Thu, 24 Sep 2020 16:42:25 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200911175318.GQ3310@work-vm>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9754
 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 mlxscore=0 adultscore=0
 bulkscore=0 mlxlogscore=999 phishscore=0 suspectscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009240151
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9754
 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 impostorscore=0
 clxscore=1011 suspectscore=0 phishscore=0 malwarescore=0
 priorityscore=1501 mlxlogscore=999 adultscore=0 bulkscore=0 mlxscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009240151
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

On 9/11/2020 1:53 PM, Dr. David Alan Gilbert wrote:
> * Steve Sistare (steven.sistare@oracle.com) wrote:
>> After cprload, the guest console misbehaves.  You must type 8 characters
>> before any are echoed to the terminal.  Qemu was not sending interrupts
>> to the guest because the QEMU_CLOCK_VIRTUAL timers_state.cpu_clock_offset
>> was bad.  The offset is usually updated at cprsave time by the path
>>
>>   save_cpr_snapshot()
>>     vm_stop()
>>       do_vm_stop()
>>         if (runstate_is_running())
>>           cpu_disable_ticks();
>>             timers_state.cpu_clock_offset = cpu_get_clock_locked();
>>
>> However, if the guest is in RUN_STATE_SUSPENDED, then cpu_disable_ticks is
>> not called.  Further, the earlier transition to suspended in
>> qemu_system_suspend did not disable ticks.  To fix, call cpu_disable_ticks
>> from save_cpr_snapshot.
>>
>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> 
> Are you saying this is really a more generic bug with migrating when
> suspended and we should fix this anyway?

Yes.  Or when suspended and calling save_vmstate(), or qmp_xen_save_devices_state().
Each of those functions needs the same fix unless someone identifies a more
centralized way in the state transition logic to disable ticks.

- Steve

>> ---
>>  migration/savevm.c | 5 +++++
>>  1 file changed, 5 insertions(+)
>>
>> diff --git a/migration/savevm.c b/migration/savevm.c
>> index f101039..00f493b 100644
>> --- a/migration/savevm.c
>> +++ b/migration/savevm.c
>> @@ -2729,6 +2729,11 @@ void save_cpr_snapshot(const char *file, const char *mode, Error **errp)
>>          return;
>>      }
>>  
>> +    /* Update timers_state before saving.  Suspend did not so do. */
>> +    if (runstate_check(RUN_STATE_SUSPENDED)) {
>> +        cpu_disable_ticks();
>> +    }
>> +
>>      vm_stop(RUN_STATE_SAVE_VM);
>>  
>>      ret = qemu_savevm_state(f, op, errp);
>> -- 
>> 1.8.3.1
>>

