Return-Path: <SRS0=Qw6D=63=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0603CCA90AF
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2020 12:27:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C35CD23126
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2020 12:27:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E632Ultq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C35CD23126
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49384 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYqTa-0002Of-Uo
	for qemu-devel@archiver.kernel.org; Wed, 13 May 2020 08:27:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37082)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1jYqSe-0001TO-Hu
 for qemu-devel@nongnu.org; Wed, 13 May 2020 08:26:08 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:31698
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1jYqSd-0004D7-RF
 for qemu-devel@nongnu.org; Wed, 13 May 2020 08:26:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589372767;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kV12P1VagXnxek/oZ4oaCuW5iCc053eJM7RoTlqM1vI=;
 b=E632Ultqok22w2gZZGOooXJWHq0qmv2YLyxn4zhNxRnxFsp6hAdiU6Df2JeC+ISt4ro0bf
 KHwD1JLMpP2mu4DejdAxDeyZBAqvs/Nj4u0hAGnlW/C02sSPjaWY1K7FgUlh5K/dKGEiTo
 9Mc6N23ynDVkfcfHMnBic37cbM410vw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-503-3BTLyaaKOHaHdT5AyZb8YA-1; Wed, 13 May 2020 08:26:02 -0400
X-MC-Unique: 3BTLyaaKOHaHdT5AyZb8YA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7729B1841928;
 Wed, 13 May 2020 12:26:01 +0000 (UTC)
Received: from work-vm (ovpn-115-30.ams2.redhat.com [10.36.115.30])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C08B85D9C5;
 Wed, 13 May 2020 12:25:56 +0000 (UTC)
Date: Wed, 13 May 2020 13:25:54 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 0/5] Introduce 'yank' oob qmp command to recover from
 hanging qemu
Message-ID: <20200513122554.GH3225@work-vm>
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
User-Agent: Mutt/1.13.4 (2020-02-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=dgilbert@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/13 04:17:42
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 T_HK_NAME_DR=0.01 autolearn=_AUTOLEARN
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
Cc: Kevin Wolf <kwolf@redhat.com>, Lukas Straub <lukasstraub2@web.de>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 qemu-block <qemu-block@nongnu.org>, Juan Quintela <quintela@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>, Max Reitz <mreitz@redhat.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Paolo Bonzini (pbonzini@redhat.com) wrote:
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

No, that's OK - if you look at the COLO case, and some other cases,
you've got a dead storage device but your redundant pair might be OK;
so it's OK to yank it.
Other similar storage cases are trying to migrate a VM that has one dead
disk, even if you know and accept it's dead and unresponding, you often
can't kill it off if the device is hung.

> Effectively, the in-QEMU NFS client and NBD client are always operating
> in "soft" mode, but we should always treat that as a bug (which cannot
> be fixed) and not a feature for read-write images.
Dave

> 
> Paolo
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


