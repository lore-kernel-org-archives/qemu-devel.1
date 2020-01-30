Return-Path: <SRS0=hbhd=3T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2EDFC33C9E
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 08:05:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 967E820702
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 08:05:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FHKWk2jy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 967E820702
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57014 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ix4pW-0003nH-OC
	for qemu-devel@archiver.kernel.org; Thu, 30 Jan 2020 03:05:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51403)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1ix4oq-0003Hf-Pw
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 03:04:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1ix4op-00020i-Su
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 03:04:56 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:24742
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1ix4op-0001z2-PN
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 03:04:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580371495;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uJ70q+sXoYEQKaGGJj7AMqehBgteFNggGPgWXEIjqUg=;
 b=FHKWk2jy56J+l9JNmvAnWcjWek1klKIEhN/eIrBp8s6dc1TPTWGTjrM5WjhgQXUQpInpNR
 JBP6hUsfITtYWMEVWaFmRIASlnUb1dR2fXxPrwNZ9XV1q4RO+Yp+7FlG6OExuvFj5e+sBI
 32O0wiOhY5+kipELxmHnhfO7DFXtXuQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-50-v8ix7-gaPR-fbPkOI9Y8Dw-1; Thu, 30 Jan 2020 03:04:53 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 71C038010E1
 for <qemu-devel@nongnu.org>; Thu, 30 Jan 2020 08:04:52 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-131.ams2.redhat.com
 [10.36.116.131])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 08A4A68880;
 Thu, 30 Jan 2020 08:04:51 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id C93321138404; Thu, 30 Jan 2020 09:04:49 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Juan Quintela <quintela@redhat.com>
Subject: Re: [PATCH v5 5/8] multifd: Add zlib compression multifd support
References: <20200129115655.10414-1-quintela@redhat.com>
 <20200129115655.10414-6-quintela@redhat.com>
Date: Thu, 30 Jan 2020 09:04:49 +0100
In-Reply-To: <20200129115655.10414-6-quintela@redhat.com> (Juan Quintela's
 message of "Wed, 29 Jan 2020 12:56:52 +0100")
Message-ID: <87a765xtcu.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: v8ix7-gaPR-fbPkOI9Y8Dw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 "Daniel P. =?utf-8?Q?Berrang=C3=A9?=" <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org, "Dr. David
 Alan Gilbert" <dgilbert@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Juan Quintela <quintela@redhat.com> writes:

> Signed-off-by: Juan Quintela <quintela@redhat.com>

For QAPI:
Acked-by: Markus Armbruster <armbru@redhat.com>


