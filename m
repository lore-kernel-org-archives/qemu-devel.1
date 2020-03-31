Return-Path: <SRS0=xFA2=5Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 459F5C43331
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 17:38:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F3F3920BED
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 17:38:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="XvVmmdTs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3F3920BED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42302 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJKqL-0005aA-0n
	for qemu-devel@archiver.kernel.org; Tue, 31 Mar 2020 13:38:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51935)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <julio.montes@intel.com>) id 1jJKpT-0004nA-L7
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 13:37:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <julio.montes@intel.com>) id 1jJKpQ-0001dL-Dz
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 13:37:34 -0400
Received: from mga03.intel.com ([134.134.136.65]:37421)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <julio.montes@intel.com>)
 id 1jJKpP-0001Yu-TS
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 13:37:32 -0400
IronPort-SDR: KENI3qmrXi4TVyFLVE+NboFitJqAZq3PPqFuSmGEDiLVRmfF9Grq0bKFF2UgJYUb5FjkDqKNvj
 UPevhaEK1aTA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Mar 2020 10:37:27 -0700
IronPort-SDR: DnDc7J/tAN11LZO64gxpNK/MAxiwbKpDgzyj4eXlk7+JSstbzIIR+RkyGvOefRTuho8ndxlVau
 0qH6Lm0ZSUcA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,328,1580803200"; 
 d="scan'208,217";a="395579652"
Received: from orsmsx102.amr.corp.intel.com ([10.22.225.129])
 by orsmga004.jf.intel.com with ESMTP; 31 Mar 2020 10:37:27 -0700
Received: from orsmsx123.amr.corp.intel.com (10.22.240.116) by
 ORSMSX102.amr.corp.intel.com (10.22.225.129) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 31 Mar 2020 10:37:27 -0700
Received: from ORSEDG001.ED.cps.intel.com (10.7.248.4) by
 ORSMSX123.amr.corp.intel.com (10.22.240.116) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 31 Mar 2020 10:37:26 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.170)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 31 Mar 2020 10:37:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R2JqlonBIp8nh8Rc3ZAdbwp5TtCrBA/mlYIPsQe+ZsxfAZC2JFeFdBMu81rR8aIMz3GvVCLQx4NVr/imAGHljMToukESVfqY/iTnQM6APjQUpT6x9PSfo8Puz2SUpXIXDGznwl0vxX/1guuh8s/St6fCG2C78BKnIme2a+X2e13knAtQCWcvpGbvUP9j5LuuheuyIA4XW+HVpeR2NPaC5YharnT3PHgBOnb3kbKE4gNlVqLKQAAvfD2neqT36hulJ2klWaqWihMGgPZdS6OS7qgysBICUSttGYljZwzzGH0WfSfl+CdMyMC7DP0PbyOShZ926roO0inFWhUSLWOxqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aiRvt+O8U2gpiX05mSTb+o+4JQPy3o6GSyoPnzzuLTQ=;
 b=ntWcp0uewYEGQrRprqFAwsQP7NLk6MJ5FEuRn7uOa/vC+LGxq2tJwALjzfOxrdkWQfYq4nhsZ3TNigAjqYH5/+InPCan5naIv4v/yVgjHCKi4qvNm+0hPbbPkiYX3CnzcXOoWcX1b1x4eHl4TrnfRHqAgX42aDEQ8tYY1d9Aze+rbxLFohUc9AMPkZaVRhk16K34NorM6akjSBHv/aPUMAjYkccYC8KpRhimaNHa7P94+Jysv7LC0tEc/pAZfttqSIQTBODwoh7FpERom7XgoPLPbMFsC3D+P0Vk8FPWcV7Eeh3nubz5RBpsjYInSuyQ4bWZ5JJwsHDsZWVh3Vydpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com; 
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aiRvt+O8U2gpiX05mSTb+o+4JQPy3o6GSyoPnzzuLTQ=;
 b=XvVmmdTsWGICx0KgqytjgYXiqu9rz9abdoPflhFplLqA3MWIFlPGd8xZe1QtNgLHQKI4sBghv+DZ4cNi+wPNQx0hihSPm+eEUfQd488NbJNceyrIJvOy5scJ+Dmt8S0X/umNOPxkWeDsgACcprN1BfXentar8GVOmKNFTDatxXU=
