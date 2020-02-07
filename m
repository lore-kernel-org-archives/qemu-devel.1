Return-Path: <SRS0=2niX=33=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 525F6C04EB5
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 13:57:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1CDB420720
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 13:57:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UtGkJAdD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1CDB420720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56896 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j048R-0000BC-B1
	for qemu-devel@archiver.kernel.org; Fri, 07 Feb 2020 08:57:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43261)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1j047f-00089L-J4
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 08:56:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1j047e-0003cL-H8
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 08:56:43 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:60212
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1j047e-0003al-A7
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 08:56:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581083801;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FN5QkO7j0Jo4rdFnksNkoAUOBfd3auzBGSO4M15PUdQ=;
 b=UtGkJAdDLQCHLlSY1nesI0bpv7duF1O3TNTyBWVJLmeIJrv+y4bc5Q010prGKSNFqUSF2o
 ivUaLTDhZKPErNMsGQkp64GIOHvE1RUeC2RTnoHk0aMvgXIO2juaxPznhrwQ64xdDo11T1
 VCLqFRxyXPLqO4dqo9J373JRGnNhBpc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-234-QuqSC7OkP1iJw_dwIddjsA-1; Fri, 07 Feb 2020 08:56:39 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 373A219251B0;
 Fri,  7 Feb 2020 13:56:38 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-136.ams2.redhat.com
 [10.36.116.136])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2C85B790FE;
 Fri,  7 Feb 2020 13:56:33 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id B315F11386A7; Fri,  7 Feb 2020 14:56:31 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH v3 1/7] ui: add show-cursor option
References: <20200207101753.25812-1-kraxel@redhat.com>
 <20200207101753.25812-2-kraxel@redhat.com>
Date: Fri, 07 Feb 2020 14:56:31 +0100
In-Reply-To: <20200207101753.25812-2-kraxel@redhat.com> (Gerd Hoffmann's
 message of "Fri, 7 Feb 2020 11:17:47 +0100")
Message-ID: <87ftfmqz5c.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: QuqSC7OkP1iJw_dwIddjsA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
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
Cc: Peter Maydell <peter.maydell@linaro.org>, jtomko@redhat.com,
 libvir-list@redhat.com, qemu-devel@nongnu.org, jpewhacker@gmail.com,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Gerd Hoffmann <kraxel@redhat.com> writes:

> When enabled, this forces showing the mouse cursor,
> i.e. do not hide the pointer on mouse grabs.
> Defaults to off.
>
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  qapi/ui.json | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/qapi/ui.json b/qapi/ui.json
> index e04525d8b44b..b9df7fe7b5cb 100644
> --- a/qapi/ui.json
> +++ b/qapi/ui.json
> @@ -1144,6 +1144,8 @@
>  # @type:          Which DisplayType qemu should use.
>  # @full-screen:   Start user interface in fullscreen mode (default: off)=
.
>  # @window-close:  Allow to quit qemu with window close button (default: =
on).
> +# @show-cursor:   Force showing the mouse cursor (default: off).
> +#                 Since: 5.0

By convention, we use

   # Since: 5.0

for top-level definitions, and

   #                 (since 5.0)

for members and such.  See docs/devel/qapi-code-gen.txt section
"Definition documentation".

>  # @gl:            Enable OpenGL support (default: off).
>  #
>  # Since: 2.12
> @@ -1153,6 +1155,7 @@
>    'base'    : { 'type'           : 'DisplayType',
>                  '*full-screen'   : 'bool',
>                  '*window-close'  : 'bool',
> +                '*show-cursor'   : 'bool',
>                  '*gl'            : 'DisplayGLMode' },
>    'discriminator' : 'type',
>    'data'    : { 'gtk'            : 'DisplayGTK',

With the doc comment tidied up:
Reviewed-by: Markus Armbruster <armbru@redhat.com>


