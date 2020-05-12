Return-Path: <SRS0=ZOtl=62=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8A2FC54E90
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 08:58:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 98BE7206F5
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 08:58:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FYHZIWd4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98BE7206F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36402 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYQkL-0007JP-Na
	for qemu-devel@archiver.kernel.org; Tue, 12 May 2020 04:58:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37184)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jYQij-0004xt-Cu
 for qemu-devel@nongnu.org; Tue, 12 May 2020 04:57:01 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:49280
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jYQii-0004Xt-Ii
 for qemu-devel@nongnu.org; Tue, 12 May 2020 04:57:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589273819;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=C+R749a7P6PNscUKBxJlfUO6Bziw4gm5s7gmjk1uVuI=;
 b=FYHZIWd4zdiUzFUICFZV5N9RUO0kw/sx+hKRkk8iXXhfYUOowtarSdqy7Ch/aYXykgE9h1
 ig5PsO/FWg2A55l6/rI2kFtGHi8MYN9FvmBp9Fnvrc7uUZsZ3T79Y7WYvCZRDlBQnfwEoJ
 KR5GURVWmCw4y9wUUiH3K7Jpmj72Hhc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-439-CfezvmpVPL69F_ZmyrtKNA-1; Tue, 12 May 2020 04:56:56 -0400
X-MC-Unique: CfezvmpVPL69F_ZmyrtKNA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E2024107ACCA;
 Tue, 12 May 2020 08:56:54 +0000 (UTC)
Received: from redhat.com (unknown [10.36.110.71])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9A30D5D9DD;
 Tue, 12 May 2020 08:56:48 +0000 (UTC)
Date: Tue, 12 May 2020 09:56:45 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Lukas Straub <lukasstraub2@web.de>
Subject: Re: [PATCH 4/5] chardev/char-socket.c: Add yank feature
Message-ID: <20200512085645.GF1191162@redhat.com>
References: <cover.1589193717.git.lukasstraub2@web.de>
 <7f87fcd9be3cedfe0410c151de2bf4e5d907b1e2.1589193717.git.lukasstraub2@web.de>
MIME-Version: 1.0
In-Reply-To: <7f87fcd9be3cedfe0410c151de2bf4e5d907b1e2.1589193717.git.lukasstraub2@web.de>
User-Agent: Mutt/1.13.4 (2020-02-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=berrange@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/12 02:20:15
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FROM_EXCESS_BASE64=0.979, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block <qemu-block@nongnu.org>,
 Juan Quintela <quintela@redhat.com>, qemu-devel <qemu-devel@nongnu.org>,
 Max Reitz <mreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, May 11, 2020 at 01:14:47PM +0200, Lukas Straub wrote:
> Add yank option which is passed to the socket-channel.
> 
> Signed-off-by: Lukas Straub <lukasstraub2@web.de>
> ---
>  chardev/char-socket.c | 8 ++++++++
>  chardev/char.c        | 3 +++
>  qapi/char.json        | 5 ++++-
>  3 files changed, 15 insertions(+), 1 deletion(-)
> 
> diff --git a/chardev/char-socket.c b/chardev/char-socket.c
> index 185fe38dda..e476358941 100644
> --- a/chardev/char-socket.c
> +++ b/chardev/char-socket.c
> @@ -65,6 +65,7 @@ typedef struct {
>      int max_size;
>      int do_telnetopt;
>      int do_nodelay;
> +    int do_yank;
>      int *read_msgfds;
>      size_t read_msgfds_num;
>      int *write_msgfds;
> @@ -877,6 +878,9 @@ static int tcp_chr_new_client(Chardev *chr, QIOChannelSocket *sioc)
>      if (s->do_nodelay) {
>          qio_channel_set_delay(s->ioc, false);
>      }
> +    if (s->do_yank) {
> +        qio_channel_set_yank(s->ioc, true);
> +    }

This should call yank_register_function() to  register a local
callback, which then invokes qio_channel_shutdown() upon acting,
avoiding the need to add this qio_channel_set_yank method.

Likewise for the migration code in the next patch.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