Received: from BY5PR11MB3960.namprd11.prod.outlook.com (2603:10b6:a03:185::30)
 by BY5PR11MB4182.namprd11.prod.outlook.com (2603:10b6:a03:183::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2856.20; Tue, 31 Mar
 2020 17:37:25 +0000
Received: from BY5PR11MB3960.namprd11.prod.outlook.com
 ([fe80::f80d:8a9b:8bf3:47a7]) by BY5PR11MB3960.namprd11.prod.outlook.com
 ([fe80::f80d:8a9b:8bf3:47a7%5]) with mapi id 15.20.2856.019; Tue, 31 Mar 2020
 17:37:24 +0000
From: "Montes, Julio" <julio.montes@intel.com>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Subject: Re: [PATCH] target/i386: do not set unsupported VMX secondary
 execution controls
Thread-Topic: [PATCH] target/i386: do not set unsupported VMX secondary
 execution controls
Thread-Index: AQHWB3m8r1FB2qyA5Umhq8e1klXMS6hi5RMAgAAGPUWAAABloIAACGsAgAAB/GE=
Date: Tue, 31 Mar 2020 17:37:24 +0000
Message-ID: <BY5PR11MB39604F6B74053A52B79274739AC80@BY5PR11MB3960.namprd11.prod.outlook.com>
References: <20200331162752.1209928-1-vkuznets@redhat.com>
 <f976c1b0-2f50-d9f6-0921-2fc8e25ddb80@redhat.com>
 <BY5PR11MB396059E9E1FFE4B93EDE38E89AC80@BY5PR11MB3960.namprd11.prod.outlook.com>
 <BY5PR11MB3960FE6E5F51F95EF9DFAAAB9AC80@BY5PR11MB3960.namprd11.prod.outlook.com>,
 <20200331172640.GE2896@work-vm>
In-Reply-To: <20200331172640.GE2896@work-vm>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=julio.montes@intel.com; 
x-originating-ip: [134.134.137.73]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ae9c85d4-8348-4a2f-1e2a-08d7d59a2cd4
x-ms-traffictypediagnostic: BY5PR11MB4182:
x-microsoft-antispam-prvs: <BY5PR11MB418248435C5C2D069E8A2C839AC80@BY5PR11MB4182.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:826;
x-forefront-prvs: 0359162B6D
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR11MB3960.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10019020)(396003)(136003)(366004)(39860400002)(346002)(376002)(33656002)(8936002)(52536014)(66446008)(9686003)(55016002)(2906002)(5660300002)(66476007)(64756008)(86362001)(76116006)(66946007)(81156014)(66556008)(81166006)(7696005)(6916009)(54906003)(26005)(6506007)(316002)(19627405001)(8676002)(186003)(4326008)(478600001)(71200400001)(53546011);
 DIR:OUT; SFP:1102; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2xnGtPugpVAsoZKwtXp/iGsdTpuDzBXiPXCHhgK7I0o4R/r4ggSJOfqXuwMiXjJCY/C0r4I7MMmWR5gdT/gN2Rt/zA6RITkhs8FiVFZREYvtHjdm57mdc6/z9BB9mgGM98aXO21A4k5KDBEKVI9BODTUexABGcZEy7K1dT5klQ7OJzVgkrg0WWy+ZJgAOPYeaNvY32PW84CAf3Bh8H/JwQiKRRF0RceqBLJFFmdY9zpGSEXMXeoxNGv8+xrQx7qfWpauEguMJNSUFWGKGicwkeKEmhBMG+Sh1bGqFbnoDOSdBLspk3NRqeRGH+I5f6otEuyqKjxpO08p4fjsPjal0t9yF/6/t2QTozvvucXYx2kNR56dlmSVP6DAQ1avw4R44rtWJBoryoJjooJdnNejKMjKlzccoAzcVj509zf+9KKZdAqsF30EwG78HSTh7th1
x-ms-exchange-antispam-messagedata: 4suPQJZkhdgrWkwk67fHqygu85Q1yWT0uppDnWU+YK8A2xotoHN5Wi3UtcYUqLwWjcZY4KRh7xT94qx1iYGVx6hWU5d824cY3AflOBL3sRDz5PbVG9inf+nDm56F4YNyAJvIrUv5Kx9k9+wc0f/2mQ==
x-ms-exchange-transport-forked: True
Content-Type: multipart/alternative;
 boundary="_000_BY5PR11MB39604F6B74053A52B79274739AC80BY5PR11MB3960namp_"
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: ae9c85d4-8348-4a2f-1e2a-08d7d59a2cd4
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Mar 2020 17:37:24.8384 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GaCGV2sagconrRa7iSjUxU/gyKu50KDUDg9PRa1iNh7901YpDYCuPUGLmnkSCMAxGECfUiHx10G91P0Os8Wtfg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR11MB4182
X-OriginatorOrg: intel.com
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
X-Received-From: 134.134.136.65
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Vitaly Kuznetsov <vkuznets@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--_000_BY5PR11MB39604F6B74053A52B79274739AC80BY5PR11MB3960namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

