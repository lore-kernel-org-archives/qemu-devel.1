Return-Path: <SRS0=uEni=2K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCC0FC43603
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 16:44:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 87FDC20716
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 16:44:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UxHB+J1w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87FDC20716
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58876 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iiLNn-00080R-NX
	for qemu-devel@archiver.kernel.org; Fri, 20 Dec 2019 11:44:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44722)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1iiLJb-00059r-KJ
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 11:39:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1iiLJY-00086R-SO
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 11:39:45 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:60173
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1iiLJY-000845-IF
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 11:39:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576859982;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MRcOlEc2NsesDX/VPbW91N7+unboADJxq5p1NjFYWoQ=;
 b=UxHB+J1wAnb7J0499iEFR+RK9x6/1Lk5mqPE62YsZT35B+YG6NxCb3ezk9CN9rphSvcZR+
 VHafh4r+zgzHI+lgtdOAPzh+prvW+gwwYnY/znZCqrH5BfNFwR46EzlCVLoYlzbomV+o9o
 HHichp8TPpfttWUH38A1YFH+QyQ2gLs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-432-s5A78vb4MLmpS-UAYPxxUA-1; Fri, 20 Dec 2019 11:39:41 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1C74F107B0EF;
 Fri, 20 Dec 2019 16:39:40 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-42.ams2.redhat.com
 [10.36.116.42])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 55A5160BEC;
 Fri, 20 Dec 2019 16:39:37 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 93D7111386A7; Fri, 20 Dec 2019 17:39:35 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Subject: Re: [PATCH v5 37/37] qdev/qom: remove some TODO limitations now that
 PROP_PTR is gone
References: <20191220134601.571905-1-marcandre.lureau@redhat.com>
 <20191220134601.571905-38-marcandre.lureau@redhat.com>
Date: Fri, 20 Dec 2019 17:39:35 +0100
In-Reply-To: <20191220134601.571905-38-marcandre.lureau@redhat.com>
 (=?utf-8?Q?=22Marc-Andr=C3=A9?= Lureau"'s message of "Fri, 20 Dec 2019
 17:46:01 +0400")
Message-ID: <87pngjc5o8.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: s5A78vb4MLmpS-UAYPxxUA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: peter.maydell@linaro.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:

> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  hw/core/qdev.c     |  8 --------
>  qom/qom-qmp-cmds.c | 10 ----------
>  2 files changed, 18 deletions(-)
>
> diff --git a/hw/core/qdev.c b/hw/core/qdev.c
> index 98e786c50f..9feb81cff2 100644
> --- a/hw/core/qdev.c
> +++ b/hw/core/qdev.c
> @@ -736,14 +736,6 @@ void qdev_property_add_static(DeviceState *dev, Prop=
erty *prop,
>      if (prop->info->create) {
>          prop->info->create(obj, prop, &local_err);
>      } else {
> -        /*
> -         * TODO qdev_prop_ptr does not have getters or setters.  It must
> -         * go now that it can be replaced with links.  The test should b=
e
> -         * removed along with it: all static properties are read/write.
> -         */
> -        if (!prop->info->get && !prop->info->set) {
> -            return;
> -        }
>          object_property_add(obj, prop->name, prop->info->name,
>                              prop->info->get, prop->info->set,
>                              prop->info->release,
> diff --git a/qom/qom-qmp-cmds.c b/qom/qom-qmp-cmds.c
> index 236e8e41dd..f4494f98ac 100644
> --- a/qom/qom-qmp-cmds.c
> +++ b/qom/qom-qmp-cmds.c
> @@ -142,16 +142,6 @@ static ObjectPropertyInfo *make_device_property_info=
(ObjectClass *klass,
>                  continue;
>              }
> =20
> -            /*
> -             * TODO Properties without a parser are just for dirty hacks=
.
> -             * qdev_prop_ptr is the only such PropertyInfo.  It's marked
> -             * for removal.  This conditional should be removed along wi=
th
> -             * it.
> -             */
> -            if (!prop->info->set && !prop->info->create) {
> -                return NULL;           /* no way to set it, don't show *=
/
> -            }
> -
>              info =3D g_malloc0(sizeof(*info));
>              info->name =3D g_strdup(prop->name);
>              info->type =3D default_type ? g_strdup(default_type)

Reviewed-by: Markus Armbruster <armbru@redhat.com>


