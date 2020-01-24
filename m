Return-Path: <SRS0=z9mi=3N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2662CC2D0DB
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 18:53:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E842E2071E
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 18:53:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e5eg5ivK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E842E2071E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46554 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iv44v-0003S9-2b
	for qemu-devel@archiver.kernel.org; Fri, 24 Jan 2020 13:53:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47627)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1iv44E-00030E-TA
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 13:52:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1iv44D-0002k4-RK
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 13:52:30 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:60448
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1iv44D-0002js-Np
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 13:52:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579891949;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=r0WTI5/39I+bxXRLmiBJUifXso7TTdvpocRQoAmwHvI=;
 b=e5eg5ivK88aApN1sFvqhemORzlh9AjgNfI3i+wKJ34RDdsuwQSkgj06AI1F6Xg2xa/eG5t
 H2UnaR3MU4I1cxBXz+S/p0eC5YyTFA1dBteIrAjSzUz3cBszgxWuQ6+v2/uznw0Qzd8NZP
 JT+fAj6WJeyf+ujbK+/UoINQ7e/gfJ0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-189-FCIV6S1eOPCcJhhqqyu_QA-1; Fri, 24 Jan 2020 13:52:24 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3950F1137840;
 Fri, 24 Jan 2020 18:52:23 +0000 (UTC)
Received: from work-vm (ovpn-117-253.ams2.redhat.com [10.36.117.253])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7DE4760BEC;
 Fri, 24 Jan 2020 18:52:11 +0000 (UTC)
Date: Fri, 24 Jan 2020 18:52:08 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: John Snow <jsnow@redhat.com>
Subject: Re: Making QEMU easier for management tools and applications
Message-ID: <20200124185208.GB2970@work-vm>
References: <878slyej29.fsf@dusky.pond.sub.org>
 <a41ae09b-021f-2fda-0b03-7b37c5624ab3@redhat.com>
 <20200123190145.GI657556@redhat.com>
 <2561a069-ce5f-3c30-b04e-db7cd2fcdc85@redhat.com>
 <871rrp474i.fsf@dusky.pond.sub.org>
 <20200124102743.GB824327@redhat.com>
 <20200124143841.GG4732@dhcp-200-226.str.redhat.com>
 <c89f4417-ca4e-d365-e795-4570200e9dae@redhat.com>
 <20200124183036.GD2969@work-vm>
 <50637c89-1c5d-ef1b-4c8c-f23de732bcbc@redhat.com>
MIME-Version: 1.0
In-Reply-To: <50637c89-1c5d-ef1b-4c8c-f23de732bcbc@redhat.com>
User-Agent: Mutt/1.13.0 (2019-11-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: FCIV6S1eOPCcJhhqqyu_QA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 207.211.31.120
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Cleber Rosa <cleber@redhat.com>,
 "Denis V. Lunev" <den@virtuozzo.com>, Stefan Hajnoczi <stefanha@gmail.com>,
 Markus Armbruster <armbru@redhat.com>, qemu-devel <qemu-devel@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Dominik Csapak <d.csapak@proxmox.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* John Snow (jsnow@redhat.com) wrote:
>=20
>=20
> On 1/24/20 1:30 PM, Dr. David Alan Gilbert wrote:
> > However, I caution that too many people think that QMP has all the type
> > of diagnostic stuff people want - it's just way too hard and beuracrati=
c
> > to add a simple diagnostic command to QMP, when you just want to add
> > something to print some diagnostics out for your corner of qemu.
>=20
> I'm not sure I follow, do you mean bureaucratic in contrast to... HMP?

I mean, someone who adds a QMP command is expected to be a lot more
careful about the long term stability and proper structures etc etc.
Where for HMP, if someone wants to add a command that's useful to the
diagnostics of their part of QEMU and doesn't break anything else, then
fine.

Dave

> --js
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


