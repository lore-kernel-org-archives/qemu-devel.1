Return-Path: <SRS0=+Hf+=3G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40806C33CB1
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 07:47:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0B23020728
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 07:47:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZZM2DvcV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B23020728
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53632 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1isMM8-0007B1-Vw
	for qemu-devel@archiver.kernel.org; Fri, 17 Jan 2020 02:47:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33499)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kraxel@redhat.com>) id 1isMKH-0005xj-JF
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 02:45:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kraxel@redhat.com>) id 1isMKD-0006Sl-1u
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 02:45:53 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:44887
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1isMKC-0006SI-UV
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 02:45:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579247148;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MFkQI0+WRwSCWnWSROARUw5HrTsB5hfe//ZEG0pOmIA=;
 b=ZZM2DvcV+R8vhlfpS4HVqDDV2ANXgWJn5mcSWLYgjU00Ta9ELi3X0nw7U/9ucbkGdn89Y7
 bs8NpSAJ/tUw4CtNzQ2p7PU4zEY+6Gi5yxBJSCjNZWWi4rKOhL/Wmsk1xOZOUISnnZXHCd
 rUbxywlUtfzFoQ3CpZQ9EgxlkJBtKOQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-100-MUFko7JGPYyg2nCvWXuRyA-1; Fri, 17 Jan 2020 02:45:32 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B8B4A107ACC4;
 Fri, 17 Jan 2020 07:45:31 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-106.ams2.redhat.com
 [10.36.116.106])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7DC5781219;
 Fri, 17 Jan 2020 07:45:31 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id B33C497C2; Fri, 17 Jan 2020 08:45:30 +0100 (CET)
Date: Fri, 17 Jan 2020 08:45:30 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
To: Cameron Esfahani <dirty@apple.com>
Subject: Re: [PATCH v1] vnc: fix VNC artifacts
Message-ID: <20200117074530.mt2upbm7y5knyj7j@sirius.home.kraxel.org>
References: <7cb1f22ef8d575238c84f091f03dee8e7fedb78d.1579232679.git.dirty@apple.com>
MIME-Version: 1.0
In-Reply-To: <7cb1f22ef8d575238c84f091f03dee8e7fedb78d.1579232679.git.dirty@apple.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: MUFko7JGPYyg2nCvWXuRyA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Jan 16, 2020 at 07:50:58PM -0800, Cameron Esfahani wrote:
> Remove VNC optimization to reencode framebuffer update as raw if it's
> smaller than the default encoding.  QEMU's implementation was naive and
> didn't account for the ZLIB z_stream mutating with each compression.  Jus=
t
> saving and restoring the output buffer offset wasn't sufficient to "rewin=
d"
> the previous encoding.  Considering that ZRLE is never larger than raw an=
d
> even though ZLIB can occasionally be fractionally larger than raw, the
> overhead of implementing this optimization correctly isn't worth it.

So just revert de3f7de7f4e257 then ...

> In my investigation, ZRLE always compresses better than ZLIB so
> prioritize ZRLE over ZLIB, even if the client hints that ZLIB is
> preferred.

... and make this a separate patch?

cheers,
  Gerd


