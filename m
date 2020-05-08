Return-Path: <SRS0=NBT7=6W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F80BC38A2A
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 08:13:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F2CA2207DD
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 08:13:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VYCVJ2RM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2CA2207DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55102 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWy8f-0005X5-6q
	for qemu-devel@archiver.kernel.org; Fri, 08 May 2020 04:13:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44142)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1jWy7y-0004Ih-2N
 for qemu-devel@nongnu.org; Fri, 08 May 2020 04:13:02 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:27366
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1jWy7v-0007en-BR
 for qemu-devel@nongnu.org; Fri, 08 May 2020 04:13:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588925578;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YLoNvgAnmhAe37oY099ELg/k7qGKpXf7UiAPPYIuppk=;
 b=VYCVJ2RM4NNmYN/+ax8zVlvsVeHuxSkglHA7JlXkdA1vCcdE4Zpj8mQ6tW0kbfg8fRQH++
 epNHmTS5DMl6PbD9wAFLcKW6ZwQnM1JCdU+CYMk3yHxcJxuj0g/X7jB2XBPrUkuzSKaBV5
 208CwpVjiCKkTWloW1xd0qzaXbJnUl0=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-224-oTgP2uX6ORaBJC2ATjdaHQ-1; Fri, 08 May 2020 04:12:56 -0400
X-MC-Unique: oTgP2uX6ORaBJC2ATjdaHQ-1
Received: by mail-wm1-f72.google.com with SMTP id h184so4825567wmf.5
 for <qemu-devel@nongnu.org>; Fri, 08 May 2020 01:12:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:in-reply-to:references
 :user-agent:reply-to:date:message-id:mime-version
 :content-transfer-encoding;
 bh=YLoNvgAnmhAe37oY099ELg/k7qGKpXf7UiAPPYIuppk=;
 b=SiN216XcY4MW5iaoQJ5euC/gbzAIMSW/e4c/X5ujkaSwvIvDpJ2EyLAWEbUj/WNStO
 L+T4YafiVQ8ErWIIoxhV/SBFRydb1o/96mhreZIVs6zNNXU2Urq0HcN56z7KBDD7iSQ0
 0d4oaEDIoWBjEUt627w0YJVVrJiqfJs5lWKlcN7fMo/T94qQTF4+jiHslQy1jRyoTpc9
 SBCn8ihnghlcfaeDUDr3F9VVC8qY7To2CPXnt4TbtzSsXQIBMPbHmpLol6bIJACJ2cW2
 U8AbLtcoqRHhk33nYcEJsy3qHvgmJ7/fTdvMURAezr/ueeAjDLpsEZabiHA2thDShe9R
 VY5g==
X-Gm-Message-State: AGi0PubizcAQdjuFRj7BkPFB4jFI5QdKAI3BgpNQ0CNDwu+jUi+rYQyF
 Fu8FQ7GG+vSxgsYL542J+SSmNecmwDGkOyS72MX9CYqINQtT8foq8LRTbyZxEsYsozTzZRxU9zG
 FzO7gpD+ypf1/MTs=
X-Received: by 2002:adf:9286:: with SMTP id 6mr1573107wrn.179.1588925575084;
 Fri, 08 May 2020 01:12:55 -0700 (PDT)
X-Google-Smtp-Source: APiQypJniVE7SdUvDZPGcVfmK34MTJP2V68E0OO7nQf2tYId/f91uLf28KiJH9N9YOElUquHEfqkBA==
X-Received: by 2002:adf:9286:: with SMTP id 6mr1573080wrn.179.1588925574912;
 Fri, 08 May 2020 01:12:54 -0700 (PDT)
Received: from localhost (trasno.trasno.org. [83.165.45.250])
 by smtp.gmail.com with ESMTPSA id g74sm11802679wme.44.2020.05.08.01.12.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 May 2020 01:12:54 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Subject: Re: [PATCH 10/10] exec: Move cpu_physical_memory_* functions to
 'exec/memory-internal.h'
In-Reply-To: <20200507173958.25894-11-philmd@redhat.com> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Thu, 7 May 2020 19:39:58
 +0200")
References: <20200507173958.25894-1-philmd@redhat.com>
 <20200507173958.25894-11-philmd@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
Date: Fri, 08 May 2020 10:12:53 +0200
Message-ID: <875zd6g7zu.fsf@secure.mitica>
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
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Once here, can someone give a test that meassures if it makes sense that
this functions are inline?
They are relatively big, and I would preffer them to be in a .c file,
but I have no clue about how performance critical they are.

Again, this include was another of the reasons that migration/ram.c
can't be make target agnostic.

Later, Juan.


