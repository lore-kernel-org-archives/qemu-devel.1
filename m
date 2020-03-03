Return-Path: <SRS0=3Wv1=4U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 738ECC3F2C6
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 17:11:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F01B20863
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 17:11:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dnJ+rXuE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F01B20863
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50690 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9B4o-0004k0-BS
	for qemu-devel@archiver.kernel.org; Tue, 03 Mar 2020 12:11:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34672)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1j9B49-0003rx-1t
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 12:10:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1j9B47-0004MZ-Qw
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 12:10:44 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:31478
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1j9B47-0004Ly-Fy
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 12:10:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583255442;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AUrZbKeMhP9ZGf3VTyZwlzNeAO2pcduO/gbPhtC1W6c=;
 b=dnJ+rXuEhTNrbjEtclbwKHqeFPTL/nRO31zw9teUJTQ+yR4IuW84vRPawZm4AUzJc7UwXC
 5JHItxOBvDoXzFpt9xcsZvTEDYGmCcjOljp/MJYZM2IxW03tZ4Vb+E2A88IOglSjhUtyrv
 PpkbL5WLucoaQT3w5o8XXEo92AH2tWA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-313-laPmZDtnOD-Gct-wlYz-MQ-1; Tue, 03 Mar 2020 12:10:40 -0500
X-MC-Unique: laPmZDtnOD-Gct-wlYz-MQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2BD528010EB;
 Tue,  3 Mar 2020 17:10:39 +0000 (UTC)
Received: from linux.fritz.box (ovpn-117-229.ams2.redhat.com [10.36.117.229])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E93D4272CB;
 Tue,  3 Mar 2020 17:10:34 +0000 (UTC)
Date: Tue, 3 Mar 2020 18:10:33 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Maxim Levitsky <mlevitsk@redhat.com>
Subject: Re: [PATCH v4 02/11] monitor/hmp: uninline add_init_drive
Message-ID: <20200303171033.GF5733@linux.fritz.box>
References: <20200130123448.21093-1-mlevitsk@redhat.com>
 <20200130123448.21093-3-mlevitsk@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200130123448.21093-3-mlevitsk@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
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
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Markus Armbruster <armbru@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 30.01.2020 um 13:34 hat Maxim Levitsky geschrieben:
> This is only used by hmp_drive_add.
> The code is just a bit shorter this way.
>=20
> No functional changes
>=20
> Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
> Reviewed-by: Markus Armbruster <armbru@redhat.com>

Shouldn't the subject say "inline" rather than "uninline"?

Kevin


