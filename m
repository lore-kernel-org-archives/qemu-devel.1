Return-Path: <SRS0=qvFP=5O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58B3DC43331
	for <qemu-devel@archiver.kernel.org>; Sun, 29 Mar 2020 16:47:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 24F962073B
	for <qemu-devel@archiver.kernel.org>; Sun, 29 Mar 2020 16:47:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GgClySdf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24F962073B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39564 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jIb5U-0001qN-64
	for qemu-devel@archiver.kernel.org; Sun, 29 Mar 2020 12:47:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47321)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <marcandre.lureau@gmail.com>) id 1jIb4a-0000yH-DH
 for qemu-devel@nongnu.org; Sun, 29 Mar 2020 12:46:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcandre.lureau@gmail.com>) id 1jIb4Z-0005zU-0F
 for qemu-devel@nongnu.org; Sun, 29 Mar 2020 12:46:08 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:33702)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
 id 1jIb4Y-0005wK-Q4
 for qemu-devel@nongnu.org; Sun, 29 Mar 2020 12:46:06 -0400
Received: by mail-wr1-x443.google.com with SMTP id a25so18128198wrd.0
 for <qemu-devel@nongnu.org>; Sun, 29 Mar 2020 09:46:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=32RFDUG2iUuXPaqvstuEq5n3CDg9D0f3SQaSBM4ZKoo=;
 b=GgClySdfKlxgyuDICDl1fwegtnZzFuN5Er2przTIs9XTkRv5313YeW81tPZPwPvA34
 tYCtbzRYNffR9NzbFXq8UN4MoI5PS5jWX6AkllADcfg+yAqpN+xdWESJtjzxgi1t+rQy
 h3MzrdAjzzo0XIEGe0XZwh06xVwMLsW9VhQi8DZ/SPCKgVe4WJunLzRLFj8lrdPZN+mh
 c43gC3uxL2CZha8ptfBzcnKHzTeFeB3aFMtXR8DbroYM2h4VkI/yi41XQfgu3Bs7tQ3G
 gnmVa9NY8zJ4NVZvPWIELuhtLW/IjX4LOTe/hPWbft0Ecpk9hf8WnueclVpgWc4FMlBg
 iV7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=32RFDUG2iUuXPaqvstuEq5n3CDg9D0f3SQaSBM4ZKoo=;
 b=FP2zFzMQPn6r6htSCX0JmfeUc9zVO7udQm0Mmc19pffrRBQPgUlLR0Y0BQPGPSYQMe
 ybEX4yKe9or8p/zsYZpXhrwDLIuqxMpkwgSdb04plsr7zk+kEgx40n1guNO50XrDv2Kv
 ygjqPc1c1soHhceUrdGAur0ozWujAkSD0gejOR/1m1EoSJ8LhJRMK+OGRON/ZToQ/ib4
 ZNyWUgPcVac07JxU64g1CRq9aqIAR7QmyEYItIhJaLf/XZy3P6BP5JtSjM0HVQ75EnF3
 u7MhpT9d7L5ztt/IlxHltDREsiWTfilIQQrYbheSaZqVM9UYOX4di3AV2BhAPYVst2g3
 VZkg==
X-Gm-Message-State: ANhLgQ1ue/vlYGlRxkBRSGoT4SSNvfpnWx7cP9/3HNPEaPTMvKqPnq9a
 UIcbUUAvReYS1LfMP4jh/pD+iyUBJGPB+0Gihi4=
X-Google-Smtp-Source: ADFU+vtwxxex3Y48M1F0+NdYTJg21Y3Kjr3qgoeDKuhy5Zv0hZTrC0lheT45ML1soUxEB2M8ofKX/8mKtOJqd+v/Se4=
X-Received: by 2002:adf:e8c1:: with SMTP id k1mr10037413wrn.381.1585500365152; 
 Sun, 29 Mar 2020 09:46:05 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1582576372.git.jag.raman@oracle.com>
 <5087037defe31df3abbcd677d206540247649b83.1582576372.git.jag.raman@oracle.com>
In-Reply-To: <5087037defe31df3abbcd677d206540247649b83.1582576372.git.jag.raman@oracle.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Sun, 29 Mar 2020 18:45:53 +0200
Message-ID: <CAJ+F1CKa-EuY-mx2vKFvxW3Hoo_6T+-adHYdHR7eM9DWkoDcEg@mail.gmail.com>
Subject: Re: [PATCH v5 02/50] multi-process: Refactor machine_init and exit
 notifiers
To: Jagannathan Raman <jag.raman@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
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
Cc: Elena Ufimtseva <elena.ufimtseva@oracle.com>, Fam Zheng <fam@euphon.net>,
 Swapnil Ingle <swapnil.ingle@nutanix.com>, john.g.johnson@oracle.com,
 QEMU <qemu-devel@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>,
 Juan Quintela <quintela@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, kanth.ghatraju@oracle.com,
 Felipe Franciosi <felipe@nutanix.com>, Thomas Huth <thuth@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, liran.alon@oracle.com,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 Richard Henderson <rth@twiddle.net>, Kevin Wolf <kwolf@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Ross Lagerwall <ross.lagerwall@citrix.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi

On Mon, Feb 24, 2020 at 9:56 PM Jagannathan Raman <jag.raman@oracle.com> wr=
ote:
>
> Relocate machine_int and exit notifiers into common code

utils/notify.c is not a good place to relocate those.

eventually, add a new softmmu/notifiers.c ?

And that patch broke make check test-char /char/mux, because it
overrides machine_init_done from stubs/machine-init-done.c..

