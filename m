Return-Path: <SRS0=BVCf=4W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDCFAC3F2D1
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 16:06:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 888FC2073B
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 16:06:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RpDK9HrD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 888FC2073B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51794 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9t1O-0006Re-M7
	for qemu-devel@archiver.kernel.org; Thu, 05 Mar 2020 11:06:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54989)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1j9t0U-0005R5-5a
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 11:05:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1j9t0S-0006uw-4d
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 11:05:53 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:51723
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1j9t0R-0006sz-Vt
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 11:05:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583424350;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=c9qFwmyJ5Vk1MNnL5p5n8g0jBI5JukA9WXdOxsdc2EQ=;
 b=RpDK9HrDvFhjcrAxdEOwGh1acTGfd2dvd4ttEGp4vQnVuaUP29H8GT3o1XihBWFDV7sQ1+
 +VaWsR4pguEEouDIRyQrKXZgArTNKeYsgHrvsb0VH7r1RLZN1Vd/WBHD+62xhXuKIchiOo
 Sr/sQW56aW4r0ZW9cwu4caIjvLCDcg4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-185-MVMOwL2fPOqJlHhhu3l5CQ-1; Thu, 05 Mar 2020 11:05:48 -0500
X-MC-Unique: MVMOwL2fPOqJlHhhu3l5CQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 44830184C808;
 Thu,  5 Mar 2020 16:05:46 +0000 (UTC)
Received: from work-vm (unknown [10.36.118.152])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3F8B819E9C;
 Thu,  5 Mar 2020 16:05:34 +0000 (UTC)
Date: Thu, 5 Mar 2020 16:05:31 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Jagannathan Raman <jag.raman@oracle.com>
Subject: Re: [PATCH v5 46/50] multi-process/mig: Restore the VMSD in remote
 process
Message-ID: <20200305160531.GM3130@work-vm>
References: <cover.1582576372.git.jag.raman@oracle.com>
 <68144e5a0cdc4a16c1fe63f4a7482191f86b7c0f.1582576372.git.jag.raman@oracle.com>
MIME-Version: 1.0
In-Reply-To: <68144e5a0cdc4a16c1fe63f4a7482191f86b7c0f.1582576372.git.jag.raman@oracle.com>
User-Agent: Mutt/1.13.3 (2020-01-12)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
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
Cc: elena.ufimtseva@oracle.com, fam@euphon.net, swapnil.ingle@nutanix.com,
 john.g.johnson@oracle.com, qemu-devel@nongnu.org, kraxel@redhat.com,
 quintela@redhat.com, mst@redhat.com, armbru@redhat.com,
 kanth.ghatraju@oracle.com, felipe@nutanix.com, thuth@redhat.com,
 ehabkost@redhat.com, konrad.wilk@oracle.com, liran.alon@oracle.com,
 stefanha@redhat.com, thanos.makatos@nutanix.com, rth@twiddle.net,
 kwolf@redhat.com, berrange@redhat.com, mreitz@redhat.com,
 ross.lagerwall@citrix.com, marcandre.lureau@gmail.com, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Jagannathan Raman (jag.raman@oracle.com) wrote:
