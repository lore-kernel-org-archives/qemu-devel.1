Return-Path: <SRS0=NBT7=6W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87B09C38A2A
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 08:03:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 51DD5206B8
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 08:03:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cOEaxzpH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51DD5206B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60602 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWxyF-0001xK-H4
	for qemu-devel@archiver.kernel.org; Fri, 08 May 2020 04:02:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41514)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1jWxvS-0007CF-PB
 for qemu-devel@nongnu.org; Fri, 08 May 2020 04:00:06 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:34382
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1jWxvR-0001JY-Lz
 for qemu-devel@nongnu.org; Fri, 08 May 2020 04:00:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588924804;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Mk9VfLstIS933+0dK1OeirqukOrqLYcDfbmjJQLtJOo=;
 b=cOEaxzpHDDA+piYduhHV/OXSBNpY43GACxLmnkSnQXF2hrcvjgWttDWYgej+zerOFNgaOd
 644pZ4VI2rnFhVobEElrf8xm4b9tIVjEAxs72AhtpQ1kR3AMAUBKhUXyBh2tyqB0LEUM+X
 inJ7irgjVq6EiKK5wnlb7cLOlO2wB6U=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-186-kTB-8j7ON3OKKKWgML2EMg-1; Fri, 08 May 2020 04:00:03 -0400
X-MC-Unique: kTB-8j7ON3OKKKWgML2EMg-1
Received: by mail-wr1-f70.google.com with SMTP id 30so497460wrq.15
 for <qemu-devel@nongnu.org>; Fri, 08 May 2020 01:00:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:in-reply-to:references
 :user-agent:reply-to:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Mk9VfLstIS933+0dK1OeirqukOrqLYcDfbmjJQLtJOo=;
 b=TZO5Deb14Vc9wdUHCSD5j1yjcEpAdz5TuvKv7Fv1k0VYLqaQ4fJy94JwGlBS/Cnd4R
 vD2pXyD7jiuGNzORnST6WtGqwMHErF1aHkg7cU+/ksutqSySif/mXMtDo6V1qV4I3kEH
 x0vjXHeIxeEs4ZmVHLsnX7sU4f9g11EHHS6hhQgbfx+2GjuTIwmHLCOqJPmt52bWzwMm
 4+FQ8PAdGQlmb2yPj3N+uuJm6fwUiNtvkbjzo9+UYiMmjXPNKb162Bpj2Zt/BLyp9CGG
 aJdwDDV74R8XpYipSM3c3uiUagWU5gGGlgoVZwzeAoIlEGvFlrY/J5nklLPyCbpuqOkF
 jA1Q==
X-Gm-Message-State: AGi0PuZPjp21rVqU8XJkfna2Si6BbZJVbjez6vB0IW2ImUJUgNc/tng+
 6L6iGFPQNlJoIJ5EMhJYpf08fT2Ex6ntssMIl72asZK8E2CeTGv8iDV3ZNpM0qlJ2omZdhwbuEY
 LZKanw7g/ZUg3exI=
X-Received: by 2002:a1c:ed0b:: with SMTP id l11mr15721374wmh.31.1588924801858; 
 Fri, 08 May 2020 01:00:01 -0700 (PDT)
X-Google-Smtp-Source: APiQypJT9bbUqreGmIQg0XjwSWI0feDzq6zWTrTIS717wZcrt0NOJXbqb6Op+n1BKH2eEJ/zVMNCDA==
X-Received: by 2002:a1c:ed0b:: with SMTP id l11mr15721349wmh.31.1588924801599; 
 Fri, 08 May 2020 01:00:01 -0700 (PDT)
Received: from localhost (trasno.trasno.org. [83.165.45.250])
 by smtp.gmail.com with ESMTPSA id a8sm1644133wrg.85.2020.05.08.01.00.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 May 2020 01:00:00 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Subject: Re: [PATCH 02/10] exec/ramblock: Add missing 'qemu/rcu.h' include
In-Reply-To: <20200507173958.25894-3-philmd@redhat.com> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Thu, 7 May 2020 19:39:50
 +0200")
References: <20200507173958.25894-1-philmd@redhat.com>
 <20200507173958.25894-3-philmd@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
Date: Fri, 08 May 2020 09:59:59 +0200
Message-ID: <87v9l6g8lc.fsf@secure.mitica>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.61; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/08 02:25:25
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
> The first field of RAMBlock is a rcu_head structure.
> We need to include the "qemu/rcu.h" to avoid errors when
> including "exec/ramblock.h" without "qemu/rcu.h":
>
>   include/exec/ramblock.h:27:21: error: field =E2=80=98rcu=E2=80=99 has i=
ncomplete type
>      27 |     struct rcu_head rcu;
>         |                     ^~~
>   include/exec/ramblock.h:39:5: error: expected
> specifier-qualifier-list before =E2=80=98QLIST_ENTRY=E2=80=99
>      39 |     QLIST_ENTRY(RAMBlock) next;
>         |     ^~~~~~~~~~~
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Reviewed-by: Juan Quintela <quintela@redhat.com>


