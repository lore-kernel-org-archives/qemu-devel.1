Return-Path: <SRS0=EqPw=EE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18B6CC55178
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 19:55:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6776020825
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 19:55:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AbeYoNiv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6776020825
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34398 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kYE1M-0006HD-Md
	for qemu-devel@archiver.kernel.org; Thu, 29 Oct 2020 15:55:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45392)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1kYE0e-0005r8-8V
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 15:54:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:30622)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1kYE0b-0007cy-FW
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 15:54:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604001291;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+GZezBL9p9/kUmg1vUhDMUQyZljjZZkc9oKX7dqdzKw=;
 b=AbeYoNiv4aFG6xLoVWZJgJ2+LlLZ+uUIUU6MrHwWHNJ1Tk1ILHjNRs5RMVKww96RwB6MNw
 wnQcu2iDIgNRG5KmzJ7zKyFFQ5/zPQnoxPYx7MZtQX3gb8R87Gxp2JUWmZfT3ejJEOvvJE
 DP2TR30XrXYdupqBKki5+Si8H90XB0g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-374-q_LVFiGIMy-f0ZoEpciocA-1; Thu, 29 Oct 2020 15:54:48 -0400
X-MC-Unique: q_LVFiGIMy-f0ZoEpciocA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 457F6802B63;
 Thu, 29 Oct 2020 19:54:46 +0000 (UTC)
Received: from [10.3.112.145] (ovpn-112-145.phx2.redhat.com [10.3.112.145])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8833D60C17;
 Thu, 29 Oct 2020 19:54:39 +0000 (UTC)
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20201029133833.3450220-1-armbru@redhat.com>
 <20201029133833.3450220-12-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Subject: Re: [PATCH 11/11] sockets: Make abstract UnixSocketAddress depend on
 CONFIG_LINUX
Message-ID: <77c4d3b2-44f0-2bf8-feb6-bc760b2b8c46@redhat.com>
Date: Thu, 29 Oct 2020 14:54:38 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201029133833.3450220-12-armbru@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=eblake@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/29 01:47:28
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.261, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: kwolf@redhat.com, berrange@redhat.com, zxq_yx_007@163.com,
 kraxel@redhat.com, pbonzini@redhat.com, marcandre.lureau@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/29/20 8:38 AM, Markus Armbruster wrote:
> The abstract socket namespace is a non-portable Linux extension.  An
> attempt to use it elsewhere should fail with ENOENT (the abstract
> address looks like a "" pathname, which does not resolve).  We report
> this failure like
> 
>     Failed to connect socket abc: No such file or directory
> 
> Tolerable, although ENOTSUP would be better.
> 
> However, introspection lies: it has @abstract regardless of host
> support.  Easy enough to fix: since Linux provides them since 2.2,
> 'if': 'defined(CONFIG_LINUX)' should do.
> 
> The above failure becomes
> 
>     Parameter 'backend.data.addr.data.abstract' is unexpected
> 
> I consider this an improvement.
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---

> +++ b/qapi/sockets.json
> @@ -74,18 +74,20 @@
>  # Captures a socket address in the local ("Unix socket") namespace.
>  #
>  # @path: filesystem path to use
> -# @tight: pass a socket address length confined to the minimum length of the
> -#         abstract string, rather than the full sockaddr_un record length
> -#         (only matters for abstract sockets, default true). (Since 5.1)
> -# @abstract: whether this is an abstract address, default false. (Since 5.1)
> +# @abstract: if true, this is a Linux abstract socket address.  @path
> +#            will be prefixed by a null byte, and optionally padded
> +#            with null bytes.  Defaults to false.  (Since 5.1)
> +# @tight: if false, pad an abstract socket address with enough null
> +#         bytes to make it fill struct sockaddr_un member sun_path.
> +#         Defaults to true.  (Since 5.1)

Do we need to mention that @tight is ignored (or even make it an error)
if @abstract is false?

>  #
>  # Since: 1.3
>  ##
>  { 'struct': 'UnixSocketAddress',
>    'data': {
>      'path': 'str',
> -    '*tight': 'bool',
> -    '*abstract': 'bool' } }
> +    '*tight': { 'type': 'bool', 'if': 'defined(CONFIG_LINUX)' },
> +    '*abstract': { 'type': 'bool', 'if': 'defined(CONFIG_LINUX)' } } }

So we document @abstract before @tight, but declare them in reverse
order.  I guess our doc generator doesn't care?

>  
>  ##
>  # @VsockSocketAddress:
> diff --git a/chardev/char-socket.c b/chardev/char-socket.c
> index dc1cf86ecf..1d2b2efb13 100644
> --- a/chardev/char-socket.c
> +++ b/chardev/char-socket.c
> @@ -444,14 +444,20 @@ static char *qemu_chr_socket_address(SocketChardev *s, const char *prefix)
>          break;
>      case SOCKET_ADDRESS_TYPE_UNIX:
>      {
> +#ifdef CONFIG_LINUX
>          UnixSocketAddress *sa = &s->addr->u.q_unix;
> +#endif
>  
>          return g_strdup_printf("%sunix:%s%s%s%s", prefix,
>                                 s->addr->u.q_unix.path,

Why did we need the #ifdef above, which means we can't we use sa here?

> +#ifdef CONFIG_LINUX
>                                 sa->has_abstract && sa->abstract

I hate mid-()-expression #ifdefs.  If g_strdup_printf() were itself a
macro expansion, things break.  Can you come up with a saner way of
writing this?

>                                 ? ",abstract" : "",
>                                 sa->has_tight && sa->tight
>                                 ? ",tight" : "",
> +#else
> +                               "", "",
> +#endif
>                                 s->is_listen ? ",server" : "");

I suggest:

    const char *tight = "", *abstract = "";
    UnixSocketAddress *sa = &s->addr->u.q_unix;

#ifdef CONFIG_LINUX
    if (sa->has_abstract && sa->abstract) {
        abstract = ",abstract";
        if (sa->has_tight && sa->tight) {
            tight = ",tight";
        }
    }
#endif

    return g_strdup_printf("%sunix:%s%s%s%s", prefix, sa->path,
                           abstract, tight,
                           s->is_listen ? ", server" : "");


> +++ b/util/qemu-sockets.c
> @@ -854,10 +854,29 @@ static int vsock_parse(VsockSocketAddress *addr, const char *str,
>  
>  #ifndef _WIN32
>  
> +static bool saddr_is_abstract(UnixSocketAddress *saddr)
> +{
> +#ifdef CONFIG_LINUX
> +    return saddr->abstract;
> +#else
> +    return false;
> +#endif
> +}
> +
> +static bool saddr_is_tight(UnixSocketAddress *saddr)
> +{
> +#ifdef CONFIG_LINUX
> +    return !saddr->has_tight || saddr->tight;

Should this also look at abstract?

> +#else
> +    return false;
> +#endif
> +}
> +

Is it any easier to split the patch, first into the introduction of
saddr_is_* and adjusting all clients, and second into adding the 'if' to
the QAPI declaration?

But the idea makes sense.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


