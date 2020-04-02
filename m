Return-Path: <SRS0=DsKm=5S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45032C43331
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2020 13:10:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 13FDA20784
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2020 13:10:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C0eNRhV7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13FDA20784
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38410 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJzcU-0005Ht-7f
	for qemu-devel@archiver.kernel.org; Thu, 02 Apr 2020 09:10:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38573)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jJzbp-0004lj-3m
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 09:10:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1jJzbm-0005U9-MO
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 09:10:12 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:31750
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1jJzbm-0005Tv-3n
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 09:10:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585833009;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=K4lJHnbN/1slg+JDMkmAvpYJ6x1YI1TYOmYL0AVqZAk=;
 b=C0eNRhV7ZkfOrrqMSzSBW6ilR4RDNfxSLM5FgcTTYjfS7H/h6Sgei2UlUrt4g0Mu6e/p8b
 3zOumlKCmsojshQPRq2Hxtw6p/M5qOY1Lak43GTCYAeGiFL/knrzTawXci8F0yhBKh6Rey
 3CSk0I8Y1mrpzdDMfXbeH9bLWCkzadY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-269-tr_hpxvBOsy167fg0q0U0Q-1; Thu, 02 Apr 2020 09:10:01 -0400
X-MC-Unique: tr_hpxvBOsy167fg0q0U0Q-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0C83A801E5C;
 Thu,  2 Apr 2020 13:10:00 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-69.ams2.redhat.com
 [10.36.112.69])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id BD7AA18A85;
 Thu,  2 Apr 2020 13:09:56 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 419FF11385E2; Thu,  2 Apr 2020 15:09:55 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Subject: Re: [PATCH-for-5.0 v2 4/4] qga: Restrict guest-file-read count to 10
 MB to avoid crashes
References: <20200331140638.16464-1-philmd@redhat.com>
 <20200331140638.16464-5-philmd@redhat.com>
Date: Thu, 02 Apr 2020 15:09:55 +0200
In-Reply-To: <20200331140638.16464-5-philmd@redhat.com> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Tue, 31 Mar 2020 16:06:38
 +0200")
Message-ID: <87v9mi3ufw.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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
Cc: "Daniel P . =?utf-8?Q?Berrang=C3=A9?=" <berrange@redhat.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Fakhri Zulkifli <mohdfakhrizulkifli@gmail.com>, qemu-devel@nongnu.org,
 Sameeh Jubran <sjubran@redhat.com>, Basil Salman <basil@daynix.com>,
 Dietmar Maurer <dietmar@proxmox.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:

> On https://www.mail-archive.com/qemu-devel@nongnu.org/msg693176.html
> Daniel Berrang=C3=A9 commented:
>
>   The QEMU guest agent protocol is not sensible way to access huge
>   files inside the guest. It requires the inefficient process of
>   reading the entire data into memory than duplicating it again in
>   base64 format, and then copying it again in the JSON serializer /
>   monitor code.
>
>   For arbitrary general purpose file access, especially for large
>   files, use a real file transfer program or use a network block
>   device, not the QEMU guest agent.
>
> To avoid bug reports as BZ#1594054, follow his suggestion to put a
> low, hard limit on "count" in the guest agent QAPI schema, and don't
> allow count to be larger than 10 MB.
>
> Buglink: https://bugzilla.redhat.com/show_bug.cgi?id=3D1594054
> Reported-by: Fakhri Zulkifli <mohdfakhrizulkifli@gmail.com>
> Suggested-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>  qga/qapi-schema.json | 6 ++++--
>  qga/commands.c       | 6 +++++-
>  2 files changed, 9 insertions(+), 3 deletions(-)
>
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
> =20
>  /* Maximum captured guest-exec out_data/err_data - 16MB */
>  #define GUEST_EXEC_MAX_OUTPUT (16*1024*1024)
>  /* Allocation and I/O buffer for reading guest-exec out_data/err_data - =
4KB */
>  #define GUEST_EXEC_IO_SIZE (4*1024)
> +/* Maximum file size to read - 10MB */
> +#define GUEST_FILE_READ_COUNT_MAX (10 * MiB)
> =20
>  /* Note: in some situations, like with the fsfreeze, logging may be
>   * temporarilly disabled. if it is necessary that a command be able
> @@ -559,7 +563,7 @@ GuestFileRead *qmp_guest_file_read(int64_t handle, bo=
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

What about qmp-guest-file-write?

Hmm, the JSON parser already puts a limit on the base-64 encoded data,
namely MAX_TOKEN_SIZE, which is 64MiB.  Yes, MAX_TOKEN_SIZE is
ridiculously generous.

In case you look at the code: there are *two* MAX_TOKEN_SIZE, both
64MiB.  One actually applies to tokens, the other to all the tokens in a
top-level expression.  Yes, this is criminally confusing.

We additionally limit the number of tokens within a top-level
expression, and its nesting depth.

The stated reason for these limits is

    /*
     * Security consideration, we limit total memory allocated per object
     * and the maximum recursion depth that a message can force.
     */

"Security" is misleading; we use this parser only for parsing QMP input,
QGA input, and string literals.  All trusted.  It's actually a
robustness consideration.

We fail to put similar limits on JSON output.

While we protect you from the rather far-fetched mistake of driving QEMU
into OOM state by sending ridiculously huge QMP/QGA input, we do nothing
to protect you from the more realistic mistake of sending a QMP/QGA
command that produces ridiculously huge output.

Could use a rethink, I guess :)


