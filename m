Return-Path: <SRS0=xv4c=6Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C448CC47255
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 18:02:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 91730206B9
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 18:02:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Tu+bdLIU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91730206B9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43444 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYCkm-0003ex-Md
	for qemu-devel@archiver.kernel.org; Mon, 11 May 2020 14:02:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39148)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jYCjv-0002pD-Kq
 for qemu-devel@nongnu.org; Mon, 11 May 2020 14:01:20 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:25047
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jYCju-0000mS-CS
 for qemu-devel@nongnu.org; Mon, 11 May 2020 14:01:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589220077;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4RKl3gYD9wmG4rBh207QD6ZaVEF9teVydBeY+eA5SV8=;
 b=Tu+bdLIUS+igd0xdozkHZbtPwu6tAl1UjPm2jHq6uj0/chWo0lvvwfj6tSrfI0yv/7WZoB
 4rTQePoFnAHuqs88IqQT1I0g65P9GdSUnfzslvC9EdfDSLGTBIdx+MEjnzbrKiEAkqfmQK
 rlMjwS8SGWup4E0xc8G+w5QcIk9iyfI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-339-nY4VUmtcOp-0XAB2XTcaYA-1; Mon, 11 May 2020 14:01:15 -0400
X-MC-Unique: nY4VUmtcOp-0XAB2XTcaYA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4F0981B18BC6;
 Mon, 11 May 2020 18:01:14 +0000 (UTC)
Received: from [10.3.116.145] (ovpn-116-145.phx2.redhat.com [10.3.116.145])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5813C6C796;
 Mon, 11 May 2020 18:01:07 +0000 (UTC)
Subject: Re: [PATCH v3 1/3] qemu-sockets: add abstract UNIX domain socket
 support
To: xiaoqiang zhao <zxq_yx_007@163.com>, berrange@redhat.com,
 marcandre.lureau@redhat.com, kwolf@redhat.com, armbru@redhat.com
References: <20200510061422.24841-1-zxq_yx_007@163.com>
 <20200510061422.24841-2-zxq_yx_007@163.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <0ead3ac4-efa3-b773-f5c3-7aa055e2af18@redhat.com>
Date: Mon, 11 May 2020 13:01:06 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200510061422.24841-2-zxq_yx_007@163.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=eblake@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/11 02:55:57
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org, kraxel@redhat.com,
 pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/10/20 1:14 AM, xiaoqiang zhao wrote:
> unix_listen/connect_saddr now support abstract address types
> 
> two aditional BOOL switches are introduced:
> tight: whether to set @addrlen to the minimal string length,
>         or the maximum sun_path length. default is TRUE
> abstract: whether we use abstract address. default is FALSE
> 
> cli example:
> -monitor unix:/tmp/unix.socket,abstract,tight=off
> OR
> -chardev socket,path=/tmp/unix.socket,id=unix1,abstract,tight=on
> 
> Signed-off-by: xiaoqiang zhao <zxq_yx_007@163.com>
> ---

> +++ b/qapi/sockets.json
> @@ -73,12 +73,19 @@
>   # Captures a socket address in the local ("Unix socket") namespace.
>   #
>   # @path: filesystem path to use
> +# @tight: pass a socket address length that does not include the whole
> +#         struct sockaddr_un record but (besides other components) only
> +#         the relevant part of the filename or abstract string.
> +#         default value is 'true'

Perhaps:

pass a socket address length confined to the minimum length of the 
abstract string, rather than the full sockaddr_un record length (only 
matters for abstract sockets, default true)

> +# @abstract: whether this is a abstract address, default is 'false'

Both new fields should have a '(since 5.1)' tag, to make it obvious that 
they did not exist in earlier releases with the rest of the struct.

s/a abstract/an abstract/

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


