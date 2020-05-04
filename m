Return-Path: <SRS0=Vgkn=6S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B39EC3A5A9
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 09:09:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 23AF22054F
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 09:09:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MqAqZ/rV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23AF22054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60798 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVX6q-0003mw-9l
	for qemu-devel@archiver.kernel.org; Mon, 04 May 2020 05:09:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47140)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jVX6B-0003NC-ID
 for qemu-devel@nongnu.org; Mon, 04 May 2020 05:09:15 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:38305
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jVX69-0006J4-8p
 for qemu-devel@nongnu.org; Mon, 04 May 2020 05:09:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588583351;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xBY6AgKEe4L49+Tl/h0/fHpw6Mfbs18D9m+l35ASgIY=;
 b=MqAqZ/rVOw3+D6NUpUhGUXpLQh16Km8LoxPeFvQZ+eSiN3ipqLwNGCmrDrbFSj9RensiKt
 dw+IPsVX2Te5KBOHtJaqgdjN7IrOeY2vFi+NsjzFUv+vLcfRpNHCWa6hwWitYvlvfidGhQ
 5MRuZ/LXR1D9Cfa6CGIGa7WlnWBHFNc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-297-WrIVwJvUMjezIEDVCkOvOw-1; Mon, 04 May 2020 05:09:03 -0400
X-MC-Unique: WrIVwJvUMjezIEDVCkOvOw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2A0661895A2D;
 Mon,  4 May 2020 09:09:02 +0000 (UTC)
Received: from redhat.com (unknown [10.36.110.51])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id EAADD5D9D5;
 Mon,  4 May 2020 09:08:59 +0000 (UTC)
Date: Mon, 4 May 2020 10:08:55 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Subject: Re: [RFC patch v1 2/3] qemu-file: add buffered mode
Message-ID: <20200504090855.GA115875@redhat.com>
References: <1586776334-641239-1-git-send-email-dplotnikov@virtuozzo.com>
 <1586776334-641239-3-git-send-email-dplotnikov@virtuozzo.com>
 <20200427121433.GI2923@work-vm>
MIME-Version: 1.0
In-Reply-To: <20200427121433.GI2923@work-vm>
User-Agent: Mutt/1.13.4 (2020-02-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=berrange@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/04 05:09:11
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FROM_EXCESS_BASE64=0.979, RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: den@openvz.org, Denis Plotnikov <dplotnikov@virtuozzo.com>,
 qemu-devel@nongnu.org, quintela@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Apr 27, 2020 at 01:14:33PM +0100, Dr. David Alan Gilbert wrote:
> * Denis Plotnikov (dplotnikov@virtuozzo.com) wrote:
> > The patch adds ability to qemu-file to write the data
> > asynchronously to improve the performance on writing.
> > Before, only synchronous writing was supported.
> >=20
> > Enabling of the asyncronous mode is managed by new
> > "enabled_buffered" callback.
>=20
> It's a bit invasive isn't it - changes a lot of functions in a lot of
> places!
> The multifd code separated the control headers from the data on separate
> fd's - but that doesn't help your case.
>=20
> Is there any chance you could do this by using the existing 'save_page'
> hook (that RDMA uses).
>=20
> In the cover letter you mention direct qemu_fflush calls - have we got a
> few too many in some palces that you think we can clean out?

When I first introduced the QIOChannel framework, I hoped that we could
largely eliminate QEMUFile as a concept.  Thus I'm a bit suspicious of
the idea of introducing more functionality to QEMUFile, especially as the
notion of buffering I/O is rather generic. Is there scope for having a
QIOChannelBuffered object for doing buffering. Would that provide better
isolation from the migration code and thus be less invasive/complex to
maintain ?


Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange=
 :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com=
 :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange=
 :|


