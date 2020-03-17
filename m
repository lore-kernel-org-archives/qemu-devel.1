Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 334F6C5ACD7
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 20:36:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F3E7720714
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 20:36:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iJpWztH4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3E7720714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41058 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEIxF-0006iA-68
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 16:36:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53156)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jEIwX-0006JO-99
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 16:36:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1jEIwW-0003cL-1U
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 16:36:05 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:44470)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1jEIwV-0003Wi-Tk
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 16:36:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584477363;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qRjw6/ZuXFkJQKPsdq1mTnZqZIVNPB7nbxH+cV0VxTI=;
 b=iJpWztH4k6iM0e4z8NRgjhkLDhDojglCif8RN2p4zw54n9y+Q2UA5yMu6JLTURP0Wyx5aw
 OBsmndbwrqeeQ8pjKfC/M1VN5J712+hnabZ4vPOX6V+0TT0ZEmuBMdxBTrT92/6O+Sqti5
 OmNpF8V5SRQunuhhN4i40HSkgI238Qw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-42-v25_jyPSNNao45FVVfCqZw-1; Tue, 17 Mar 2020 16:36:00 -0400
X-MC-Unique: v25_jyPSNNao45FVVfCqZw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BF62C1084455;
 Tue, 17 Mar 2020 20:35:58 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-130.ams2.redhat.com
 [10.36.112.130])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 60EBC90812;
 Tue, 17 Mar 2020 20:35:58 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id C1A8F1138404; Tue, 17 Mar 2020 21:35:56 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH v2 2/2] net: Track netdevs in NetClientState rather than
 QemuOpt
References: <20200317201711.322764-1-eblake@redhat.com>
 <20200317201711.322764-3-eblake@redhat.com>
Date: Tue, 17 Mar 2020 21:35:56 +0100
In-Reply-To: <20200317201711.322764-3-eblake@redhat.com> (Eric Blake's message
 of "Tue, 17 Mar 2020 15:17:11 -0500")
Message-ID: <87h7ymk9cj.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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
Cc: lekiravi@yandex-team.ru, jasowang@redhat.com, qemu-devel@nongnu.org,
 dgilbert@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Eric Blake <eblake@redhat.com> writes:

> As mentioned in the previous patch, our use of QemuOpt group "netdev"
> has two purposes: collect the CLI arguments, and serve as a witness
> for monitor hotplug actions.  As the latter didn't use anything but an
> id, it felt rather unclean to have to touch QemuOpts at all when going
> through QMP, so let's instead track things with a bool field in
> NetClientState.
>
> Suggested-by: Markus Armbruster <armbru@redhat.com>
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
>  include/net/net.h |  1 +
>  monitor/misc.c    |  4 +---
>  net/net.c         | 37 +++++++++++--------------------------
>  3 files changed, 13 insertions(+), 29 deletions(-)
>
> diff --git a/include/net/net.h b/include/net/net.h
> index 96e6eae8176e..094e966af9ec 100644
> --- a/include/net/net.h
> +++ b/include/net/net.h
> @@ -98,6 +98,7 @@ struct NetClientState {
>      unsigned rxfilter_notify_enabled:1;
>      int vring_enable;
>      int vnet_hdr_len;
> +    bool is_netdev;
>      QTAILQ_HEAD(, NetFilterState) filters;
>  };
>
> diff --git a/monitor/misc.c b/monitor/misc.c
> index 41a86e7012a1..6c45fa490ff5 100644
> --- a/monitor/misc.c
> +++ b/monitor/misc.c
> @@ -2035,13 +2035,11 @@ void netdev_del_completion(ReadLineState *rs, int=
 nb_args, const char *str)
>      count =3D qemu_find_net_clients_except(NULL, ncs, NET_CLIENT_DRIVER_=
NIC,
>                                           MAX_QUEUE_NUM);
>      for (i =3D 0; i < MIN(count, MAX_QUEUE_NUM); i++) {
> -        QemuOpts *opts;
>          const char *name =3D ncs[i]->name;
>          if (strncmp(str, name, len)) {
>              continue;
>          }
> -        opts =3D qemu_opts_find(qemu_find_opts_err("netdev", NULL), name=
);
> -        if (opts) {
> +        if (ncs[i]->is_netdev) {
>              readline_add_completion(rs, name);
>          }
>      }
> diff --git a/net/net.c b/net/net.c
> index a2065aabede2..38778e831da2 100644
> --- a/net/net.c
> +++ b/net/net.c
> @@ -1060,6 +1060,15 @@ static int net_client_init1(const void *object, bo=
ol is_netdev, Error **errp)
>          }
>          return -1;
>      }
> +
> +    if (is_netdev) {
> +        NetClientState *nc;
> +
> +        nc =3D qemu_find_netdev(netdev->id);
> +        assert(nc);
> +        nc->is_netdev =3D true;
> +    }
> +
>      return 0;
>  }
>

Would be simpler if net_client_init_fun[]() returned the NetClientState.
But that's clearly more than we can get done today.

> @@ -1172,34 +1181,12 @@ void netdev_add(QemuOpts *opts, Error **errp)
>
>  void qmp_netdev_add(Netdev *netdev, Error **errp)
>  {
> -    Error *local_err =3D NULL;
> -    QemuOptsList *opts_list;
> -    QemuOpts *opts;
> -
> -    opts_list =3D qemu_find_opts_err("netdev", &local_err);
> -    if (local_err) {
> -        goto out;
> -    }
> -
> -    opts =3D qemu_opts_create(opts_list, netdev->id, 1, &local_err);
> -    if (local_err) {
> -        goto out;
> -    }
> -
> -    net_client_init1(netdev, true, &local_err);
> -    if (local_err) {
> -        qemu_opts_del(opts);
> -        goto out;
> -    }
> -
> -out:
> -    error_propagate(errp, local_err);
> +    net_client_init1(netdev, true, errp);
>  }

Nice!

>
>  void qmp_netdev_del(const char *id, Error **errp)
>  {
>      NetClientState *nc;
> -    QemuOpts *opts;
>
>      nc =3D qemu_find_netdev(id);
>      if (!nc) {
> @@ -1208,14 +1195,12 @@ void qmp_netdev_del(const char *id, Error **errp)
>          return;
>      }
>
> -    opts =3D qemu_opts_find(qemu_find_opts_err("netdev", NULL), id);
> -    if (!opts) {
> +    if (!nc->is_netdev) {
>          error_setg(errp, "Device '%s' is not a netdev", id);
>          return;
>      }
>
>      qemu_del_net_client(nc);
> -    qemu_opts_del(opts);
>  }
>
>  static void netfilter_print_info(Monitor *mon, NetFilterState *nf)

Reviewed-by: Markus Armbruster <armbru@redhat.com>


