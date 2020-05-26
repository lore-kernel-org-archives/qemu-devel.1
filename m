Return-Path: <SRS0=4PQo=7I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 205A2C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 13:29:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DFB4E207CB
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 13:29:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fjqL79hn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFB4E207CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34414 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdZeJ-0004BI-4Z
	for qemu-devel@archiver.kernel.org; Tue, 26 May 2020 09:29:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56454)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vgoyal@redhat.com>) id 1jdZdV-0003Jd-VO
 for qemu-devel@nongnu.org; Tue, 26 May 2020 09:28:53 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:58655
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <vgoyal@redhat.com>) id 1jdZdT-00056g-O2
 for qemu-devel@nongnu.org; Tue, 26 May 2020 09:28:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590499730;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bTJxnnea/Sm6c60lh4Fsytq7DTrCBB3u8XDeELCUU/E=;
 b=fjqL79hngvYzmATkLtxwde9t38JNZI7y/eFUPVmJUCwR9xC9GihhnRnD7xC7wwcgixE7/0
 0NnqDpvtHjjqpOX0pmCp6kV6ScuQ72cmJkp9lTDMxcOvaJmReSgxmEMRE7hGxYbOaeHkws
 tSWuAyQshiltGdg9R+z4iDN4zu25M5A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-498-aPcof9r5O7aL4PvDK3P1gg-1; Tue, 26 May 2020 09:28:48 -0400
X-MC-Unique: aPcof9r5O7aL4PvDK3P1gg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E62AF801504;
 Tue, 26 May 2020 13:28:46 +0000 (UTC)
Received: from horse.redhat.com (ovpn-115-102.rdu2.redhat.com [10.10.115.102])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 146E95C1BB;
 Tue, 26 May 2020 13:28:41 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
 id 6C62822036E; Tue, 26 May 2020 09:28:40 -0400 (EDT)
Date: Tue, 26 May 2020 09:28:40 -0400
From: Vivek Goyal <vgoyal@redhat.com>
To: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v1] pc: Support coldplugging of virtio-pmem-pci devices
 on all buses
Message-ID: <20200526132840.GD108774@redhat.com>
References: <20200525084511.51379-1-david@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200525084511.51379-1-david@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/mixed; boundary="PNTmBPCT7hxwcZjr"
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=vgoyal@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/26 01:19:28
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Pankaj Gupta <pankaj.gupta.linux@gmail.com>,
 Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 qemu-devel@nongnu.org, Igor Mammedov <imammedo@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--PNTmBPCT7hxwcZjr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, May 25, 2020 at 10:45:11AM +0200, David Hildenbrand wrote:
> E.g., with "pc-q35-4.2", trying to coldplug a virtio-pmem-pci devices
> results in
>     "virtio-pmem-pci not supported on this bus"
> 
> Reasons is, that the bus does not support hotplug and, therefore, does
> not have a hotplug handler. Let's allow coldplugging virtio-pmem devices
> on such buses. The hotplug order is only relevant for virtio-pmem-pci
> when the guest is already alive and the device is visible before
> memory_device_plug() wired up the memory device bits.
> 
> Hotplug attempts will still fail with:
>     "Error: Bus 'pcie.0' does not support hotplugging"
> 
> Hotunplug attempts will still fail with:
>     "Error: Bus 'pcie.0' does not support hotplugging"
> 
> Reported-by: Vivek Goyal <vgoyal@redhat.com>
> Cc: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
> Cc: Igor Mammedov <imammedo@redhat.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Richard Henderson <rth@twiddle.net>
> Cc: Eduardo Habkost <ehabkost@redhat.com>
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  hw/i386/pc.c | 18 ++++++++++--------
>  1 file changed, 10 insertions(+), 8 deletions(-)

Thanks for the patch David. I still seem to face a different error though.

2020-05-26T13:26:05.720617Z qemu-system-x86_64: -device virtio-pmem-pci,memdev=pmem1,id=nv1: memory devices (e.g. for memory hotplug) are not enabled, please specify the maxmem option

Following is my domain xml file.

Vivek