> From: Elena Ufimtseva <elena.ufimtseva@oracle.com>
>=20
> The remote process accepts the VMSD from Proxy object and
> restores it
>=20
> Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
> Signed-off-by: John G Johnson <john.g.johnson@oracle.com>
> Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
> ---
>  migration/savevm.c   | 36 ++++++++++++++++++++++++++++++++++++
>  migration/savevm.h   |  1 +
>  remote/remote-main.c | 33 +++++++++++++++++++++++++++++++++
>  3 files changed, 70 insertions(+)
>=20
> diff --git a/migration/savevm.c b/migration/savevm.c
> index 09af14d..e95ea4a 100644
> --- a/migration/savevm.c
> +++ b/migration/savevm.c
> @@ -2969,3 +2969,39 @@ int qemu_remote_savevm(QEMUFile *f)
> =20
>      return 0;
>  }
> +
> +int qemu_remote_loadvm(QEMUFile *f)
> +{
> +    uint8_t section_type;
> +    int ret =3D 0;
> +
> +    qemu_mutex_lock_iothread();
> +
> +    while (true) {
> +        section_type =3D qemu_get_byte(f);
> +
> +        if (qemu_file_get_error(f)) {
> +            ret =3D qemu_file_get_error(f);
> +            break;
> +        }
> +
> +        switch (section_type) {
> +        case QEMU_VM_SECTION_FULL:
> +            ret =3D qemu_loadvm_section_start_full(f, NULL);
> +            if (ret < 0) {
> +                break;
> +            }
> +            break;
> +        case QEMU_VM_EOF:
> +            goto out;
> +        default:
> +            ret =3D -EINVAL;

It's good to print an error there - when it goes wrong we'll want to
know it.

> +            goto out;
> +        }
> +    }
> +
> +out:
> +    qemu_mutex_unlock_iothread();
> +
> +    return ret;
> +}
> diff --git a/migration/savevm.h b/migration/savevm.h
> index 0491d3a..8741c66 100644
> --- a/migration/savevm.h
> +++ b/migration/savevm.h
> @@ -66,5 +66,6 @@ int qemu_loadvm_state_main(QEMUFile *f, MigrationIncomi=
ngState *mis);
>  int qemu_load_device_state(QEMUFile *f);
> =20
>  int qemu_remote_savevm(QEMUFile *f);
> +int qemu_remote_loadvm(QEMUFile *f);
> =20
>  #endif
> diff --git a/remote/remote-main.c b/remote/remote-main.c
> index 0260c7c..ab4ad0b 100644
> --- a/remote/remote-main.c
> +++ b/remote/remote-main.c
> @@ -68,6 +68,7 @@
>  #include "chardev/char.h"
>  #include "sysemu/reset.h"
>  #include "vl.h"
> +#include "migration/misc.h"
> =20
>  static MPQemuLinkState *mpqemu_link;
> =20
> @@ -363,6 +364,30 @@ static void process_start_mig_out(MPQemuMsg *msg)
>      qemu_fclose(f);
>  }
> =20
> +static int process_start_mig_in(MPQemuMsg *msg)
> +{
> +    Error *err =3D NULL;
> +    QIOChannel *ioc;
> +    QEMUFile *f;
> +    int rc =3D -EINVAL;
> +
> +    ioc =3D qio_channel_new_fd(msg->fds[0], &err);
> +    if (err) {
> +        error_report_err(err);
> +        return rc;
> +    }
> +
> +    qio_channel_set_name(QIO_CHANNEL(ioc), "remote-migration-channel");
> +
> +    f =3D qemu_fopen_channel_input(ioc);
> +
> +    rc =3D qemu_remote_loadvm(f);
> +
> +    qemu_fclose(f);
> +
> +    return rc;
> +}
> +
>  static void process_msg(GIOCondition cond, MPQemuChannel *chan)
>  {
>      MPQemuMsg *msg =3D NULL;
> @@ -455,6 +480,12 @@ static void process_msg(GIOCondition cond, MPQemuCha=
nnel *chan)
>      case START_MIG_OUT:
>          process_start_mig_out(msg);
>          break;
> +    case START_MIG_IN:
> +        if (process_start_mig_in(msg)) {
> +            error_setg(&err, "Incoming migration failed.");
> +            goto finalize_loop;
> +        }
> +        break;

Do you have any sanity checks to make sure what happens if you were to
receive a MIG_IN while you were already running?

Dave

>      case RUNSTATE_SET:
>          remote_runstate_set(msg->data1.runstate.state);
>          notify_proxy(msg->fds[0], 0);
> @@ -532,6 +563,8 @@ int main(int argc, char *argv[])
>      }
>      mpqemu_init_channel(mpqemu_link, &mpqemu_link->mmio, fd);
> =20
> +    migration_object_init();
> +
>      parse_cmdline(argc - 3, argv + 3, NULL);
> =20
>      mpqemu_link_set_callback(mpqemu_link, process_msg);
> --=20
> 1.8.3.1
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


