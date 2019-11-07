Return-Path: <SRS0=+ldK=Y7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABC7FC5DF60
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2019 11:53:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7450F2166E
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2019 11:53:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iFw9cAIQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7450F2166E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41214 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iSgLp-0000rF-Jf
	for qemu-devel@archiver.kernel.org; Thu, 07 Nov 2019 06:53:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52361)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1iSgKp-0000Pp-Nv
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 06:52:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1iSgKo-0007CD-0J
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 06:52:19 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:20638
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1iSgKn-0007Bl-Rt
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 06:52:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573127536;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bWnh5JFISOJDLBz0J9xZhxxwsWOlAahhYzC1l/WC8gA=;
 b=iFw9cAIQQ5pd3vcaZ3sV90YaDt+AXij+Cz5r+Dk2FQNWU3IbmHEsltZxrezG7elhexMp2c
 eXlrrm03HBXC3TkpRJqa9kkcLzP/tR9Hx/t0gNP3v3d5Kls9LdU9IhYTaqRsPmHklibYjv
 6UpN1ZoCrPgISKUTI0t2ZZb5He7A5zg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-202-Qf9vTQ8tP3mID9UthTfCSg-1; Thu, 07 Nov 2019 06:52:13 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 273DC800C61;
 Thu,  7 Nov 2019 11:52:12 +0000 (UTC)
Received: from redhat.com (unknown [10.42.16.105])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id ACF9C5DA32;
 Thu,  7 Nov 2019 11:52:05 +0000 (UTC)
Date: Thu, 7 Nov 2019 11:52:03 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Laszlo Ersek <lersek@redhat.com>
Subject: Re: privileged entropy sources in QEMU/KVM guests
Message-ID: <20191107115203.GD120292@redhat.com>
References: <03e769cf-a5ad-99ce-cd28-690e0a72a310@redhat.com>
MIME-Version: 1.0
In-Reply-To: <03e769cf-a5ad-99ce-cd28-690e0a72a310@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: Qf9vTQ8tP3mID9UthTfCSg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 Jian J Wang <jian.j.wang@intel.com>,
 edk2-devel-groups-io <devel@edk2.groups.io>,
 Bret Barkelew <Bret.Barkelew@microsoft.com>,
 qemu devel list <qemu-devel@nongnu.org>, Erik Bjorge <erik.c.bjorge@intel.com>,
 Sean Brogan <sean.brogan@microsoft.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Nov 07, 2019 at 11:10:57AM +0100, Laszlo Ersek wrote:
> Hi,
>=20
> related TianoCore BZ:
>=20
>   https://bugzilla.tianocore.org/show_bug.cgi?id=3D1871
>=20
> (I'm starting this thread separately because at least some of the topics
> are specific to QEMU, and I didn't want to litter the BZ with a
> discussion that may not be interesting to all participants CC'd on the
> BZ. I am keeping people CC'd on this initial posting; please speak up if
> you'd like to be dropped from the email thread.)
>=20
> QEMU provides guests with the virtio-rng device, and the OVMF and
> ArmVirtQemu* edk2 platforms build EFI_RNG_PROTOCOL on top of that
> device. But, that doesn't seem enough for all edk2 use cases.
>=20
> Also, virtio-rng (hence EFI_RNG_PROTOCOL too) is optional, and its
> absence may affect some other use cases.

The optional nature of virtio-rng is something that results in the
the same problems for Linux.

If virtio-rng is absent, then Linux now has a general purpose fallback
via the CPU timing jitter entropy source:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?=
id=3Dbb5530e4082446aac3a3d69780cd4dbfa4520013

Is it practical to provide a jitter entropy source for EDK2
too ?

> (1) For UEFI HTTPS boot, TLS would likely benefit from good quality
> entropy. If the VM config includes virtio-rng (hence the guest firmware
> has EFI_RNG_PROTOCOL), then it should be used as a part of HTTPS boot.
>=20
> However, what if virtio-rng (hence EFI_RNG_PROTOCOL) are absent? Should
> UEFI HTTPS boot be disabled completely (or prevented / rejected
> somehow), blaming lack of good entropy? Or should TLS silently fall back
> to "mixing some counters [such as TSC] together and applying a
> deterministic cryptographic transformation"?
>=20
> IOW, knowing that the TLS setup may not be based on good quality
> entropy, should we allow related firmware services to "degrade silently"
> (not functionally, but potentially in security), or should we deny the
> services altogether?

If we can guarantee we always present fallback like jitterentropy
then the problem with TLS init goes away IIUC.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange=
 :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com=
 :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange=
 :|


