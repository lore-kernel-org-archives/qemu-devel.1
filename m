Return-Path: <SRS0=EqPw=EE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C0D9C2D0A3
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 19:42:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7341B20738
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 19:42:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EKruVaZo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7341B20738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54930 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kYDol-0002Cd-D7
	for qemu-devel@archiver.kernel.org; Thu, 29 Oct 2020 15:42:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43124)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1kYDnf-0001jp-RU
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 15:41:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:21026)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1kYDnd-00063U-QN
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 15:41:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604000488;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=J+D6BXsk0GHyNLUuEVSClzWHrwR9awJ9GUzpswVPLXY=;
 b=EKruVaZoj/2arMux+WXnHzHQa/Rzk46AHy1ycrIxPSIvThNU3dT3C+tk6A7Jn7Ppa/6rts
 oDz1sxzUnoWOIeIv/T3Q5QjMKko8SNKlRYM0aUTKzn7JMCAxir/Tsz8HA2L6UJGOUOgAQ8
 zInRUbeEBRG/6AqjJmV0fhS552VO9IM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-510-k399QtziOEqUDK-NISWlHQ-1; Thu, 29 Oct 2020 15:41:17 -0400
X-MC-Unique: k399QtziOEqUDK-NISWlHQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 852D418BA29A;
 Thu, 29 Oct 2020 19:41:12 +0000 (UTC)
Received: from [10.3.112.145] (ovpn-112-145.phx2.redhat.com [10.3.112.145])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D180D75121;
 Thu, 29 Oct 2020 19:41:11 +0000 (UTC)
Subject: Re: [PATCH 09/11] char-socket: Fix qemu_chr_socket_address() for
 abstract sockets
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20201029133833.3450220-1-armbru@redhat.com>
 <20201029133833.3450220-10-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <c95ba994-8753-8240-9c3c-8cd14f21729a@redhat.com>
Date: Thu, 29 Oct 2020 14:41:11 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201029133833.3450220-10-armbru@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=eblake@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
> Commit 776b97d360 "qemu-sockets: add abstract UNIX domain socket
> support" neglected to update qemu_chr_socket_address().  It shows
> shows neither @abstract nor @tight.  Fix that.
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  chardev/char-socket.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 

> +++ b/chardev/char-socket.c
> @@ -443,10 +443,18 @@ static char *qemu_chr_socket_address(SocketChardev *s, const char *prefix)
>                                 s->is_listen ? ",server" : "");
>          break;
>      case SOCKET_ADDRESS_TYPE_UNIX:
> -        return g_strdup_printf("%sunix:%s%s", prefix,
> +    {
> +        UnixSocketAddress *sa = &s->addr->u.q_unix;
> +
> +        return g_strdup_printf("%sunix:%s%s%s%s", prefix,
>                                 s->addr->u.q_unix.path,
> +                               sa->has_abstract && sa->abstract
> +                               ? ",abstract" : "",
> +                               sa->has_tight && sa->tight
> +                               ? ",tight" : "",

Why are we appending ',tight' when it is not abstract?  tight only makes
a difference for abstract sockets, so omitting it for normal sockets
makes more sense.

Or put another way, why are we using 2 bools to represent three sensible
states, instead of a single 3-state enum?

>                                 s->is_listen ? ",server" : "");
>          break;
> +    }
>      case SOCKET_ADDRESS_TYPE_FD:
>          return g_strdup_printf("%sfd:%s%s", prefix, s->addr->u.fd.str,
>                                 s->is_listen ? ",server" : "");
> 

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


