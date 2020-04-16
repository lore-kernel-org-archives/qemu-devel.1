Return-Path: <SRS0=3HrQ=6A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 224B2C2BA2B
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2020 06:04:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E0A2920771
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2020 06:04:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ALWrkw+G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0A2920771
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58292 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jOxdp-0000wJ-VT
	for qemu-devel@archiver.kernel.org; Thu, 16 Apr 2020 02:04:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58587)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jOxci-00005l-5l
 for qemu-devel@nongnu.org; Thu, 16 Apr 2020 02:03:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1jOxch-0007RH-7R
 for qemu-devel@nongnu.org; Thu, 16 Apr 2020 02:03:40 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:59599
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1jOxch-0007R0-4F
 for qemu-devel@nongnu.org; Thu, 16 Apr 2020 02:03:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587017017;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zKloTF0E9MOmIvzB92fFTNTPcPJanq751FUSMG9eAKg=;
 b=ALWrkw+GID6Vv/YxaK8zdrxVCbjQ8EF/06EimxKCgrL4KI4GYkceWxjbcFCFYuNONxkkPy
 njygEgAv9DC/6elN+jO/hZCzvst4LU0IdP+ysKubO0RLph4napJfBHo8XBfAz+YcEFTf4Y
 oqOjx0P2HRJJMwJwnRrl1sc6E4LqsyY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-346--prX31gLP7GavqkceAkKxQ-1; Thu, 16 Apr 2020 02:03:32 -0400
X-MC-Unique: -prX31gLP7GavqkceAkKxQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 79846107BA97;
 Thu, 16 Apr 2020 06:03:31 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-113-20.ams2.redhat.com
 [10.36.113.20])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 43DC0396;
 Thu, 16 Apr 2020 06:03:31 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id D4BD811385C8; Thu, 16 Apr 2020 08:03:29 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Adalbert =?utf-8?Q?Laz=C3=A3r?= <alazar@bitdefender.com>
Subject: Re: [RFC PATCH v1 03/26] char-socket: fix the client mode when
 created through QMP
References: <20200415005938.23895-1-alazar@bitdefender.com>
 <20200415005938.23895-4-alazar@bitdefender.com>
 <CAJ+F1CLLpzdoNqwgMQh8j4Sd4_HGEmBt=x1wPsHXvgZ7O=8Kzg@mail.gmail.com>
 <15869512460.BE82bEee.22517@host> <87tv1kg7p9.fsf@dusky.pond.sub.org>
 <15869732200.9DFE1C.30594@host>
Date: Thu, 16 Apr 2020 08:03:29 +0200
In-Reply-To: <15869732200.9DFE1C.30594@host> ("Adalbert =?utf-8?Q?Laz?=
 =?utf-8?Q?=C3=A3r=22's?= message of
 "Wed, 15 Apr 2020 20:53:40 +0300")
Message-ID: <87h7xkc6ha.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>,
 QEMU <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Adalbert Laz=C3=A3r <alazar@bitdefender.com> writes:

> On Wed, 15 Apr 2020 16:11:14 +0200, Markus Armbruster <armbru@redhat.com>=
 wrote:
>> Adalbert Laz=C3=A3r <alazar@bitdefender.com> writes:
[...]
>> > Until this moment, I did not think that we can use "server=3Dno" throu=
gh QMP :))
>>=20
>> Start here:
>>=20
>>     $ socat "READLINE,history=3D$HOME/.qmp_history,prompt=3DQMP>" UNIX-C=
ONNECT:$HOME/work/images/test-qmp=20
>>     {"QMP": {"version": {"qemu": {"micro": 92, "minor": 2, "major": 4}, =
"package": "v5.0.0-rc2-30-g25b0509e28"}, "capabilities": ["oob"]}}
>>     QMP>{"execute": "qmp_capabilities"}
>>     {"return": {}}
>>     QMP>{"execute":"chardev-add", "arguments": {"id":"foo", "backend": {=
"type": "socket", "data": {"addr": {"type": "inet", "data": {"host": "0.0.0=
.0", "port": "2445"}}, "server": false}}}}
>>     {"error": {"class": "GenericError", "desc": "Failed to connect socke=
t: Connection refused"}}
>>=20
>
> Thank you, Markus.
>
> I wanted to say that while I was writing the reply, I had an aha! moment =
and I was
> amused that I have not thought to use server=3Dno/false and I used the wr=
ong verb tense.

Happy to help!  Enjoy :)