David

I'm using master
17083d6d1e Merge remote-tracking branch 'remotes/jasowang/tags/net-pull-req=
uest' into staging

-
Cheers
Julio

________________________________
From: Dr. David Alan Gilbert <dgilbert@redhat.com>
Sent: Tuesday, March 31, 2020 11:26 AM
To: Montes, Julio <julio.montes@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>; Vitaly Kuznetsov <vkuznets@redhat.=
com>; qemu-devel@nongnu.org <qemu-devel@nongnu.org>; Marcelo Tosatti <mtosa=
tti@redhat.com>; Eduardo Habkost <ehabkost@redhat.com>; Richard Henderson <=
rth@twiddle.net>
Subject: Re: [PATCH] target/i386: do not set unsupported VMX secondary exec=
ution controls

* Montes, Julio (julio.montes@intel.com) wrote:
> Sorry for my last email, it was incomplete
>
> Hi Vitaly
>
> thanks for raising this, unfortunately this patch didn't work for me, I s=
till get the same error:

Are you trying that on top of 5.0 or ontop of the older 4.2 world?

> qemu-system-x86_64: error: failed to set MSR 0x48b to 0x1582e00000000
> qemu-system-x86_64: /home/testpmem/go/src/github.com/kata-containers/qemu=
/target/i386/kvm.c:2695: kvm_buf_set_msrs: Assertion `ret =3D=3D cpu->kvm_m=
sr_buf->nmsrs

If my reading of 0x1582e00000000 is correct then we have:
                                               0x1582e 00000000
VMX_SECONDARY_EXEC_RDSEED_EXITING           0x00010000  !

VMX_SECONDARY_EXEC_SHADOW_VMCS              0x00004000  !
VMX_SECONDARY_EXEC_ENABLE_INVPCID           0x00001000

VMX_SECONDARY_EXEC_RDRAND_EXITING           0x00000800

VMX_SECONDARY_EXEC_ENABLE_VPID              0x00000020

VMX_SECONDARY_EXEC_ENABLE_EPT               0x00000002
VMX_SECONDARY_EXEC_DESC                     0x00000004
VMX_SECONDARY_EXEC_RDTSCP                   0x00000008

>
> my qemu command line:
> /usr/bin/qemu-system-x86_64 -name sandbox-f218abcb05f6e05cc68768f74e91063=
03066f377a877c03ddc64e1e5e8685633 -uuid 8189ac12-5a5c-4989-bf82-c0218f8a3d3=
3 -machine pc,accel=3Dkvm,kernel_irqchip,nvdimm -cpu host,pmu=3Doff -qmp un=
ix:/run/vc/vm/f218abcb05f6e05cc68768f74e9106303066f377a877c03ddc64e1e5e8685=
633/qmp.sock,server,nowait -m 2048M,slots=3D10,maxmem=3D17041M -device pci-=
bridge,bus=3Dpci.0,id=3Dpci-bridge-0,chassis_nr=3D1,shpc=3Don,addr=3D2,romf=
ile=3D -device virtio-serial-pci,disable-modern=3Dtrue,id=3Dserial0,romfile=
=3D -device virtconsole,chardev=3Dcharconsole0,id=3Dconsole0 -chardev socke=
t,id=3Dcharconsole0,path=3D/run/vc/vm/f218abcb05f6e05cc68768f74e9106303066f=
377a877c03ddc64e1e5e8685633/console.sock,server,nowait -device nvdimm,id=3D=
nv0,memdev=3Dmem0 -object memory-backend-file,id=3Dmem0,mem-path=3D/usr/sha=
re/kata-containers/kata-containers-clearlinux-32700-osbuilder-891b61c-agent=
-73afd1a.img,size=3D134217728 -device virtio-scsi-pci,id=3Dscsi0,disable-mo=
dern=3Dtrue,romfile=3D -object rng-random,id=3Drng0,filename=3D/dev/urandom=
 -device virtio-rng-pci,rng=3Drng0,romfile=3D -device virtserialport,charde=
v=3Dcharch0,id=3Dchannel0,name=3Dagent.channel.0 -chardev socket,id=3Dcharc=
h0,path=3D/run/vc/vm/f218abcb05f6e05cc68768f74e9106303066f377a877c03ddc64e1=
e5e8685633/kata.sock,server,nowait -device virtio-9p-pci,disable-modern=3Dt=
rue,fsdev=3Dextra-9p-kataShared,mount_tag=3DkataShared,romfile=3D -fsdev lo=
cal,id=3Dextra-9p-kataShared,path=3D/run/kata-containers/shared/sandboxes/f=
218abcb05f6e05cc68768f74e9106303066f377a877c03ddc64e1e5e8685633,security_mo=
del=3Dnone -netdev tap,id=3Dnetwork-0,vhost=3Don,vhostfds=3D3,fds=3D4 -devi=
ce driver=3Dvirtio-net-pci,netdev=3Dnetwork-0,mac=3D02:42:ac:11:00:02,disab=
le-modern=3Dtrue,mq=3Don,vectors=3D4,romfile=3D -global kvm-pit.lost_tick_p=
olicy=3Ddiscard -vga none -no-user-config -nodefaults -nographic -daemonize=
 -object memory-backend-ram,id=3Ddimm1,size=3D2048M -numa node,memdev=3Ddim=
m1 -kernel /usr/share/kata-containers/vmlinuz-5.4.15-71 -append tsc=3Drelia=
ble no_timer_check rcupdate.rcu_expedited=3D1 i8042.direct=3D1 i8042.dumbkb=
d=3D1 i8042.nopnp=3D1 i8042.noaux=3D1 noreplace-smp reboot=3Dk console=3Dhv=
c0 console=3Dhvc1 iommu=3Doff cryptomgr.notests net.ifnames=3D0 pci=3Dlastb=
us=3D0 root=3D/dev/pmem0p1 rootflags=3Ddax,data=3Dordered,errors=3Dremount-=
ro ro rootfstype=3Dext4 debug systemd.show_status=3Dtrue systemd.log_level=
=3Ddebug panic=3D1 nr_cpus=3D4 agent.use_vsock=3Dfalse systemd.unit=3Dkata-=
containers.target systemd.mask=3Dsystemd-networkd.service systemd.mask=3Dsy=
stemd-networkd.socket agent.log=3Ddebug agent.log=3Ddebug -pidfile /run/vc/=
vm/f218abcb05f6e05cc68768f74e9106303066f37
> 7a877c03ddc64e1e5e8685633/pid -D /run/vc/vm/f218abcb05f6e05cc68768f74e910=
6303066f377a877c03ddc64e1e5e8685633/qemu.log -smp 1,cores=3D1,threads=3D1,s=
ockets=3D4,maxcpus=3D4
>
>
>
> ./vmxcap output:
>
> secondary processor-based controls
>   Virtualize APIC accesses                 no
>   Enable EPT                               yes
>   Descriptor-table exiting                 yes
>   Enable RDTSCP                            yes
>   Virtualize x2APIC mode                   no
>   Enable VPID                              yes
>   WBINVD exiting                           no
>   Unrestricted guest                       no
>   APIC register emulation                  no
>   Virtual interrupt delivery               no
>   PAUSE-loop exiting                       no
>   RDRAND exiting                           yes
>   Enable INVPCID                           yes
>   Enable VM functions                      no
>   VMCS shadowing                           no   <<<<<
>   Enable ENCLS exiting                     no
>   RDSEED exiting                           no   <<<<<
>   Enable PML                               no
>   EPT-violation #VE                        no
>   Conceal non-root operation from PT       no
>   Enable XSAVES/XRSTORS                    no
>   Mode-based execute control (XS/XU)       no
>   Sub-page write permissions               no
>   GPA translation for PT                   no
>   TSC scaling                              no
>   User wait and pause                      no
>   ENCLV exiting                            no


So we're apparently trying to enable both RDSEED_EXITING and SHADOW_VMCS
which are missing.


> On 31/03/20 18:27, Vitaly Kuznetsov wrote:

> >      case MSR_IA32_VMX_PROCBASED_CTLS2:
> > -        /* KVM forgot to add these bits for some time, do this ourselv=
es.  */
> > -        if (kvm_arch_get_supported_cpuid(s, 0xD, 1, R_ECX) & CPUID_XSA=
VE_XSAVES) {
> > -            value |=3D (uint64_t)VMX_SECONDARY_EXEC_XSAVES << 32;
> > -        }
> > -        if (kvm_arch_get_supported_cpuid(s, 1, 0, R_ECX) & CPUID_EXT_R=
DRAND) {
> > -            value |=3D (uint64_t)VMX_SECONDARY_EXEC_RDRAND_EXITING << =
32;
> > -        }
> > -        if (kvm_arch_get_supported_cpuid(s, 7, 0, R_EBX) & CPUID_7_0_E=
BX_INVPCID) {
> > -            value |=3D (uint64_t)VMX_SECONDARY_EXEC_ENABLE_INVPCID << =
32;
> > -        }
> > -        if (kvm_arch_get_supported_cpuid(s, 7, 0, R_EBX) & CPUID_7_0_E=
BX_RDSEED) {
> > -            value |=3D (uint64_t)VMX_SECONDARY_EXEC_RDSEED_EXITING << =
32;
> > -        }
> > -        if (kvm_arch_get_supported_cpuid(s, 0x80000001, 0, R_EDX) & CP=
UID_EXT2_RDTSCP) {
> > -            value |=3D (uint64_t)VMX_SECONDARY_EXEC_RDTSCP << 32;
> > +        if (!has_msr_vmx_procbased_ctls2) {
> > +            /* KVM forgot to add these bits for some time, do this our=
selves. */
> > +            if (kvm_arch_get_supported_cpuid(s, 0xD, 1, R_ECX) &
> > +                CPUID_XSAVE_XSAVES) {
> > +                value |=3D (uint64_t)VMX_SECONDARY_EXEC_XSAVES << 32;
> > +            }
> > +            if (kvm_arch_get_supported_cpuid(s, 1, 0, R_ECX) &
> > +                CPUID_EXT_RDRAND) {
> > +                value |=3D (uint64_t)VMX_SECONDARY_EXEC_RDRAND_EXITING=
 << 32;
> > +            }
> > +            if (kvm_arch_get_supported_cpuid(s, 7, 0, R_EBX) &
> > +                CPUID_7_0_EBX_INVPCID) {
> > +                value |=3D (uint64_t)VMX_SECONDARY_EXEC_ENABLE_INVPCID=
 << 32;
> > +            }
> > +            if (kvm_arch_get_supported_cpuid(s, 7, 0, R_EBX) &
> > +                CPUID_7_0_EBX_RDSEED) {
> > +                value |=3D (uint64_t)VMX_SECONDARY_EXEC_RDSEED_EXITING=
 << 32;
> > +            }
> > +            if (kvm_arch_get_supported_cpuid(s, 0x80000001, 0, R_EDX) =
&
> > +                CPUID_EXT2_RDTSCP) {
> > +                value |=3D (uint64_t)VMX_SECONDARY_EXEC_RDTSCP << 32;
> > +            }

So you would think that would tkae care of RDSEED exiting - but what
about VMCS shadowing?

Dave

> >          }
> >          /* fall through */
> >      case MSR_IA32_VMX_TRUE_PINBASED_CTLS:
> > @@ -2060,6 +2068,9 @@ static int kvm_get_supported_msrs(KVMState *s)
> >              case MSR_IA32_UCODE_REV:
> >                  has_msr_ucode_rev =3D true;
> >                  break;
> > +            case MSR_IA32_VMX_PROCBASED_CTLS2:
> > +                has_msr_vmx_procbased_ctls2 =3D true;
> > +                break;
> >              }
> >          }
> >      }
> >
>
>
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


--_000_BY5PR11MB39604F6B74053A52B79274739AC80BY5PR11MB3960namp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0); background-color: rgb(255, 255, 255);">
David</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0); background-color: rgb(255, 255, 255);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0); background-color: rgb(255, 255, 255);">
I'm using master<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0); background-color: rgb(255, 255, 255);">
17083d6d1e Merge remote-tracking branch 'remotes/jasowang/tags/net-pull-req=
uest' into staging<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0); background-color: rgb(255, 255, 255);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0); background-color: rgb(255, 255, 255);">
-</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0); background-color: rgb(255, 255, 255);">
Cheers</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0); background-color: rgb(255, 255, 255);">
Julio<br>
</div>
<div id=3D"appendonsend"></div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font style=3D"font-size: 11pt;" data=
-ogsc=3D"" face=3D"Calibri, sans-serif" color=3D"#000000"><b>From:</b> Dr. =
David Alan Gilbert &lt;dgilbert@redhat.com&gt;<br>
<b>Sent:</b> Tuesday, March 31, 2020 11:26 AM<br>
<b>To:</b> Montes, Julio &lt;julio.montes@intel.com&gt;<br>
<b>Cc:</b> Paolo Bonzini &lt;pbonzini@redhat.com&gt;; Vitaly Kuznetsov &lt;=
vkuznets@redhat.com&gt;; qemu-devel@nongnu.org &lt;qemu-devel@nongnu.org&gt=
;; Marcelo Tosatti &lt;mtosatti@redhat.com&gt;; Eduardo Habkost &lt;ehabkos=
t@redhat.com&gt;; Richard Henderson &lt;rth@twiddle.net&gt;<br>
<b>Subject:</b> Re: [PATCH] target/i386: do not set unsupported VMX seconda=
ry execution controls</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt"=
>
<div class=3D"PlainText">* Montes, Julio (julio.montes@intel.com) wrote:<br=
>
&gt; Sorry for my last email, it was incomplete<br>
&gt; <br>
&gt; Hi Vitaly<br>
&gt; <br>
&gt; thanks for raising this, unfortunately this patch didn't work for me, =
I still get the same error:<br>
<br>
Are you trying that on top of 5.0 or ontop of the older 4.2 world?<br>
<br>
&gt; qemu-system-x86_64: error: failed to set MSR 0x48b to 0x1582e00000000<=
br>
&gt; qemu-system-x86_64: /home/testpmem/go/src/github.com/kata-containers/q=
emu/target/i386/kvm.c:2695: kvm_buf_set_msrs: Assertion `ret =3D=3D cpu-&gt=
;kvm_msr_buf-&gt;nmsrs<br>
<br>
If my reading of 0x1582e00000000 is correct then we have:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x1582e 00000000<br>
VMX_SECONDARY_EXEC_RDSEED_EXITING&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; 0x00010000&nbsp; !<br>
&nbsp;<br>
VMX_SECONDARY_EXEC_SHADOW_VMCS&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x00004000&nbsp; !<br>
VMX_SECONDARY_EXEC_ENABLE_INVPCID&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; 0x00001000<br>
&nbsp;<br>
VMX_SECONDARY_EXEC_RDRAND_EXITING&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; 0x00000800<br>
&nbsp;<br>
VMX_SECONDARY_EXEC_ENABLE_VPID&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x00000020<br>
&nbsp;<br>
VMX_SECONDARY_EXEC_ENABLE_EPT&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x00000002<br>
VMX_SECONDARY_EXEC_DESC&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x0000=
0004<br>
VMX_SECONDARY_EXEC_RDTSCP&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x00000008<br>
<br>
&gt; <br>
&gt; my qemu command line:<br>
&gt; /usr/bin/qemu-system-x86_64 -name sandbox-f218abcb05f6e05cc68768f74e91=
06303066f377a877c03ddc64e1e5e8685633 -uuid 8189ac12-5a5c-4989-bf82-c0218f8a=
3d33 -machine pc,accel=3Dkvm,kernel_irqchip,nvdimm -cpu host,pmu=3Doff -qmp=
 unix:/run/vc/vm/f218abcb05f6e05cc68768f74e9106303066f377a877c03ddc64e1e5e8=
