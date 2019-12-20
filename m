Return-Path: <SRS0=uEni=2K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BB13C43603
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 13:32:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 24BC5206DA
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 13:32:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JgWmrhjT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24BC5206DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55806 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iiINu-0002yC-Ba
	for qemu-devel@archiver.kernel.org; Fri, 20 Dec 2019 08:32:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36429)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1iiIHt-0003KR-7H
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 08:25:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1iiIHr-0006Oj-5l
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 08:25:47 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:45805
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1iiIHo-0006Id-Ij
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 08:25:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576848341;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xP6ZNvU3p4VNzD0xUSwdP2abxVGRKcAb23hyeO2ftw4=;
 b=JgWmrhjTF/b5PP1BF9JCqKjAwuzXi6dR3AYsq2JDRt1crurzMyxYA26Z/xv4rJDFJu/sE5
 eRBiSteSsbq9Z5DVLuj9ZkhfGEhiGwtEliqDz2Ly21LhJ74rmJFS3/hiS2v3+PJeKoRM/l
 UYUeE9grku1pjVE91R0eZWH4jcechNI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-381-h_EWPvN1MISkdbs-vqsIgw-1; Fri, 20 Dec 2019 08:25:37 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DD473800D4C;
 Fri, 20 Dec 2019 13:25:36 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-42.ams2.redhat.com
 [10.36.116.42])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id AC72210016E8;
 Fri, 20 Dec 2019 13:25:36 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id A0F2911386A7; Fri, 20 Dec 2019 14:25:34 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Subject: Re: [PATCH 02/18] fuse: Allow exporting BDSs via FUSE
References: <20191219143818.1646168-1-mreitz@redhat.com>
 <20191219143818.1646168-3-mreitz@redhat.com>
 <20191220102656.GD4019@dhcp-200-226.str.redhat.com>
 <1812e968-1197-523e-7039-caf29e3bbc4b@redhat.com>
 <20191220112402.GE4019@dhcp-200-226.str.redhat.com>
 <87pngjgo2h.fsf@dusky.pond.sub.org>
 <20191220125839.GG4019@dhcp-200-226.str.redhat.com>
Date: Fri, 20 Dec 2019 14:25:34 +0100
In-Reply-To: <20191220125839.GG4019@dhcp-200-226.str.redhat.com> (Kevin Wolf's
 message of "Fri, 20 Dec 2019 13:58:39 +0100")
Message-ID: <877e2rf7sh.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: h_EWPvN1MISkdbs-vqsIgw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Kevin Wolf <kwolf@redhat.com> writes:

> Am 20.12.2019 um 13:48 hat Markus Armbruster geschrieben:
>> Kevin Wolf <kwolf@redhat.com> writes:
>>=20
>> > Am 20.12.2019 um 11:48 hat Max Reitz geschrieben:
>> >> So if we kept writable and growable in the common base, then the sche=
ma
>> >> would give no information about what exports actually support them.
>> >>=20
>> >> On one hand, I don=E2=80=99t know whether it=E2=80=99s important to h=
ave this
>> >> information in a static form, or whether it=E2=80=99s sufficient to l=
earn at
>> >> runtime.
>> >>=20
>> >> On the other, I don=E2=80=99t know whether it=E2=80=99s important to =
have those fields
>> >> in the base or not.  Would it make a difference on the wire?
>> >
>> > Not for the command itself, so I think we're free to change it later. =
It
>> > might make a difference for introspection, though, not sure. Markus?
>>=20
>> QAPI schema introspection is designed to hide the difference between
>> local members and base members.  You can move members to or from a base
>> type freely without affecting introspection.  Even if that creates or
>> deletes the base type.
>
> Good, that's helpful. So I can split the nbd-server-add argument type
> into a base that is reused as a union branch and the rest without
> potentially breaking anything.
>
> I suppose moving a field between a union base and all variants does
> still result in different introspection even though the accepted inputs
> are the same.

Correct.  A common member (whether it's local or from the base) is in
SchemaInfoObject.members[].  Moving it to all the variants moves it to
the variant types' .members[].

>               Is this kind of movement still allowed unconditionally or
> should we be more careful with something like this?

QMP's backward compatibility promise does not include "introspection
value won't change".  Still, such changes can conceivably confuse
clients.  Care is advisable.  But it's not a hard "no".


