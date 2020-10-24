Return-Path: <SRS0=SOuJ=D7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4F85C4363A
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Oct 2020 19:56:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 19B6C20BED
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Oct 2020 19:56:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Wx5b2YfH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19B6C20BED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35922 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kWPeb-0003Am-8q
	for qemu-devel@archiver.kernel.org; Sat, 24 Oct 2020 15:56:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58460)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kWPdm-0002dj-ER
 for qemu-devel@nongnu.org; Sat, 24 Oct 2020 15:55:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:44564)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kWPdk-0008Va-UZ
 for qemu-devel@nongnu.org; Sat, 24 Oct 2020 15:55:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603569348;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Z9HMH8hiIeYDpAnGY0zuU/Q9iB+wz9fGZU3XqEGG4yY=;
 b=Wx5b2YfH8qEVOvOYZR9Qzy1gfJxkkejFt7SUmlMW/7EFw1PMb2HenyZKvP8lne9L9EqwKW
 vdcDhtOO95QQANUbia5zGisAHrsqx1v/NGMzhNA1fI1+EOSWB8UP9Eup1M7celQElSrP6f
 VwwplifaSEGe5V7UDR6eQE1i9WOoe/4=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-521-qFgFzDYwOeWpHr63jB6mNA-1; Sat, 24 Oct 2020 15:55:46 -0400
X-MC-Unique: qFgFzDYwOeWpHr63jB6mNA-1
Received: by mail-wm1-f69.google.com with SMTP id c204so2962185wmd.5
 for <qemu-devel@nongnu.org>; Sat, 24 Oct 2020 12:55:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Z9HMH8hiIeYDpAnGY0zuU/Q9iB+wz9fGZU3XqEGG4yY=;
 b=H8xYaUZvzNb+8ScHgJsjlq40lwykFE53ptb68GTHAjKcqY4FQ3t1f12ZRuhbtoXkx1
 wpDZ5L8It9dnc97mkP6tST085D3dpZMH8yKFtTsTxfLitg3zdNjJxKcJ9Wpg7U2dteOQ
 VyTxX6t2SubBWNh8pJR0wOALIBDF4m6VK4fimbPl9pgOioCt8DsDhouZ70izNA6OArO8
 pHiPEjEAKFQEVooyIOn3PXg2fGuPcSytLqmrf2tCmoK+6qVLB7EJy6i+i64CclsCYDxx
 iKhn8R6EV4T/fwBfNhMxHheh/enm3uxIwiBQNI4O3llAKRU+TMAouQjkT8pfAar/G9tj
 5PqA==
X-Gm-Message-State: AOAM533Kf5UE/wMuHrDZjL54G7kNdSLbmv4CCgfb6PRpDthEgUwCXk9k
 NbJw0MCzejPX+Z4YotyKxhL2PRyPrQTzmdUTfZtYpXOATfJmTwD3F6JvCZ8XGaDejO7Nibim77+
 Ne3BVBrs661yNAg0=
X-Received: by 2002:a7b:c081:: with SMTP id r1mr8251970wmh.158.1603569345117; 
 Sat, 24 Oct 2020 12:55:45 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxfhZVJI7GG35p20no0Q0t5qnCq2WIYClLEzfNhyvDfkWRZklWtxKq/HpNA1GHrIemQmVoSpw==
X-Received: by 2002:a7b:c081:: with SMTP id r1mr8251958wmh.158.1603569344948; 
 Sat, 24 Oct 2020 12:55:44 -0700 (PDT)
Received: from [192.168.1.36] (237.red-88-18-140.staticip.rima-tde.net.
 [88.18.140.237])
 by smtp.gmail.com with ESMTPSA id 32sm12909466wro.31.2020.10.24.12.55.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 24 Oct 2020 12:55:44 -0700 (PDT)
Subject: Re: [PATCH 11/15] scripts/qom-fuse: ensure QOMFuse.read always
 returns bytes
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
References: <20201021185208.1611145-1-jsnow@redhat.com>
 <20201021185208.1611145-12-jsnow@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <b815a3ed-4b6f-3634-e263-8c6922811f83@redhat.com>
Date: Sat, 24 Oct 2020 21:55:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201021185208.1611145-12-jsnow@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/24 15:52:22
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.107, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
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
Cc: Cleber Rosa <crosa@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/21/20 8:52 PM, John Snow wrote:
> - Use FuseOSError to signal ENOENT instead of returning it
> - Wrap qom-get in str(), as we don't always know its type
> - The empty return should be b'', not ''.
> 
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>   scripts/qmp/qom-fuse | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>


