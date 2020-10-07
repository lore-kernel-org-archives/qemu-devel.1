Return-Path: <SRS0=37Ja=DO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1232C4363C
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 21:27:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF28C2083B
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 21:27:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="PZ1M485s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF28C2083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34700 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQGxy-0003TH-0B
	for qemu-devel@archiver.kernel.org; Wed, 07 Oct 2020 17:27:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52616)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1kQGwp-000304-3K
 for qemu-devel@nongnu.org; Wed, 07 Oct 2020 17:26:07 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:43810)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1kQGwj-0008Px-N1
 for qemu-devel@nongnu.org; Wed, 07 Oct 2020 17:26:06 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
 by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 097L9Tgi071856;
 Wed, 7 Oct 2020 21:25:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=z+kfReIqPdu/6oLDrwGtmMMTb2rbwVgLLCSnGvvjPZ8=;
 b=PZ1M485shKA3p8mXbc+g6dt7vCTuKDEwolqTeUhB1380a/bhaKsO/172kqvCTMlBHc+v
 Si3vi84W7dM+Cn6L3CAAjJw/7wRUdZM93grjV1t2n8pijf88hOjfKH3f/cpwRQRIq+GK
 57+55L5TO7zZL+b+ayQWHoYJKS3hoQIMocR1SB1K/nvBTntGa8cvRlqjmpsbL2QkNg8M
 ywGusPAcvnM+J6hzrF3hlJsLFRCi47HVcwmIyvW1+mHU23gzdd1+8WwkkgYiP+kHjxKv
 6/ESYXOFa9gPFj+9Gly+rRpDjzF5x9IVgN5+l9fAKoznocxXbAmb0eW0z83ag3/XfiPO BQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
 by userp2120.oracle.com with ESMTP id 33xhxn4ch3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 07 Oct 2020 21:25:55 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
 by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 097LADbx020760;
 Wed, 7 Oct 2020 21:25:54 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
 by userp3030.oracle.com with ESMTP id 33y3803akt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 07 Oct 2020 21:25:54 +0000
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
 by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 097LPr23028366;
 Wed, 7 Oct 2020 21:25:53 GMT
Received: from [10.39.254.36] (/10.39.254.36)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Wed, 07 Oct 2020 14:25:52 -0700
Subject: Re: [PATCH V1 30/32] vfio-pci: save and restore
To: Jason Zeng <jason.zeng@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>
References: <1596122076-341293-1-git-send-email-steven.sistare@oracle.com>
 <1596122076-341293-31-git-send-email-steven.sistare@oracle.com>
 <20200806102259.GA25634@x48>
 <5d2e3c90-eb8c-569f-ef4a-5016756725c7@oracle.com> <20200810035059.GA3463@x48>
 <0da862c8-74bc-bf06-a436-4ebfcb9dd8d4@oracle.com>
 <20200820103333.GA30987@x48>
From: Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
Message-ID: <bdbb51c3-9e6e-3b4f-2e5d-79dd1ba64d70@oracle.com>
Date: Wed, 7 Oct 2020 17:25:51 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <20200820103333.GA30987@x48>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9767
 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 bulkscore=0 spamscore=0
 mlxscore=0 malwarescore=0 suspectscore=0 adultscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2010070137
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9767
 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 malwarescore=0 bulkscore=0
 impostorscore=0 lowpriorityscore=0 suspectscore=0 phishscore=0
 mlxlogscore=999 adultscore=0 clxscore=1011 spamscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2010070137
Received-SPF: pass client-ip=156.151.31.85;
 envelope-from=steven.sistare@oracle.com; helo=userp2120.oracle.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/07 17:25:58
X-ACL-Warn: Detected OS   = Linux 3.1-3.10 [fuzzy]
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.001,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
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
 Juan Quintela <quintela@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Jason Zeng <jason.zeng@linux.intel.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 8/20/2020 6:33 AM, Jason Zeng wrote:
