Return-Path: <SRS0=tSBD=YP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0F6CCA9EA0
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 06:19:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B685F20B7C
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 06:19:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="etJfERM1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B685F20B7C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50572 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMnVx-00022S-Tv
	for qemu-devel@archiver.kernel.org; Tue, 22 Oct 2019 02:19:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60749)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1iMnUo-0001Rt-Cj
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 02:18:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1iMnUn-0006fo-9I
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 02:18:18 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:36238
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1iMnUn-0006fi-63
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 02:18:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1571725096;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Y9t4ZYoitCThfCu83qRbjYr4evCXjg2uqwFMRmx+seY=;
 b=etJfERM1H4ZfaUQTuzPxTy6vtHIx8+/XAkA0V+shoNtVKHlmMZMUgo+IYg3amMfjL2k3Am
 dGB0ZDQ0hRu07iOpNEP0/WVDrQmdXU2MZSKeoYxvyhDNMZXHkJx8jYofYePhPreaQGUcnx
 Jeq1HiwkiITSC//obAzt1rxbWNB9mFI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-336-vYKR9QsGPia8jk2di8H2IA-1; Tue, 22 Oct 2019 02:18:13 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B3848107AD31;
 Tue, 22 Oct 2019 06:18:12 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.36.118.123])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id ABF921001E75;
 Tue, 22 Oct 2019 06:18:09 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 110461138619; Tue, 22 Oct 2019 08:18:08 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Han Han <hhan@redhat.com>
Subject: Re: [PATCH] qemu-options.hx: Update for reboot-timeout parameter
References: <20191015151451.727323-1-hhan@redhat.com>
Date: Tue, 22 Oct 2019 08:18:08 +0200
In-Reply-To: <20191015151451.727323-1-hhan@redhat.com> (Han Han's message of
 "Tue, 15 Oct 2019 23:14:51 +0800")
Message-ID: <87d0epqp5r.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: vYKR9QsGPia8jk2di8H2IA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
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
Cc: qemu-trivial@nongnu.org, philmd@redhat.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Han Han <hhan@redhat.com> writes:

> Since ee5d0f89d, -1 is not valid for the value of reboot-timeout. Update
> that in qemu-options doc.
>
> Signed-off-by: Han Han <hhan@redhat.com>
> ---
>  qemu-options.hx | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/qemu-options.hx b/qemu-options.hx
> index 793d70ff..6b92a916 100644
> --- a/qemu-options.hx
> +++ b/qemu-options.hx
> @@ -327,8 +327,8 @@ format(true color). The resolution should be supporte=
d by the SVGA mode, so
   A splash picture could be passed to bios, enabling user to show it as lo=
go,
   when option splash=3D@var{sp_name} is given and menu=3Don, If firmware/B=
IOS
   supports them. Currently Seabios for X86 system support it.
   limitation: The splash file could be a jpeg file or a BMP file in 24 BPP
   format(true color). The resolution should be supported by the SVGA mode,=
 so
>  the recommended is 320x240, 640x480, 800x640.
> =20
>  A timeout could be passed to bios, guest will pause for @var{rb_timeout}=
 ms
> -when boot failed, then reboot. If @var{rb_timeout} is '-1', guest will n=
ot
> -reboot, qemu passes '-1' to bios by default. Currently Seabios for X86
> +when boot failed, then reboot. If @option{reboot-timeout} is not set,
> +guest will not reboot by default. Currently Seabios for X86
>  system support it.
> =20
>  Do strict boot via @option{strict=3Don} as far as firmware/BIOS

Preexisting: "could be passed" sounds awkward.  Same in the previous
paragraph.  Not this patch's problem, so:

Reviewed-by: Markus Armbruster <armbru@redhat.com>


