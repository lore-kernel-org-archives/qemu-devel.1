Return-Path: <SRS0=PCRa=3C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9DB5C33CA9
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jan 2020 16:21:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F7552080D
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jan 2020 16:21:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DpbE5CVa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F7552080D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52480 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ir2T1-0000ax-C6
	for qemu-devel@archiver.kernel.org; Mon, 13 Jan 2020 11:21:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47161)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1ir2Pe-0006Gf-SK
 for qemu-devel@nongnu.org; Mon, 13 Jan 2020 11:17:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1ir2Pd-00088K-Ne
 for qemu-devel@nongnu.org; Mon, 13 Jan 2020 11:17:58 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:27814
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1ir2Pd-00087j-Jg
 for qemu-devel@nongnu.org; Mon, 13 Jan 2020 11:17:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578932277;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6+bqcGeLP31SMXqTxwduepgdpkxzKRJ7guSr7EFMmwc=;
 b=DpbE5CVaArP52ct1ctj2mDjNRtukJuWARdepYUjnQ/hYMVtUt4JwwxyLP/cbv/KZV698gM
 jAWLL1EgDT1M66V6m0MKOjNUwLpZ09owH+f+iB1HSAuu4gLSEO209cbuLpRCX+UZ1IV7Qh
 ycrwEI/Rj66GuQtA0JCe01/aVRkTvGg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-414-bNZGqzEjMK-gMtCh4TdeWQ-1; Mon, 13 Jan 2020 11:17:56 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4C7C2801E76;
 Mon, 13 Jan 2020 16:17:55 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-131.ams2.redhat.com
 [10.36.116.131])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 48FBF60BE2;
 Mon, 13 Jan 2020 16:17:48 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id D089A1138600; Mon, 13 Jan 2020 17:17:46 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: Priority of -accel
References: <20200106130951.29873-1-philmd@redhat.com>
 <c493e693-13a7-7dc4-eb2d-5dbc7b3053f1@redhat.com>
 <12334054-4ae7-e580-9727-2d322bfa2bda@redhat.com>
 <1A5859EA-4403-4921-B527-DFD07C59C702@redhat.com>
 <360fa010-ba80-b02b-3a35-19c2b48a462d@redhat.com>
Date: Mon, 13 Jan 2020 17:17:46 +0100
In-Reply-To: <360fa010-ba80-b02b-3a35-19c2b48a462d@redhat.com> (Paolo
 Bonzini's message of "Tue, 7 Jan 2020 15:37:35 +0100")
Message-ID: <87d0bnwct1.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: bNZGqzEjMK-gMtCh4TdeWQ-1
X-Mimecast-Spam-Score: 0
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
Cc: Kevin Wolf <kwolf@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Daniel Berrange <berrange@redhat.com>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org, Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Max Reitz <mreitz@redhat.com>, Christophe de Dinechin <dinechin@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Paolo Bonzini <pbonzini@redhat.com> writes:

> On 07/01/20 14:55, Christophe de Dinechin wrote:
>> So what about ranking the accelerators, so that all combinaisons
>> -accel=3Dkvm:tcg, -accel=3Dtcg:kvm, -accel kvm -accel tcg, etc would
>
> (I assume you mean "-machine accel=3Dkvm:tcg" and "-machine accel=3Dtcg:k=
vm"
> for the first two.  This is the "older" way which has now become sugar
> for "-accel kvm -accel tcg").
>
>> all pickup kvm if available, and tcg as a fallback? Implementation-wise,
>> it would simply mean ranking the accelerators and updating the accelerat=
or
>> only if it=E2=80=99s available and better.
>
> This is an interesting idea.  I like this better than "-accel best",
> because "-accel best" has the problem that you can't add suboptions to
> it (the suboptions for the various accelerators are disjoint).
>
> It would break backwards compatibility for "-machine accel=3Dtcg:kvm",
> which so far meant "use TCG if compiled in, otherwise use KVM".  This is
> not something I would have a problem with... except that "tcg:kvm" is
> the default if no -accel option is provided!

Perfect opportunity to change the default to something more useful.


