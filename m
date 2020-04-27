Return-Path: <SRS0=Hhxc=6L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D3BCC54FD0
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2020 06:19:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC2B9206B6
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2020 06:19:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZNF4P+U8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC2B9206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53960 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jSx79-00049Z-1i
	for qemu-devel@archiver.kernel.org; Mon, 27 Apr 2020 02:19:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58932)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <drjones@redhat.com>) id 1jSx6E-0003Ca-Sq
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 02:18:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <drjones@redhat.com>) id 1jSx6E-0004mo-Ba
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 02:18:38 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:33735
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <drjones@redhat.com>)
 id 1jSx6D-0004mg-SQ
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 02:18:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587968316;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=z9GxT9ibmzxXP3rSVkXz4GcBHwjbM4n+aVHQx3+API8=;
 b=ZNF4P+U8jVK5XhD6K7yBCy8ZjtLa0sjUKloKIRBjc7P9DNjN4Kd5TH4r3rd1RpihuTk742
 MoJxn5Okj9FALJ66kl/5bpJT45rLj6RHuFMzOF/g/s1xH/peZ5udSYwMh3lUAlBF71i1zb
 zTYBemCYEFLPGNShEAH7jwbWp8AjSqk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-344-48T284WyPxiX5ZkcYYpzVw-1; Mon, 27 Apr 2020 02:18:34 -0400
X-MC-Unique: 48T284WyPxiX5ZkcYYpzVw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EB157464;
 Mon, 27 Apr 2020 06:18:32 +0000 (UTC)
Received: from kamzik.brq.redhat.com (unknown [10.40.192.184])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7FB5A60C80;
 Mon, 27 Apr 2020 06:18:30 +0000 (UTC)
Date: Mon, 27 Apr 2020 08:18:27 +0200
From: Andrew Jones <drjones@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v4 1/2] target/arm: kvm: Handle DABT with no valid ISS
Message-ID: <20200427061827.s3fcyvdu3r3bfijj@kamzik.brq.redhat.com>
References: <20200323113227.3169-1-beata.michalska@linaro.org>
 <20200323113227.3169-2-beata.michalska@linaro.org>
 <CAFEAcA_uWS+cVRk=BKra8AhsD+B1syVzhXeCMttSKwQDdo=j3w@mail.gmail.com>
 <20200417131032.lcyunbjwofsn2nzz@kamzik.brq.redhat.com>
 <20200424121633.GF3106@work-vm>
 <d6f4b17c-1202-3aef-320a-247dc0295277@redhat.com>
MIME-Version: 1.0
In-Reply-To: <d6f4b17c-1202-3aef-320a-247dc0295277@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=drjones@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/26 23:32:35
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Beata Michalska <beata.michalska@linaro.org>, quintela@redhat.com,
 Christoffer Dall <Christoffer.Dall@arm.com>,
 QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>,
 kvmarm@lists.cs.columbia.edu, "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, Apr 25, 2020 at 11:24:14AM +0200, Paolo Bonzini wrote:
> On 24/04/20 14:16, Dr. David Alan Gilbert wrote:
> >>> I was trying to work out whether we need to migrate this state,
> >>> and I'm not sure. Andrew, do you know? I think this comes down
> >>> to "at what points in QEMU's kvm run loop can migration kick in",
> >>> and specifically if we get a KVM_EXIT_ARM_NISV do we definitely
> >>> go round the loop and KVM_RUN again without ever checking
> >>> to see if we should do a migration ?
> >>>
> >> I'd prefer a migration expert confirm this, so I've CC'ed David and Ju=
an,
> >> but afaict there's no way to break out of the KVM_RUN loop after a
> >> successful (ret=3D0) call to kvm_arch_handle_exit() until after the ne=
xt
> >> KVM_RUN ioctl. This is because even if migration kicks the vcpus betwe=
en
> >> kvm_arch_handle_exit() and the next run, the signal won't do anything
> >> other than prepare the vcpu for an immediate exit.
>=20
> As far as QEMU is concerned, this should be enough for Beata's patch to
> be safe.  If the signal causes KVM to exit before KVM_EXIT_ARM_NISV,
> it's of course okay.  If you get a KVM_EXIT_ARM_NISV, however, KVM_RUN
> will exit with return code 0 and kvm_cpu_exec will:
>=20
> - set env->ext_dabt_pending
>=20
> - go round the loop again
>=20
> - notice cpu->exit_request and schedule an immediate exit
>=20
> - call kvm_arch_put_registers
>=20
> - call KVM_RUN again, which will exit with -EINTR
>=20
> - exit the loop and allow migration to proceed

This was my understanding as well. Thanks for the confirmation.

>=20
> However, I'm not sure that it's a good idea to
>=20
> +        /* Clear instantly if the call was successful */
> +        env->ext_dabt_pending =3D 0;
>=20
> Rather, this should be done by the next kvm_arch_get_registers when it
> calls KVM_GET_VCPU_EVENTS.  It's also possible to add an assertion in
> kvm_get_vcpu_events that it you always get zero, to justify that the
> field is not migrated.

I like the idea of a balanced API; keeping the 'set' abort pending
until the next 'get', but this event doesn't work that way.
Documentation/virt/kvm/api.rst states:

  It is not possible to read back a pending external abort (injected via
  KVM_SET_VCPU_EVENTS or otherwise) because such an exception is always
  delivered directly to the virtual CPU).

I think clearing the userspace copy instantly after a successful
KVM_SET_VCPU_EVENTS implements that correctly.

Thanks,
drew


