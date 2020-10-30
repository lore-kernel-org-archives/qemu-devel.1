Return-Path: <SRS0=q+n2=EF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 309BEC4363A
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 10:36:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7CAAD20704
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 10:36:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X1JA+t1w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CAAD20704
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38444 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kYRlt-0002SN-99
	for qemu-devel@archiver.kernel.org; Fri, 30 Oct 2020 06:36:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49932)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kYRgN-0005RT-5A
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 06:30:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:56858)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kYRgL-0002pA-7R
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 06:30:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604053852;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9cpP4yLgY9wcQ1taE8zVNEyFIBiD3p/KK5YXwTlh10M=;
 b=X1JA+t1wDNITs9ArL48/YdB5WKLSkdKbZdukfLnAQpo5U8KLixAqm6HpWu0urZsGSzig6j
 jilRx1Dy2bubD9vqHLSZ7XTzcRNBImkDjoa+s8ONZoNLW9M0YNc5ARp+kUgT1qp2ozwEls
 fvhHZLKRM3B6EaE2rDo0Rz19MPJY0bs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-588-Ij3kE2yiMOO7sEH3kOzxeA-1; Fri, 30 Oct 2020 06:30:50 -0400
X-MC-Unique: Ij3kE2yiMOO7sEH3kOzxeA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D5383101964F;
 Fri, 30 Oct 2020 10:30:48 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-182.ams2.redhat.com
 [10.36.112.182])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7495262A15;
 Fri, 30 Oct 2020 10:30:45 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id D94D7113865F; Fri, 30 Oct 2020 11:30:43 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Subject: Re: Our abstract UNIX domain socket support is a mess
References: <87o8kmwmjh.fsf@dusky.pond.sub.org>
 <20201029140242.GE27369@redhat.com>
 <20201029160744.GB6271@merkur.fritz.box>
Date: Fri, 30 Oct 2020 11:30:42 +0100
In-Reply-To: <20201029160744.GB6271@merkur.fritz.box> (Kevin Wolf's message of
 "Thu, 29 Oct 2020 17:07:44 +0100")
Message-ID: <87zh44uht9.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=63.128.21.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/30 01:22:25
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: xiaoqiang zhao <zxq_yx_007@163.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 "Daniel P. =?utf-8?Q?Berrang=C3=A9?=" <berrange@redhat.com>,
 qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Kevin Wolf <kwolf@redhat.com> writes:

> Am 29.10.2020 um 15:02 hat Daniel P. Berrang=C3=A9 geschrieben:
>> On Wed, Oct 28, 2020 at 01:41:06PM +0100, Markus Armbruster wrote:
[...]
>> > Issue#1: our interface is differently ugly, for no good reason
>> >=20
>> > Like the Linux kernel, we also appropriate existing @path for abstract
>> > sockets.  With less excuse, though; we could have created a neater
>> > interface, easily.
>> >=20
>> > Unlike the Linux kernel, we don't do blobs.  In other words, our varia=
nt
>> > of the hack is not general.
>>=20
>> The Linux kernel interface is low level and not the way any userspace
>> application exposes the use of abstract sockets. No one wants to
>> specify an abstract socket by listing all 108 characters with many
>> trailing nuls. It would be insane to do this.
>>=20
>> There are two ways userspace apps expose abstract socket config.
>>=20
>> Either using a leading "@" as a magic substitute for NUL and not
>> supporting a coibfigurable way to distinguish truncated vs full
>> length, just define the desired behaviour for their app. THis is
>> what dbus does to denote its abstract socket paths.
>
> Using magic characters in strings to distinguish different types of
> objects is always wrong in QAPI. If we interpreted leading '@' this way,
> you wouldn't be able to specify a relative filename starting with '@'
> any more.
>
>> Or, just or by having  explicit flags "abstract" and "tight" to
>> control the behaviour.  The latter is what 'socat' does to allow
>> use of abstract sockets.
>>=20
>> For QEMU the former approach gives broad interoperabiltiy with
>> userspace applications, so made more sense than using magic "@".
>
> Boolean flags to distinguish different types are better than parsing
> strings, but still not optimal. Documentation like "only matters for
> abstract sockets" is another hint that we're treating things the same
> that aren't the same.
>
> The proper way to distinguish two different types is unions. So I think

Yes.

> the ideal interface would be another SocketAddress variant that could
> then also use base64 instead of str to represent arbitrary blobs, like
> Markus suggested below.

There are no impossible combinations to ignore or reject, and to
document.  Instead, introspection tells the whole story.

Done this way, we could easily support both a (string, bool tight) for
convenience and base64 blob for generality, if we want to.

But I stand by my opinion that the feature is simply not worth its keep.
To make me reconsider, show me actual uses.

> Probably too late now.

It's too late if we decide it is.

>> > Elsewhere in QMP, we use base64 for blobs.
>> >=20
>> > Aside: QMP can do embedded 0 bytes.  It represents them as overlong
>> > UTF-8 =E2=80=9C\xC0\x80", though.
>> >=20
>> > Not sure the interface is worth fixing now.  Abstract sockets are nich=
e.
>> > In my opinion, we should've said no.
>>=20
>> The interface doesn't need fixing - the way it is represented in
>> QEMU is much saner than the low level struct sockaddr_un representation
>> used to talk to the kernel, and is common with other userspace apps.
>>=20
>> The use case is to enable interoperability with other apps that use
>> an abstract socket.
>
> Kevin


