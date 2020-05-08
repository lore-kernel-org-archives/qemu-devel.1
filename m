Return-Path: <SRS0=NBT7=6W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70506C38A2A
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 08:08:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 41FF6207DD
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 08:08:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bZ8/5+ua"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41FF6207DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40048 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWy3E-00065K-Cu
	for qemu-devel@archiver.kernel.org; Fri, 08 May 2020 04:08:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43042)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1jWy2Q-0004vM-CU
 for qemu-devel@nongnu.org; Fri, 08 May 2020 04:07:18 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:56324
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1jWy2O-0005zq-LM
 for qemu-devel@nongnu.org; Fri, 08 May 2020 04:07:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588925235;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0I/uHFHnYyaNQP5ochKQASdEv3ZMFZI9WL9B0uIJt8w=;
 b=bZ8/5+uaaZ9ol9IOol7iAbz11rb2FonKGdvaEVEUrStITrh/p/BbkSl9rSY6FZRQ6vwtcg
 Wb1UGYnx9mjsQDeHn7a9a3wM3vUAVWAlOMpAZRg3W+C7mUAmIv5P4gKLNPlSE8lmezmwCI
 kAmaJkj82dcz/gqgFtcGVIvn5UjtPgc=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-316-uV1DJXgVOeqzeCNRfuyLTQ-1; Fri, 08 May 2020 04:07:14 -0400
X-MC-Unique: uV1DJXgVOeqzeCNRfuyLTQ-1
Received: by mail-wr1-f69.google.com with SMTP id u4so509748wrm.13
 for <qemu-devel@nongnu.org>; Fri, 08 May 2020 01:07:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:in-reply-to:references
 :user-agent:reply-to:date:message-id:mime-version
 :content-transfer-encoding;
 bh=j0eeTCMwrd7MbEygnBFECWdWogDY0IK/sUKAtJtUlvY=;
 b=YmQkZgcKUIGUrfz3q7oG8vDUjpxO+Pp6jrdJvj0oE9v2ShY/BW188EyzV+CmkUQMxF
 ohW2vn8GIpTudF5TaJcK1i+xy8BAsXRnLZ/p4CNQT3Zuyl3ZabcH3WtbFzBwYDQFQqTs
 9QVdTXhWjOF3iZyhrv6r77idsTgLEVrEMBZmHG3YXCQ7dTosYKN2aXg2TWbrhiM6jxuB
 4Uz2tRxG9NQx/+J9euwHmbeQZKwWHo73M6WHot+e9qH/Ozu0FgfNHpkYHiwl+JRIzsH2
 0ML54apAmGRTgeY9KaH+4NygLWU15VnRNXw3F+q9+tmWZkP+2ZrxmtTMYkAS+NmpK4uE
 EYUg==
X-Gm-Message-State: AGi0PuYdYMqaoA1WZ3k0FsyV9oblKKdJudzKCnLFQVTT2lvJ+R5AnVO4
 fPoZjdo4nKPgnZKqOlKlfTew2BxaybXgyPFWszCkwGJ/CA4jgbvc9HMnlt51XppTVRl4UJryeUx
 iSWvfYQGchpINO94=
X-Received: by 2002:a1c:df83:: with SMTP id w125mr5765141wmg.140.1588925233036; 
 Fri, 08 May 2020 01:07:13 -0700 (PDT)
X-Google-Smtp-Source: APiQypJgGsSSdtnX4yF0jxjx9rtUhZ9un1aMAUkKGjLqgijmqU4TibOw9qkRNUkB4x+PNYdSltWyFg==
X-Received: by 2002:a1c:df83:: with SMTP id w125mr5765125wmg.140.1588925232842; 
 Fri, 08 May 2020 01:07:12 -0700 (PDT)
Received: from localhost (trasno.trasno.org. [83.165.45.250])
 by smtp.gmail.com with ESMTPSA id w6sm1796804wrt.39.2020.05.08.01.07.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 May 2020 01:07:12 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Subject: Re: [PATCH 06/10] exec: Move ramblock_recv_bitmap_offset() to
 migration/ram.c
In-Reply-To: <20200507173958.25894-7-philmd@redhat.com> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Thu, 7 May 2020 19:39:54
 +0200")
References: <20200507173958.25894-1-philmd@redhat.com>
 <20200507173958.25894-7-philmd@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
Date: Fri, 08 May 2020 10:07:11 +0200
Message-ID: <87imh6g89c.fsf@secure.mitica>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.120; envelope-from=quintela@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/08 02:25:09
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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
 qemu-ppc@nongnu.org, Keith Busch <kbusch@kernel.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> wrote:
> The ramblock_recv_bitmap_offset() function is only used once
> in migration/ram.c, move it there.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Reviewed-by: Juan Quintela <quintela@redhat.com>

But, if you are in the mood:

>  }
> =20
> +static inline unsigned long int ramblock_recv_bitmap_offset(void *host_a=
ddr,
> +                                                            RAMBlock *rb=
)
> +{
> +    uint64_t host_addr_offset =3D
> +            (uint64_t)(uintptr_t)(host_addr - (void *)rb->host);
> +    return host_addr_offset >> TARGET_PAGE_BITS;
                                  ^^^^^^^^^^^^^^^^

That should be qemu_target_page_bits().

We are trying (not there yet) that migration code is target independent,
this TARGET constant are one of the problems (not the only one,
thought).

And yes, I know that this file has both the function and the constant,
sniff.

Later, Juan.


