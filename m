Return-Path: <SRS0=JPH5=CC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC49FC433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2020 13:27:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 989EE206B5
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2020 13:27:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D6A9W9/l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 989EE206B5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44874 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kACVD-0007a2-Sg
	for qemu-devel@archiver.kernel.org; Mon, 24 Aug 2020 09:27:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53334)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1kACUg-00077v-1K
 for qemu-devel@nongnu.org; Mon, 24 Aug 2020 09:26:38 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:29745
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1kACUe-0002Zc-Dd
 for qemu-devel@nongnu.org; Mon, 24 Aug 2020 09:26:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598275595;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=d5N9bJHCzhhGq1q1rcL50uhT0Yg+WzpXWcAoUxFTYIE=;
 b=D6A9W9/lKCmL9ZemhZqzzvsS2y3/WYsRZ7f3LojBJSVaNqixifPbVVIfpJM38u/Xb2bst3
 BKQc/iG0A5xOOSjt3dyPpZQZ0EPXruC7b2LujPiCvNpuu5DfjuONYvoI82R0OiZpPuIhee
 SY1bkKlOztJEQgV/1p/UImXsbrkBuWQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-95-Ugdjsfr-Nr63UWsX26hDmw-1; Mon, 24 Aug 2020 09:26:33 -0400
X-MC-Unique: Ugdjsfr-Nr63UWsX26hDmw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D46A018A2250;
 Mon, 24 Aug 2020 13:26:31 +0000 (UTC)
Received: from kaapi (unknown [10.74.9.190])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id EBEEA10027AB;
 Mon, 24 Aug 2020 13:26:19 +0000 (UTC)
Date: Mon, 24 Aug 2020 18:56:17 +0530 (IST)
From: P J P <ppandit@redhat.com>
X-X-Sender: pjp@kaapi
To: =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@redhat.com>
Subject: Re: [PATCH] ati-vga: Fix checks in ati_2d_blt() to avoid crash
In-Reply-To: <2041026f-7a88-d8f7-8738-968e1394e8c6@redhat.com>
Message-ID: <nycvar.YSQ.7.78.906.2008241842050.306228@xnncv>
References: <20200406204029.19559747D5D@zero.eik.bme.hu>
 <2041026f-7a88-d8f7-8738-968e1394e8c6@redhat.com>
MIME-Version: 1.0
Content-ID: <nycvar.YSQ.7.78.906.2008241851130.306228@xnncv>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ppandit@redhat.com
X-Mimecast-Spam-Score: 0.0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/mixed;
 BOUNDARY="-1463810047-780288353-1598275116=:306228"
Received-SPF: pass client-ip=207.211.31.81; envelope-from=ppandit@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/24 05:21:34
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.956,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
 Mauro Matteo Cascella <mcascell@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>,
 qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
---1463810047-780288353-1598275116=:306228
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Content-ID: <nycvar.YSQ.7.78.906.2008241851131.306228@xnncv>

+-- On Sat, 22 Aug 2020, Philippe Mathieu-Daudé wrote --+
| This points to a BZ#1847385 which is private:
| "You are not authorized to access bug #1847385.
| https://bugzilla.redhat.com/show_bug.cgi?id=1847385

CVE-2020-24352:
  -> https://bugzilla.redhat.com/show_bug.cgi?id=1847584

This is the pubic bug.

| Maybe we could improve the security process, when a CVE embargo
| expires, the public statement could point at the commit(s) fixing
| the bug.

Yes, we generally tag/log upstream fixes against the CVE bugs. It seems 
missing in this case, maybe because fix was sent upstream latter. Will fix it.


Thank you.
--
Prasad J Pandit / Red Hat Product Security Team
8685 545E B54C 486B C6EB 271E E285 8B5A F050 DE8D
---1463810047-780288353-1598275116=:306228--


