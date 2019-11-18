Return-Path: <SRS0=QE2o=ZK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78FB9C432C0
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2019 10:49:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 453E42067D
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2019 10:49:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ADpWvU4E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 453E42067D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60378 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iWead-0006sS-7i
	for qemu-devel@archiver.kernel.org; Mon, 18 Nov 2019 05:49:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41402)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <david@redhat.com>) id 1iWeZV-0006Ox-GW
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 05:47:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <david@redhat.com>) id 1iWeZQ-0002WC-9s
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 05:47:50 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:29772
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <david@redhat.com>) id 1iWeZH-0002Ta-Sr
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 05:47:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574074058;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aEgN/3FpA4+VRydlreE0OjBL4EpFbGJkSFlqWjd9iaM=;
 b=ADpWvU4Eo2zsj2svnuVKILx5n+ANflyAV9xIMQcV6OajdVP5m9bnt4JHigxfxkxGN+Bnqb
 doRKMGYhovfRu2qv2YpqiH5QWuLw9igJ+7FicuwvtRnkt3Hk+AnsWGAs/E9nfhlFt/GsZC
 Xqiv/bVDeHcrUademLJwPp+n5Rnikxk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-43-XiiODSYNNV-hDly26FgcHg-1; Mon, 18 Nov 2019 05:47:35 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BFE45800EBA;
 Mon, 18 Nov 2019 10:47:33 +0000 (UTC)
Received: from [10.36.118.85] (unknown [10.36.118.85])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DF47B173B1;
 Mon, 18 Nov 2019 10:47:30 +0000 (UTC)
Subject: Re: [PATCH v1 0/2] s390x/cpumodel: Introduce "best" model variants
To: Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>
References: <20191108110714.7475-1-david@redhat.com>
 <CAFEAcA-mD3-Zg2JunGpMqbcaT1qboCenhqEFytZD0FmFcL2i9Q@mail.gmail.com>
 <5dd613c0-6d9e-b943-b64d-7ba1791cbefe@redhat.com>
 <CAFEAcA-4r53vM-K24WYr1OFSOufhZ7hDHeZBhnywyaJ0gpMO1g@mail.gmail.com>
 <20191108191057.GZ3812@habkost.net>
 <CAFEAcA_No5oAFtULbAOrPDeQE18HHgc0agXbs4m2AGZ+gK_ReQ@mail.gmail.com>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <66c64c6d-b7c0-2cb1-2b29-4fdd9b369714@redhat.com>
Date: Mon, 18 Nov 2019 11:47:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_No5oAFtULbAOrPDeQE18HHgc0agXbs4m2AGZ+gK_ReQ@mail.gmail.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: XiiODSYNNV-hDly26FgcHg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8; format=flowed
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
Cc: Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Janosch Frank <frankja@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Markus Armbruster <armbru@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 qemu-s390x <qemu-s390x@nongnu.org>, Michael Mueller <mimu@linux.ibm.com>,
 Jiri Denemark <jdenemar@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 09.11.19 17:07, Peter Maydell wrote:
> On Fri, 8 Nov 2019 at 19:11, Eduardo Habkost <ehabkost@redhat.com> wrote:
>>
>> On Fri, Nov 08, 2019 at 01:02:28PM +0000, Peter Maydell wrote:
>>> On Fri, 8 Nov 2019 at 12:46, David Hildenbrand <david@redhat.com> wrote=
:
>>>> There is a small but important difference between "max"/"host" and
>>>> "best". Max really means "all features", including deprecated ones.
>>>> "best", however, can disable experimental or deprecated features. Or a=
ny
>>>> other features we don't want to be enabled when somebody selects a mod=
el
>>>> manually.
>>
>> On x86, this is implemented by "host".  "max" gives you the full
>> set of features that can be enabled by the user.  "host" gives
>> you a reasonable set of features you will want to see enabled by
>> default when the user says "use the host CPU".
>=20
> How does "host" work for TCG on x86?

I think just like on s390x, host is limited to KVM only.

>=20
>>> Hmm. I see the distinction, but is it one that's sufficiently
>>> worth making that we want to expose it to our users, possibly
>>> try to add it to the other architectures, etc ? How bad is it
>>> if the CPU provides some legacy deprecated feature that the
>>> guest just doesn't use ?
>>>
>>
>> "max" isn't something we want to expose to end users.  It is
>> something we need to expose to other software components.
>=20
> We seem to have a disagreement here about what 'max' is intended
> for and what its semantics for. That seems unfortunate...
>=20
> For Arm, "max" is absolutely something we want to expose to
> end users. It's the easiest way for a user to say "give me
> something that's going to work". "host" doesn't work on TCG,
> only with KVM.

t460s: ~/git/qemu master $ s390x-softmmu/qemu-system-s390x -cpu help |=20
grep max
s390 max             Enables all features supported by the accelerator=20
in the current host

t460s: ~/git/qemu master $ x86_64-softmmu/qemu-system-x86_64 -cpu help |=20
grep max
x86 max                   Enables all features supported by the=20
accelerator in the current host

x86 and s390x interpret the "all features supported" as "possible in=20
this configuration", not "supported" like in a support statement.

When not passing a "-cpu", you will automatically get the default model=20
assigned (e.g., host vs. qemu model on s390x). "max" does no mimic that!

>=20
>>> 'max' already shouldn't include experimental features, at least
>>> for Arm -- those should be off by default, because they're
>>> experimental and you only want users to get them if they
>>> explicitly opt in via '-cpu something,+x-my-feature'.
>>
>> The whole point of "max" is to tell management software which
>> features are valid to be enabled in a host.  If "+x-my-feature"
>> works, "x-my-feature" must be included in "max".
>=20
> No, definitely not. Experimental features should never be
> enabled by default -- the user must explicitly opt into them
> so they are aware that they're using something that might
> change behaviour or go away in a future QEMU version.
>=20
> Also, from my point of view "max" is not for the benefit
> of management software in particular. It's a convenience
> for users primarily (and also for management software if
> it doesn't want to care whether it's running KVM or TCG).
>=20
> If management software wants a way to ask "what features
> might be valid" we should provide them with one which
> doesn't require those features to be enabled-by-default
> in the 'max' CPU.
>=20
> thanks
> -- PMM
>=20

My personal opinion: "max" really means "all features". If we want an=20
automatic way to specify something you requested ("give me something=20
that's going to work") we either have to change the definition of the=20
max model for alla rchitectures or introduce something that really=20
matches the "no -cpu specified" - e.g., "best".

--=20

Thanks,

David / dhildenb


