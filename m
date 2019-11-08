Return-Path: <SRS0=73np=ZA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71EE9FC6196
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 21:11:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2947420869
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 21:11:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lybdmy8/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2947420869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60538 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iTBXu-00062J-9W
	for qemu-devel@archiver.kernel.org; Fri, 08 Nov 2019 16:11:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56001)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <marcandre.lureau@gmail.com>) id 1iTBX4-0005M4-Vs
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 16:11:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcandre.lureau@gmail.com>) id 1iTBX1-0003N4-Ix
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 16:11:01 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:42482)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
 id 1iTBX1-0003Mn-Bh; Fri, 08 Nov 2019 16:10:59 -0500
Received: by mail-wr1-x444.google.com with SMTP id a15so8524339wrf.9;
 Fri, 08 Nov 2019 13:10:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=73/Er0/wletKjakTj5Sg+GBBinrJk/bbe18/Yg/uytw=;
 b=lybdmy8/zQVJLge+FoEDtDpOsRJmKkucC1LCi67ZXIkbsoRHad/QHyCVFyzsJ251Qb
 BPMTzqur0Budz6yc+eNU/QkVqjTH88o8GEoXUv/feyZPCauFCMhoWkjudlGP3pRCQ1L6
 ArMMsH2YDGbsgigi0FjVuSE9uuo/HsWrhGTuaYqqyOUp7uMlKUZp9PvxlJWV7xLJiCl3
 LjLJn8SUY0IbwLgHukMMBZJQ5GE3v+6gCPFAOH65TQ5UCELR6SR7bowPRBwg/hYo9Pvm
 MRoCYfbcIrWHrzzbS/pQRex3eVgZeuAk+gJ0OTfmxNRWaPgmkjC0zut83zxX/NAC/NZ8
 8ftQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=73/Er0/wletKjakTj5Sg+GBBinrJk/bbe18/Yg/uytw=;
 b=efQNMci4nxmg/UKYANqeUKp5JZmDOlyyMPqwUuYIVAF6SGrSEvID/fwxUffu8sddmO
 LKDLhnOjpKFfbJwd8SijYaYX+pzfa+uoTPRn3rvHInzJgpatCqANcqdQsqd+N/ZqaSSu
 TIGnIg9v7oaaYuecTL0kK1il5x3bSr+NArn6Tg/a6z1l+rwvsC4j/lxT/mL6U474rDvp
 OJ0BxicF22eCuJoCUTFj4NiqMKje+JT5+xDun7wyJaOzyA9bFayrjYkMAhkadT5yhNyK
 v29d1ri/TJXnMDEq1rflbKLGNchdcWR6QOT5C1A9jeiCNEowXaYx+Slf45UZh3VWCd+F
 3BIA==
X-Gm-Message-State: APjAAAXDpeztqUNxMEZMBsbZMZtxaMMfiQCbEQ0ukRUp0fXG/E1qIh5U
 ymxZpK0CqNqQN3oMHK7v5u+FARU4pTQBEnMY4yg=
X-Google-Smtp-Source: APXvYqzfxA2pqb/9d8lAfGdOFYeuUgux9dlBzO8unAXzKUb+vJdwk4VpnHS7LZzOekXwA7ihbpmn7CNhspyQ0+cGIYQ=
X-Received: by 2002:adf:f20f:: with SMTP id p15mr9710837wro.370.1573247458125; 
 Fri, 08 Nov 2019 13:10:58 -0800 (PST)
MIME-Version: 1.0
References: <20191011160552.22907-1-vsementsov@virtuozzo.com>
 <20191011160552.22907-25-vsementsov@virtuozzo.com>
In-Reply-To: <20191011160552.22907-25-vsementsov@virtuozzo.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Sat, 9 Nov 2019 01:10:45 +0400
Message-ID: <CAJ+F1CJWgQqE-FLVrOSeh8JMc_X5cKxk-iOpDftE1e_T7CsKNg@mail.gmail.com>
Subject: Re: [RFC v5 024/126] error: auto propagated local_err
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
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
 Hailiang Zhang <zhang.zhanghailiang@huawei.com>,
 "open list:Block layer core" <qemu-block@nongnu.org>,
 Aleksandar Rikalo <arikalo@wavecomp.com>, Halil Pasic <pasic@linux.ibm.com>,
 =?UTF-8?Q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>,
 Anthony Perard <anthony.perard@citrix.com>,
 Samuel Thibault <samuel.thibault@ens-lyon.org>,
 Laszlo Ersek <lersek@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 Xie Changlong <xiechanglong.d@gmail.com>, Peter Lieven <pl@kamp.de>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Beniamino Galvani <b.galvani@gmail.com>, Eric Auger <eric.auger@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, John Snow <jsnow@redhat.com>,
 Richard Henderson <rth@twiddle.net>, Kevin Wolf <kwolf@redhat.com>,
 Andrew Jeffery <andrew@aj.id.au>, Chris Wulff <crwulff@gmail.com>,
 Subbaraya Sundeep <sundeep.lkml@gmail.com>, Michael Walle <michael@walle.cc>,
 "open list:sPAPR pseries" <qemu-ppc@nongnu.org>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
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
 Qemu-s390x list <qemu-s390x@nongnu.org>, "open list:ARM" <qemu-arm@nongnu.org>,
 Peter Chubb <peter.chubb@nicta.com.au>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
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
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 "Richard W.M. Jones" <rjones@redhat.com>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>, Max Reitz <mreitz@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, QEMU <qemu-devel@nongnu.org>,
 Vincenzo Maffione <v.maffione@gmail.com>, Marek Vasut <marex@denx.de>,
 Markus Armbruster <armbru@redhat.com>,
 Alistair Francis <alistair@alistair23.me>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Giuseppe Lettieri <g.lettieri@iet.unipi.it>, Luigi Rizzo <rizzo@iet.unipi.it>,
 David Gibson <david@gibson.dropbear.id.au>,
 Tony Krowiak <akrowiak@linux.ibm.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Xiao Guangrong <xiaoguangrong.eric@gmail.com>,
 Pierre Morel <pmorel@linux.ibm.com>, Wen Congyang <wencongyang2@huawei.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 Paolo Bonzini <pbonzini@redhat.com>, Stefan Berger <stefanb@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Oct 11, 2019 at 10:11 PM Vladimir Sementsov-Ogievskiy
<vsementsov@virtuozzo.com> wrote:
>
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
> (the macro itself doesn't fix the issue, but it allows to [3.] drop all
> local_err+error_propagate pattern, which will definitely fix the issue)
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
>
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
>
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

Nice improvements. Minor drawback, the abort()/exit() will now take
place when going out of scope and running the cleanup instead of error
location. Not a big problem I guess.

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
> --
> 2.21.0
>
>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


--=20
Marc-Andr=C3=A9 Lureau

