Return-Path: <SRS0=Qw6D=63=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D2FFCA90AF
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2020 12:33:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EBEEE2054F
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2020 12:33:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LaL8cY8N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBEEE2054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58154 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYqaC-0000tw-1m
	for qemu-devel@archiver.kernel.org; Wed, 13 May 2020 08:33:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38046)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jYqYe-00087q-Hq
 for qemu-devel@nongnu.org; Wed, 13 May 2020 08:32:21 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:44436
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jYqYb-0005MF-LF
 for qemu-devel@nongnu.org; Wed, 13 May 2020 08:32:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589373136;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/K31d/JxI245jJyQB2zQWxDzX86IIbHt7WVLqN3A8d8=;
 b=LaL8cY8NNogVwM9jPoAolyy0lg3fDx7LuEhLaEKa0YHBdQ/mCarPCdf7MXE4Z5JWevhCAB
 Vuk6NpPus3PC0xDhY1m+UIMWyqVOe0pTzUZEYisSf4WCptGhr0x7fkgocmWzDcekk63pGi
 ifKlGBU9/+jF3yk1zYITceVo5wRzmoA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-375-rBLSJfxpOaqmDP8m4nDxyg-1; Wed, 13 May 2020 08:32:12 -0400
X-MC-Unique: rBLSJfxpOaqmDP8m4nDxyg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 921DB1005510;
 Wed, 13 May 2020 12:32:11 +0000 (UTC)
Received: from linux.fritz.box (ovpn-114-80.ams2.redhat.com [10.36.114.80])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 15F465D9C5;
 Wed, 13 May 2020 12:32:03 +0000 (UTC)
Date: Wed, 13 May 2020 14:32:02 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 0/5] Introduce 'yank' oob qmp command to recover from
 hanging qemu
Message-ID: <20200513123202.GG6202@linux.fritz.box>
References: <20200511120718.GD2811@work-vm>
 <20200511121714.GL1135885@redhat.com>
 <20200511154645.GI2811@work-vm> <20200512113206.62836e44@luklap>
 <20200512094337.GK1191162@redhat.com>
 <20200513103245.GD6202@linux.fritz.box>
 <20200513105359.GF3225@work-vm>
 <20200513111320.GE6202@linux.fritz.box>
 <20200513112630.GJ1215285@redhat.com>
 <31bb69c3-5149-70cf-7527-54680b1e3f6b@redhat.com>
MIME-Version: 1.0
In-Reply-To: <31bb69c3-5149-70cf-7527-54680b1e3f6b@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/13 04:17:42
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Lukas Straub <lukasstraub2@web.de>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 qemu-block <qemu-block@nongnu.org>, Juan Quintela <quintela@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 13.05.2020 um 13:58 hat Paolo Bonzini geschrieben:
> On 13/05/20 13:26, Daniel P. Berrangé wrote:
> > Are you referring to the in-kernel NFS client hangs here ?  AFAIK, it is
> > impossible to do anything to get out of those hangs from userspace, because
> > the thread is stuck in an uninterruptable sleep in kernel space.
> > 
> > If using the in-QEMU NFS client, then there is a network connection that
> > can be yanked just like the NBD client.
> 
> But it's a bad idea to yank it (and also the NBD client) because you're
> not sure which wites have made it to the server (and to the medium) and
> which haven't.

This (undefined content) is generally what guests should expect when a
write request returns an error.

> Effectively, the in-QEMU NFS client and NBD client are always operating
> in "soft" mode, but we should always treat that as a bug (which cannot
> be fixed) and not a feature for read-write images.

It certainly means that you can't continue as if nothing had happened.

However, writing to the same area again (and successfully) restores a
valid state, so with werror=stop you would get into a state where you
can later reconnect and continue where you stopped, but the monitor
would stay responsive during that time.

Or if the disk isn't critical for the guest, you could replace the NBD
block node with a node that always returns I/O errors, so the guest
would see a broken disk (actually, just reporting the errors from
yanking to the guest might be enough to make it give up on the disk and
stop sending new requests). Then you can resume the VM right away.

Kevin


