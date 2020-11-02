Return-Path: <SRS0=N3Ri=EI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56327C388F9
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2020 18:33:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF65E22245
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2020 18:33:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aE2dZ8Vu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF65E22245
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47368 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZeeE-0007Ri-IM
	for qemu-devel@archiver.kernel.org; Mon, 02 Nov 2020 13:33:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43678)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1kZebs-0006Vz-RO
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 13:31:17 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:22846)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1kZebp-0008Jr-U3
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 13:31:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604341871;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Kllnz1HTiccEmc++7DZ5F+gEQHuXbjJFuHHaQ12fyOs=;
 b=aE2dZ8Vuglqwm0rgIuxP7i4MtzAyenVYpGZhSQJKfPfhUsa14OL0YT7eiGZVnzwdwtPOLl
 fEn+e+kJvSzbH6tWkcKeWlvVtItzo0ndxfMROyvHn5CjOdwWSBGjq6qZbrOieR5brvWZYn
 H4AlKGklySwwZIW39sQCLuoUBqVj/pw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-569-rGZibH3_NIe2Sc1cGf1Ojw-1; Mon, 02 Nov 2020 13:31:03 -0500
X-MC-Unique: rGZibH3_NIe2Sc1cGf1Ojw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6AF5F8030C0;
 Mon,  2 Nov 2020 18:31:02 +0000 (UTC)
Received: from work-vm (ovpn-114-142.ams2.redhat.com [10.36.114.142])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 67ADD5D9D2;
 Mon,  2 Nov 2020 18:30:55 +0000 (UTC)
Date: Mon, 2 Nov 2020 18:30:52 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Subject: Re: [PATCH] virtiofsd: Seccomp: Add 'send' for syslog
Message-ID: <20201102183052.GB4845@work-vm>
References: <20201102150750.34565-1-dgilbert@redhat.com>
 <20201102151712.GF138796@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20201102151712.GF138796@redhat.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=dgilbert@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=dgilbert@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/02 01:33:03
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: virtio-fs@redhat.com, qemu-devel@nongnu.org, stefanha@redhat.com,
 amulmek1@in.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Daniel P. Berrangé (berrange@redhat.com) wrote:
> On Mon, Nov 02, 2020 at 03:07:50PM +0000, Dr. David Alan Gilbert (git) wrote:
> > From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> > 
> > On ppc it looks like syslog ends up using 'send' rather than 'sendto'.
> > 
> > Reference: https://github.com/kata-containers/kata-containers/issues/1050
> > 
> > Reported-by: amulmek1@in.ibm.com
> > Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> > ---
> >  tools/virtiofsd/passthrough_seccomp.c | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/tools/virtiofsd/passthrough_seccomp.c b/tools/virtiofsd/passthrough_seccomp.c
> > index eb9af8265f..672fb72a31 100644
> > --- a/tools/virtiofsd/passthrough_seccomp.c
> > +++ b/tools/virtiofsd/passthrough_seccomp.c
> > @@ -118,6 +118,7 @@ static const int syscall_whitelist[] = {
> >  
> >  /* Syscalls used when --syslog is enabled */
> >  static const int syscall_whitelist_syslog[] = {
> > +    SCMP_SYS(send),
> >      SCMP_SYS(sendto),
> >  };
> 
> With glibc, syslog() calls __send() which for Linux target is implemented
> as:
> 
> 
> ssize_t
> __libc_send (int fd, const void *buf, size_t len, int flags)
> {
> #ifdef __ASSUME_SEND_SYSCALL
>   return SYSCALL_CANCEL (send, fd, buf, len, flags);
> #elif defined __ASSUME_SENDTO_SYSCALL
>   return SYSCALL_CANCEL (sendto, fd, buf, len, flags, NULL, 0);
> #else
>   return SOCKETCALL_CANCEL (send, fd, buf, len, flags);
> #endif
> }
> 
> We can see those defines being referenced vary per architecture:
> 
> $ git grep -E '__ASSUME_SEND(TO)?_SYSCALL' sysdeps/
> sysdeps/unix/sysv/linux/alpha/kernel-features.h:#define __ASSUME_SEND_SYSCALL   1
> sysdeps/unix/sysv/linux/arm/kernel-features.h:#define __ASSUME_SEND_SYSCALL     1
> sysdeps/unix/sysv/linux/hppa/kernel-features.h:#define __ASSUME_SEND_SYSCALL    1
> sysdeps/unix/sysv/linux/i386/kernel-features.h:# undef __ASSUME_SENDTO_SYSCALL
> sysdeps/unix/sysv/linux/ia64/kernel-features.h:#define __ASSUME_SEND_SYSCALL            1
> sysdeps/unix/sysv/linux/kernel-features.h:#define __ASSUME_SENDTO_SYSCALL               1
> sysdeps/unix/sysv/linux/m68k/kernel-features.h:# undef __ASSUME_SENDTO_SYSCALL
> sysdeps/unix/sysv/linux/microblaze/kernel-features.h:#define __ASSUME_SEND_SYSCALL              1
> sysdeps/unix/sysv/linux/mips/kernel-features.h:# define __ASSUME_SEND_SYSCALL           1
> sysdeps/unix/sysv/linux/powerpc/kernel-features.h:#define __ASSUME_SEND_SYSCALL         1
> sysdeps/unix/sysv/linux/s390/kernel-features.h:# undef __ASSUME_SENDTO_SYSCALL
> sysdeps/unix/sysv/linux/send.c:#ifdef __ASSUME_SEND_SYSCALL
> sysdeps/unix/sysv/linux/send.c:#elif defined __ASSUME_SENDTO_SYSCALL
> sysdeps/unix/sysv/linux/sendto.c:#ifdef __ASSUME_SENDTO_SYSCALL
> sysdeps/unix/sysv/linux/sh/kernel-features.h:#define __ASSUME_SEND_SYSCALL              1
> sysdeps/unix/sysv/linux/sparc/kernel-features.h:# undef __ASSUME_SENDTO_SYSCALL
> 
> 
> So the patch is correct, but the commit message could be updated becase
> this isn't specific to PPC.  Any platform except x86, s490, m68k will
> use send() rather than sendto() based on what I see here.
> 
> With any commit message update, you can add
> 
> Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>

Thanks, changed to:

  On ppc, and some other archs, it looks like syslog ends up using 'send'
  rather than 'sendto'.

Dave

> 
> 
> Regards,
> Daniel
> -- 
> |: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
> |: https://libvirt.org         -o-            https://fstop138.berrange.com :|
> |: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
> 
> 
-- 
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


