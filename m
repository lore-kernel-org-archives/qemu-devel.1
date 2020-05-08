Return-Path: <SRS0=NBT7=6W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AA8DC38A2A
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 08:09:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C8B65207DD
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 08:09:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G+G/vOuA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8B65207DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46602 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWy4X-0000pn-2J
	for qemu-devel@archiver.kernel.org; Fri, 08 May 2020 04:09:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43206)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1jWy3V-00073T-BF
 for qemu-devel@nongnu.org; Fri, 08 May 2020 04:08:25 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:51685
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1jWy3U-0007i5-IG
 for qemu-devel@nongnu.org; Fri, 08 May 2020 04:08:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588925303;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3M3Sie6sHH4F//aP9lcPPkUNV4SWqztGtawK1ZyAkUw=;
 b=G+G/vOuAOJrk0DEdOJaqDOO8oEf7bbD366httyNsqBOGJL3gHeBp3AOtV8VfbBD4kr+Wa7
 tGjMba8T5bwEKukQGn4dyNNZyyye8Dvy0TDeWuzC1Ce4AU7afEeScstgh1Chtyj6APnkFR
 WfVjLQpD0i/4flEvoHA9X0/6RmFAElM=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-105-zU08DJyJNfOqUbhhQrOEhw-1; Fri, 08 May 2020 04:08:22 -0400
X-MC-Unique: zU08DJyJNfOqUbhhQrOEhw-1
Received: by mail-wm1-f69.google.com with SMTP id h184so4820345wmf.5
 for <qemu-devel@nongnu.org>; Fri, 08 May 2020 01:08:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:in-reply-to:references
 :user-agent:reply-to:date:message-id:mime-version
 :content-transfer-encoding;
 bh=3M3Sie6sHH4F//aP9lcPPkUNV4SWqztGtawK1ZyAkUw=;
 b=nYCGdCh6bz+GWh+evUVUVVfTmAWeWYGkbOTmrbmLxsejecVionJB2NZd2ijScdshHn
 t0OM+FrwFQ/bEnzV4oSlT66lONUOa1cMlxMVdeG5KZGZJSxozrACDJcYLDHG405v3Qoz
 /Kz7fejdXylfcF42yJrnc9Tf7jaYelCcjIYdTkO72N9Lj5kiEw0vTyW8pcMcoPBS+5Ob
 /kYSSMitvil0qdoAX3BWODqRpZDbApzYdf6cgoXj7BZRlzY/y9SLuUaQCyUQTeXHJcfP
 yT0Spx2/IhIEdVsSrdI7I3r70xQaJjvv2Q9wa/HQPhYLMAPu8rAKHSU+TcUyvG7St0tn
 XwxQ==
X-Gm-Message-State: AGi0PuaPjOlpx15ypYGdGIUnQTf9EZCnmcgIVYZg5d8yegUyMTLGOCGA
 yhzpsvdtGhDS5qGoFcaupq0WMf6PIIZYMvGS8ls8KWtQ3kCPV3gucXzqRqr7DX30zdd/XjJLfcW
 eJptn5luAcKrl+cY=
X-Received: by 2002:a5d:550c:: with SMTP id b12mr1608907wrv.152.1588925301482; 
 Fri, 08 May 2020 01:08:21 -0700 (PDT)
X-Google-Smtp-Source: APiQypJ9e9iyqFL1GiboSQId4vkLu6NoLEgu/GcIhQyfGHaAoLDM8gqB7nP5Y55GxjmMeqboCH2AoA==
X-Received: by 2002:a5d:550c:: with SMTP id b12mr1608881wrv.152.1588925301283; 
 Fri, 08 May 2020 01:08:21 -0700 (PDT)
Received: from localhost (trasno.trasno.org. [83.165.45.250])
 by smtp.gmail.com with ESMTPSA id f5sm1644494wrp.70.2020.05.08.01.08.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 May 2020 01:08:20 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Subject: Re: [PATCH 07/10] exec: Move all RAMBlock functions to
 'exec/ramblock.h'
In-Reply-To: <20200507173958.25894-8-philmd@redhat.com> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Thu, 7 May 2020 19:39:55
 +0200")
References: <20200507173958.25894-1-philmd@redhat.com>
 <20200507173958.25894-8-philmd@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
Date: Fri, 08 May 2020 10:08:19 +0200
Message-ID: <87eerug87g.fsf@secure.mitica>
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
 qemu-ppc@nongnu.org, Keith Busch <kbusch@kernel.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> wrote:
> The RAMBlock API was dispersed in 3 different headers.
> One of these headers, "exec/ram_addr.h", is restricted
> to target dependent code. However these functions are
> not target specific. Move all functions into a single
> place.  Now all these functions can be accessed by
> target-agnostic code.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Reviewed-by: Juan Quintela <quintela@redhat.com>

Very nice of you doing this, Thanks.


