Return-Path: <SRS0=i8Yf=47=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9192EC10DCE
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Mar 2020 00:24:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F7812074C
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Mar 2020 00:24:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EJW6XenR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F7812074C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39356 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCubq-0002sh-HE
	for qemu-devel@archiver.kernel.org; Fri, 13 Mar 2020 20:24:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36531)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlureau@redhat.com>) id 1jCub3-0002Nt-IQ
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 20:24:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlureau@redhat.com>) id 1jCub2-0006Ls-5a
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 20:24:09 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:21913
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1jCub1-0006FX-SF
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 20:24:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584145445;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nxWnAEPLEiUzXFHAqL0Ai9O4rz6YI2uPE+84nS05Td4=;
 b=EJW6XenRgL1BCOoeTNPEbM3kX2zB3h5EOID9Yh2U826usCv00XiUz8S5RhmE28GApBXu/i
 8jBzC/jPWzY+4+Cjh8uwdB+0UV2tCHclPQK4LfuhFDUTxpjnPZbem7gqHubWoXAdjuanD6
 jj1Pes4L1XSASn8QUwRWx/uv7LxbsWc=
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-307-Y77bQ9JHOf60e9RQlqmozQ-1; Fri, 13 Mar 2020 20:24:04 -0400
X-MC-Unique: Y77bQ9JHOf60e9RQlqmozQ-1
Received: by mail-ot1-f70.google.com with SMTP id s8so6989747otd.13
 for <qemu-devel@nongnu.org>; Fri, 13 Mar 2020 17:24:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=nxWnAEPLEiUzXFHAqL0Ai9O4rz6YI2uPE+84nS05Td4=;
 b=RyrC7JVxcF1EzD3ftL3QYj1hoVTRoI3JFJJ8N1o6qRhE2ezSxKEP5FJ6akqK021mgS
 3qu0w1BC2wxZiGhtIiXTmPZIoq8KgHsWZkrp0hOrwYpnoewmisfUDa1nEGFmw6ymGbk4
 qHUHsV3MMYmHCdfSRXka6fz9D2snDK8ZzwkoEtMNrd/pJPqcFA4S+XFR0pUCDPlRbGC+
 c8JBjjcPf1vJd9VK87qEaWS0qUabS45DZGI+OkHycf8ghSL6nJs0gnaYp+VRx1iZ5Sgf
 fW0je5f3SzYdwZVtaxxYHDfkfHhfllJQ40Am20F7J7ULB6IdZlLFpTWhv28GGUjolSU2
 aAbA==
X-Gm-Message-State: ANhLgQ1AAdhhKP/fTyMEQsLqGPxGj1O4j9OZFtVVGPqLNQrUxMv5v2ul
 nIPJKvbWj3W7krsw2WfM1M2ML/GPpId1b55drSp4HFWsdp91MJCqlB/zVTgb+3Mn8GJZ/LDknKB
 Vr4CQVECDEGwjEK80wsq/Ue5Egq2Aexs=
X-Received: by 2002:a9d:748c:: with SMTP id t12mr12843485otk.38.1584145443478; 
 Fri, 13 Mar 2020 17:24:03 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vuJjBjIkeV/Nd7EC6KHlSGeZesjD0w0mw99Z8mI/DeGI4PEK4H9ylBSAD2SXIMrrwr9AcTX1plrLwusR90A7oc=
X-Received: by 2002:a9d:748c:: with SMTP id t12mr12843468otk.38.1584145443154; 
 Fri, 13 Mar 2020 17:24:03 -0700 (PDT)
MIME-Version: 1.0
References: <20200313184153.11275-1-philmd@redhat.com>
 <20200313184153.11275-3-philmd@redhat.com>
In-Reply-To: <20200313184153.11275-3-philmd@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Sat, 14 Mar 2020 01:23:52 +0100
Message-ID: <CAMxuvaxRikWH9Y1cujGR02z=5Kmynnax5fYLqqBuQP4_0WxdSw@mail.gmail.com>
Subject: Re: [PATCH 2/9] qapi/misc: Move add_client command with chardev code
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-block <qemu-block@nongnu.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel <qemu-devel@nongnu.org>,
 Markus Armbruster <armbru@redhat.com>, Ben Warren <ben@skyportsystems.com>,
 Peter Lieven <pl@kamp.de>, Laurent Vivier <laurent@vivier.eu>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Ronnie Sahlberg <ronniesahlberg@gmail.com>,
 Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Max Reitz <mreitz@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi

