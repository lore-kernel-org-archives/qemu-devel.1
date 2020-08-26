Return-Path: <SRS0=H0ck=CE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88F20C433E1
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 11:20:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4FCBA20786
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 11:20:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SUvX3GEP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FCBA20786
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37042 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAtUA-00034T-KB
	for qemu-devel@archiver.kernel.org; Wed, 26 Aug 2020 07:20:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50224)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kAtTF-00023Y-Gg
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 07:20:01 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:22851
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kAtTD-0004xM-H3
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 07:20:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598440798;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JW3cbo9TNsVhO86tFiK37jfCs/Lns4fiNoifcTZK1jE=;
 b=SUvX3GEP8hf+DvmllJVhtqPJn+CtM9jy9LnU2PQuD+wuoNPkDoO3MsRgXtaWMatTFTXZ2T
 evRH8fnzXokWE+XzxfA98bw0C6kS24ozzYihI9nA00BjppIR86S5j2DoPhCExPEcdZmd9K
 JNYrKLUQsf294HyGqHVqBB12A8NQCoQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-512-cXIszKsTO-eY8boda73MkA-1; Wed, 26 Aug 2020 07:19:56 -0400
X-MC-Unique: cXIszKsTO-eY8boda73MkA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D79161DDF7;
 Wed, 26 Aug 2020 11:19:55 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-74.ams2.redhat.com
 [10.36.112.74])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7B1641944D;
 Wed, 26 Aug 2020 11:19:55 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id F30B8112D737; Wed, 26 Aug 2020 13:19:53 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Subject: Re: [PATCH v4 5/6] util: give a specific error message when O_DIRECT
 doesn't work
References: <20200821172105.608752-1-berrange@redhat.com>
 <20200821172105.608752-6-berrange@redhat.com>
 <87o8mybvmu.fsf@dusky.pond.sub.org>
 <20200825152319.GX107278@redhat.com>
Date: Wed, 26 Aug 2020 13:19:53 +0200
In-Reply-To: <20200825152319.GX107278@redhat.com> ("Daniel P. =?utf-8?Q?Be?=
 =?utf-8?Q?rrang=C3=A9=22's?=
 message of "Tue, 25 Aug 2020 16:23:19 +0100")
Message-ID: <875z957ixy.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.120; envelope-from=armbru@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/26 01:10:45
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.959,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
 Philippe =?utf-8?Q?Mathi?= =?utf-8?Q?eu-Daud=C3=A9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> On Tue, Aug 25, 2020 at 05:19:53PM +0200, Markus Armbruster wrote:
>> Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:
>>=20
>> > A common error scenario is to tell QEMU to use O_DIRECT in combination
>> > with a filesystem that doesn't support it. To aid users to diagnosing
>> > their mistake we want to provide a clear error message when this happe=
ns.
>> >
>> > Reviewed-by: Eric Blake <eblake@redhat.com>
>> > Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
>> > ---
>> >  util/osdep.c | 13 +++++++++++++
>> >  1 file changed, 13 insertions(+)
>> >
>> > diff --git a/util/osdep.c b/util/osdep.c
>> > index a4956fbf6b..6c24985f7a 100644
>> > --- a/util/osdep.c
>> > +++ b/util/osdep.c
>> > @@ -345,6 +345,19 @@ qemu_open_internal(const char *name, int flags, m=
ode_t mode, Error **errp)
>> > =20
>> >      if (ret =3D=3D -1) {
>> >          const char *action =3D flags & O_CREAT ? "create" : "open";
>> > +#ifdef O_DIRECT
>> > +        if (errno =3D=3D EINVAL && (flags & O_DIRECT)) {

Suggest

                  /*
                   * Check whether open() failed due to use of O_DIRECT,
                   * and set a more helpful error then.
                   */

>> > +            ret =3D open(name, flags & ~O_DIRECT, mode);
>> > +            if (ret !=3D -1) {
>> > +                close(ret);
>> > +                error_setg(errp, "Could not %s '%s' flags 0x%x: "
>> > +                           "filesystem does not support O_DIRECT",
>> > +                           action, name, flags);
>> > +                errno =3D EINVAL; /* close() clobbered earlier errno =
*/
>>=20
>> More precise: close() may have clobbered
>
> Either open or close in fact.
>
>>=20
>> Sure open() can only fail with EINVAL here?
>
> We don't care about the errno from the open() call seen in this context,
> we're restoring the EINVAL from the previous open() call above this patch
> contxt, that we match on with  "if (errno =3D=3D EINVAL && ...)" line.

Ah, got it now.

I'd prefer

                errno =3D EINVAL; /* restore first open()'s errno */
>>=20
>> > +                return -1;
>> > +            }
>> > +        }
>> > +#endif /* O_DIRECT */
>> >          error_setg_errno(errp, errno, "Could not %s '%s' flags 0x%x",
>> >                           action, name, flags);
>> >      }
>>=20
>> There is no qemu_set_cloexec().  Intentional?
>
> We've called close() immediately after open(). Adding qemu_set_cloexec()
> doesnt make it any less racy on platforms lacking O_CLOSEXEC

You're right.  I misread the code.

Reviewed-by: Markus Armbruster <armbru@redhat.com>


Now back to my dislike of the #ifdeffery I voiced in reply to PATCH 2.

Code now:

    #ifdef O_CLOEXEC
        flags |=3D O_CLOEXEC;
    #endif /* O_CLOEXEC */

        ret =3D open(name, flags, mode);

    #ifndef O_CLOEXEC
        if (ret >=3D 0) {
            qemu_set_cloexec(ret);
        }
    #endif /* ! O_CLOEXEC */

        if (ret =3D=3D -1) {
            const char *action =3D flags & O_CREAT ? "create" : "open";
    #ifdef O_DIRECT
            if (errno =3D=3D EINVAL && (flags & O_DIRECT)) {
                ret =3D open(name, flags & ~O_DIRECT, mode);
                if (ret !=3D -1) {
                    close(ret);
                    [O_DIRECT not supported error...]
                    errno =3D EINVAL; /* close() clobbered earlier errno */
                    return -1;
                }
            }
    #endif /* O_DIRECT */
            [generic error...]
        }

Compare:

    #ifdef O_CLOEXEC
        flags |=3D O_CLOEXEC;
        ret =3D open(name, flags, mode);
    #else
        ret =3D open(name, flags, mode);
        if (ret >=3D 0) {
            qemu_set_cloexec(ret);
        }
    #endif /* ! O_CLOEXEC */

        if (ret =3D=3D -1) {
            const char *action =3D flags & O_CREAT ? "create" : "open";
    #ifdef O_DIRECT
            if (errno =3D=3D EINVAL && (flags & O_DIRECT)) {
                ret =3D open(name, flags & ~O_DIRECT, mode);
                if (ret !=3D -1) {
                    close(ret);
                    [O_DIRECT not supported error...]
                    errno =3D EINVAL; /* close() clobbered earlier errno */
                    return -1;
                }
            }
    #endif /* O_DIRECT */
            [generic error...]
        }

I like this a bit better, but not enough to make a strong
recommendation, let alone demand.


