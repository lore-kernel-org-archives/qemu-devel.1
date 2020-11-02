Return-Path: <SRS0=N3Ri=EI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A97C2C00A89
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2020 08:45:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F0EF322275
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2020 08:45:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GcwQXv2P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0EF322275
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40822 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZVTM-0002MD-U8
	for qemu-devel@archiver.kernel.org; Mon, 02 Nov 2020 03:45:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60918)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kZVSb-0001sV-6f
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 03:45:05 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:28996)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kZVSY-0007th-7g
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 03:45:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604306699;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jFjcVoU8isVdCQKdSRuzDMXksReUyefJzU4/as6D7b0=;
 b=GcwQXv2PlqmeJ/gyok9imSi92FH8LOSOVz8IzNeOZRIeOGXae3IVn2p9QhRyxAo0+4xwRA
 GdAnSapAy7VpQO/rfHFgtCO13XtGV8bBRAiKgcqrVMXDtwCo0zyySBBW49zckx2Kvxsn++
 Eu9+9W2n4O8hsGiHX/nEInVsfXusNJc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-386-3rNAPRqLOnyBlDh6MjEGFg-1; Mon, 02 Nov 2020 03:44:56 -0500
X-MC-Unique: 3rNAPRqLOnyBlDh6MjEGFg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1C31918B9ED2;
 Mon,  2 Nov 2020 08:44:55 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-103.ams2.redhat.com
 [10.36.112.103])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 46ACF109F1B9;
 Mon,  2 Nov 2020 08:44:51 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id C5CD61132BD6; Mon,  2 Nov 2020 09:44:49 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Subject: Re: [PATCH 00/11] sockets: Attempt to drain the abstract socket swamp
References: <20201029133833.3450220-1-armbru@redhat.com>
 <CAJ+F1CLW=zfWq3apgrKear2v42LYarSMQKw07BHadM-rYjcmoA@mail.gmail.com>
 <87pn50vxa0.fsf@dusky.pond.sub.org>
 <20201030102049.GI99222@redhat.com>
Date: Mon, 02 Nov 2020 09:44:49 +0100
In-Reply-To: <20201030102049.GI99222@redhat.com> ("Daniel P. =?utf-8?Q?Ber?=
 =?utf-8?Q?rang=C3=A9=22's?=
 message of "Fri, 30 Oct 2020 10:20:49 +0000")
Message-ID: <87zh40no5a.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
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
 QEMU <qemu-devel@nongnu.org>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> On Fri, Oct 30, 2020 at 11:11:19AM +0100, Markus Armbruster wrote:
>> Marc-Andr=C3=A9 Lureau <marcandre.lureau@gmail.com> writes:
>>=20
>> > Hi Markus,
>> >
>> > On Thu, Oct 29, 2020 at 5:43 PM Markus Armbruster <armbru@redhat.com> =
wrote:
>> >
>> >> In my opinion, the Linux-specific abstract UNIX domain socket feature
>> >> introduced in 5.1 should have been rejected.  The feature is niche,
>> >> the interface clumsy, the implementation buggy and incomplete, and th=
e
>> >> test coverage insufficient.  Review fail.
>> >>
>> >
>> > I also failed (as chardev maintainer..) to not only review but weigh i=
n and
>> > discuss the merits or motivations behind it.
>> >
>> > I agree with you. Also the commit lacks motivation behind this "featur=
e".
>> >
>> >
>> >> Fixing the parts we can still fix now is regrettably expensive.  If I
>> >> had the power to decide, I'd unceremoniously revert the feature,
>> >> compatibility to 5.1 be damned.  But I don't, so here we go.
>> >>
>> >> I'm not sure this set of fixes is complete.  However, I already spent
>> >> too much time on this, so out it goes.  Lightly tested.
>> >>
>> >> Regardless, I *will* make time for ripping the feature out if we
>> >> decide to do that.  Quick & easy way to avoid reviewing this series
>> >> *hint* *hint*.
>> >>
>> >
>> > well, fwiw, I would also take that approach too, to the risk of upsett=
ing
>> > the users.
>>=20
>> Reverting the feature requires rough consensus and a patch.
>>=20
>> I can provide a patch, but let's give everybody a chance to object
>> first.

Daniel, do you object, yes or no?

I need to know to avoid wasting even more time.

>> >            But maybe we can get a clear reason behind it before that
>> > happens. (sorry, I didn't dig the ML archive is such evidence is there=
, it
>> > should have been in the commit message too)
>>=20
>> I just did, and found next to nothing.
>>=20
>> This is the final cover letter:
>>=20
>>     qemu-sockets: add abstract UNIX domain socket support
>>=20
>>     qemu does not support abstract UNIX domain
>>     socket address. Add this ability to make qemu handy
>>     when abstract address is needed.
>>=20
>> Boils down to "$feature is needed because it's handy when it's needed",
>> which is less than helpful.
>
> Well if you have an existing application that uses abstract sockets,
> and you want to connect QEMU to it, then QEMU needs to support it,
> or you are forced to interject a proxy between your app and QEMU
> which is an extra point of failure and lantency. I was interested
> in whether there was a specific application they were using, but
> that is largely just from a curiosity POV. There's enough usage of
> abstract sockets in apps in general that is it clearly a desirable
> feature to enable.
>
> Even if no external app is involved and you're just connecting
> together 2 QEMU processes' chardevs, abstract sockets are interesting
> because of their differing behaviour to non-abstract sockets.
>
> Most notably non-abstract sockets are tied to the filesystem mount
> namespace in Linux, where as abstract sockets are tied to the network
> namespace. This is a useful distinction in the container world. Ordinaril=
y
> you can't connect QEMUs in 2 separate containers together, because they
> always have distinct mount namespaces. There is often the ability to
> share network namespaces between containers though, and thus unlock
> use of abstract sockets for communications.=20

If this was patch review, I'd now ask the patch submitter to work it
into the commit message.

Thanks anyway :)

[...]


