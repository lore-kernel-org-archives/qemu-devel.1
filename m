Return-Path: <SRS0=2GMi=CD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33F9DC433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 15:16:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E98EA20786
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 15:16:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ceAf7uMN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E98EA20786
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49302 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAag4-0004wa-98
	for qemu-devel@archiver.kernel.org; Tue, 25 Aug 2020 11:16:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58216)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kAafA-0004FQ-Dy
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 11:15:04 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:54197
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kAaf8-0004vX-NW
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 11:15:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598368501;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/fK5XDCZ79ChIX5sIFwPK/2VWwY6xrAMNYWulDzucNw=;
 b=ceAf7uMNP4EtwtgMOxkHnKVUnjiRdqYpELwSPzJBkB1U6EmGmvitXYSU46fQPzL2RfpnAM
 Fap1hUkyYUNC0VdSQEvJYzIJr9mjhUTjZuvo2GZgqGKECND5v3rNsOIqmdD/JGnc10x0o6
 AvyN9RNuSuR6xjgsk/IFBNc1WsL7Wrs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-126-aaCzM4E9NsOPjF0Evg8SAA-1; Tue, 25 Aug 2020 11:14:59 -0400
X-MC-Unique: aaCzM4E9NsOPjF0Evg8SAA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 39760AE3CE;
 Tue, 25 Aug 2020 15:14:23 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-74.ams2.redhat.com
 [10.36.112.74])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0B2175C1CF;
 Tue, 25 Aug 2020 15:14:23 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 9382D112D737; Tue, 25 Aug 2020 17:14:21 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Subject: Re: [PATCH v4 3/6] util: add Error object for qemu_open_internal
 error reporting
References: <20200821172105.608752-1-berrange@redhat.com>
 <20200821172105.608752-4-berrange@redhat.com>
Date: Tue, 25 Aug 2020 17:14:21 +0200
In-Reply-To: <20200821172105.608752-4-berrange@redhat.com> ("Daniel
 P. =?utf-8?Q?Berrang=C3=A9=22's?= message of "Fri, 21 Aug 2020 18:21:02
 +0100")
Message-ID: <87wo1mbvw2.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.61; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/25 01:35:36
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.958,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> Instead of relying on the limited information from errno, we can now
> also provide detailed error messages.

The more detailed error messages are currently always ignored, but the
next patches will fix that.

> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> ---
>  util/osdep.c | 21 +++++++++++++++++++--
>  1 file changed, 19 insertions(+), 2 deletions(-)
>
> diff --git a/util/osdep.c b/util/osdep.c
> index 9ff92551e7..9c7118d3cb 100644
> --- a/util/osdep.c
> +++ b/util/osdep.c
> @@ -284,7 +284,7 @@ int qemu_lock_fd_test(int fd, int64_t start, int64_t =
len, bool exclusive)
>   * Opens a file with FD_CLOEXEC set
>   */
>  static int
> -qemu_open_internal(const char *name, int flags, mode_t mode)
> +qemu_open_internal(const char *name, int flags, mode_t mode, Error **err=
p)
>  {
>      int ret;
> =20
> @@ -298,24 +298,31 @@ qemu_open_internal(const char *name, int flags, mod=
e_t mode)
> =20
>          fdset_id =3D qemu_parse_fdset(fdset_id_str);
>          if (fdset_id =3D=3D -1) {
> +            error_setg(errp, "Could not parse fdset %s", name);
>              errno =3D EINVAL;
>              return -1;
>          }
> =20
>          fd =3D monitor_fdset_get_fd(fdset_id, flags);
>          if (fd < 0) {
> +            error_setg_errno(errp, -fd, "Could not acquire FD for %s fla=
gs %x",
> +                             name, flags);
>              errno =3D -fd;
>              return -1;
>          }
> =20
>          dupfd =3D qemu_dup_flags(fd, flags);
>          if (dupfd =3D=3D -1) {
> +            error_setg_errno(errp, errno, "Could not dup FD for %s flags=
 %x",
> +                             name, flags);
>              return -1;
>          }
> =20
>          ret =3D monitor_fdset_dup_fd_add(fdset_id, dupfd);
>          if (ret =3D=3D -1) {
>              close(dupfd);
> +            error_setg(errp, "Could not save FD for %s flags %x",
> +                       name, flags);

Can this happen?

>              errno =3D EINVAL;
>              return -1;
>          }
> @@ -336,6 +343,16 @@ qemu_open_internal(const char *name, int flags, mode=
_t mode)
>      }
>  #endif /* ! O_CLOEXEC */
> =20
> +    if (ret =3D=3D -1) {
> +        const char *action =3D "open";
> +        if (flags & O_CREAT) {
> +            action =3D "create";
> +        }
> +        error_setg_errno(errp, errno, "Could not %s '%s' flags 0x%x",
> +                         action, name, flags);

Not a good user experience:

    Could not open '/etc/shadow' flags 0x0: Permission denied

Better:

    Could not open '/etc/shadow' for reading: Permission denied

Are you sure flags other than the access mode (O_RDONLY, O_WRONLY,
O_RDWR) must be included in the error message?

If you must report flags in hexadecimal, then please reporting them more
consistently.  Right now you have

    for %s flags 0x%x
    '%s' flags %x

Perhaps '%s' with flags 0x%x

> +    }
> +
> +
>      return ret;
>  }
> =20
> @@ -352,7 +369,7 @@ int qemu_open_old(const char *name, int flags, ...)
>      }
>      va_end(ap);
> =20
> -    ret =3D qemu_open_internal(name, flags, mode);
> +    ret =3D qemu_open_internal(name, flags, mode, NULL);
> =20
>  #ifdef O_DIRECT
>      if (ret =3D=3D -1 && errno =3D=3D EINVAL && (flags & O_DIRECT)) {


