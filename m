Return-Path: <SRS0=IEfc=4J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB53DC35646
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 13:07:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A75C32073A
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 13:07:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a2+CpXnR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A75C32073A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56788 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j581N-00060G-R7
	for qemu-devel@archiver.kernel.org; Fri, 21 Feb 2020 08:07:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56115)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1j580n-0005Uc-1W
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 08:06:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1j580m-0001Rz-3O
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 08:06:32 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:35177
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1j580l-0001Rn-Vr
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 08:06:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582290391;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6oloexiJP1nW3zyjudqbh590kp97Lih1IZhdsUxlerw=;
 b=a2+CpXnRZduzILdA/EdcFQf5Wic39q0vJm3mER3e408l4iXTBvmp4XtLL40GFASo4RAXEm
 aBlpelq+NqpjKTEyCfvJuSOuAd7PbtGZ5LoTIbSGfUteNa7d1uIa/vJEMLPRtN9setG0ge
 ZQYouqzJHvRAcsMpzNz85O71qd/CyNQ=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-297-2lKHwCDgP1-5poTpUgOQRg-1; Fri, 21 Feb 2020 08:06:29 -0500
X-MC-Unique: 2lKHwCDgP1-5poTpUgOQRg-1
Received: by mail-wr1-f70.google.com with SMTP id s13so982838wrb.21
 for <qemu-devel@nongnu.org>; Fri, 21 Feb 2020 05:06:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=LN16A1JR1h1LPQmNXlvB2zaapJeu++hOFHgo38e1o+E=;
 b=IGk6YnKCKIvvZIO+6giCkxsV7PuDJVk+9h7Q/8o2q9uDL/1PFwBVSXRfN9ifLALIi1
 CIsSpfln0HoNJb57BgY+L1/QENcA2D43Wi+mvYVcbLHuUIa8av0yMLsEQ1GZVmGOGpXL
 h2ssLSC6aBu2BFDgINBuLYcTQlZp02rMo0fdQ2CKAvVd4VAR4MkCajtUeXI3g/9T/496
 gbEFmCV6MTf3ANzSwGkrfTUiyWqxQO+l7YaxFhkdbSQGvuUZBIDAyWw8c/T3vPjxHZwq
 wXlerClQIPoLABhf+tU33v4LKXr11BBz7QMvr0mY3gKGhNEo16tyXk45ZZt863QzsCW3
 fA7w==
X-Gm-Message-State: APjAAAVVL+OBkySr9D19kBPcOqeczhIjEny6a5z2rL/2cgfaUoYtsh7D
 m1ePCfzk1AFJ5h9/Vo+0LtWzpXO/KkOWB8D9VwcGjgp5b2g8h22y3DnYyQqkh6+Hw3ILgT1bG7o
 xzM66ZT6RXvZv2LE=
X-Received: by 2002:a7b:cd92:: with SMTP id y18mr3921703wmj.133.1582290388731; 
 Fri, 21 Feb 2020 05:06:28 -0800 (PST)
X-Google-Smtp-Source: APXvYqxb5y1m6GS75VROutn2CL+lyuTGJRkfk7JIM2WfD7XXTBxbX2ERsiwpwF17y0HyHuud751U1g==
X-Received: by 2002:a7b:cd92:: with SMTP id y18mr3921636wmj.133.1582290388062; 
 Fri, 21 Feb 2020 05:06:28 -0800 (PST)
Received: from [192.168.178.40] ([151.20.135.128])
 by smtp.gmail.com with ESMTPSA id l15sm3889376wrv.39.2020.02.21.05.06.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 21 Feb 2020 05:06:27 -0800 (PST)
Subject: Re: [PATCH 5/5] aio-posix: make AioHandler dispatch O(1) with epoll
To: Stefan Hajnoczi <stefanha@gmail.com>
References: <20200214171712.541358-1-stefanha@redhat.com>
 <20200214171712.541358-6-stefanha@redhat.com>
 <38c8e61b-377b-07bd-f55b-a1a773b72701@redhat.com>
 <20200221125948.GI1484511@stefanha-x1.localdomain>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <425318ef-0b19-983b-b2ea-93754c48cb8d@redhat.com>
Date: Fri, 21 Feb 2020 14:06:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20200221125948.GI1484511@stefanha-x1.localdomain>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 21/02/20 13:59, Stefan Hajnoczi wrote:
> 1. It doesn't crash if the node is currently not on a list.
> 2. It clears the node's linked list pointers so that future linked
>    list operations (like QLIST_SAFE_REMOVE()) aren't accidentally
>    performed on stale pointers.
>
> The node has a long lifespan and will be inserted into ready_lists
> multiple times.  We need to safely remove it from ready_list to protect
> against a corruption the next time the node is inserted into a
> ready_list again:

Ah, so the one I singled out is for (2) (we know the node is currently
on a list), while the one below is for (1).  Would it make sense to move
(2) to Q*_REMOVE_*?  We can do it separately after this pull request.

>   /* Add a handler to a ready list */
>   static void add_ready_handler(AioHandlerList *ready_list,
>                                 AioHandler *node,
>                                 int revents)
>   {
>       QLIST_SAFE_REMOVE(node, node_ready); /* remove from nested parent's=
 list */
>       ^---- would cause corruption if node->node_ready was stale!
>=20
> Would you like me to add a comment?
No, it's okay.

Paolo


