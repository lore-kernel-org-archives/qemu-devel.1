Return-Path: <SRS0=Tmh/=3Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 324A8C35247
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 17:37:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F3FC721741
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 17:37:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AhE57vzr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3FC721741
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54406 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izOcd-0007jS-8n
	for qemu-devel@archiver.kernel.org; Wed, 05 Feb 2020 12:37:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47407)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1izOYZ-0004NS-6r
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 12:33:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1izOYW-0002kX-Ky
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 12:33:41 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:55557
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1izOYW-0002iV-GT
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 12:33:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580924019;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zbEorfVCzjjc6I0AE62QmdIN9JIltkcMC54DrdJm0AE=;
 b=AhE57vzr29FK+HKmPI2pLMOyVEyK4sfwXzClw8bjW3T6MJzSjT7U4edhPpIlCY+6YsXGcO
 xtzienz22586lLbkIIQp2jhd0OEZPvBkNVaZmXyWj4Anz1C//Z165V+sAofpjVb0fL0Eke
 ZGfwUTIP8BAX+JrU4oUNer5uti4R11k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-382-K0EYoQyJMAW4P6O48qrAYw-1; Wed, 05 Feb 2020 12:33:31 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id ECB8E8018A3;
 Wed,  5 Feb 2020 17:33:29 +0000 (UTC)
Received: from work-vm (unknown [10.36.118.56])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A20DC9D52;
 Wed,  5 Feb 2020 17:33:28 +0000 (UTC)
Date: Wed, 5 Feb 2020 17:33:26 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: jasper.lowell@bt.com
Subject: Re: Emulating Solaris 10 on SPARC64 sun4u
Message-ID: <20200205173326.GA3256@work-vm>
References: <CWXP123MB2262B6F3159B7AA7AB010F4183020@CWXP123MB2262.GBRP123.PROD.OUTLOOK.COM>
MIME-Version: 1.0
In-Reply-To: <CWXP123MB2262B6F3159B7AA7AB010F4183020@CWXP123MB2262.GBRP123.PROD.OUTLOOK.COM>
User-Agent: Mutt/1.13.3 (2020-01-12)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: K0EYoQyJMAW4P6O48qrAYw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: mark.cave-ayland@ilande.co.uk, qemu-devel@nongnu.org, atar4qemu@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* jasper.lowell@bt.com (jasper.lowell@bt.com) wrote:
> I'm currently working towards emulating Solaris 10 on sun4u.
>=20
> The Solaris 10 ISO image I am attempting to boot is the one from the Orac=
le
> download page at https://www.oracle.com/solaris/solaris10/downloads/solar=
is10-get-jsp-downloads.html.
> Image: sol-10-u11-ga-sparc-dvd.iso
> MD5:   53e8b066f7f250ce2fd2cef063f8072b
>=20
> I am using QEMU commit 7bd9d0a9e26c7a3c67c0f174f0009ba19969b158.
>=20
> The command I am using to run QEMU is:
> ./qemu/sparc64-softmmu/qemu-system-sparc64 -bios ./openbios/obj-sparc64/o=
penbios-builtin.elf -cdrom ./iso/solaris/sol-10-u11-ga-sparc-dvd.iso -boot =
d -nographic -m 3G
>=20
> ```
> CPUs: 1 x SUNW,UltraSPARC-IIi
> UUID: 00000000-0000-0000-0000-000000000000
> Welcome to OpenBIOS v1.1 built on Feb 5 2020 19:15
>   Type 'help' for detailed information
> Trying cdrom:f...
> Not a bootable ELF image
> Not a bootable a.out image
>=20
> Loading FCode image...
> Loaded 7420 bytes
> entry point is 0x4000
> Evaluating FCode...
> Evaluating FCode...
> Ignoring failed claim for va 1000000 memsz af6d6!
> Ignoring failed claim for va 1402000 memsz 4dcc8!
> Ignoring failed claim for va 1800000 memsz 510c8!
> SunOS Release 5.10 Version Generic_147147-26 64-bit
> Copyright (c) 1983, 2013, Oracle and/or its affiliates. All rights reserv=
ed.
> could not find debugger-vocabulary-hook>threads:interpret: exception -13 =
caught
> interpret \ Copyright (c) 1995-1999 by Sun Microsystems, Inc.
> \ All rights reserved.
> \
> \ ident "@(#)data64.fth  1.3     00/07/17 SMI"
>=20
> hex
>=20
> only forth also definitions
> vocabulary kdbg-words
> also kdbg-words definitions
>=20
> defer p@
> defer p!
> ['] x@ is p@
> ['] x! is p!
>=20
> 8 constant ptrsize
>=20
> d# 32 constant nbitsminor
> h# ffffffff constant maxmin
> \
> \ Copyright 2008 Sun Microsystems, Inc.  All rights reserved.
> \ Use is subject to license terms.
> \
>=20
> \ #pragma ident  "@(#)kdbg.fth    1.20    08/06/06 SMI"
>=20
> h# 7ff constant v9bias
> h# unix-tte:interpret: exception -13 caught
> interpret ' unix-tte is va>tte-data failed with error ffffffffffffffed
> WARNING: consconfig: cannot find driver for screen device /pci@1fe,0/pci@=
1,1/QEMU,VGA@2
> Configuring devices.
> WARNING: Interrupt not seen after set_features

GIven that your problem below is looking like an interrupt related
problem, have you figured out where that's coming from?

Dave

--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


