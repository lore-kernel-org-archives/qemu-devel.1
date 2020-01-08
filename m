Return-Path: <SRS0=peXq=25=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E611EC282DD
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 19:08:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B47CA206DB
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 19:08:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RyiQGd1D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B47CA206DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48204 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipGgw-0006uc-RS
	for qemu-devel@archiver.kernel.org; Wed, 08 Jan 2020 14:08:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60613)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <quintela@redhat.com>) id 1ipGgA-0006TC-Jk
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 14:07:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <quintela@redhat.com>) id 1ipGg8-00072z-4o
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 14:07:40 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:54270
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <quintela@redhat.com>) id 1ipGg7-00070z-Kr
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 14:07:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578510458;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ODHbSgO0j+hboYZIB5j0laro593dYqw0dcGH0hdhIeY=;
 b=RyiQGd1DYNg9T4roqdRPn9TV7EgfkXgiot89bEV1SGwOC60rLTyeMcq1K2EEysSOeh2eSU
 02/0i/31OeI44Ofw9zFfckQFzPwCeaMWnbyaGrVkj4G+RpsANjAdiu7oZObvHMO9jVMiyG
 aOwJ3Z6WmJgF8AMIoPsok95vpJVk3+w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-112-X3Sv4ex9OXyrGsYa4YqjoQ-1; Wed, 08 Jan 2020 14:07:35 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1B9CA10054E3;
 Wed,  8 Jan 2020 19:07:34 +0000 (UTC)
Received: from redhat.com (ovpn-116-97.ams2.redhat.com [10.36.116.97])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 39F137C370;
 Wed,  8 Jan 2020 19:07:32 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: Scott Cheloha <cheloha@linux.vnet.ibm.com>
Subject: Re: [PATCH v2 1/2] migration: add savevm_state_handler_remove()
In-Reply-To: <20191017205953.13122-2-cheloha@linux.vnet.ibm.com> (Scott
 Cheloha's message of "Thu, 17 Oct 2019 15:59:52 -0500")
References: <20191017205953.13122-1-cheloha@linux.vnet.ibm.com>
 <20191017205953.13122-2-cheloha@linux.vnet.ibm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
Date: Wed, 08 Jan 2020 20:07:13 +0100
Message-ID: <87tv5522e6.fsf@secure.laptop>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: X3Sv4ex9OXyrGsYa4YqjoQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Reply-To: quintela@redhat.com
Cc: qemu-devel@nongnu.org, "Dr . David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Scott Cheloha <cheloha@linux.vnet.ibm.com> wrote:
> Create a function to abstract common logic needed when removing a
> SaveStateEntry element from the savevm_state.handlers queue.
>
> For now we just remove the element.  Soon it will involve additional
> cleanup.
>
> Signed-off-by: Scott Cheloha <cheloha@linux.vnet.ibm.com>

Reviewed-by: Juan Quintela <quintela@redhat.com>

queued


