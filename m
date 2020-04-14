Return-Path: <SRS0=m554=56=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49202C2BA19
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2020 07:21:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1409320767
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2020 07:21:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GY4z1EYn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1409320767
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53642 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jOFtO-0007dW-8v
	for qemu-devel@archiver.kernel.org; Tue, 14 Apr 2020 03:21:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43343)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jOFsT-0006yR-Af
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 03:21:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1jOFsS-00041q-7t
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 03:21:01 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:52998
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1jOFsS-00041M-4x
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 03:21:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586848859;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=J0fIZmw1aWAkN+24HMHAFe6dSZXjdfWmrXBfDJ88NpM=;
 b=GY4z1EYnACrmlwvSYe2+cDVniPprq2QPsGymueey+Gj1pQkejt/lCm2qnXYDuRpKxI45ae
 p+8MaLfJkCsF/dURGVQ6v6H1kO4wJFDru6JRqKHZtViXZNVrd1vMy5y/VfQq+Jl3g2A6Uz
 K7PhhByUYc0fGJV0am52O3eBL+TcsbY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-407-p8Q6mpW6MZa4ddvGazmJMg-1; Tue, 14 Apr 2020 03:20:55 -0400
X-MC-Unique: p8Q6mpW6MZa4ddvGazmJMg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2D3201005510;
 Tue, 14 Apr 2020 07:20:54 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-113-20.ams2.redhat.com
 [10.36.113.20])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id CC07F9F996;
 Tue, 14 Apr 2020 07:20:53 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 4E49811385C8; Tue, 14 Apr 2020 09:20:52 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Claudio Fontana <cfontana@suse.de>
Subject: Re: [PATCH v2] Makefile: libfdt: build only the strict necessary
References: <20200409124337.32134-1-cfontana@suse.de>
 <2a5ea4be-96bb-b686-1683-52269bd518ff@redhat.com>
 <c9c407e4-9f90-44e9-d8f9-3a9681456057@redhat.com>
 <98172eb5-2475-b3aa-6e1f-83830e9ee2c0@suse.de>
Date: Tue, 14 Apr 2020 09:20:52 +0200
In-Reply-To: <98172eb5-2475-b3aa-6e1f-83830e9ee2c0@suse.de> (Claudio Fontana's
 message of "Fri, 10 Apr 2020 16:32:01 +0200")
Message-ID: <87mu7ezg6j.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org,
 Alex Bennee <alex.bennee@linaro.org>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Claudio Fontana <cfontana@suse.de> writes:

[...]
> I am tempted to remove the old compatibility gunks that are marked as "to=
 be removed some time after 4.1" as the second patch in the series,
> any thoughts? (Markus?)

Yes, please!


