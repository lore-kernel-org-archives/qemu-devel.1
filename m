Return-Path: <SRS0=Qmby=6N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F481C83000
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 16:05:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1803A2072A
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 16:05:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C2kotQgv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1803A2072A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33508 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTpDU-0002lg-41
	for qemu-devel@archiver.kernel.org; Wed, 29 Apr 2020 12:05:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39254)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1jTp6g-00058X-QK
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 11:59:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1jTp5Z-0002Tn-PF
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 11:58:42 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:38350
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jTp5Z-0002SP-AC
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 11:57:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588175850;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VNdsFlxTDeWjlHAAFuGq+1SZxzoADdixrtmtPKOEK/A=;
 b=C2kotQgveJZLDsNK9jy1rhiUBYCyaJ1VBC39dw39V9XHlagTWNFvjIDgAwhLAa4sVhBz2g
 95uPCYGbZo4z5OQLbrkzKQC/ge5thKwiwh5dg8oehRVb8j6uy4kov0sMTZgHB4ctg98ahp
 lw9RVt5hq1xk2A/usqWh3isv8iZHyg8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-145-9dhoWSC_OXasGtCktO_WJw-1; Wed, 29 Apr 2020 11:57:28 -0400
X-MC-Unique: 9dhoWSC_OXasGtCktO_WJw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CE77E107ACF3;
 Wed, 29 Apr 2020 15:57:27 +0000 (UTC)
Received: from redhat.com (unknown [10.36.110.2])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3E9FD5D9C9;
 Wed, 29 Apr 2020 15:57:22 +0000 (UTC)
Date: Wed, 29 Apr 2020 16:57:19 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Subject: Re: Failing property setters + hardwired devices + -global = a bad day
Message-ID: <20200429155719.GL1495129@redhat.com>
References: <87mu6uia5i.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
In-Reply-To: <87mu6uia5i.fsf@dusky.pond.sub.org>
User-Agent: Mutt/1.13.3 (2020-01-12)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=berrange@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/29 01:18:10
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>, Jason Wang <jasowang@redhat.com>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Apr 29, 2020 at 05:28:25PM +0200, Markus Armbruster wrote:
> Is there any sane use for configuring backends via any of the default
> mechanisms?
>=20
> I'm aware of one, but it's outdated: -global isa-fdc.driveA=3D...  Use
> -device floppy instead.
>=20
> I'd love to deprecate -global wholesale, but we can't as long as we
> don't have better means to configure onboard devices.  Can we deprecate
> its use with backend properties at least?

Currently libvirt has code using the following


* Floppy

  -global isa-fdc.driveA=3DID
  -global isa-fdc.driveB=3DID
  -global isa-fdc.bootindexA=3DNN
  -global isa-fdc.bootindexB=3DNN

  Only used when the machine type is pc-q35-2.4 or earlier

* NVRAM

  -global spapr-nvram.reg=3D0xnnnn

* Video primary display adapter

  -global qxl-vga.ram_size=3DNN
  -global qxl-vga.vram_size=3DNN
  -global qxl-vga.vram64_size=3DNN
  -global qxl-vga.vgamem_mb=3DNN
  -global qxl-vga.max_outputs=3DNN
  -global VGA.vgamem_mb=3DMM
  -global vmware-svga.vgamem_mb=3DMM

  Only used for old qemu lacking -device support where we must use -vga
  instead


* PIT policy

   -global kvm-pit.lost_tick_policy=3DXXX


* S3/S4

   -global PIIX4_PM.disable_s3=3DNNN
   -global PIIX4_PM.disable_s4=3DNNN
   -global ICH9-LPC.disable_s3=3DNNN
   -global ICH9-LPC.disable_s4=3DNNN

* PCI hole

   -global i440FX-pcihost.pci-hole64-size=3DNNN
   -global q35-pcihost.pci-hole64-size=3DNNN

* SMM TSeg

   -global mch.extended-tseg-mbytes=3DNNN

* pflash

   -global driver=3Dcfi.pflash01,property=3Dsecure,value=3Don

  Used for EFI secure boot


I'm unclear which of these can be replaced with a different QEMU cli
option....

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange=
 :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com=
 :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange=
 :|


