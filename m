Return-Path: <SRS0=I8Mx=26=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78FE1C32771
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 12:17:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4343B2067D
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 12:17:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JLzgAjzG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4343B2067D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59336 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipWkh-0002kx-DH
	for qemu-devel@archiver.kernel.org; Thu, 09 Jan 2020 07:17:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39785)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1ipWjn-000211-BL
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 07:16:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1ipWjl-0003VS-Sd
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 07:16:31 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:55885
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1ipWjl-0003T9-MJ
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 07:16:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578572189;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LnS3g8bt9YFCsB+GmaJrGvFZ/wWn6sUJ0ZunY+tUbb4=;
 b=JLzgAjzGnB13CQxDfG7EoXEAwDNTtQrlYQHblxpssZt64woOCZS8lVv+6YB6hUyV4WB/g9
 t97+MrPeaJsQlPi69R8bR4+5BDReF6wx4hcuREyfoIGlAVFGSHjwH+qGY+ObDxU9QdTyj6
 9Gae66v3VKw00rGXojy0vkCqjGi6+dg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-294-M-qWrraNPz6yP5ygNkJIlQ-1; Thu, 09 Jan 2020 07:16:26 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 51DDB801E72;
 Thu,  9 Jan 2020 12:16:25 +0000 (UTC)
Received: from work-vm (unknown [10.36.118.29])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B44515C241;
 Thu,  9 Jan 2020 12:16:21 +0000 (UTC)
Date: Thu, 9 Jan 2020 12:16:19 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Roman Kagan <rkagan@virtuozzo.com>, qemu-devel@nongnu.org,
 vkuznets@redhat.com, mst@redhat.com, jasowang@redhat.com
Subject: Re: [PATCH 0/2] exclude hyperv synic sections from vhost
Message-ID: <20200109121619.GC6795@work-vm>
References: <20200108135353.75471-1-dgilbert@redhat.com>
 <20200109115353.GA3147@rkaganb.sw.ru>
MIME-Version: 1.0
In-Reply-To: <20200109115353.GA3147@rkaganb.sw.ru>
User-Agent: Mutt/1.13.0 (2019-11-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: M-qWrraNPz6yP5ygNkJIlQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Roman Kagan (rkagan@virtuozzo.com) wrote:
> On Wed, Jan 08, 2020 at 01:53:51PM +0000, Dr. David Alan Gilbert (git) wr=
ote:
> > Hyperv's synic (that we emulate) is a feature that allows the guest
> > to place some magic (4k) pages of RAM anywhere it likes in GPA.
> > This confuses vhost's RAM section merging when these pages
> > land over the top of hugepages.
> >=20
> > Since they're not normal RAM, and they shouldn't have vhost DMAing
> > into them, exclude them from the vhost set.
>=20
> But they *are* normal RAM.  If the guest driver sets up the device to
> DMA to a SynIC page so be it, and the guest deserves what it gets.

I don't think that's guaranteed to work.
However, in our case the guest isn't doing anything that crazy; it's
just setting the GPA of these pages in an inconveninent place for us.

> > I do that by marking them as device-ram and then excluding device-ram
> > from vhost.
> >=20
> > bz: https://bugzilla.redhat.com/show_bug.cgi?id=3D1779041
>=20
> I was pointed a while back by Vitaly at
> https://bugs.launchpad.net/qemu/+bug/1811533 which appeared to be the
> same issue, but failed to reproduce the problem.  Can you please provide
> some more detail as to how it's triggered?

Our test script is:
/usr/libexec/qemu-kvm \
    -name 'dgilbert-vm1' \
    -machine q35  \
    -nodefaults \
    -device VGA,bus=3Dpcie.0,addr=3D0x1 \
    -m 4096 \
    -object memory-backend-file,size=3D1024M,prealloc=3Dno,mem-path=3D/mnt/=
kvm_hugepage,policy=3Ddefault,id=3Dmem-mem0 \
    -object memory-backend-file,size=3D3072M,prealloc=3Dno,mem-path=3D/mnt/=
kvm_hugepage,policy=3Ddefault,id=3Dmem-mem1  \
    -smp 16,maxcpus=3D16,cores=3D8,threads=3D1,dies=3D1,sockets=3D2  \
    -numa node,memdev=3Dmem-mem0  \
    -numa node,memdev=3Dmem-mem1  \
    -cpu SandyBridge,hv_stimer,hv_time,hv_synic,hv_vpindex \
    -device pcie-root-port,id=3Dpcie.0-root-port-2,slot=3D2,chassis=3D2,add=
r=3D0x2,bus=3Dpcie.0 \
    -device qemu-xhci,id=3Dusb1,bus=3Dpcie.0-root-port-2,addr=3D0x0 \
    -device pcie-root-port,id=3Dpcie.0-root-port-3,slot=3D3,chassis=3D3,add=
r=3D0x3,bus=3Dpcie.0 \
    -device virtio-scsi-pci,id=3Dvirtio_scsi_pci0,bus=3Dpcie.0-root-port-3,=
addr=3D0x0 \
    -drive id=3Ddrive_image1,if=3Dnone,snapshot=3Doff,aio=3Dthreads,cache=
=3Dnone,format=3Dqcow2,file=3D./win2019-64-virtio-scsi.qcow2 \
    -device scsi-hd,id=3Dimage1,drive=3Ddrive_image1 \
    -device pcie-root-port,id=3Dpcie.0-root-port-4,slot=3D4,chassis=3D4,add=
r=3D0x4,bus=3Dpcie.0 \
    -device virtio-net-pci,mac=3D9a:5c:d7:9f:cd:48,id=3Did7ex9m8,netdev=3Di=
dim5Sro,bus=3Dpcie.0-root-port-4,addr=3D0x0  \
    -netdev tap,id=3Didim5Sro,vhost=3Don \
    -device usb-tablet,id=3Dusb-tablet1,bus=3Dusb1.0,port=3D1  \
    -vnc :1  \
    -rtc base=3Dlocaltime,clock=3Dhost,driftfix=3Dslew  \
    -boot order=3Dcdn,once=3Dc,menu=3Doff,strict=3Doff \
    -enable-kvm \
    -device pcie-root-port,id=3Dpcie_extra_root_port_0,slot=3D5,chassis=3D5=
,addr=3D0x5,bus=3Dpcie.0 \
    -monitor stdio -qmp tcp:0:4444,server,nowait

Dave

> Thanks,
> Roman.
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


