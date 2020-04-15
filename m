Return-Path: <SRS0=EwQe=57=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E75DC2BA19
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2020 12:35:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CC0EB2074F
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2020 12:35:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gI3JtZu2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC0EB2074F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49112 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jOhGR-0007l5-SN
	for qemu-devel@archiver.kernel.org; Wed, 15 Apr 2020 08:35:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58263)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1jOhFS-0006Zu-Qp
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 08:34:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1jOhFR-00005f-Bi
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 08:34:34 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:26799
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1jOhFR-00005P-8T
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 08:34:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586954072;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0Uy9lqTgi6TZn/aPolCcUucWxqAYXbHSor4s6Zu9RQo=;
 b=gI3JtZu28egik2Qc0+vt5qcNU7FEs92cTc4tOyDAjM48RHG0m5hR4E/o6JfnsUElshqvIb
 nC1N20jC51ZQ9zbISVgrmC3lMpNr1jRh5fAagKijqCeN7iUDDUoE8/z5lOknH1nGD3i6re
 KhOrGp1WX3w/kbnPjQK3LueLpvVYxzw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-304-zONj6yNzP8KWgGBFGP0GYg-1; Wed, 15 Apr 2020 08:34:25 -0400
X-MC-Unique: zONj6yNzP8KWgGBFGP0GYg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 435C91005509;
 Wed, 15 Apr 2020 12:34:22 +0000 (UTC)
Received: from redhat.com (unknown [10.36.110.40])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5CD782719A;
 Wed, 15 Apr 2020 12:34:08 +0000 (UTC)
Date: Wed, 15 Apr 2020 13:34:05 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Subject: Re: [PATCH-for-5.0 04/12] qga: Restrict guest-file-read count to 48
 MB to avoid crashes
Message-ID: <20200415123405.GD1344391@redhat.com>
References: <20200414133052.13712-1-philmd@redhat.com>
 <20200414133052.13712-5-philmd@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200414133052.13712-5-philmd@redhat.com>
User-Agent: Mutt/1.13.3 (2020-01-12)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Michael Roth <mdroth@linux.vnet.ibm.com>, qemu-block@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Fakhri Zulkifli <mohdfakhrizulkifli@gmail.com>, qemu-devel@nongnu.org,
 Fabien Chouteau <chouteau@adacore.com>, Max Filippov <jcmvbkbc@gmail.com>,
 KONRAD Frederic <frederic.konrad@adacore.com>, qemu-arm@nongnu.org,
 qemu-ppc@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Stafford Horne <shorne@gmail.com>, Max Reitz <mreitz@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Apr 14, 2020 at 03:30:44PM +0200, Philippe Mathieu-Daud=C3=A9 wrote=
:
> On [*] Daniel Berrang=C3=A9 commented:
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
> To avoid bug reports as BZ#1594054 (CVE-2018-12617), follow his
> suggestion to put a low, hard limit on "count" in the guest agent
> QAPI schema, and don't allow count to be larger than 48 MB.
>=20
> [*] https://www.mail-archive.com/qemu-devel@nongnu.org/msg693176.html
>=20
> Fixes: CVE-2018-12617
> Buglink: https://bugzilla.redhat.com/show_bug.cgi?id=3D1594054
> Reported-by: Fakhri Zulkifli <mohdfakhrizulkifli@gmail.com>
> Suggested-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>  qga/qapi-schema.json | 6 ++++--
>  qga/commands.c       | 9 ++++++++-
>  2 files changed, 12 insertions(+), 3 deletions(-)
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

s/10/48/

>  #
>  # @handle: filehandle returned by guest-file-open
>  #
> -# @count: maximum number of bytes to read (default is 4KB)
> +# @count: maximum number of bytes to read (default is 4KB, maximum is 10=
MB)

s/10/48/

>  #
>  # Returns: @GuestFileRead on success.
>  #
> diff --git a/qga/commands.c b/qga/commands.c
> index 5611117372..efc8b90281 100644
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
> @@ -24,6 +25,12 @@
>  #define GUEST_EXEC_MAX_OUTPUT (16*1024*1024)
>  /* Allocation and I/O buffer for reading guest-exec out_data/err_data - =
4KB */
>  #define GUEST_EXEC_IO_SIZE (4*1024)
> +/*
> + * Maximum file size to read - 48MB
> + *
> + * (48MB + Base64 3:4 overhead =3D JSON parser 64 MB limit)
> + */
> +#define GUEST_FILE_READ_COUNT_MAX (48 * MiB)
> =20
>  /* Note: in some situations, like with the fsfreeze, logging may be
>   * temporarilly disabled. if it is necessary that a command be able
> @@ -560,7 +567,7 @@ GuestFileRead *qmp_guest_file_read(int64_t handle, bo=
ol has_count,
>      }
>      if (!has_count) {
>          count =3D QGA_READ_COUNT_DEFAULT;
> -    } else if (count < 0 || count >=3D UINT32_MAX) {
> +    } else if (count < 0 || count > GUEST_FILE_READ_COUNT_MAX) {
>          error_setg(errp, "value '%" PRId64 "' is invalid for argument co=
unt",
>                     count);
>          return NULL;

With the docs typos fixed:

  Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>


Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange=
 :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com=
 :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange=
 :|


