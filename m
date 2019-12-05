Return-Path: <SRS0=YrRb=Z3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D737DC43603
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2019 16:05:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A0776206DB
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2019 16:05:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bEEfuVw7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0776206DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56882 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ictcw-0000FT-9Y
	for qemu-devel@archiver.kernel.org; Thu, 05 Dec 2019 11:05:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46505)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1ictaz-00079r-Ke
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 11:03:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1ictaw-0001Xh-5A
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 11:03:11 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:32564
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1ictav-0001Sb-Kd
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 11:03:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575561786;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sjfgfU4XfQn+FQO3l6qj0TWjL1bRfQ1DJHT/UWIzPKE=;
 b=bEEfuVw7Sd6JLOrHHDRCFSrHYP02WHKVbECUTU7sWsPjB4aglhNjT+zgT0TXmuwDby48Ce
 DUtY+X2Nm4MUeVu8EEITCwtoY7Rjj0U+cwmhwCt0oc6H2vb9ZnQseaQ/4lUDKHh46DFUXI
 9yzdVoVZBVJd7+l9mi8dQpNvulB08U4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-403-BWxlG8gHPw-7QvNZWr418A-1; Thu, 05 Dec 2019 11:03:03 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 37F98802775;
 Thu,  5 Dec 2019 16:03:02 +0000 (UTC)
Received: from work-vm (unknown [10.36.118.4])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B65B810013D9;
 Thu,  5 Dec 2019 16:02:57 +0000 (UTC)
Date: Thu, 5 Dec 2019 16:02:54 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH] net: Remove deprecated [hub_id name] tuple of
 'hostfwd_add' / 'hostfwd_remove'
Message-ID: <20191205160254.GK2824@work-vm>
References: <20191205104109.18680-1-thuth@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20191205104109.18680-1-thuth@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: BWxlG8gHPw-7QvNZWr418A-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: libvir-list@redhat.com, Samuel Thibault <samuel.thibault@ens-lyon.org>,
 Jason Wang <jasowang@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Thomas Huth (thuth@redhat.com) wrote:
> It's been deprecated since QEMU v3.1.0. Time to finally remove it now.
>=20
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  hmp-commands.hx      |  8 ++++----
>  net/hub.c            | 23 -----------------------
>  net/hub.h            |  2 --
>  net/slirp.c          | 44 ++++++++++++--------------------------------
>  qemu-deprecated.texi | 13 ++++++++-----
>  5 files changed, 24 insertions(+), 66 deletions(-)
>=20
> diff --git a/hmp-commands.hx b/hmp-commands.hx
> index cfcc044ce4..14ccc685d7 100644
> --- a/hmp-commands.hx
> +++ b/hmp-commands.hx
> @@ -1463,8 +1463,8 @@ ETEXI
>  #ifdef CONFIG_SLIRP
>      {
>          .name       =3D "hostfwd_add",
> -        .args_type  =3D "arg1:s,arg2:s?,arg3:s?",
> -        .params     =3D "[hub_id name]|[netdev_id] [tcp|udp]:[hostaddr]:=
hostport-[guestaddr]:guestport",
> +        .args_type  =3D "arg1:s,arg2:s?",
> +        .params     =3D "[netdev_id] [tcp|udp]:[hostaddr]:hostport-[gues=
taddr]:guestport",
>          .help       =3D "redirect TCP or UDP connections from host to gu=
est (requires -net user)",
>          .cmd        =3D hmp_hostfwd_add,
>      },
> @@ -1478,8 +1478,8 @@ ETEXI
>  #ifdef CONFIG_SLIRP
>      {
>          .name       =3D "hostfwd_remove",
> -        .args_type  =3D "arg1:s,arg2:s?,arg3:s?",
> -        .params     =3D "[hub_id name]|[netdev_id] [tcp|udp]:[hostaddr]:=
hostport",
> +        .args_type  =3D "arg1:s,arg2:s?",
> +        .params     =3D "[netdev_id] [tcp|udp]:[hostaddr]:hostport",
>          .help       =3D "remove host-to-guest TCP or UDP redirection",
>          .cmd        =3D hmp_hostfwd_remove,
>      },

for HMP:

Acked-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

