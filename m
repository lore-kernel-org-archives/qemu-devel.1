Return-Path: <SRS0=N3Ri=EI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F492C00A89
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2020 06:33:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D63C020874
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2020 06:33:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e5cyCnws"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D63C020874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44296 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZTPe-0004Yp-Me
	for qemu-devel@archiver.kernel.org; Mon, 02 Nov 2020 01:33:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58324)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kZTOu-00042s-QP
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 01:33:08 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:60495)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kZTOr-0001kf-Kk
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 01:33:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604298783;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FvO7SWeRvtMsAen7yl3skEAdrRW+yndcHhOHx/L/lzc=;
 b=e5cyCnwsA+Atr3qEDMV4R+f+tTpOx14chTAmiGXiD/I0fEh0m8OfiZSHJ/Pp/F8IGuqWVX
 2syDFP1PcOka8o7Ksoh3hj8e3vFLF9zFrCa2j9JVdwg4ICuw+r7tOj8DcbP9pvfXEvj1cd
 GLlsB3TcleW3yyyvm61jEtVRZRDTks4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-263-4jM5X1GpNGGVDubPe02A2g-1; Mon, 02 Nov 2020 01:33:01 -0500
X-MC-Unique: 4jM5X1GpNGGVDubPe02A2g-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 641F0107ACF8;
 Mon,  2 Nov 2020 06:33:00 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-103.ams2.redhat.com
 [10.36.112.103])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5029860C13;
 Mon,  2 Nov 2020 06:32:57 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id ADC0F1132BD6; Mon,  2 Nov 2020 07:32:55 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Lukas Straub <lukasstraub2@web.de>
Subject: Re: [PATCH v10 1/8] Introduce yank feature
References: <cover.1604075469.git.lukasstraub2@web.de>
 <20201030174108.1c88195b@luklap>
Date: Mon, 02 Nov 2020 07:32:55 +0100
In-Reply-To: <20201030174108.1c88195b@luklap> (Lukas Straub's message of "Fri, 
 30 Oct 2020 17:41:08 +0100")
Message-ID: <87y2jkp8tk.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Received-SPF: pass client-ip=216.205.24.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/02 01:33:03
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-block <qemu-block@nongnu.org>, Juan Quintela <quintela@redhat.com>,
 "Dr. David
 Alan Gilbert" <dgilbert@redhat.com>, qemu-devel <qemu-devel@nongnu.org>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Lukas Straub <lukasstraub2@web.de> writes:

> The yank feature allows to recover from hanging qemu by "yanking"
> at various parts. Other qemu systems can register themselves and
> multiple yank functions. Then all yank functions for selected
> instances can be called by the 'yank' out-of-band qmp command.
> Available instances can be queried by a 'query-yank' oob command.
>
> Signed-off-by: Lukas Straub <lukasstraub2@web.de>
> Acked-by: Stefan Hajnoczi <stefanha@redhat.com>
[...]
>  qapi_storage_daemon_modules = [
> diff --git a/qapi/qapi-schema.json b/qapi/qapi-schema.json
> index 0b444b76d2..79c1705ed7 100644
> --- a/qapi/qapi-schema.json
> +++ b/qapi/qapi-schema.json
> @@ -91,3 +91,4 @@
>  { 'include': 'audio.json' }
>  { 'include': 'acpi.json' }
>  { 'include': 'pci.json' }
> +{ 'include': 'yank.json' }

This adds the documentation at the very end of the reference manual.  Is
this where you want it to go?  Check generated
docs/interop/qemu-qmp-ref.html.

> diff --git a/qapi/yank.json b/qapi/yank.json
> new file mode 100644
> index 0000000000..1964a2202e
> --- /dev/null
> +++ b/qapi/yank.json
> @@ -0,0 +1,115 @@
> +# -*- Mode: Python -*-
> +# vim: filetype=python
> +#
> +

Please add a suitable heading here.  Headings look like this:

   ##
   # Text of heading goes here
   ##

Without it, the yank stuff gets squashed into the previous section
(happens to be PCI).

If you want to add an introduction or overview, it goes right below the
heading.  I'm not asking you to do that, I'm only telling you what's
possible.

[...]

Solid work, pleasant to review, thanks!

Reviewed-by: Markus Armbruster <armbru@redhat.com>


