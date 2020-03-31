Return-Path: <SRS0=xFA2=5Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05F76C43331
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 17:27:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C6F2820BED
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 17:27:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DCWVp8Jj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6F2820BED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42188 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJKfi-0006H0-VZ
	for qemu-devel@archiver.kernel.org; Tue, 31 Mar 2020 13:27:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50492)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1jJKf4-0005rI-NH
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 13:26:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1jJKf3-0003iI-7v
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 13:26:50 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:50406
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1jJKf3-0003hf-38
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 13:26:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585675607;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zvISRHraneO3eHN3s6l9Wyeno1PweHHLPP3MkYADUJE=;
 b=DCWVp8JjkIY9uAMw2ahVmnUkp+Etl77/TXI6aeUBjFdk4vr5D8ao/yb5tBkjz7I0ybDDs5
 MVQ9NPaLOFHVhqbN7pdp3F6tYDHP/3g12K3vGUb2fkm6jaHU57OuIc4VfI+9Segh3aGtDr
 hdQkqpJ9DCpFL2MUU2I93U+ISuzHyUI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-357-Tj95EuoyPXWiJ18uGxPHxA-1; Tue, 31 Mar 2020 13:26:45 -0400
X-MC-Unique: Tj95EuoyPXWiJ18uGxPHxA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6A1D3107ACC7;
 Tue, 31 Mar 2020 17:26:44 +0000 (UTC)
Received: from work-vm (ovpn-112-221.ams2.redhat.com [10.36.112.221])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9253096B8D;
 Tue, 31 Mar 2020 17:26:42 +0000 (UTC)
Date: Tue, 31 Mar 2020 18:26:40 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: "Montes, Julio" <julio.montes@intel.com>
Subject: Re: [PATCH] target/i386: do not set unsupported VMX secondary
 execution controls
Message-ID: <20200331172640.GE2896@work-vm>
References: <20200331162752.1209928-1-vkuznets@redhat.com>
 <f976c1b0-2f50-d9f6-0921-2fc8e25ddb80@redhat.com>
 <BY5PR11MB396059E9E1FFE4B93EDE38E89AC80@BY5PR11MB3960.namprd11.prod.outlook.com>
 <BY5PR11MB3960FE6E5F51F95EF9DFAAAB9AC80@BY5PR11MB3960.namprd11.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <BY5PR11MB3960FE6E5F51F95EF9DFAAAB9AC80@BY5PR11MB3960.namprd11.prod.outlook.com>
User-Agent: Mutt/1.13.3 (2020-01-12)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Vitaly Kuznetsov <vkuznets@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Montes, Julio (julio.montes@intel.com) wrote:
> Sorry for my last email, it was incomplete
>=20
> Hi Vitaly
>=20
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
=20
VMX_SECONDARY_EXEC_SHADOW_VMCS              0x00004000  !
VMX_SECONDARY_EXEC_ENABLE_INVPCID           0x00001000
=20
VMX_SECONDARY_EXEC_RDRAND_EXITING           0x00000800
=20
VMX_SECONDARY_EXEC_ENABLE_VPID              0x00000020
=20
VMX_SECONDARY_EXEC_ENABLE_EPT               0x00000002
VMX_SECONDARY_EXEC_DESC                     0x00000004
VMX_SECONDARY_EXEC_RDTSCP                   0x00000008

>=20
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
>=20
>=20
>=20
> ./vmxcap output:
>=20
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
>=20
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


