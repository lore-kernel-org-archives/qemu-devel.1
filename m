Return-Path: <SRS0=EqPw=EE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3896FC55178
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 19:39:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 411D620796
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 19:39:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R1iLJVqt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 411D620796
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52772 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kYDm5-00016n-UX
	for qemu-devel@archiver.kernel.org; Thu, 29 Oct 2020 15:39:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42734)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1kYDlC-0000et-SM
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 15:38:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:48222)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1kYDlA-0005TD-Qv
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 15:38:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604000335;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=khBYKwNFNh4jhZjHa9Ppb+VjF7YqxYckeI2L85TFt7Y=;
 b=R1iLJVqtydwYOObr5yoM2CkPQSoqnhvKMom0+o2HJptRu4T2lMDXnGbhDq/BDgieSLcD3p
 bud3TrKjtn5wRuKZPXOBFGgmecgYEFbWXQttMUMAcz+j9WoVFKW16N2Se/J050mPm913F3
 kM5qmN2G9L8dMQfGGFN7Wq9rF+g7+RA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-467-tN9ddE-sOuaEwCdABu6jQg-1; Thu, 29 Oct 2020 15:38:52 -0400
X-MC-Unique: tN9ddE-sOuaEwCdABu6jQg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9F7E5190A41F;
 Thu, 29 Oct 2020 19:38:38 +0000 (UTC)
Received: from [10.3.112.145] (ovpn-112-145.phx2.redhat.com [10.3.112.145])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0561A60CCC;
 Thu, 29 Oct 2020 19:38:37 +0000 (UTC)
Subject: Re: [PATCH 08/11] sockets: Fix socket_sockaddr_to_address_unix() for
 abstract sockets
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20201029133833.3450220-1-armbru@redhat.com>
 <20201029133833.3450220-9-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <a30d57a6-2188-12fa-a1e5-e0c015e8f970@redhat.com>
Date: Thu, 29 Oct 2020 14:38:37 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201029133833.3450220-9-armbru@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=eblake@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/29 00:47:54
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.261, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
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
> support" neglected to update socket_sockaddr_to_address_unix().  The
> function returns a non-abstract socket address for abstract
> sockets (wrong) with a null @path (also wrong; a non-optional QAPI str
> member must never be null).
> 
> The null @path is due to confused code going back all the way to
> commit 17c55decec "sockets: add helpers for creating SocketAddress
> from a socket".
> 
> Add the required special case, and simplify the confused code.
> 
> Fixes: 776b97d3605ed0fc94443048fdf988c7725e38a9
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  util/qemu-sockets.c | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/util/qemu-sockets.c b/util/qemu-sockets.c
> index c802d5aa0a..801c5e3957 100644
> --- a/util/qemu-sockets.c
> +++ b/util/qemu-sockets.c
> @@ -1264,10 +1264,20 @@ socket_sockaddr_to_address_unix(struct sockaddr_storage *sa,
>  
>      addr = g_new0(SocketAddress, 1);
>      addr->type = SOCKET_ADDRESS_TYPE_UNIX;
> -    if (su->sun_path[0]) {
> -        addr->u.q_unix.path = g_strndup(su->sun_path, sizeof(su->sun_path));
> +#ifdef CONFIG_LINUX
> +    if (!su->sun_path[0]) {
> +        /* Linux abstract socket */
> +        addr->u.q_unix.path = g_strndup(su->sun_path + 1,
> +                                        sizeof(su->sun_path) - 1);
> +        addr->u.q_unix.has_abstract = true;
> +        addr->u.q_unix.abstract = true;
> +        addr->u.q_unix.has_tight = true;
> +        addr->u.q_unix.tight = !su->sun_path[sizeof(su->sun_path) - 1];

This is questionable - how can you tell from the last byte whether the
name was created as tight or not?

> +        return addr;
>      }
> +#endif
>  
> +    addr->u.q_unix.path = g_strdup(su->sun_path);

This is wrong on at least Linux, where su->sun_path need not be
NUL-terminated (allowing file-system Unix sockets to have one more byte
in their name); you need the strndup that you replaced above, in order
avoid reading beyond the end of the array.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


