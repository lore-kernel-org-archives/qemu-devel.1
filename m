Return-Path: <SRS0=Szrt=YV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DBC6CA9EC2
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2019 15:48:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2CF3520830
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2019 15:48:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MAlNgB0J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CF3520830
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53028 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iP7FN-0002iw-Uq
	for qemu-devel@archiver.kernel.org; Mon, 28 Oct 2019 11:47:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50979)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <crosa@redhat.com>) id 1iP6wz-0007Zl-Nj
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 11:28:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <crosa@redhat.com>) id 1iP6wy-0005Ex-4u
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 11:28:57 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:58668
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <crosa@redhat.com>) id 1iP6wy-0005Ep-1N
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 11:28:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1572276535;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oWHV6SrqvHmurkMfXgsPstac43vJd6LTW3Vnzw6qzuA=;
 b=MAlNgB0JkQ+6ukME5M0zJQFAfTUzYVfe6Bs3kJGivtbz2HC1yEcnqrHm24Pw/04qEUUrqJ
 SeCYEH2c2lb+ZtAVsc8t+pTjl9xKZrp9kDM6RxnJJp05RH+Wpqph5MQt+L5LEz3Srpkwom
 1XgrYthuDLuPYkDlkFv8S7ZvL/7VR4Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-323-Bn0z9i2nMmyoIgrE5XIYDw-1; Mon, 28 Oct 2019 11:28:52 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B8D03476;
 Mon, 28 Oct 2019 15:28:50 +0000 (UTC)
Received: from localhost.localdomain (ovpn-123-183.rdu2.redhat.com
 [10.10.123.183])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4C75D3DAD;
 Mon, 28 Oct 2019 15:28:44 +0000 (UTC)
Date: Mon, 28 Oct 2019 11:28:42 -0400
From: Cleber Rosa <crosa@redhat.com>
To: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Subject: Re: [PATCH 03/26] tests/acceptance: Fixe wait_for_console_pattern()
 hangs
Message-ID: <20191028152842.GB3978@localhost.localdomain>
References: <20191028073441.6448-1-philmd@redhat.com>
 <20191028073441.6448-4-philmd@redhat.com>
 <CAL1e-=iDs5v4S5A8_-0XmjvTEbhJ71+yH=nKJT_ZvtQF3idPeQ@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAL1e-=iDs5v4S5A8_-0XmjvTEbhJ71+yH=nKJT_ZvtQF3idPeQ@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: Bn0z9i2nMmyoIgrE5XIYDw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
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
Cc: Fam Zheng <fam@euphon.net>, Kamil Rytarowski <kamil@netbsd.org>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Fabien Chouteau <chouteau@adacore.com>,
 KONRAD Frederic <frederic.konrad@adacore.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Oct 28, 2019 at 09:01:16AM +0100, Aleksandar Markovic wrote:
> On Monday, October 28, 2019, Philippe Mathieu-Daud=E9 <philmd@redhat.com>
> wrote:
>=20
> > Because of a possible deadlock (QEMU waiting for the socket to
> > become writable) let's close the console socket as soon as we
> > stop to use it.
> >
> > Suggested-by: Cleber Rosa <crosa@redhat.com>
> > Signed-off-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>
> > ---
> >  tests/acceptance/avocado_qemu/__init__.py | 1 +
> >  1 file changed, 1 insertion(+)
> >
> >
> Fixe -> Fix
>=20
> You missed my r-b again, given in:
>=20
> https://lists.gnu.org/archive/html/qemu-devel/2019-10/msg06376.html
>=20
> A.
>=20

I've collected your review and I'm queuing on my python-next branch
(and sending shortly in a PR).

Thanks,
- Cleber.


