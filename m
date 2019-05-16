Return-Path: <SRS0=H6GY=TQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5573DC04AB4
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2019 08:47:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C7E620881
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2019 08:47:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C7E620881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:50752 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hRC38-0007S3-8K
	for qemu-devel@archiver.kernel.org; Thu, 16 May 2019 04:47:38 -0400
Received: from eggs.gnu.org ([209.51.188.92]:34759)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hRC1e-0006Xu-MW
	for qemu-devel@nongnu.org; Thu, 16 May 2019 04:46:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hRC01-0002W2-Lw
	for qemu-devel@nongnu.org; Thu, 16 May 2019 04:44:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:32946)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hRC01-0002U3-Dc
	for qemu-devel@nongnu.org; Thu, 16 May 2019 04:44:25 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 78EAD307D9D0
	for <qemu-devel@nongnu.org>; Thu, 16 May 2019 08:44:23 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-28.ams2.redhat.com
	[10.36.116.28])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id BEB771001DC5;
	Thu, 16 May 2019 08:44:21 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
	id 1D79B11385E4; Thu, 16 May 2019 10:44:20 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Stefano Garzarella <sgarzare@redhat.com>
References: <20190509130345.227526-1-sgarzare@redhat.com>
	<20190509130345.227526-3-sgarzare@redhat.com>
Date: Thu, 16 May 2019 10:44:20 +0200
In-Reply-To: <20190509130345.227526-3-sgarzare@redhat.com> (Stefano
	Garzarella's message of "Thu, 9 May 2019 15:03:43 +0200")
Message-ID: <877eaqvlej.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.48]);
	Thu, 16 May 2019 08:44:23 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2 2/4] net: avoid using variable length
 array in net_client_init()
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Jason Wang <jasowang@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Stefano Garzarella <sgarzare@redhat.com> writes:

> net_client_init() uses a variable length array to store the prefix
> of 'ipv6-net' parameter (e.g. if ipv6-net=fec0::0/64, the prefix
> is 'fec0::0').
> This patch introduces g_strsplit() to split the 'ipv6-net' parameter,
> so we can remove the variable length array.
>
> Suggested-by: Markus Armbruster <armbru@redhat.com>
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> ---
>  net/net.c | 33 +++++++++++++++++++++------------
>  1 file changed, 21 insertions(+), 12 deletions(-)
>
> diff --git a/net/net.c b/net/net.c
> index d5071e49e2..932fa5abb5 100644
> --- a/net/net.c
> +++ b/net/net.c
> @@ -1118,29 +1118,38 @@ static int net_client_init(QemuOpts *opts, bool is_netdev, Error **errp)
>          const char *ip6_net = qemu_opt_get(opts, "ipv6-net");
>  
>          if (ip6_net) {
> -            char buf[strlen(ip6_net) + 1];
> +            gchar **substrings;
> +            char *prefix_addr;
> +            unsigned long prefix_len = 64; /* Default 64bit prefix length. */
>  
> -            if (get_str_sep(buf, sizeof(buf), &ip6_net, '/') < 0) {
> -                /* Default 64bit prefix length.  */
> -                qemu_opt_set(opts, "ipv6-prefix", ip6_net, &error_abort);
> -                qemu_opt_set_number(opts, "ipv6-prefixlen", 64, &error_abort);
> -            } else {
> +            substrings = g_strsplit(ip6_net, "/", 2);
> +            if (!substrings || !substrings[0]) {
> +                    error_setg(errp, QERR_INVALID_PARAMETER_VALUE,
> +                               "ipv6-net", "a valid IPv6 prefix");
> +                    g_strfreev(substrings);
> +                    goto out;

Indentation's off.

> +            }
> +
> +            *prefix_addr = substrings[0];
> +
> +            if (substrings[1]) {
>                  /* User-specified prefix length.  */
> -                unsigned long len;
>                  int err;
>  
> -                qemu_opt_set(opts, "ipv6-prefix", buf, &error_abort);
> -                err = qemu_strtoul(ip6_net, NULL, 10, &len);
> -
> +                err = qemu_strtoul(substrings[1], NULL, 10, &prefix_len);
>                  if (err) {
>                      error_setg(errp, QERR_INVALID_PARAMETER_VALUE,
>                                 "ipv6-prefixlen", "a number");
> +                    g_strfreev(substrings);
>                      goto out;

Two g_strfreev() before goto out.  Avoidable: declare substrings at the
function level, initialize to NULL, then call g_strfreev(substrings) ...

>                  }
> -
> -                qemu_opt_set_number(opts, "ipv6-prefixlen", len, &error_abort);
>              }
> +
> +            qemu_opt_set(opts, "ipv6-prefix", prefix_addr, &error_abort);
> +            qemu_opt_set_number(opts, "ipv6-prefixlen", prefix_len,
> +                                &error_abort);
>              qemu_opt_unset(opts, "ipv6-net");
> +            g_strfreev(substrings);
>          }
>      }

       if (is_netdev) {
           visit_type_Netdev(v, NULL, (Netdev **)&object, &err);
       } else {
           visit_type_NetLegacy(v, NULL, (NetLegacy **)&object, &err);
       }

       if (!err) {
           ret = net_client_init1(object, is_netdev, &err);
       }

       if (is_netdev) {
           qapi_free_Netdev(object);
       } else {
           qapi_free_NetLegacy(object);
       }

   out:
       error_propagate(errp, err);

... here.  Your choice.

       visit_free(v);
       return ret;
   }

With at least the indentation fixed:
Reviewed-by: Markus Armbruster <armbru@redhat.com>


Not this patch's problem: when visit_type_FOO() fails with an input
visitor such as @v, you should not call qapi_free_FOO().  Nothing bad
happens when you do, it's just sloppy.  See visitor.h's big comment for
details.

Cleaner:

       if (is_netdev) {
           visit_type_Netdev(v, NULL, (Netdev **)&object, &err);
       } else {
           visit_type_NetLegacy(v, NULL, (NetLegacy **)&object, &err);
       }
       if (err) {
           goto out;
       }

       ret = net_client_init1(object, is_netdev, &err);

       if (is_netdev) {
           qapi_free_Netdev(object);
       } else {
           qapi_free_NetLegacy(object);
       }

   out:

Or maybe:

       if (is_netdev) {
           visit_type_Netdev(v, NULL, &netdev, &err);
           if (err) {
               goto out;
           }
           ret = net_client_init1(netdev, is_netdev, &err);
           qapi_free_Netdev(netdev);
       } else {
           visit_type_NetLegacy(v, NULL, &netlegacy, &err);
           if (err) {
               goto out;
           }
           ret = net_client_init1(netlegacy, is_netdev, &err);
           qapi_free_NetLegacy(netlegacy);
       }

   out:

with

       Netdev *netdev;
       NetLegacy *netlegacy;

replacing @object.

Or one step further: observe net_client_init() is always called with a
compile-time constant second argument.  Split it into two functions,
factor the common part into a helper.

