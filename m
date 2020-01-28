Return-Path: <SRS0=Nty2=3R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FE24C33CB3
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 08:18:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE3C32467B
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 08:18:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ya9ytkbk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE3C32467B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55258 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwM4f-00061w-Ul
	for qemu-devel@archiver.kernel.org; Tue, 28 Jan 2020 03:18:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46736)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1iwM3x-0005XR-1K
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 03:17:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1iwM3v-00025j-CX
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 03:17:32 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:50946
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1iwM3v-00023w-1P
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 03:17:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580199450;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qqwdwqDPSceNnP4zbTpTXEBN9TkbmK+SZhh6yBtPEbk=;
 b=Ya9ytkbkFPZOc856xzPWttauJgQzmYvTZGoEtGZJJoigzDAUU8WowBnKjeEYSuaMZNw36P
 rZZr3k0BICCiGNO9ABMo8CUoZ6UAKWYv34HqOKA7bw7XNT1ZhCJL6MZM4R+GG6uJYt2DmB
 EtSMTM4I8hMYhEXHIh9DltUF5kZwhJg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-81-tSSatFNzNPq7ojja3nHUCw-1; Tue, 28 Jan 2020 03:17:25 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8AEE018C35BD;
 Tue, 28 Jan 2020 08:17:24 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-131.ams2.redhat.com
 [10.36.116.131])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4F62160C05;
 Tue, 28 Jan 2020 08:17:19 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id BBCD31138600; Tue, 28 Jan 2020 09:17:17 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Peter Krempa <pkrempa@redhat.com>
Subject: Re: [PATCH v3 00/13] RFC: [for 5.0]: HMP monitor handlers cleanups
References: <20200127103647.17761-1-mlevitsk@redhat.com>
 <2e885a1d-94c7-53b5-44f7-feffe70f57c3@redhat.com>
 <20200127204355.GE4544@andariel.pipo.sk>
Date: Tue, 28 Jan 2020 09:17:17 +0100
In-Reply-To: <20200127204355.GE4544@andariel.pipo.sk> (Peter Krempa's message
 of "Mon, 27 Jan 2020 21:43:55 +0100")
Message-ID: <8736c0hu5u.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: tSSatFNzNPq7ojja3nHUCw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 207.211.31.120
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
Cc: Kevin Wolf <kwolf@redhat.com>, Maxim Levitsky <mlevitsk@redhat.com>,
 Jan Tomko <jtomko@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Max Reitz <mreitz@redhat.com>,
 John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Peter Krempa <pkrempa@redhat.com> writes:

> On Mon, Jan 27, 2020 at 14:39:02 -0500, John Snow wrote:
>>=20
>>=20
>> On 1/27/20 5:36 AM, Maxim Levitsky wrote:
>> > This patch series is bunch of cleanups
>> > to the hmp monitor code.
>> >=20
>> > This series only touched blockdev related hmp handlers.
>> >=20
>> > No functional changes expected other that
>> > light error message changes by the last patch.
>> >=20
>> > This was inspired by this bugzilla:
>> > https://bugzilla.redhat.com/show_bug.cgi?id=3D1719169
>> >=20
>> > Basically some users still parse hmp error messages,
>> > and they would like to have them prefixed with 'Error:'
>> >=20
>>=20
>> HMP isn't meant to be parsed. It's explicitly *not* API or ABI. I do
>> like consistency in my UIs (it's useful for human eyes, too), but I'd
>> like to know more about the request.
>
> That's true as long as there's an stable replacement ... see below.
>
>>=20
>> Is this request coming from libvirt? Can we wean them off of this
>> interface? What do they need as a replacement?
>
> There are 5 commands that libvirt still has HMP interfaces for:
>
> drive_add
> drive_del
>
> savevm
> loadvm
> delvm
>
> From upstream point of view there's no value in adding the 'error'
> prefix to drive_add/drive_del as libvirt now uses blockdev-add/del QMP
> command instead which have implicit error propagation.
>
> There are no replacements for the internal snapshot commands, but they
> reported the 'error' prefix for some time even before this series.
>
> Said that, please don't break savevm/loadvm/delvm until a QMP
> replacement is added.

Replacements have been proposed several times, but they went nowhere
because they replicated the HMP commands' design flaws in QMP.  Here's
one that got some design analysis in its review, by yours truly:
https://lists.nongnu.org/archive/html/qemu-devel/2016-01/msg03593.html

Sane QMP replacements are certainly possible, but so far nobody has
cared enough to pitch in the work.

> The bug was reported at the time when libvirt didn't use blockdev yet,
> but at this point it's pointless from our side. This wouldn't even fix
> the scenario when old (pre-5.10) libvirt would use new qemu because the
> drive-add handler never checked the error prefix.
>
> [1] https://libvirt.org/git/?p=3Dlibvirt.git;a=3Dblob;f=3Dsrc/qemu/qemu_m=
onitor_text.c;h=3D9135a11f0a3aae718c86bb199112fba8d16d4d80;hb=3DHEAD

Thanks!