> On Wed, Aug 19, 2020 at 05:15:11PM -0400, Steven Sistare wrote:
>> On 8/9/2020 11:50 PM, Jason Zeng wrote:
>>> On Fri, Aug 07, 2020 at 04:38:12PM -0400, Steven Sistare wrote:
>>>> On 8/6/2020 6:22 AM, Jason Zeng wrote:
>>>>> Hi Steve,
>>>>>
>>>>> On Thu, Jul 30, 2020 at 08:14:34AM -0700, Steve Sistare wrote:
>>>>>> @@ -3182,6 +3207,51 @@ static Property vfio_pci_dev_properties[] = {
>>>>>>      DEFINE_PROP_END_OF_LIST(),
>>>>>>  };
>>>>>>  
>>>>>> +static int vfio_pci_post_load(void *opaque, int version_id)
>>>>>> +{
>>>>>> +    int vector;
>>>>>> +    MSIMessage msg;
>>>>>> +    Error *err = 0;
>>>>>> +    VFIOPCIDevice *vdev = opaque;
>>>>>> +    PCIDevice *pdev = &vdev->pdev;
>>>>>> +
>>>>>> +    if (msix_enabled(pdev)) {
>>>>>> +        vfio_msix_enable(vdev);
>>>>>> +        pdev->msix_function_masked = false;
>>>>>> +
>>>>>> +        for (vector = 0; vector < vdev->pdev.msix_entries_nr; vector++) {
>>>>>> +            if (!msix_is_masked(pdev, vector)) {
>>>>>> +                msg = msix_get_message(pdev, vector);
>>>>>> +                vfio_msix_vector_use(pdev, vector, msg);
>>>>>> +            }
>>>>>> +        }
>>>>>
>>>>> It looks to me MSIX re-init here may lose device IRQs and impact
>>>>> device hardware state?
>>>>>
>>>>> The re-init will cause the kernel vfio driver to connect the device
>>>>> MSIX vectors to new eventfds and KVM instance. But before that, device
>>>>> IRQs will be routed to previous eventfd. Looks these IRQs will be lost.
>>>>
>>>> Thanks Jason, that sounds like a problem.  I could try reading and saving an 
>>>> event from eventfd before shutdown, and injecting it into the eventfd after
>>>> restart, but that would be racy unless I disable interrupts.  Or, unconditionally
>>>> inject a spurious interrupt after restart to kick it, in case an interrupt 
>>>> was lost.
>>>>
>>>> Do you have any other ideas?
>>>
>>> Maybe we can consider to also hand over the eventfd file descriptor, or
>>
>> I believe preserving this descriptor in isolation is not sufficient.  We would
>> also need to preserve the KVM instance which it is linked to.
>>
>>> or even the KVM fds to the new Qemu?
>>>
>>> If the KVM fds can be preserved, we will just need to restore Qemu KVM
>>> side states. But not sure how complicated the implementation would be.
>>
>> That should work, but I fear it would require many code changes in QEMU
>> to re-use descriptors at object creation time and suppress the initial 
>> configuration ioctl's, so it's not my first choice for a solution.
>>
>>> If we only preserve the eventfd fd, we can attach the old eventfd to
>>> vfio devices. But looks it may turn out we always inject an interrupt
>>> unconditionally, because kernel KVM irqfd eventfd handling is a bit
>>> different than normal user land eventfd read/write. It doesn't decrease
>>> the counter in the eventfd context. So if we read the eventfd from new
>>> Qemu, it looks will always have a non-zero counter, which requires an
>>> interrupt injection.
>>
>> Good to know, thanks.
>>
>> I will try creating a new eventfd and injecting an interrupt unconditionally.
>> I need a test case to demonstrate losing an interrupt, and fixing it with
>> injection.  Any advice?  My stress tests with a virtual function nic and a
>> directly assigned nvme block device have never failed across live update.
>>
> 
> I am not familiar with nvme devices. For nic device, to my understanding,
> stress nic testing will not have many IRQs, because nic driver usually
> enables NAPI, which only take the first interrupt, then disable interrupt
> and start polling. It will only re-enable interrupt after some packet
> quota reached or the traffic quiesces for a while. But anyway, if the
> test goes enough long time, the number of IRQs should also be big, not
> sure why it doesn't trigger any issue. Maybe we can have some study on
> the IRQ pattern for the testing and see how we can design a test case?
> or see if our assumption is wrong?
> 
> 
>>>>> And the re-init will make the device go through the procedure of
>>>>> disabling MSIX, enabling INTX, and re-enabling MSIX and vectors.
>>>>> So if the device is active, its hardware state will be impacted?
>>>>
>>>> Again thanks.  vfio_msix_enable() does indeed call vfio_disable_interrupts().
>>>> For a quick experiment, I deleted that call in for the post_load code path, and 
>>>> it seems to work fine, but I need to study it more.
>>>
>>> vfio_msix_vector_use() will also trigger this procedure in the kernel.
>>
>> Because that code path calls VFIO_DEVICE_SET_IRQS? Or something else?
>> Can you point to what it triggers in the kernel?
> 
> 
> In vfio_msix_vector_use(), I see vfio_disable_irqindex() will be invoked
> if "vdev->nr_vectors < nr + 1" is true. Since the 'vdev' is re-inited,
> so this condition should be true, and vfio_disable_irqindex() will
> trigger VFIO_DEVICE_SET_IRQS with VFIO_IRQ_SET_DATA_NONE, which will
> cause kernel to disable MSIX.
> 
>>
>>> Looks we shouldn't trigger any kernel vfio actions here? Because we
>>> preserve vfio fds, so its kernel state shouldn't be touched. Here we
>>> may only need to restore Qemu states. Re-connect to KVM instance should
>>> be done automatically when we setup the KVM irqfds with the same eventfd.
>>>
>>> BTW, if I remember correctly, it is not enough to only save MSIX state
>>> in the snapshot. We should also save the Qemu side pci config space
>>> cache to the snapshot, because Qemu's copy is not exactly the same as
>>> the kernel's copy. I encountered this before, but I don't remember which
>>> field it was.
>>
>> FYI all, Jason told me offline that qemu may emulate some pci capabilities and
>> hence keeps state in the shadow config that is never written to the kernel.
>> I need to study that.
>>
> 
> Sorry, I read the code again, see Qemu does write all config-space-write
> to kernel in vfio_pci_write_config(). Now I am also confused about what
> I was seeing previously :(. But it seems we still need to look at kernel
> code to see if mismatch is possibile for config space cache between Qemu
> and kernel.
> 
> FYI. Some discussion about the VFIO PCI config space saving/restoring in
> live migration scenario:
> https://lists.gnu.org/archive/html/qemu-devel/2020-06/msg06964.html
> 

I have coded a solution for much of the "lost interrupts" issue.
cprsave preserves the vfio err, req, and msi irq eventfd's across exec:
  vdev->err_notifier
  vdev->req_notifier
  vdev->msi_vectors[i].interrupt
  vdev->msi_vectors[i].kvm_interrupt

The KVM instance is destroyed and recreated as before.
The eventfd descriptors are found and reused during vfio_realize using
event_notifier_init_fd.  No calls to VFIO_DEVICE_SET_IRQS are made before or
after the exec.  The descriptors are attached to the new KVM instance via the
usual ioctl's on the existing code paths.

It works.  I issue cprsave, send an interrupt, wait a few seconds, then issue cprload.
The interrupt fires immediately after cprload.  I tested interrupt delivery to the 
kvm_irqchip and to qemu.

It does not support Posted Interrupts, as that involves state attached to the
VMCS, which is destroyed with the KVM instance.  That needs more study and
a likely kernel enhancement.

I will post the full code as part of the V2 patch series.

- Steve


