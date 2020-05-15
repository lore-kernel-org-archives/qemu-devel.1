Return-Path: <SRS0=sZ1e=65=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C573C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 05:45:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 391D220671
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 05:45:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QUSxEyW8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 391D220671
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52414 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZT9m-0007is-E0
	for qemu-devel@archiver.kernel.org; Fri, 15 May 2020 01:45:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53264)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jZT9C-0006um-5a
 for qemu-devel@nongnu.org; Fri, 15 May 2020 01:44:38 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:30679
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jZT9A-0007Cj-LJ
 for qemu-devel@nongnu.org; Fri, 15 May 2020 01:44:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589521475;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JR4+Jcm8GM+lqyfKkLrUhxMUepqAeQKVR4GG20twXRw=;
 b=QUSxEyW8GoWPh7mJc2bGlDW3v7pViZBWjHXlOTQGqIXH6VXQTb6PR24ze5ecRoQU2imd0R
 rQBF8uX2ddGJuLbc42kBDl6TWWzsjVw42H0KZJaOcsYAJ87npgjDwPxHZo6Kx2fGNjC05R
 bVXL283mXssRB5mZl1tB6EWwh9xR8Ug=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-112-Q_HJ_0U_OaiocNaSPbxlew-1; Fri, 15 May 2020 01:44:32 -0400
X-MC-Unique: Q_HJ_0U_OaiocNaSPbxlew-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 01D9F1005510;
 Fri, 15 May 2020 05:44:32 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-113-6.ams2.redhat.com [10.36.113.6])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id AD60B5D9D7;
 Fri, 15 May 2020 05:44:31 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 3A6AC11358BC; Fri, 15 May 2020 07:44:30 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Subject: Re: proposal: deprecate -readconfig/-writeconfig
References: <7599153e-89a2-9a86-16ad-4a3c6a107b18@redhat.com>
 <20200514085622.GB1280939@redhat.com>
 <56379563-c1f3-3270-f9ac-5bdd49b324aa@redhat.com>
 <20200514153456.GL1280939@redhat.com>
 <93bda646-6f5f-69b6-57ec-36ec9485e84c@redhat.com>
 <20200514155540.GN1280939@redhat.com>
Date: Fri, 15 May 2020 07:44:30 +0200
In-Reply-To: <20200514155540.GN1280939@redhat.com> ("Daniel P. =?utf-8?Q?B?=
 =?utf-8?Q?errang=C3=A9=22's?=
 message of "Thu, 14 May 2020 16:55:40 +0100")
Message-ID: <87ftc1sqf5.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.61; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/15 00:07:24
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>, Markus Armbruster <armbru@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> On Thu, May 14, 2020 at 05:51:02PM +0200, Paolo Bonzini wrote:
>> On 14/05/20 17:34, Daniel P. Berrang=C3=A9 wrote:
>> > Yeah, the key thing is that you really want to be able to provide the
>> > whole initial config in one go as an atomic action. I don't want to
>> > issue 100 individual QMP commands to load each initial device.
>>=20
>> Why?  I think if we do something like the qemu-vm-$TARGET that you
>> propose below, there's absolutely no difference between the two.
>
> Ok, I should clarify. I don't want to do 100 individual serialized
> round-trip request+reply, as that'd create latency on startup.
> 100 pipelined/parallelized request+reply would be ok, as you'll
> not have the synchronization delay for each command.
>
> Today the biggest cause of slow startup in libvirt, is issuing
> something like 100+ serialized QMP calls to check status of
> individual CPUID features. Possibly this is already just a libvirt
> bug we can could just stuff all 100 qom-get queries down the pipe
> in one go and have 1 wait for replies to arrive.

Hundreds of serialized QMP roundtrips are certainly bad.

Sending hundreds of QMP commands before reading any QMP output would
also be bad: it relies on QEMU to buffer the output.  It does, but
unlimited buffering is bad, and you shouldn't rely on it to stay.

Instead, send your input as fast as QEMU accepts it (it *will* stop
reading if you send input faster than it can process it), and also
receive output as fast as you can, until you got it all.

[...]


