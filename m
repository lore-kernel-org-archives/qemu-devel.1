Return-Path: <SRS0=EqPw=EE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0AAEC2D0A3
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 19:35:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 29913206DD
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 19:35:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Il4ialQN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29913206DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46790 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kYDiB-0006ou-NL
	for qemu-devel@archiver.kernel.org; Thu, 29 Oct 2020 15:35:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41574)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1kYDgj-0006Gj-2H
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 15:34:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:40926)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1kYDgg-0004kJ-MG
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 15:34:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604000057;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iKc+alC3GNHOWzVdJKy+wpkubdPFO4Hbe58+ItSQHk4=;
 b=Il4ialQNa+3ZMrZt1AMJ2GvvV4V4W7Tmotbx28aKGYCeb4QOXAoJOcrAQLAdLsNqp3Q6qu
 aIXYHx11bVQX1I7grtK2E6RWi4IyebpscM57NoiQQAYXfJAIA0CtlW2x3lZ445XBNTS7pz
 Gzbq5ZYvA+BY00Fr8U5fuQkwvej51AI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-288-AD3dRRcyP72ApUPa4BRRfQ-1; Thu, 29 Oct 2020 15:34:15 -0400
X-MC-Unique: AD3dRRcyP72ApUPa4BRRfQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 894E287950B;
 Thu, 29 Oct 2020 19:34:14 +0000 (UTC)
Received: from [10.3.112.145] (ovpn-112-145.phx2.redhat.com [10.3.112.145])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1F73155772;
 Thu, 29 Oct 2020 19:34:08 +0000 (UTC)
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20201029133833.3450220-1-armbru@redhat.com>
 <20201029133833.3450220-8-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Subject: Re: [PATCH 07/11] sockets: Fix default of UnixSocketAddress member
 @tight
Message-ID: <388cd3a5-9f7f-79e0-b9ad-f5be86e4661d@redhat.com>
Date: Thu, 29 Oct 2020 14:34:07 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201029133833.3450220-8-armbru@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
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
> QMP chardev-add defaults absent member @tight to false instead of
> true.  HMP chardev-add and CLI -chardev correctly default to true.
> 
> The previous commit demonstrated that socket_listen() and
> socket_connect() are broken for absent @tight.  That explains why QMP
> is broken, but not why HMP and CLI work.  We need to dig deeper.
> 
> An optional bool member of a QAPI struct can be false, true, or
> absent.  In C, we have:
> 
> 	    has_MEMBER    MEMBER
>     false         true	   false
>     true	  true	   false
>     absent	 false	false/ignore

I'm not sure the TAB in this table made it very legible (it's hard to
tell if has_MEMBER is the label of column 1 or 2).

Row two is wrong: MEMBER (column 3) is set to true when the QMP code
passed true on the wire.

> 
> When has_MEMBER is false, MEMBER should be set to false on write, and
> ignored on read.
> 
> unix_listen_saddr() and unix_connect_saddr() use member @tight without
> checking @has_tight.  This is wrong.

It generally works if addr was constructed by the same way as the
generated QAPI parser code - but as you demonstrated, in this particular
case, because our construction did not obey the rules of the QAPI
parser, our lack of checking bit us.

> 
> When @tight was set to false as it should be, absent @tight defaults
> to false.  Wrong, it should default to true.  This is what breaks QMP.
> 
> There is one exception: qemu_chr_parse_socket() leaves @has_tight
> false when it sets @tight.  Wrong, but the wrongs cancel out.  This is
> why HMP and CLI work.  Same for @has_abstract.
> 
> Fix unix_listen_saddr() and unix_connect_saddr() to default absent
> @tight to true.
> 
> Fix qemu_chr_parse_socket() to set @has_tight and @has_abstract.

At any rate, the fix looks correct:
- as producers, anywhere we hand-construct an addr (rather than using
generated QAPI code), we MUST set both has_MEMBER and MEMBER, including
setting MEMBER to false if has_MEMBER is false, if we want to preserve
the assumptions made in the rest of the code;
- as consumers, rather than relying on the QAPI parsers only setting
MEMBER to true when has_MEMBER is true, we can ensure that has_MEMBER
has priority by checking it ourselves

> +++ b/util/qemu-sockets.c
> @@ -919,7 +919,7 @@ static int unix_listen_saddr(UnixSocketAddress *saddr,
>      if (saddr->abstract) {
>          un.sun_path[0] = '\0';
>          memcpy(&un.sun_path[1], path, pathlen);
> -        if (saddr->tight) {
> +        if (!saddr->has_tight || saddr->tight) {
>              addrlen = offsetof(struct sockaddr_un, sun_path) + 1 + pathlen;
>          }
>      } else {
> @@ -979,7 +979,7 @@ static int unix_connect_saddr(UnixSocketAddress *saddr, Error **errp)
>      if (saddr->abstract) {
>          un.sun_path[0] = '\0';
>          memcpy(&un.sun_path[1], saddr->path, pathlen);
> -        if (saddr->tight) {
> +        if (!saddr->has_tight || saddr->tight) {
>              addrlen = offsetof(struct sockaddr_un, sun_path) + 1 + pathlen;
>          }
>      } else {
> 

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


