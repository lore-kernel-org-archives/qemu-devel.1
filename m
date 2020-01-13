Return-Path: <SRS0=PCRa=3C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB924C33CA9
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jan 2020 15:58:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 70F7420678
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jan 2020 15:58:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eXEPxI6Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70F7420678
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52158 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ir26b-0002mO-AW
	for qemu-devel@archiver.kernel.org; Mon, 13 Jan 2020 10:58:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39300)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1ir25G-0001DL-0G
 for qemu-devel@nongnu.org; Mon, 13 Jan 2020 10:56:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1ir25D-0005eY-73
 for qemu-devel@nongnu.org; Mon, 13 Jan 2020 10:56:52 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:49491
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1ir25C-0005cE-Rm
 for qemu-devel@nongnu.org; Mon, 13 Jan 2020 10:56:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578931009;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=c92XKFdIAYPpyZWu6qoeoy/W/fMggzXgr4Io7cEaXwM=;
 b=eXEPxI6YpFHRuAWsllnk1QafGXvGOZThPQmSFE40v3e0PRFU4wchARmb52CuBmfrRihqfo
 Hzc7Ac7UL2GIQiZOKPQDF7r5n6uffhjDmPFFaSKi3m89T3/rCEug7OzUYKyHL8RSCUysml
 IAJYxQPXcarp8ykn6fwkkFyHZz2Rke0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-182-MQZpV1ftMe654dH3QZszkA-1; Mon, 13 Jan 2020 10:56:48 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 60A2A107ACC4;
 Mon, 13 Jan 2020 15:56:47 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-131.ams2.redhat.com
 [10.36.116.131])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id CD29E1000328;
 Mon, 13 Jan 2020 15:56:44 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 619761138600; Mon, 13 Jan 2020 16:56:43 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: Difference between 'current_machine' vs
 MACHINE(qdev_get_machine())
References: <a88f7647-c061-bf3f-a272-72700078ef26@redhat.com>
 <e6a7197d-1647-4667-dae8-10c8dba1737f@redhat.com>
Date: Mon, 13 Jan 2020 16:56:43 +0100
In-Reply-To: <e6a7197d-1647-4667-dae8-10c8dba1737f@redhat.com> (Paolo
 Bonzini's message of "Thu, 9 Jan 2020 13:01:30 +0100")
Message-ID: <87lfqbwds4.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: MQZpV1ftMe654dH3QZszkA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
 "Daniel P . Berrange" <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Like Xu <like.xu@linux.intel.com>,
 qemu-devel <qemu-devel@nongnu.org>, Igor Mammedov <imammedo@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Paolo Bonzini <pbonzini@redhat.com> writes:

> On 09/01/20 12:23, Philippe Mathieu-Daud=C3=A9 wrote:
>>=20
>>=20
>> =C2=A0=C2=A0=C2=A0 current_machine =3D
>> MACHINE(object_new_with_class(OBJECT_CLASS(machine_class)));
>> =C2=A0=C2=A0=C2=A0 object_property_add_child(object_get_root(), "machine=
",
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 OBJECT(current_machine), &error_abort);
>>=20
>> The bigger user of 'current_machine' is the accel/KVM code.
>>=20
>> Recently in a0628599f..cc7d44c2e0 "Replace global smp variables with
>> machine smp properties" we started to use MACHINE(qdev_get_machine()).
>>=20
>> qdev_get_machine() resolves the machine in the QOM composition tree.
>> I am confused by this comment:
>>=20
>> =C2=A0 /* qdev_get_machine() can return something that's not TYPE_MACHIN=
E
>> =C2=A0=C2=A0 * if this is one of the user-only emulators; in that case t=
here's
>> =C2=A0=C2=A0 * no need to check the ignore_memory_transaction_failures b=
oard flag.
>> =C2=A0=C2=A0 */
>>=20
>> Following a0628599f..cc7d44c2e0, a5e0b33119 use 'current_machine' again.
>>=20
>> What are the differences between both form, when should we use one or
>> another (or can we use a single one?). Can this break user-only mode?
>
> I would always use MACHINE(qdev_get_machine()), espeecially outside
> vl.c.

The way it works now, I wouldn't.  If you call qdev_get_machine() before
main() creates "/machine", it "helpfully" creates "/machine" as a
container object.  When main() tries to put the actual machine there,
it'll abort with "attempt to add duplicate property 'machine' to object
(type 'container')".  Trap for the unwary.  See also commit e2fb3fbbf9c
and 1a3ec8c1564.

Now ready your barf bags: We actually rely on this.  The user emulators
call qdev_get_machine() even though they don't have a real machine.
They get a container dummy, which is good enough for them.  The comment
that confused Philippe tries to explain exactly that.

>        Ideally, current_machine would be static within vl.c or even
> unused outside the object_property_add_child() that you quote above.

Before we spread use of qdev_get_machine() even more widely, we should
eliminate its side effect.  Programs that need a "/machine" should
create it explicitly.

> Most of the times, I noticed from a quick grep, we actually want to
> access the accelerator, not the machine, so we could add a
> qemu_get_accelerator() wrapper that does
> MACHINE(qdev_get_machine())->accelerator.

A convenience function to get the accelerator is unobjectionable.  It
having a side effect is objectionable.