685633/qmp.sock,server,nowait
 -m 2048M,slots=3D10,maxmem=3D17041M -device pci-bridge,bus=3Dpci.0,id=3Dpc=
i-bridge-0,chassis_nr=3D1,shpc=3Don,addr=3D2,romfile=3D -device virtio-seri=
al-pci,disable-modern=3Dtrue,id=3Dserial0,romfile=3D -device virtconsole,ch=
ardev=3Dcharconsole0,id=3Dconsole0 -chardev socket,id=3Dcharconsole0,path=
=3D/run/vc/vm/f218abcb05f6e05cc68768f74e9106303066f377a877c03ddc64e1e5e8685=
633/console.sock,server,nowait
 -device nvdimm,id=3Dnv0,memdev=3Dmem0 -object memory-backend-file,id=3Dmem=
0,mem-path=3D/usr/share/kata-containers/kata-containers-clearlinux-32700-os=
builder-891b61c-agent-73afd1a.img,size=3D134217728 -device virtio-scsi-pci,=
id=3Dscsi0,disable-modern=3Dtrue,romfile=3D -object
 rng-random,id=3Drng0,filename=3D/dev/urandom -device virtio-rng-pci,rng=3D=
rng0,romfile=3D -device virtserialport,chardev=3Dcharch0,id=3Dchannel0,name=
=3Dagent.channel.0 -chardev socket,id=3Dcharch0,path=3D/run/vc/vm/f218abcb0=
5f6e05cc68768f74e9106303066f377a877c03ddc64e1e5e8685633/kata.sock,server,no=
wait
 -device virtio-9p-pci,disable-modern=3Dtrue,fsdev=3Dextra-9p-kataShared,mo=
