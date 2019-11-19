Return-Path: <SRS0=aBJE=ZL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D171FC432C0
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 07:22:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C30F222DE
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 07:22:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NZ6m+9qX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C30F222DE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42224 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iWxpt-0005fr-IF
	for qemu-devel@archiver.kernel.org; Tue, 19 Nov 2019 02:22:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42470)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1iWxp1-00059v-PL
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 02:21:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1iWxp0-0003Qm-KC
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 02:21:11 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:22059
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1iWxp0-0003QF-8Z
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 02:21:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574148068;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=txeO7NB+kzAEVp/oTlNkB1iSa7fy2pFwpseicNQuOJw=;
 b=NZ6m+9qXkplITTyzavYR9YEUPVw6gDEIwus62xiCLNJ/djGLHJC1vlhTgZTFmAF/jxI7Sm
 tKWLJLwMZKCN8vPRAOrtajj2cD4PjdgC/rjAtJrs0Oa9zEAJ78y91asYDf9G/KPZW55ph8
 E+TH6Q0eevI3ipc42yN20PBjtKIE1rU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-402-61HLiR2wOgSZVCPHu_TIhA-1; Tue, 19 Nov 2019 02:21:07 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6DCCD800A02;
 Tue, 19 Nov 2019 07:21:06 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.36.118.163])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4AD3D29362;
 Tue, 19 Nov 2019 07:21:00 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id C97771138606; Tue, 19 Nov 2019 08:20:58 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Wolfgang Bumiller <w.bumiller@proxmox.com>
Subject: Re: [PATCH v3 for-4.2] monitor/qmp: resume monitor when clearing its
 queue
References: <20191115085914.21287-1-w.bumiller@proxmox.com>
Date: Tue, 19 Nov 2019 08:20:58 +0100
In-Reply-To: <20191115085914.21287-1-w.bumiller@proxmox.com> (Wolfgang
 Bumiller's message of "Fri, 15 Nov 2019 09:59:14 +0100")
Message-ID: <87v9rg9vs5.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: 61HLiR2wOgSZVCPHu_TIhA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
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
Cc: Michael Roth <mdroth@linux.vnet.ibm.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Wolfgang Bumiller <w.bumiller@proxmox.com> writes:

> When a monitor's queue is filled up in handle_qmp_command()
> it gets suspended. It's the dispatcher bh's job currently to
> resume the monitor, which it does after processing an event
> from the queue. However, it is possible for a
> CHR_EVENT_CLOSED event to be processed before before the bh
> is scheduled, which will clear the queue without resuming
> the monitor, thereby preventing the dispatcher from reaching
> the resume() call.
> Any new connections to the qmp socket will be accept()ed and
> show the greeting, but will not respond to any messages sent
> afterwards (as they will not be read from the
> still-suspended socket).
> Fix this by resuming the monitor when clearing a queue which
> was filled up.
>
> Signed-off-by: Wolfgang Bumiller <w.bumiller@proxmox.com>

Reviewed-by: Markus Armbruster <armbru@redhat.com>

I'm going to prepare a pull request for today's -rc2.


