Return-Path: <SRS0=Jnn8=YR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B2AFCA9EAF
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 15:20:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1668B20679
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 15:20:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OxSWAlCH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1668B20679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45276 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNeum-0002b2-5y
	for qemu-devel@archiver.kernel.org; Thu, 24 Oct 2019 11:20:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46521)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1iNesK-0008MY-W0
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 11:18:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1iNesJ-0002If-Iw
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 11:18:08 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:20334
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1iNesJ-0002AD-CH
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 11:18:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1571930200;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Aj2fw3kqMhaYujJmwNQfIp4SzI0JZ/mxRbbJUYOMzuc=;
 b=OxSWAlCHRDVqDSPGkWDtiy06GAr3siYeFotEaxc2N/wwOsyYEWNNHyg2H4N5qJTVyypOWN
 MKEE6s0lm7y0gDhURGVPpMnu9Xfk+lCgqailoxazAd6EpRf870RH2rZEpcZrLjRIpeC5BF
 VmuUj61XLT45WTzWsd5fLgLrO02TETM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-94-2WHtewz8NxSOqUEFzulKwQ-1; Thu, 24 Oct 2019 11:05:43 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 62EF985EE90;
 Thu, 24 Oct 2019 14:34:56 +0000 (UTC)
Received: from redhat.com (unknown [10.42.16.231])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 61FB13DB4;
 Thu, 24 Oct 2019 14:34:52 +0000 (UTC)
Date: Thu, 24 Oct 2019 15:34:50 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: cenjiahui <cenjiahui@huawei.com>
Subject: Re: [PATCH 3/3] migration/multifd: fix potential wrong acception
 order of IOChannel
Message-ID: <20191024143450.GF8381@redhat.com>
References: <20191023033214.31592-1-cenjiahui@huawei.com>
 <20191023033214.31592-3-cenjiahui@huawei.com>
 <20191024095227.GC3700@redhat.com>
 <1356aa1a-346d-29a7-8064-ac1e572b6512@huawei.com>
MIME-Version: 1.0
In-Reply-To: <1356aa1a-346d-29a7-8064-ac1e572b6512@huawei.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: 2WHtewz8NxSOqUEFzulKwQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: quintela@redhat.com, qemu-devel@nongnu.org, zhouyibo3@huawei.com,
 dgilbert@redhat.com, peterx@redhat.com, fangying1@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Oct 24, 2019 at 09:53:24PM +0800, cenjiahui wrote:
> On 2019/10/24 17:52, Daniel P. Berrang=C3=A9 wrote:
> > On Wed, Oct 23, 2019 at 11:32:14AM +0800, cenjiahui wrote:
> >> From: Jiahui Cen <cenjiahui@huawei.com>
> >>
> >> Multifd assumes the migration thread IOChannel is always established b=
efore
> >> the multifd IOChannels, but this assumption will be broken in many sit=
uations
> >> like network packet loss.
> >>
> >> For example:
> >> Step1: Source (migration thread IOChannel)  --SYN-->  Destination
> >> Step2: Source (migration thread IOChannel)  <--SYNACK  Destination
> >> Step3: Source (migration thread IOChannel, lost) --ACK-->X  Destinatio=
n
> >> Step4: Source (multifd IOChannel) --SYN-->    Destination
> >> Step5: Source (multifd IOChannel) <--SYNACK   Destination
> >> Step6: Source (multifd IOChannel, ESTABLISHED) --ACK-->  Destination
> >> Step7: Destination accepts multifd IOChannel
> >> Step8: Source (migration thread IOChannel, ESTABLISHED) -ACK,DATA->  D=
estination
> >> Step9: Destination accepts migration thread IOChannel
> >>
> >> The above situation can be reproduced by creating a weak network envir=
onment,
> >> such as "tc qdisc add dev eth0 root netem loss 50%". The wrong accepti=
on order
> >> will cause magic check failure and thus lead to migration failure.
> >>
> >> This patch fixes this issue by sending a migration IOChannel initial p=
acket with
> >> a unique id when using multifd migration. Since the multifd IOChannels=
 will also
> >> send initial packets, the destination can judge whether the processing=
 IOChannel
> >> belongs to multifd by checking the id in the initial packet. This mech=
anism can
> >> ensure that different IOChannels will go to correct branches in our te=
st.
> >=20
> > Isn't this going to break back compatibility when new QEMU talks to old
> > QEMU with multifd enabled ? New QEMU will be sending a packet that old
> > QEMU isn't expecting IIUC.
>=20
> Yes, it actually breaks back compatibility. But since the old QEMU has bu=
g with
> multifd, it may be not suitable to use multifd to migrate from new QEMU t=
o old
> QEMU in my opinion.

We declared multifd supported from v4.0.0 onwards, so changing the wire
protocol in non-backwards compatibles ways is not acceptable IMHO.

Ideally we'd change QEMU so that the src QEMU serializes the connections,
such that the migration thread I/O channel is established before we attempt
to establish the multifd channels.

If changing the wire protocol is unavoidable, then we'd need to invent
a new migration capability for the mgmt apps to detect & opt-in to when
both sides support it.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange=
 :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com=
 :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange=
 :|


