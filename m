Return-Path: <SRS0=zj/5=4O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4AD6C4BA0E
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 09:42:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A08D920732
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 09:42:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ta0ieRLs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A08D920732
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41044 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6tDR-0003ti-RM
	for qemu-devel@archiver.kernel.org; Wed, 26 Feb 2020 04:42:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54113)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lersek@redhat.com>) id 1j6tCr-0003SZ-A5
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 04:42:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <lersek@redhat.com>) id 1j6tCp-0005DN-1i
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 04:42:16 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:54508
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <lersek@redhat.com>) id 1j6tCo-00054N-RX
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 04:42:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582710133;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jQtHSMcIWMkGyL2yi1GxbAYzvMHmhlvEw44Eg19ba38=;
 b=Ta0ieRLsrqZOB5lh04C5c5axCZSBtRcfXWM/J5ZvCPKA3Az91L0+INm94COLPcAUP3yQTy
 jyhv4qkeRTknR4/+r0+oKuoSK2jIMIonpPjcc5XXOTSiz2ps/mwqaFxy2x6ppTtGj9YYuC
 7kJ90eaW/X2bFfEDYkKK03LTESlFjx0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-425-D9xknN3aMdm9k2mjFv9_sQ-1; Wed, 26 Feb 2020 04:42:10 -0500
X-MC-Unique: D9xknN3aMdm9k2mjFv9_sQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CA99810766DE;
 Wed, 26 Feb 2020 09:42:08 +0000 (UTC)
Received: from lacos-laptop-7.usersys.redhat.com (ovpn-116-185.ams2.redhat.com
 [10.36.116.185])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 90B0D5C54A;
 Wed, 26 Feb 2020 09:42:06 +0000 (UTC)
Subject: Re: [edk2-devel] A problem with live migration of UEFI virtual
 machines
To: Andrew Fish <afish@apple.com>, devel@edk2.groups.io
References: <tencent_BC7FD00363690990994E90F8@qq.com>
 <87sgjhxbtc.fsf@zen.linaroharston> <20200224152810.GX635661@redhat.com>
 <8b0ec286-9322-ee00-3729-6ec7ee8260a6@redhat.com>
 <3E8BB07B-8730-4AB8-BCB6-EA183FB589C5@apple.com>
 <465a5a84-cac4-de39-8956-e38771807450@redhat.com>
 <8F42F6F1-A65D-490D-9F2F-E12746870B29@apple.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <6666a886-720d-1ead-8f7e-13e65dcaaeb4@redhat.com>
Date: Wed, 26 Feb 2020 10:42:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <8F42F6F1-A65D-490D-9F2F-E12746870B29@apple.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
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
Cc: berrange@redhat.com, qemu-devel@nongnu.org,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 zhoujianjay <zhoujianjay@gmail.com>, discuss <discuss@edk2.groups.io>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 wuchenye1995 <wuchenye1995@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Andrew,

On 02/25/20 22:35, Andrew Fish wrote:

> Laszlo,
>
> The FLASH offsets changing breaking things makes sense.
>
> I now realize this is like updating the EFI ROM without rebooting the
> system.  Thus changes in how the new EFI code works is not the issue.
>
> Is this migration event visible to the firmware? Traditionally the
> NVRAM is a region in the FD so if you update the FD you have to skip
> NVRAM region or save and restore it. Is that activity happening in
> this case? Even if the ROM layout does not change how do you not lose
> the contents of the NVRAM store when the live migration happens? Sorry
> if this is a remedial question but I'm trying to learn how this
> migration works.

With live migration, the running guest doesn't notice anything. This is
a general requirement for live migration (regardless of UEFI or flash).

You are very correct to ask about "skipping" the NVRAM region. With the
approach that OvmfPkg originally supported, live migration would simply
be unfeasible. The "build" utility would produce a single (unified)
OVMF.fd file, which would contain both NVRAM and executable regions, and
the guest's variable updates would modify the one file that would exist.
This is inappropriate even without considering live migration, because
OVMF binary upgrades (package updates) on the virtualization host would
force guests to lose their private variable stores (NVRAMs).

Therefore, the "build" utility produces "split" files too, in addition
to the unified OVMF.fd file. Namely, OVMF_CODE.fd and OVMF_VARS.fd.
OVMF.fd is simply the concatenation of the latter two.

$ cat OVMF_VARS.fd OVMF_CODE.fd | cmp - OVMF.fd
[prints nothing]

When you define a new domain (VM) on a virtualization host, the domain
definition saves a reference (pathname) to the OVMF_CODE.fd file.
However, the OVMF_VARS.fd file (the variable store *template*) is not
directly referenced; instead, it is *copied* into a separate (private)
file for the domain.

Furthermore, once booted, guest has two flash chips, one that maps the
firmware executable OVMF_CODE.fd read-only, and another pflash chip that
maps its private varstore file read-write.

This makes it possible to upgrade OVMF_CODE.fd and OVMF_VARS.fd (via
package upgrades on the virt host) without messing with varstores that
were earlier instantiated from OVMF_VARS.fd. What's important here is
that the various constants in the new (upgraded) OVMF_CODE.fd file
remain compatible with the *old* OVMF_VARS.fd structure, across package
upgrades.

If that's not possible for introducing e.g. a new feature, then the
package upgrade must not overwrite the OVMF_CODE.fd file in place, but
must provide an additional firmware binary. This firmware binary can
then only be used by freshly defined domains (old domains cannot be
switched over). Old domains can be switched over manually -- and only if
the sysadmin decides it is OK to lose the current variable store
contents. Then the old varstore file for the domain is deleted
(manually), the domain definition is updated, and then a new (logically
empty, pristine) varstore can be created from the *new* OVMF_2_VARS.fd
that matches the *new* OVMF_2_CODE.fd.


During live migration, the "RAM-like" contents of both pflash chips are
migrated (the guest-side view of both chips remains the same, including
the case when the writeable chip happens to be in "programming mode",
i.e., during a UEFI variable write through the Fault Tolerant Write and
Firmware Volume Block(2) protocols).

Once live migration completes, QEMU dumps the full contents of the
writeable chip to the backing file (on the destination host). Going
forward, flash writes from within the guest are reflected to said
host-side file on-line, just like it happened on the source host before
live migration. If the file backing the r/w pflash chip is on NFS
(shared by both src and dst hosts), then this one-time dumping when the
migration completes is superfluous, but it's also harmless.

The interesting question is, what happens when you power down the VM on
the destination host (= post migration), and launch it again there, from
zero. In that case, the firmware executable file comes from the
*destination host* (it was never persistently migrated from the source
host, i.e. never written out on the dst). It simply comes from the OVMF
package that had been installed on the destination host, by the
sysadmin. However, the varstore pflash does reflect the permanent result
of the previous migration. So this is where things can fall apart, if
both firmware binaries (on the src host and on the dst host) don't agree
about the internal structure of the varstore pflash.

Thanks
Laszlo


