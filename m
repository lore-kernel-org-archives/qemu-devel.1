Return-Path: <SRS0=OFvx=W5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF727C3A5A8
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Sep 2019 09:41:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9DB4E217F4
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Sep 2019 09:41:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SpIhaYO4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9DB4E217F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34434 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i4ipc-0005m8-Ok
	for qemu-devel@archiver.kernel.org; Mon, 02 Sep 2019 05:41:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50462)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@gmail.com>) id 1i4iom-0005Ev-RW
 for qemu-devel@nongnu.org; Mon, 02 Sep 2019 05:40:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@gmail.com>) id 1i4ioj-0003GM-Vo
 for qemu-devel@nongnu.org; Mon, 02 Sep 2019 05:40:12 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:35256)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1i4ioj-0003D7-KK
 for qemu-devel@nongnu.org; Mon, 02 Sep 2019 05:40:09 -0400
Received: by mail-wm1-x342.google.com with SMTP id n10so3173014wmj.0
 for <qemu-devel@nongnu.org>; Mon, 02 Sep 2019 02:40:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=gay1X/1hHW67JJmdE8K7QDqpjPpfQBfL53rAv3KFWTE=;
 b=SpIhaYO4HpIkzCFcX9xSUR9jbThTLqE2OLjXwKeBIHKxHRW59Sl11mGLlGR+AAyZnq
 dBfdbmO/rXSBUU5TlU7NPg/6UgvJXzoeQ9TLqmxKnSIgGmdT7lXVPtW3s8pofTPRpmef
 3jaD1N7rjIkokeZpQjWHw0fAUiUeEbB1r341yKEn82i8IH/Dr9UVBBIP2YR3EX9Yli7C
 pySuO5/ZYoFvF1As3mr3lv7+hnB4ddUwq1eXmpMhz3UJf6eVjKgtWBG+jWb+RwIG3pYb
 v7Zupo9ynPYtfTciMHYrIctPRUz0fMASjETWfw46bTWA1Rr1f7D8M4jyy76AF8ZAAGTV
 JO9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=gay1X/1hHW67JJmdE8K7QDqpjPpfQBfL53rAv3KFWTE=;
 b=hpngxAXy4A7zbMklbK47JIFqr6hFckilbB6j8VGnpdlRC+qQbFygF6O82xKA0Ig2et
 sXHNcOKKKAjR6gf7f1R1SaXjrvt3FmcBZYHK15X21Jj0gLiS6XFu1B4pjvUlT0E0nIcE
 2YEkIiwnLq+6FSud0iezzBTfnH5ETQA29r84mgxnLledjqqpR6Wq7+hlvTq6c2dm4JDY
 JgOziLBdOGKXm9/sGveXBo2edjoGP4LI3UOAbInvDCUt+12xEEm47+eCulAu88IbFwFu
 fqrrFzgLfiSSHa4RRShbriVnIj4yurx0lkrGoL4m7f3/SPWu7NI2b1OBSMmkeoX5fQ/x
 fojQ==
X-Gm-Message-State: APjAAAXu0JqV33y2RePOK4MoHtaMkxYkAxX2L66yOCgaB/ggYpZXKXxZ
 4NgRO6Ok84vLZoVnSiwHcM0=
X-Google-Smtp-Source: APXvYqzANa0JLvyvXX4UW4VloEhq6LCOw2Yi0/Mm1sJOtUEX3grTU3C8O+T3ZdcKmRSHIVdat+v+wQ==
X-Received: by 2002:a1c:7ecf:: with SMTP id
 z198mr14607951wmc.175.1567417207054; 
 Mon, 02 Sep 2019 02:40:07 -0700 (PDT)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id a18sm18063472wrt.18.2019.09.02.02.40.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Sep 2019 02:40:06 -0700 (PDT)
Date: Mon, 2 Sep 2019 10:40:04 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Bug 1842038 <1842038@bugs.launchpad.net>
Message-ID: <20190902094004.GE9069@stefanha-x1.localdomain>
References: <156715467564.28583.4532580571142689623.malonedeb@chaenomeles.canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="84ND8YJRMFlzkrP4"
Content-Disposition: inline
In-Reply-To: <156715467564.28583.4532580571142689623.malonedeb@chaenomeles.canonical.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
Subject: Re: [Qemu-devel] [Bug 1842038] [NEW] qemu 4.0/4.1 segfault on live
 migrate with virtio-scsi iothread
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org,
 Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--84ND8YJRMFlzkrP4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 30, 2019 at 08:44:35AM -0000, Dmitriy wrote:
> Public bug reported:

Thanks for reporting this.  There have been fixes for virtio-scsi with
iothreads lately, but QEMU 4.1.0 is fairly recent so it should have most
of them.

Can you try qemu.git/master?

>=20
> [root@kvm-nvme5 qemu]# uname -a
> Linux kvm-nvme5 4.14.35-1902.4.8.el7uek.x86_64 #2 SMP Sun Aug 4 22:25:18 =
GMT 2019 x86_64 x86_64 x86_64 GNU/Linux
>=20
> [root@kvm-nvme5 qemu]# qemu-system-x86_64 --version
> QEMU emulator version 4.1.0 (qemu-4.1.0-1.el7)
> Copyright (c) 2003-2019 Fabrice Bellard and the QEMU Project developers
>=20
> [root@kvm-nvme5 qemu]# libvirtd --version
> libvirtd (libvirt) 5.6.0
>=20
> when migrate=20
> MIGR_OPTS=3D"--live --copy-storage-all --verbose --persistent --undefines=
ource"
> virsh migrate $MIGR_OPTS p12345 qemu+ssh://$SERV/system
>=20
> we got segfault if we have option <driver iothread=3D'1'/> in config for
> virtio-scsi controller
>=20
> [1205674.818067] qemu-system-x86[39744]: segfault at 38 ip
> 00005575890ad411 sp 00007ffd3c10a0e0 error 6 in qemu-system-
> x86_64[5575889ad000+951000]
>=20
> On 4.0 we have error with this context(dont save all output)
> "qemu_coroutine_get_aio_context(co)' failed"
>=20
> If we remove option=20
> <driver iothread=3D'1'/>
> migrate work fine without segfaults
>=20
> 2019-08-30 08:25:35.402+0000: starting up libvirt version: 5.6.0, package=
: 1.el7 (Unknown, 2019-08-06-09:57:56, mock), qemu version: 4.1.0qemu-4.1.0=
-1.el7, kernel: 4.14.35-1902.4.8.el7uek.x86_64, hostname: kvm-nvme5
> LC_ALL=3DC \
> PATH=3D/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin \
> HOME=3D/var/lib/libvirt/qemu/domain-75-p541999 \
> XDG_DATA_HOME=3D/var/lib/libvirt/qemu/domain-75-p541999/.local/share \
> XDG_CACHE_HOME=3D/var/lib/libvirt/qemu/domain-75-p541999/.cache \
> XDG_CONFIG_HOME=3D/var/lib/libvirt/qemu/domain-75-p541999/.config \
> QEMU_AUDIO_DRV=3Dnone \
> /usr/bin/qemu-system-x86_64 \
> -name guest=3Dp541999,debug-threads=3Don \
> -S \
> -object secret,id=3DmasterKey0,format=3Draw,file=3D/var/lib/libvirt/qemu/=
domain-75-p541999/master-key.aes \
> -machine pc-q35-4.0,accel=3Dkvm,usb=3Doff,dump-guest-core=3Doff \
> -cpu Cascadelake-Server,ss=3Don,hypervisor=3Don,tsc-adjust=3Don,umip=3Don=
,pku=3Don,md-clear=3Don,stibp=3Don,arch-capabilities=3Don,xsaves=3Don,rdctl=
-no=3Don,ibrs-all=3Don,skip-l1dfl-vmentry=3Don,mds-no=3Don,hv-time,hv-relax=
ed,hv-vapic,hv-spinlocks=3D0x1000,hv-vpindex,hv-runtime,hv-synic,hv-stimer,=
hv-fre
> quencies,hv-reenlightenment,hv-tlbflush \
> -m 2148 \
> -overcommit mem-lock=3Doff \
> -smp 1,sockets=3D1,cores=3D1,threads=3D1 \
> -object iothread,id=3Diothread1 \
> -uuid ff20ae7f-8cfe-4ec5-bd50-e78f8a167414 \
> -no-user-config \
> -nodefaults \
> -chardev socket,id=3Dcharmonitor,fd=3D44,server,nowait \
> -mon chardev=3Dcharmonitor,id=3Dmonitor,mode=3Dcontrol \
> -rtc base=3Dutc,driftfix=3Dslew \
> -global kvm-pit.lost_tick_policy=3Ddelay \
> -no-shutdown \
> -boot menu=3Don,strict=3Don \
> -device ich9-usb-ehci1,id=3Dusb,bus=3Dpcie.0,addr=3D0x5.0x7 \
> -device ich9-usb-uhci1,masterbus=3Dusb.0,firstport=3D0,bus=3Dpcie.0,multi=
function=3Don,addr=3D0x5 \
> -device ich9-usb-uhci2,masterbus=3Dusb.0,firstport=3D2,bus=3Dpcie.0,addr=
=3D0x5.0x1 \
> -device ich9-usb-uhci3,masterbus=3Dusb.0,firstport=3D4,bus=3Dpcie.0,addr=
=3D0x5.0x2 \
> -device virtio-scsi-pci,iothread=3Diothread1,id=3Dscsi0,bus=3Dpcie.0,addr=
=3D0x9 \
> -device virtio-serial-pci,id=3Dvirtio-serial0,bus=3Dpcie.0,addr=3D0x6 \
> -drive file=3D/dev/vm/p541999,format=3Draw,if=3Dnone,id=3Ddrive-scsi0-0-0=
-0,cache=3Dnone,discard=3Dunmap,aio=3Dthreads,throttling.bps-write=3D524288=
00,throttling.bps-write-max=3D314572800,throttling.bps-write-max-length=3D1=
20 \
> -device scsi-hd,bus=3Dscsi0.0,channel=3D0,scsi-id=3D0,lun=3D0,device_id=
=3Ddrive-scsi0-0-0-0,drive=3Ddrive-scsi0-0-0-0,id=3Dscsi0-0-0-0,bootindex=
=3D2,write-cache=3Don \
> -drive if=3Dnone,id=3Ddrive-sata0-0-0,readonly=3Don \
> -device ide-cd,bus=3Dide.0,drive=3Ddrive-sata0-0-0,id=3Dsata0-0-0,bootind=
ex=3D1 \
> -netdev tap,fd=3D47,id=3Dhostnet0,vhost=3Don,vhostfd=3D48 \
> -device virtio-net-pci,netdev=3Dhostnet0,id=3Dnet0,mac=3D00:00:00:54:19:9=
9,bus=3Dpcie.0,addr=3D0x3 \
> -chardev pty,id=3Dcharserial0 \
> -device isa-serial,chardev=3Dcharserial0,id=3Dserial0 \
> -chardev socket,id=3Dcharchannel0,fd=3D49,server,nowait \
> -device virtserialport,bus=3Dvirtio-serial0.0,nr=3D1,chardev=3Dcharchanne=
l0,id=3Dchannel0,name=3Dorg.qemu.guest_agent.0 \
> -vnc 0.0.0.0:6128,password \
> -device cirrus-vga,id=3Dvideo0,bus=3Dpcie.0,addr=3D0x1 \
> -device virtio-balloon-pci,id=3Dballoon0,bus=3Dpcie.0,addr=3D0x8 \
> -sandbox on,obsolete=3Ddeny,elevateprivileges=3Ddeny,spawn=3Ddeny,resourc=
econtrol=3Ddeny \
> -msg timestamp=3Don
> char device redirected to /dev/pts/5 (label charserial0)
> 2019-08-30 08:27:00.539+0000: shutting down, reason=3Dcrashed
>=20
>=20
> config:
> <domain type=3D'kvm'>
>   <name>p541999</name>
>   <uuid>ff20ae7f-8cfe-4ec5-bd50-e78f8a167414</uuid>
>   <memory unit=3D'KiB'>2199552</memory>
>   <currentMemory unit=3D'KiB'>2199552</currentMemory>
>   <vcpu placement=3D'static'>1</vcpu>
>   <iothreads>1</iothreads>
>   <resource>
>     <partition>/machine</partition>
>   </resource>
>   <os>
>     <type arch=3D'x86_64' machine=3D'pc-q35-4.0'>hvm</type>
>     <boot dev=3D'cdrom'/>
>     <boot dev=3D'hd'/>
>     <bootmenu enable=3D'yes'/>
>   </os>
>   <features>
>     <acpi/>
>     <apic/>
>     <pae/>
>     <hyperv>
>       <relaxed state=3D'on'/>
>       <vapic state=3D'on'/>
>       <spinlocks state=3D'on' retries=3D'4096'/>
>       <vpindex state=3D'on'/>
>       <runtime state=3D'on'/>
>       <synic state=3D'on'/>
>       <stimer state=3D'on'/>
>       <frequencies state=3D'on'/>
>       <reenlightenment state=3D'on'/>
>       <tlbflush state=3D'on'/>
>     </hyperv>
>     <msrs unknown=3D'ignore'/>
>   </features>
>   <cpu mode=3D'host-model' check=3D'full'>
>     <model fallback=3D'forbid'/>
>   </cpu>
>   <clock offset=3D'utc'>
>     <timer name=3D'rtc' tickpolicy=3D'catchup'/>
>     <timer name=3D'pit' tickpolicy=3D'delay'/>
>     <timer name=3D'hpet' present=3D'yes'/>
>     <timer name=3D'hypervclock' present=3D'yes'/>
>   </clock>
>   <on_poweroff>destroy</on_poweroff>
>   <on_reboot>restart</on_reboot>
>   <on_crash>restart</on_crash>
>   <devices>
>     <emulator>/usr/bin/qemu-system-x86_64</emulator>
>     <disk type=3D'block' device=3D'disk'>
>       <driver name=3D'qemu' type=3D'raw' cache=3D'none' io=3D'threads' di=
scard=3D'unmap'/>
>       <source dev=3D'/dev/vm/p541999'/>
>       <backingStore/>
>       <target dev=3D'sda' bus=3D'scsi'/>
>       <iotune>
>         <write_bytes_sec>52428800</write_bytes_sec>
>         <write_bytes_sec_max>314572800</write_bytes_sec_max>
>         <write_bytes_sec_max_length>120</write_bytes_sec_max_length>
>       </iotune>
>       <address type=3D'drive' controller=3D'0' bus=3D'0' target=3D'0' uni=
t=3D'0'/>
>     </disk>
>     <disk type=3D'file' device=3D'cdrom'>
>       <driver name=3D'qemu' type=3D'raw'/>
>       <target dev=3D'sdb' bus=3D'sata'/>
>       <readonly/>
>       <address type=3D'drive' controller=3D'0' bus=3D'0' target=3D'0' uni=
t=3D'0'/>
>     </disk>
>     <controller type=3D'usb' index=3D'0' model=3D'ich9-ehci1'>
>       <address type=3D'pci' domain=3D'0x0000' bus=3D'0x00' slot=3D'0x05' =
function=3D'0x7'/>
>     </controller>
>     <controller type=3D'usb' index=3D'0' model=3D'ich9-uhci1'>
>       <master startport=3D'0'/>
>       <address type=3D'pci' domain=3D'0x0000' bus=3D'0x00' slot=3D'0x05' =
function=3D'0x0' multifunction=3D'on'/>
>     </controller>
>     <controller type=3D'usb' index=3D'0' model=3D'ich9-uhci2'>
>       <master startport=3D'2'/>
>       <address type=3D'pci' domain=3D'0x0000' bus=3D'0x00' slot=3D'0x05' =
function=3D'0x1'/>
>     </controller>
>     <controller type=3D'usb' index=3D'0' model=3D'ich9-uhci3'>
>       <master startport=3D'4'/>
>       <address type=3D'pci' domain=3D'0x0000' bus=3D'0x00' slot=3D'0x05' =
function=3D'0x2'/>
>     </controller>
>     <controller type=3D'virtio-serial' index=3D'0'>
>       <address type=3D'pci' domain=3D'0x0000' bus=3D'0x00' slot=3D'0x06' =
function=3D'0x0'/>
>     </controller>
>     <controller type=3D'scsi' index=3D'0' model=3D'virtio-scsi'>
>       <driver iothread=3D'1'/>
>       <address type=3D'pci' domain=3D'0x0000' bus=3D'0x00' slot=3D'0x09' =
function=3D'0x0'/>
>     </controller>
>     <controller type=3D'pci' index=3D'0' model=3D'pcie-root'/>
>     <controller type=3D'sata' index=3D'0'>
>       <address type=3D'pci' domain=3D'0x0000' bus=3D'0x00' slot=3D'0x1f' =
function=3D'0x2'/>
>     </controller>
>     <interface type=3D'bridge'>
>       <mac address=3D'00:00:00:54:19:99'/>
>       <source bridge=3D'br0'/>
>       <bandwidth>
>         <inbound average=3D'12500' peak=3D'12500' burst=3D'1024'/>
>         <outbound average=3D'12500' peak=3D'12500' burst=3D'1024'/>
>       </bandwidth>
>       <model type=3D'virtio'/>
>       <filterref filter=3D'clean-traffic'>
>         <parameter name=3D'CTRL_IP_LEARNING' value=3D'none'/>
>         <parameter name=3D'IP' value=3D'1.2.3.4'/>
>       </filterref>
>       <address type=3D'pci' domain=3D'0x0000' bus=3D'0x00' slot=3D'0x03' =
function=3D'0x0'/>
>     </interface>
>     <serial type=3D'pty'>
>       <target type=3D'isa-serial' port=3D'0'>
>         <model name=3D'isa-serial'/>
>       </target>
>     </serial>
>     <console type=3D'pty'>
>       <target type=3D'serial' port=3D'0'/>
>     </console>
>     <channel type=3D'unix'>
>       <source mode=3D'bind' path=3D'/var/lib/libvirt/qemu/p541999.agent'/>
>       <target type=3D'virtio' name=3D'org.qemu.guest_agent.0'/>
>       <address type=3D'virtio-serial' controller=3D'0' bus=3D'0' port=3D'=
1'/>
>     </channel>
>     <input type=3D'mouse' bus=3D'ps2'/>
>     <input type=3D'keyboard' bus=3D'ps2'/>
>     <graphics type=3D'vnc' port=3D'12028' autoport=3D'no' listen=3D'0.0.0=
=2E0' passwd=3D'SUPERPASSWORD'>
>       <listen type=3D'address' address=3D'0.0.0.0'/>
>     </graphics>
>     <video>
>       <model type=3D'cirrus' vram=3D'16384' heads=3D'1' primary=3D'yes'/>
>       <address type=3D'pci' domain=3D'0x0000' bus=3D'0x00' slot=3D'0x01' =
function=3D'0x0'/>
>     </video>
>     <memballoon model=3D'virtio'>
>       <address type=3D'pci' domain=3D'0x0000' bus=3D'0x00' slot=3D'0x08' =
function=3D'0x0'/>
>     </memballoon>
>   </devices>
>   <seclabel type=3D'none' model=3D'none'/>
> </domain>
>=20
> ** Affects: qemu
>      Importance: Undecided
>          Status: New
>=20
> --=20
> You received this bug notification because you are a member of qemu-
> devel-ml, which is subscribed to QEMU.
> https://bugs.launchpad.net/bugs/1842038
>=20
> Title:
>   qemu 4.0/4.1 segfault on live migrate with virtio-scsi iothread
>=20
> Status in QEMU:
>   New
>=20
> Bug description:
>   [root@kvm-nvme5 qemu]# uname -a
>   Linux kvm-nvme5 4.14.35-1902.4.8.el7uek.x86_64 #2 SMP Sun Aug 4 22:25:1=
8 GMT 2019 x86_64 x86_64 x86_64 GNU/Linux
>=20
>   [root@kvm-nvme5 qemu]# qemu-system-x86_64 --version
>   QEMU emulator version 4.1.0 (qemu-4.1.0-1.el7)
>   Copyright (c) 2003-2019 Fabrice Bellard and the QEMU Project developers
>=20
>   [root@kvm-nvme5 qemu]# libvirtd --version
>   libvirtd (libvirt) 5.6.0
>=20
>   when migrate=20
>   MIGR_OPTS=3D"--live --copy-storage-all --verbose --persistent --undefin=
esource"
>   virsh migrate $MIGR_OPTS p12345 qemu+ssh://$SERV/system
>=20
>   we got segfault if we have option <driver iothread=3D'1'/> in config for
>   virtio-scsi controller
>=20
>   [1205674.818067] qemu-system-x86[39744]: segfault at 38 ip
>   00005575890ad411 sp 00007ffd3c10a0e0 error 6 in qemu-system-
>   x86_64[5575889ad000+951000]
>=20
>   On 4.0 we have error with this context(dont save all output)
>   "qemu_coroutine_get_aio_context(co)' failed"
>=20
>   If we remove option=20
>   <driver iothread=3D'1'/>
>   migrate work fine without segfaults
>=20
>   2019-08-30 08:25:35.402+0000: starting up libvirt version: 5.6.0, packa=
ge: 1.el7 (Unknown, 2019-08-06-09:57:56, mock), qemu version: 4.1.0qemu-4.1=
=2E0-1.el7, kernel: 4.14.35-1902.4.8.el7uek.x86_64, hostname: kvm-nvme5
>   LC_ALL=3DC \
>   PATH=3D/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin \
>   HOME=3D/var/lib/libvirt/qemu/domain-75-p541999 \
>   XDG_DATA_HOME=3D/var/lib/libvirt/qemu/domain-75-p541999/.local/share \
>   XDG_CACHE_HOME=3D/var/lib/libvirt/qemu/domain-75-p541999/.cache \
>   XDG_CONFIG_HOME=3D/var/lib/libvirt/qemu/domain-75-p541999/.config \
>   QEMU_AUDIO_DRV=3Dnone \
>   /usr/bin/qemu-system-x86_64 \
>   -name guest=3Dp541999,debug-threads=3Don \
>   -S \
>   -object secret,id=3DmasterKey0,format=3Draw,file=3D/var/lib/libvirt/qem=
u/domain-75-p541999/master-key.aes \
>   -machine pc-q35-4.0,accel=3Dkvm,usb=3Doff,dump-guest-core=3Doff \
>   -cpu Cascadelake-Server,ss=3Don,hypervisor=3Don,tsc-adjust=3Don,umip=3D=
on,pku=3Don,md-clear=3Don,stibp=3Don,arch-capabilities=3Don,xsaves=3Don,rdc=
tl-no=3Don,ibrs-all=3Don,skip-l1dfl-vmentry=3Don,mds-no=3Don,hv-time,hv-rel=
axed,hv-vapic,hv-spinlocks=3D0x1000,hv-vpindex,hv-runtime,hv-synic,hv-stime=
r,hv-fre
>   quencies,hv-reenlightenment,hv-tlbflush \
>   -m 2148 \
>   -overcommit mem-lock=3Doff \
>   -smp 1,sockets=3D1,cores=3D1,threads=3D1 \
>   -object iothread,id=3Diothread1 \
>   -uuid ff20ae7f-8cfe-4ec5-bd50-e78f8a167414 \
>   -no-user-config \
>   -nodefaults \
>   -chardev socket,id=3Dcharmonitor,fd=3D44,server,nowait \
>   -mon chardev=3Dcharmonitor,id=3Dmonitor,mode=3Dcontrol \
>   -rtc base=3Dutc,driftfix=3Dslew \
>   -global kvm-pit.lost_tick_policy=3Ddelay \
>   -no-shutdown \
>   -boot menu=3Don,strict=3Don \
>   -device ich9-usb-ehci1,id=3Dusb,bus=3Dpcie.0,addr=3D0x5.0x7 \
>   -device ich9-usb-uhci1,masterbus=3Dusb.0,firstport=3D0,bus=3Dpcie.0,mul=
tifunction=3Don,addr=3D0x5 \
>   -device ich9-usb-uhci2,masterbus=3Dusb.0,firstport=3D2,bus=3Dpcie.0,add=
r=3D0x5.0x1 \
>   -device ich9-usb-uhci3,masterbus=3Dusb.0,firstport=3D4,bus=3Dpcie.0,add=
r=3D0x5.0x2 \
>   -device virtio-scsi-pci,iothread=3Diothread1,id=3Dscsi0,bus=3Dpcie.0,ad=
dr=3D0x9 \
>   -device virtio-serial-pci,id=3Dvirtio-serial0,bus=3Dpcie.0,addr=3D0x6 \
>   -drive file=3D/dev/vm/p541999,format=3Draw,if=3Dnone,id=3Ddrive-scsi0-0=
-0-0,cache=3Dnone,discard=3Dunmap,aio=3Dthreads,throttling.bps-write=3D5242=
8800,throttling.bps-write-max=3D314572800,throttling.bps-write-max-length=
=3D120 \
>   -device scsi-hd,bus=3Dscsi0.0,channel=3D0,scsi-id=3D0,lun=3D0,device_id=
=3Ddrive-scsi0-0-0-0,drive=3Ddrive-scsi0-0-0-0,id=3Dscsi0-0-0-0,bootindex=
=3D2,write-cache=3Don \
>   -drive if=3Dnone,id=3Ddrive-sata0-0-0,readonly=3Don \
>   -device ide-cd,bus=3Dide.0,drive=3Ddrive-sata0-0-0,id=3Dsata0-0-0,booti=
ndex=3D1 \
>   -netdev tap,fd=3D47,id=3Dhostnet0,vhost=3Don,vhostfd=3D48 \
>   -device virtio-net-pci,netdev=3Dhostnet0,id=3Dnet0,mac=3D00:00:00:54:19=
:99,bus=3Dpcie.0,addr=3D0x3 \
>   -chardev pty,id=3Dcharserial0 \
>   -device isa-serial,chardev=3Dcharserial0,id=3Dserial0 \
>   -chardev socket,id=3Dcharchannel0,fd=3D49,server,nowait \
>   -device virtserialport,bus=3Dvirtio-serial0.0,nr=3D1,chardev=3Dcharchan=
nel0,id=3Dchannel0,name=3Dorg.qemu.guest_agent.0 \
>   -vnc 0.0.0.0:6128,password \
>   -device cirrus-vga,id=3Dvideo0,bus=3Dpcie.0,addr=3D0x1 \
>   -device virtio-balloon-pci,id=3Dballoon0,bus=3Dpcie.0,addr=3D0x8 \
>   -sandbox on,obsolete=3Ddeny,elevateprivileges=3Ddeny,spawn=3Ddeny,resou=
rcecontrol=3Ddeny \
>   -msg timestamp=3Don
>   char device redirected to /dev/pts/5 (label charserial0)
>   2019-08-30 08:27:00.539+0000: shutting down, reason=3Dcrashed
>=20
>  =20
>   config:
>   <domain type=3D'kvm'>
>     <name>p541999</name>
>     <uuid>ff20ae7f-8cfe-4ec5-bd50-e78f8a167414</uuid>
>     <memory unit=3D'KiB'>2199552</memory>
>     <currentMemory unit=3D'KiB'>2199552</currentMemory>
>     <vcpu placement=3D'static'>1</vcpu>
>     <iothreads>1</iothreads>
>     <resource>
>       <partition>/machine</partition>
>     </resource>
>     <os>
>       <type arch=3D'x86_64' machine=3D'pc-q35-4.0'>hvm</type>
>       <boot dev=3D'cdrom'/>
>       <boot dev=3D'hd'/>
>       <bootmenu enable=3D'yes'/>
>     </os>
>     <features>
>       <acpi/>
>       <apic/>
>       <pae/>
>       <hyperv>
>         <relaxed state=3D'on'/>
>         <vapic state=3D'on'/>
>         <spinlocks state=3D'on' retries=3D'4096'/>
>         <vpindex state=3D'on'/>
>         <runtime state=3D'on'/>
>         <synic state=3D'on'/>
>         <stimer state=3D'on'/>
>         <frequencies state=3D'on'/>
>         <reenlightenment state=3D'on'/>
>         <tlbflush state=3D'on'/>
>       </hyperv>
>       <msrs unknown=3D'ignore'/>
>     </features>
>     <cpu mode=3D'host-model' check=3D'full'>
>       <model fallback=3D'forbid'/>
>     </cpu>
>     <clock offset=3D'utc'>
>       <timer name=3D'rtc' tickpolicy=3D'catchup'/>
>       <timer name=3D'pit' tickpolicy=3D'delay'/>
>       <timer name=3D'hpet' present=3D'yes'/>
>       <timer name=3D'hypervclock' present=3D'yes'/>
>     </clock>
>     <on_poweroff>destroy</on_poweroff>
>     <on_reboot>restart</on_reboot>
>     <on_crash>restart</on_crash>
>     <devices>
>       <emulator>/usr/bin/qemu-system-x86_64</emulator>
>       <disk type=3D'block' device=3D'disk'>
>         <driver name=3D'qemu' type=3D'raw' cache=3D'none' io=3D'threads' =
discard=3D'unmap'/>
>         <source dev=3D'/dev/vm/p541999'/>
>         <backingStore/>
>         <target dev=3D'sda' bus=3D'scsi'/>
>         <iotune>
>           <write_bytes_sec>52428800</write_bytes_sec>
>           <write_bytes_sec_max>314572800</write_bytes_sec_max>
>           <write_bytes_sec_max_length>120</write_bytes_sec_max_length>
>         </iotune>
>         <address type=3D'drive' controller=3D'0' bus=3D'0' target=3D'0' u=
nit=3D'0'/>
>       </disk>
>       <disk type=3D'file' device=3D'cdrom'>
>         <driver name=3D'qemu' type=3D'raw'/>
>         <target dev=3D'sdb' bus=3D'sata'/>
>         <readonly/>
>         <address type=3D'drive' controller=3D'0' bus=3D'0' target=3D'0' u=
nit=3D'0'/>
>       </disk>
>       <controller type=3D'usb' index=3D'0' model=3D'ich9-ehci1'>
>         <address type=3D'pci' domain=3D'0x0000' bus=3D'0x00' slot=3D'0x05=
' function=3D'0x7'/>
>       </controller>
>       <controller type=3D'usb' index=3D'0' model=3D'ich9-uhci1'>
>         <master startport=3D'0'/>
>         <address type=3D'pci' domain=3D'0x0000' bus=3D'0x00' slot=3D'0x05=
' function=3D'0x0' multifunction=3D'on'/>
>       </controller>
>       <controller type=3D'usb' index=3D'0' model=3D'ich9-uhci2'>
>         <master startport=3D'2'/>
>         <address type=3D'pci' domain=3D'0x0000' bus=3D'0x00' slot=3D'0x05=
' function=3D'0x1'/>
>       </controller>
>       <controller type=3D'usb' index=3D'0' model=3D'ich9-uhci3'>
>         <master startport=3D'4'/>
>         <address type=3D'pci' domain=3D'0x0000' bus=3D'0x00' slot=3D'0x05=
' function=3D'0x2'/>
>       </controller>
>       <controller type=3D'virtio-serial' index=3D'0'>
>         <address type=3D'pci' domain=3D'0x0000' bus=3D'0x00' slot=3D'0x06=
' function=3D'0x0'/>
>       </controller>
>       <controller type=3D'scsi' index=3D'0' model=3D'virtio-scsi'>
>         <driver iothread=3D'1'/>
>         <address type=3D'pci' domain=3D'0x0000' bus=3D'0x00' slot=3D'0x09=
' function=3D'0x0'/>
>       </controller>
>       <controller type=3D'pci' index=3D'0' model=3D'pcie-root'/>
>       <controller type=3D'sata' index=3D'0'>
>         <address type=3D'pci' domain=3D'0x0000' bus=3D'0x00' slot=3D'0x1f=
' function=3D'0x2'/>
>       </controller>
>       <interface type=3D'bridge'>
>         <mac address=3D'00:00:00:54:19:99'/>
>         <source bridge=3D'br0'/>
>         <bandwidth>
>           <inbound average=3D'12500' peak=3D'12500' burst=3D'1024'/>
>           <outbound average=3D'12500' peak=3D'12500' burst=3D'1024'/>
>         </bandwidth>
>         <model type=3D'virtio'/>
>         <filterref filter=3D'clean-traffic'>
>           <parameter name=3D'CTRL_IP_LEARNING' value=3D'none'/>
>           <parameter name=3D'IP' value=3D'1.2.3.4'/>
>         </filterref>
>         <address type=3D'pci' domain=3D'0x0000' bus=3D'0x00' slot=3D'0x03=
' function=3D'0x0'/>
>       </interface>
>       <serial type=3D'pty'>
>         <target type=3D'isa-serial' port=3D'0'>
>           <model name=3D'isa-serial'/>
>         </target>
>       </serial>
>       <console type=3D'pty'>
>         <target type=3D'serial' port=3D'0'/>
>       </console>
>       <channel type=3D'unix'>
>         <source mode=3D'bind' path=3D'/var/lib/libvirt/qemu/p541999.agent=
'/>
>         <target type=3D'virtio' name=3D'org.qemu.guest_agent.0'/>
>         <address type=3D'virtio-serial' controller=3D'0' bus=3D'0' port=
=3D'1'/>
>       </channel>
>       <input type=3D'mouse' bus=3D'ps2'/>
>       <input type=3D'keyboard' bus=3D'ps2'/>
>       <graphics type=3D'vnc' port=3D'12028' autoport=3D'no' listen=3D'0.0=
=2E0.0' passwd=3D'SUPERPASSWORD'>
>         <listen type=3D'address' address=3D'0.0.0.0'/>
>       </graphics>
>       <video>
>         <model type=3D'cirrus' vram=3D'16384' heads=3D'1' primary=3D'yes'=
/>
>         <address type=3D'pci' domain=3D'0x0000' bus=3D'0x00' slot=3D'0x01=
' function=3D'0x0'/>
>       </video>
>       <memballoon model=3D'virtio'>
>         <address type=3D'pci' domain=3D'0x0000' bus=3D'0x00' slot=3D'0x08=
' function=3D'0x0'/>
>       </memballoon>
>     </devices>
>     <seclabel type=3D'none' model=3D'none'/>
>   </domain>
>=20
> To manage notifications about this bug go to:
> https://bugs.launchpad.net/qemu/+bug/1842038/+subscriptions
>=20

--84ND8YJRMFlzkrP4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl1s43QACgkQnKSrs4Gr
c8iwxQgAiuY6GhBiy3/5uFsXPF/XHCLYWjwItWJVNWySuvHg5oSTabmtFqzhyOyf
cKmbtsP9zicDHTftVlAWM7IXh8MvqvIQc3HqvURs34UENh3ev4zBq+AQ+hqaIWDh
32xO/DAf9eFcuURHPmUkK/5XVSg4zq6fQSYndo/R5wcSDnCGtnpULhAsRyC8Drzu
fnLPSED2TL0TjHONdiHQVkbpcfP2v/yzqXMKAzoyPO/Hn3rg7oQZN/jJ43X5BJrz
ojOpsQzb0anCBoh2Z/WgCA0wvf2RwvCBxGSFB+nxMqIWADXcMwuIwiKCRwPA7+Gg
tFaD21W7LBgtPe9nDcjosTwm65U2EQ==
=TSZe
-----END PGP SIGNATURE-----

--84ND8YJRMFlzkrP4--

