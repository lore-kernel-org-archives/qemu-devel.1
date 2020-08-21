Return-Path: <SRS0=atk5=B7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9484DC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 11:39:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C2F7221E2
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 11:39:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Cp9N1D/E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C2F7221E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47372 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k95O3-0005rG-Ji
	for qemu-devel@archiver.kernel.org; Fri, 21 Aug 2020 07:39:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38762)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1k94iP-0007mL-Gh
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 06:56:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:31267)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1k94iN-0005o9-J0
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 06:56:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598007366;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ih6fZH5SzHMQ5OO8SIg3LAOzdJ8VCA84rFAdVVvNqVQ=;
 b=Cp9N1D/E4B5TY0XO+nLTPavHh4V99QaYSWIxcUyGlR8xhtsUaDVQi7r3wTc95HMT8dbSiS
 osIC9yvIkWTsgtmFHq6GH2a/yMObIIWPrGp8GWoWW9QBNn7aRYQQSCivfKwU7S9mB1qxon
 QkJ3tzFZuEqrKTjbEqEQrIaYuwMk5Aw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-111-Sma2VIOgMJWELhANf2pawg-1; Fri, 21 Aug 2020 06:56:03 -0400
X-MC-Unique: Sma2VIOgMJWELhANf2pawg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2D4701005E73;
 Fri, 21 Aug 2020 10:55:58 +0000 (UTC)
Received: from gondolin (ovpn-113-4.ams2.redhat.com [10.36.113.4])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E9E5860BF1;
 Fri, 21 Aug 2020 10:55:46 +0000 (UTC)
Date: Fri, 21 Aug 2020 12:55:44 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: Robert Foley <robert.foley@linaro.org>
Subject: Re: [PATCH v2 0/7] accel/tcg: remove implied BQL from
 cpu_handle_interrupt/exception path
Message-ID: <20200821125544.73fc1d7b.cohuck@redhat.com>
In-Reply-To: <20200819182856.4893-1-robert.foley@linaro.org>
References: <20200819182856.4893-1-robert.foley@linaro.org>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=cohuck@redhat.com
X-Mimecast-Spam-Score: 0.003
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=cohuck@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/21 04:26:32
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Sarah Harris <S.E.Harris@kent.ac.uk>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 David Hildenbrand <david@redhat.com>, Anthony Green <green@moxielogic.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Max Filippov <jcmvbkbc@gmail.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Guan Xuetao <gxt@mprc.pku.edu.cn>, Marek Vasut <marex@denx.de>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Thomas Huth <thuth@redhat.com>, Richard Henderson <rth@twiddle.net>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Michael Rolnik <mrolnik@gmail.com>,
 pbonzini@redhat.com, Stafford Horne <shorne@gmail.com>, alex.bennee@linaro.org,
 David Gibson <david@gibson.dropbear.id.au>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Chris Wulff <crwulff@gmail.com>, Laurent Vivier <laurent@vivier.eu>,
 Michael Walle <michael@walle.cc>, Palmer Dabbelt <palmer@dabbelt.com>,
 peter.puhov@linaro.org, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 19 Aug 2020 14:28:49 -0400
Robert Foley <robert.foley@linaro.org> wrote:

> The purpose of this change is to set the groundwork
> so that an arch could move towards removing
> the BQL from the cpu_handle_interrupt/exception paths.
> 
> The BQL is a bottleneck in scaling to more cores.
> And this cpu_handle_interrupt/exception path is one of
> the key BQL users as measured by the QEMU sync profiling (qsp).
> 
> As the first step in removing the BQL from this path, we will make
> changes to the core/common functions of cpu_handle_interrupt/exception
> to drop the holding of the BQL. The holding of the BQL is pushed down
> to the per-arch implementation code.

I have only skimmed the patches I was cc:ed on so far, but the series
seems sane to me in general.

> 
> This patch goes through several transitions of the code in order to
> maintain correctness (bisectability).  In order to maintain
> bisectability across these steps some patches need to touch many
> files across different arches, however most of the changes are trivial.
> 
> The general order of the changes is below where each step
> represents one patch.
> 
> 1) rename all *_do_interrupt functions to *_do_interrupt_locked

I'm wondering whether this renaming could be done in an automated way
(e.g. via Coccinelle). Reviewing the method for the renaming is often
easier than looking at a lot of similar code patterns.

> 
> 2) add a new function *_do_interrupt that takes the BQL and calls
> *_do_interrupt_locked, point ->do_interrupt to it, and remove 
> the BQL from cpu-exec.c's cpu_handle_exception.
> 
> 3) modify the BQL critical sections around
> ->cpu_exec_interrupt, so that the BQL critical section covers just the  
> call to ->cpu_exec_interrupt. 
> 
> 4/5) same as 1/2 for ->cpu_exec_interrupt.  This removes the BQL
> from cpu_handle_exception.

The method of doing this in steps looks fine, although the patches
produced are a bit unwieldy -- that's something we have to live with, I
guess.


