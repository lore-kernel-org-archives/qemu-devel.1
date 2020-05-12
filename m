Return-Path: <SRS0=ZOtl=62=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA307C54E4A
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 11:22:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 762FB206DD
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 11:22:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dkpfIFrd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 762FB206DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44022 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYSzq-0004Ex-KU
	for qemu-devel@archiver.kernel.org; Tue, 12 May 2020 07:22:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60146)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jYSz4-0003WC-9X
 for qemu-devel@nongnu.org; Tue, 12 May 2020 07:22:02 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:27879
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jYSz3-0002Iw-Gl
 for qemu-devel@nongnu.org; Tue, 12 May 2020 07:22:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589282520;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AEVRL4Oko0vgs597Lf34jLnzBsH+tHv+QfEWr0pATNc=;
 b=dkpfIFrdeRjlKcKVsiGR5Yte/APjoteALBvpKFNSPCpGXLWVx114WW9pcnsyCMEfy0ko1L
 wlaJqmUpmA/r7/jvb+xNssmMPdUdZf7VAOJonh5zC+rDWxwMq7BfQlGSNr/IGqNsSgtoMe
 IjwU9XDmz9h0VIJn9JwnP8croyaHTiM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-172-dhFqWU8hOHm-1YISCiiWQA-1; Tue, 12 May 2020 07:21:58 -0400
X-MC-Unique: dhFqWU8hOHm-1YISCiiWQA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9B3A3107ACCA;
 Tue, 12 May 2020 11:21:57 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-113-193.ams2.redhat.com
 [10.36.113.193])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5FF6E7D8C3;
 Tue, 12 May 2020 11:21:57 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 6C18C1747D; Tue, 12 May 2020 13:21:56 +0200 (CEST)
Date: Tue, 12 May 2020 13:21:56 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
To: Volker =?utf-8?Q?R=C3=BCmelin?= <vr_qemu@t-online.de>
Subject: Re: [PATCH 01/10] ui/win32-kbd-hook: handle AltGr in a hook procedure
Message-ID: <20200512112156.ttp5wekonrcwmyxs@sirius.home.kraxel.org>
References: <2393388c-86c3-4d7e-178e-2c7e6d14a8de@t-online.de>
 <20200510184304.9267-1-vr_qemu@t-online.de>
MIME-Version: 1.0
In-Reply-To: <20200510184304.9267-1-vr_qemu@t-online.de>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/12 02:02:05
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
Cc: Stefan Weil <sw@weilnetz.de>,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>,
 QEMU <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, May 10, 2020 at 08:42:55PM +0200, Volker Rümelin wrote:
> Import win32 keyboard hooking code from project spice-gtk.

> +/*
> + * This work is licensed under the terms of the GNU GPL, version 2 or
> + * (at your option) any later version.  See the COPYING file in the
> + * top-level directory.
> + */

Can you add the import note to the comment too?

> +void win32_kbd_set_window(HWND hwnd);

Can we use uint32_t here (or whatever HWND actually is) so the header
can also be included on non-win32 machines?

thanks,
  Gerd