> diff --git a/net/hub.c b/net/hub.c
> index 5795a678ed..88cfb876f3 100644
> --- a/net/hub.c
> +++ b/net/hub.c
> @@ -193,29 +193,6 @@ NetClientState *net_hub_add_port(int hub_id, const c=
har *name,
>      return &port->nc;
>  }
> =20
> -/**
> - * Find a specific client on a hub
> - */
> -NetClientState *net_hub_find_client_by_name(int hub_id, const char *name=
)
> -{
> -    NetHub *hub;
> -    NetHubPort *port;
> -    NetClientState *peer;
> -
> -    QLIST_FOREACH(hub, &hubs, next) {
> -        if (hub->id =3D=3D hub_id) {
> -            QLIST_FOREACH(port, &hub->ports, next) {
> -                peer =3D port->nc.peer;
> -
> -                if (peer && strcmp(peer->name, name) =3D=3D 0) {
> -                    return peer;
> -                }
> -            }
> -        }
> -    }
> -    return NULL;
> -}
> -
>  /**
>   * Find a available port on a hub; otherwise create one new port
>   */
> diff --git a/net/hub.h b/net/hub.h
> index 66d3322fac..ce45f7b399 100644
> --- a/net/hub.h
> +++ b/net/hub.h
> @@ -15,10 +15,8 @@
>  #ifndef NET_HUB_H
>  #define NET_HUB_H
> =20
> -
>  NetClientState *net_hub_add_port(int hub_id, const char *name,
>                                   NetClientState *hubpeer);
> -NetClientState *net_hub_find_client_by_name(int hub_id, const char *name=
);
>  void net_hub_info(Monitor *mon);
>  void net_hub_check_clients(void);
>  bool net_hub_flush(NetClientState *nc);
> diff --git a/net/slirp.c b/net/slirp.c
> index c4334ee876..77042e6df7 100644
> --- a/net/slirp.c
> +++ b/net/slirp.c
> @@ -610,25 +610,13 @@ error:
>      return -1;
>  }
> =20
> -static SlirpState *slirp_lookup(Monitor *mon, const char *hub_id,
> -                                const char *name)
> +static SlirpState *slirp_lookup(Monitor *mon, const char *id)
>  {
> -    if (name) {
> -        NetClientState *nc;
> -        if (hub_id) {
> -            nc =3D net_hub_find_client_by_name(strtol(hub_id, NULL, 0), =
name);
> -            if (!nc) {
> -                monitor_printf(mon, "unrecognized (hub-id, stackname) pa=
ir\n");
> -                return NULL;
> -            }
> -            warn_report("Using 'hub-id' is deprecated, specify the netde=
v id "
> -                        "directly instead");
> -        } else {
> -            nc =3D qemu_find_netdev(name);
> -            if (!nc) {
> -                monitor_printf(mon, "unrecognized netdev id '%s'\n", nam=
e);
> -                return NULL;
> -            }
> +    if (id) {
> +        NetClientState *nc =3D qemu_find_netdev(id);
> +        if (!nc) {
> +            monitor_printf(mon, "unrecognized netdev id '%s'\n", id);
> +            return NULL;
>          }
>          if (strcmp(nc->model, "user")) {
>              monitor_printf(mon, "invalid device specified\n");
> @@ -655,16 +643,12 @@ void hmp_hostfwd_remove(Monitor *mon, const QDict *=
qdict)
>      int err;
>      const char *arg1 =3D qdict_get_str(qdict, "arg1");
>      const char *arg2 =3D qdict_get_try_str(qdict, "arg2");
> -    const char *arg3 =3D qdict_get_try_str(qdict, "arg3");
> =20
> -    if (arg3) {
> -        s =3D slirp_lookup(mon, arg1, arg2);
> -        src_str =3D arg3;
> -    } else if (arg2) {
> -        s =3D slirp_lookup(mon, NULL, arg1);
> +    if (arg2) {
> +        s =3D slirp_lookup(mon, arg1);
>          src_str =3D arg2;
>      } else {
> -        s =3D slirp_lookup(mon, NULL, NULL);
> +        s =3D slirp_lookup(mon, NULL);
>          src_str =3D arg1;
>      }
>      if (!s) {
> @@ -784,16 +768,12 @@ void hmp_hostfwd_add(Monitor *mon, const QDict *qdi=
ct)
>      SlirpState *s;
>      const char *arg1 =3D qdict_get_str(qdict, "arg1");
>      const char *arg2 =3D qdict_get_try_str(qdict, "arg2");
> -    const char *arg3 =3D qdict_get_try_str(qdict, "arg3");
> =20
> -    if (arg3) {
> -        s =3D slirp_lookup(mon, arg1, arg2);
> -        redir_str =3D arg3;
> -    } else if (arg2) {
> -        s =3D slirp_lookup(mon, NULL, arg1);
> +    if (arg2) {
> +        s =3D slirp_lookup(mon, arg1);
>          redir_str =3D arg2;
>      } else {
> -        s =3D slirp_lookup(mon, NULL, NULL);
> +        s =3D slirp_lookup(mon, NULL);
>          redir_str =3D arg1;
>      }
>      if (s) {
> diff --git a/qemu-deprecated.texi b/qemu-deprecated.texi
> index 66d2b22a94..e407cc085e 100644
> --- a/qemu-deprecated.texi
> +++ b/qemu-deprecated.texi
> @@ -206,11 +206,6 @@ the 'wait' field, which is only applicable to socket=
s in server mode
> =20
>  @section Human Monitor Protocol (HMP) commands
> =20
> -@subsection The hub_id parameter of 'hostfwd_add' / 'hostfwd_remove' (si=
nce 3.1)
> -
> -The @option{[hub_id name]} parameter tuple of the 'hostfwd_add' and
> -'hostfwd_remove' HMP commands has been replaced by @option{netdev_id}.
> -
>  @subsection cpu-add (since 4.0)
> =20
>  Use ``device_add'' for hotplugging vCPUs instead of ``cpu-add''.  See
> @@ -376,6 +371,14 @@ What follows is a record of recently removed, former=
ly deprecated
>  features that serves as a record for users who have encountered
>  trouble after a recent upgrade.
> =20
> +@section Human Monitor Protocol (HMP) commands
> +
> +@subsection The hub_id parameter of 'hostfwd_add' / 'hostfwd_remove' (re=
moved in 5.0)
> +
> +The @option{[hub_id name]} parameter tuple of the 'hostfwd_add' and
> +'hostfwd_remove' HMP commands has been replaced by the single option
> +@option{netdev_id}.
> +
>  @section QEMU Machine Protocol (QMP) commands
> =20
>  @subsection block-dirty-bitmap-add "autoload" parameter (since 4.2.0)
> --=20
> 2.18.1
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


