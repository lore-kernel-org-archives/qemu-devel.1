Return-Path: <SRS0=I8Mx=26=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD4D0C32771
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 09:45:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 94F2D206ED
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 09:45:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OWRrmOqr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94F2D206ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57488 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipUN9-0002O4-Pk
	for qemu-devel@archiver.kernel.org; Thu, 09 Jan 2020 04:44:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36374)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <quintela@redhat.com>) id 1ipUMU-0001wN-5T
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 04:44:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <quintela@redhat.com>) id 1ipUMS-0000kG-W4
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 04:44:17 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:33649
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <quintela@redhat.com>) id 1ipUMS-0000hI-P8
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 04:44:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578563056;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vLSqyyR7AcX0CQmCuyqsHUHujGC858FTBG6qOSkKufo=;
 b=OWRrmOqr8dAI9DA5qkNsLl3wGYmbix60audfL9Io1lGssalZvHRmVPElM2qOd9Itc+vExS
 ghszXmkCysOldF02LLW/XNu/ZXbBLmKAZQHbpmP1FqYIPlLQ+JQaYA9CYgg+MBABMXBjhf
 AG//OzjSMjZYSIwVvWq/0W5ZCp2LhBg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-365-NgFjt09PMBqxEMgOitfDZA-1; Thu, 09 Jan 2020 04:44:12 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D0AAC10054E3;
 Thu,  9 Jan 2020 09:44:11 +0000 (UTC)
Received: from redhat.com (ovpn-116-22.ams2.redhat.com [10.36.116.22])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 65DD0272A3;
 Thu,  9 Jan 2020 09:44:11 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: Wei Yang <richardw.yang@linux.intel.com>
Subject: Re: [Patch v2 6/6] migration/postcopy: enable compress during postcopy
In-Reply-To: <20191107123907.29791-7-richardw.yang@linux.intel.com> (Wei
 Yang's message of "Thu, 7 Nov 2019 20:39:07 +0800")
References: <20191107123907.29791-1-richardw.yang@linux.intel.com>
 <20191107123907.29791-7-richardw.yang@linux.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
Date: Thu, 09 Jan 2020 10:44:09 +0100
Message-ID: <87zhexynfa.fsf@secure.laptop>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: NgFjt09PMBqxEMgOitfDZA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: dgilbert@redhat.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Wei Yang <richardw.yang@linux.intel.com> wrote:
> postcopy requires to place a whole host page, while migration thread
> migrate memory in target page size. This makes postcopy need to collect
> all target pages in one host page before placing via userfaultfd.
>
> To enable compress during postcopy, there are two problems to solve:
>
>     1. Random order for target page arrival
>     2. Target pages in one host page arrives without interrupt by target
>        page from other host page
>
> The first one is handled by previous cleanup patch.
>
> This patch handles the second one by:
>
>     1. Flush compress thread for each host page
>     2. Wait for decompress thread for before placing host page
>
> Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
> Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

Reviewed-by: Juan Quintela <quintela@redhat.com>