unt_tag=3DkataShared,romfile=3D -fsdev local,id=3Dextra-9p-kataShared,path=
=3D/run/kata-containers/shared/sandboxes/f218abcb05f6e05cc68768f74e91063030=
66f377a877c03ddc64e1e5e8685633,security_model=3Dnone
 -netdev tap,id=3Dnetwork-0,vhost=3Don,vhostfds=3D3,fds=3D4 -device driver=
=3Dvirtio-net-pci,netdev=3Dnetwork-0,mac=3D02:42:ac:11:00:02,disable-modern=
=3Dtrue,mq=3Don,vectors=3D4,romfile=3D -global kvm-pit.lost_tick_policy=3Dd=
iscard -vga none -no-user-config -nodefaults -nographic -daemonize
 -object memory-backend-ram,id=3Ddimm1,size=3D2048M -numa node,memdev=3Ddim=
m1 -kernel /usr/share/kata-containers/vmlinuz-5.4.15-71 -append tsc=3Drelia=
ble no_timer_check rcupdate.rcu_expedited=3D1 i8042.direct=3D1 i8042.dumbkb=
d=3D1 i8042.nopnp=3D1 i8042.noaux=3D1 noreplace-smp
 reboot=3Dk console=3Dhvc0 console=3Dhvc1 iommu=3Doff cryptomgr.notests net=
