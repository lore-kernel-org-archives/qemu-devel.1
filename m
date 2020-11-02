Return-Path: <SRS0=N3Ri=EI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FDCDC388F2
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2020 14:14:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C8BCA21D91
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2020 14:14:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NQa6Az9v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8BCA21D91
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52794 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZab1-0006rx-Tf
	for qemu-devel@archiver.kernel.org; Mon, 02 Nov 2020 09:14:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35264)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1kZaaB-0006QZ-6g
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 09:13:15 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:32158)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1kZaa9-0002dX-GA
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 09:13:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604326392;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=27VoN9y1Lkbu2WQW+R/IOuCroT5K0E1P4/9HzWMeXjQ=;
 b=NQa6Az9vAu9Vx5canl2a9pOGhzYYHxlQ4vTZcgKf9XK/C4BCiYrO2l90hNgOpGFIp30YjK
 I9C8Uk8mI3KSAtnEfwFaYaQP+QnTmfQjnc0hgn3uIfzFhan52h9iH44dRN78v6DRV5Tf4d
 9Vqx2/iFG+dOCyoUK1ZOk0RnuZyTIOY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-27-G6G569FRMsOyhzMCBq7vwg-1; Mon, 02 Nov 2020 09:13:10 -0500
X-MC-Unique: G6G569FRMsOyhzMCBq7vwg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 282CC802B60;
 Mon,  2 Nov 2020 14:13:09 +0000 (UTC)
Received: from [10.3.113.41] (ovpn-113-41.phx2.redhat.com [10.3.113.41])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C3C6119C78;
 Mon,  2 Nov 2020 14:12:57 +0000 (UTC)
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20201102094422.173975-1-armbru@redhat.com>
 <20201102094422.173975-12-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Subject: Re: [PATCH v2 11/11] sockets: Make abstract UnixSocketAddress depend
 on CONFIG_LINUX
Message-ID: <e98fe4e1-b641-97ef-e697-11281d085c04@redhat.com>
Date: Mon, 2 Nov 2020 08:12:57 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201102094422.173975-12-armbru@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=eblake@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/02 01:33:03
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
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

Commit message lacks mention of the fact that we are now explicitly not
outputting 'strict' for non-abstract sockets (in fact, that change could
be squashed in 9/11 if you wanted to do it there).  But as this cleans
up the code I mentioned in 9/11, I'll leave it up to Dan if the commit
message needs a tweak; the end result is fine if we don't feel like a v3
spin just for moving hunks around.

Reviewed-by: Eric Blake <eblake@redhat.com>

> +++ b/chardev/char-socket.c
> @@ -444,14 +444,20 @@ static char *qemu_chr_socket_address(SocketChardev *s, const char *prefix)
>          break;
>      case SOCKET_ADDRESS_TYPE_UNIX:
>      {
> +        const char *tight = "", *abstract = "";
>          UnixSocketAddress *sa = &s->addr->u.q_unix;
>  
> -        return g_strdup_printf("%sunix:%s%s%s%s", prefix,
> -                               s->addr->u.q_unix.path,
> -                               sa->has_abstract && sa->abstract
> -                               ? ",abstract" : "",
> -                               sa->has_tight && sa->tight
> -                               ? ",tight" : "",

Unconditional output if tight is true (which is its stated default)...

> +#ifdef CONFIG_LINUX
> +        if (sa->has_abstract && sa->abstract) {
> +            abstract = ",abstract";
> +            if (sa->has_tight && sa->tight) {
> +                tight = ",tight";
> +            }
> +        }
> +#endif
> +
> +        return g_strdup_printf("%sunix:%s%s%s%s", prefix, sa->path,
> +                               abstract, tight,

...vs. the now-nicer conditional where tight is only present if abstract.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


