Return-Path: <SRS0=xFA2=5Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16222C2D0F0
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 14:17:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D4EF12071A
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 14:17:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bikb/OU8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4EF12071A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38776 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJHhM-00073f-Vq
	for qemu-devel@archiver.kernel.org; Tue, 31 Mar 2020 10:17:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49508)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1jJHgK-00068b-KY
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 10:15:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1jJHgJ-0005q6-DT
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 10:15:56 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:49891
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1jJHgH-0005oo-VH
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 10:15:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585664153;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HhXUZVQdQg/xIMlWqFy5lAph2sWi88lhRGg8VR6locQ=;
 b=bikb/OU8QD0z+QTlH5k2KIWGT5y2fQoDPLqzBpnYoTQsyDNB55zEU4bkAJVi1XbNdwEQEu
 T0M7BtNoku4KAuWdjKNSOpujRX4WDJcOuyUSW2NrxW4VXIpaT++3Xc3pu6QZq3rNQymqSp
 EuUlItATQX5CULCZTSb+cobz4KWjtSU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-272-gwOIpEjnMYq1o63HzWTy5g-1; Tue, 31 Mar 2020 10:15:49 -0400
X-MC-Unique: gwOIpEjnMYq1o63HzWTy5g-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F3730107ACC9;
 Tue, 31 Mar 2020 14:15:47 +0000 (UTC)
Received: from redhat.com (unknown [10.36.110.48])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8ABB95D9E2;
 Tue, 31 Mar 2020 14:15:42 +0000 (UTC)
Date: Tue, 31 Mar 2020 15:15:39 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Subject: Re: [PATCH-for-5.0 v2 4/4] qga: Restrict guest-file-read count to 10
 MB to avoid crashes
Message-ID: <20200331141539.GJ353752@redhat.com>
References: <20200331140638.16464-1-philmd@redhat.com>
 <20200331140638.16464-5-philmd@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200331140638.16464-5-philmd@redhat.com>
User-Agent: Mutt/1.13.3 (2020-01-12)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Michael Roth <mdroth@linux.vnet.ibm.com>,
 Fakhri Zulkifli <mohdfakhrizulkifli@gmail.com>,
 Markus Armbruster <armbru@redhat.com>, Sameeh Jubran <sjubran@redhat.com>,
 Basil Salman <basil@daynix.com>, Dietmar Maurer <dietmar@proxmox.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Mar 31, 2020 at 04:06:38PM +0200, Philippe Mathieu-Daud=C3=A9 wrote=
:
> On https://www.mail-archive.com/qemu-devel@nongnu.org/msg693176.html
> Daniel Berrang=C3=A9 commented:
>=20
>   The QEMU guest agent protocol is not sensible way to access huge
>   files inside the guest. It requires the inefficient process of
>   reading the entire data into memory than duplicating it again in
>   base64 format, and then copying it again in the JSON serializer /
>   monitor code.
>=20
>   For arbitrary general purpose file access, especially for large
>   files, use a real file transfer program or use a network block
>   device, not the QEMU guest agent.
>=20
> To avoid bug reports as BZ#1594054, follow his suggestion to put a
> low, hard limit on "count" in the guest agent QAPI schema, and don't
> allow count to be larger than 10 MB.
>=20
> Buglink: https://bugzilla.redhat.com/show_bug.cgi?id=3D1594054
> Reported-by: Fakhri Zulkifli <mohdfakhrizulkifli@gmail.com>
> Suggested-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>  qga/qapi-schema.json | 6 ++++--
>  qga/commands.c       | 6 +++++-
>  2 files changed, 9 insertions(+), 3 deletions(-)
>=20
> diff --git a/qga/qapi-schema.json b/qga/qapi-schema.json
> index f6fcb59f34..7758d9daf8 100644
> --- a/qga/qapi-schema.json
> +++ b/qga/qapi-schema.json
> @@ -266,11 +266,13 @@
>  ##
>  # @guest-file-read:
>  #
> -# Read from an open file in the guest. Data will be base64-encoded
> +# Read from an open file in the guest. Data will be base64-encoded.
> +# As this command is just for limited, ad-hoc debugging, such as log
> +# file access, the number of bytes to read is limited to 10 MB.
>  #
>  # @handle: filehandle returned by guest-file-open
>  #
> -# @count: maximum number of bytes to read (default is 4KB)
> +# @count: maximum number of bytes to read (default is 4KB, maximum is 10=
MB)
>  #
>  # Returns: @GuestFileRead on success.
>  #
> diff --git a/qga/commands.c b/qga/commands.c
> index 8ee1244ebb..c130d1b0f5 100644
> --- a/qga/commands.c
> +++ b/qga/commands.c
> @@ -11,6 +11,7 @@
>   */
> =20
>  #include "qemu/osdep.h"
> +#include "qemu/units.h"
>  #include "guest-agent-core.h"
>  #include "qga-qapi-commands.h"
>  #include "qapi/error.h"
> @@ -18,11 +19,14 @@
>  #include "qemu/base64.h"
>  #include "qemu/cutils.h"
>  #include "qemu/atomic.h"
> +#include "commands-common.h"

This needs to be in the previous patch AFAICT.


Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange=
 :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com=
 :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange=
 :|


