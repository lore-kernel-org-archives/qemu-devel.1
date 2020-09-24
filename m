Return-Path: <SRS0=QZTr=DB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7999EC4727E
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 21:53:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E3E682399A
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 21:53:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="WQvA7xYw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3E682399A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45394 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLZBV-0001ey-27
	for qemu-devel@archiver.kernel.org; Thu, 24 Sep 2020 17:53:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51954)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1kLZ9r-0000Ey-Q2
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 17:52:07 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:53800)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1kLZ9q-0007QW-0A
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 17:52:07 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
 by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08OLnmGA154113;
 Thu, 24 Sep 2020 21:52:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=NbjZmyrtbz1QL62ZclUQdx0IqNOrya1/nx3hUxCVGw0=;
 b=WQvA7xYwpJeDaCLBqofuy0POo1fvJumqxCEdVbRhsDBBzXe35MQ8/ZlS8yi6enlevU4b
 jY+BsKymPkCoAiZX0W0f91j+5stTBVrwP67J+mDs0nwJPNOD3XIrP3AJ+PaQxhY1z2T+
 bboAE7Wo/BJizSu4Mg+CLnD+GR7V5tFxQLjNErX3FOouZdJ+OHbUwzcxd+7WFiOwb2QV
 9KHeUqKJvQYsG+NwlaDcta1PEd+KiTkc7wtQ/8VRe8+H/H7MpIH+Yy13sZIUlUCBPR1C
 oCIjs3+uo0P3KPDaXvveYLTzngyU2WSxreoBwhIbtEb+00qEEJg5WnU8vrkXR9lhzZa2 7g== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
 by aserp2130.oracle.com with ESMTP id 33qcpu7nga-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 24 Sep 2020 21:52:03 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
 by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08OLpTBs131105;
 Thu, 24 Sep 2020 21:52:02 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
 by userp3030.oracle.com with ESMTP id 33nux3fk0e-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 24 Sep 2020 21:52:02 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
 by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 08OLq1Go020624;
 Thu, 24 Sep 2020 21:52:01 GMT
Received: from [10.39.244.100] (/10.39.244.100)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Thu, 24 Sep 2020 14:52:01 -0700
Subject: Re: [PATCH V1 13/32] gdbstub: gdb support for suspended state
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, alex.bennee@linaro.org,
 philmd@redhat.com
References: <1596122076-341293-1-git-send-email-steven.sistare@oracle.com>
 <1596122076-341293-14-git-send-email-steven.sistare@oracle.com>
 <20200911184118.GS3310@work-vm>
From: Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
Message-ID: <2ffc8aae-5787-0109-91ef-6d834a611f14@oracle.com>
Date: Thu, 24 Sep 2020 17:51:58 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200911184118.GS3310@work-vm>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9754
 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 mlxscore=0 adultscore=0
 bulkscore=0 mlxlogscore=999 phishscore=0 suspectscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009240156
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
 Stefan Hajnoczi <stefanha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org,
 Markus Armbruster <armbru@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/11/2020 2:41 PM, Dr. David Alan Gilbert wrote:
> * Steve Sistare (steven.sistare@oracle.com) wrote:
>> Modify the gdb server so a continue command appears to resume execution
>> when in RUN_STATE_SUSPENDED.  Do not print the next gdb prompt, but do not
>> actually resume instruction fetch.  While in this "fake" running mode, a
>> ctrl-C returns the user to the gdb prompt.
>>
>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> 
> This patch doesn't feel like it lives here; it seems to be a separate
> gdbstub patch and it'll get noticed/merged quicker just sent on it's
> own.

OK, I will submit it separately.

- Steve

>>  gdbstub.c | 11 +++++++++--
>>  1 file changed, 9 insertions(+), 2 deletions(-)
>>
>> diff --git a/gdbstub.c b/gdbstub.c
>> index f3a318c..2f0d9ff 100644
>> --- a/gdbstub.c
>> +++ b/gdbstub.c
>> @@ -461,7 +461,9 @@ static inline void gdb_continue(void)
>>  #else
>>      if (!runstate_needs_reset()) {
>>          trace_gdbstub_op_continue();
>> -        vm_start();
>> +        if (!runstate_check(RUN_STATE_SUSPENDED)) {
>> +            vm_start();
>> +        }
>>      }
>>  #endif
>>  }
>> @@ -490,7 +492,7 @@ static int gdb_continue_partial(char *newstates)
>>      int flag = 0;
>>  
>>      if (!runstate_needs_reset()) {
>> -        if (vm_prepare_start()) {
>> +        if (!runstate_check(RUN_STATE_SUSPENDED) && vm_prepare_start()) {
>>              return 0;
>>          }
>>  
>> @@ -2835,6 +2837,9 @@ static void gdb_read_byte(uint8_t ch)
>>          /* when the CPU is running, we cannot do anything except stop
>>             it when receiving a char */
>>          vm_stop(RUN_STATE_PAUSED);
>> +    } else if (runstate_check(RUN_STATE_SUSPENDED) && ch == 3) {
>> +        /* Received ctrl-c from gdb */
>> +        gdb_vm_state_change(0, 0, RUN_STATE_PAUSED);
>>      } else
>>  #endif
>>      {
>> @@ -3282,6 +3287,8 @@ static void gdb_sigterm_handler(int signal)
>>  {
>>      if (runstate_is_running()) {
>>          vm_stop(RUN_STATE_PAUSED);
>> +    } else if (runstate_check(RUN_STATE_SUSPENDED)) {
>> +        gdb_vm_state_change(0, 0, RUN_STATE_PAUSED);
>>      }
>>  }
>>  #endif
>> -- 
>> 1.8.3.1
>>

