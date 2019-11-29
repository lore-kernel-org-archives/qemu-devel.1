Return-Path: <SRS0=xfvu=ZV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20CEEC432C0
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2019 20:45:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D3A54207FA
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2019 20:45:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YDa51klN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3A54207FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35070 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ian8Z-0004TD-1q
	for qemu-devel@archiver.kernel.org; Fri, 29 Nov 2019 15:45:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53116)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ehabkost@redhat.com>) id 1iamve-0007Ur-Ru
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 15:31:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ehabkost@redhat.com>) id 1iamvT-0002sH-Mf
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 15:31:47 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:59227
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1iamvJ-0002YW-S5
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 15:31:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575059487;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4QT2SNijlEK+OE4il375qLEgx/y+umh/ROw1uXgOVs4=;
 b=YDa51klNnWWtQ/E6mioAk0GQPU+2i2a3DLXeuJglu/U0OT4CoymYgRuqv9nUZgGPDRoxB6
 K8mr657wTFUj+dTRbd4Z0TbI86D0V3wZBlE64q3PPLUhBHp8ZAdq0nG2z0un8+R3RxXjvv
 oRHSjzcwmPMzTizqv7GOxwlcEeUPBn0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-46-o3iOzgFWOeO7-T980xms9w-1; Fri, 29 Nov 2019 15:31:24 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1D22810054E3;
 Fri, 29 Nov 2019 20:31:23 +0000 (UTC)
Received: from localhost (ovpn-116-90.gru2.redhat.com [10.97.116.90])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 381986090B;
 Fri, 29 Nov 2019 20:31:20 +0000 (UTC)
Date: Fri, 29 Nov 2019 17:31:18 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH 2/2] Add -mem-shared option
Message-ID: <20191129203118.GJ14595@habkost.net>
References: <20191128141518.628245-1-marcandre.lureau@redhat.com>
 <20191128141518.628245-3-marcandre.lureau@redhat.com>
 <20191128172807.788e6aeb@redhat.com>
 <CAJ+F1CLZxhMf-bOAB4sVfuB1yaUMqiO70-ogpKVS3CqfC7y5KA@mail.gmail.com>
 <20191129110703.2b15c541@redhat.com>
 <04dadf85-cd35-fd37-9642-8087cba625bd@redhat.com>
 <87imn2uc0d.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
In-Reply-To: <87imn2uc0d.fsf@dusky.pond.sub.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: o3iOzgFWOeO7-T980xms9w-1
X-Mimecast-Spam-Score: 0
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
Cc: QEMU <qemu-devel@nongnu.org>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@gmail.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Nov 29, 2019 at 01:01:54PM +0100, Markus Armbruster wrote:
> Paolo Bonzini <pbonzini@redhat.com> writes:
>=20
> > On 29/11/19 11:07, Igor Mammedov wrote:
> >>>> So user who wants something non trivial could override default
> >>>> non-numa behavior with
> >>>>   -object memory-backend-file,id=3Dmem,size=3D4G,mem-path=3D/dev/shm=
,share=3Don \
> >>>>   -machine memdev=3Dmem
> >>>> or use any other backend that suits theirs needs. =20
> >>> That's nice, but not as friendly as a simple -mem-shared.
> >> (I still do not like idea of convenience options but it won't
> >> get onto the way much if implemented as "global property" to memdev,
> >> so I won't object if there is real demand for it)
> >
> > I agree with Igor, we should always think about the generic ("object
> > model") options and only then add convenience option.
>=20
> +1

I agree with this.  I just hope we don't forget about the second
part.

--=20
Eduardo


