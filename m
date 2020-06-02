Return-Path: <SRS0=xYMn=7P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5896AC433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2020 06:48:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 219E92072F
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2020 06:48:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S1S8YzVK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 219E92072F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57168 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jg0iW-0007MZ-Bw
	for qemu-devel@archiver.kernel.org; Tue, 02 Jun 2020 02:48:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45744)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jg0hd-0006q6-0R
 for qemu-devel@nongnu.org; Tue, 02 Jun 2020 02:47:13 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:50117
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jg0hb-0005jG-CT
 for qemu-devel@nongnu.org; Tue, 02 Jun 2020 02:47:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591080429;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DBbADa4bcBjWsSgzgPFrNIFZVpPuypWB/yrI5pRLyF8=;
 b=S1S8YzVKjJpYOOvpEL7Vs8BYMSZNRuZqs8v1zkq2AcVvLOb261tyxdyPaRv5+XA0FdelrC
 vLQ6w2L/sUhpy+iuXLu3VSI1vTKsG8ow3p3u3MQe+UJvzBwuwUCTkSucU3KjLyixakFWkE
 pqz6giZRqli5yj22zgUlbvPaZ7gvUDo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-208-_3a5aI83NC2OmSLbqi4N3w-1; Tue, 02 Jun 2020 02:47:07 -0400
X-MC-Unique: _3a5aI83NC2OmSLbqi4N3w-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4A26B461;
 Tue,  2 Jun 2020 06:47:06 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-121.ams2.redhat.com
 [10.36.112.121])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 27B5778EF4;
 Tue,  2 Jun 2020 06:47:02 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 8EF661138601; Tue,  2 Jun 2020 08:47:00 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: "Dr. David Alan Gilbert \(git\)" <dgilbert@redhat.com>
Subject: Re: [PULL 04/12] hmp: Simplify qom-set
References: <20200601184004.272784-1-dgilbert@redhat.com>
 <20200601184004.272784-5-dgilbert@redhat.com>
Date: Tue, 02 Jun 2020 08:47:00 +0200
In-Reply-To: <20200601184004.272784-5-dgilbert@redhat.com> (David Alan
 Gilbert's message of "Mon, 1 Jun 2020 19:39:56 +0100")
Message-ID: <87pnai7ymz.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.120; envelope-from=armbru@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/02 01:38:04
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: mszeredi@redhat.com, lukasstraub2@web.de, quintela@redhat.com,
 pannengyuan@huawei.com, f4bug@amsat.org, qemu-devel@nongnu.org,
 stefanha@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

"Dr. David Alan Gilbert (git)" <dgilbert@redhat.com> writes:

> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
>
> Simplify qom_set by making it use qmp_qom_set and the JSON parser.
>
> (qemu) qom-get /machine smm
> "auto"
> (qemu) qom-set /machine smm "auto"
>
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> Message-Id: <20200520151108.160598-3-dgilbert@redhat.com>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> Reviewed-by: Markus Armbruster <armbru@redhat.com>
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
>   With 's'->'S' type change suggested by Paolo and Markus

This is actually more than just simplification, it's disarming a bear
trap: the string visitor is restricted to a subset of the QAPI types,
and when you qom-set a property with a type it can't handle, QEMU
aborts.  I mentioned this in the discussion of possible ways out of the
qom-get impasse, but missed reraising it in patch review.

A suitably amended commit would be nice, but respinning the PR just for
that may not be worthwhile.


