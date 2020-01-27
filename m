Return-Path: <SRS0=8p31=3Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 418BFC2D0DB
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2020 12:14:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D422207FD
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2020 12:14:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="POpoMDI0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D422207FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43924 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iw3Hj-0005yg-4B
	for qemu-devel@archiver.kernel.org; Mon, 27 Jan 2020 07:14:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33879)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1iw3Go-0005Xc-7j
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 07:13:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1iw3Gm-0000AI-JQ
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 07:13:33 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:24044
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1iw3Gm-00008N-FY
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 07:13:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580127211;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=O16HbfsbpLHeyzyUIZCVC0ywF3WKGaH4Qlzoq8QrBJQ=;
 b=POpoMDI08cobjvvdpE04fkGw0pRolEn8o6ef6zN+VOZ9sMq4zQKHEWi4JYC+GS+6WhC0wf
 aOTXEYvca7iZ1ErTJcS7wWqKjBXr+Nrsq0ijpsC/Ik4FZgvRL6SSwaz9zK8xHvuWDq2eB+
 vuYSS4Aymbh1fUOxXJPD4zgitEhn4Zk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-86-RTEKPaSmPBaEFL5SSRMpFQ-1; Mon, 27 Jan 2020 07:13:29 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9D45F18FE882;
 Mon, 27 Jan 2020 12:13:27 +0000 (UTC)
Received: from linux.fritz.box (ovpn-117-108.ams2.redhat.com [10.36.117.108])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6755A8889E;
 Mon, 27 Jan 2020 12:13:12 +0000 (UTC)
Date: Mon, 27 Jan 2020 13:13:11 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: Making QEMU easier for management tools and applications
Message-ID: <20200127121311.GB5669@linux.fritz.box>
References: <87h81unja8.fsf@dusky.pond.sub.org>
 <20191224134139.GD2710539@redhat.com>
 <30664f6e-81da-a6e6-9b20-037fc91290fb@redhat.com>
 <878slyej29.fsf@dusky.pond.sub.org>
 <a41ae09b-021f-2fda-0b03-7b37c5624ab3@redhat.com>
 <20200123190145.GI657556@redhat.com>
 <2561a069-ce5f-3c30-b04e-db7cd2fcdc85@redhat.com>
 <871rrp474i.fsf@dusky.pond.sub.org>
 <f24ff946-2c37-d7c7-ff18-d67e22aa438e@redhat.com>
 <20200127083513.hgl5ydgpn4mkuho5@sirius.home.kraxel.org>
MIME-Version: 1.0
In-Reply-To: <20200127083513.hgl5ydgpn4mkuho5@sirius.home.kraxel.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: RTEKPaSmPBaEFL5SSRMpFQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 "Denis V. Lunev" <den@virtuozzo.com>, Cleber Rosa <cleber@redhat.com>,
 Stefan Hajnoczi <stefanha@gmail.com>, Markus Armbruster <armbru@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-devel <qemu-devel@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 John Snow <jsnow@redhat.com>, Dominik Csapak <d.csapak@proxmox.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 27.01.2020 um 09:35 hat Gerd Hoffmann geschrieben:
>   Hi,
>=20
> > We build a "configuration" struct in QAPI, and extend from there.
> >=20
> > (2) We offer "--config myconfig.yaml" as an option for specifying
> > options.
>=20
> Yes.
>=20
> > This precludes the use of *any* traditional command line flags.
>=20
> Hmm.  Given that the transition effort will probably take a while
> I think it makes sense to allow mixing config file and cmd line
> switches, if it is only for testing the config file parsing and
> processing.  Maybe have a (temporary) -x-config for that?
>=20
> We already have qapi schema for -blockdev + -display + -audiodev +
> -chardev, creating a configuration struct which supports these
> shouldn't be that much effort.  Then move over QemuOpts one by one.

chardev-add uses a QAPI type that has too deep nesting to be user
friendly. Markus and I are trying to use mostly QAPIfied command line
options for qemu-storage-daemon, and --chardev is one that we agree must
be simplified to be bearable.

> The most tricky part here probably is -device support.

Possibly, though -object might not be much easier.

> > - We WOULD need a new YAML parsing layer in QEMU, generated by QAPI.
> > Supporting two deserialization layers could lead to strange
> > discrepancies between the two formats at runtime. So, admittedly, using
> > JSON would be *even easier*, as we could re-use the same parsers alread=
y
> > battle-tested in QEMU. We could get *MAXIMUM* code re-use this way.
>=20
> Well, we can support multiple formats, much like openshift accepts both
> json and yaml.  json is pretty much there already, so we could start
> with that and add yaml later on.  Possibly even the ini-style syntax
> accepted by -readconfig today, although I'm not sure there is much
> benefit in that.
>=20
> > - We will break compatibility with our existing CLI. People will not be
> > happy about this, especially, perhaps, embedded board and TCG developer=
s
> > who use fairly minimal command lines regularly.
>=20
> Once config file support is complete enough we should be able to offload
> backward compatibility command line parsing to some script which
> transforms the cli into a config file.  Which is probably better than
> trying to add -writeconfig to qemu as we don't have to do the string
> processing in C then.

If we get a launcher script anyway, I would argue that the system
emulator binary written in C should only support JSON (like it already
does) and the script can easily translate from YAML to JSON.

Kevin


