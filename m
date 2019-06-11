Return-Path: <SRS0=mXWu=UK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CED29C4321A
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2019 16:13:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8A63020673
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2019 16:13:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="eLK11nVb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A63020673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60574 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hajOP-0001vJ-RA
	for qemu-devel@archiver.kernel.org; Tue, 11 Jun 2019 12:13:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37622)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <jag.raman@oracle.com>) id 1haj5N-0006Nd-Gf
 for qemu-devel@nongnu.org; Tue, 11 Jun 2019 11:53:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jag.raman@oracle.com>) id 1haj5L-0003RU-2E
 for qemu-devel@nongnu.org; Tue, 11 Jun 2019 11:53:21 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:42334)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jag.raman@oracle.com>)
 id 1haj5K-0003NE-N3
 for qemu-devel@nongnu.org; Tue, 11 Jun 2019 11:53:18 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
 by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5BFhj5t142827;
 Tue, 11 Jun 2019 15:53:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=6EZdx72v1N85iGk5u5igwXPSmVBpji5AOekryKRsXaY=;
 b=eLK11nVbgbaW0/Nv+RHOJ2NxUAh+rOIyGC7FRoWVUB6zRQeeQw+yeXZ+TqhvmHJvvCvE
 ZDk7ZfKwyJpcaU3wq9A0I079sf6NxUX82mAhEA4dbeRJfpxuhnUcGYfJQJ2Vgzb0eAhA
 S2gZgEf/YFPNQizqFj8cgGBdpbCad6SZIfMfD62DWbXpO0Egi+BPmvzJxl+XLUHh68Ru
 W6m2BRt5OFtuZbAHGWslOBj82pe5KAfAi6B9/i57Rra9QD9fUucWSU0tUMJGfofzp6go
 y/ybju46Lx1kMMhhKa4MlNPjGx1yJe85kCClJtNr63fKOoLI2w2SO8d73nFT1KGAcAx1 9Q== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
 by userp2120.oracle.com with ESMTP id 2t05nqp28e-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 11 Jun 2019 15:53:09 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
 by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5BFpHaR161528;
 Tue, 11 Jun 2019 15:53:09 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
 by userp3030.oracle.com with ESMTP id 2t024ufvcj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 11 Jun 2019 15:53:08 +0000
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
 by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x5BFr6PX006340;
 Tue, 11 Jun 2019 15:53:06 GMT
Received: from [10.11.108.55] (/10.11.108.55)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Tue, 11 Jun 2019 08:53:06 -0700
To: Stefan Hajnoczi <stefanha@gmail.com>
References: <20190307145120.GF32268@redhat.com>
 <20190307192727.GG2915@stefanha-x1.localdomain>
 <BDEBF2EE-DE0F-46CF-B60E-536B3DA9BF77@oracle.com>
 <20190308095036.GC12318@stefanha-x1.localdomain>
 <20190326080822.GC21018@stefanha-x1.localdomain>
 <e5395abf-6b41-46c8-f5af-3210077dfdd5@oracle.com>
 <CAAdtpL4ztcpf-CTx0fc5T_+VQ+8upHa2pEMoiZPcmBXOO6L3Og@mail.gmail.com>
 <c945c950-f6f1-7e2a-a6c4-399c9b728288@oracle.com>
 <20190425154421.GG17806@stefanha-x1.localdomain>
 <fe4b0b42-523d-5877-173c-3e878abd4e32@oracle.com>
 <20190523104018.GE26632@stefanha-x1.localdomain>
From: Jag Raman <jag.raman@oracle.com>
Organization: Oracle Corporation
Message-ID: <735c942b-9ab9-86df-d112-d6b1fc7e90f9@oracle.com>
Date: Tue, 11 Jun 2019 11:53:05 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190523104018.GE26632@stefanha-x1.localdomain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9284
 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906110102
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9284
 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906110102
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by userp2120.oracle.com id
 x5BFhj5t142827
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 156.151.31.85
Subject: Re: [Qemu-devel] [multiprocess RFC PATCH 36/37] multi-process: add
 the concept description to docs/devel/qemu-multiprocess
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
Cc: Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 John G Johnson <john.g.johnson@oracle.com>, sstabellini@kernel.org,
 konrad.wilk@oracle.com, qemu-devel@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 ross.lagerwall@citrix.com, liran.alon@oracle.com,
 Stefan Hajnoczi <stefanha@redhat.com>, kanth.ghatraju@oracle.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 5/23/2019 6:40 AM, Stefan Hajnoczi wrote:
> On Tue, May 07, 2019 at 03:00:52PM -0400, Jag Raman wrote:
>> Hi Stefan,
>>
>> Thank you very much for your feedback. Following is a summary of the
>> discussions our team had regarding your feedback.
>>
>> On 4/25/2019 11:44 AM, Stefan Hajnoczi wrote:
>>>
>>> Can multiple LSI SCSI controllers be launched such that each process
>>> only has access to a subset of disk images?  Or is the disk image lab=
el
>>> per-VM so that there is no isolation between LSI SCSI controller
>>> processes for that VM?
>>
>> Yes, it is possible to provide each process with access to a subset of
>> disk images. The Orchestrator (libvirt, etc.) assigns a set of MCS
>> Categories to each VM, then device instances can be isolated by being
>> assigned a subset of the VM=E2=80=99s Categories.
>>
>>>
>>> My concern with this overall approach is the practicality vs its
>>> benefits.  Regarding practicality, each emulated device needs to be
>>> proxied separately.  The QEMU subsystem used by the device also needs=
 to
>>> be proxied.  Global state, monitor commands, and live migration all
>>> require code changes to support proxied operation.  This is very
>>> invasive.
>>>
>>> Then each emulated device needs an SELinux policy to achieve the
>>> benefits of confinement.  I have no idea how to correctly write a pol=
icy
>>> like this and it's likely that developers who contribute a single new
>>> device will not be proficient in it either.  Writing these policies i=
s a
>>> rare thing and few people will be good at this.  It also makes me wor=
ry
>>> about how we test and review them.
>>
>> We also think that having an SELinux policy per device would become
>> complicated. Our proposal, therefore, is to define SELinux policies fo=
r
>> each device class - viz. disk, network, console, graphics, etc.
>> "fedora-selinux" upstream repo. [1] will contain these policies, so th=
e
>> device developer doesn't have to worry about defining new policies for
>> each device. This proposal would diminish the complexity of SELinux
>> policies.
>=20
> Have you considered using Linux namespaces?  I'm beginning to think tha=
t
> SELinux becomes less relevant with pid and mount namespaces to isolate
> processes.  The advantage of namespaces is that they are easy to
> understand and can be expressed in code instead of a policy file in a
> separate package.  This is the approach we're taking with virtiofsd
> (vhost-user device backend for virtio-fs).
>=20
>>>
>>> Despite the efforts required in making this work, all processes still
>>> effectively have full access to the guest since they can access guest
>>> RAM.  What I mean is that the device is actually not confined to its
>>> host process (e.g. LSI SCSI controller process) because it can write
>>> code to executable guest RAM pages.  The guest will then execute that
>>> code and therefore all guest I/O (networking, disk, etc) is still
>>> available indirectly to the "confined" processes.  They are not reall=
y
>>> sandboxed from the outside world, regardless of how strict the SELinu=
x
>>> policy is :(.
>>>
>>> There are performance issues due to proxying as well, but let's ignor=
e
>>> them for now and focus on security.
>>
>> We are also focusing on performance. Please take a look at the followi=
ng
>> blog for an initial report on performance. The results are for an iSCS=
I
>> backend in Oracle Cloud. We are working on collecting data on a much
>> heavier IOPS workload like an NVMe backend.
>>
>> https://blogs.oracle.com/linux/towards-a-more-secure-qemu-hypervisor%2=
c-part-3-of-3-v2
>=20
> Hard to reach a conclusion without also looking at CPU utilization.
> IOPS alone don't tell the story.
>=20
> If the system had spare CPU cycles then the performance results between
> built-in LSI and separate LSI will be similar but the efficiency
> (IOPS/CPU%) has actually decreased due to the extra CPU cycles required
> to forward the hardware register access to the device emulation process.
>=20
> If you rerun on a system without spare CPU cycles then IOPS degradation
> would become apparent.  I'm not saying this is necessarily the case,
> maybe the overhead is really doesn't have a significant effect, but the
> graph shown in the blog post isn't enough to draw a conclusion either
> way.

Hi Stefan,

We are working on getting a better idea about the CPU utilization while=20
the performance test is running. We're looking forward to discussing=20
this during the forthcoming KVM meeting.

Thank you!
--
Jag

>=20
> Regarding the proposed QEMU bypass, these already exist in some form vi=
a
> kvm.ko's ioeventfd and coalesced MMIO features.
>=20
> Today ioeventfd is only used for performance-critical hardware
> registers, so kvm.ko doesn't use a sophisticated dispatch mechanism.  I=
f
> you want to use it for all hardware register accesses handled by a
> separate process then ioeventfd probably needs to be tweaked somewhat t=
o
> make it more scalable for that case.
>=20
> Coalesced MMIO is also cool.  kvm.ko can accumulate guest MMIO writes i=
n
> a buffer that is only collected at a later point in time.  This improve=
s
> performance for devices that require multiple hardware register writes
> to kick off an I/O operation (only the last one really needs to be
> trapped by the device emulation code!).  This sounds similar to an MMIO
> access shared ring buffer.
>=20
>>>
>>> How do the benefits compare against today's monolithic approach?  If =
the
>>> guest exploits monolithic QEMU it has full access to all host files a=
nd
>>> APIs available to QEMU.  However, these are largely just the resource=
s
>>> that belong to the guest anyway - not resources we are trying to keep
>>> away from the guest.  With multi-process QEMU each process still has
>>> access to all guest interfaces via the code injection I mentioned abo=
ve,
>>> but the SELinux policy could restrict access to some resources.  But
>>> this benefit is really small in my opinion, given that the resources
>>> belong to the guest anyway and the guest can already access them.
>>
>> The primary focus of our project is to defend the host from malicious
>> guest. The code injection problem you outlined above involves part of
>> the guest attacking itself, but not the host. Therefore, this wouldn't
>> compromise our objective.
>>
>> Like you know, there are some parts of QEMU which are not directly
>> accessible from the guest (via drivers, etc.), which we prefer to call
>> the control plane. It executes ioctls to the host kernel and has acces=
s
>> to a broader set of syscalls, which the device emulation code doesn=E2=
=80=99t
>> need. We want to protect the control plane from emulated devices. In t=
he
>> case where a device injects code into the RAM to attack another device
>> on the same VM, the control plane would still be protected.
>=20
> Are you aware of any cases where the syscall attack surface led to an
> exploitable bug in QEMU?  Any proof-of-concept exploit code or a CVE?
>=20
>> Another benefit with the project would be regarding detecting and
>> reporting failures in the emulated devices. For instance, in cases lik=
e
>> CVE-2018-18849, where an emulated device hangs/crashes, it wouldn't
>> directly crash the QEMU process as well. QEMU could detect the failure=
,
>> log the problem and exit, instead of generating coredump/hang.
>=20
> Debugging is a lot easier with a coredump though :).  I would rather
> have a coredump than a nice message that says "LSI died".
>=20
>>>
>>> I think you can implement this for a handful of devices as a one-time
>>> thing, but the invasiveness and the impracticality of getting wide co=
ver
>>> of QEMU make this approach questionable.
>>>
>>> Am I mistaken about the invasiveness or impracticality?
>>
>> We are not planning to implement this for all devices since it would b=
e
>> impractical. But the project adds a framework for implementing more
>> devices in the future.
>>
>> One other thing we would like to bring your attention to is that the
>> project doesn't affect the current usage. The same devices could still
>> be used as part of monolithic QEMU if the user chooses to do so.
>=20
> I don't follow, to me this proposal seems extremely invasive and
> requires awareness from all developers.
>=20
> QEMU contains global state (like net/net.c:net_clients or
> block.c:all_bdrv_states) and QMP commands that access global state.  Al=
l
> of this needs to be carefully proxied to avoid losing functionality as
> fundamental as the QMP monitor.
>=20
> This is what worries me about this project.  There are amazing niche
> features like record/replay that have been integrated into QEMU without
> requiring all developers to be aware of how they work.  If you can
> achieve this then I would have no reservations.
>=20
> Right now I don't see that this will be possible and that's why I'm
> challenging you to justify that the reduction in system call attack
> surface is actually worth the invasive changes required.
>=20
> Do you see a way to solve the issues I've mentioned?
>=20
> Stefan
>=20

