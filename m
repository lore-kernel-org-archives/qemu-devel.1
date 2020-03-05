Return-Path: <SRS0=BVCf=4W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28735C3F2CD
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 14:41:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E6C2920732
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 14:41:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZiXbP16a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6C2920732
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50460 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9rgr-0007er-4f
	for qemu-devel@archiver.kernel.org; Thu, 05 Mar 2020 09:41:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37640)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1j9rfg-0005t0-2l
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 09:40:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1j9rfe-0002iA-B3
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 09:40:19 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:56978
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1j9rfe-0002hd-5v
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 09:40:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583419217;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GFSvv+YNgAwpVVO2rzFICsHg+LLJwfK6w7K+OoiFsts=;
 b=ZiXbP16aphONeqmzq66Um+NN7vGhBVKA8EfZlXH/xUtd9W5q6zUF6znKpJfSrJOS/Y/m8w
 A+q9oymw4fuxFMD1pYSQIpkslSled0KSX46ZyBb+8DpoTbQjaZjwiQahm0aV8ESYgOq5Fv
 d6A1xHOXMt4/YEBgwjV5j2yFdNgxoI8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-216-1CJL0PlEMhq1KSj-uu4Hvg-1; Thu, 05 Mar 2020 09:40:15 -0500
X-MC-Unique: 1CJL0PlEMhq1KSj-uu4Hvg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8554B13E6;
 Thu,  5 Mar 2020 14:40:13 +0000 (UTC)
Received: from work-vm (unknown [10.36.118.152])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 708B860C18;
 Thu,  5 Mar 2020 14:39:52 +0000 (UTC)
Date: Thu, 5 Mar 2020 14:39:49 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Jagannathan Raman <jag.raman@oracle.com>
Subject: Re: [PATCH v5 42/50] multi-process/mig: Send VMSD of remote to the
 Proxy object
Message-ID: <20200305143949.GI3130@work-vm>
References: <cover.1582576372.git.jag.raman@oracle.com>
 <74d6f7b67720a31a53c25164f8d9769c32d8c643.1582576372.git.jag.raman@oracle.com>
MIME-Version: 1.0
In-Reply-To: <74d6f7b67720a31a53c25164f8d9769c32d8c643.1582576372.git.jag.raman@oracle.com>
User-Agent: Mutt/1.13.3 (2020-01-12)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
> The remote process sends the VMSD to the Proxy object, on the source
> side
>=20
> Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
> Signed-off-by: John G Johnson <john.g.johnson@oracle.com>
> Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
> ---
>  migration/savevm.c   | 27 +++++++++++++++++++++++++++
>  migration/savevm.h   |  2 ++
>  remote/remote-main.c | 43 +++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 72 insertions(+)
>=20
> diff --git a/migration/savevm.c b/migration/savevm.c
> index 1d4220e..09af14d 100644
> --- a/migration/savevm.c
> +++ b/migration/savevm.c
> @@ -2942,3 +2942,30 @@ bool vmstate_check_only_migratable(const VMStateDe=
scription *vmsd)
> =20
>      return !(vmsd && vmsd->unmigratable);
>  }
> +

Can we add something here commenting, e.g.
/* Called by the remote process to serialise migration back to the qemu
 * */
> +int qemu_remote_savevm(QEMUFile *f)
> +{
> +    SaveStateEntry *se;
> +    int ret;
> +
> +    QTAILQ_FOREACH(se, &savevm_state.handlers, entry) {
> +        if (!se->vmsd || !vmstate_save_needed(se->vmsd, se->opaque)) {
> +            continue;
> +        }
> +
> +        save_section_header(f, se, QEMU_VM_SECTION_FULL);
> +
> +        ret =3D vmstate_save(f, se, NULL);
> +        if (ret) {
> +            qemu_file_set_error(f, ret);
> +            return ret;
> +        }
> +
> +        save_section_footer(f, se);
> +    }
> +
> +    qemu_put_byte(f, QEMU_VM_EOF);
> +    qemu_fflush(f);

You have a qemu_fflush in process_start_mig_out  just after you call it
- so you don't need both; I suggest you remove this one.

> +    return 0;

And make this return qemu_file_get_error(f);  just like
qemu_save_device_state and then makybe some day we can merge them.

> +}


> diff --git a/migration/savevm.h b/migration/savevm.h
> index ba64a7e..0491d3a 100644
> --- a/migration/savevm.h
> +++ b/migration/savevm.h
> @@ -65,4 +65,6 @@ void qemu_loadvm_state_cleanup(void);
>  int qemu_loadvm_state_main(QEMUFile *f, MigrationIncomingState *mis);
>  int qemu_load_device_state(QEMUFile *f);
> =20
> +int qemu_remote_savevm(QEMUFile *f);
> +
>  #endif
> diff --git a/remote/remote-main.c b/remote/remote-main.c
> index 58d9905..e97eb76 100644
> --- a/remote/remote-main.c
> +++ b/remote/remote-main.c
> @@ -53,6 +53,16 @@
>  #include "qemu/log.h"
>  #include "qemu/cutils.h"
>  #include "remote-opts.h"
> +#include "qapi/error.h"
> +#include "io/channel-util.h"
> +
> +#include "io/channel.h"
> +#include "io/channel-socket.h"
> +#include "migration/qemu-file-types.h"
> +#include "migration/savevm.h"
> +#include "migration/qemu-file-channel.h"
> +#include "migration/qemu-file.h"
> +
>  #include "monitor/monitor.h"
>  #include "chardev/char.h"
>  #include "sysemu/reset.h"
> @@ -322,6 +332,36 @@ static int setup_device(MPQemuMsg *msg, Error **errp=
)
> =20
>  }
> =20
> +static void process_start_mig_out(MPQemuMsg *msg)
> +{
> +    int wait =3D msg->fds[1];
> +    Error *err =3D NULL;
> +    QIOChannel *ioc;
> +    QEMUFile *f;
> +
> +    ioc =3D qio_channel_new_fd(msg->fds[0], &err);
> +    if (err) {
> +        error_report_err(err);
> +        return;
> +    }
> +
> +    qio_channel_set_name(QIO_CHANNEL(ioc), "remote-migration-channel");
> +
> +    f =3D qemu_fopen_channel_output(ioc);
> +
> +    bdrv_drain_all();
> +    (void)bdrv_flush_all();

Do remote process always have block code? I mean can't we have a remote
process that's just say a NIC ?

> +    (void)qemu_remote_savevm(f);

It's probably bad to ignore errors here; what you could do is if there's
an error, you shoul dprint something and then send a poison value back
to the QEMU to let it know that you've failed.

> +    qemu_fflush(f);
> +
> +    notify_proxy(wait, (uint64_t)qemu_ftell(f));
> +    PUT_REMOTE_WAIT(wait);
> +
> +    qemu_fclose(f);
> +}
> +
>  static void process_msg(GIOCondition cond, MPQemuChannel *chan)
>  {
>      MPQemuMsg *msg =3D NULL;
> @@ -411,6 +451,9 @@ static void process_msg(GIOCondition cond, MPQemuChan=
nel *chan)
>              notify_proxy(msg->fds[0], 0);
>          }
>          break;
> +    case START_MIG_OUT:
> +        process_start_mig_out(msg);
> +        break;
>      default:
>          error_setg(&err, "Unknown command");
>          goto finalize_loop;
> --=20
> 1.8.3.1

--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


