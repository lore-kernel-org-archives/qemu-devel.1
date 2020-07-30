Return-Path: <SRS0=WSdW=BJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0728C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2020 19:10:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8B10C206F5
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2020 19:10:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="b1b3N0qA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B10C206F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39932 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k1Dwm-0004uF-SS
	for qemu-devel@archiver.kernel.org; Thu, 30 Jul 2020 15:10:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49834)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1k1DwA-0004SN-35
 for qemu-devel@nongnu.org; Thu, 30 Jul 2020 15:09:54 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:54642)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1k1Dw7-0000vO-52
 for qemu-devel@nongnu.org; Thu, 30 Jul 2020 15:09:53 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
 by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06UJ85Fj131475;
 Thu, 30 Jul 2020 19:09:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=lNeTG8MyN1bBWjEs3rX3E3a4KarHPQPqtzrRuloYVbc=;
 b=b1b3N0qAOujRsAj83Cookt5KGdEAy0vQ9VLjRZQfCKhyH1UTY02CYBc9UnByc35PSatH
 HTRVg78k5un6/o8+nkxw4tkbDSSLsYXWSz6WNUX/xTDTs/pBEDtB/5c69uVb+bNSQBcv
 2e/4Uf+z3X+CCC+eZT2yyIgBcnkpt7yX2yz6ism8n12IRwFS+I5djuKm/jeuMEYVcTAR
 Y6JVGgBpvy1uAuTprCCWpJe8tXy89c0S+gV7K9SQvB9I7i8YFjksVYPmsYOiY81gTXoD
 tOMgelKCyGJBvilLqK5DKPsXb/Xl/35z23tGB1jI8p1FaTbm7ixkSK7udr8U0nPFPE0b zQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
 by aserp2120.oracle.com with ESMTP id 32hu1jng1k-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 30 Jul 2020 19:09:48 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
 by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06UJ8g24036823;
 Thu, 30 Jul 2020 19:09:47 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
 by userp3020.oracle.com with ESMTP id 32hu5xat6q-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 30 Jul 2020 19:09:47 +0000
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
 by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 06UJ9kqp010529;
 Thu, 30 Jul 2020 19:09:46 GMT
Received: from [10.39.200.60] (/10.39.200.60)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Thu, 30 Jul 2020 12:09:45 -0700
Subject: Re: [PATCH V1 00/32] Live Update
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <1596122076-341293-1-git-send-email-steven.sistare@oracle.com>
 <37635d27-b63f-f200-fa89-ccb6f7eba7f6@redhat.com>
From: Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
Message-ID: <c7fe0c2e-045c-f50c-6429-7ceaeee7bd66@oracle.com>
Date: Thu, 30 Jul 2020 15:09:43 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <37635d27-b63f-f200-fa89-ccb6f7eba7f6@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9698
 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 phishscore=0 bulkscore=0
 malwarescore=0 suspectscore=0 spamscore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007300133
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9698
 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 bulkscore=0 mlxlogscore=999
 lowpriorityscore=0 malwarescore=0 clxscore=1015 mlxscore=0 impostorscore=0
 phishscore=0 adultscore=0 suspectscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007300133
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
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Juan Quintela <quintela@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/30/2020 1:15 PM, Paolo Bonzini wrote:
> On 30/07/20 17:14, Steve Sistare wrote:
>> The first set of patches adds the cprsave and cprload commands to save and
>> restore VM state, and allow the host kernel to be updated and rebooted in
>> between.  The VM must create guest RAM in a persistent shared memory file,
>> such as /dev/dax0.0 or persistant /dev/shm PKRAM as proposed in 
>> https://lore.kernel.org/lkml/1588812129-8596-1-git-send-email-anthony.yznaga@oracle.com/
>>
>> cprsave stops the VCPUs and saves VM device state in a simple file, and
>> thus supports any type of guest image and block device.  The caller must
>> not modify the VM's block devices between cprsave and cprload.
> 
> Stupid question, what does cpr stand for?  If it is checkpoint/restore,

Checkpoint/restart.  An acronym from my HPC days.  I will spell it out.

> please spell it out.  Also, how does the functionality compare to
> xen-save-devices-state and xen-load-devices-state?

qmp_xen_save_devices_state serializes device state to a file which is loaded 
on the target for a live migration.  It performs some of the same actions
as cprsave/cprload but does not support live update-in-place.

>> cprsave and cprload support guests with vfio devices if the caller first
>> suspends the guest by issuing guest-suspend-ram to the qemu guest agent.
>> The guest drivers suspend methods flush outstanding requests and re-
>> initialize the devices, and thus there is no device state to save and
>> restore.
> 
> This probably should be allowed even for regular migration.  Can you
> generalize the code as a separate series?

Maybe.  I think that would be a distinct patch that ignores the vfio migration blocker 
if the state is suspended.  Plus a qemu agent call to do the suspend.  Needs more
thought.

- Steve

> 
> Thanks,
> 
> Paolo
> 