>
> Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
> Signed-off-by: John G Johnson <john.g.johnson@oracle.com>
> Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
> ---
>  include/sysemu/sysemu.h |  2 ++
>  softmmu/vl.c            | 42 ------------------------------------------
>  util/notify.c           | 43 +++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 45 insertions(+), 42 deletions(-)
>
> diff --git a/include/sysemu/sysemu.h b/include/sysemu/sysemu.h
> index dec64fc..2f37e2b 100644
> --- a/include/sysemu/sysemu.h
> +++ b/include/sysemu/sysemu.h
> @@ -17,11 +17,13 @@ extern bool qemu_uuid_set;
>
>  void qemu_add_exit_notifier(Notifier *notify);
>  void qemu_remove_exit_notifier(Notifier *notify);
> +void qemu_run_exit_notifiers(void);
>
>  extern bool machine_init_done;
>
>  void qemu_add_machine_init_done_notifier(Notifier *notify);
>  void qemu_remove_machine_init_done_notifier(Notifier *notify);
> +void qemu_run_machine_init_done_notifiers(void);
>
>  extern int autostart;
>
> diff --git a/softmmu/vl.c b/softmmu/vl.c
> index 92c7b3a..94a7b93 100644
> --- a/softmmu/vl.c
> +++ b/softmmu/vl.c
> @@ -173,12 +173,6 @@ int icount_align_option;
>  QemuUUID qemu_uuid;
>  bool qemu_uuid_set;
>
> -static NotifierList exit_notifiers =3D
> -    NOTIFIER_LIST_INITIALIZER(exit_notifiers);
> -
> -static NotifierList machine_init_done_notifiers =3D
> -    NOTIFIER_LIST_INITIALIZER(machine_init_done_notifiers);
> -
>  bool xen_allowed;
>  uint32_t xen_domid;
>  enum xen_mode xen_mode =3D XEN_EMULATE;
> @@ -2324,21 +2318,6 @@ static MachineClass *machine_parse(const char *nam=
e, GSList *machines)
>      return mc;
>  }
>
> -void qemu_add_exit_notifier(Notifier *notify)
> -{
> -    notifier_list_add(&exit_notifiers, notify);
> -}
> -
> -void qemu_remove_exit_notifier(Notifier *notify)
> -{
> -    notifier_remove(notify);
> -}
> -
> -static void qemu_run_exit_notifiers(void)
> -{
> -    notifier_list_notify(&exit_notifiers, NULL);
> -}
> -
>  static const char *pid_file;
>  static Notifier qemu_unlink_pidfile_notifier;
>
> @@ -2349,27 +2328,6 @@ static void qemu_unlink_pidfile(Notifier *n, void =
*data)
>      }
>  }
>
> -bool machine_init_done;
> -
> -void qemu_add_machine_init_done_notifier(Notifier *notify)
> -{
> -    notifier_list_add(&machine_init_done_notifiers, notify);
> -    if (machine_init_done) {
> -        notify->notify(notify, NULL);
> -    }
> -}
> -
> -void qemu_remove_machine_init_done_notifier(Notifier *notify)
> -{
> -    notifier_remove(notify);
> -}
> -
> -static void qemu_run_machine_init_done_notifiers(void)
> -{
> -    machine_init_done =3D true;
> -    notifier_list_notify(&machine_init_done_notifiers, NULL);
> -}
> -
>  static const QEMUOption *lookup_opt(int argc, char **argv,
>                                      const char **poptarg, int *poptind)
>  {
> diff --git a/util/notify.c b/util/notify.c
> index 76bab21..0e7479b 100644
> --- a/util/notify.c
> +++ b/util/notify.c
> @@ -15,6 +15,15 @@
>
>  #include "qemu/osdep.h"
>  #include "qemu/notify.h"
> +#include "sysemu/sysemu.h"
> +
> +bool machine_init_done;
> +
> +static NotifierList machine_init_done_notifiers =3D
> +    NOTIFIER_LIST_INITIALIZER(machine_init_done_notifiers);
> +
> +static NotifierList exit_notifiers =3D
> +    NOTIFIER_LIST_INITIALIZER(exit_notifiers);
>
>  void notifier_list_init(NotifierList *list)
>  {
> @@ -74,3 +83,37 @@ int notifier_with_return_list_notify(NotifierWithRetur=
nList *list, void *data)
>      }
>      return ret;
>  }
> +
> +void qemu_add_machine_init_done_notifier(Notifier *notify)
> +{
> +    notifier_list_add(&machine_init_done_notifiers, notify);
> +    if (machine_init_done) {
> +        notify->notify(notify, NULL);
> +    }
> +}
> +
> +void qemu_remove_machine_init_done_notifier(Notifier *notify)
> +{
> +    notifier_remove(notify);
> +}
> +
> +void qemu_run_machine_init_done_notifiers(void)
> +{
> +    machine_init_done =3D true;
> +    notifier_list_notify(&machine_init_done_notifiers, NULL);
> +}
> +
> +void qemu_add_exit_notifier(Notifier *notify)
> +{
> +    notifier_list_add(&exit_notifiers, notify);
> +}
> +
> +void qemu_remove_exit_notifier(Notifier *notify)
> +{
> +    notifier_remove(notify);
> +}
> +
> +void qemu_run_exit_notifiers(void)
> +{
> +    notifier_list_notify(&exit_notifiers, NULL);
> +}
> --
> 1.8.3.1
>


--=20
Marc-Andr=C3=A9 Lureau

