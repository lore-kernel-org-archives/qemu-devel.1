Return-Path: <SRS0=37Ja=DO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 381E3C41604
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 11:32:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 670DA20789
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 11:32:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Nw0S7Xt/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 670DA20789
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34350 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQ7gI-0002MW-4Q
	for qemu-devel@archiver.kernel.org; Wed, 07 Oct 2020 07:32:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57258)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1kQ7em-0001i9-EJ
 for qemu-devel@nongnu.org; Wed, 07 Oct 2020 07:30:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:31530)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1kQ7ek-0006q2-3h
 for qemu-devel@nongnu.org; Wed, 07 Oct 2020 07:30:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602070249;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lCo2tJKCNVeKjFL5aRBFnVO4rBlRtJ7nofZ+eqWUE54=;
 b=Nw0S7Xt/VEhB9yRrZHuOaWvTOfKrPrKm5Nb/ZXOC5yqTTbnrfpPRQltrO3fHSjmjInvJuy
 d1vdxPS2smeqBirJHWNgqb8+67R2dEalKe2HC5tb+KK2jFxF088Ch4I+rxr6tXm801XUHA
 V9FVpyXt3r5VSdrawmBBNG0R1eAX0YE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-515-Ec4r4C7zO2q3FfHT1z4yTw-1; Wed, 07 Oct 2020 07:30:47 -0400
X-MC-Unique: Ec4r4C7zO2q3FfHT1z4yTw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1075180401F;
 Wed,  7 Oct 2020 11:30:46 +0000 (UTC)
Received: from linux.fritz.box (ovpn-113-169.ams2.redhat.com [10.36.113.169])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8DBF45C70A;
 Wed,  7 Oct 2020 11:30:44 +0000 (UTC)
Date: Wed, 7 Oct 2020 13:30:43 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: John Snow <jsnow@redhat.com>
Subject: Re: [PATCH 18/20] python/qemu/qmp.py: re-raise OSError when
 encountered
Message-ID: <20201007113043.GL7212@linux.fritz.box>
References: <20201006235817.3280413-1-jsnow@redhat.com>
 <20201006235817.3280413-19-jsnow@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20201006235817.3280413-19-jsnow@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kwolf@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/07 00:54:30
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.742,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org,
 Eduardo Habkost <ehabkost@redhat.com>, Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 07.10.2020 um 01:58 hat John Snow geschrieben:
> Nested if conditions don't change when the exception block fires; we
> need to explicitly re-raise the error if we didn't intend to capture and
> suppress it.
> 
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  python/qemu/qmp.py | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/python/qemu/qmp.py b/python/qemu/qmp.py
> index d911999da1f..bdbd1e9bdbb 100644
> --- a/python/qemu/qmp.py
> +++ b/python/qemu/qmp.py
> @@ -169,9 +169,9 @@ def __get_events(self, wait: Union[bool, float] = False) -> None:
>          try:
>              self.__json_read()
>          except OSError as err:
> -            if err.errno == errno.EAGAIN:
> -                # No data available
> -                pass
> +            # EAGAIN: No data available; not critical
> +            if err.errno != errno.EAGAIN:
> +                raise

Hm, if we re-raise the exception here, the socket remains non-blocking.
I think we intended to have it like that only temporarily.

The same kind of exception would raise QMPConnectError below instead of
directly OSError. Should we try to make this consistent?

>          self.__sock.setblocking(True)
>  
>          # Wait for new events, if needed.

Kevin


