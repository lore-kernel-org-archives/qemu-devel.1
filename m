Return-Path: <SRS0=xVqP=Z2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_SBL,URIBL_SBL_A autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 799E8C43603
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2019 15:03:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1255D2084F
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2019 15:03:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A+ywdV5W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1255D2084F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40122 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1icWBo-0001Nt-7q
	for qemu-devel@archiver.kernel.org; Wed, 04 Dec 2019 10:03:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48404)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1icW91-0007xG-6j
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 10:00:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1icW8x-0000MF-Py
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 10:00:47 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:39682
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1icW8x-0000Ln-KR
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 10:00:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575471643;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ajRfpg8Ys2mundddq1XB+ae7HTn9RvM1JIztRsA+x88=;
 b=A+ywdV5WHf3FBI4ktUXu7ICSEbE2SacHxC4AkvV9WKIb3dyCmtID2cVDscbs0Fn9sWUDTD
 fxe0NTe1r9dfbgsz9680THTB8UqzJaYENPIqd5zPevHmvkcBuEmhTVqmgu0XZW7+ehi12h
 kOBG0WhgeB5AJspWzLTjoBwbbVH88Fk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-121-mtHk5eY3O-2_dbJ5ZdlsaQ-1; Wed, 04 Dec 2019 10:00:40 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D568618557FF;
 Wed,  4 Dec 2019 15:00:36 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-134.ams2.redhat.com
 [10.36.116.134])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4E41E19C68;
 Wed,  4 Dec 2019 15:00:01 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id C11E51138606; Wed,  4 Dec 2019 15:59:59 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Subject: Re: [RFC v5 024/126] error: auto propagated local_err
References: <20191011160552.22907-1-vsementsov@virtuozzo.com>
 <20191011160552.22907-25-vsementsov@virtuozzo.com>
