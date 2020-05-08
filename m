Return-Path: <SRS0=NBT7=6W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66210C38A2A
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 08:00:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 34784206B8
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 08:00:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Sh3zXsTk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34784206B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54656 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWxvZ-00076C-8F
	for qemu-devel@archiver.kernel.org; Fri, 08 May 2020 04:00:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41458)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1jWxuv-0006Yk-22
 for qemu-devel@nongnu.org; Fri, 08 May 2020 03:59:33 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:22339
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1jWxuu-0001FW-Cg
 for qemu-devel@nongnu.org; Fri, 08 May 2020 03:59:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588924771;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hOM4Ta888SHuPswPLoampHjeSqoWZmEtw7z22uOrthw=;
 b=Sh3zXsTkil9PoIn6VBbIz9BF8AtaDIpY96eujrWQ4GFegax8RsFx5ZS5aISO31/CDvm+6A
 hv01uhpGh1it9JsjIFHqFqJSezzTtwtNUAm+0Jo1eOVo7oXexMb46q6y07IFf1X7BABGvb
 +vCTCWVS6ULY4rGsucfIzqiT64Pietg=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-363-JBpmxfnkMO6mj_I89BbO6Q-1; Fri, 08 May 2020 03:59:29 -0400
X-MC-Unique: JBpmxfnkMO6mj_I89BbO6Q-1
Received: by mail-wr1-f71.google.com with SMTP id d1so505107wru.6
 for <qemu-devel@nongnu.org>; Fri, 08 May 2020 00:59:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:in-reply-to:references
 :user-agent:reply-to:date:message-id:mime-version
 :content-transfer-encoding;
 bh=hOM4Ta888SHuPswPLoampHjeSqoWZmEtw7z22uOrthw=;
 b=GFpZ6KnZqXCJBa6DLtJZI9uV0Miyqn5Fom8y18uX6CnnRWBydkHnyq0E0CA++BzbPj
 XOTO3Kxb1tuRAn1FYRXW6fzOLICDNgxVpDopIRf9VK2qANW6ePfdwwT4JLo2amGeLNgF
 ls8QtJ4L5oEstT2c+2nVM2qkP5RSsr0ldz4agHviCGp//H23zDQHsBUgBSCYmAEXZSf2
 dX8vN9+RPkUbjek4POTH1cU9HT9tgNSkB0SUIhlic1JrYxLzK+1kDqEJeGJAc8cPkrKR
 mnYXZaTOrt2SyUZv9aj9B2Ok+jvaKKGGeMp9BPj6fJRgEbEEzsbkZczpIPlBhdL51yGz
 ZOYQ==
X-Gm-Message-State: AGi0PuZ0QUIQ3iIfnncYbASO9Mm33nwArZQNUruORQNiYBETW8tGl6Hk
 ISmiPZ5lqlL3utoAa0nhrEWY+edxx+SruoxA00rUUDf5QwYEjT1L9GG7/ihqfUCnJiNqRYqidl/
 8qYgOj8vYGvbkNmQ=
X-Received: by 2002:a05:600c:2:: with SMTP id g2mr15296010wmc.85.1588924768812; 
 Fri, 08 May 2020 00:59:28 -0700 (PDT)
X-Google-Smtp-Source: APiQypIg39JuLvqmLtGYeDlL88daRIIOSxtOEwlBYmgTj5eyYzQkYL9XnuRwKaEi3dTYNwwm21KHHA==
X-Received: by 2002:a05:600c:2:: with SMTP id g2mr15295977wmc.85.1588924768602; 
 Fri, 08 May 2020 00:59:28 -0700 (PDT)
Received: from localhost (trasno.trasno.org. [83.165.45.250])
 by smtp.gmail.com with ESMTPSA id 89sm1589594wrj.37.2020.05.08.00.59.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 May 2020 00:59:27 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Subject: Re: [PATCH 01/10] exec: Rename qemu_ram_writeback() as
 qemu_ram_msync()
In-Reply-To: <20200507173958.25894-2-philmd@redhat.com> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Thu, 7 May 2020 19:39:49
 +0200")
References: <20200507173958.25894-1-philmd@redhat.com>
 <20200507173958.25894-2-philmd@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
Date: Fri, 08 May 2020 09:59:26 +0200
Message-ID: <87zhaig8m9.fsf@secure.mitica>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.81; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/08 01:34:54
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Reply-To: quintela@redhat.com
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Cornelia Huck <cohuck@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>, qemu-block@nongnu.org,
 David Hildenbrand <david@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org,
 qemu-ppc@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Keith Busch <kbusch@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <rth@twiddle.net>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> wrote:
> Rename qemu_ram_writeback() as qemu_ram_msync() to better
> match what it does.
>
> Suggested-by: Stefan Hajnoczi <stefanha@redhat.com>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Reviewed-by: Juan Quintela <quintela@redhat.com>

if block people preffers that name, who I am to complain.


