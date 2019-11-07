Return-Path: <SRS0=+ldK=Y7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F3A0C43331
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2019 15:55:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 59F5420663
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2019 15:55:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="PT1jO0Ea"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59F5420663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44662 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iSk8M-0007B1-GI
	for qemu-devel@archiver.kernel.org; Thu, 07 Nov 2019 10:55:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35496)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jag.raman@oracle.com>) id 1iSk7S-0006IR-Mz
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 10:54:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jag.raman@oracle.com>) id 1iSk7Q-0008CQ-IL
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 10:54:46 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:50754)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jag.raman@oracle.com>)
 id 1iSk7Q-0007w6-9a
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 10:54:44 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
 by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xA7FiGhh111035;
 Thu, 7 Nov 2019 15:54:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=rvmGV8EruZ/WUrHNbTHLOZHZkOU5GkG45PlHJpY4tlA=;
 b=PT1jO0EaR9i/vW5NRMcmIqpI9OtPdY5DKAYMfpTGg604CAMKf4XdUTTcaKKB8+5xF+Ah
 cPc6KScCyyO6DjXKNEIbB3w+vdQYiDDujBBeQVGW2e2BdFxehURBxW3rtiPD09SnpHu8
 A3Xt6MOjxVQK+5qxB3cUdCn5/GuN+Dsn+/cLxVLV2WpQWk+yiR1cRRU+fIOkJoeyu1jj
 O4Toa4+pNF+QrHfZl24AmH814wwRZzggt9Yv8xaR+YfDB24pA0LiHW7NKTz5kKv72lBX
 RQI8uGyiKoy/TCkKrRHinsflHGNjD3WFBmkfp8eagv9vOQQfmZ+U6OKi+ZNUAZVZ4YES LA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
 by userp2130.oracle.com with ESMTP id 2w41w175e3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 07 Nov 2019 15:54:12 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
 by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xA7FrwgN056373;
 Thu, 7 Nov 2019 15:54:11 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
 by userp3020.oracle.com with ESMTP id 2w41whg3es-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 07 Nov 2019 15:54:11 +0000
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
 by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id xA7FrTNP017397;
 Thu, 7 Nov 2019 15:53:29 GMT
Received: from [10.152.34.2] (/10.152.34.2)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Thu, 07 Nov 2019 07:53:29 -0800
Subject: Re: [RFC v4 PATCH 49/49] multi-process: add configure and usage
 information
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Stefan Hajnoczi <stefanha@gmail.com>, mst@redhat.com
References: <cover.1571905346.git.jag.raman@oracle.com>
 <2736d12f29d2c9051966864b5d865ab0f392b8d1.1571905346.git.jag.raman@oracle.com>
 <20191107140220.GI365089@stefanha-x1.localdomain>
 <20191107143900.GG120292@redhat.com>
From: Jag Raman <jag.raman@oracle.com>
Organization: Oracle Corporation
Message-ID: <cdc3bd40-a1c4-2f89-b3d3-eff2b661e04f@oracle.com>
Date: Thu, 7 Nov 2019 10:53:27 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <20191107143900.GG120292@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9433
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1910280000 definitions=main-1911070151
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9433
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1910280000
 definitions=main-1911070150
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by userp2130.oracle.com id
 xA7FiGhh111035
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
X-Received-From: 156.151.31.86
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
Cc: elena.ufimtseva@oracle.com, fam@euphon.net, thuth@redhat.com,
 john.g.johnson@oracle.com, ehabkost@redhat.com, quintela@redhat.com,
 konrad.wilk@oracle.com, qemu-devel@nongnu.org, armbru@redhat.com,
 ross.lagerwall@citrix.com, mreitz@redhat.com, kanth.ghatraju@oracle.com,
 kraxel@redhat.com, stefanha@redhat.com, pbonzini@redhat.com,
 liran.alon@oracle.com, marcandre.lureau@gmail.com, kwolf@redhat.com,
 dgilbert@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 11/7/2019 9:39 AM, Daniel P. Berrang=C3=A9 wrote:
> On Thu, Nov 07, 2019 at 03:02:20PM +0100, Stefan Hajnoczi wrote:
>> On Thu, Oct 24, 2019 at 05:09:30AM -0400, Jagannathan Raman wrote:
>>> From: Elena Ufimtseva <elena.ufimtseva@oracle.com>
>>>
>>> Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
>>> Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
>>> Signed-off-by: John G Johnson <john.g.johnson@oracle.com>
>>> ---
>>>   docs/qemu-multiprocess.txt | 86 +++++++++++++++++++++++++++++++++++=
+++++++++++
>>>   1 file changed, 86 insertions(+)
>>>   create mode 100644 docs/qemu-multiprocess.txt
>>>
>>> diff --git a/docs/qemu-multiprocess.txt b/docs/qemu-multiprocess.txt
>>> new file mode 100644
>>> index 0000000..c29f4df
>>> --- /dev/null
>>> +++ b/docs/qemu-multiprocess.txt
>>> @@ -0,0 +1,86 @@
>>> +Multi-process QEMU
>>> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>> +
>>> +This document describes how to configure and use multi-process qemu.
>>> +For the design document refer to docs/devel/qemu-multiprocess.
>>> +
>>> +1) Configuration
>>> +----------------
>>> +
>>> +To enable support for multi-process add --enable-mpqemu
>>> +to the list of options for the "configure" script.
>>> +
>>> +
>>> +2) Usage
>>> +--------
>>> +
>>> +To start qemu with devices intended to run in a separate emulation
>>> +process without libvirtd support, the following should be used on QE=
MU
>>> +command line. As of now, we only support the emulation of lsi53c895a
>>> +in a separate process
>>> +
>>> +* Since parts of the RAM are shared between QEMU & remote process, a
>>> +  memory-backend-file is required to facilitate this, as follows:
>>> +
>>> +  -object memory-backend-file,id=3Dmem,mem-path=3D/dev/shm/,size=3D4=
096M,share=3Don
>>> +
>>> +* The devices to be emulated in the separate process are defined as
>>> +  before with addition of "rid" suboption that serves as a remote gr=
oup
>>> +  identificator.
>>> +
>>> +  -device <device options>,rid=3D"remote process id"
>>> +
>>> +  For exmaple, for non multi-process qemu:
>>
>> s/exmaple/example/
>>
>>> +    -device lsi53c895a,id=3Dscsi0 device
>>> +    -device scsi-hd,drive=3Ddrive0,bus=3Dscsi0.0,scsi-id=3D0
>>> +    -drive id=3Ddrive0,file=3Ddata-disk.img
>>> +
>>> +  and for multi-process qemu and no libvirt
>>> +  support (i.e. QEMU forks child processes):
>>> +    -device lsi53c895a,id=3Dscsi0,rid=3D0
>>> +    -device scsi-hd,drive=3Ddrive0,bus=3Dscsi0.0,scsi-id=3D0,rid=3D"=
0"
>>> +
>>> +* The command-line options for the remote process is added to the "c=
ommand"
>>
>> s/is added/are added/
>>
>>> +  suboption of the newly added "-remote" option.
>>> +
>>> +   -remote [socket],rid=3D,command=3D"..."
>>> +
>>> +  The drives to be emulated by the remote process are specified as p=
art of
>>> +  this command sub-option. The device to be used to connect to the m=
onitor
>>> +  is also specified as part of this suboption.
>>> +
>>> +  For example, the following option adds a drive and monitor to the =
remote
>>> +  process:
>>> +  -remote rid=3D0,command=3D"-drive id=3Ddrive0,,file=3Ddata-disk.im=
g -monitor unix:/home/qmp-sock,,server,,nowait"
>>> +
>>> +  Note: There's an issue with this "command" subtion which we are in=
 the
