Return-Path: <SRS0=Q7uJ=36=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DEECC352A4
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2020 22:06:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E88612070A
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2020 22:06:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K5n4Uy9v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E88612070A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40350 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1HCT-0001Tk-VM
	for qemu-devel@archiver.kernel.org; Mon, 10 Feb 2020 17:06:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58840)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.williamson@redhat.com>) id 1j1HBA-0000gw-U8
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 17:05:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.williamson@redhat.com>) id 1j1HB7-0002xe-5v
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 17:05:19 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:25457
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
 id 1j1HB6-0002tS-Oj
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 17:05:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581372315;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=435qkshwGHgHbCS1Cai9TNd9TAzS3Rk8kzx/l5pUUEM=;
 b=K5n4Uy9vwfCyBvyRHiitwnxRAZsLOiSOp/34kf0lDiKD1VxViAw7e8tLi0m4H4b0FjxxJ1
 sX+YEIUHS2kiApxntxqyNkKNV//RSkJS30vIRCdHFT7MVT2R9UbvQgZK8tLY4h+qYRTs1Q
 kSoq0OYN2hVyYc1mEbY9xqzABNcOfp4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-236-GvFT7E0HO6GSSw_DW1SSDw-1; Mon, 10 Feb 2020 17:05:14 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6803C18FF660
 for <qemu-devel@nongnu.org>; Mon, 10 Feb 2020 22:05:13 +0000 (UTC)
Received: from w520.home (ovpn-116-28.phx2.redhat.com [10.3.116.28])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3AD905C101;
 Mon, 10 Feb 2020 22:05:13 +0000 (UTC)
Date: Mon, 10 Feb 2020 15:05:12 -0700
From: Alex Williamson <alex.williamson@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PULL 20/59] target/i386: kvm: initialize microcode revision
 from KVM
Message-ID: <20200210150512.2c66704a@w520.home>
In-Reply-To: <20200207085158.208e86c4@x1.home>
References: <1579787449-27599-1-git-send-email-pbonzini@redhat.com>
 <1579787449-27599-21-git-send-email-pbonzini@redhat.com>
 <20200206162412.11d5b9c6@w520.home>
 <f2e74bc5-b3ce-c917-d0d3-bd9a8a194c36@redhat.com>
 <20200207085158.208e86c4@x1.home>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: GvFT7E0HO6GSSw_DW1SSDw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 7 Feb 2020 08:51:58 -0700
Alex Williamson <alex.williamson@redhat.com> wrote:

> On Fri, 7 Feb 2020 00:40:31 +0100
> Paolo Bonzini <pbonzini@redhat.com> wrote:
> 
> > On 07/02/20 00:24, Alex Williamson wrote:  
> > > Hey Paolo,
> > > 
> > > My Windows 10 VM boot loops with this :-\  It seems to be related to
> > > the CPU model.  Now fails (host-passthrough):
> > > 
> > > -cpu host,hv-time,hv-relaxed,hv-vapic,hv-spinlocks=0x1fff,hv-vendor-id=KeenlyKVM,kvm=off    
> > 
> > Can you try adding ucode-rev=0x100000000 just to double check that it's
> > the microcode version?   
> 
> Yes, it boots with:
> 
> -cpu host,hv-time,hv-relaxed,hv-vapic,hv-spinlocks=0x1fff,hv-vendor-id=KeenlyKVM,kvm=off,ucode-rev=0x100000000
> 
> > Also perhaps doing "rdmsr 0x8b" and if you have
> > anything set in bits 0-31 clearing them.  
> 
> How would I do that?  Thanks,

Here's the simplest case that I can reproduce with:

/usr/local/bin/qemu-system-x86_64 \
-S \
-machine pc,accel=kvm \
-cpu host \
-m 4096 \
-smp 2,sockets=1,cores=2,threads=1 \
-vga std \
-vnc :0 \
-no-user-config \
-nodefaults \
-monitor stdio \
-serial none \
-parallel none \
-net none \
-cdrom en_windows_10_consumer_edition_version_1809_updated_april_2019_x64_dvd_b6a14039.iso

This blue screens with a stop code: MICROCODE REVISION MISMATCH

If I disable SMP for the guest or add the ucode-rev option it boots to
the installer.  I don't currently have newer local ISO images, but I
could download some if necessary.  Host cpu:

# lscpu
Architecture:        x86_64
CPU op-mode(s):      32-bit, 64-bit
Byte Order:          Little Endian
CPU(s):              8
On-line CPU(s) list: 0-7
Thread(s) per core:  2
Core(s) per socket:  4
Socket(s):           1
NUMA node(s):        1
Vendor ID:           GenuineIntel
CPU family:          6
Model:               58
Model name:          Intel(R) Xeon(R) CPU E3-1245 V2 @ 3.40GHz
Stepping:            9
CPU MHz:             1601.482
CPU max MHz:         3800.0000
CPU min MHz:         1600.0000
BogoMIPS:            6805.62
Virtualization:      VT-x
L1d cache:           32K
L1i cache:           32K
L2 cache:            256K
L3 cache:            8192K
NUMA node0 CPU(s):   0-7
Flags:               fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl xtopology nonstop_tsc cpuid aperfmperf pni pclmulqdq dtes64 monitor ds_cpl vmx smx est tm2 ssse3 cx16 xtpr pdcm pcid sse4_1 sse4_2 x2apic popcnt tsc_deadline_timer aes xsave avx f16c rdrand lahf_lm cpuid_fault epb pti ssbd ibrs ibpb stibp tpr_shadow vnmi flexpriority ept vpid fsgsbase smep erms xsaveopt dtherm ida arat pln pts md_clear flush_l1d

# dmesg | grep microcode
[    0.000000] microcode: microcode updated early to revision 0x21, date = 2019-02-13
[   11.454405] microcode: sig=0x306a9, pf=0x2, revision=0x21
[   11.465289] microcode: Microcode Update Driver: v2.2.


