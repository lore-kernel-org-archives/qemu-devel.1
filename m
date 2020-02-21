Return-Path: <SRS0=IEfc=4J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53235C35656
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 15:39:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 222FE206E2
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 15:39:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PfxtDyy2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 222FE206E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59968 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j5AOL-0001GA-AU
	for qemu-devel@archiver.kernel.org; Fri, 21 Feb 2020 10:39:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38280)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1j5AMa-0007tM-PQ
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 10:37:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1j5AMY-0002lM-OF
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 10:37:11 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:40042
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1j5AMY-0002gs-KY
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 10:37:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582299428;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SVNC3P661drwryvIJd+QwZEZ4DLuhgafx0Y+uMzImhQ=;
 b=PfxtDyy2FvIvdYmr9VH0+w116GC+haNEkEURgV+TXaU89zoNA0vy/49vag4xQbiWNHKCJ+
 eEZ7nVwj/B8YDMbkEcpO6byuxAHVQwVgQcX52HDiJu2XxO73nKoFL5kjWTjBkgNQwghUFp
 yQcVLbvUZQt+5Rqe4ZbmL+JIZS4YUU4=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-308-slUkpvkjMKuBYimnAeZ9UQ-1; Fri, 21 Feb 2020 10:37:04 -0500
X-MC-Unique: slUkpvkjMKuBYimnAeZ9UQ-1
Received: by mail-wm1-f72.google.com with SMTP id 7so760013wmf.9
 for <qemu-devel@nongnu.org>; Fri, 21 Feb 2020 07:37:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=SVNC3P661drwryvIJd+QwZEZ4DLuhgafx0Y+uMzImhQ=;
 b=QjkUfuMkIgNNSJw57kEpmBOl794gVK4aIDC3vJhRCghQjcHPQwswcwS+Exg4orNJ8n
 26uhwpfXgFCOFghUzgNdCtnIaq6BbBgLfPMZ21MmnR76PLq36tDLE5vrzcmUqbpcs8a5
 B2GFs1LAOAH2dX1c9zv+3JP67383S0n4EyCTIz8fl8ZKMfli2WzQCgwuwtqDMW8W7NBi
 TAnKQo6HJEsLDTjBfh1hAL5UXnZ7ZWxT+vx/rETW8Jcuy5ID8+GqI5ah8PUu3Ir6gwtz
 Vbz/IMp1wEu6DqA6Oqs4KDfPSPBFCwNtk3mZZfvhz4lyX1MKbtmZKioi2rX6o2A+rVW6
 SukA==
X-Gm-Message-State: APjAAAUGYf8jAt7KAJVm7KzEtruHQCnSCYw6hp7JoEZtxTFeSu7URgX5
 ZKTYOGUx/4nZhMxGmlkOJCE+k2k7/izWFrjNbJg1VFAFXkIuErVlvwFu42pZsjOZgZm7ZrJlGp5
 pS3btuHO2I82nCSo=
X-Received: by 2002:a05:600c:21c5:: with SMTP id
 x5mr4649203wmj.72.1582299423271; 
 Fri, 21 Feb 2020 07:37:03 -0800 (PST)
X-Google-Smtp-Source: APXvYqwwpGOZTL+Cm0BL1sqxRiFGwdgw4rmy6ojAIGiSsz7F951SNE/Ur0L8X1Nkm7WgKexA3E2lag==
X-Received: by 2002:a05:600c:21c5:: with SMTP id
 x5mr4649182wmj.72.1582299423003; 
 Fri, 21 Feb 2020 07:37:03 -0800 (PST)
Received: from [192.168.178.40] ([151.20.135.128])
 by smtp.gmail.com with ESMTPSA id p5sm4261514wrt.79.2020.02.21.07.37.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 21 Feb 2020 07:37:02 -0800 (PST)
Subject: Re: [PATCH 5/5] aio-posix: make AioHandler dispatch O(1) with epoll
To: Stefan Hajnoczi <stefanha@redhat.com>
References: <20200214171712.541358-1-stefanha@redhat.com>
 <20200214171712.541358-6-stefanha@redhat.com>
 <38c8e61b-377b-07bd-f55b-a1a773b72701@redhat.com>
 <20200221125948.GI1484511@stefanha-x1.localdomain>
 <425318ef-0b19-983b-b2ea-93754c48cb8d@redhat.com>
 <20200221144708.GD1501077@stefanha-x1.localdomain>
 <607d1b80-f66f-6519-b3e5-af48e1a65900@redhat.com>
 <20200221152902.GC1511783@stefanha-x1.localdomain>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <25842305-feea-d179-3932-d78e834b6d93@redhat.com>
Date: Fri, 21 Feb 2020 16:37:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20200221152902.GC1511783@stefanha-x1.localdomain>
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

On 21/02/20 16:29, Stefan Hajnoczi wrote:
>> Yes.  Let's keep the Q*_REMOVE cleanup on the todo list.  I'd keep
>> Q*_SAFE_REMOVE, but clear the pointer unconditionally in Q*_REMOVE so
>> that we can have something like Q*_IN_LIST too.
> QLIST_IS_INSERTED() is part of this patch series, although I can rename
> it to Q*_IN_LIST() and cover all linked list variants. :)

Yes I meant having it for all variants.  I remembered you adding it but
not the exact spelling!

Paolo


