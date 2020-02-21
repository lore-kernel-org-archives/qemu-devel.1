Return-Path: <SRS0=IEfc=4J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39705C35656
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 15:05:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0636D24653
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 15:05:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eMgWfl7O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0636D24653
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59424 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j59rX-0002aY-4h
	for qemu-devel@archiver.kernel.org; Fri, 21 Feb 2020 10:05:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58816)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1j59qn-00024i-Nw
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 10:04:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1j59qm-0006M4-P7
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 10:04:21 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:34492
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1j59qm-0006Ls-M4
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 10:04:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582297460;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VEi8OFWf5uemwFjAgEsb1nIKUMvdrfw2VI/npCHYtao=;
 b=eMgWfl7OAh3duD+wu9Nlh7YK0c+p60iQIEYGxc1DvkwbSH0w1SyH4/9A/aVtOmBcVNLhuJ
 D/nppi9PM1PqwbTLl39T48oL/lUOWGP4LUO1m9QRgoFWtMqJp7tRMhUun26TGAAJwv4ueO
 rFQ5j9cuv8w5RL/GI+JFA25K+ChMrGE=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-86-zkTV39IwPk6pNni0IMwsBw-1; Fri, 21 Feb 2020 10:04:18 -0500
X-MC-Unique: zkTV39IwPk6pNni0IMwsBw-1
Received: by mail-wm1-f71.google.com with SMTP id n17so728425wmk.1
 for <qemu-devel@nongnu.org>; Fri, 21 Feb 2020 07:04:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=EeZrYfmR89oT7JfVbifJ3RrrJ96G/ouqaVVUbvUfjas=;
 b=oz+ndA8xZhgwvOTJ2YmvFAqwoKzrqM7002ZnpT4b4735ErAOriopIWxu8+mbuwi0Nq
 BicdTylSS6VRw/fK2zixL0kK4JJhaY1xFvW+4D/sTxRsdwjmNjlTPkHTEKS93Zb/0Os1
 J10gL8ssCYXYCEN2cgF/bc9Z9iu2njGUbEpY0E3+a8r54ui0JrL8TKfMOqW+GtOL8TwZ
 8QDrg0XH4ux2QROe6VtlZjGE5HGaPwCl8DgE4PbS2aeQsrZt9UNMdod/44JJ1x94oEuc
 y0Ro0Z0hadNQW3lqXDGQePJXU7wOSDIQeVv3QsffopGOwVkVsK2SpdhyjIkw03niQwE3
 0C3w==
X-Gm-Message-State: APjAAAUFTOZ3m1qZK65lA9H/bppINWUt/MsadnjAQQ+Lkpgy3G0O7IsP
 haW30HIAyVYjrejiDZVN4bq6zNRSsVoAyLvV/UcoUweVdc45jU61Vj32ZsUg0nxrHYNzrxVOB/s
 F5akyooLzAw7GYqE=
X-Received: by 2002:a1c:e388:: with SMTP id a130mr4322422wmh.176.1582297454819; 
 Fri, 21 Feb 2020 07:04:14 -0800 (PST)
X-Google-Smtp-Source: APXvYqwLMHC3OO8kjPsf+bXRpt6jklzm7TV2HRhn4JIHCB2q6gwbT2F1MjzfSeJL7Ba970S5KfOK4A==
X-Received: by 2002:a1c:e388:: with SMTP id a130mr4322391wmh.176.1582297454539; 
 Fri, 21 Feb 2020 07:04:14 -0800 (PST)
Received: from [192.168.178.40] ([151.20.135.128])
 by smtp.gmail.com with ESMTPSA id k13sm4329380wrx.59.2020.02.21.07.04.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 21 Feb 2020 07:04:13 -0800 (PST)
Subject: Re: [PATCH 5/5] aio-posix: make AioHandler dispatch O(1) with epoll
To: Stefan Hajnoczi <stefanha@redhat.com>
References: <20200214171712.541358-1-stefanha@redhat.com>
 <20200214171712.541358-6-stefanha@redhat.com>
 <38c8e61b-377b-07bd-f55b-a1a773b72701@redhat.com>
 <20200221125948.GI1484511@stefanha-x1.localdomain>
 <425318ef-0b19-983b-b2ea-93754c48cb8d@redhat.com>
 <20200221144708.GD1501077@stefanha-x1.localdomain>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <607d1b80-f66f-6519-b3e5-af48e1a65900@redhat.com>
Date: Fri, 21 Feb 2020 16:04:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20200221144708.GD1501077@stefanha-x1.localdomain>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
 qemu-block@nongnu.org, Stefan Hajnoczi <stefanha@gmail.com>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 21/02/20 15:47, Stefan Hajnoczi wrote:
>>>       QLIST_SAFE_REMOVE(node, node_ready); /* remove from nested parent=
's list */
>>>       ^---- would cause corruption if node->node_ready was stale!
>>>
>>> Would you like me to add a comment?
>> No, it's okay.
> Are you happy with this series?

Yes.  Let's keep the Q*_REMOVE cleanup on the todo list.  I'd keep
Q*_SAFE_REMOVE, but clear the pointer unconditionally in Q*_REMOVE so
that we can have something like Q*_IN_LIST too.

> Shall I include it in my next pull request or do you want to merge it?

No, it's yours.

Paolo


