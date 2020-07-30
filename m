Return-Path: <SRS0=WSdW=BJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53C6DC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2020 18:12:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D636120829
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2020 18:12:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="C3Jjikl1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D636120829
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39756 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k1D2j-0005xU-Of
	for qemu-devel@archiver.kernel.org; Thu, 30 Jul 2020 14:12:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34162)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1k1D1f-0005Ul-UV
 for qemu-devel@nongnu.org; Thu, 30 Jul 2020 14:11:31 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:40064)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1k1D1c-0001G3-Gb
 for qemu-devel@nongnu.org; Thu, 30 Jul 2020 14:11:31 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
 by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06UI1jjQ022873;
 Thu, 30 Jul 2020 18:11:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=zj0XjZTp7iDHc01Xsu2COXfAtKYQJjEp7XxnpyyhcoQ=;
 b=C3Jjikl1iqDYRMycN+dsbJCegXbTUAAOsFj9IIypUswLep8z0epDN/2+5fczcLbAZM71
 HSHZK6sO5Gj2dnAuwrobpegWzJRDeY9DoIbfIcsIbf79Wlr68kzwnDQ5VvZjPkm4vUUv
 FQFN05fR78hKvkmTjbl10y/6XU7qJD/ezKy19i1C4Ac4uXhhDy+wUqI5630Syt1Ysn4u
 hoetpFZXdZAU/vleYm0Zql456gEJJEJmmVbhOvdNL+rfbxxzyirCDQKYdL4sDl8dGlZr
 GukH+qfwoh/AxGigMoZgdk9RvkDSRwYGdjZpeOqHZL7TH6IfisQYcsjBqhxsAtg/EnjW Bg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
 by aserp2120.oracle.com with ESMTP id 32hu1jn6ws-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 30 Jul 2020 18:11:25 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
 by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06UI9SLJ163177;
 Thu, 30 Jul 2020 18:11:25 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
 by userp3030.oracle.com with ESMTP id 32hu5x53fh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 30 Jul 2020 18:11:25 +0000
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
 by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 06UIBNn6026930;
 Thu, 30 Jul 2020 18:11:23 GMT
Received: from [10.39.200.60] (/10.39.200.60)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Thu, 30 Jul 2020 11:11:22 -0700
Subject: Re: [PATCH V1 12/32] vl: pause option
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
References: <1596122076-341293-1-git-send-email-steven.sistare@oracle.com>
 <1596122076-341293-13-git-send-email-steven.sistare@oracle.com>
 <1dea1698-f8be-519d-e00c-d163b08dca65@redhat.com>
From: Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
Message-ID: <36036b5f-4e63-4287-a8e6-499732f54689@oracle.com>
Date: Thu, 30 Jul 2020 14:11:19 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1dea1698-f8be-519d-e00c-d163b08dca65@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9698
 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 mlxlogscore=999 mlxscore=0
 suspectscore=0 bulkscore=0 malwarescore=0 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007300129
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9698
 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 bulkscore=0 mlxlogscore=999
 lowpriorityscore=0 malwarescore=0 clxscore=1015 mlxscore=0 impostorscore=0
 phishscore=0 adultscore=0 suspectscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007300128
Received-SPF: pass client-ip=141.146.126.78;
 envelope-from=steven.sistare@oracle.com; helo=aserp2120.oracle.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/30 14:11:27
X-ACL-Warn: Detected OS   = Linux 3.1-3.10 [fuzzy]
X-Spam_score_int: -63
X-Spam_score: -6.4
X-Spam_bar: ------
X-Spam_report: (-6.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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

On 7/30/2020 12:20 PM, Eric Blake wrote:
> On 7/30/20 10:14 AM, Steve Sistare wrote:
>> Provide the -pause command-line parameter and the QEMU_PAUSE environment
>> variable to briefly pause QEMU in main and allow a developer to attach gdb.
>> Useful when the developer does not invoke QEMU directly, such as when using
>> libvirt.
> 
> How would you set this option with libvirt?

Add -pause in the qemu args in the xml.
 
> It feels like you are trying to reinvent something that is already well-documented:
> 
> https://www.berrange.com/posts/2011/10/12/debugging-early-startup-of-kvm-with-gdb-when-launched-by-libvirtd/

Too many steps to reach BINGO for my taste.  Easier is better.  Also, in our shop we start qemu 
in other ways, such as via services.

These new hooks helped me and my colleagues, and I hope others may also find them useful, 
but if not then we drop them.

>> Usage:
>>    qemu -pause <seconds>
>>    or
>>    export QEMU_PAUSE=<seconds>
>>
>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>> ---
>>   qemu-options.hx |  9 +++++++++
>>   softmmu/vl.c    | 15 ++++++++++++++-
>>   2 files changed, 23 insertions(+), 1 deletion(-)
> 
>> @@ -3204,6 +3211,12 @@ void qemu_init(int argc, char **argv, char **envp)
>>               case QEMU_OPTION_gdb:
>>                   add_device_config(DEV_GDB, optarg);
>>                   break;
>> +            case QEMU_OPTION_pause:
>> +                seconds = atoi(optarg);
> 
> atoi() cannot detect overflow.  You should never use it in robust parsing of untrusted input.

OK.

- Steve




