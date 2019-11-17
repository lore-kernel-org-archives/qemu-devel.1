Return-Path: <SRS0=ZAHP=ZJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D80B5C432C0
	for <qemu-devel@archiver.kernel.org>; Sun, 17 Nov 2019 04:32:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 955B020729
	for <qemu-devel@archiver.kernel.org>; Sun, 17 Nov 2019 04:32:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V5/gnfZN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 955B020729
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52012 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iWCEV-0006og-Kp
	for qemu-devel@archiver.kernel.org; Sat, 16 Nov 2019 23:32:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38456)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.williamson@redhat.com>) id 1iWCDc-00064h-Dp
 for qemu-devel@nongnu.org; Sat, 16 Nov 2019 23:31:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.williamson@redhat.com>) id 1iWCDY-0000IX-Gm
 for qemu-devel@nongnu.org; Sat, 16 Nov 2019 23:31:21 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:48884
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
 id 1iWCDX-0000Hq-Po
 for qemu-devel@nongnu.org; Sat, 16 Nov 2019 23:31:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573965078;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qgXCx/9VD777dNyTWlKVXrktmLIt4sujPloyB0IXgXg=;
 b=V5/gnfZN7E5y9hSwLpYRqheaGxNSxR6cbROfh40nF2rDMHaCB/57Sk9h4gxexA8vEnm6XA
 oCVvYLRlIPkJXX2J5xaRcduTr8XcRjCo3txByRbPm4z5s/iFOZt5TskeK29wOvnHGFefpq
 vGUfHWT5Q1nej69z6iFipnC9QKuz/tE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-84-jRYUekB9Mq6r2lvYf2RGtw-1; Sat, 16 Nov 2019 23:31:17 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 722FF801FA1;
 Sun, 17 Nov 2019 04:31:16 +0000 (UTC)
Received: from x1.home (ovpn-116-56.phx2.redhat.com [10.3.116.56])
 by smtp.corp.redhat.com (Postfix) with ESMTP id EE258100EBB2;
 Sun, 17 Nov 2019 04:31:15 +0000 (UTC)
Date: Sat, 16 Nov 2019 21:31:15 -0700
From: Alex Williamson <alex.williamson@redhat.com>
To: Marcelo Tosatti <mtosatti@redhat.com>
Subject: Re: [PATCH v2] mc146818rtc: fix timer interrupt reinjection
Message-ID: <20191116213115.611d8028@x1.home>
In-Reply-To: <20191117032015.GA4568@amt.cnet>
References: <20191010123008.GA19158@amt.cnet> <20191116135855.5e16bb7c@x1.home>
 <20191117032015.GA4568@amt.cnet>
Organization: Red Hat
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: jRYUekB9Mq6r2lvYf2RGtw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Xiao Guangrong <guangrong.xiao@gmail.com>, qemu-devel <qemu-devel@nongnu.org>,
 Vadim Rozenfeld <vrozenfe@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, 17 Nov 2019 01:20:19 -0200
Marcelo Tosatti <mtosatti@redhat.com> wrote:

> On Sat, Nov 16, 2019 at 01:58:55PM -0700, Alex Williamson wrote:
> > On Thu, 10 Oct 2019 09:30:08 -0300
> > Marcelo Tosatti <mtosatti@redhat.com> wrote:
> >  =20
> > > commit 369b41359af46bded5799c9ef8be2b641d92e043 broke timer interrupt
> > > reinjection when there is no period change by the guest.
> > >=20
> > > In that case, old_period is 0, which ends up zeroing irq_coalesced
> > > (counter of reinjected interrupts).
> > >=20
> > > The consequence is Windows 7 is unable to synchronize time via NTP.
> > > Easily reproducible by playing a fullscreen video with cirrus and VNC=
.
> > >=20
> > > Fix by not updating s->irq_coalesced when old_period is 0.
> > >=20
> > > V2: reorganize code (Paolo Bonzini)
> > >=20
> > > Signed-off-by: Marcelo Tosatti <mtosatti@redhat.com> =20
> >=20
> > This causes a regression for me, my win10 VM with assigned GPU
> > experiences hangs and slowness with this.  Found via bisect, reverting
> > restores normal behavior.  libvirt uses this commandline:
> >=20
> > /usr/local/bin/qemu-system-x86_64 \
> > -name guest=3DSteam-GeForce,debug-threads=3Don \
> > -S \
> > -object secret,id=3DmasterKey0,format=3Draw,file=3D/var/lib/libvirt/qem=
u/domain-1-Steam-GeForce/master-key.aes \
> > -machine pc-i440fx-4.1,accel=3Dkvm,usb=3Doff,vmport=3Doff,dump-guest-co=
re=3Doff \
> > -cpu host,hv-time,hv-relaxed,hv-vapic,hv-spinlocks=3D0x1fff,hv-vendor-i=
d=3DKeenlyKVM,kvm=3Doff \
> > -drive file=3D/usr/share/edk2/ovmf/OVMF_CODE.fd,if=3Dpflash,format=3Dra=
w,unit=3D0,readonly=3Don \
> > -drive file=3D/var/lib/libvirt/qemu/nvram/Steam_VARS.fd,if=3Dpflash,for=
mat=3Draw,unit=3D1 \
> > -m 4096 \
> > -mem-prealloc \
> > -mem-path /dev/hugepages/libvirt/qemu/1-Steam-GeForce \
> > -overcommit mem-lock=3Doff \
> > -smp 4,sockets=3D1,cores=3D2,threads=3D2 \
> > -uuid 2b417d4b-f25b-4522-a5be-e105f032f99c \
> > -display none \
> > -no-user-config \
> > -nodefaults \
> > -chardev socket,id=3Dcharmonitor,fd=3D38,server,nowait \
> > -mon chardev=3Dcharmonitor,id=3Dmonitor,mode=3Dcontrol \
> > -rtc base=3Dlocaltime,driftfix=3Dslew \
> > -global kvm-pit.lost_tick_policy=3Ddelay \
> > -no-hpet \
> > -no-shutdown \
> > -boot menu=3Don,strict=3Don \
> > -device nec-usb-xhci,id=3Dusb,bus=3Dpci.0,addr=3D0x8 \
> > -device virtio-scsi-pci,id=3Dscsi0,num_queues=3D4,bus=3Dpci.0,addr=3D0x=
5 \
> > -drive file=3D/mnt/ssd/Steam.qcow2,format=3Dqcow2,if=3Dnone,id=3Ddrive-=
scsi0-0-0-0,cache=3Dnone \
> > -device scsi-hd,bus=3Dscsi0.0,channel=3D0,scsi-id=3D0,lun=3D0,device_id=
=3Ddrive-scsi0-0-0-0,drive=3Ddrive-scsi0-0-0-0,id=3Dscsi0-0-0-0,bootindex=
=3D2,write-cache=3Don \
> > -netdev tap,fd=3D40,id=3Dhostnet0,vhost=3Don,vhostfd=3D41 \
> > -device virtio-net-pci,netdev=3Dhostnet0,id=3Dnet0,mac=3D52:54:00:60:ef=
:ac,bus=3Dpci.0,addr=3D0x3 \
> > -device vfio-pci,host=3D0000:01:00.0,id=3Dhostdev0,bus=3Dpci.0,addr=3D0=
x4,rombar=3D1 \
> > -device vfio-pci,host=3D0000:01:00.1,id=3Dhostdev1,bus=3Dpci.0,addr=3D0=
x6,rombar=3D0 \
> > -S \
> > -debugcon file:/tmp/Steam-ovmf-debug.log \
> > -global isa-debugcon.iobase=3D0x402 \
> > -set device.hostdev0.x-pci-vendor-id=3D0x10de \
> > -trace events=3D/var/lib/libvirt/images/Steam-GeForce.events \
> > -sandbox on,obsolete=3Ddeny,elevateprivileges=3Ddeny,spawn=3Ddeny,resou=
rcecontrol=3Ddeny \
> > -msg timestamp=3Don =20
>=20
> Alex,
>=20
> -rtc base=3Dlocaltime,driftfix=3Dnone should fix it. Can you confirm?

How do I translate that to xml?  I'm currently using:

  <clock offset=3D'localtime'>
    <timer name=3D'rtc' tickpolicy=3D'catchup'/>
    <timer name=3D'pit' tickpolicy=3D'delay'/>
    <timer name=3D'hpet' present=3D'no'/>
    <timer name=3D'hypervclock' present=3D'yes'/>
  </clock>

According to this[1] bz, 'catchup' translates to 'slew' and seems to be
the default policy in use.  The 'discard' option seemed the most
likely, but my VM fails to start with that:

error: unsupported configuration: unsupported rtc timer tickpolicy 'discard=
'

The 'merge' option gives me a similar error.  The 'delay' option is the
only other choice where I can actually start the VM, but this results in
the commandline:

-rtc base=3Dlocaltime

(no driftfix specified)  This does appear to resolve the issue, but of
course compatibility with existing configurations has regressed.
Thanks,

Alex

[1] https://bugzilla.redhat.com/show_bug.cgi?id=3D865315


