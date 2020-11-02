Return-Path: <SRS0=N3Ri=EI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C4E0C00A89
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2020 11:59:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C1246223AC
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2020 11:59:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VT3sErt/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1246223AC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53554 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZYUz-0004am-Nr
	for qemu-devel@archiver.kernel.org; Mon, 02 Nov 2020 06:59:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51940)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kZYU6-0003rm-BG
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 06:58:50 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:59358)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kZYU4-0003b7-Nk
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 06:58:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604318326;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4xis9muqmn5iPnx7Q72JMW21UXtvMfjkXeMBaeoBsNo=;
 b=VT3sErt/ZcHQa+tzyxKYhuZszyMU8G8r8DN/awRJR40uY+MGfmsrlENPwNJeNg6R+1mQZS
 gqLkzWosGLDaex/auQDC7Ahinrt4acGGLQrJNqYMOqTcwQHX/uZhdrLjgel3KPa2oIg/n2
 3X6ZARjfjflvYg5QuKX4HCmyFl5GhWY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-448-PHjLEArhOSuwig6PWbbqjw-1; Mon, 02 Nov 2020 06:58:44 -0500
X-MC-Unique: PHjLEArhOSuwig6PWbbqjw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7C7FBACF23;
 Mon,  2 Nov 2020 11:58:43 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-103.ams2.redhat.com
 [10.36.112.103])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D6D1A389;
 Mon,  2 Nov 2020 11:58:38 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 57FA71132BD6; Mon,  2 Nov 2020 12:58:37 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Subject: Re: [PATCH 00/11] sockets: Attempt to drain the abstract socket swamp
References: <20201029133833.3450220-1-armbru@redhat.com>
 <CAJ+F1CLW=zfWq3apgrKear2v42LYarSMQKw07BHadM-rYjcmoA@mail.gmail.com>
 <87pn50vxa0.fsf@dusky.pond.sub.org>
 <20201030102049.GI99222@redhat.com>
 <87zh40no5a.fsf@dusky.pond.sub.org>
 <20201102091804.GC134709@redhat.com>
 <875z6om640.fsf@dusky.pond.sub.org>
 <20201102100221.GA136514@redhat.com>
Date: Mon, 02 Nov 2020 12:58:37 +0100
In-Reply-To: <20201102100221.GA136514@redhat.com> ("Daniel P. =?utf-8?Q?Be?=
 =?utf-8?Q?rrang=C3=A9=22's?=
 message of "Mon, 2 Nov 2020 10:02:21 +0000")
Message-ID: <87blggj7gy.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=63.128.21.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/02 03:02:24
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: Kevin Wolf <kwolf@redhat.com>, xiaoqiang zhao <zxq_yx_007@163.com>,
 Markus Armbruster <armbru@redhat.com>, QEMU <qemu-devel@nongnu.org>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> On Mon, Nov 02, 2020 at 10:59:43AM +0100, Markus Armbruster wrote:
>> Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:
>>=20
>> > On Mon, Nov 02, 2020 at 09:44:49AM +0100, Markus Armbruster wrote:
>> >> Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:
>> >>=20
>> >> > On Fri, Oct 30, 2020 at 11:11:19AM +0100, Markus Armbruster wrote:
>> >> >> Marc-Andr=C3=A9 Lureau <marcandre.lureau@gmail.com> writes:
>> >> >>=20
>> >> >> > Hi Markus,
>> >> >> >
>> >> >> > On Thu, Oct 29, 2020 at 5:43 PM Markus Armbruster <armbru@redhat=
.com> wrote:
>> [...]
>> >> >> >> Regardless, I *will* make time for ripping the feature out if w=
e
>> >> >> >> decide to do that.  Quick & easy way to avoid reviewing this se=
ries
>> >> >> >> *hint* *hint*.
>> >> >> >>
>> >> >> >
>> >> >> > well, fwiw, I would also take that approach too, to the risk of =
upsetting
>> >> >> > the users.
>> >> >>=20
>> >> >> Reverting the feature requires rough consensus and a patch.
>> >> >>=20
>> >> >> I can provide a patch, but let's give everybody a chance to object
>> >> >> first.
>> >>=20
>> >> Daniel, do you object, yes or no?
>> >
>> > Yes, I object to removing the feature as it is clearly useful.
>>=20
>> Thanks.  I sent v2 of my fixes.  Can you take care of getting them
>> merged, hopefully in time for 5.2?
>
> Sure, I'll aim to review & send PR today / tomorrow.

Excellent.  I'll be around to address whatever review comments you may
have.


