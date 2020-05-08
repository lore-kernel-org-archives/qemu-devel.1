Return-Path: <SRS0=NBT7=6W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52DDFC4724C
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 08:02:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 23EF3206B8
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 08:02:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BjBbZv36"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23EF3206B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59450 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWxxw-0001Uw-9l
	for qemu-devel@archiver.kernel.org; Fri, 08 May 2020 04:02:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41768)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1jWxx3-0000fV-G5
 for qemu-devel@nongnu.org; Fri, 08 May 2020 04:01:45 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:35055
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1jWxx2-0002op-ND
 for qemu-devel@nongnu.org; Fri, 08 May 2020 04:01:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588924904;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=65ssXkaSSraLTnCVIM8DWlt4bh27ueore7tly090W2g=;
 b=BjBbZv36l67AE0CrRnHFb70yAjZLdv93IbLTsyekiVw3hHIVh3y6uN73SNREXie9PLB4io
 LUsRmJ1l/PD7uJsvEXDJT06ayHChkTeDwUemtuqV3cujXc2o6iR24+8e06p+oIQPHK0Gvn
 yDw/PO01Lk9AcQ60IsXFAphZUI/Y/e8=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-277-qDxHuMD1PiawquCmi-PyIQ-1; Fri, 08 May 2020 04:01:42 -0400
X-MC-Unique: qDxHuMD1PiawquCmi-PyIQ-1
Received: by mail-wm1-f72.google.com with SMTP id o11so2580594wme.8
 for <qemu-devel@nongnu.org>; Fri, 08 May 2020 01:01:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:in-reply-to:references
 :user-agent:reply-to:date:message-id:mime-version
 :content-transfer-encoding;
 bh=65ssXkaSSraLTnCVIM8DWlt4bh27ueore7tly090W2g=;
 b=rb8svnT+jPgO4rbF0M3fBxixEAf1cZh/wFrbagv+uLHQCi9sFjhwyw7YukGwNuv9/+
 Xlov6ldxrKMV8AlvQv36qbpgfaIqdkpiFqBmZLojZhZHfEqOOsRyWr4L/gLtJ2WcuIXX
 WoFx9Je+VKrQ3v8boIQkNjRh+pw3bygOQJfCPd56niKOkWaXka/TtXxzSUL53hsn6PFw
 LeXKTdbL6BkPPL91D4cYtA5K7FOQyCqUdEflJaSkAf54D4Mj0Uq2u7Dh9Z7qJnGe44O9
 ELGlvzkTkbY4gAHKdy70ZB23icMry2P2OSb9uQRwLIx5m0gFT6cChCfCUWeRU8N1tSBl
 LEDg==
X-Gm-Message-State: AGi0PuZjnJIaWB27BQ0diCfTx4npJC5wYReZjJa3qxu3MNDlI5lcu+kZ
 aftxhanfSfB8HC1OChyTMy51p1f1Q4QOqgQBjYqpmOSafUtz9wNwzGAWmbUuEvympq4xcfFQ2sl
 J4oLmAnE9m+Bh0jo=
X-Received: by 2002:a5d:5646:: with SMTP id j6mr1491572wrw.207.1588924900847; 
 Fri, 08 May 2020 01:01:40 -0700 (PDT)
X-Google-Smtp-Source: APiQypLwfOk3kzezxVkw6obUCkIcXsnUOLMfGeFdxGMdQtj78RHJNldWgkOfApTqx4kaQRDNz9o73w==
X-Received: by 2002:a5d:5646:: with SMTP id j6mr1491534wrw.207.1588924900646; 
 Fri, 08 May 2020 01:01:40 -0700 (PDT)
Received: from localhost (trasno.trasno.org. [83.165.45.250])
 by smtp.gmail.com with ESMTPSA id 92sm1667796wrm.71.2020.05.08.01.01.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 May 2020 01:01:40 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Subject: Re: [PATCH 04/10] exec/memory-internal: Check CONFIG_SOFTMMU instead
 of CONFIG_USER_ONLY
In-Reply-To: <20200507173958.25894-5-philmd@redhat.com> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Thu, 7 May 2020 19:39:52
 +0200")
References: <20200507173958.25894-1-philmd@redhat.com>
 <20200507173958.25894-5-philmd@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
Date: Fri, 08 May 2020 10:01:38 +0200
Message-ID: <87r1vug8il.fsf@secure.mitica>
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
> The CONFIG_SOFTMMU definition is poisoned in "exec/poison.h".
> As this header is internal, check for poisoned CONFIG_SOFTMMU
> instead of CONFIG_USER_ONLY to make this include harder to use.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>>

Reviewed-by: Juan Quintela <quintela@redhat.com>


