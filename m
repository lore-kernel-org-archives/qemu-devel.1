Return-Path: <SRS0=ZS6r=2E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D43DC43603
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Dec 2019 01:34:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D8BA20663
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Dec 2019 01:34:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IQF9Zlbt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D8BA20663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55012 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifwJq-0001JW-Hz
	for qemu-devel@archiver.kernel.org; Fri, 13 Dec 2019 20:34:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54661)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1ifwHf-0007oZ-PY
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 20:31:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1ifwHZ-00083Z-DQ
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 20:31:47 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:52085
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1ifwHU-0007xo-LL
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 20:31:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576287098;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+rfChBjeqlCDmq6N/UbfANfJtHcxYJfAuJC/Wa9rel4=;
 b=IQF9Zlbtk5BRuSqZPW6+iNhWADJw4QYIADbYF+tWLu53lm9u/RSGo4H4+8jjJH1Vr4tCte
 0SHdaSZem6KyB8Nlkod1P4itLnrC6ylKCxL5UXYaKp8fx0SdSoXdFaL6TL6cn82FYnjbLw
 K9+RH6F0o3/htuPCGmIbtaguFmhgZ1s=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-139-yNgS6bdlM0GZvfp-grETug-1; Fri, 13 Dec 2019 20:31:36 -0500
Received: by mail-wr1-f71.google.com with SMTP id c17so332481wrp.10
 for <qemu-devel@nongnu.org>; Fri, 13 Dec 2019 17:31:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:cc:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=+rfChBjeqlCDmq6N/UbfANfJtHcxYJfAuJC/Wa9rel4=;
 b=bdY6X77bUSZF6WE629meP5lxHptn8+K0qyc7ewrdnolb7ruYYOBXmb4wuVL5Ges73q
 4NZPxZNmDf0uA9YHjfOkrpGlf5GTdtMCM64v0IOjMFVYtlD6wg/AV67FJZoQd5rOqDxa
 ujJszHNxFG5KRHMWUQNIrxRmD8gcNEc1e/zS4C3hBlrXVtZaLWpZ64wYE0zachh+V9ue
 bdnCFj0haKoRVbeFoydW5WAetUT5S604Gssl0ZAW4w70DyvaGSGdebTMDFPioXjE23Oi
 BRXTMuX7GPhVsExykDFl6zrZSx4jwxUIkAPCYSGMq1RaU/d2+Gr6zg+xveyPwS7D94/r
 dQDg==
X-Gm-Message-State: APjAAAWDvWUwMr3dyqVI5gqdqBohjB35ExVK6t+pYPTFRh8im85jZZYf
 bqffbCBFdElsCyQ79bUxum+KZJ7sql92MsN+GE/WvtRJH4QNcd89V9dMSQKIz4Jh6T5Px2N6ypk
 DpwK2mLFVaDKrtTs=
X-Received: by 2002:a7b:c00c:: with SMTP id c12mr16617347wmb.34.1576287095594; 
 Fri, 13 Dec 2019 17:31:35 -0800 (PST)
X-Google-Smtp-Source: APXvYqxCJW05lTMYTKj5OPKmeUu6i+Y4aM4pvT0TIc75LbbTXE/OpWA6ZWCdiQKIAYZ+qaTXRBwlqA==
X-Received: by 2002:a7b:c00c:: with SMTP id c12mr16617324wmb.34.1576287095336; 
 Fri, 13 Dec 2019 17:31:35 -0800 (PST)
Received: from [192.168.1.35] (34.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.34])
 by smtp.gmail.com with ESMTPSA id g7sm12083992wrq.21.2019.12.13.17.31.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 13 Dec 2019 17:31:34 -0800 (PST)
