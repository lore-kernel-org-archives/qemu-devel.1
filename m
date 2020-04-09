Return-Path: <SRS0=qpXq=5Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 111FCC2BA19
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2020 18:01:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D3A9F20757
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2020 18:01:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Is79zlfs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3A9F20757
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53618 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jMbUW-0003xw-V3
	for qemu-devel@archiver.kernel.org; Thu, 09 Apr 2020 14:01:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43325)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1jMbTX-0003Ic-Nj
 for qemu-devel@nongnu.org; Thu, 09 Apr 2020 14:00:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1jMbTW-0000Y0-6x
 for qemu-devel@nongnu.org; Thu, 09 Apr 2020 14:00:27 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:41369
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1jMbTV-0000We-Lt
 for qemu-devel@nongnu.org; Thu, 09 Apr 2020 14:00:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586455224;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=flivfQm3PJ+cwSZlCPRYfDWehSVBjanFQVk+oLoifcA=;
 b=Is79zlfs4i5jCvu2LqBvOnvLaiHsljJBt+Yr4b6fIYOOCTyco0fWLdu6cd85nSAYoFTcnb
 AEHsfnKppLLVB/Cypy2nnoiDO13IV2GYuqAEcZYtN+GmPVvbz+S6dWsNeD2se+3ZMfMk0T
 e/E+V5TyU+ahM0PE+KiBMSbUaUYdoPs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-204-55peSwTbNOuDTgKD28ZHBQ-1; Thu, 09 Apr 2020 14:00:20 -0400
X-MC-Unique: 55peSwTbNOuDTgKD28ZHBQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 39C0B107ACC4;
 Thu,  9 Apr 2020 18:00:18 +0000 (UTC)
Received: from work-vm (ovpn-114-117.ams2.redhat.com [10.36.114.117])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7D03B9B905;
 Thu,  9 Apr 2020 18:00:05 +0000 (UTC)
Date: Thu, 9 Apr 2020 19:00:02 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: elena.ufimtseva@oracle.com
Subject: Re: [PATCH v6 16/36] multi-process: remote process initialization
Message-ID: <20200409180002.GG3065@work-vm>
References: <cover.1586165555.git.elena.ufimtseva@oracle.com>
 <73241ca8e613a00d89f86d214bf586cad658a616.1586165556.git.elena.ufimtseva@oracle.com>
MIME-Version: 1.0
In-Reply-To: <73241ca8e613a00d89f86d214bf586cad658a616.1586165556.git.elena.ufimtseva@oracle.com>
User-Agent: Mutt/1.13.4 (2020-02-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
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
Cc: fam@euphon.net, john.g.johnson@oracle.com, swapnil.ingle@nutanix.com,
 mst@redhat.com, qemu-devel@nongnu.org, kraxel@redhat.com, jag.raman@oracle.com,
 quintela@redhat.com, armbru@redhat.com, kanth.ghatraju@oracle.com,
 felipe@nutanix.com, thuth@redhat.com, ehabkost@redhat.com,
 konrad.wilk@oracle.com, liran.alon@oracle.com, stefanha@redhat.com,
 thanos.makatos@nutanix.com, rth@twiddle.net, kwolf@redhat.com,
 berrange@redhat.com, mreitz@redhat.com, ross.lagerwall@citrix.com,
 marcandre.lureau@gmail.com, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* elena.ufimtseva@oracle.com (elena.ufimtseva@oracle.com) wrote:
> From: Jagannathan Raman <jag.raman@oracle.com>
>=20
> Adds the handler to process message from QEMU,
> Initialize remote process main loop, handles SYNC_SYSMEM
> message by updating its "system_memory" container using
> shared file descriptors received from QEMU.
>=20
> Signed-off-by: John G Johnson <john.g.johnson@oracle.com>
> Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
> Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
> ---
>  remote/remote-main.c | 87 ++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 87 insertions(+)
>=20
> diff --git a/remote/remote-main.c b/remote/remote-main.c
> index ecf30e0cba..51595f3141 100644
> --- a/remote/remote-main.c
> +++ b/remote/remote-main.c
> @@ -12,6 +12,7 @@
>  #include "qemu-common.h"
> =20
>  #include <stdio.h>
> +#include <unistd.h>
> =20
>  #include "qemu/module.h"
>  #include "remote/pcihost.h"
> @@ -19,12 +20,98 @@
>  #include "hw/boards.h"
>  #include "hw/qdev-core.h"
>  #include "qemu/main-loop.h"
> +#include "remote/memory.h"
> +#include "io/mpqemu-link.h"
> +#include "qapi/error.h"
> +#include "qemu/main-loop.h"
> +#include "sysemu/cpus.h"
> +#include "qemu-common.h"
> +#include "hw/pci/pci.h"
> +#include "qemu/thread.h"
> +#include "qemu/main-loop.h"
> +#include "qemu/config-file.h"
> +#include "sysemu/sysemu.h"
> +#include "block/block.h"
> +#include "exec/ramlist.h"
> +
> +static MPQemuLinkState *mpqemu_link;
> +
> +static void process_msg(GIOCondition cond, MPQemuLinkState *link,
> +                        MPQemuChannel *chan)
> +{
> +    MPQemuMsg *msg =3D NULL;
> +    Error *err =3D NULL;
> +
> +    if ((cond & G_IO_HUP) || (cond & G_IO_ERR)) {
> +        goto finalize_loop;
> +    }
> +
> +    msg =3D g_malloc0(sizeof(MPQemuMsg));
> +
> +    if (mpqemu_msg_recv(msg, chan) < 0) {
> +        error_setg(&err, "Failed to receive message");
> +        goto finalize_loop;
> +    }
> +
> +    switch (msg->cmd) {
> +    case INIT:
> +        break;
> +    default:
> +        error_setg(&err, "Unknown command");

Again this doesn't seem to have changed since my 4th March review where
I asked for better error messages.

Dave

> +        goto finalize_loop;
> +    }
> +
> +    g_free(msg->data2);
> +    g_free(msg);
> +
> +    return;
> +
> +finalize_loop:
> +    if (err) {
> +        error_report_err(err);
> +    }
> +    g_free(msg);
> +    mpqemu_link_finalize(mpqemu_link);
> +    mpqemu_link =3D NULL;
> +}
> =20
>  int main(int argc, char *argv[])
>  {
> +    Error *err =3D NULL;
> +
>      module_call_init(MODULE_INIT_QOM);
> =20
> +    bdrv_init_with_whitelist();
> +
> +    if (qemu_init_main_loop(&err)) {
> +        error_report_err(err);
> +        return -EBUSY;
> +    }
> +
> +    qemu_init_cpu_loop();
> +
> +    page_size_init();
> +
> +    qemu_mutex_init(&ram_list.mutex);
> +
>      current_machine =3D MACHINE(REMOTE_MACHINE(object_new(TYPE_REMOTE_MA=
CHINE)));
> =20
> +    mpqemu_link =3D mpqemu_link_create();
> +    if (!mpqemu_link) {
> +        printf("Could not create MPQemu link\n");
> +        return -1;
> +    }
> +
> +    mpqemu_init_channel(mpqemu_link, &mpqemu_link->com, STDIN_FILENO);
> +
> +    mpqemu_link_set_callback(mpqemu_link, process_msg);
> +
> +    qdev_machine_creation_done();
> +    qemu_mutex_lock_iothread();
> +    qemu_run_machine_init_done_notifiers();
> +    qemu_mutex_unlock_iothread();
> +
> +    mpqemu_start_coms(mpqemu_link, mpqemu_link->com);
> +
>      return 0;
>  }
> --=20
> 2.25.GIT
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


