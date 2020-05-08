Return-Path: <SRS0=NBT7=6W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EC32C38A2A
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 06:49:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4BBC320870
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 06:49:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Vs66C9yO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BBC320870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37972 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWwox-0006UT-KF
	for qemu-devel@archiver.kernel.org; Fri, 08 May 2020 02:49:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52686)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jWwnr-0005gp-Dc
 for qemu-devel@nongnu.org; Fri, 08 May 2020 02:48:11 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:57602
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jWwnp-0008NS-96
 for qemu-devel@nongnu.org; Fri, 08 May 2020 02:48:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588920488;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1xCzJ5Tz46sHnU8EcLR/nWjDvOgP71+g2+8D/s2yHTY=;
 b=Vs66C9yOmuX5yfdA/hQci4r/fixWseloG8q/gOyeoRQMciLZvPnkDv9J2MN9SYCxQY1ooi
 4B2latdkek+FKdB1Z9AtkvELrh9eSlSMkKwK3ojXrGuJwqhMc2PPUdeNYoOqr8RL3+fPV+
 s6j6IxQ9G0Nj319bF2vOCP6XA/1ToFQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-59-2Fm9VM1xNLaM-zlNPWA89Q-1; Fri, 08 May 2020 02:48:06 -0400
X-MC-Unique: 2Fm9VM1xNLaM-zlNPWA89Q-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9594C461;
 Fri,  8 May 2020 06:48:04 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-113-6.ams2.redhat.com [10.36.113.6])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1E8FE19C4F;
 Fri,  8 May 2020 06:48:04 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 86E3D11358BC; Fri,  8 May 2020 08:48:02 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Subject: Re: [RFC PATCH] qom: Implement qom-get HMP command
References: <20200407114449.482532-1-clg@kaod.org>
 <87a72q6fi4.fsf@dusky.pond.sub.org> <20200507170611.GF2699@work-vm>
Date: Fri, 08 May 2020 08:48:02 +0200
In-Reply-To: <20200507170611.GF2699@work-vm> (David Alan Gilbert's message of
 "Thu, 7 May 2020 18:06:11 +0100")
Message-ID: <87h7wq2a8t.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.81; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/08 01:34:54
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: "Daniel P . =?utf-8?Q?Berrang=C3=A9?=" <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org,
 =?utf-8?Q?C=C3=A9?= =?utf-8?Q?dric?= Le Goater <clg@kaod.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Andreas =?utf-8?Q?F=C3=A4rber?= <afaerber@suse.de>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

"Dr. David Alan Gilbert" <dgilbert@redhat.com> writes:

> * Markus Armbruster (armbru@redhat.com) wrote:
>> C=C3=A9dric Le Goater <clg@kaod.org> writes:
>>=20
>> > From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
>> >
>> > Reimplement it based on qmp_qom_get() to avoid converting QObjects bac=
k
>> > to strings.
>> >
>> > Inspired-by: Paolo Bonzini <pbonzini@redhat.com>
>> > Signed-off-by: Andreas F=C3=A4rber <afaerber@suse.de>
>> >
>> > Slight fix for bit-rot:
>> > Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
>> > [clg: updates for QEMU 5.0 ]
>> > Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
>> > ---
>> >
>> >  I would like to restart the discussion on qom-get command to understa=
nd
>> >  what was the conclusion and see if things have changed since.
>>=20
>> I've since learned more about QOM.  I believe we should do HMP qom-get,
>> but not quite like this patch does.  Let me explain.
>>=20
>> A QOM property has ->get() and ->set() methods to expose the property
>> via the Visitor interface.
>>=20
>> ->get() works with an output visitor.  With the QObject output visitor,
>> you can get the property value as a QObject.  QMP qom-get uses this.
>> With the string output visitor, you can get it as a string.  Your
>> proposed HMP qom-get uses this.
>>=20
>> ->set() works with an input visitor.  With the QObject input visitor,
>> you can set the property value from a QObject.  QMP qom-set uses this.
>> With the string input visitor, you can set it from a string.  HMP
>> qom-set uses this.  With the options visitor, you can set it from a
>> QemuOpts.  CLI -object uses this.
>>=20
>> The Visitor interface supports arbitrary QAPI types.  The ->get() and
>> ->set() methods can use them all.
>>=20
>> Some visitors, howerver, carry restrictions:
>>=20
>>  * The string output visitor does not implement support for visiting
>>  * QAPI structs, alternates, null, or arbitrary QTypes.  It also
>>  * requires a non-null list argument to visit_start_list().
>>=20
>>  * The string input visitor does not implement support for visiting
>>  * QAPI structs, alternates, null, or arbitrary QTypes. Only flat lists
>>  * of integers (except type "size") are supported.
>>=20
>>  * The Opts input visitor does not implement support for visiting QAPI
>>  * alternates, numbers (other than integers), null, or arbitrary
>>  * QTypes.  It also requires a non-null list argument to
>>  * visit_start_list().
>>=20
>> If you try to qom-set a property whose ->set() uses something the string
>> input visitor doesn't support, QEMU crashes.  Same for -object, and your
>> proposed qom-get.
>
> Crashing would be bad.
>
>> I'm not aware of such a ->set(), but this is a death trap all the same.
>>=20
>> The obvious way to disarm it is removing the restrictions.
>>=20
>> One small step we took towards that goal is visible in the comments
>> above: support for flat lists of integers.  The code for that will make
>> your eyes bleed.  It's been a thorn in my side ever since I inherited
>> QAPI.  Perhaps it could be done better.  But there's a reason why it
>> should not be done at all: it's language design.
>>=20
>> The QObject visitors translate between QAPI types and our internal
>> representation of JSON.  The JSON parser and formatter complete the
>> translation to and from JSON.  Sensible enough.
>>=20
>> The string visitors translate between QAPI and ...  well, a barely
>> documented language of our own "design".  Tolerable when the language it
>> limited to numbers, booleans and strings.  Foolish when it grows into
>> something isomorphic to JSON.
>>=20
>> This is a dead end.
>>=20
>> Can we still implement a safe and tolerably useful HMP qom-get and
>> qom-set?  I think we can.  Remember the basic rule of HMP command
>> implementation: wrap around the QMP command.  So let's try that.
>>=20
>> hmp_qom_get() calls qmp_qom_get() and formats the resulting QObject with
>> qobject_to_json_pretty().
>
> Why don't we *just* do this?
> OK, we wont fix the qom-set or the CLI, but if we just get hmp_qom_get
> to call QMP, format it into json and then dump the json to the user,
> then we get a usable, if not pretty, qom-get command, without having to
> solve all these hard problems to move it forward?

Count me in favour.  I'd like to see the matching change to HMP qom-set,
though.


