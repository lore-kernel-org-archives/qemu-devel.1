Return-Path: <SRS0=8p31=3Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0A5AC32771
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2020 08:26:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F4FE20842
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2020 08:26:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Zh7v++B7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F4FE20842
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41544 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ivzj0-0002Oa-Om
	for qemu-devel@archiver.kernel.org; Mon, 27 Jan 2020 03:26:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48334)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1ivziP-0001vP-V6
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 03:25:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1ivziO-0005ZO-Lx
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 03:25:49 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:29434
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1ivziO-0005VA-FU
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 03:25:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580113547;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eS+8KnQhjpgFVhOTwFKsQTKCr5vQ+ilq2DvalclO4vY=;
 b=Zh7v++B7WJg1m7op8XQh/DFbt0YSJWuVmipFI9DxoX4+5Mch/LlhTnNqRu1LS324pFruwV
 guF8sK8zlV9APTmL+0T+5iVvL3+pMcvpJzz+mbWCwEQ66u0BW/lCY64nROiW+2gn8PuwcU
 /zLNl50ReOqt2/tikQbPWfu0rX0TThI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-190-6s7nVDUWNgqpnBVNScTfmQ-1; Mon, 27 Jan 2020 03:25:46 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9C4C7107ACC4;
 Mon, 27 Jan 2020 08:25:44 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-131.ams2.redhat.com
 [10.36.116.131])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E08381084192;
 Mon, 27 Jan 2020 08:25:36 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 799661138600; Mon, 27 Jan 2020 09:25:35 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Subject: Tooling to help humans use JSON (was: Making QEMU easier for
 management tools and applications)
References: <CAJSP0QUk=4co-nqk8fv2n-T2_W40rE3r_5OMoxD7otAV993mCA@mail.gmail.com>
 <87h81unja8.fsf@dusky.pond.sub.org>
 <20191224134139.GD2710539@redhat.com>
 <30664f6e-81da-a6e6-9b20-037fc91290fb@redhat.com>
 <878slyej29.fsf@dusky.pond.sub.org>
 <a41ae09b-021f-2fda-0b03-7b37c5624ab3@redhat.com>
 <20200123190145.GI657556@redhat.com>
 <2561a069-ce5f-3c30-b04e-db7cd2fcdc85@redhat.com>
 <20200124095027.GA824327@redhat.com>
Date: Mon, 27 Jan 2020 09:25:35 +0100
In-Reply-To: <20200124095027.GA824327@redhat.com> ("Daniel P. =?utf-8?Q?Be?=
 =?utf-8?Q?rrang=C3=A9=22's?=
 message of "Fri, 24 Jan 2020 09:50:27 +0000")
Message-ID: <87zhe9s3uo.fsf_-_@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: 6s7nVDUWNgqpnBVNScTfmQ-1
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 "Denis V. Lunev" <den@virtuozzo.com>, Cleber Rosa <cleber@redhat.com>,
 Stefan Hajnoczi <stefanha@gmail.com>, qemu-devel <qemu-devel@nongnu.org>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Dominik Csapak <d.csapak@proxmox.com>,
 John Snow <jsnow@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> On Thu, Jan 23, 2020 at 04:07:09PM -0500, John Snow wrote:
>>=20
>>=20
>> On 1/23/20 2:01 PM, Daniel P. Berrang=C3=A9 wrote:
[...]
>> Well, sure. The context of this email was qmp-shell though, which is
>> meant to help facilitate the entry of JSON commands so that you *can*
>> indeed just forego the CLI/HMP entirely.
>>=20
>> If you are of the opinion that every user of QEMU should be copy/pasting
>> JSON straight into a socket and we should delete qmp-shell, that's
>> certainly a fine opinion.
>
> I think part of the pain of qmp-shell comes from the very fact that
> it is trying to be an interactive shell. This points people towards
> interactively typing in the commands, which is horrific when you get
> anywhere near the JSON, or even dot-notation traditional commands.
>
> If it was just a qmp-client that was single shot, we'd encourage
> people to create the JSON in a sensible way - vim/emacs/whatever.

Tooling can help with typing JSON.  Mature tooling for editing JSON
files exists.  I'm not aware of such tooling for interactive use of
JSON.  It certainly could be made.  qmp-shell tries to help by
"improving" the JSON syntax, half-heartedly.  I doubt that's a good
idea.

Kubernetes went the "put complex configuration into files, use the
mature tooling for editing files" route.  I think we can call that a
success.

The fact that JSON is not meant to serve as configuration file format /
command language for human users bears repeating.  It's a data
interchange format.

Kubernetes supplemented JSON (adequate for machines) with YAML (more
pleasant for humans, I guess).  I'm no friend of YAML myself (too much
syntax, not enough types), but once again, I think we can call that a
success, at least for Kubernetes.

> Bash/dash/zsh/$whatever is their interactive shell, with massively
> more features than qmp-shell. You have command history, autocomplete,
> conditional and looping constructs, and everything a normal shell
> offers.
>
> The only strong reason for qmp-shell to be interactive would be if
> the initial protoocl handshake was too slow. I can't see that being
> a problem with QMP.=20

Me neither.

The connection overhead may matter for non-interactive uses.  These are
better off without a middleman.

[...]


