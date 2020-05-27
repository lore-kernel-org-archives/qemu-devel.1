Return-Path: <SRS0=ACoC=7J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2E59C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 14:13:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B9E6B2073B
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 14:13:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ctckqZQY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9E6B2073B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59598 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdwnp-0004UB-Uw
	for qemu-devel@archiver.kernel.org; Wed, 27 May 2020 10:13:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38132)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jdwn0-0003mX-3j
 for qemu-devel@nongnu.org; Wed, 27 May 2020 10:12:14 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:21704
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jdwmy-0001yv-Q1
 for qemu-devel@nongnu.org; Wed, 27 May 2020 10:12:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590588732;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=njsFzAW/s+zriwfmWB1wwgwpSOQozEeqvruQHuovgps=;
 b=ctckqZQYaoL8v3wPFSJ7yyx6JJbqI5PJV7IY8xv0l9gNWpl3DasqPyApomx9X+nbhMnt91
 CJqXHWjFBpzTmbNpiUHvpx2pA0HxaimftCLAHfyyjz/F1nP3cJY1in+0xXt2M30r8L8pb4
 w5/pV6Ysq3ZM9jP/qg11wk3y/npD06c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-312-QHL9azrfNaq432VBEfZ5og-1; Wed, 27 May 2020 10:12:10 -0400
X-MC-Unique: QHL9azrfNaq432VBEfZ5og-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6AC251005510;
 Wed, 27 May 2020 14:12:09 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-32.ams2.redhat.com
 [10.36.112.32])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 165B81CA;
 Wed, 27 May 2020 14:12:09 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 97BAB113864A; Wed, 27 May 2020 16:12:07 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH 09/24] macio: Fix to realize "mos6522-cuda" and
 "mos6522-pmu" devices
References: <20200518050408.4579-1-armbru@redhat.com>
 <20200518050408.4579-10-armbru@redhat.com>
 <CAFEAcA_S_JsuPG4UN-_zhhdZppBhiwm3-4bocO7O1XdjxC9bAw@mail.gmail.com>
Date: Wed, 27 May 2020 16:12:07 +0200
In-Reply-To: <CAFEAcA_S_JsuPG4UN-_zhhdZppBhiwm3-4bocO7O1XdjxC9bAw@mail.gmail.com>
 (Peter Maydell's message of "Thu, 21 May 2020 17:26:50 +0100")
Message-ID: <87wo4xxya0.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Received-SPF: pass client-ip=205.139.110.120; envelope-from=armbru@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/27 00:49:35
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 Eduardo Habkost <ehabkost@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Peter Maydell <peter.maydell@linaro.org> writes:

[...]
> Since we init the device with sysbus_init_child_obj() and
> we're in a position here to propagate any realize error
> back up to our caller, it would be nicer to do this via
> setting the realize property rather than qdev_init_nofail().

I checked all my patches for new uses of qdev_init_nofail():

* PATCH 02: in realize(), but right next to existing uses.  I'm not
  making it worse.

* PATCH 03: in helper functions used by board init functions.  Okay.

* PATCH 08: in a realize method.  Can't actually fail, so let's use
  &error_abort.

* PATCH 09 (this one): likewise.

* PATCH 18: in a realize method, and in a realize helper that can't
  fail.  One of the callers uses qdev_init_nofail() already.  Let's Use
  &error_abort.

[...]


