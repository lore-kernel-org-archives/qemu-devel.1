Return-Path: <SRS0=QduX=3Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7413FC35247
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 15:39:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3DCF820674
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 15:39:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VyAevBBA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DCF820674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60500 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iz0It-0001xt-Eg
	for qemu-devel@archiver.kernel.org; Tue, 04 Feb 2020 10:39:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49995)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1iz0IJ-0001Wm-5S
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 10:39:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1iz0IH-0006cl-0U
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 10:39:17 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:23146
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1iz0IG-0006WX-N9
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 10:39:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580830755;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uspoKd2cNxTmLAwxzKKh5K71LksRcHNUfpIlYUs8y10=;
 b=VyAevBBAax3hKD1LBWIC00Q530aMrJMg9dfuwm5B3YXnkZwP6lP1Croi8EOXm2oIz/ClWH
 vXvZnlMfl7UX3xWJicNJonwE5D5A8zs7/8/iJQHkFz+qNciPmO4gGx8KQH3GA6HIUL/p8e
 FeuxxjTPCstpGhot8Y4GuMQcJutdDLE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-86-I14fPwicOGOet-JCxz0Smg-1; Tue, 04 Feb 2020 10:39:11 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E647C108839F
 for <qemu-devel@nongnu.org>; Tue,  4 Feb 2020 15:39:10 +0000 (UTC)
Received: from localhost (unknown [10.43.2.114])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 437E6386;
 Tue,  4 Feb 2020 15:39:10 +0000 (UTC)
Date: Tue, 4 Feb 2020 16:39:09 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: qemu-devel@nongnu.org, pbonzini@redhat.com
Subject: Re: [PATCH v4 00/80] refactor main RAM allocation to use hostmem
 backend
Message-ID: <20200204163909.5ce2cb2a@redhat.com>
In-Reply-To: <20200204160830.02afbd2e@redhat.com>
References: <1580483390-131164-1-git-send-email-imammedo@redhat.com>
 <20200204160830.02afbd2e@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: I14fPwicOGOet-JCxz0Smg-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 4 Feb 2020 16:08:30 +0100
Igor Mammedov <imammedo@redhat.com> wrote:

> On Fri, 31 Jan 2020 16:08:30 +0100
> Igor Mammedov <imammedo@redhat.com> wrote:
> 
> Paolo,

forgot to add address to CC

> 
> could you take a look at patches 1-7, 73,75-78 and
> if series looks to be in acceptable shape, merge it via your tree
> 
> > v4:
[...]