Subject: Re: qemu-4.2: failed to set MSR 0x48b to 0x1582e00000000: Assertion
 `ret == cpu->kvm_msr_buf->nmsrs' failed.
To: "Montes, Julio" <julio.montes@intel.com>,
 qemu-devel <qemu-devel@nongnu.org>
References: <DM6PR11MB4089A0B695CB84FB288068B89A540@DM6PR11MB4089.namprd11.prod.outlook.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <2c28287e-1869-751d-f7c8-04605ef4b337@redhat.com>
Date: Sat, 14 Dec 2019 02:31:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <DM6PR11MB4089A0B695CB84FB288068B89A540@DM6PR11MB4089.namprd11.prod.outlook.com>
Content-Language: en-US
X-MC-Unique: yNgS6bdlM0GZvfp-grETug-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Julio,

On 12/13/19 9:53 PM, Montes, Julio wrote:
> Hi folks
> 
> I'm trying to run qemu 4.2.0 in azure VMs, unfourtunately qemu fails:
> 
> failed to launch qemu: exit status 1, error messages from qemu log: 
> qemu-system-x86_64: error: failed to set MSR 0x48b to 0x1582e00000000
> qemu-system-x86_64: /root/qemu/target/i386/kvm.c:2947: kvm_put_msrs: 
> Assertion `ret == cpu->kvm_msr_buf->nmsrs' failed.
> 
> I'm using the following command line:
> 
> qemu-system-x86_64 -machine pc,accel=kvm,kernel_irqchip,nvdimm -cpu 
> host,pmu=off \
> -qmp unix:qmp.sock,server,nowait -m 2048M,slots=10,maxmem=8977M -device 
> pci-bridge,bus=pci.0,id=pci-bridge-0,chassis_nr=1,shpc=on,addr=2,romfile= \
> -device virtio-serial-pci,disable-modern=true,id=serial0,romfile= 
> -device virtconsole,chardev=charconsole0,id=console0 \
> -chardev socket,id=charconsole0,path=console.sock,server,nowait -device 
> nvdimm,id=nv0,memdev=mem0 \
> -object 
> memory-backend-file,id=mem0,mem-path=kata-containers.img,size=134217728 
> -device virtio-scsi-pci,id=scsi0,disable-modern=true,romfile= \
> -object rng-random,id=rng0,filename=/dev/urandom -device 
> virtio-rng,rng=rng0,romfile= -device 
> virtserialport,chardev=charch0,id=channel0,name=agent.channel.0 \
> -chardev socket,id=charch0,path=kata.sock,server,nowait -device 
> virtio-9p-pci,disable-modern=true,fsdev=extra-9p-kataShared,mount_tag=kataShared,romfile= 
> \
> -fsdev 
> local,id=extra-9p-kataShared,path=/run/kata-containers/shared/sandboxes,security_model=none 
> -netdev tap,id=network-0,vhost=on,vhostfds=3,fds=4 \
> -device 
> driver=virtio-net-pci,netdev=network-0,mac=ea:4a:b6:1a:92:72,disable-modern=true,mq=on,vectors=4,romfile= 
> \
> -global kvm-pit.lost_tick_policy=discard -vga none -no-user-config 
> -nodefaults -nographic -daemonize -object 
> memory-backend-ram,id=dimm1,size=2048M \
> -numa node,memdev=dimm1 -kernel 
> /usr/share/kata-containers/vmlinuz-4.19.86-60 \
> -append "tsc=reliable no_timer_check rcupdate.rcu_expedited=1 
> i8042.direct=1 i8042.dumbkbd=1 i8042.nopnp=1 i8042.noaux=1 noreplace-smp 
> reboot=k \
> console=hvc0 console=hvc1 iommu=off cryptomgr.notests net.ifnames=0 
> pci=lastbus=0 root=/dev/pmem0p1 
> rootflags=dax,data=ordered,errors=remount-ro \
> ro rootfstype=ext4 debug systemd.show_status=true 
> systemd.log_level=debug panic=1 nr_cpus=2 agent.use_vsock=false 
> systemd.unit=kata-containers.target \
> systemd.mask=systemd-networkd.service 
> systemd.mask=systemd-networkd.socket agent.log=debug agent.log=debug" \
> -pidfile pid -D qemu.log -smp 1,cores=1,threads=1,sockets=2,maxcpus=2
> 
> Qemu 4.1.0 works fine
> Qemu 4.2.0 **only** fails in azure VMs, in my workstation it works fine
> 
> any thoughts?

Are you running also nested on your workstation?

> 
> 
> Information about the VM:
> 
> $ cat /sys/module/kvm_intel/parameters/nested
> Y
> 
> $ cat /proc/cpuinfo
> processor : 0
> vendor_id : GenuineIntel
> cpu family : 6
> model : 79
> model name : Intel(R) Xeon(R) CPU E5-2673 v4 @ 2.30GHz
> stepping : 1
> microcode : 0xffffffff
> cpu MHz : 2294.685
> cache size : 51200 KB
> physical id : 0
> siblings : 2
> core id : 0
> cpu cores : 1
> apicid : 0
> initial apicid : 0
> fpu : yes
> fpu_exception : yes
> cpuid level : 20
> wp : yes
> flags : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov 
> pat pse36 clflush mmx fxsr sse sse2 ss ht syscall nx pdpe1gb rdtscp lm 
> constant_tsc rep_good nopl xtopology cpuid pni pclmulqdq vmx ssse3 fma 
> cx16 pcid sse4_1 sse4_2 movbe popcnt aes xsave avx f16c rdrand 
> hypervisor lahf_lm abm 3dnowprefetch invpcid_single pti tpr_shadow vnmi 
> ept vpid fsgsbase bmi1 hle avx2 smep bmi2 erms invpcid rtm rdseed adx 
> smap xsaveopt md_clear
> bugs : cpu_meltdown spectre_v1 spectre_v2 spec_store_bypass l1tf mds 
> swapgs taa itlb_multihit
> bogomips : 4589.37
> clflush size : 64
> cache_alignment : 64
> address sizes : 44 bits physical, 48 bits virtual
> power management:
> 
> processor : 1
> vendor_id : GenuineIntel
> cpu family : 6
> model : 79
> model name : Intel(R) Xeon(R) CPU E5-2673 v4 @ 2.30GHz
> stepping : 1
> microcode : 0xffffffff
> cpu MHz : 2294.685
> cache size : 51200 KB
> physical id : 0
> siblings : 2
> core id : 0
> cpu cores : 1
> apicid : 1
> initial apicid : 1
> fpu : yes
> fpu_exception : yes
> cpuid level : 20
> wp : yes
> flags : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov 
> pat pse36 clflush mmx fxsr sse sse2 ss ht syscall nx pdpe1gb rdtscp lm 
> constant_tsc rep_good nopl xtopology cpuid pni pclmulqdq vmx ssse3 fma 
> cx16 pcid sse4_1 sse4_2 movbe popcnt aes xsave avx f16c rdrand 
> hypervisor lahf_lm abm 3dnowprefetch invpcid_single pti tpr_shadow vnmi 
> ept vpid fsgsbase bmi1 hle avx2 smep bmi2 erms invpcid rtm rdseed adx 
> smap xsaveopt md_clear
> bugs : cpu_meltdown spectre_v1 spectre_v2 spec_store_bypass l1tf mds 
> swapgs taa itlb_multihit
> bogomips : 4589.37
> clflush size : 64
> cache_alignment : 64
> address sizes : 44 bits physical, 48 bits virtual
> power management:
> 
> $ uname -a
> Linux testcrio1 5.0.0-1027-azure #29~18.04.1-Ubuntu SMP Mon Nov 25 
> 21:18:57 UTC 2019 x86_64 x86_64 x86_64 GNU/Linux
> 
> Thanks
> 
> -
> Julio
> 
> 


