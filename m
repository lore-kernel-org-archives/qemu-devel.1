Return-Path: <SRS0=QiA4=7D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE626C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 19:43:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B871D2065F
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 19:43:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z0L4l1ec"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B871D2065F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51160 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbr6d-0003zO-VH
	for qemu-devel@archiver.kernel.org; Thu, 21 May 2020 15:43:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40104)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1jbqzG-0004B8-Ax
 for qemu-devel@nongnu.org; Thu, 21 May 2020 15:36:14 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:35581
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1jbqzE-0004Nn-Vb
 for qemu-devel@nongnu.org; Thu, 21 May 2020 15:36:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590089771;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JkJZODhmUwm3E25nOk4GS3TRj4fHKfo14VkApp8fUH8=;
 b=Z0L4l1ec4704bHiCEx3FoXxJT/LSKEsRTyM9qLmi6bO9V9pJQnsVk84V45Qh7T4BlAbDK7
 jQAk34xETseko32jZqW67iXOYWoFrMUb3fBSuw0wzk5doucA6pYb+WcD42o+HYIwsXcp+q
 gzbzrvRAPn9m0DxfQnhRHmAygy4AvAw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-403-uNX9P_j-MoW5kDCXCVSKZA-1; Thu, 21 May 2020 15:36:08 -0400
X-MC-Unique: uNX9P_j-MoW5kDCXCVSKZA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9FDC483DE2C;
 Thu, 21 May 2020 19:36:05 +0000 (UTC)
Received: from work-vm (ovpn-113-115.ams2.redhat.com [10.36.113.115])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 15CE161992;
 Thu, 21 May 2020 19:35:40 +0000 (UTC)
Date: Thu, 21 May 2020 20:35:38 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Kirti Wankhede <kwankhede@nvidia.com>
Subject: Re: [PATCH QEMU v23 08/18] vfio: Register SaveVMHandlers for VFIO
 device
Message-ID: <20200521193538.GR2752@work-vm>
References: <1589999088-31477-1-git-send-email-kwankhede@nvidia.com>
 <1589999088-31477-9-git-send-email-kwankhede@nvidia.com>
 <20200521141805.GG2752@work-vm>
 <5a5b54d1-e026-c16f-68ad-78d7300e0ba3@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <5a5b54d1-e026-c16f-68ad-78d7300e0ba3@nvidia.com>
