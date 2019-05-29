Return-Path: <SRS0=DspQ=T5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 010C3C072B1
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2019 00:17:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B531C21019
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2019 00:17:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Lo+2Adp3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B531C21019
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:44590 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hVmHd-0003Lp-Qw
	for qemu-devel@archiver.kernel.org; Tue, 28 May 2019 20:17:33 -0400
Received: from eggs.gnu.org ([209.51.188.92]:37676)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <si-wei.liu@oracle.com>) id 1hVmGm-0002w5-M2
	for qemu-devel@nongnu.org; Tue, 28 May 2019 20:16:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <si-wei.liu@oracle.com>) id 1hVmGl-0003zp-1g
	for qemu-devel@nongnu.org; Tue, 28 May 2019 20:16:40 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:41538)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <si-wei.liu@oracle.com>)
	id 1hVmGk-0003wf-Nk
	for qemu-devel@nongnu.org; Tue, 28 May 2019 20:16:38 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
	by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id
	x4SNxKYW130994; Wed, 29 May 2019 00:16:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
	h=subject : to :
	references : cc : from : message-id : date : mime-version : in-reply-to
	: content-type : content-transfer-encoding; s=corp-2018-07-02;
	bh=kuWSmkUbBe9FQX4/OCo08iB0PJc8q/8wx4H0THbvoG0=;
	b=Lo+2Adp3Ny0nVDSBLh1InuYGLEOD7JjYzYdMEy6n8AeInrW95rLJxgN1IquXk1U2fqL5
	wEpHQ6cWhl9tMhWVmmkf/vRCbtkYMshr32mVc2VE4LtyuvhCgeM0w+Ki9MuoDx4hLW4/
	Ik+6mPwXUWFV2GqiU3ejjXQyAkNzoN8yHOC6gytzX7e7Vfp9qts6tGNkvcCFG4aSBxik
	mQ7IEtpR1qJN2nzU57YxQ8/7E3kxOmYr6QHFULrzbL7KLpinCdsWMfxwOe5nci3gqcvn
	dv3/Kj854pviSCvBGYeeKspFsJWaDLYjsqmc06gbBrL3IAXl6XUmRViqta7F82Km3jPD
	NA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
	by userp2130.oracle.com with ESMTP id 2spw4teggu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 29 May 2019 00:16:31 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
	by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id
	x4T0EOSO031481; Wed, 29 May 2019 00:14:30 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
	by aserp3020.oracle.com with ESMTP id 2sqh73dbba-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 29 May 2019 00:14:30 +0000
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
	by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x4T0ES0K030001;
	Wed, 29 May 2019 00:14:28 GMT
Received: from [10.159.253.52] (/10.159.253.52)
	by default (Oracle Beehive Gateway v4.0)
	with ESMTP ; Tue, 28 May 2019 17:14:28 -0700
To: Jens Freimann <jfreimann@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
References: <20190517125820.2885-1-jfreimann@redhat.com>
	<20190520165657.2293c5d7@x1.home>
	<20190521072157.wpb77wlc5mhfcdes@jenstp.localdomain>
	<20190521073511-mutt-send-email-mst@kernel.org>
	<20190521184918.n4nnk6ack3ssp6jv@jenstp.localdomain>
From: si-wei liu <si-wei.liu@oracle.com>
Organization: Oracle Corporation
Message-ID: <d116bc65-0715-2c6a-2616-49f67cd685c8@oracle.com>
Date: Tue, 28 May 2019 17:14:22 -0700
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
	Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <20190521184918.n4nnk6ack3ssp6jv@jenstp.localdomain>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9271
	signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
	malwarescore=0
	phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
	adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
	engine=8.0.1-1810050000 definitions=main-1905280152
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9271
	signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
	priorityscore=1501 malwarescore=0
	suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
	lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999
	adultscore=0
	classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
	definitions=main-1905280152
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 156.151.31.86
Subject: Re: [Qemu-devel] [PATCH 0/4] add failover feature for assigned
 network devices
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: pkrempa@redhat.com, berrange@redhat.com, ehabkost@redhat.com,
	aadam@redhat.com, qemu-devel@nongnu.org,
	Alex Williamson <alex.williamson@redhat.com>, laine@redhat.com,
	ailan@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 5/21/2019 11:49 AM, Jens Freimann wrote:
> On Tue, May 21, 2019 at 07:37:19AM -0400, Michael S. Tsirkin wrote:
>> On Tue, May 21, 2019 at 09:21:57AM +0200, Jens Freimann wrote:
>>> On Mon, May 20, 2019 at 04:56:57PM -0600, Alex Williamson wrote:
>>> > On Fri, 17 May 2019 14:58:16 +0200
>>> > Jens Freimann <jfreimann@redhat.com> wrote:
>>> > > Command line example:
>>> > >
>>> > > qemu-system-x86_64 -enable-kvm -m 3072 -smp 3 \
>>> > >         -machine q35,kernel-irqchip=split -cpu host   \
>>> > >         -k fr   \
>>> > >         -serial stdio   \
>>> > >         -net none \
>>> > >         -qmp unix:/tmp/qmp.socket,server,nowait \
>>> > >         -monitor telnet:127.0.0.1:5555,server,nowait \
>>> > >         -device 
>>> pcie-root-port,id=root0,multifunction=on,chassis=0,addr=0xa \
>>> > >         -device pcie-root-port,id=root1,bus=pcie.0,chassis=1 \
>>> > >         -device pcie-root-port,id=root2,bus=pcie.0,chassis=2 \
>>> > >         -netdev 
>>> tap,script=/root/bin/bridge.sh,downscript=no,id=hostnet1,vhost=on \
>>> > >         -device 
>>> virtio-net-pci,netdev=hostnet1,id=net1,mac=52:54:00:6f:55:cc,bus=root2,failover=on 
>>> \
>>> > >         /root/rhel-guest-image-8.0-1781.x86_64.qcow2
>>> > >
>>> > > Then the primary device can be hotplugged via
>>> > >  (qemu) device_add 
>>> vfio-pci,host=5e:00.2,id=hostdev0,bus=root1,standby=net1
>>> >
>>> > Is this standby= option only valid for Network/Ethernet class code
>>> > devices?  If so, perhaps vfio-pci code should reject the option on 
>>> any
>>> > non-ethernet devices.  The option is also non-intuitive for users, 
>>> only
>>> > through examples like above can we see it relates to the id of the
>>> > secondary device.  Could we instead name it something like
>>> > "standby_net_failover_pair_id="?
>>>
>>> It is only for ethernet (VFs), I will add code to reject 
>>> non-ethernet VF devices.
>>> I agree the name is not descriptive and the one you suggest seems 
>>> good to
>>> me.
>>> >
>>> > Also, this feature requires matching MAC addresses per the 
>>> description,
>>> > where is that done?  Is it the user's responsibility to set the 
>>> MAC on
>>> > the host device prior to the device_add?  If so, is this actually not
>>> > only specific to ethernet devices, but ethernet VFs?
>>>
>>> Yes, it's the users responsibility and the MACs are then matched by
>>> the net_failover driver in the guest. It makes sense for ethernet 
>>> VFs only,
>>> I'll add a check for that.
>>
>> Actually is there a list of devices for which this has been tested
>> besides mlx5? I think someone said some old intel cards
>> don't support this well, we might need to blacklist these ...
>
> So far I've tested mlx5 and XL710 which both worked, but I'm
> working on testing with more devices. But of course help with testing
> is greatly appreciated.
It won't work on Intel ixgbe and Broadcom bnxt_en, which requires 
toggling the state of tap backing the virtio-net in order to 
release/reprogram MAC filter. Actually, it's very few NICs that could 
work with this - even some works by chance the behavior is undefined. 
Instead of blacklisting it makes more sense to whitelist the NIC that 
supports it - with some new sysfs attribute claiming the support 
presumably.

-Siwei

>
> regards,
> Jens