Date: Wed, 04 Dec 2019 15:59:59 +0100
In-Reply-To: <20191011160552.22907-25-vsementsov@virtuozzo.com> (Vladimir
 Sementsov-Ogievskiy's message of "Fri, 11 Oct 2019 19:04:10 +0300")
Message-ID: <87muc8p24w.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: mtHk5eY3O-2_dbJ5ZdlsaQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
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
Cc: Ronnie Sahlberg <ronniesahlberg@gmail.com>, Jeff Cody <codyprime@gmail.com>,
 Jan Kiszka <jan.kiszka@siemens.com>, Alberto Garcia <berto@igalia.com>,
 Hailiang Zhang <zhang.zhanghailiang@huawei.com>, qemu-block@nongnu.org,
 Aleksandar Rikalo <arikalo@wavecomp.com>, Halil Pasic <pasic@linux.ibm.com>,
 =?utf-8?Q?Herv=C3=A9?= Poussineau <hpoussin@reactos.org>,
 Anthony Perard <anthony.perard@citrix.com>,
 Samuel Thibault <samuel.thibault@ens-lyon.org>,
 Laszlo Ersek <lersek@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 Xie Changlong <xiechanglong.d@gmail.com>, Peter Lieven <pl@kamp.de>, "Dr.
 David Alan Gilbert" <dgilbert@redhat.com>,
 Beniamino Galvani <b.galvani@gmail.com>, Eric Auger <eric.auger@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, John Snow <jsnow@redhat.com>,
 Richard Henderson <rth@twiddle.net>, Kevin Wolf <kwolf@redhat.com>,
 Andrew Jeffery <andrew@aj.id.au>, Chris Wulff <crwulff@gmail.com>,
 Subbaraya Sundeep <sundeep.lkml@gmail.com>, Michael Walle <michael@walle.cc>,
 qemu-ppc@nongnu.org, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Igor Mammedov <imammedo@redhat.com>, Fam Zheng <fam@euphon.net>,
 Peter Maydell <peter.maydell@linaro.org>, sheepdog@lists.wpkg.org,
 Matthew Rosato <mjrosato@linux.ibm.com>, David Hildenbrand <david@redhat.com>,
 Palmer Dabbelt <palmer@sifive.com>, Eric Farman <farman@linux.ibm.com>,
 Max Filippov <jcmvbkbc@gmail.com>, "Denis V. Lunev" <den@openvz.org>,
 Hannes Reinecke <hare@suse.com>, Stefano Stabellini <sstabellini@kernel.org>,
 "Gonglei \(Arei\)" <arei.gonglei@huawei.com>, Liu Yuan <namei.unix@gmail.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Thomas Huth <thuth@redhat.com>,
 Amit Shah <amit@kernel.org>, Stefan Weil <sw@weilnetz.de>,
 Greg Kurz <groug@kaod.org>, Yuval Shaia <yuval.shaia@oracle.com>,
 qemu-s390x@nongnu.org, qemu-arm@nongnu.org,
 Peter Chubb <peter.chubb@nicta.com.au>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>,
 Stafford Horne <shorne@gmail.com>, qemu-riscv@nongnu.org,
 Cornelia Huck <cohuck@redhat.com>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Paul Burton <pburton@wavecomp.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>, Paul Durrant <paul@xen.org>,
 Anthony Green <green@moxielogic.com>, Gerd Hoffmann <kraxel@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Guan Xuetao <gxt@mprc.pku.edu.cn>, Ari Sundholm <ari@tuxera.com>,
 Juan Quintela <quintela@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>, Joel Stanley <joel@jms.id.au>,
 Jason Dillaman <dillaman@redhat.com>, Antony Pavlov <antonynpavlov@gmail.com>,
 xen-devel@lists.xenproject.org, integration@gluster.org,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 "Richard W.M. Jones" <rjones@redhat.com>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>, Max Reitz <mreitz@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org,
 Vincenzo Maffione <v.maffione@gmail.com>, Marek Vasut <marex@denx.de>,
 armbru@redhat.com,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Alistair Francis <alistair@alistair23.me>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Giuseppe Lettieri <g.lettieri@iet.unipi.it>, Luigi Rizzo <rizzo@iet.unipi.it>,
 David Gibson <david@gibson.dropbear.id.au>,
 Tony Krowiak <akrowiak@linux.ibm.com>,
 "Daniel P. =?utf-8?Q?Berrang=C3=A9?=" <berrange@redhat.com>,
 Xiao Guangrong <xiaoguangrong.eric@gmail.com>,
 Pierre Morel <pmorel@linux.ibm.com>, Wen Congyang <wencongyang2@huawei.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 Paolo Bonzini <pbonzini@redhat.com>, Stefan Berger <stefanb@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com> writes:

> Here is introduced ERRP_AUTO_PROPAGATE macro, to be used at start of
> functions with errp OUT parameter.
>
> It has three goals:
>
> 1. Fix issue with error_fatal & error_prepend/error_append_hint: user
> can't see this additional information, because exit() happens in
> error_setg earlier than information is added. [Reported by Greg Kurz]
>
> 2. Fix issue with error_abort & error_propagate: when we wrap
> error_abort by local_err+error_propagate, resulting coredump will
> refer to error_propagate and not to the place where error happened.

I get what you mean, but I have plenty of context.

> (the macro itself doesn't fix the issue, but it allows to [3.] drop all
> local_err+error_propagate pattern, which will definitely fix the issue)

The parenthesis is not part of the goal.

> [Reported by Kevin Wolf]
>
> 3. Drop local_err+error_propagate pattern, which is used to workaround
> void functions with errp parameter, when caller wants to know resulting
> status. (Note: actually these functions could be merely updated to
> return int error code).
>
> To achieve these goals, we need to add invocation of the macro at start
> of functions, which needs error_prepend/error_append_hint (1.); add
> invocation of the macro at start of functions which do
> local_err+error_propagate scenario the check errors, drop local errors
> from them and just use *errp instead (2., 3.).

The paragraph talks about two cases: 1. and 2.+3.  Makes me think we
want two paragraphs, each illustrated with an example.

What about you provide the examples, and then I try to polish the prose?

> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> Reviewed-by: Eric Blake <eblake@redhat.com>
> ---
>
> CC: Gerd Hoffmann <kraxel@redhat.com>
> CC: "Gonglei (Arei)" <arei.gonglei@huawei.com>
> CC: Eduardo Habkost <ehabkost@redhat.com>
> CC: Igor Mammedov <imammedo@redhat.com>
> CC: Laurent Vivier <lvivier@redhat.com>
> CC: Amit Shah <amit@kernel.org>
> CC: Kevin Wolf <kwolf@redhat.com>
> CC: Max Reitz <mreitz@redhat.com>
> CC: John Snow <jsnow@redhat.com>
> CC: Ari Sundholm <ari@tuxera.com>
> CC: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>
> CC: Paolo Bonzini <pbonzini@redhat.com>
> CC: Stefan Hajnoczi <stefanha@redhat.com>
> CC: Fam Zheng <fam@euphon.net>
> CC: Stefan Weil <sw@weilnetz.de>
> CC: Ronnie Sahlberg <ronniesahlberg@gmail.com>
> CC: Peter Lieven <pl@kamp.de>
> CC: Eric Blake <eblake@redhat.com>
> CC: "Denis V. Lunev" <den@openvz.org>
> CC: Markus Armbruster <armbru@redhat.com>
> CC: Alberto Garcia <berto@igalia.com>
> CC: Jason Dillaman <dillaman@redhat.com>
> CC: Wen Congyang <wencongyang2@huawei.com>
> CC: Xie Changlong <xiechanglong.d@gmail.com>
> CC: Liu Yuan <namei.unix@gmail.com>
> CC: "Richard W.M. Jones" <rjones@redhat.com>
> CC: Jeff Cody <codyprime@gmail.com>
> CC: "Marc-Andr=C3=A9 Lureau" <marcandre.lureau@redhat.com>
> CC: "Daniel P. Berrang=C3=A9" <berrange@redhat.com>
> CC: Richard Henderson <rth@twiddle.net>
> CC: Greg Kurz <groug@kaod.org>
> CC: "Michael S. Tsirkin" <mst@redhat.com>
> CC: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
> CC: Beniamino Galvani <b.galvani@gmail.com>
> CC: Peter Maydell <peter.maydell@linaro.org>
> CC: "C=C3=A9dric Le Goater" <clg@kaod.org>
> CC: Andrew Jeffery <andrew@aj.id.au>
> CC: Joel Stanley <joel@jms.id.au>
> CC: Andrew Baumann <Andrew.Baumann@microsoft.com>
> CC: "Philippe Mathieu-Daud=C3=A9" <philmd@redhat.com>
> CC: Antony Pavlov <antonynpavlov@gmail.com>
> CC: Jean-Christophe Dubois <jcd@tribudubois.net>
> CC: Peter Chubb <peter.chubb@nicta.com.au>
> CC: Subbaraya Sundeep <sundeep.lkml@gmail.com>
> CC: Eric Auger <eric.auger@redhat.com>
> CC: Alistair Francis <alistair@alistair23.me>
> CC: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
> CC: Stefano Stabellini <sstabellini@kernel.org>
> CC: Anthony Perard <anthony.perard@citrix.com>
> CC: Paul Durrant <paul@xen.org>
> CC: Paul Burton <pburton@wavecomp.com>
> CC: Aleksandar Rikalo <arikalo@wavecomp.com>
> CC: Chris Wulff <crwulff@gmail.com>
> CC: Marek Vasut <marex@denx.de>
> CC: David Gibson <david@gibson.dropbear.id.au>
> CC: Cornelia Huck <cohuck@redhat.com>
> CC: Halil Pasic <pasic@linux.ibm.com>
> CC: Christian Borntraeger <borntraeger@de.ibm.com>
> CC: "Herv=C3=A9 Poussineau" <hpoussin@reactos.org>
> CC: Xiao Guangrong <xiaoguangrong.eric@gmail.com>
> CC: Aurelien Jarno <aurelien@aurel32.net>
> CC: Aleksandar Markovic <amarkovic@wavecomp.com>
> CC: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> CC: Jason Wang <jasowang@redhat.com>
> CC: Laszlo Ersek <lersek@redhat.com>
> CC: Yuval Shaia <yuval.shaia@oracle.com>
> CC: Palmer Dabbelt <palmer@sifive.com>
> CC: Sagar Karandikar <sagark@eecs.berkeley.edu>
> CC: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
> CC: David Hildenbrand <david@redhat.com>
> CC: Thomas Huth <thuth@redhat.com>
> CC: Eric Farman <farman@linux.ibm.com>
> CC: Matthew Rosato <mjrosato@linux.ibm.com>
> CC: Hannes Reinecke <hare@suse.com>
> CC: Michael Walle <michael@walle.cc>
> CC: Artyom Tarasenko <atar4qemu@gmail.com>
> CC: Stefan Berger <stefanb@linux.ibm.com>
> CC: Samuel Thibault <samuel.thibault@ens-lyon.org>
> CC: Alex Williamson <alex.williamson@redhat.com>
> CC: Tony Krowiak <akrowiak@linux.ibm.com>
> CC: Pierre Morel <pmorel@linux.ibm.com>
> CC: Michael Roth <mdroth@linux.vnet.ibm.com>
> CC: Hailiang Zhang <zhang.zhanghailiang@huawei.com>
> CC: Juan Quintela <quintela@redhat.com>
> CC: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> CC: Luigi Rizzo <rizzo@iet.unipi.it>
> CC: Giuseppe Lettieri <g.lettieri@iet.unipi.it>
> CC: Vincenzo Maffione <v.maffione@gmail.com>
> CC: Jan Kiszka <jan.kiszka@siemens.com>
> CC: Anthony Green <green@moxielogic.com>
> CC: Stafford Horne <shorne@gmail.com>
> CC: Guan Xuetao <gxt@mprc.pku.edu.cn>
> CC: Max Filippov <jcmvbkbc@gmail.com>
> CC: qemu-block@nongnu.org
> CC: integration@gluster.org
> CC: sheepdog@lists.wpkg.org
> CC: qemu-arm@nongnu.org
> CC: xen-devel@lists.xenproject.org
> CC: qemu-ppc@nongnu.org
> CC: qemu-s390x@nongnu.org
> CC: qemu-riscv@nongnu.org
>
>  include/qapi/error.h | 38 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 38 insertions(+)
>
> diff --git a/include/qapi/error.h b/include/qapi/error.h
> index d6898d833b..47238d9065 100644
> --- a/include/qapi/error.h
> +++ b/include/qapi/error.h
> @@ -345,6 +345,44 @@ void error_set_internal(Error **errp,
>                          ErrorClass err_class, const char *fmt, ...)
>      GCC_FMT_ATTR(6, 7);
> =20
> +typedef struct ErrorPropagator {
> +    Error *local_err;
> +    Error **errp;
> +} ErrorPropagator;
> +
> +static inline void error_propagator_cleanup(ErrorPropagator *prop)
> +{
> +    error_propagate(prop->errp, prop->local_err);
> +}
> +
> +G_DEFINE_AUTO_CLEANUP_CLEAR_FUNC(ErrorPropagator, error_propagator_clean=
up);
> +
> +/*
> + * ERRP_AUTO_PROPAGATE
> + *
> + * This macro is created to be the first line of a function with Error *=
*errp
> + * OUT parameter. It's needed only in cases where we want to use error_p=
repend,
> + * error_append_hint or dereference *errp. It's still safe (but useless)=
 in
> + * other cases.
> + *
> + * If errp is NULL or points to error_fatal, it is rewritten to point to=
 a
> + * local Error object, which will be automatically propagated to the ori=
ginal
> + * errp on function exit (see error_propagator_cleanup).
> + *
> + * After invocation of this macro it is always safe to dereference errp
> + * (as it's not NULL anymore) and to add information (by error_prepend o=
r
> + * error_append_hint)
> + * (as, if it was error_fatal, we swapped it with a local_error to be
> + * propagated on cleanup).
> + *
> + * Note: we don't wrap the error_abort case, as we want resulting coredu=
mp
> + * to point to the place where the error happened, not to error_propagat=
e.
> + */
> +#define ERRP_AUTO_PROPAGATE()                                  \
> +    g_auto(ErrorPropagator) _auto_errp_prop =3D {.errp =3D errp};  \
> +    errp =3D ((errp =3D=3D NULL || *errp =3D=3D error_fatal)            =
 \
> +            ? &_auto_errp_prop.local_err : errp)
> +
>  /*
>   * Special error destination to abort on error.
>   * See error_setg() and error_propagate() for details.

Missing: update of the big comment starting with "Error reporting system
loosely patterned after Glib's GError."


