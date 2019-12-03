Return-Path: <SRS0=HheB=ZZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7751AC432C0
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 07:19:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C86B206DF
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 07:19:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E0h1e/Da"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C86B206DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49406 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ic2TS-00087G-Be
	for qemu-devel@archiver.kernel.org; Tue, 03 Dec 2019 02:19:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44617)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1ic2QY-0006OJ-SK
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 02:16:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1ic2QV-0001to-Op
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 02:16:53 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:48022
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1ic2QV-0001ox-Ch
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 02:16:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575357410;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yfBKWzLEEVwr+XjlfPpSjMM8EdrJN6EWeoCFqPhfV4o=;
 b=E0h1e/DaiXoMNA0Oxto+/kH7CMdIyq+PtBzdTZoarJjR49LDCXazXvClHdxHsCCV3I5M2h
 rP4KqY8+NEnLyfH1XNxknWc1KeZD11kPmb66dAl4HPGMFLG6p7njgBw9fk4oQwykePZW0G
 PlkczQ7iZWjWq/TqAfBH7lyItm9c448=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-419-cObeZ2VQNjqSx19EgVHg-g-1; Tue, 03 Dec 2019 02:16:45 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D64C9801E72;
 Tue,  3 Dec 2019 07:16:43 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-134.ams2.redhat.com
 [10.36.116.134])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8C7B319C68;
 Tue,  3 Dec 2019 07:16:40 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id E64661138606; Tue,  3 Dec 2019 08:16:38 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v20 0/8] Build ACPI Heterogeneous Memory Attribute Table
 (HMAT)
References: <20191129075634.682-1-tao3.xu@intel.com>
 <a31eeaf7-406f-01c4-5183-cd25835af616@intel.com>
 <20191203003445-mutt-send-email-mst@kernel.org>
 <87y2vu7xt6.fsf@dusky.pond.sub.org>
 <20191203010755-mutt-send-email-mst@kernel.org>
Date: Tue, 03 Dec 2019 08:16:38 +0100
In-Reply-To: <20191203010755-mutt-send-email-mst@kernel.org> (Michael
 S. Tsirkin's message of "Tue, 3 Dec 2019 01:25:22 -0500")
Message-ID: <87lfrt98vd.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: cObeZ2VQNjqSx19EgVHg-g-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: "lvivier@redhat.com" <lvivier@redhat.com>,
 "thuth@redhat.com" <thuth@redhat.com>,
 "ehabkost@redhat.com" <ehabkost@redhat.com>, "sw@weilnetz.de" <sw@weilnetz.de>,
 Tao Xu <tao3.xu@intel.com>, "Du, Fan" <fan.du@intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "mdroth@linux.vnet.ibm.com" <mdroth@linux.vnet.ibm.com>,
 "jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>,
 "imammedo@redhat.com" <imammedo@redhat.com>, "Liu,
 Jingqi" <jingqi.liu@intel.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

"Michael S. Tsirkin" <mst@redhat.com> writes:

> On Tue, Dec 03, 2019 at 07:00:53AM +0100, Markus Armbruster wrote:
>> "Michael S. Tsirkin" <mst@redhat.com> writes:
>>=20
>> > On Tue, Dec 03, 2019 at 08:53:30AM +0800, Tao Xu wrote:
>> >> Hi Michael,
>> >>=20
>> >> Could this patch series be queued?
>> >> Thank you very much!
>> >>=20
>> >> Tao
>> >
>> > QEMU is in freeze, so not yet. Please ping after the release.
>>=20
>> Just to avoid confusion: it's Michael's personal preference not to
>> process patches for the next version during freeze.  Other maintainers
>> do, and that's actually the project's policy:
>>=20
>> Subject: QEMU Summit 2017: minutes
>> Message-ID: <CAFEAcA-b9oDkPfZbntWfhWSv1HOnbUf75p_xB_tF74h_NBGPmw@mail.gm=
ail.com>
>> https://lists.nongnu.org/archive/html/qemu-devel/2017-11/msg04453.html
>>=20
>>     qemu-next:
>>      * Problem 1: Contributors cannot get patches merged during freeze
>>        (bad experience)
>>      [...]
>>      * Markus Armbruster: Problem 1 is solved if maintainers keep their =
own
>>        -next trees
>>      * Paolo Bonzini: Maintaining -next could slow down or create work f=
or
>>        -freeze (e.g. who does backports)
>>      * Action: Maintainers mustn't tell submitters to go away just becau=
se
>>        we're in a release freeze (it's up to them whether they prefer to
>>        maintain a "-next" tree for their subsystem with patches queued f=
or
>>        the following release, or track which patches they've accepted
>>        some other way)
>>      * We're not going to have an official project-wide "-next" tree, th=
ough
>>=20
>> Michael, would queuing up patches in a -next branch really be too much
>> trouble for you?
>
> Thanks for pointing this out!
>
> I stopped asking for re-post since awhile ago.  I don't queue patches in
> a public tree but I do review and do keep track of pending patches.
>
> I tend to ask contributors to also ping because sometimes there's a
> problem with rebase, I drop the patch but forget to tell the
> contributor, and it tends to happen more with big patchsets posted during
> freeze as there's a rush to merge changes right after that.
> I usually don't bother people with this for small patches though.
>
> I'll try to be clearer in my communication so contributors don't feel
> stressed.
>
> Would something like:
>
> "I'll queue it for merge after the release. If possible please ping me
> after the release to help make sure it didn't get dropped."
>
> be clearer?

Yes, that's both clearer and friendlier.  Thank you!

> Hopefully windows CI efforts will soon bear fruit to the point where
> they stress PCI enough to make maintaining next worth the effort.

CI++ :)