>>
>> s/subtion/sub-option/
>>
>>> +  process of fixing. To work around this issue, it requires addition=
al
>>> +  "comma" characters as illustrated above, and in the example below.
>>> +
>>> +* Example QEMU command-line to launch lsi53c895a in a remote process
>>> +
>>> +  #/bin/sh
>>> +  qemu-system-x86_64 \
>>> +  -name "OL7.4" \
>>> +  -machine q35,accel=3Dkvm \
>>> +  -smp sockets=3D1,cores=3D1,threads=3D1 \
>>> +  -cpu host \
>>> +  -m 2048 \
>>> +  -object memory-backend-file,id=3Dmem,mem-path=3D/dev/shm/,size=3D2=
G,share=3Don \
>>> +  -numa node,memdev=3Dmem \
>>> +  -device virtio-scsi-pci,id=3Dvirtio_scsi_pci0 \
>>> +  -drive id=3Ddrive_image1,if=3Dnone,format=3Draw,file=3D/root/ol7.q=
cow2 \
>>> +  -device scsi-hd,id=3Dimage1,drive=3Ddrive_image1,bus=3Dvirtio_scsi=
_pci0.0 \
>>> +  -boot d \
>>> +  -monitor stdio \
>>> +  -vnc :0 \
>>> +  -device lsi53c895a,id=3Dlsi0,remote,rid=3D8,command=3D"qemu-scsi-d=
ev" \
>>> +  -device scsi-hd,id=3Ddrive2,drive=3Ddrive_image2,bus=3Dlsi0.0,scsi=
-id=3D0,remote,rid=3D8,command=3D"qemu-scsi-dev"\
>>> +  -remote rid=3D8,command=3D"-drive id=3Ddrive_image2,,file=3D/root/=
remote-process-disk.img -monitor unix:/home/qmp-sock,,server,,nowait"
>>> +
>>> +  We could connect to the monitor using the following command:
>>> +  socat /home/qmp-sock stdio
>>> +
>>> +  After hotplugging disks to the remote process, please execute the
>>> +  following command in the guest to refresh the list of storage devi=
ces:
>>> +  rescan_scsi_bus.sh -a
>>
>> This documentation suggests that QEMU spawns the remote processes.  Ho=
w
>> do this work with unprivileged QEMU?  Is there an additional step wher=
e
>> QEMU drops privileges after having spawned remote processes?
>=20
> This syntax is for the simple case without privilege separation.
> If differing privilege levels are needed, then whatever spawns QEMU
> should spawn the remote helper process ahead of time, and then just
> pass the UNIX socket path to the -remote arg, instead of using
> the 'command' parameter.
>=20
> Regards,
> Daniel

Thank You, Stefan, Michael & Daniel, for your comments. I had a chance
to sit down with my teammates to understand the feedback you gave at the
KVM Forum. Thank you for that, as well.

We currently support two ways of launching the remote process - one is
self-launch through QEMU, as outlined in this patch series. The other
approach is using an Orchestrator like libvirt (we haven't had the
chance to submit those patches for review yet).

In the case where libvirt is involved, it would assume the
responsibility of spawning the remote process first and pass in the info
required to connect to the remote process via command-line arguments to
QEMU. This support in QEMU is available in the current series. We
haven't sent the libvirt side of patches out for review yet. It would be
easier to upstream libvirt once the QEMU side of things is firmed up.

In the case of self-launch, our understanding is that QEMU has the
privilege to fork() the remote process until the "-sandbox" argument is
processed. However, if an Orchestrator prohibits QEMU from spawning
other processes from the get-go, then the Orchestrator would assume the
responsibility of spawning the remote process as well - like Daniel just
pointed out.

In both cases, we intend to apply the security policies required to
confine the remote process externally - probably through SELinux. We
haven't had the chance to upstream the SELinux policies yet, but we
previously sent a sample of the policies for your comments. Like Michael
pointed out earlier, the SELinux policies are per binary.

Thank you very much!
--
Jag

>=20

