Return-Path: <SRS0=CoOB=7C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB7ECC433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 08:16:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7EB982065F
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 08:16:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SVDxgp42"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7EB982065F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51654 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbJuG-0006Tf-Od
	for qemu-devel@archiver.kernel.org; Wed, 20 May 2020 04:16:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41194)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jbJti-0005gv-6a
 for qemu-devel@nongnu.org; Wed, 20 May 2020 04:16:18 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:33059
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jbJth-0001il-Fv
 for qemu-devel@nongnu.org; Wed, 20 May 2020 04:16:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589962576;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IvEd7ZU519viVvCYnlKklhYfaA4j35CRFPP2bQpnsSg=;
 b=SVDxgp42faRugvzz8yOqR2tVrujjikqBgj3Sd4wFipsG1HyREYpUdOl0Xfv9pk+yahUj3u
 nTTrWdKlv9KR3r810AEwF/Wqot9CZGj8ddJuS9++Il6YZlsYDoNirnhburTXW5ia3qJd+r
 Wt16AT56HaJSmYdWKDkno660oi8LYKs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-440-3munEkUXPD-Nb3_xGGeZvA-1; Wed, 20 May 2020 04:16:14 -0400
X-MC-Unique: 3munEkUXPD-Nb3_xGGeZvA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 21A6A8005AA
 for <qemu-devel@nongnu.org>; Wed, 20 May 2020 08:16:14 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-32.ams2.redhat.com
 [10.36.112.32])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E593B5D9CA;
 Wed, 20 May 2020 08:16:13 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 72B1B11358BC; Wed, 20 May 2020 10:16:12 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 08/55] qdev: Convert uses of qdev_create() with Coccinelle
References: <20200519145551.22836-1-armbru@redhat.com>
 <20200519145551.22836-9-armbru@redhat.com>
 <87ca8eae-d100-9098-d3e9-91a7abca1e28@redhat.com>
Date: Wed, 20 May 2020 10:16:12 +0200
In-Reply-To: <87ca8eae-d100-9098-d3e9-91a7abca1e28@redhat.com> (Paolo
 Bonzini's message of "Wed, 20 May 2020 08:30:01 +0200")
Message-ID: <87sgfvrpgz.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Received-SPF: pass client-ip=205.139.110.61; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/20 02:22:41
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
Cc: berrange@redhat.com, qemu-devel@nongnu.org, ehabkost@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Paolo Bonzini <pbonzini@redhat.com> writes:

> On 19/05/20 16:55, Markus Armbruster wrote:
>>     expression bus, type_name, dev;
>>     @@
>>     -    dev = qdev_create(bus, type_name);
>>     +    dev = qdev_new(type_name);
>>          ...
>>     -    qdev_init_nofail(dev);
>>     +    qdev_realize_and_unref(dev, bus, &error_fatal);
>> 
>
>> The first rule exempts hw/arm/highbank.c, because it matches along two
>> control flow paths there, with different @type_name.  Covered by the
>> next commit's manual conversions.
>
> Slightly better way to express it:
>
>      expression bus, type_name, dev;
>      @@
>      -    dev = qdev_create(bus, type_name);
>      +    dev = qdev_new(type_name);
>           ... when != dev = qdev_create(...)
>      -    qdev_init_nofail(dev);
>      +    qdev_realize_and_unref(dev, bus, &error_fatal);
>
> (Just for documentation purposes, the patch is okay of course).

I actually have a "... when != dev = expr" in a few later scripts.
Added when I found out that just ... produced a bad change in one case.
I meant to update all such ... to carry it, then check the addition
doesn't mess up anything, but forgot.  Can do it for v2.  Thanks!