.ifnames=3D0 pci=3Dlastbus=3D0 root=3D/dev/pmem0p1 rootflags=3Ddax,data=3Do=
rdered,errors=3Dremount-ro ro rootfstype=3Dext4 debug systemd.show_status=
=3Dtrue systemd.log_level=3Ddebug panic=3D1 nr_cpus=3D4 agent.use_vsock=3Df=
alse
 systemd.unit=3Dkata-containers.target systemd.mask=3Dsystemd-networkd.serv=
ice systemd.mask=3Dsystemd-networkd.socket agent.log=3Ddebug agent.log=3Dde=
bug -pidfile /run/vc/vm/f218abcb05f6e05cc68768f74e9106303066f37<br>
&gt; 7a877c03ddc64e1e5e8685633/pid -D /run/vc/vm/f218abcb05f6e05cc68768f74e=
9106303066f377a877c03ddc64e1e5e8685633/qemu.log -smp 1,cores=3D1,threads=3D=
1,sockets=3D4,maxcpus=3D4<br>
&gt; <br>
&gt; <br>
&gt; <br>
&gt; ./vmxcap output:<br>
&gt; <br>
&gt; secondary processor-based controls<br>
&gt;&nbsp;&nbsp; Virtualize APIC accesses&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; no<br>
&gt;&nbsp;&nbsp; Enable EPT&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; yes<br>
&gt;&nbsp;&nbsp; Descriptor-table exiting&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; yes<br>
&gt;&nbsp;&nbsp; Enable RDTSCP&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; yes<br>
&gt;&nbsp;&nbsp; Virtualize x2APIC mode&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; no=
<br>
&gt;&nbsp;&nbsp; Enable VPID&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; yes<br>
&gt;&nbsp;&nbsp; WBINVD exiting&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; no<br>
&gt;&nbsp;&nbsp; Unrestricted guest&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; no<br>
&gt;&nbsp;&nbsp; APIC register emulation&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; no<br>
&gt;&nbsp;&nbsp; Virtual interrupt delivery&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; no<br>
&gt;&nbsp;&nbsp; PAUSE-loop exiting&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; no<br>
&gt;&nbsp;&nbsp; RDRAND exiting&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; yes<br>
&gt;&nbsp;&nbsp; Enable INVPCID&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; yes<br>
&gt;&nbsp;&nbsp; Enable VM functions&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; no<br>
&gt;&nbsp;&nbsp; VMCS shadowing&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; no&nbsp;&nbsp; &lt;&lt;&lt;&lt;&lt;<b=
r>
&gt;&nbsp;&nbsp; Enable ENCLS exiting&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; no<br>
&gt;&nbsp;&nbsp; RDSEED exiting&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; no&nbsp;&nbsp; &lt;&lt;&lt;&lt;&lt;<b=
r>
&gt;&nbsp;&nbsp; Enable PML&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; no<br>
&gt;&nbsp;&nbsp; EPT-violation #VE&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; no<br>
&gt;&nbsp;&nbsp; Conceal non-root operation from PT&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; no<br>
&gt;&nbsp;&nbsp; Enable XSAVES/XRSTORS&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; no<br>
&gt;&nbsp;&nbsp; Mode-based execute control (XS/XU)&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; no<br>
&gt;&nbsp;&nbsp; Sub-page write permissions&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; no<br>
&gt;&nbsp;&nbsp; GPA translation for PT&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; no=
<br>
&gt;&nbsp;&nbsp; TSC scaling&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; no<br>
&gt;&nbsp;&nbsp; User wait and pause&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; no<br>
&gt;&nbsp;&nbsp; ENCLV exiting&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; no<br>
<br>
<br>
So we're apparently trying to enable both RDSEED_EXITING and SHADOW_VMCS<br=
>
which are missing.<br>
<br>
<br>
&gt; On 31/03/20 18:27, Vitaly Kuznetsov wrote:<br>
<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case MSR_IA32_VMX_PROCBASED_CTLS2:<=
br>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* KVM forgot to add =
these bits for some time, do this ourselves.&nbsp; */<br>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (kvm_arch_get_supp=
orted_cpuid(s, 0xD, 1, R_ECX) &amp; CPUID_XSAVE_XSAVES) {<br>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; value |=3D (uint64_t)VMX_SECONDARY_EXEC_XSAVES &lt;&lt; 32;<br>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (kvm_arch_get_supp=
orted_cpuid(s, 1, 0, R_ECX) &amp; CPUID_EXT_RDRAND) {<br>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; value |=3D (uint64_t)VMX_SECONDARY_EXEC_RDRAND_EXITING &lt;&lt; 32;<br>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (kvm_arch_get_supp=
orted_cpuid(s, 7, 0, R_EBX) &amp; CPUID_7_0_EBX_INVPCID) {<br>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; value |=3D (uint64_t)VMX_SECONDARY_EXEC_ENABLE_INVPCID &lt;&lt; 32;<br>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (kvm_arch_get_supp=
orted_cpuid(s, 7, 0, R_EBX) &amp; CPUID_7_0_EBX_RDSEED) {<br>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; value |=3D (uint64_t)VMX_SECONDARY_EXEC_RDSEED_EXITING &lt;&lt; 32;<br>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (kvm_arch_get_supp=
orted_cpuid(s, 0x80000001, 0, R_EDX) &amp; CPUID_EXT2_RDTSCP) {<br>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; value |=3D (uint64_t)VMX_SECONDARY_EXEC_RDTSCP &lt;&lt; 32;<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!has_msr_vmx_=
procbased_ctls2) {<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; /* KVM forgot to add these bits for some time, do this ourselves. */=
<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; if (kvm_arch_get_supported_cpuid(s, 0xD, 1, R_ECX) &amp;<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; CPUID_XSAVE_XSAVES) {<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; value |=3D (uint64_t)VMX_SECONDARY_EXEC_XSAV=
ES &lt;&lt; 32;<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; }<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; if (kvm_arch_get_supported_cpuid(s, 1, 0, R_ECX) &amp;<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; CPUID_EXT_RDRAND) {<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; value |=3D (uint64_t)VMX_SECONDARY_EXEC_RDRA=
ND_EXITING &lt;&lt; 32;<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; }<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; if (kvm_arch_get_supported_cpuid(s, 7, 0, R_EBX) &amp;<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; CPUID_7_0_EBX_INVPCID) {<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; value |=3D (uint64_t)VMX_SECONDARY_EXEC_ENAB=
LE_INVPCID &lt;&lt; 32;<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; }<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; if (kvm_arch_get_supported_cpuid(s, 7, 0, R_EBX) &amp;<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; CPUID_7_0_EBX_RDSEED) {<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; value |=3D (uint64_t)VMX_SECONDARY_EXEC_RDSE=
ED_EXITING &lt;&lt; 32;<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; }<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; if (kvm_arch_get_supported_cpuid(s, 0x80000001, 0, R_EDX) &amp;<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; CPUID_EXT2_RDTSCP) {<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; value |=3D (uint64_t)VMX_SECONDARY_EXEC_RDTS=
CP &lt;&lt; 32;<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; }<br>
<br>
So you would think that would tkae care of RDSEED exiting - but what<br>
about VMCS shadowing?<br>
<br>
Dave<br>
<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* fall thr=
ough */<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case MSR_IA32_VMX_TRUE_PINBASED_CTL=
S:<br>
&gt; &gt; @@ -2060,6 &#43;2068,9 @@ static int kvm_get_supported_msrs(KVMSt=
ate *s)<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; case MSR_IA32_UCODE_REV:<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; has_msr_ucode_rev =3D true;<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; case MSR_IA32_VMX_PROCBASED_CTLS2:<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; has_msr_vmx_procbased_ctls2 =3D true;<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; }<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &gt;<br>
&gt; <br>
&gt; <br>
--<br>
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK<br>
<br>
</div>
</span></font></div>
</body>
</html>

--_000_BY5PR11MB39604F6B74053A52B79274739AC80BY5PR11MB3960namp_--

