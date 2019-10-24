Return-Path: <SRS0=Jnn8=YR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDCE8CA9EAF
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 19:58:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A83AF2166E
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 19:58:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="btJjknoh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A83AF2166E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51568 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNjFM-0004uQ-Mo
	for qemu-devel@archiver.kernel.org; Thu, 24 Oct 2019 15:58:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32887)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1iNjE1-0003VW-AI
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 15:56:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1iNjE0-0001NY-59
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 15:56:49 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:39941
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1iNjE0-0001Mu-1Q
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 15:56:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1571947007;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PWar3sXWveI81s9sb02PZUlySVSxdLyLr/8aseOOBtg=;
 b=btJjknoh5MUmD87SIn4A5ihV2lRo5dXAmqYIWltZnXnefukrsn7vpqh0TNU3LP3B7fVUzq
 2H7AVDXNLWAvP4K+pcBWqxYm4PXd6MrJuhO0YTiiWMPlniQ2vgjrJpQzb+MlGYs4j9KcNd
 QD5u1HpyzicULpLZ9M7x6o8NlcRLO4g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-230-YvO24G-1OVuJg6Oh6wXwKg-1; Thu, 24 Oct 2019 15:56:41 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 38F121800DCA
 for <qemu-devel@nongnu.org>; Thu, 24 Oct 2019 19:56:40 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.36.118.123])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4540C10027BF;
 Thu, 24 Oct 2019 19:56:36 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id B2C121138619; Thu, 24 Oct 2019 21:56:30 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Subject: Re: [libvirt] [RFC PATCH 19/19] qapi: Implement -compat
 deprecated-output=hide for events
References: <20191024123458.13505-1-armbru@redhat.com>
 <20191024123458.13505-20-armbru@redhat.com>
 <20191024141658.GD8381@redhat.com>
Date: Thu, 24 Oct 2019 21:56:30 +0200
In-Reply-To: <20191024141658.GD8381@redhat.com> ("Daniel P. =?utf-8?Q?Berr?=
 =?utf-8?Q?ang=C3=A9=22's?=
 message of "Thu, 24 Oct 2019 15:16:58 +0100")
Message-ID: <87blu5or2p.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: YvO24G-1OVuJg6Oh6wXwKg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
Cc: libvir-list@redhat.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> On Thu, Oct 24, 2019 at 02:34:58PM +0200, Markus Armbruster wrote:
>> This policy suppresses deprecated events, and thus permits "testing
>> the future".
>
> One thing that occurs to me is that this is a fairly passive impact
> on libvirt. eg it may well be not at all obvious if libvirt is behaving
> in a broken way due to an event not being emitted, as the code in
> question simply won't be triggered.

Intented use of -compat deprecated-input=3Derror,deprecated-output=3Dhide i=
s
"testing the future": make QEMU behave as if the deprecated features
were already gone.  Can be useful when you want to test code that deals
with the anticipated future *now*.

It can also be used to ferret out unknown uses of deprecated interfaces:
run test suite with it, see what fails.  But as you note, the
deprecated-output=3Dhide part is somewhat problematic in that role.

> With the current QMP this situation is unavoidable since QEMU doesn't
> know which events the client (libvirt) is actually using. QEMU just
> unconditionally emits all events.
>
> I've often wondered if we should have the client explicitly tell
> QEMU which events it wants to receive as part of the QMP greeting
> handshake.
>
> ie, libvirt knows which events it can handle. QEMU knows which
> events it can emit, and reports this via capabilities which
> libvirt probes.
>
> So on connecting libvirt can tell QEMU exactly which evnets it
> wants to get back. QEMU is now able to explicitly tell libvirt
> it has asked for a deprecated event, and so the logic from the
> "deprecated-input" option can take effect.

QEMU already reports its events via introspection.  What's missing is an
event subscription mechanism.  Should be feasible.

Additional benefit: can reduce I/O.

> We'd not need "deprecated-output" at that point.

If deprecated-input=3Derror makes subscribing to a deprecated event fail,
we don't need deprecated-output=3Dhide for events.

But events are not the only output: there's also command returns.

Consider query-cpus-fast.  Returns list of CpuInfoFast.  CpuInfoFast
member @arch is deprecated.  deprecated-output=3Dhide should hide it,
except it's not implemented in this series.

This is also "a fairly passive impact on libvirt", I'm afraid.

We have some 40 events, and having libvirt subscribe to the ones it
actually uses is obviously practical.

I doubt the subscription idea scales up to return values.


