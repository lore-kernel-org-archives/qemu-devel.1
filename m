Return-Path: <SRS0=37Ja=DO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70DABC4363D
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 13:09:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B109E20870
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 13:09:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BraIJ7rJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B109E20870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59256 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQ9Bv-0005dZ-EW
	for qemu-devel@archiver.kernel.org; Wed, 07 Oct 2020 09:09:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51242)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kQ98q-0003ol-Ou
 for qemu-devel@nongnu.org; Wed, 07 Oct 2020 09:06:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:50242)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kQ98n-00029A-Q7
 for qemu-devel@nongnu.org; Wed, 07 Oct 2020 09:06:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602075956;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7/14k+ocreZoF/krrUlb3TqHe70XTp2MhFXhZ4qCR1c=;
 b=BraIJ7rJ/5m+U8v2/r/AgWuit3pf6/l4iQLTMZ/XVYyllGmZ7NUtvzLx1rf5TZfYlJX6k8
 tMa0TcQP/cZh3Tp/PARt11nY1x1UZGt1DHnPHjFiT50LDYGy45xReVo9rIWEWpa4i1fHfV
 c/27FDHwEJZgEIzSzzzbd9Uxw7FeX6E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-576-k2Sk-YcwNpKp2h8Z85CqxQ-1; Wed, 07 Oct 2020 09:05:49 -0400
X-MC-Unique: k2Sk-YcwNpKp2h8Z85CqxQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0C28018BA2BC
 for <qemu-devel@nongnu.org>; Wed,  7 Oct 2020 13:05:49 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-182.ams2.redhat.com
 [10.36.112.182])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D22E55D9DD;
 Wed,  7 Oct 2020 13:05:48 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 5BEB811329C1; Wed,  7 Oct 2020 15:05:47 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Subject: Re: [PATCH v5 00/36] qapi: static typing conversion, pt1
References: <20201005195158.2348217-1-jsnow@redhat.com>
Date: Wed, 07 Oct 2020 15:05:47 +0200
In-Reply-To: <20201005195158.2348217-1-jsnow@redhat.com> (John Snow's message
 of "Mon, 5 Oct 2020 15:51:22 -0400")
Message-ID: <87o8le9oes.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Received-SPF: pass client-ip=63.128.21.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/07 00:44:56
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.742,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>,
 Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

John Snow <jsnow@redhat.com> writes:

> Hi, this series adds static type hints to the QAPI module.
> This is part one!
>
> Part 1: https://gitlab.com/jsnow/qemu/-/tree/python-qapi-cleanup-pt1
> Everything: https://gitlab.com/jsnow/qemu/-/tree/python-qapi-cleanup-pt6
>
> - Requires Python 3.6+
> - Requires mypy 0.770 or newer (for type analysis only)
> - Requires pylint 2.6.0 or newer (for lint checking only)
>
> In general, this series tackles the cleanup of one individual QAPI
> module at a time. Once it passes pylint or mypy checks, those checks are
> enabled for that file.
>
> Type hints are added in patches that add *only* type hints and change no
> other behavior. Any necessary changes to behavior to accommodate typing
> are split out into their own tiny patches.

Neat and pleasant to review.  The care you put into this shows.  Thanks!


