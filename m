Return-Path: <SRS0=FShu=BK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3B98C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jul 2020 19:23:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 83FB7208E4
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jul 2020 19:23:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="hDreJXB0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83FB7208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36402 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k1ad3-0004eI-RT
	for qemu-devel@archiver.kernel.org; Fri, 31 Jul 2020 15:23:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40926)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1k1acV-0004Dq-GA
 for qemu-devel@nongnu.org; Fri, 31 Jul 2020 15:23:07 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:40946)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1k1acT-0004Cx-7B
 for qemu-devel@nongnu.org; Fri, 31 Jul 2020 15:23:06 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
 by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06VJH4ZB026130;
 Fri, 31 Jul 2020 19:23:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=0WKAks+sq1FJ3A9M0ghgfCawXcMHWyyOpB9C84TN2So=;
 b=hDreJXB0qtMnOEQKzmUyxw1DydTRjM7E6rnj1TROx7Od6VUP3MNLN4ZsP/njqeuoeFBA
 cmWggB+qJZF1M/+yTc0q3AthUTZpzXln8WntJ1FLKooYx58JlZ3xyr2ri3kQTQJxGD5n
 jRCXOQmfXCh9WVoHySOSER7OUNffbBUDbyBPTF6Ui0ZbuyRNFxCgi1Uoh+fIFHaEuBhy
 4trM4JfD+Nfih4GSeuTRTOe5uMH24AfwNyBcLAwTxNLqi7H1ZX0deI60Cp51hvtCVTHq
 8IDULp001+XIwExHsmVGc/XMP32EduIQwS6ZyDcNlsopFEPtAP9XGSA66dVHeqA32vB2 Hw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
 by userp2130.oracle.com with ESMTP id 32hu1jtrh1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 31 Jul 2020 19:23:01 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
 by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06VJHVB3111630;
 Fri, 31 Jul 2020 19:23:01 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
 by userp3030.oracle.com with ESMTP id 32hu6096us-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 31 Jul 2020 19:23:01 +0000
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
 by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 06VJMw84011130;
 Fri, 31 Jul 2020 19:22:58 GMT
Received: from [10.39.235.87] (/10.39.235.87)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Fri, 31 Jul 2020 12:22:57 -0700
Subject: Re: [PATCH V1 00/32] Live Update
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <1596122076-341293-1-git-send-email-steven.sistare@oracle.com>
 <37635d27-b63f-f200-fa89-ccb6f7eba7f6@redhat.com>
 <c7fe0c2e-045c-f50c-6429-7ceaeee7bd66@oracle.com>
 <5fbcfbcc-0908-4957-d15b-4ba4494dde85@redhat.com>
From: Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
Message-ID: <fac560b8-7de0-15ee-824d-4e9261424555@oracle.com>
Date: Fri, 31 Jul 2020 15:22:54 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <5fbcfbcc-0908-4957-d15b-4ba4494dde85@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9699
 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 mlxlogscore=999 mlxscore=0
 suspectscore=0 bulkscore=0 malwarescore=0 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007310142
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9699
 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 clxscore=1015
 malwarescore=0 spamscore=0 suspectscore=0 bulkscore=0 priorityscore=1501
 phishscore=0 mlxlogscore=999 lowpriorityscore=0 impostorscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007310142
Received-SPF: pass client-ip=156.151.31.86;
 envelope-from=steven.sistare@oracle.com; helo=userp2130.oracle.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/31 12:51:59
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

On 7/30/2020 5:39 PM, Paolo Bonzini wrote:
> On 30/07/20 21:09, Steven Sistare wrote:
>>> please spell it out.  Also, how does the functionality compare to
>>> xen-save-devices-state and xen-load-devices-state?
>>
>> qmp_xen_save_devices_state serializes device state to a file which is loaded 
>> on the target for a live migration.  It performs some of the same actions
>> as cprsave/cprload but does not support live update-in-place.
> 
> So it is a subset, can code be reused across both?  

They use common subroutines, but their bodies check different conditions, so I
don't think merging would be an improvement.  We do provide a new helper 
qf_file_open() which could replace a handful of lines in both qmp_xen_save_devices_state 
and qmp_xen_load_devices_state.

> Also, live migration
> across versions is supported, so can you describe the special
> update-in-place support more precisely?  I am confused about the use
> cases, which require (or try) to keep file descriptors across re-exec,
> which are for kexec, and so on.

Sure. The first use case allows you to kexec reboot the host and update host
software and/or qemu.  It does not preserve descriptors, and guest ram must be
backed by persistant shared memory.  Guest pause time depends on host reboot
time, which can be seconds to 10's of seconds.

The second case allows you to update qemu in place, but not update the host.
Guest ram can be in shared or anonymous memory.  We call madvise(MADV_DOEXEC)
to tell the kernel to preserve anon memory across the exec.  Open descriptors
are preserved.  Addresses and lengths of saved memory segments are saved in
the environment, and the values of descriptors are saved.  When new qemu
restarts, it finds those values in the environment and uses them when the
various objects are created.  Memory is not realloc'd, it is already present,
and the address and lengths are saved in the ram objects.  Guest pause time
is in the 100 to 200 msec range.  It is less resource intensive than live
migration, and is appropriate if your only goal is to update qemu, as opposed
to evacuating a host.

>>>> cprsave and cprload support guests with vfio devices if the caller first
>>>> suspends the guest by issuing guest-suspend-ram to the qemu guest agent.
>>>> The guest drivers suspend methods flush outstanding requests and re-
>>>> initialize the devices, and thus there is no device state to save and
>>>> restore.
>>> This probably should be allowed even for regular migration.  Can you
>>> generalize the code as a separate series?
>>
>> Maybe.  I think that would be a distinct patch that ignores the vfio migration blocker 
>> if the state is suspended.  Plus a qemu agent call to do the suspend.  Needs more
>> thought.
> 
> The agent already supports suspend, so that should be relatively easy.
> Only the code to add/remove the VFIO migration blocker from a VM state
> change notifier, or something like that, would be needed.

Yes, I have experimented with the guest's suspend method.

- Steve

