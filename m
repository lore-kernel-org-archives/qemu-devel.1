Return-Path: <SRS0=f7ls=75=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAE7BC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 16:51:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B7CF208B8
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 16:51:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XvGUWvd/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B7CF208B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57934 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlEoY-0003Ly-RG
	for qemu-devel@archiver.kernel.org; Tue, 16 Jun 2020 12:51:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39700)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jlEnX-0002RF-8I
 for qemu-devel@nongnu.org; Tue, 16 Jun 2020 12:50:55 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:48976
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jlEnU-0003dC-L5
 for qemu-devel@nongnu.org; Tue, 16 Jun 2020 12:50:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592326251;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/40m/SXau9hSZT6cOLgCj4eLpw+OLPLjiMjW+L7lgKE=;
 b=XvGUWvd/Dyfza1zCmWSp78HOHhJS8qWzBSMznrot5wi02MTsJXKlGkrnnfmMweNzycdqwk
 fpt7QdHreurox9RYHf433LFwI1KPdlDrm4gW3EM+nA/FCdeKJAgsVYXyPR1SOigW/dHlqb
 LylzW6iaCUu+Lykp9ov7Q2QIGjR21W0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-290-_jFSyfJOPf-Y1IfeZFgCmg-1; Tue, 16 Jun 2020 12:50:46 -0400
X-MC-Unique: _jFSyfJOPf-Y1IfeZFgCmg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C20F310AEA01;
 Tue, 16 Jun 2020 16:50:44 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-112-67.ams2.redhat.com
 [10.36.112.67])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5A1865C1BD;
 Tue, 16 Jun 2020 16:50:44 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 7A13216E18; Tue, 16 Jun 2020 18:50:43 +0200 (CEST)
Date: Tue, 16 Jun 2020 18:50:43 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
To: "Guilherme G. Piccoli" <gpiccoli@canonical.com>
Subject: Re: ovmf / PCI passthrough impaired due to very limiting PCI64
 aperture
Message-ID: <20200616165043.24y2cp53axk7uggy@sirius.home.kraxel.org>
References: <99779e9c-f05f-501b-b4be-ff719f140a88@canonical.com>
MIME-Version: 1.0
In-Reply-To: <99779e9c-f05f-501b-b4be-ff719f140a88@canonical.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=kraxel@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/16 02:45:54
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: pedro.principeza@canonical.com, ehabkost@redhat.com,
 dann.frazier@canonical.com, qemu-devel@nongnu.org,
 christian.ehrhardt@canonical.com, dgilbert@redhat.com, lersek@redhat.com,
 fw@gpiccoli.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

  Hi,

> (a) We could rely in the guest physbits to calculate the PCI64 aperture.

I'd love to do that.  Move the 64-bit I/O window as high as possible and
use -- say -- 25% of the physical address space for it.

Problem is we can't.

> failure. Also, if the users are not setting the physbits in the guest,
> there must be a default (seems to be 40bit according to my experiments),
> seems to be a good idea to rely on that.

Yes, 40 is the default, and it is used *even if the host supports less
than that*.  Typical values I've seen for intel hardware are 36 and 39.
39 is used even by recent hardware (not the xeons, but check out a
laptop or a nuc).

> If guest physbits is 40, why to have OVMF limiting it to 36, right?

Things will explode in case OVMF uses more physbits than the host
supports (host physbits limit applies to ept too).  In other words: OVMF
can't trust the guest physbits, so it is conservative to be on the safe
side.

If we can somehow make a *trustable* physbits value available to the
guest, then yes, we can go that route.  But the guest physbits we have
today unfortunately don't cut it.

take care,
  Gerd


