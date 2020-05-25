Return-Path: <SRS0=XKWp=7H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE5B8C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2020 13:47:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A7E1F207C3
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2020 13:47:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cp/eyWuf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7E1F207C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45636 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdDRq-00073b-U4
	for qemu-devel@archiver.kernel.org; Mon, 25 May 2020 09:47:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44694)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1jdDQ0-0006F5-7O
 for qemu-devel@nongnu.org; Mon, 25 May 2020 09:45:28 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:43433
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1jdDPw-000837-Oz
 for qemu-devel@nongnu.org; Mon, 25 May 2020 09:45:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590414322;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Dw2U/ySOWFqYPvOSOrmV1uE/IkH6FXOj5h7xIVtFtNI=;
 b=cp/eyWufR6BOiD9GokBKgCSWzZfUyUWCIKbZH4hQMH12b2CnHdtvKK90foCZMSkEK/SjMb
 T4uiRaaI0hNWjyMJt/Lej0MqtwdqZVsCT+BDgbBQuSTC9lOiBf54lfrXxgclvPL5M5oTHA
 bBV4gvfJUo7LpBm1l2LNZHXRPxXcEgY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-204-4nfVhKK8NnyXNeis2S7iyg-1; Mon, 25 May 2020 09:45:12 -0400
X-MC-Unique: 4nfVhKK8NnyXNeis2S7iyg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BE32E460;
 Mon, 25 May 2020 13:45:10 +0000 (UTC)
Received: from nas.mammed.net (unknown [10.40.195.242])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B8BB919D61;
 Mon, 25 May 2020 13:45:08 +0000 (UTC)
Date: Mon, 25 May 2020 15:45:05 +0200
From: Igor Mammedow <imammedo@redhat.com>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Subject: Re: [RFC PATCH] hw/sparc/sun4m: Use memdev backend for main RAM
Message-ID: <20200525154505.3d64c0a5@nas.mammed.net>
In-Reply-To: <aa0afa5a-9d71-69b6-0a34-5a829d974878@ilande.co.uk>
References: <20200510113505.10500-1-f4bug@amsat.org>
 <20200514120951.3588bc30@redhat.com>
 <58238d26-a9dc-0cc0-749d-6230d2646f75@amsat.org>
 <20200520120709.558a52ba@nas.mammed.net>
 <aa0afa5a-9d71-69b6-0a34-5a829d974878@ilande.co.uk>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.120; envelope-from=imammedo@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/25 01:44:10
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <f4bug@amsat.org>,
 Artyom Tarasenko <atar4qemu@gmail.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 25 May 2020 10:02:00 +0100
Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk> wrote:

> On 20/05/2020 11:07, Igor Mammedow wrote:
>=20
> > On Thu, 14 May 2020 14:13:11 +0200
> > Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> wrote:
> >  =20
> >> On 5/14/20 12:09 PM, Igor Mammedov wrote: =20
> >>> On Sun, 10 May 2020 13:35:05 +0200
> >>> Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> wrote:
> >>>    =20
> >>>> Since commit 82b911aaff3, machine_run_board_init() checks for
> >>>> ram_memdev_id and consume it. As TYPE_SUN4M_MEMORY is no more
> >>>> needed, replace it by the generic memdev allocated MemoryRegion
> >>>> and remove it. This completes commit b2554752b1da7c8f.   =20
> >>>
> >>> I don't get justification here.
> >>> You are removing 'frontend' device model that has little/nothing
> >>> to do with how backend is instantiated.
> >>>
> >>> TYPE_SUN4M_MEMORY is analog to pc-dimm, only for builtin RAM
> >>> (not really useful but could serve as an example).   =20
> >>
> >> I have no idea about the benefits of using memory frontend/backend
> >> with emulation. Is there documentation and examples? I'm seeing
> >> this code as a complicated way of doing a simple thing, but I
> >> guess I'm missing the big picture here. =20
> >=20
> > Examples are pc-dimm and nv-dimm which thanks to separation easily
> > reusable across pc/spapr/virt-arm.
> >=20
> > Having frontend is also useful for mgmt purposes, where HMP/QMP
> > just has to enumerate all RAM devices, otherwise boards would have
> > to provide a callback to describe their custom mappings.
> >=20
> > But for embed boards with a single blob of RAM nailed down,
> > having frontend is probably overkill (at least ATM).
> > So I'm fine with this patch /with amended commit message/ =20
>=20
> I don't feel too strongly about this, however if there is a standard
> way of doing things then I would prefer to do that since it makes it
> easier for me as a maintainer if there are existing (and up-to-date)
> examples that I can use as a reference.
>=20
> Presumably it also means that if HMP/QMP commands are added in
> relation to machine RAM then the SPARC machines would get that new
> functionality automatically...
I'm afraid there is no standard way to do it yet.
Even for virt targeted boards we have a mix of
  1. explicit mapping of memory region (arm/virt, x86, spapr),
     -m/-machine memory-backend CLI options
          (with optional partitioning of it internally, using aliases
          (pc/q35, some other embed boards))=20
     which now maps auto-created or user provided hostmem back-end
     memory region=20
     This area is quite a mess.
  2. device based RAM in guise of pc-dimm or nv-dimm, where user
     explicitly provides hostmem back-end and pairing it
     with [pc|nv]-dimm frontend on CLI (i.e. like on real hardware
     machines).

Theoretically you can reuse pc-dimm if whole dimm maps into VM address
space. It will get accounted in HMP info commands automatically. But
it hasn't been done for main RAM on any machine yet so thta's an area
to experiment with. which opens questions:
 * how to map -m/-machine memory-backend to frontend
 * or maybe ditch -m and force user to specify all DIMMs on CLI
   explicitly.

>=20
> ATB,
>=20
> Mark.
>=20


