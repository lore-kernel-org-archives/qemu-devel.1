Return-Path: <SRS0=pQgJ=ZH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 690B0C43215
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2019 15:35:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3850220715
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2019 15:35:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N8d+tlFG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3850220715
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40884 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iVddH-0008JP-9E
	for qemu-devel@archiver.kernel.org; Fri, 15 Nov 2019 10:35:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44310)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1iVdcP-0007bJ-WA
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 10:34:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1iVdcO-0002Vo-VZ
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 10:34:41 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:30143
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1iVdcO-0002VZ-SF
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 10:34:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573832080;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TxQN2ykuPzWY1WWuzKCGPYzXoWDwWAklpvKcneRm7NU=;
 b=N8d+tlFG4M8WveLYY2WC2GSu47lqM0h8VLmQtUZ+OW7+qX+u3hrEnzGirqDaIDBXgyde3z
 Umu139qLRjdvlAn/8yFgD6OzpNG5x267GSCl7NjZZnWWIpn3PQgj0wna0kolYtqd4AQPJV
 2Vph/gF/0tTKxZXiIB0yg4cSpF/g73w=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-299-Y6iyDEW4Njexsgo0JJKiPQ-1; Fri, 15 Nov 2019 10:34:38 -0500
Received: by mail-qv1-f69.google.com with SMTP id w2so6812468qvz.10
 for <qemu-devel@nongnu.org>; Fri, 15 Nov 2019 07:34:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=jXuZvRCxs4H7wEEmJhLwwDotj+6kIvzITkOyqqDQOWU=;
 b=A2IOADv+4BehkwXZwl48ZmUs2JYNQMf/tnDwzE+/FBohjXBwkGOdC5GNu+CZlS/iXA
 jcZN/bmx6jSMNw7YCE4T3zvZVVgVerPU/SazmRbcKkt4ZIYY895jh+F0lCMT7q+mUt2s
 JGCOyASpaxMfvP0aYBJwaAUwmRt833v+bttnmvunskdcAq5j1x7bxBo4cZdldH5TzurX
 1oT4mlQkVpSpoLUUPqDE+SIg+rJrBro3MyuC9PoVUZXL08ftTrRIAYtQZZUs7BjCsluV
 Zeq5e/mO9YY0D+JGclQHH+gQnuD9X9ZkA9rgvOJybKDJVXRj+vrzdDoXx0oFRxQqr/hn
 p7mA==
X-Gm-Message-State: APjAAAX7M6GLM5bqI2lPhrAhCgu58ESR29BYDd2jkh2iI/uRztQEXNhd
 5CDshmUSH1H89a5WttYgl9JvmsxRq3QmP5C0e37cVsBaNhw4aRviAdmFkqjyoSMYHJdyVMyp/39
 abunJRfnOqb0I17U=
X-Received: by 2002:a05:620a:110f:: with SMTP id
 o15mr12703169qkk.127.1573832077248; 
 Fri, 15 Nov 2019 07:34:37 -0800 (PST)
X-Google-Smtp-Source: APXvYqxo7BpSfa8lh2X5mXpDSvekynyzwR7AxSyihG0mFZD6PZqmRuL0mFs/cw2wK97xTB0XiYREOg==
X-Received: by 2002:a05:620a:110f:: with SMTP id
 o15mr12703048qkk.127.1573832075823; 
 Fri, 15 Nov 2019 07:34:35 -0800 (PST)
Received: from redhat.com (bzq-79-176-6-42.red.bezeqint.net. [79.176.6.42])
 by smtp.gmail.com with ESMTPSA id h24sm3072394qtn.36.2019.11.15.07.34.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Nov 2019 07:34:34 -0800 (PST)
Date: Fri, 15 Nov 2019 10:34:29 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH for-4.2] hw/i386: Fix compiler warning when
 CONFIG_IDE_ISA is disabled
Message-ID: <20191115103335-mutt-send-email-mst@kernel.org>
References: <20191115145049.26868-1-thuth@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20191115145049.26868-1-thuth@redhat.com>
X-MC-Unique: Y6iyDEW4Njexsgo0JJKiPQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, qemu-trivial@nongnu.org,
 qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Nov 15, 2019 at 03:50:49PM +0100, Thomas Huth wrote:
> When CONFIG_IDE_ISA is disabled, compilation currently fails:
>=20
>  hw/i386/pc_piix.c: In function =E2=80=98pc_init1=E2=80=99:
>  hw/i386/pc_piix.c:81:9: error: unused variable =E2=80=98i=E2=80=99 [-Wer=
ror=3Dunused-variable]
>=20
> Move the variable declaration to the right code block to avoid
> this problem.
>=20
> Fixes: 4501d317b50e ("hw/i386/pc: Extract pc_i8259_create()")
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Reviewed-by: Michael S. Tsirkin <mst@redhat.com>

> ---
>  hw/i386/pc_piix.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>=20
> diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
> index 2aefa3b8df..d187db761c 100644
> --- a/hw/i386/pc_piix.c
> +++ b/hw/i386/pc_piix.c
> @@ -78,7 +78,6 @@ static void pc_init1(MachineState *machine,
>      X86MachineState *x86ms =3D X86_MACHINE(machine);
>      MemoryRegion *system_memory =3D get_system_memory();
>      MemoryRegion *system_io =3D get_system_io();
> -    int i;
>      PCIBus *pci_bus;
>      ISABus *isa_bus;
>      PCII440FXState *i440fx_state;
> @@ -253,7 +252,7 @@ static void pc_init1(MachineState *machine,
>      }
>  #ifdef CONFIG_IDE_ISA
>  else {
> -        for(i =3D 0; i < MAX_IDE_BUS; i++) {
> +        for (int i =3D 0; i < MAX_IDE_BUS; i++) {
>              ISADevice *dev;
>              char busname[] =3D "ide.0";
>              dev =3D isa_ide_init(isa_bus, ide_iobase[i], ide_iobase2[i],
> --=20
> 2.23.0


