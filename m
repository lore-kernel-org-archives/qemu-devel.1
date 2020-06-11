Return-Path: <SRS0=U615=7Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0864BC433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 09:15:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF4AB2078D
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 09:15:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TEAuDVPu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF4AB2078D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39470 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjJIw-0006X1-W6
	for qemu-devel@archiver.kernel.org; Thu, 11 Jun 2020 05:15:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53646)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <drjones@redhat.com>)
 id 1jjJI4-0005tN-62
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 05:14:28 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:51779
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <drjones@redhat.com>)
 id 1jjJI3-0000yL-DL
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 05:14:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591866866;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=P8c1wxI9qT72Dg+EUCoyPxu2yI/s+ts/sEYQpOuBIkg=;
 b=TEAuDVPuc4o5dPi35iC45Z4REN8Nyyx2A7Kjtd9slKlGxmi0APp7Uo/E+5Og9GziEvyd1J
 8wXox0kfYT3+3zzfV2FbFER8W6UmazKWJkV9fLVMerhGphXMvDBsrAgHvenNXVzND+3EX4
 IqUHhQJ4pFQAlZHynEo99EN1YzLhoC8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-414-gOKvY7lXPAyyfQoQl3PTBg-1; Thu, 11 Jun 2020 05:14:24 -0400
X-MC-Unique: gOKvY7lXPAyyfQoQl3PTBg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8AE52835B92;
 Thu, 11 Jun 2020 09:14:23 +0000 (UTC)
Received: from kamzik.brq.redhat.com (unknown [10.40.195.76])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4DA558FF80;
 Thu, 11 Jun 2020 09:14:22 +0000 (UTC)
Date: Thu, 11 Jun 2020 11:14:19 +0200
From: Andrew Jones <drjones@redhat.com>
To: Haibo Xu <haibo.xu@linaro.org>, philmd@redhat.com
Subject: Re: Core dump happened when starting a VM on arm64 server
Message-ID: <20200611091419.e2rfcurztmlajlwr@kamzik.brq.redhat.com>
References: <CAJc+Z1Eb815hroFPY+9Ai_9hh=+eje+X2ENtGj9XA+_F0XUPqg@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAJc+Z1Eb815hroFPY+9Ai_9hh=+eje+X2ENtGj9XA+_F0XUPqg@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=drjones@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/11 03:29:33
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Jun 11, 2020 at 04:46:45PM +0800, Haibo Xu wrote:
> Hi,
> 
> I met a qemu core dump issue when starting a VM with cpu feature
> "pmu=on" on an arm server.
> The commands to start the machine is:
> 
>   ./qemu-system-aarch64 \
>            -cpu host,pmu=on -M virt,accel=kvm,gic-version=3 -nographic
> -m 2048M \
>            -kernel ./Image \
>            -initrd /boot/initrd.img-5.6.0-rc2+ \
>            -append "root=/dev/vda rw console=ttyAMA0" -nodefaults -serial stdio\
>            -drive if=none,file=./xenial.rootfs.ext4,id=hd0,format=raw \
>            -device virtio-blk-device,drive=hd0
> 
> 
> And here is the stack dump:
> 
>  Core was generated by `./qemu-system-aarch64 -cpu host,pmu=on -M
> virt,accel=kvm,gic-version=3 -nograph'.
>  Program terminated with signal SIGSEGV, Segmentation fault.
>  #0  kvm_ioctl (s=0x0, type=type@entry=44547) at

s=0x0 means cpu->kvm_state is NULL

> The root cause is in the arm_get_pmu() operation which was introduced
> in ae502508f83.

Actually the root cause is d70c996df23f ("target/arm/kvm: Use
CPUState::kvm_state in kvm_arm_pmu_supported()"). ae502508f83 used
the machine kvm_state, not the cpu kvm_state, and that allows pmu=on
to work. d70c996df23f changed that saying that "KVMState is already
accessible via CPUState::kvm_state, use it.", but I'm not sure why,
since kvm_init_vcpu() doesn't run until the vcpu thread is created.

Philippe?

Thanks,
drew