--PNTmBPCT7hxwcZjr
Content-Type: text/xml; charset=us-ascii
Content-Disposition: attachment; filename="vivek-vm-definition.xml"

<domain type='kvm' xmlns:qemu='http://libvirt.org/schemas/domain/qemu/1.0'>
  <name>vm2-f30</name>
  <uuid>c15287f2-9e66-4867-99dc-d77ece6486c8</uuid>
  <metadata>
    <libosinfo:libosinfo xmlns:libosinfo="http://libosinfo.org/xmlns/libvirt/domain/1.0">
      <libosinfo:os id="http://fedoraproject.org/fedora/30"/>
    </libosinfo:libosinfo>
  </metadata>
  <memory unit='KiB'>67108864</memory>
  <currentMemory unit='KiB'>67108864</currentMemory>
  <vcpu placement='static'>64</vcpu>
  <os>
    <type arch='x86_64' machine='pc-q35-4.2'>hvm</type>
    <boot dev='hd'/>
  </os>
  <features>
    <acpi/>
    <apic/>
    <vmport state='off'/>
  </features>
  <cpu mode='host-model' check='partial'>
    <model fallback='allow'/>
  </cpu>
  <clock offset='utc'>
    <timer name='rtc' tickpolicy='catchup'/>
    <timer name='pit' tickpolicy='delay'/>
    <timer name='hpet' present='no'/>
  </clock>
  <on_poweroff>destroy</on_poweroff>
  <on_reboot>restart</on_reboot>
  <on_crash>destroy</on_crash>
  <pm>
    <suspend-to-mem enabled='no'/>
    <suspend-to-disk enabled='no'/>
  </pm>
  <devices>
    <emulator>/usr/bin/qemu-kvm</emulator>
    <disk type='file' device='disk'>
      <driver name='qemu' type='qcow2'/>
      <source file='/var/lib/libvirt/images/vm2-f30.qcow2'/>
      <target dev='vda' bus='virtio'/>
      <address type='pci' domain='0x0000' bus='0x04' slot='0x00' function='0x0'/>
    </disk>
    <disk type='file' device='cdrom'>
      <driver name='qemu' type='raw'/>
      <target dev='sda' bus='sata'/>
      <readonly/>
      <address type='drive' controller='0' bus='0' target='0' unit='0'/>
    </disk>
    <controller type='usb' index='0' model='qemu-xhci' ports='15'>
      <address type='pci' domain='0x0000' bus='0x02' slot='0x00' function='0x0'/>
    </controller>
    <controller type='sata' index='0'>
      <address type='pci' domain='0x0000' bus='0x00' slot='0x1f' function='0x2'/>
    </controller>
    <controller type='pci' index='0' model='pcie-root'/>
    <controller type='pci' index='1' model='pcie-root-port'>
      <model name='pcie-root-port'/>
      <target chassis='1' port='0x10'/>
      <address type='pci' domain='0x0000' bus='0x00' slot='0x02' function='0x0' multifunction='on'/>
    </controller>
    <controller type='pci' index='2' model='pcie-root-port'>
      <model name='pcie-root-port'/>
      <target chassis='2' port='0x11'/>
      <address type='pci' domain='0x0000' bus='0x00' slot='0x02' function='0x1'/>
    </controller>
    <controller type='pci' index='3' model='pcie-root-port'>
      <model name='pcie-root-port'/>
      <target chassis='3' port='0x12'/>
      <address type='pci' domain='0x0000' bus='0x00' slot='0x02' function='0x2'/>
    </controller>
    <controller type='pci' index='4' model='pcie-root-port'>
      <model name='pcie-root-port'/>
      <target chassis='4' port='0x13'/>
      <address type='pci' domain='0x0000' bus='0x00' slot='0x02' function='0x3'/>
    </controller>
    <controller type='pci' index='5' model='pcie-root-port'>
      <model name='pcie-root-port'/>
      <target chassis='5' port='0x14'/>
      <address type='pci' domain='0x0000' bus='0x00' slot='0x02' function='0x4'/>
    </controller>
    <controller type='pci' index='6' model='pcie-root-port'>
      <model name='pcie-root-port'/>
      <target chassis='6' port='0x15'/>
      <address type='pci' domain='0x0000' bus='0x00' slot='0x02' function='0x5'/>
    </controller>
    <controller type='pci' index='7' model='pcie-root-port'>
      <model name='pcie-root-port'/>
      <target chassis='7' port='0x16'/>
      <address type='pci' domain='0x0000' bus='0x00' slot='0x02' function='0x6'/>
    </controller>
    <controller type='virtio-serial' index='0'>
      <address type='pci' domain='0x0000' bus='0x03' slot='0x00' function='0x0'/>
    </controller>
    <interface type='network'>
      <mac address='52:54:00:51:b6:34'/>
      <source network='default'/>
      <model type='virtio'/>
      <address type='pci' domain='0x0000' bus='0x01' slot='0x00' function='0x0'/>
    </interface>
    <serial type='pty'>
      <target type='isa-serial' port='0'>
        <model name='isa-serial'/>
      </target>
    </serial>
    <console type='pty'>
      <target type='serial' port='0'/>
    </console>
    <channel type='unix'>
      <target type='virtio' name='org.qemu.guest_agent.0'/>
      <address type='virtio-serial' controller='0' bus='0' port='1'/>
    </channel>
    <channel type='spicevmc'>
      <target type='virtio' name='com.redhat.spice.0'/>
      <address type='virtio-serial' controller='0' bus='0' port='2'/>
    </channel>
    <input type='tablet' bus='usb'>
      <address type='usb' bus='0' port='1'/>
    </input>
    <input type='mouse' bus='ps2'/>
    <input type='keyboard' bus='ps2'/>
    <graphics type='spice' autoport='yes'>
      <listen type='address'/>
      <image compression='off'/>
    </graphics>
    <sound model='ich9'>
      <address type='pci' domain='0x0000' bus='0x00' slot='0x1b' function='0x0'/>
    </sound>
    <video>
      <model type='qxl' ram='65536' vram='65536' vgamem='16384' heads='1' primary='yes'/>
      <address type='pci' domain='0x0000' bus='0x00' slot='0x01' function='0x0'/>
    </video>
    <redirdev bus='usb' type='spicevmc'>
      <address type='usb' bus='0' port='2'/>
    </redirdev>
    <redirdev bus='usb' type='spicevmc'>
      <address type='usb' bus='0' port='3'/>
    </redirdev>
    <memballoon model='virtio'>
      <address type='pci' domain='0x0000' bus='0x05' slot='0x00' function='0x0'/>
    </memballoon>
    <rng model='virtio'>
      <backend model='random'>/dev/urandom</backend>
      <address type='pci' domain='0x0000' bus='0x06' slot='0x00' function='0x0'/>
    </rng>
  </devices>
  <qemu:commandline>
    <qemu:arg value='-fsdev'/>
    <qemu:arg value='local,id=extra1,path=/mnt/virtio-9p-dir,security_model=none'/>
    <qemu:arg value='-device'/>
    <qemu:arg value='virtio-9p-pci,fsdev=extra1,mount_tag=hostShared'/>
    <qemu:arg value='-object'/>
    <qemu:arg value='memory-backend-file,id=mem,size=64G,mem-path=/dev/shm,share=on'/>
    <qemu:arg value='-numa'/>
    <qemu:arg value='node,memdev=mem'/>
    <qemu:arg value='-chardev'/>
    <qemu:arg value='socket,id=char0,path=/tmp/vhostqemu'/>
    <qemu:arg value='-device'/>
    <qemu:arg value='vhost-user-fs-pci,id=myvirtiofs,chardev=char0,tag=myfs,cache-size=64G,queue-size=1024'/>
    <qemu:arg value='-object'/>
    <qemu:arg value='memory-backend-file,id=pmem1,mem-path=/var/lib/libvirt/images/pmem-vm2-f30.img,share=on,size=4G'/>
    <qemu:arg value='-device'/>
    <qemu:arg value='virtio-pmem-pci,memdev=pmem1,id=nv1'/>
  </qemu:commandline>
</domain>


--PNTmBPCT7hxwcZjr--


