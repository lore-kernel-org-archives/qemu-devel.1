Return-Path: <SRS0=URa6=5T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C76F7C43331
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2020 09:25:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D8C820721
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2020 09:25:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Xc8+ma+K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D8C820721
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52652 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jKIZz-00045M-L7
	for qemu-devel@archiver.kernel.org; Fri, 03 Apr 2020 05:25:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56802)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1jKIYU-0003Xc-BW
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 05:24:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1jKIYR-0008FI-4v
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 05:24:01 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:59377
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1jKIYQ-00089T-Py
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 05:23:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585905837;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eJJy1WT3kPY1U6bs3QG16OQMi/Oxvs51Sf5VUHXmTR0=;
 b=Xc8+ma+KKqohDwUyq0zR+EaATkaqUzF/h0CyNtpe1/vb8dMhI6boN+4qGqFWOMP4AWeD4X
 A6rqgmNM91aq1ZZXtUWptPvDTFlOMglvrnoKpYBsudvRaQSP/1ecbQ93Y+jnXSO+q5rL8S
 9EznWPbBm0U3S7T7tSyKCzM/30fLS58=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-425-kkOMkQ55On-ry-b4ELn7wQ-1; Fri, 03 Apr 2020 05:23:45 -0400
X-MC-Unique: kkOMkQ55On-ry-b4ELn7wQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C857519067E6;
 Fri,  3 Apr 2020 09:23:43 +0000 (UTC)
Received: from redhat.com (unknown [10.36.110.24])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D38CC6EF97;
 Fri,  3 Apr 2020 09:23:37 +0000 (UTC)
Date: Fri, 3 Apr 2020 10:23:34 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH-for-5.0 v2 4/4] qga: Restrict guest-file-read count to 10
 MB to avoid crashes
Message-ID: <20200403092334.GC559148@redhat.com>
References: <20200331140638.16464-1-philmd@redhat.com>
 <20200331140638.16464-5-philmd@redhat.com>
 <87v9mi3ufw.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
In-Reply-To: <87v9mi3ufw.fsf@dusky.pond.sub.org>
User-Agent: Mutt/1.13.3 (2020-01-12)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Michael Roth <mdroth@linux.vnet.ibm.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Fakhri Zulkifli <mohdfakhrizulkifli@gmail.com>, qemu-devel@nongnu.org,
 Sameeh Jubran <sjubran@redhat.com>, Basil Salman <basil@daynix.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Dietmar Maurer <dietmar@proxmox.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Apr 02, 2020 at 03:09:55PM +0200, Markus Armbruster wrote:
> Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:
>=20
> > On https://www.mail-archive.com/qemu-devel@nongnu.org/msg693176.html
> > Daniel Berrang=C3=A9 commented:
> >
> >   The QEMU guest agent protocol is not sensible way to access huge
> >   files inside the guest. It requires the inefficient process of
> >   reading the entire data into memory than duplicating it again in
> >   base64 format, and then copying it again in the JSON serializer /
> >   monitor code.
> >
> >   For arbitrary general purpose file access, especially for large
> >   files, use a real file transfer program or use a network block
> >   device, not the QEMU guest agent.
> >
> > To avoid bug reports as BZ#1594054, follow his suggestion to put a
> > low, hard limit on "count" in the guest agent QAPI schema, and don't
> > allow count to be larger than 10 MB.
> >
> > Buglink: https://bugzilla.redhat.com/show_bug.cgi?id=3D1594054
> > Reported-by: Fakhri Zulkifli <mohdfakhrizulkifli@gmail.com>
> > Suggested-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> > Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> > ---
> >  qga/qapi-schema.json | 6 ++++--
> >  qga/commands.c       | 6 +++++-
> >  2 files changed, 9 insertions(+), 3 deletions(-)
> >
> > diff --git a/qga/qapi-schema.json b/qga/qapi-schema.json
> > index f6fcb59f34..7758d9daf8 100644
> > --- a/qga/qapi-schema.json
> > +++ b/qga/qapi-schema.json
> > @@ -266,11 +266,13 @@
> >  ##
> >  # @guest-file-read:
> >  #
> > -# Read from an open file in the guest. Data will be base64-encoded
> > +# Read from an open file in the guest. Data will be base64-encoded.
> > +# As this command is just for limited, ad-hoc debugging, such as log
> > +# file access, the number of bytes to read is limited to 10 MB.
> >  #
> >  # @handle: filehandle returned by guest-file-open
> >  #
> > -# @count: maximum number of bytes to read (default is 4KB)
> > +# @count: maximum number of bytes to read (default is 4KB, maximum is =
10MB)
> >  #
> >  # Returns: @GuestFileRead on success.
> >  #
> > diff --git a/qga/commands.c b/qga/commands.c
> > index 8ee1244ebb..c130d1b0f5 100644
> > --- a/qga/commands.c
> > +++ b/qga/commands.c
> > @@ -11,6 +11,7 @@
> >   */
> > =20
> >  #include "qemu/osdep.h"
> > +#include "qemu/units.h"
> >  #include "guest-agent-core.h"
> >  #include "qga-qapi-commands.h"
> >  #include "qapi/error.h"
> > @@ -18,11 +19,14 @@
> >  #include "qemu/base64.h"
> >  #include "qemu/cutils.h"
> >  #include "qemu/atomic.h"
> > +#include "commands-common.h"
> > =20
> >  /* Maximum captured guest-exec out_data/err_data - 16MB */
> >  #define GUEST_EXEC_MAX_OUTPUT (16*1024*1024)
> >  /* Allocation and I/O buffer for reading guest-exec out_data/err_data =
- 4KB */
> >  #define GUEST_EXEC_IO_SIZE (4*1024)
> > +/* Maximum file size to read - 10MB */
> > +#define GUEST_FILE_READ_COUNT_MAX (10 * MiB)
> > =20
> >  /* Note: in some situations, like with the fsfreeze, logging may be
> >   * temporarilly disabled. if it is necessary that a command be able
> > @@ -559,7 +563,7 @@ GuestFileRead *qmp_guest_file_read(int64_t handle, =
bool has_count,
> >      }
> >      if (!has_count) {
> >          count =3D QGA_READ_COUNT_DEFAULT;
> > -    } else if (count < 0 || count >=3D UINT32_MAX) {
> > +    } else if (count < 0 || count > GUEST_FILE_READ_COUNT_MAX) {
> >          error_setg(errp, "value '%" PRId64 "' is invalid for argument =
count",
> >                     count);
> >          return NULL;
>=20
> What about qmp-guest-file-write?
>=20
> Hmm, the JSON parser already puts a limit on the base-64 encoded data,
> namely MAX_TOKEN_SIZE, which is 64MiB.  Yes, MAX_TOKEN_SIZE is
> ridiculously generous.
>=20
> In case you look at the code: there are *two* MAX_TOKEN_SIZE, both
> 64MiB.  One actually applies to tokens, the other to all the tokens in a
> top-level expression.  Yes, this is criminally confusing.

Oh fun :-(

Anyway, if the JSON parser has 64 MB limits in various places, then
I'd be inclined to set the QGA guest-file-read limit such that the
encoded JSON is at approx the 64 MB limit too so we're somewhat
consistent in limits.

Base64 has a 3:4 overhead, so that would suggest setting guest-file-read
to be 48 MB limit.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange=
 :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com=
 :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange=
 :|


