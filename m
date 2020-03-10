Return-Path: <SRS0=ZRpO=43=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 749F2C10DCE
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 20:57:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3194A215A4
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 20:57:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cGJH5LQc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3194A215A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40170 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBlw8-0003kz-CX
	for qemu-devel@archiver.kernel.org; Tue, 10 Mar 2020 16:57:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37526)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1jBlvH-0002S6-5n
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 16:56:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1jBlvF-0002QR-GC
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 16:56:18 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:48754
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1jBlvF-0002OL-8C
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 16:56:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583873776;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6kX4LS5ASycnks83Rvhanl1KSYdqZHcKgs1BKVWoJxk=;
 b=cGJH5LQcPySDiscSOpI1dIY1gV3mqHTh0fb8r7n4CiqO5RJjb5opND7bFMWopLeqveHt0q
 QYN/omHA9OJkQw9OP8mWG0yw+j08Qi8JprqSmZnAyF/aOmxSLNfvW2v8wqVj6ytZD53+Vk
 ZT41kuFP2UPChLchhkhK/9Y55StB+NQ=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-377-2WjmiXBhNWS6POINo0pQcg-1; Tue, 10 Mar 2020 16:56:14 -0400
X-MC-Unique: 2WjmiXBhNWS6POINo0pQcg-1
Received: by mail-qv1-f71.google.com with SMTP id w1so9910462qvp.23
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2020 13:56:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=73Km+G2EdmT+jiuYG/JtPH/g0wLI4amjEMjilwF0ccA=;
 b=jXvTev7MHMPe88vY3G1FtXRWWsc5nQhPfTWvP7TIqpd79tg+tRM17V9n4bhyDbpbvV
 ZxmxXfWn/Zyr5k9Ugu3N4Ldc5ASNUjxG99G2neOVgEt3cWbk3onXyDCRxNi0wAdHWHqI
 ZJTnc91ClJf7vCEOsIKYMci6237qYlSCX1t6lUw0IPLwwD8m7IUElsiO3ZRCx2io9fxt
 60DYJEP5VLViH0ENS7j/joY4nVUdYnftFoxsvC+FzUMwlnBGaHDD4ncg5qD4NFy4lKcK
 hhv0gb8vZUi7YVCA4UdQ1RGM0wpOylfq7qNv+WUckd2FPUqgxkqF9goOfYbDaZutqTRN
 kQGg==
X-Gm-Message-State: ANhLgQ1acHwckwK91GIsGM6ubwBHFPManV5DX/ZCWdTh6DNDLCTyL8vQ
 Yi3htqAqMx9MiiVuvHWFDPktvJA+Z5/dBjdRaqt6lyY7cuNCfdjA/m+I5hYX/FuzpVAlsHj5qTI
 dxFVq6PcIKiePBoY=
X-Received: by 2002:ad4:4564:: with SMTP id o4mr86836qvu.190.1583873773818;
 Tue, 10 Mar 2020 13:56:13 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vsa/jiY+8R2/jvA3F2LaSx7Eaoj816mjbrYa2q3Scb7+x5dc4xEDkGzOulASHzDUb9h51nEOg==
X-Received: by 2002:ad4:4564:: with SMTP id o4mr86828qvu.190.1583873773510;
 Tue, 10 Mar 2020 13:56:13 -0700 (PDT)
Received: from redhat.com (bzq-79-178-2-19.red.bezeqint.net. [79.178.2.19])
 by smtp.gmail.com with ESMTPSA id w11sm20737494qti.54.2020.03.10.13.56.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Mar 2020 13:56:12 -0700 (PDT)
Date: Tue, 10 Mar 2020 16:56:06 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Liran Alon <liran.alon@oracle.com>
Subject: Re: [PATCH v2 00/16]: hw/i386/vmport: Bug fixes and improvements
Message-ID: <20200310164239-mutt-send-email-mst@kernel.org>
References: <20200310165332.140774-1-liran.alon@oracle.com>
 <20200310133932-mutt-send-email-mst@kernel.org>
 <bcf7f439-7954-a6dc-322e-f8cbddd51d24@oracle.com>
MIME-Version: 1.0
In-Reply-To: <bcf7f439-7954-a6dc-322e-f8cbddd51d24@oracle.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: nikita.leshchenko@oracle.com, ehabkost@redhat.com, qemu-devel@nongnu.org,
 rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Mar 10, 2020 at 08:09:09PM +0200, Liran Alon wrote:
>=20
> On 10/03/2020 19:44, Michael S. Tsirkin wrote:
> > On Tue, Mar 10, 2020 at 06:53:16PM +0200, Liran Alon wrote:
> > > Hi,
> > >=20
> > > This series aims to fix several bugs in VMPort and improve it by supp=
orting
> > > more VMPort commands and make command results more configurable to
> > > user via QEMU command-line.
> > >=20
> > > This functionality was proven to be useful to run various VMware VMs
> > > when attempting to run them as-is on top of QEMU/KVM.
> > >=20
> > > For more details, see commit messages.
> > Well two versions in one day and some review comments weren't addressed=
.
> There is a single review comment that wasn't addressed which is replacing=
 an
> enum with a comment. And I explicitly mentioned that it's because I want
> additional opinion on this.
> I don't see why such a small thing should block review for 15 patches...
> All the rest of the comments (Which were great) have been addressed. Unle=
ss
> I have mistakenly missed something, which please point it out if I did.

OK I just took a quick peek, two things quickly jumped out at me.

version property really should be a boolean and have some documentation
saying what functionality enables.

userspace properties should use the non-abbreviated
vm-executable since vmx is easy to confuse with vm extensions.

That's just a quick look.


> > Some people do this, try to wear the maintainers out by sheer volume.
> > It works sometimes but it's not a nice tactic. I personally think it's
> > worth taking the time to think harder about ways to address all
> > comments, not try to dismiss them.
> That's not what I tried to do. I carefully fixed all comments I saw in th=
e
> review discussion and run tests.
> The only thing which wasn't addressed is removing an enum and replacing i=
t
> with a comment.
> The hint that I try to manipulate maintainers is disrespectful. I assume
> that this isn't your intention, as we all just want to collaborate togeth=
er
> here. No need to make this a personal discussion.
>=20
> If you think that replacing the enum with a comment is a blocker for v2
> patch-series, I will go ahead and submit v3 with that change.

Yes IMHO it needs to be fixed but please go over the comments and try to
address them all as best you can, instead of looking for an explanation
why the comments were irrelevant and can be dismissed.  Sure someone
might propose you introduce a bug, and that can't just be addressed, but
that's not the case here.  Also please do not send multiple revisions of
a large patchset in a day.  People need time for review.

> Is there any other comment you made on v1 patch-series you think I missed=
?
>=20
> Thanks,
> -Liran
>=20
> >=20
> > Thanks!
> >=20
> > > Regards,
> > > -Liran
> > >=20
> > > v1->v2:
> > > * Fix coding convention [Patchew Bot & MST].
> > > * Create new header file for vmport.h [MST].
> > > * Move KVM_APIC_BUS_FREQUENCY from linux-headers/asm-x86/kvm.h
> > >    auto-generated header [MST]
> > > * Elaborate more that vmx-version refers to the VMware userspace
> > >    VMM in commit message. [MST]
> > > * Use le32_to_cpu() on BIOS_UUID vmport command. [MST]
> > > * Introduce VMPort compatability version property to maintain migrati=
on
> > >    compatibility. [MST]


