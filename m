Return-Path: <SRS0=8N/K=Z4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80D43C43603
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 16:16:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D761206DF
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 16:16:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="imfGH0Gl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D761206DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40602 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1idGHG-0002Yu-Ml
	for qemu-devel@archiver.kernel.org; Fri, 06 Dec 2019 11:16:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49372)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1idExG-0005oC-Oo
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 09:51:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1idExF-0002Sr-KB
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 09:51:38 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:54614
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1idExF-0002S3-Fu
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 09:51:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575643897;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MFe6Cdfe9hqUvnITd/MyemnffkthR92vZSWDsxZGzSQ=;
 b=imfGH0GlPaRqY6wLs9lMARTMP3h3Hbk8VHJTZ7UfHuE93DLmunc6XyJjErzJNQOEDoZ2R1
 QhYsTqpNqKbaoutPiJRStjyL4uZLH74cMZLZI6miusFBqaCOyiO0ViqcgHhXXAfhV4BtK/
 Drbdwarn0S1U4Kfm8PCBDq1LeWztqWE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-82-c5G7KeeoPXmcPlrUjppY3A-1; Fri, 06 Dec 2019 01:50:11 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BF6DA107ACCA
 for <qemu-devel@nongnu.org>; Fri,  6 Dec 2019 06:50:10 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-134.ams2.redhat.com
 [10.36.116.134])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4079A19C4F;
 Fri,  6 Dec 2019 06:50:01 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id B3DC31138606; Fri,  6 Dec 2019 07:49:59 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH 0/3] Remove deprecated pc-0.x machine types and related
 hacks
References: <20191205160652.23493-1-thuth@redhat.com>
Date: Fri, 06 Dec 2019 07:49:59 +0100
In-Reply-To: <20191205160652.23493-1-thuth@redhat.com> (Thomas Huth's message
 of "Thu, 5 Dec 2019 17:06:49 +0100")
Message-ID: <874kyeosmg.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: c5G7KeeoPXmcPlrUjppY3A-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, libvir-list@redhat.com,
 qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Thomas Huth <thuth@redhat.com> writes:

> These have been on the deprecation list since a year now, so it's
> time to finally remove the pc-0.x machine types.
>
> We then can also remove some compatibility hacks in the devices, i.e.
> the "use_broken_id" in ac97 and "command_serr_enable" in PCI devices.
>
> Note that there is also the "rombar" property of the PCI devices which
> is now not required for the x86 machine types anymore. But it seems to
> me like this is still used by various people to bypass the ROM loading
> for PCI devices in certain cases, so I did not remove that property here
> yet.

With this series applied:

$ git-grep pc-0
hw/display/vga-pci.c:        /* compatibility with pc-0.13 and older */
hw/display/vga.c:    /* With pc-0.12 and below we map both the PCI BAR and =
the fixed VBE region,
hw/display/vmware_vga.c:        /* compatibility with pc-0.13 and older */
hw/i386/pc_piix.c:/* PC compat function


