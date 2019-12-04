Return-Path: <SRS0=xVqP=Z2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 679E7C2BC73
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2019 13:11:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3135E2073B
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2019 13:11:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NhsPy8T/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3135E2073B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38678 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1icURB-0001Hg-Cu
	for qemu-devel@archiver.kernel.org; Wed, 04 Dec 2019 08:11:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58154)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1icUQJ-0000VF-Pq
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 08:10:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1icUQH-0000Dd-8U
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 08:10:31 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:21424
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1icUQF-0008Un-5D
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 08:10:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575465021;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PvkzPMxJfN2ugJmEUKDiuJ2DHsBoTtCeDxuubBrk41s=;
 b=NhsPy8T/zCe8uj3SIT57ab2/mCJaEqfHVzPbAO5rmIxWqTq8w2+I3t+YCONfRfJN3WS2sT
 D5yFHR3MSKQ8X1BLpb9FmFXbV5SXvh+djYCOBLLZpo6Igs5UFGrJ+W7AqdNcPkcL2xq9+z
 +rmo9xDB8E0FO2O188vFvrXvgRLdeLk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-32-GLZkzULkOQCLepKx_8pNfQ-1; Wed, 04 Dec 2019 08:10:17 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 260C0107ACC4;
 Wed,  4 Dec 2019 13:10:16 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-134.ams2.redhat.com
 [10.36.116.134])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A921C5DA76;
 Wed,  4 Dec 2019 13:10:01 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 303F01138606; Wed,  4 Dec 2019 14:10:00 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Subject: Re: virtiofsd: Where should it live?
References: <20191125185021.GB3767@work-vm>
 <20191126102600.GG556568@redhat.com> <20191126121416.GE2928@work-vm>
 <CAFEAcA9Ln2uwg4f4s8oS6VeQk83W3BErmH9cHeyDJy7v-4gNxw@mail.gmail.com>
 <87k17ekhs9.fsf@dusky.pond.sub.org>
 <fef0eaaf-149a-f8a8-02c5-821d2d42becd@redhat.com>
 <20191203105341.GB3078@work-vm>
 <CAFEAcA8bjGAs7JSTNYYYwCH1yF06i0v0r9wjKXqZGZg_Sqy0VA@mail.gmail.com>
 <20191203111949.GB267814@redhat.com>
 <87o8wofsda.fsf@dusky.pond.sub.org> <20191204120418.GH3325@work-vm>
Date: Wed, 04 Dec 2019 14:10:00 +0100
In-Reply-To: <20191204120418.GH3325@work-vm> (David Alan Gilbert's message of
 "Wed, 4 Dec 2019 12:04:18 +0000")
Message-ID: <87fti09qzb.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: GLZkzULkOQCLepKx_8pNfQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 "Daniel P. =?utf-8?Q?Berrang=C3=A9?=" <berrange@redhat.com>,
 qemu-block@nongnu.org, mszeredi@redhat.com, Jason Wang <jasowang@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Max Reitz <mreitz@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 =?utf-8?Q?M?= =?utf-8?Q?arc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 vgoyal@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

"Dr. David Alan Gilbert" <dgilbert@redhat.com> writes:

> So what do you think of Paolo's suggestion of putting virtiofsd in=20
> fsdev (mkdir fsdev/9p && mv fsdev/* fsdev/9p && mkdir fsdev/virtiofsd )

No objections.

Flatter: fsdev-9p/ and fsdev-virtio/.  Matter of taste.


