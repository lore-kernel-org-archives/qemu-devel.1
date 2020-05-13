Return-Path: <SRS0=Qw6D=63=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FB05CA90AF
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2020 10:29:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 55501206CC
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2020 10:29:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fPq234oZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55501206CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39570 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYoe5-00045S-Fm
	for qemu-devel@archiver.kernel.org; Wed, 13 May 2020 06:29:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49626)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1jYodO-0003Xb-2e
 for qemu-devel@nongnu.org; Wed, 13 May 2020 06:29:06 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:35098
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1jYodM-0003Ph-FD
 for qemu-devel@nongnu.org; Wed, 13 May 2020 06:29:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589365742;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kcmT/ox8AHLX/QMTCJPzRwt3hsJ5CzQByK8qyk+UAh8=;
 b=fPq234oZLwLf9mlkcXzsHTjAefnhe3xe+Gs/acXsCyfvdtiv/t9E3wS8gxYKc7uAY7Z2Db
 oY188gXji7vqNPWZq/ZsICqksSkAJPKQPPmZWBXVD7RfPRGxhyGl8ujonQ4Q5/o4pzmRnb
 zf/vKScSvPzlx/6Uh1O/dFi/zdii8Cw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-283-xqI8SoykMmaPbd2Rkkxylw-1; Wed, 13 May 2020 06:28:59 -0400
X-MC-Unique: xqI8SoykMmaPbd2Rkkxylw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8B59F835B46;
 Wed, 13 May 2020 10:28:57 +0000 (UTC)
Received: from localhost (unknown [10.40.208.69])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D57247D94A;
 Wed, 13 May 2020 10:28:49 +0000 (UTC)
Date: Wed, 13 May 2020 12:28:47 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Pan Nengyuan <pannengyuan@huawei.com>
Subject: Re: [PATCH v2] i386/kvm: fix a use-after-free when vcpu plug/unplug
Message-ID: <20200513122847.10dbc3c0@redhat.com>
In-Reply-To: <20200513132630.13412-1-pannengyuan@huawei.com>
References: <20200513132630.13412-1-pannengyuan@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Received-SPF: pass client-ip=207.211.31.81; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/13 04:17:42
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: ehabkost@redhat.com, kvm@vger.kernel.org, mtosatti@redhat.com,
 qemu-devel@nongnu.org, zhang.zhanghailiang@huawei.com, euler.robot@huawei.com,
 pbonzini@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 13 May 2020 09:26:30 -0400
Pan Nengyuan <pannengyuan@huawei.com> wrote:

> When we hotplug vcpus, cpu_update_state is added to vm_change_state_head
> in kvm_arch_init_vcpu(). But it forgot to delete in kvm_arch_destroy_vcpu=
() after
> unplug. Then it will cause a use-after-free access. This patch delete it =
in
> kvm_arch_destroy_vcpu() to fix that.
>=20
> Reproducer:
>     virsh setvcpus vm1 4 --live
>     virsh setvcpus vm1 2 --live
>     virsh suspend vm1
>     virsh resume vm1
>=20
> The UAF stack:
> =3D=3Dqemu-system-x86_64=3D=3D28233=3D=3DERROR: AddressSanitizer: heap-us=
e-after-free on address 0x62e00002e798 at pc 0x5573c6917d9e bp 0x7fff07139e=
50 sp 0x7fff07139e40
> WRITE of size 1 at 0x62e00002e798 thread T0
>     #0 0x5573c6917d9d in cpu_update_state /mnt/sdb/qemu/target/i386/kvm.c=
:742
>     #1 0x5573c699121a in vm_state_notify /mnt/sdb/qemu/vl.c:1290
>     #2 0x5573c636287e in vm_prepare_start /mnt/sdb/qemu/cpus.c:2144
>     #3 0x5573c6362927 in vm_start /mnt/sdb/qemu/cpus.c:2150
>     #4 0x5573c71e8304 in qmp_cont /mnt/sdb/qemu/monitor/qmp-cmds.c:173
>     #5 0x5573c727cb1e in qmp_marshal_cont qapi/qapi-commands-misc.c:835
>     #6 0x5573c7694c7a in do_qmp_dispatch /mnt/sdb/qemu/qapi/qmp-dispatch.=
c:132
>     #7 0x5573c7694c7a in qmp_dispatch /mnt/sdb/qemu/qapi/qmp-dispatch.c:1=
75
>     #8 0x5573c71d9110 in monitor_qmp_dispatch /mnt/sdb/qemu/monitor/qmp.c=
:145
>     #9 0x5573c71dad4f in monitor_qmp_bh_dispatcher /mnt/sdb/qemu/monitor/=
qmp.c:234
>=20
> Reported-by: Euler Robot <euler.robot@huawei.com>
> Signed-off-by: Pan Nengyuan <pannengyuan@huawei.com>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> ---
> - v2: remove unnecessary set vmsentry to null(there is no non-null check).
> ---
>  target/i386/cpu.h | 1 +
>  target/i386/kvm.c | 4 +++-
>  2 files changed, 4 insertions(+), 1 deletion(-)
>=20
> diff --git a/target/i386/cpu.h b/target/i386/cpu.h
> index e818fc712a..afbd11b7a3 100644
> --- a/target/i386/cpu.h
> +++ b/target/i386/cpu.h
> @@ -1631,6 +1631,7 @@ struct X86CPU {
> =20
>      CPUNegativeOffsetState neg;
>      CPUX86State env;
> +    VMChangeStateEntry *vmsentry;
> =20
>      uint64_t ucode_rev;
> =20
> diff --git a/target/i386/kvm.c b/target/i386/kvm.c
> index 4901c6dd74..0a4eca5a85 100644
> --- a/target/i386/kvm.c
> +++ b/target/i386/kvm.c
> @@ -1770,7 +1770,7 @@ int kvm_arch_init_vcpu(CPUState *cs)
>          }
>      }
> =20
> -    qemu_add_vm_change_state_handler(cpu_update_state, env);
> +    cpu->vmsentry =3D qemu_add_vm_change_state_handler(cpu_update_state,=
 env);
> =20
>      c =3D cpuid_find_entry(&cpuid_data.cpuid, 1, 0);
>      if (c) {
> @@ -1883,6 +1883,8 @@ int kvm_arch_destroy_vcpu(CPUState *cs)
>          env->nested_state =3D NULL;
>      }
> =20
> +    qemu_del_vm_change_state_handler(cpu->vmsentry);
> +
>      return 0;
>  }
> =20


