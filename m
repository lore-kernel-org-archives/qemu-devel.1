Return-Path: <SRS0=FShu=BK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35FE1C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jul 2020 15:19:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F21B721744
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jul 2020 15:19:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="JKBJXx8H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F21B721744
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49910 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k1Wog-0000eP-7O
	for qemu-devel@archiver.kernel.org; Fri, 31 Jul 2020 11:19:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35918)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1k1Wo2-0000CO-5q
 for qemu-devel@nongnu.org; Fri, 31 Jul 2020 11:18:46 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:55042)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1k1Wnz-0005Xt-V3
 for qemu-devel@nongnu.org; Fri, 31 Jul 2020 11:18:45 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
 by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06VFHmdH153848;
 Fri, 31 Jul 2020 15:18:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=Q4Lqlf5IJ+YYmQCAySJrwOqudJC12bFRjs/yFKXVDH4=;
 b=JKBJXx8Hp5TjS1KFBxSjbRxcjFhaV5P1BuoKMwjrYJ1H2j7kUgv94VJ6T2GoZpWYbyPj
 Ja6DiydRqzAoBH2yIH3gm+VRRyv7nCYYU89TtpMqC5FhDxOFRJAyruCb+xpqtFR/k/+Y
 z/EjCOIQRMSU6ktB7tJ68dempx8YprdsTXe4G3zipzqkcn+EyaP+7u0mfbpvpQPICfnd
 XBR2uUgtrCB2Gp+wdSTORuNO1XC6TA9RlgsZz2t+7RvLSAqUEOOYedbVgWzpKlSMLBQN
 +QhU9qRmgZ8XoS0ulN3n+e5OY2xpFTYrSVg1MjXtxuUWWQMyMvbabm/bCPz7l3BY0F8i kw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
 by userp2120.oracle.com with ESMTP id 32mf701xxy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 31 Jul 2020 15:18:40 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
 by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06VFHU2q171952;
 Fri, 31 Jul 2020 15:18:40 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
 by userp3030.oracle.com with ESMTP id 32hu5yw7wb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 31 Jul 2020 15:18:40 +0000
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
 by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 06VFIcwL019069;
 Fri, 31 Jul 2020 15:18:38 GMT
Received: from [10.39.235.87] (/10.39.235.87)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Fri, 31 Jul 2020 08:18:38 -0700
Subject: Re: [PATCH V1 12/32] vl: pause option
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
References: <1596122076-341293-1-git-send-email-steven.sistare@oracle.com>
 <1596122076-341293-13-git-send-email-steven.sistare@oracle.com>
 <1dea1698-f8be-519d-e00c-d163b08dca65@redhat.com>
 <36036b5f-4e63-4287-a8e6-499732f54689@oracle.com>
 <20200731100742.GA3641941@redhat.com>
From: Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
Message-ID: <0b41c5b4-8d06-be87-d814-f7f39b43f2d7@oracle.com>
Date: Fri, 31 Jul 2020 11:18:35 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200731100742.GA3641941@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9699
 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 mlxlogscore=999 mlxscore=0
 suspectscore=0 bulkscore=0 malwarescore=0 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007310114
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9699
 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 bulkscore=0 suspectscore=0
 spamscore=0 impostorscore=0 clxscore=1015 phishscore=0 priorityscore=1501
 adultscore=0 mlxlogscore=999 malwarescore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007310114
Received-SPF: pass client-ip=156.151.31.85;
 envelope-from=steven.sistare@oracle.com; helo=userp2120.oracle.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/31 11:18:42
X-ACL-Warn: Detected OS   = Linux 3.1-3.10 [fuzzy]
X-Spam_score_int: -53
X-Spam_score: -5.4
X-Spam_bar: -----
X-Spam_report: (-5.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Juan Quintela <quintela@redhat.com>,
 qemu-devel@nongnu.org, "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/31/2020 6:07 AM, Daniel P. Berrangé wrote:
> On Thu, Jul 30, 2020 at 02:11:19PM -0400, Steven Sistare wrote:
>> On 7/30/2020 12:20 PM, Eric Blake wrote:
>>> On 7/30/20 10:14 AM, Steve Sistare wrote:
>>>> Provide the -pause command-line parameter and the QEMU_PAUSE environment
>>>> variable to briefly pause QEMU in main and allow a developer to attach gdb.
>>>> Useful when the developer does not invoke QEMU directly, such as when using
>>>> libvirt.
>>>
>>> How would you set this option with libvirt?
>>
>> Add -pause in the qemu args in the xml.
>>  
>>> It feels like you are trying to reinvent something that is already well-documented:
>>>
>>> https://www.berrange.com/posts/2011/10/12/debugging-early-startup-of-kvm-with-gdb-when-launched-by-libvirtd/
>>
>> Too many steps to reach BINGO for my taste.  Easier is better.  Also, in our shop we start qemu 
>> in other ways, such as via services.
> 
> A "sleep" is a pretty crude & unreliable way to get into debugging
> though. It is racy for a start, but also QEMU has a bunch of stuff
> that runs via ELF constructors before main() even starts.
> 
> So I feel like the thing that starts QEMU is better placed to provide
> a way in for debugging.
> 
> eg the service launcher can send SIGSTOP to the child process immediately
> before the execve(qemu) call.
> 
> Now user can attach with the debugger, allow execution to continue,
> and has ability to debug *everything* right from the ELF constructors
> onwards into main() and all that follows.
> 
> Regards,
> Daniel

That is a nice solution for the launchers we can modify.
We could use your idea in place of the sleep in main,
    kill(getpid(), SIGSTOP);

Not quite as good as being able to debug the elf constructors, but still helpful.

- Steve