User-Agent: Mutt/1.13.4 (2020-02-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=dgilbert@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/21 04:44:45
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, T_HK_NAME_DR=0.01, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: cohuck@redhat.com, cjia@nvidia.com, aik@ozlabs.ru,
 Zhengxiao.zx@alibaba-inc.com, shuangtai.tst@alibaba-inc.com,
 qemu-devel@nongnu.org, peterx@redhat.com, eauger@redhat.com,
 yi.l.liu@intel.com, eskultet@redhat.com, ziye.yang@intel.com,
 armbru@redhat.com, mlevitsk@redhat.com, pasic@linux.ibm.com,
 felipe@nutanix.com, Ken.Xue@amd.com, kevin.tian@intel.com,
 yan.y.zhao@intel.com, alex.williamson@redhat.com, changpeng.liu@intel.com,
 quintela@redhat.com, zhi.a.wang@intel.com, jonathan.davies@nutanix.com,
 pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Kirti Wankhede (kwankhede@nvidia.com) wrote:
> 
> 
> On 5/21/2020 7:48 PM, Dr. David Alan Gilbert wrote:
> > * Kirti Wankhede (kwankhede@nvidia.com) wrote:
> > > Define flags to be used as delimeter in migration file stream.
> > > Added .save_setup and .save_cleanup functions. Mapped & unmapped migration
> > > region from these functions at source during saving or pre-copy phase.
> > > Set VFIO device state depending on VM's state. During live migration, VM is
> > > running when .save_setup is called, _SAVING | _RUNNING state is set for VFIO
> > > device. During save-restore, VM is paused, _SAVING state is set for VFIO device.
> > > 
> > > Signed-off-by: Kirti Wankhede <kwankhede@nvidia.com>
> > > Reviewed-by: Neo Jia <cjia@nvidia.com>

<snip>

> > > +    register_savevm_live("vfio", VMSTATE_INSTANCE_ID_ANY, 1,
> > > +                         &savevm_vfio_handlers, vbasedev);
> > 
> > Hi,
> >    This is still the only bit which worries me, and I saw your note
> > saying you'd tested it; to calm my nerves, can you run with the
> > 'qemu_loadvm_state_section_startfull' trace enabled with 2 devices
> > and show me the output and qemu command line?
> > I'm trying to figure out how they end up represented in the stream.
> > 
> 
> Created mtty devices for source VM:
> echo "83b8f4f2-509f-382f-3c1e-e6bfe0fa1233" >
> /sys/class/mdev_bus/mtty/mdev_supported_types/mtty-2/create
> echo "83b8f4f2-509f-382f-3c1e-e6bfe0fa1234" >
> /sys/class/mdev_bus/mtty/mdev_supported_types/mtty-2/create
> 
> for destination VM:
> echo "83b8f4f2-509f-382f-3c1e-e6bfe0fa1235" >
> /sys/class/mdev_bus/mtty/mdev_supported_types/mtty-2/create
> echo "83b8f4f2-509f-382f-3c1e-e6bfe0fa1236" >
> /sys/class/mdev_bus/mtty/mdev_supported_types/mtty-2/create
> 
> Source qemu-cmdline:
> /usr/libexec/qemu-kvm \
>  -name guest=rhel75-mig,debug-threads=on \
>  -machine pc-i440fx-3.1,accel=kvm,usb=off,dump-guest-core=off \
>  -cpu SandyBridge,vme=on,hypervisor=on,arat=on,xsaveopt=on \
>  -m 2048 -realtime mlock=off -smp 2,sockets=2,cores=1,threads=1 \
>  -uuid eefb718c-137c-d416-e573-dd74ecd3490d \
>  -drive
> file=/home/vm/rhel-75.qcow2,format=qcow2,if=none,id=drive-ide0-0-0,cache=none
> \
>  -device ide-hd,bus=ide.0,unit=0,drive=drive-ide0-0-0,id=ide0-0-0,bootindex=1,write-cache=on
> \
>  -vnc 127.0.0.1:0 \
>  -device rtl8139,netdev=net0,mac=52:54:b2:88:86:2a,bus=pci.0,addr=0x3
> -netdev tap,id=net0,script=/root/qemu-ifup,downscript=no \
>  -device
> vfio-pci,sysfsdev=/sys/bus/mdev/devices/83b8f4f2-509f-382f-3c1e-e6bfe0fa1233
> \
>  -device
> vfio-pci,sysfsdev=/sys/bus/mdev/devices/83b8f4f2-509f-382f-3c1e-e6bfe0fa1234
> \
>  --trace events=/root/vfio_events \
>  -monitor unix:/tmp/qmp_socket1,server,nowait \
>  -serial stdio \
>  -msg timestamp=on
> 
> Destination qemu-cmdline:
> /usr/libexec/qemu-kvm \
>  -name guest=rhel75-mig,debug-threads=on \
>  -machine pc-i440fx-3.1,accel=kvm,usb=off,dump-guest-core=off \
>  -cpu SandyBridge,vme=on,hypervisor=on,arat=on,xsaveopt=on \
>  -m 2048 -realtime mlock=off -smp 2,sockets=2,cores=1,threads=1 \
>  -uuid eefb718c-137c-d416-e573-dd74ecd3490d \
>  -drive
> file=/home/vm/rhel-75.qcow2,format=qcow2,if=none,id=drive-ide0-0-0,cache=none
> \
>  -device ide-hd,bus=ide.0,unit=0,drive=drive-ide0-0-0,id=ide0-0-0,bootindex=1,write-cache=on
> \
>  -vnc 127.0.0.1:1 \
>  -device rtl8139,netdev=net0,mac=52:54:b2:88:86:2a,bus=pci.0,addr=0x3
> -netdev tap,id=net0,script=/root/qemu-ifup,downscript=no \
>  -device
> vfio-pci,sysfsdev=/sys/bus/mdev/devices/83b8f4f2-509f-382f-3c1e-e6bfe0fa1235
> \
>  -device
> vfio-pci,sysfsdev=/sys/bus/mdev/devices/83b8f4f2-509f-382f-3c1e-e6bfe0fa1236
> \
>  -incoming unix:/tmp/mig_socket \
>  --trace events=/root/vfio_events \
>  -monitor unix:/tmp/qmp_socket2,server,nowait \
>  -serial stdio \
>  -msg timestamp=on
> 
> Migrate:
> echo "migrate_set_speed 0" | sudo nc -U /tmp/qmp_socket1
> echo "migrate -d unix:/tmp/mig_socket" | sudo nc -U $/tmp/qmp_socket1
> 
> After migration, 'qemu_loadvm_state_section_startfull' traces:
> 
> qemu_loadvm_state_section_startfull 0.000 pid=1457 section_id=0x2
> idstr=b'ram' instance_id=0x0 version_id=0x4
> qemu_loadvm_state_section_startfull 515.606 pid=1457 section_id=0x2e
> idstr=b'vfio' instance_id=0x0 version_id=0x1
> qemu_loadvm_state_section_startfull 10.661 pid=1457 section_id=0x2f
> idstr=b'vfio' instance_id=0x1 version_id=0x1

Right, so this is my worry - we have two devices in the stream called
'vfio' with I think sequential id's - what makes each of your source
vfio devices go to the correct destination vfio device?  If the two
devices were different vfio devices, how would you ensure that they
ended up in the write place?  There's no requirement for
the order of the qemu command line on the source and the destination
to be the same, or for qemu to maintain semantics based on the order -
but I bet that's the ordering were getting here.

> idstr=b'0000:00:03.0/rtl8139' instance_id=0x0 version_id=0x5

Now you see that PCI NIC has a nice PCI address as it's name in the
stream; if you have two NICs defined then they end up getting loaded
into the destination device with the same guest PCI address - so it's
nice and repeatable (especially if you specify the PCI devices address
on the command line).

Dave



> qemu_loadvm_state_section_startfull 1619.840 pid=1457 section_id=0x30
> idstr=b'acpi_build' instance_id=0x0 version_id=0x1
> qemu_loadvm_state_section_startfull 4.200 pid=1457 section_id=0x31
> idstr=b'globalstate' instance_id=0x0 version_id=0x1
> 
> Thanks,
> Kirti
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


