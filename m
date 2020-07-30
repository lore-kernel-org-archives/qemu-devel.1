Return-Path: <SRS0=WSdW=BJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 442B0C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2020 17:53:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 118CD20809
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2020 17:53:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="nxX2fjLZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 118CD20809
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44434 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k1CkZ-0003Un-A8
	for qemu-devel@archiver.kernel.org; Thu, 30 Jul 2020 13:53:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57096)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1k1Cjg-00031U-Ss
 for qemu-devel@nongnu.org; Thu, 30 Jul 2020 13:52:56 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:37344)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1k1Cje-0006qj-Rt
 for qemu-devel@nongnu.org; Thu, 30 Jul 2020 13:52:56 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
 by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06UHlrp7195254;
 Thu, 30 Jul 2020 17:52:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=yEps1S+sqercb3u0e69yngOBcLozBuJOWIiW67otIM0=;
 b=nxX2fjLZqIjHGrJ6ksp67auJgqySmILJHpVevDTa+iTNUko9JkqP3olqVtZiCtknYoFO
 xDP8wC5J96aIcNNvgklVFfNs0xFkH1jAruUWHYKzBhpvnIjSi8XvYuk/yqdLDP3XqANy
 TxZJbB7FV5R6I4hObQ4ypTTYPvbTHHsSO6wTBjFT6WgPHWccYuhODfCqvPDtrXF8KnSu
 f2ENef41qEro98d5nq5xkqINVSxGC8vIcUxBXTBcJWk4JL0v6G3Nc+cZPbqm1LPc3xaR
 Eac1OXOufGMJbenPHeuVTt1NTj4zgHskV1D7iXUWcy9ZyTqeVmop2E3YVmZkJtNQcfTm Tw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
 by userp2120.oracle.com with ESMTP id 32hu1jw3cv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 30 Jul 2020 17:52:51 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
 by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06UHlRGN080707;
 Thu, 30 Jul 2020 17:52:50 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
 by userp3030.oracle.com with ESMTP id 32hu5x4bu6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 30 Jul 2020 17:52:50 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
 by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 06UHqngG021964;
 Thu, 30 Jul 2020 17:52:49 GMT
Received: from [10.39.200.60] (/10.39.200.60)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Thu, 30 Jul 2020 10:52:48 -0700
Subject: Re: [PATCH V1 03/32] savevm: QMP command for cprsave
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
References: <1596122076-341293-1-git-send-email-steven.sistare@oracle.com>
 <1596122076-341293-4-git-send-email-steven.sistare@oracle.com>
 <6aefdd56-b8fe-358b-6699-3f82a7fa8b1a@redhat.com>
From: Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
Message-ID: <ec60b632-4441-146b-61f3-67a48ac42697@oracle.com>
Date: Thu, 30 Jul 2020 13:52:44 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <6aefdd56-b8fe-358b-6699-3f82a7fa8b1a@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9698
 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 mlxlogscore=999 mlxscore=0
 suspectscore=0 bulkscore=0 malwarescore=0 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007300126
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9698
 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015
 mlxlogscore=999
 malwarescore=0 impostorscore=0 priorityscore=1501 spamscore=0 phishscore=0
 suspectscore=0 bulkscore=0 mlxscore=0 lowpriorityscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007300126
Received-SPF: pass client-ip=156.151.31.85;
 envelope-from=steven.sistare@oracle.com; helo=userp2120.oracle.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/30 13:52:52
X-ACL-Warn: Detected OS   = Linux 3.1-3.10 [fuzzy]
X-Spam_score_int: -53
X-Spam_score: -5.4
X-Spam_bar: -----
X-Spam_report: (-5.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
 Juan Quintela <quintela@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/30/2020 12:12 PM, Eric Blake wrote:
> On 7/30/20 10:14 AM, Steve Sistare wrote:
>> To enable live reboot, provide the cprsave QMP command and the VMS_REBOOT
>> vmstate-saving operation, which saves the state of the virtual machine in a
>> simple file.
>>
>> Syntax:
>>    {'command':'cprsave', 'data':{'file':'str', 'mode':'str'}}
>>
>>    The mode argument must be 'reboot'.  Additional modes will be defined in
>>    the future.
>>
> 
> Focusing on just the UI:
> 
>> +++ b/qapi/migration.json
>> @@ -1621,3 +1621,17 @@
>>   ##
>>   { 'event': 'UNPLUG_PRIMARY',
>>     'data': { 'device-id': 'str' } }
>> +
>> +##
>> +# @cprsave:
>> +#
>> +# Create a checkpoint of the virtual machine device state in @file.
>> +# Guest RAM and guest block device blocks are not saved.
>> +#
>> +# @file: name of checkpoint file
> 
> Since you used qemu_open() in the code, this can include a '/dev/fdset/NNN' magic name for saving into a previously-passed-in file descriptor instead of directly opening a local file name.  That's a good thing, but I don't know if it needs explicit mention in the docs.

OK, I'll look for other uses of file and fdset in the docs and see if it fits naturally here.

>> +# @mode: 'reboot' : checkpoint can be cprload'ed after a host kexec reboot.
>> +#
>> +# Since 5.0
> 
> 5.2 (you've missed 5.0 by a long shot, and even 5.1 is too late now).

Yup!  Will fix here and in the other patches, thanks.

>> +##
>> +{ 'command': 'cprsave', 'data': { 'file': 'str', 'mode': 'str' } }
> 
> 'mode' should be an enum type, rather than an open-coded string:
> 
> { 'enum': 'CprMode', 'data': ['reboot'] }
> { 'command': 'cprsave', 'data': {'file': 'str', 'mode': 'CprMode' } }

Will do, thanks for the syntax.

- Steve


