Return-Path: <SRS0=H0ck=CE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9918C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 11:06:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8EADC2083B
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 11:06:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Qm25ejoh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8EADC2083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33360 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAtGY-0006Kc-QZ
	for qemu-devel@archiver.kernel.org; Wed, 26 Aug 2020 07:06:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47108)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kAtEN-00033p-SQ
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 07:04:40 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:50028
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kAtDB-00032Q-7L
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 07:04:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598439804;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+4GzsgrGIVgPT/aygMaWuyUZAWVh5MZcztuOKgZGM/w=;
 b=Qm25ejohxlT6E4LN65iGTmBzhRXzMDPTbHZ+z98ylgrdBFMTbyNqHzaCWpuEIdhuEZDAlQ
 WPMwq7r9CXDlom/TCyr7BQ0KdawIFbEgmkfYplyGL82MedYvYjvDE6wZnc14zgruNHfnK+
 tvLUTsv4AiDoKdoxrlVgt4USUYNKTDI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-59-4hqDn55tP3iXhgS1VfIPAQ-1; Wed, 26 Aug 2020 07:03:22 -0400
X-MC-Unique: 4hqDn55tP3iXhgS1VfIPAQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 33D4118A2240;
 Wed, 26 Aug 2020 11:03:21 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-74.ams2.redhat.com
 [10.36.112.74])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B64EB1944D;
 Wed, 26 Aug 2020 11:03:20 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 31F4D112D737; Wed, 26 Aug 2020 13:03:19 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Subject: Re: [PATCH v4 3/6] util: add Error object for qemu_open_internal
 error reporting
References: <20200821172105.608752-1-berrange@redhat.com>
 <20200821172105.608752-4-berrange@redhat.com>
 <87wo1mbvw2.fsf@dusky.pond.sub.org>
 <20200825153627.GA107278@redhat.com>
Date: Wed, 26 Aug 2020 13:03:19 +0200
In-Reply-To: <20200825153627.GA107278@redhat.com> ("Daniel P. =?utf-8?Q?Be?=
 =?utf-8?Q?rrang=C3=A9=22's?=
 message of "Tue, 25 Aug 2020 16:36:27 +0100")
