Received: from eggs.gnu.org ([2001:4830:134:3::10]:55897)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <haoqf@linux.vnet.ibm.com>) id 1dRuQq-0003jW-0x
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 02:02:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <haoqf@linux.vnet.ibm.com>) id 1dRuQl-0006EK-3t
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 02:02:00 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:43254
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <haoqf@linux.vnet.ibm.com>)
	id 1dRuQk-0006Dj-UB
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 02:01:55 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v635wf79114635
	for <qemu-devel@nongnu.org>; Mon, 3 Jul 2017 02:01:53 -0400
Received: from e19.ny.us.ibm.com (e19.ny.us.ibm.com [129.33.205.209])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2bf13v1jau-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 03 Jul 2017 02:01:53 -0400
Received: from localhost
	by e19.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <haoqf@linux.vnet.ibm.com>;
	Mon, 3 Jul 2017 02:01:52 -0400
References: <1498234919-27316-1-git-send-email-kwolf@redhat.com>
	<1498234919-27316-12-git-send-email-kwolf@redhat.com>
	<4c7f09a2-04b4-25b0-b9c7-cbdb5dc3c795@linux.vnet.ibm.com>
	<20170628102213.GB5378@noname.redhat.com>
From: QingFeng Hao <haoqf@linux.vnet.ibm.com>
Date: Mon, 3 Jul 2017 14:01:45 +0800
MIME-Version: 1.0
In-Reply-To: <20170628102213.GB5378@noname.redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <799c3d2f-237c-9833-e8fe-0af6d461e252@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-block] [PULL 11/61] virtio-pci: use
 ioeventfd even when KVM is disabled
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, Fam Zheng <famz@redhat.com>, stefanha@redhat.com



=E5=9C=A8 2017/6/28 18:22, Kevin Wolf =E5=86=99=E9=81=93:
> Am 28.06.2017 um 12:11 hat QingFeng Hao geschrieben:
>> =E5=9C=A8 2017/6/24 0:21, Kevin Wolf =E5=86=99=E9=81=93:
>>> From: Stefan Hajnoczi <stefanha@redhat.com>
>>>
>>> Old kvm.ko versions only supported a tiny number of ioeventfds so
>>> virtio-pci avoids ioeventfds when kvm_has_many_ioeventfds() returns 0.
>>>
>>> Do not check kvm_has_many_ioeventfds() when KVM is disabled since it
>>> always returns 0.  Since commit 8c56c1a592b5092d91da8d8943c17777d6462=
a6f
>>> ("memory: emulate ioeventfd") it has been possible to use ioeventfds =
in
>>> qtest or TCG mode.
>>>
>>> This patch makes -device virtio-blk-pci,iothread=3Diothread0 work eve=
n
>>> when KVM is disabled.
>>>
>>> I have tested that virtio-blk-pci works under TCG both with and witho=
ut
>>> iothread.
>>>
>>> Cc: Michael S. Tsirkin <mst@redhat.com>
>>> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
>>> Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
>>> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
>>> ---
>>>   hw/virtio/virtio-pci.c | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
>>> index 20d6a08..301920e 100644
>>> --- a/hw/virtio/virtio-pci.c
>>> +++ b/hw/virtio/virtio-pci.c
>>> @@ -1740,7 +1740,7 @@ static void virtio_pci_realize(PCIDevice *pci_d=
ev, Error **errp)
>>>       bool pcie_port =3D pci_bus_is_express(pci_dev->bus) &&
>>>                        !pci_bus_is_root(pci_dev->bus);
>>>
>>> -    if (!kvm_has_many_ioeventfds()) {
>>> +    if (kvm_enabled() && !kvm_has_many_ioeventfds()) {
>>>           proxy->flags &=3D ~VIRTIO_PCI_FLAG_USE_IOEVENTFD;
>>>       }
>> This response is actually for mail thread "Re: [Qemu-devel] [PATCH
>> 1/5] virtio-pci: use ioeventfd even when KVM is disabled"
>> which I didn't receive, sorry.
>> I also saw the failed case of 068 as Fam due to the same cause on
>> s390x and x86.
>> With this patch applied, no failure found. Further investigation
>> shows that the error is in
>> virtio_scsi_dataplane_setup:
>>   if (!virtio_device_ioeventfd_enabled(vdev)) {
>>              error_setg(errp, "ioeventfd is required for iothread");
>>              return;
>>   }
>> call flow is:
>> virtio_device_ioeventfd_enabled-->virtio_bus_ioeventfd_enabled
>> -->k->ioeventfd_enabled-->virtio_pci_ioeventfd_enabled
>> virtio_pci_ioeventfd_enabled checks flag
>> VIRTIO_PCI_FLAG_USE_IOEVENTFD which was
>> cleared in virtio_pci_realize if this patch isn't applied.
> Yes, we know all of this. However, this patch is not correct and causes
> 'make check' failures on some platforms. The open question is where tha=
t
> failure comes from. Before this is solved, the patch can't be applied.
Sorry that I found case 068 of the latest master still fails on s390x=20
(but passed
on x86) and the cause is that s390x uses "-device virtio-scsi-ccw"=20
instead of
"-device virtio-scsi-pci", so the change in virtio_ccw_device_realize is=20
also needed:
diff --git a/hw/s390x/virtio-ccw.c b/hw/s390x/virtio-ccw.c
index 90d37cb..35896eb 100644
--- a/hw/s390x/virtio-ccw.c
+++ b/hw/s390x/virtio-ccw.c
@@ -711,7 +711,7 @@ static void=20
virtio_ccw_device_realize(VirtioCcwDevice *dev, Error
          sch->cssid, sch->ssid, sch->schid, sch->devno,
          ccw_dev->devno.valid ? "user-configured" : "auto-configured");

-    if (!kvm_eventfds_enabled()) {
+    if (kvm_enabled() && !kvm_eventfds_enabled()) {
          dev->flags &=3D ~VIRTIO_CCW_FLAG_USE_IOEVENTFD;
      }

I'll send out a patch for that. Thanks!
> Kevin
>

--=20
Regards
QingFeng Hao
