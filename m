Return-Path: <SRS0=ZO09=24=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6222C33C8C
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 12:54:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F2152075A
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 12:54:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RzW1aSJX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F2152075A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48118 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iooNP-0000f0-8A
	for qemu-devel@archiver.kernel.org; Tue, 07 Jan 2020 07:54:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55599)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1ionuL-0005dI-Qe
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 07:24:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1ionuJ-0008BK-NZ
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 07:24:25 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:26483
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1ionuJ-0008B9-KR
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 07:24:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578399863;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=Sl8WGQpZL1pmSlF8449Htl3rLKUh4HtY/Fk2ULKmZo0=;
 b=RzW1aSJXIKnwWX6k8F6TQuRPzrhoVRytc+DVhfhuQrrPnW+6nh1K9bgQsxdJFQU4YMG2Aw
 RamPU7ne3JN3ucr4xUNeXoFV5ORWsjQcCh+n+1SYcYVVoSssh9mGhRnMH6rzUk0ovUEEIT
 M6yjkYNag8Ar9lJcNikoZgqtQLIeSF0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-338-fYDtDc4dMkiE1VR296XhdA-1; Tue, 07 Jan 2020 07:24:22 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2AF3218A8C80;
 Tue,  7 Jan 2020 12:24:20 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-116-116.ams2.redhat.com [10.36.116.116])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id F106E1084199;
 Tue,  7 Jan 2020 12:24:07 +0000 (UTC)
Subject: Re: [PATCH 01/14] hw/usb/redirect: Do not link 'usb-redir' device
 when USB not enabled
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20191231183216.6781-1-philmd@redhat.com>
 <20191231183216.6781-2-philmd@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <160b203b-0af3-c912-7eff-847730f3911d@redhat.com>
Date: Tue, 7 Jan 2020 13:24:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191231183216.6781-2-philmd@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: fYDtDc4dMkiE1VR296XhdA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
Cc: Fam Zheng <fam@euphon.net>, Eduardo Habkost <ehabkost@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Aurelien Jarno <aurelien@aurel32.net>, qemu-ppc@nongnu.org,
 Gerd Hoffmann <kraxel@redhat.com>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 31/12/2019 19.32, Philippe Mathieu-Daud=C3=A9 wrote:
> The 'usb-redir' device requires the USB core code to work. Do not
> link it when there is no USB support. This fixes:
>=20
>   $ qemu-system-tricore -M tricore_testboard -device usb-redir
>   qemu-system-tricore: -device usb-redir: No 'usb-bus' bus found for devi=
ce 'usb-redir'
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>  hw/usb/Makefile.objs | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/hw/usb/Makefile.objs b/hw/usb/Makefile.objs
> index 0ab20f9d73..0052d49ce1 100644
> --- a/hw/usb/Makefile.objs
> +++ b/hw/usb/Makefile.objs
> @@ -39,9 +39,11 @@ common-obj-$(CONFIG_USB_STORAGE_MTP)  +=3D dev-mtp.o
>  endif
> =20
>  # usb redirection
> +ifeq ($(CONFIG_USB),y)
>  common-obj-$(CONFIG_USB_REDIR) +=3D redirect.o quirks.o
>  redirect.o-cflags =3D $(USB_REDIR_CFLAGS)
>  redirect.o-libs =3D $(USB_REDIR_LIBS)
> +endif
> =20
>  # usb pass-through
>  ifeq ($(CONFIG_USB_LIBUSB)$(CONFIG_USB),yy)
>=20

Reviewed-by: Thomas Huth <thuth@redhat.com>