Message-ID: <87k0xl7jpk.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.81; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/26 03:16:15
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.959,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> On Tue, Aug 25, 2020 at 05:14:21PM +0200, Markus Armbruster wrote:
>> Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:
>>=20
>> > Instead of relying on the limited information from errno, we can now
>> > also provide detailed error messages.
>>=20
>> The more detailed error messages are currently always ignored, but the
>> next patches will fix that.
>>=20
>> > Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
>> > ---
>> >  util/osdep.c | 21 +++++++++++++++++++--
>> >  1 file changed, 19 insertions(+), 2 deletions(-)
>> >
>> > diff --git a/util/osdep.c b/util/osdep.c
>> > index 9ff92551e7..9c7118d3cb 100644
>> > --- a/util/osdep.c
>> > +++ b/util/osdep.c
>> > @@ -284,7 +284,7 @@ int qemu_lock_fd_test(int fd, int64_t start, int64=
_t len, bool exclusive)
>> >   * Opens a file with FD_CLOEXEC set
>> >   */
>> >  static int
>> > -qemu_open_internal(const char *name, int flags, mode_t mode)
>> > +qemu_open_internal(const char *name, int flags, mode_t mode, Error **=
errp)
>> >  {
>> >      int ret;
>> > =20
>> > @@ -298,24 +298,31 @@ qemu_open_internal(const char *name, int flags, =
mode_t mode)
>> > =20
>> >          fdset_id =3D qemu_parse_fdset(fdset_id_str);
>> >          if (fdset_id =3D=3D -1) {
>> > +            error_setg(errp, "Could not parse fdset %s", name);
>> >              errno =3D EINVAL;
>> >              return -1;
>> >          }
>> > =20
>> >          fd =3D monitor_fdset_get_fd(fdset_id, flags);
>> >          if (fd < 0) {
>> > +            error_setg_errno(errp, -fd, "Could not acquire FD for %s =
flags %x",
>> > +                             name, flags);
>> >              errno =3D -fd;
>> >              return -1;
>> >          }
>> > =20
>> >          dupfd =3D qemu_dup_flags(fd, flags);
>> >          if (dupfd =3D=3D -1) {
>> > +            error_setg_errno(errp, errno, "Could not dup FD for %s fl=
ags %x",
>> > +                             name, flags);
>> >              return -1;
>> >          }
>> > =20
>> >          ret =3D monitor_fdset_dup_fd_add(fdset_id, dupfd);
>> >          if (ret =3D=3D -1) {
>> >              close(dupfd);
>> > +            error_setg(errp, "Could not save FD for %s flags %x",
>> > +                       name, flags);
>>=20
>> Can this happen?
>
> Well there's code in monitor_fdset_dup_fd_add that can return -1.

It fails when

* @fdset_id contains @dupfd

  @dupfd is a fresh file descriptor.  If @fdset_id already contains it,
  it's stale there.  That would be a programming error.  Recommend to
  assert.

* @fdset_id is not in @mon_fdsets

  monitor_fdset_get_fd() fails the same way.  monitor_fdset_dup_fd_add()
  can fail that way after monitor_fdset_get_fd() succeed only if the fd
  set went away between the two.  Could that happen?  Would it be safe?

  This is the only user of monitor_fdset_dup_fd_add().  Why not remove
  the awkward failure mode by making monitor_fdset_dup_fd_add() dup the
  fd and add?

>> >              errno =3D EINVAL;
>> >              return -1;
>> >          }
>> > @@ -336,6 +343,16 @@ qemu_open_internal(const char *name, int flags, m=
ode_t mode)
>> >      }
>> >  #endif /* ! O_CLOEXEC */
>> > =20
>> > +    if (ret =3D=3D -1) {
>> > +        const char *action =3D "open";
>> > +        if (flags & O_CREAT) {
>> > +            action =3D "create";
>> > +        }
>> > +        error_setg_errno(errp, errno, "Could not %s '%s' flags 0x%x",
>> > +                         action, name, flags);
>>=20
>> Not a good user experience:
>>=20
>>     Could not open '/etc/shadow' flags 0x0: Permission denied
>>=20
>> Better:
>>=20
>>     Could not open '/etc/shadow' for reading: Permission denied
>>=20
>> Are you sure flags other than the access mode (O_RDONLY, O_WRONLY,
>> O_RDWR) must be included in the error message?
>
> It was the flags other than access mode that I was thinking were
> more important to log. I'm ambivalent htough, so can drop the
> flags if it is thought to be overkill.

Hexadecimal flags are borderline useless even for developers: to make
sense of them, you have to grep -R /usr/include/.  For mere mortals,
they are confusing in addition to useless.

>> If you must report flags in hexadecimal, then please reporting them more
>> consistently.  Right now you have
>>=20
>>     for %s flags 0x%x
>>     '%s' flags %x
>>=20
>> Perhaps '%s' with flags 0x%x
>>=20
>> > +    }
>> > +
>> > +
>> >      return ret;
>> >  }
>> > =20
>> > @@ -352,7 +369,7 @@ int qemu_open_old(const char *name, int flags, ...=
)
>> >      }
>> >      va_end(ap);
>> > =20
>> > -    ret =3D qemu_open_internal(name, flags, mode);
>> > +    ret =3D qemu_open_internal(name, flags, mode, NULL);
>> > =20
>> >  #ifdef O_DIRECT
>> >      if (ret =3D=3D -1 && errno =3D=3D EINVAL && (flags & O_DIRECT)) {
>>=20
>>=20
>
> Regards,
> Daniel


