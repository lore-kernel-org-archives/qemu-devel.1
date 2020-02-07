Return-Path: <SRS0=2niX=33=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 611AEC04EB5
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 14:12:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2CEA320838
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 14:12:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YyRol/tn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CEA320838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57196 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j04Mo-0004GX-AW
	for qemu-devel@archiver.kernel.org; Fri, 07 Feb 2020 09:12:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46366)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1j04Lx-0003FY-1w
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 09:11:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1j04Lv-0003Ll-Vf
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 09:11:28 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:26235
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1j04Lv-0003KG-RK
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 09:11:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581084687;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=o81+JWmLU/tFz7R4cIBaX3fO8pUbp9JTZdiL9GKDwS8=;
 b=YyRol/tngp4sph/BUE0LTmtt5PjcOPzWccZgigURuc6O7a4ksKapiChUuAuxabDLtNfhUn
 x3VqkQSJtKiTrM07jW4IjIsaC0nQm5zrtsT7obHiUjYsVxzaV2H0ZYBZr11xzkkDawwsZu
 eGF+b1sWLEmq6Vk2nA0sPvoRWZi0c+Y=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-106-04Fe0YQrMj6WZMiWjRBE8A-1; Fri, 07 Feb 2020 09:11:25 -0500
Received: by mail-qk1-f200.google.com with SMTP id b23so1467200qkg.17
 for <qemu-devel@nongnu.org>; Fri, 07 Feb 2020 06:11:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=r7HLC+pRyHdtI1HUnYeCh7nUdsYVlBwhAa0vgrpGZwE=;
 b=Ovn+RFuDZeSFCd3uLOnVva7uoLmY6d3rd/0yQC5JUPKBrN/jGBtW4hjp4NcI5zHGMS
 Kb0gWrkA2JijWdLjoYEXc6oCokek0TS4OBn1iqW8fAr7EgiEaXfyO3GFMwppRhnDSki7
 dz/+btzAKHFsASwOLkMJmvw37QR13iD8OY3Cc4Edubjxcn0oSeN+/5tQa96cDmn4Axi/
 r8rD+V4qhMmo1BG7qW77zntL+844KgH3u7yeJbXCssVhoaFriZm2/y7AdK43agQKCT1O
 AWnh6nzBILF109Q4JNu7EOrNaZ1YEFTF+aZF+gK9mG3itwwxAtimmJDoSj8I2cHBD28a
 hyqA==
X-Gm-Message-State: APjAAAWhGwukBqE9loq6MBoruMTjrKlkwZZ85kqF6SeNNfYqhhu9JCst
 rDYJv07l9CU9BUHfwIIq/xn5l8c7m9uesCXCeEnO9kmWSCYcnnDQrvReMD+lE0ET3T8d+t23QzU
 yOZpNIx1yB6cl+tg=
X-Received: by 2002:ae9:f50c:: with SMTP id o12mr7535352qkg.42.1581084685173; 
 Fri, 07 Feb 2020 06:11:25 -0800 (PST)
X-Google-Smtp-Source: APXvYqybFpSe7hEw7HPlsSHWTeTred/Bqbnh34A8vvhVkNG91NbRJEbUtCucDkm6pF0Z6PlJOt/FQw==
X-Received: by 2002:ae9:f50c:: with SMTP id o12mr7535300qkg.42.1581084684907; 
 Fri, 07 Feb 2020 06:11:24 -0800 (PST)
Received: from redhat.com (bzq-79-176-41-183.red.bezeqint.net. [79.176.41.183])
 by smtp.gmail.com with ESMTPSA id d17sm1358069qkc.9.2020.02.07.06.11.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Feb 2020 06:11:24 -0800 (PST)
Date: Fri, 7 Feb 2020 09:11:15 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Subject: Re: [PATCH v3 3/3] vl: Abort if multiple machines are registered as
 default
Message-ID: <20200207090427-mutt-send-email-mst@kernel.org>
References: <20200207130453.16666-1-philmd@redhat.com>
 <20200207130453.16666-4-philmd@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200207130453.16666-4-philmd@redhat.com>
X-MC-Unique: 04Fe0YQrMj6WZMiWjRBE8A-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
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
Cc: Chris Wulff <crwulff@gmail.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 David Hildenbrand <david@redhat.com>, Anthony Green <green@moxielogic.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org,
 Alistair Francis <Alistair.Francis@wdc.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Guan Xuetao <gxt@mprc.pku.edu.cn>, Marek Vasut <marex@denx.de>,
 Jia Liu <proljc@gmail.com>, qemu-trivial@nongnu.org,
 Helge Deller <deller@gmx.de>, Magnus Damm <magnus.damm@gmail.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Richard Henderson <rth@twiddle.net>, Artyom Tarasenko <atar4qemu@gmail.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-s390x@nongnu.org,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@gmail.com>,
 Stafford Horne <shorne@gmail.com>, David Gibson <david@gibson.dropbear.id.au>,
 qemu-riscv@nongnu.org, Thomas Huth <huth@tuxfamily.org>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Cornelia Huck <cohuck@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 Michael Walle <michael@walle.cc>, qemu-ppc@nongnu.org,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Feb 07, 2020 at 02:04:53PM +0100, Philippe Mathieu-Daud=E9 wrote:
> It would be confusing to have multiple default machines.
> Abort if this ever occurs.
>=20
> Signed-off-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>
> ---
> v2: Use assert() instead of human friendly message (Marc-Andr=E9)
>=20
> Cc: Marc-Andr=E9 Lureau <marcandre.lureau@gmail.com>
> Cc: Laurent Vivier <laurent@vivier.eu>

Is it really worth adding counting logic just so we can assert?
There are a bunch of other places that deal with
default, like qmp query machines and find_default_machine.

> ---
>  vl.c | 4 ++++
>  1 file changed, 4 insertions(+)
>=20
> diff --git a/vl.c b/vl.c
> index 7dcb0879c4..b3e0f7af25 100644
> --- a/vl.c
> +++ b/vl.c
> @@ -2354,6 +2354,8 @@ static MachineClass *machine_parse(const char *name=
, GSList *machines)
>      GSList *el;
> =20
>      if (is_help_option(name)) {
> +        int default_count =3D 0;
> +
>          printf("Supported machines are:\n");
>          machines =3D g_slist_sort(machines, machine_class_cmp);
>          for (el =3D machines; el; el =3D el->next) {
> @@ -2364,7 +2366,9 @@ static MachineClass *machine_parse(const char *name=
, GSList *machines)
>              printf("%-20s %s%s%s\n", mc->name, mc->desc,
>                     mc->is_default ? " (default)" : "",
>                     mc->deprecation_reason ? " (deprecated)" : "");
> +            default_count +=3D !!mc->is_default;
>          }
> +        assert(default_count <=3D 1);
>          exit(0);
>      }
> =20
> --=20
> 2.21.1