On Fri, Mar 13, 2020 at 7:42 PM Philippe Mathieu-Daud=C3=A9
<philmd@redhat.com> wrote:
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Without looking at the rest of the series, I fail to see the
improvement, quite the opposite. A bit of context?

> ---
>  qapi/char.json     | 32 ++++++++++++++++++++++++++++++++
>  qapi/misc.json     | 32 --------------------------------
>  monitor/qmp-cmds.c |  1 +
>  3 files changed, 33 insertions(+), 32 deletions(-)
>
> diff --git a/qapi/char.json b/qapi/char.json
> index 6907b2bfdb..8b7baf11eb 100644
> --- a/qapi/char.json
> +++ b/qapi/char.json
> @@ -572,3 +572,35 @@
>  { 'event': 'VSERPORT_CHANGE',
>    'data': { 'id': 'str',
>              'open': 'bool' } }
> +
> +##
> +# @add_client:
> +#
> +# Allow client connections for VNC, Spice and socket based
> +# character devices to be passed in to QEMU via SCM_RIGHTS.
> +#
> +# @protocol: protocol name. Valid names are "vnc", "spice" or the
> +#            name of a character device (eg. from -chardev id=3DXXXX)
> +#
> +# @fdname: file descriptor name previously passed via 'getfd' command
> +#
> +# @skipauth: whether to skip authentication. Only applies
> +#            to "vnc" and "spice" protocols
> +#
> +# @tls: whether to perform TLS. Only applies to the "spice"
> +#       protocol
> +#
> +# Returns: nothing on success.
> +#
> +# Since: 0.14.0
> +#
> +# Example:
> +#
> +# -> { "execute": "add_client", "arguments": { "protocol": "vnc",
> +#                                              "fdname": "myclient" } }
> +# <- { "return": {} }
> +#
> +##
> +{ 'command': 'add_client',
> +  'data': { 'protocol': 'str', 'fdname': 'str', '*skipauth': 'bool',
> +            '*tls': 'bool' } }
> diff --git a/qapi/misc.json b/qapi/misc.json
> index c18fe681fb..e84e6823e9 100644
> --- a/qapi/misc.json
> +++ b/qapi/misc.json
> @@ -39,38 +39,6 @@
>  { 'enum': 'LostTickPolicy',
>    'data': ['discard', 'delay', 'slew' ] }
>
> -##
> -# @add_client:
> -#
> -# Allow client connections for VNC, Spice and socket based
> -# character devices to be passed in to QEMU via SCM_RIGHTS.
> -#
> -# @protocol: protocol name. Valid names are "vnc", "spice" or the
> -#            name of a character device (eg. from -chardev id=3DXXXX)
> -#
> -# @fdname: file descriptor name previously passed via 'getfd' command
> -#
> -# @skipauth: whether to skip authentication. Only applies
> -#            to "vnc" and "spice" protocols
> -#
> -# @tls: whether to perform TLS. Only applies to the "spice"
> -#       protocol
> -#
> -# Returns: nothing on success.
> -#
> -# Since: 0.14.0
> -#
> -# Example:
> -#
> -# -> { "execute": "add_client", "arguments": { "protocol": "vnc",
> -#                                              "fdname": "myclient" } }
> -# <- { "return": {} }
> -#
> -##
> -{ 'command': 'add_client',
> -  'data': { 'protocol': 'str', 'fdname': 'str', '*skipauth': 'bool',
> -            '*tls': 'bool' } }
> -
>  ##
>  # @NameInfo:
>  #
> diff --git a/monitor/qmp-cmds.c b/monitor/qmp-cmds.c
> index 864cbfa32e..67d95b4af7 100644
> --- a/monitor/qmp-cmds.c
> +++ b/monitor/qmp-cmds.c
> @@ -31,6 +31,7 @@
>  #include "sysemu/block-backend.h"
>  #include "qapi/error.h"
>  #include "qapi/qapi-commands-block.h"
> +#include "qapi/qapi-commands-char.h"
>  #include "qapi/qapi-commands-control.h"
>  #include "qapi/qapi-commands-machine.h"
>  #include "qapi/qapi-commands-misc.h"
> --
> 2.21.1
>


