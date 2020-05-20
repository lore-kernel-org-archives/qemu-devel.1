Return-Path: <SRS0=CoOB=7C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E757C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 14:25:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D332205CB
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 14:25:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L2UK+rkL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D332205CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52368 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbPfG-0003li-A0
	for qemu-devel@archiver.kernel.org; Wed, 20 May 2020 10:25:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57224)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jbPYJ-0005ic-Qu
 for qemu-devel@nongnu.org; Wed, 20 May 2020 10:18:35 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:32813
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jbPYH-0004cM-Rq
 for qemu-devel@nongnu.org; Wed, 20 May 2020 10:18:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589984311;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fCtxyaGRX3pH5si0qKT8LOAxquMmZc6pTkiDFw7uCaE=;
 b=L2UK+rkLj0Q5l0WuhvATm/4umSYfHEx4pQ7MiRhGKKG4a6ahmnBs9tIrUus2MeI10fKL6T
 fVqujO5j6F5F0ugHzUyD8gavCWjznlGW8H2VcIj+ynxeEqp1ALHw6A490moQ6y/au79Imu
 LRkKVYPkIFegP6GjAtkINYW9tVogw1E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-63-JofniFxtP9yih4whcT0CFg-1; Wed, 20 May 2020 10:18:29 -0400
X-MC-Unique: JofniFxtP9yih4whcT0CFg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D120A464
 for <qemu-devel@nongnu.org>; Wed, 20 May 2020 14:18:28 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-32.ams2.redhat.com
 [10.36.112.32])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 974CE2E18C;
 Wed, 20 May 2020 14:18:28 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 1287C11358BC; Wed, 20 May 2020 16:18:27 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Subject: Re: [PATCH not-for-merge 0/5] Instrumentation for "Fixes around
 device realization"
References: <20200518051945.8621-1-armbru@redhat.com>
 <60a1b3d3-354f-ab11-31f4-dbbbbf8a9270@redhat.com>
Date: Wed, 20 May 2020 16:18:27 +0200
In-Reply-To: <60a1b3d3-354f-ab11-31f4-dbbbbf8a9270@redhat.com> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Wed, 20 May 2020 14:13:24
 +0200")
Message-ID: <87mu62r8p8.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.81; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/20 04:09:34
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: pbonzini@redhat.com, berrange@redhat.com,
 Markus Armbruster <armbru@redhat.com>, ehabkost@redhat.com,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:

> On 5/18/20 7:19 AM, Markus Armbruster wrote:
>> This is the instrumentation mentioned in "[PATCH 00/24] Fixes around
>> device realization".
>>
>> PATCH 2/5 might have value on its own.  You tell me.
>
> I'd like to have 2/3 merged normally because as you described, having
> reproducible output makes testing simpler. Can you repost them with
> proper syntax/style?

I will.

> I have similar hacks than 1/4/5.
> What about having the warnings always displayed with warn_report()
> while running QTests? Simply checking qtest_enabled().

PATCH 1 and 4 get superseded by "[PATCH 24/24] qdev: Assert onboard
devices all get realized properly".

PATCH 5 gets superseded by "[PATCH 22/24] qdev: Assert devices are
plugged into a bus that can take them".


