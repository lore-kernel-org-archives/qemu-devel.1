Return-Path: <SRS0=MAm8=C6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6822FC43464
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 12:36:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BBEE320756
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 12:36:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="aNd00OG/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBEE320756
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33878 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKL3O-0006Iu-SX
	for qemu-devel@archiver.kernel.org; Mon, 21 Sep 2020 08:36:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57886)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dovmurik@linux.vnet.ibm.com>)
 id 1kKKwJ-0007U8-F9
 for qemu-devel@nongnu.org; Mon, 21 Sep 2020 08:29:03 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:36336)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dovmurik@linux.vnet.ibm.com>)
 id 1kKKwH-0000R7-6W
 for qemu-devel@nongnu.org; Mon, 21 Sep 2020 08:29:03 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 08LCDh6K013468; Mon, 21 Sep 2020 08:28:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=+x9X6bupAgc2IksDqVNyfDddO1DhtBLWIkEqfjhE/vw=;
 b=aNd00OG/5hBUvZyUfB6TX0QATFwqHmhOlV7Wg0jGRMbK5cJ68ZMBiRKEDFFfS9ESL7lF
 cHXGCUI/nzMUbYf3a+m5T0DYWqpFDszG31PJUsIS64fbXgLiOCamQbnedXlGlU3kW8p4
 wpznej3gTWsI7fLzpVrk/BPtIBIsVOqjUr0xHcklWjy1SEwuFZegJPhecsweKg9ciyEc
 nM4PyaSDxgGak/ybld11VSQ0Nbxt3w9KXSwMBSj/bfZ7qfh0rifOKmVmSDMGiZhrV25T
 ycqmmzx2aTmakFYwJfEGUZYICy2Fja+/xUztUs5wli7z8+AEaDMxTmRtB+gd2IC0JP1Q mA== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 33pv080du2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 21 Sep 2020 08:28:57 -0400
Received: from m0098394.ppops.net (m0098394.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 08LCDgdn013155;
 Mon, 21 Sep 2020 08:28:56 -0400
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com
 [149.81.74.106])
 by mx0a-001b2d01.pphosted.com with ESMTP id 33pv080dsw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 21 Sep 2020 08:28:56 -0400
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
 by ppma04fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 08LCRSC7031630;
 Mon, 21 Sep 2020 12:28:54 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com
 (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
 by ppma04fra.de.ibm.com with ESMTP id 33n9m7s1p1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 21 Sep 2020 12:28:54 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com
 [9.149.105.232])
 by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP
 id 08LCSoLr16777692
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 21 Sep 2020 12:28:50 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D519C52052;
 Mon, 21 Sep 2020 12:28:51 +0000 (GMT)
Received: from [9.65.232.226] (unknown [9.65.232.226])
 by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 356E85204E;
 Mon, 21 Sep 2020 12:28:49 +0000 (GMT)
Subject: Re: [PATCH] migration: Truncate state file in xen-save-devices-state
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, sstabellini@kernel.org,
 anthony.perard@citrix.com
References: <20200921094830.114028-1-dovmurik@linux.vnet.ibm.com>
 <20200921111723.GF3221@work-vm>
From: Dov Murik <dovmurik@linux.vnet.ibm.com>
Message-ID: <f1ae6a96-322d-faaf-7ab8-1481cffa7aa7@linux.vnet.ibm.com>
Date: Mon, 21 Sep 2020 15:28:48 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.2.2
MIME-Version: 1.0
In-Reply-To: <20200921111723.GF3221@work-vm>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235, 18.0.687
 definitions=2020-09-21_03:2020-09-21,
 2020-09-21 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 phishscore=0
 impostorscore=0 mlxlogscore=999 lowpriorityscore=0 adultscore=0
 suspectscore=0 malwarescore=0 spamscore=0 mlxscore=0 bulkscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009210089
Received-SPF: none client-ip=148.163.156.1;
 envelope-from=dovmurik@linux.vnet.ibm.com; helo=mx0a-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/21 08:28:59
X-ACL-Warn: Detected OS   = Linux 3.x [generic] [fuzzy]
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
Cc: qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 21/09/2020 14:17, Dr. David Alan Gilbert wrote:
> * Dov Murik (dovmurik@linux.vnet.ibm.com) wrote:
>> When running the xen-save-devices-state QMP command, if the filename
>> already exists it will be truncated before dumping the devices' state
>> into it.
>>
>> Signed-off-by: Dov Murik <dovmurik@linux.vnet.ibm.com>
>> ---
> 
> OK, that looks fine to me, so:
> 
> Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> 
>>
>> Note that I found the above issue while trying to debug
>> xen-load-devices-state which simply fails (prints "Configuration section
>> missing" to stderr) directly after xen-save-devices-state (in the same
>> VM).  I wonder if I should file a bug report as-is or investigate some
>> more.  Advice welcome.
> 
> I don't try the xen-* commands normally; I've cc'ing in Stefano and
> Anthony.

Thanks Dave.  Just to be clear, I'm running this without Xen at all; but
these commands seem to work OK for dumping/restoring guest's devices
state (without RAM) -- if I modify the code to circumvent the mentioned
problem.

Dov

> 
> Dave
> 
>>
>> -Dov
>>
>> ---
>>   migration/savevm.c | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/migration/savevm.c b/migration/savevm.c
>> index 304d98ff78..e1b26672cc 100644
>> --- a/migration/savevm.c
>> +++ b/migration/savevm.c
>> @@ -2803,7 +2803,8 @@ void qmp_xen_save_devices_state(const char *filename, bool has_live, bool live,
>>       vm_stop(RUN_STATE_SAVE_VM);
>>       global_state_store_running();
>>   
>> -    ioc = qio_channel_file_new_path(filename, O_WRONLY | O_CREAT, 0660, errp);
>> +    ioc = qio_channel_file_new_path(filename, O_WRONLY | O_CREAT | O_TRUNC,
>> +                                    0660, errp);
>>       if (!ioc) {
>>           goto the_end;
>>       }
>> -- 
>> 2.20.1
>>

