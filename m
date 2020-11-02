Return-Path: <SRS0=N3Ri=EI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CF3DC00A89
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2020 14:10:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D7A82465D
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2020 14:10:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HJrDuBTW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D7A82465D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47548 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZaXC-0004Pg-Rf
	for qemu-devel@archiver.kernel.org; Mon, 02 Nov 2020 09:10:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34046)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1kZaVl-0003Wq-Rc
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 09:08:41 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:55978)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1kZaVj-0000ww-N5
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 09:08:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604326117;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=u+QuHujvNcGqexpya8GXsOhbfTltABrmjyIgDJsItZU=;
 b=HJrDuBTWDqrAzQiuTmoM9HaS3YXaMfZOSMXur4z3YmerKwAWPzqIU+aWo2k/Pf3LRBeymQ
 a/y8zevHcwaa/Kz5/LqHJNiqanqmm/Kna3TAES24xB8yAqkcXrZGNGVGq4/lduF9u+TcC9
 oigLB4fCdapvqI9LP3MRt/czef4m8TQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-556-0ZMXSFacPvu7z-ZeeeaR-A-1; Mon, 02 Nov 2020 09:08:32 -0500
X-MC-Unique: 0ZMXSFacPvu7z-ZeeeaR-A-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4C80E802B51;
 Mon,  2 Nov 2020 14:08:31 +0000 (UTC)
Received: from [10.3.113.41] (ovpn-113-41.phx2.redhat.com [10.3.113.41])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id DD00921E96;
 Mon,  2 Nov 2020 14:08:24 +0000 (UTC)
Subject: Re: [PATCH v2 09/11] char-socket: Fix qemu_chr_socket_address() for
 abstract sockets
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20201102094422.173975-1-armbru@redhat.com>
 <20201102094422.173975-10-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <9f594cfb-2138-c12d-f6f7-6a4653e78087@redhat.com>
Date: Mon, 2 Nov 2020 08:08:24 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201102094422.173975-10-armbru@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=eblake@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/02 03:02:24
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
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

On 11/2/20 3:44 AM, Markus Armbruster wrote:
> Commit 776b97d360 "qemu-sockets: add abstract UNIX domain socket
> support" neglected to update qemu_chr_socket_address().  It shows
> shows neither @abstract nor @tight.  Fix that.
> 
> Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  chardev/char-socket.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/chardev/char-socket.c b/chardev/char-socket.c
> index 1ee5a8c295..dc1cf86ecf 100644
> --- a/chardev/char-socket.c
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
>                                 s->is_listen ? ",server" : "");

Gets modified again in 11/11, so I can accept this as a strict
improvement, even if it is not the final form.

Reviewed-by: Eric Blake <eblake@redhat.com>

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


