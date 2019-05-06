Return-Path: <SRS0=msIk=TG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E56CC04A6B
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2019 13:25:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 11BF4206A3
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2019 13:25:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11BF4206A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:56568 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hNdc3-0000oK-61
	for qemu-devel@archiver.kernel.org; Mon, 06 May 2019 09:24:59 -0400
Received: from eggs.gnu.org ([209.51.188.92]:35192)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hNdaK-00086U-Av
	for qemu-devel@nongnu.org; Mon, 06 May 2019 09:23:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hNdaJ-0003Id-9J
	for qemu-devel@nongnu.org; Mon, 06 May 2019 09:23:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46700)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hNdaJ-0003GI-1E
	for qemu-devel@nongnu.org; Mon, 06 May 2019 09:23:11 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id EEAD63082E60;
	Mon,  6 May 2019 13:23:09 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-28.ams2.redhat.com
	[10.36.116.28])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id BC55E60C43;
	Mon,  6 May 2019 13:23:09 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
	id 382A01132B35; Mon,  6 May 2019 15:23:08 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Stefano Garzarella <sgarzare@redhat.com>
References: <20190503170631.228487-1-sgarzare@redhat.com>
Date: Mon, 06 May 2019 15:23:08 +0200
In-Reply-To: <20190503170631.228487-1-sgarzare@redhat.com> (Stefano
	Garzarella's message of "Fri, 3 May 2019 19:06:31 +0200")
Message-ID: <878svjra2r.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.46]);
	Mon, 06 May 2019 13:23:10 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH] net: avoid to use variable length array in
 net_client_init()
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowang@redhat.com>,
	qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Stefano Garzarella <sgarzare@redhat.com> writes:

> net_client_init() uses a variable length array to store the prefix
> of 'ipv6-net' parameter (e.g. if ipv6-net=fec0::0/64, the prefix
> is 'fec0::0').
> Since the IPv6 prefix can be at most as long as an IPv6 address,
> we can use an array with fixed size equals to INET6_ADDRSTRLEN.
>
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> ---
>  net/net.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/net/net.c b/net/net.c
> index f3a3c5444c..2e5f27e121 100644
> --- a/net/net.c
> +++ b/net/net.c
> @@ -1118,7 +1118,7 @@ static int net_client_init(QemuOpts *opts, bool is_netdev, Error **errp)
>          const char *ip6_net = qemu_opt_get(opts, "ipv6-net");
>  
>          if (ip6_net) {
> -            char buf[strlen(ip6_net) + 1];
> +            char buf[INET6_ADDRSTRLEN];
>  
>              if (get_str_sep(buf, sizeof(buf), &ip6_net, '/') < 0) {
>                  /* Default 64bit prefix length.  */

Hmm.

Parameter "ipv6-net" is of the form ADDRESS[/PREFIX-SIZE].  If
/PREFIX-SIZE is present, get_str_sep() copies the ADDRESS part to buf[].

However, nothing stops the user from passing in an ADDRESS longer than
INET6_ADDRSTRLEN, say by adding a enough leading zeros.  get_str_sep()
will then silently truncate ADDRESS.

Suggest to avoid get_str_sep() like this (not even compile-tested):

        if (ip6_net) {
            char *slashp = strchr(ip6_net, '/');

            if (!slashp) {
                /* Default 64bit prefix length.  */
                qemu_opt_set(opts, "ipv6-prefix", ip6_net, &error_abort);
                qemu_opt_set_number(opts, "ipv6-prefixlen", 64, &error_abort);
            } else {
                /* User-specified prefix length.  */
                unsigned long len;
                int err;
                char *addr = g_strndup(ip6_net, slashp - ip6_net);

                qemu_opt_set(opts, "ipv6-prefix", addr, &error_abort);
                g_free(addr);
                err = qemu_strtoul(slashp + 1, NULL, 10, &len);
                if (err) {
                    error_setg(errp, QERR_INVALID_PARAMETER_VALUE,
                              "ipv6-prefix", "a number");
                } else {
                    qemu_opt_set_number(opts, "ipv6-prefixlen", len,
                                        &error_abort);
                }
            }
            qemu_opt_unset(opts, "ipv6-net");
        }
    }

I'd be tempted to clean up further; de-duplicate the qemu_opt_set() and
qemu_opt_set_number().

There's just one more use of get_str_sep(), in parse_host_port(), and it
looks just as prone to silent truncation.

