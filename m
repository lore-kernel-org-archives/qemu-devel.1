Return-Path: <SRS0=2jXw=3K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAD4FC2D0CE
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 13:57:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B2C4D21569
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 13:57:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UqUYNJXG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2C4D21569
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54440 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itu2G-0007LH-II
	for qemu-devel@archiver.kernel.org; Tue, 21 Jan 2020 08:57:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54946)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1itswu-0003nB-Gl
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 07:48:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1itswq-0005J1-RA
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 07:48:04 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:48713
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1itswm-0005GE-M6
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 07:48:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579610875;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cA8lwlkG/wvH17sR9oaAHe7pnVPQ3ttOFdMo7rL4+rc=;
 b=UqUYNJXGfo5IYrN6EeRphkxtoZ8wMuRU471nLO/I4P6ryg91QuxblLUZ7yNcT3rybAhgmB
 vLzuBShAh99DHYRisqJAoP5oX0IVL1vaXjB7Eh176Zh8pwQ2psOHHlYfciiGsggJP/SO/n
 l3JEzLmf0MMEZfPdRdy5rSpduyGLFLc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-40-JU11Mu9UPOKep-jxUp3rrw-1; Tue, 21 Jan 2020 07:47:49 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 57A50190D341;
 Tue, 21 Jan 2020 12:47:48 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-131.ams2.redhat.com
 [10.36.116.131])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 61D1E86423;
 Tue, 21 Jan 2020 12:47:43 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 13D3F1138600; Tue, 21 Jan 2020 13:47:42 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Subject: Re: [PATCH v2 00/10] Cleanups around the 'current_machine' global
 variable
References: <20200121110349.25842-1-philmd@redhat.com>
Date: Tue, 21 Jan 2020 13:47:42 +0100
In-Reply-To: <20200121110349.25842-1-philmd@redhat.com> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Tue, 21 Jan 2020 12:03:39
 +0100")
Message-ID: <87ftg9dlht.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: JU11Mu9UPOKep-jxUp3rrw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Marcelo Tosatti <mtosatti@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 Like Xu <like.xu@linux.intel.com>, David Hildenbrand <david@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, qemu-devel@nongnu.org,
 qemu-s390x@nongnu.org, qemu-arm@nongnu.org, qemu-ppc@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:

> v1 was "Replace current_machine by qdev_get_machine()":
> https://www.mail-archive.com/qemu-devel@nongnu.org/msg669611.html
>
> But Markus objected, see:
> https://www.mail-archive.com/qemu-devel@nongnu.org/msg670122.html
> and older discussion:
> https://www.mail-archive.com/qemu-devel@nongnu.org/msg611338.html
>
> This series salvage patches from v1, and add other trivial cleanups.
>
> Can the ARM/PPC/S390 patches could go via their own tree, and the
> rest via Paolo's 'misc' tree?
>
> Supersedes: <20200109152133.23649-1-philmd@redhat.com>

Separating off uncontroversial patches is always a good idea.  These all
look okay to me on first glance, with one minor remark on PATCH 7.  I
think you got or are likely to get competent review for all of them.  If
you need me to have a closer look, just ask.

Thanks!


