Return-Path: <SRS0=vczr=7A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 860E5C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 13:17:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5455820671
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 13:17:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MxQ8Lwid"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5455820671
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35950 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jafe8-0007vp-Hm
	for qemu-devel@archiver.kernel.org; Mon, 18 May 2020 09:17:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58318)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jafdW-0007QP-Ov
 for qemu-devel@nongnu.org; Mon, 18 May 2020 09:16:54 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:57448
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jafdV-0005kt-E2
 for qemu-devel@nongnu.org; Mon, 18 May 2020 09:16:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589807811;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=iValZqaVvWoc04Zpty13WXkghh7WTL2ioU79eSCJYX8=;
 b=MxQ8Lwidl82znCIHsJgw6EmmC8X3TQGZ0D8LFdi22+kteAd/F7YDOuuunjIe2M4dRv/7cC
 VyYjUuK3Emf1fu+5tD3u8nRLc7zQJBL+A3uRUW9uV2Td88MFZYqlJ5d85UbKeiJ7XnqXPf
 Au1H1uJ57ChrmDBVqm0eoqYIELZVG4g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-168-DjvOEUl3Pc67BtTpSImzUg-1; Mon, 18 May 2020 09:16:50 -0400
X-MC-Unique: DjvOEUl3Pc67BtTpSImzUg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 374CB1054F90
 for <qemu-devel@nongnu.org>; Mon, 18 May 2020 13:16:49 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-32.ams2.redhat.com
 [10.36.112.32])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D687C100164D;
 Mon, 18 May 2020 13:16:43 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 4A2D511358BC; Mon, 18 May 2020 15:16:42 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH v2 11/13] audio: deprecate -soundhw pcspk
References: <20200515143528.13591-1-kraxel@redhat.com>
 <20200515143528.13591-12-kraxel@redhat.com>
 <20200515150823.GA738369@lpt>
 <20200518101628.3j4d6hwq6pitjfo3@sirius.home.kraxel.org>
 <20200518102650.GG1430944@redhat.com>
 <20200518112448.7lwjol4elj4d76bq@sirius.home.kraxel.org>
 <20200518125935.zwrpaqwh7dwd3p4p@sirius.home.kraxel.org>
Date: Mon, 18 May 2020 15:16:42 +0200
In-Reply-To: <20200518125935.zwrpaqwh7dwd3p4p@sirius.home.kraxel.org> (Gerd
 Hoffmann's message of "Mon, 18 May 2020 14:59:35 +0200")
Message-ID: <87mu659ydh.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Received-SPF: pass client-ip=205.139.110.120; envelope-from=armbru@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/17 22:51:00
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: =?utf-8?Q?J=C3=A1n?= Tomko <jtomko@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, libvir-list@redhat.com,
 "Daniel P. =?utf-8?Q?Berrang=C3=A9?=" <berrange@redhat.com>,
 qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Gerd Hoffmann <kraxel@redhat.com> writes:

>   Hi,
>
>> Initialization order looks tricky though.  I'd have to create pcspk
>> early, simliar to flash, in pc_machine_initfn().  Problem is I don't
>> have a isa bus yet at that point (flash is sysbus and doesn't have this
>> problem).  I'm open to suggestions hiow do deal with that best.
>
> Seems I've found a way to deal with that: "ISADevice *pcspk =
> object_new(TYPE_PC_SPEAKER);" can be done before the isa bus exists
> & we can fixup things later using qdev_set_parent_bus().

You'll want to watch out for the series I hope to post shortly: it'll be
dev = qdev_new(TYPE_PC_SPEAKER); qdev_realize(dev, bus, errp) then.  No
need for qdev_set_parent_bus().


