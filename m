Return-Path: <SRS0=By5p=5W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9061C2BA19
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2020 14:08:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 77ABA238E4
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2020 14:08:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OuKwj4+g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77ABA238E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60716 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jLSQo-0001Qc-KK
	for qemu-devel@archiver.kernel.org; Mon, 06 Apr 2020 10:08:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56475)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <wrampazz@redhat.com>) id 1jLSPz-0000OT-5H
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 10:08:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <wrampazz@redhat.com>) id 1jLSPy-0000ir-1o
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 10:08:03 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:59967
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <wrampazz@redhat.com>) id 1jLSPx-0000iP-Uw
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 10:08:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586182081;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Q0qRjobDL3VQNo5o/7V9/uUsk0yh+H9OWm1Ix/Wb63k=;
 b=OuKwj4+gsFXDICURBnoGTGLIItBqi57uaJT+J4Z7dPc6STncAMFNcVJDHoAfgmAFkbuZBZ
 NpplOh99GR6RyF7eCOpEn8AIADxy/y39Ff1zt+GE87QFtVfMHYmCF08X4aHDszCxSwVdfd
 kKW22R5n7eFgd15R4VgyMrOfsZxCCrg=
Received: from mail-vk1-f197.google.com (mail-vk1-f197.google.com
 [209.85.221.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-367-eE1_NT_7PnSLkmfvMG0Tvw-1; Mon, 06 Apr 2020 10:08:00 -0400
X-MC-Unique: eE1_NT_7PnSLkmfvMG0Tvw-1
Received: by mail-vk1-f197.google.com with SMTP id r201so5724239vkf.5
 for <qemu-devel@nongnu.org>; Mon, 06 Apr 2020 07:08:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=Q0qRjobDL3VQNo5o/7V9/uUsk0yh+H9OWm1Ix/Wb63k=;
 b=C6uH44ik9jWyq9zCeZL4UBXJWxq9N5oqGXKl/O1CbnXt8xNTFEmkvdr656jcD3Isuk
 ZO2EO2+NGgoc8Ph4QGV2W4dwWQ1Ynr5yGl1gSiMXJEwZhvxASbBVlqKhu7+ad4x+yiT1
 IOFDKTZbgDta/7obZMNgE23KDSb3r66xPrNYYU7WZlezPHNc7jouG+LYqKkKuSZegJcT
 Qoq8nEY5sBXkr2erQNh3zNYrigDO8eMXlXI0zSuI7sHTCu+QJBPDEUA8k7akc+JapNWO
 FugUUtZ/Im83QROsvblSN7zLhLbC4pM8LUT+e10JMo86QLHbhiGaUtCnZJbBxm97mUBA
 yPiA==
X-Gm-Message-State: AGi0PuZzQE77UeoW2fbH0iASKIe8yH2/GybRA2k/t1sDYClm09w5pXOk
 Fz0KzH+aAT0ro8jmeoA18uejER1z1dSQHDQXCuoWCLmNc897PvTTOu7FNA86Xcxrn5GFxaZ7GEG
 hySyzHHjE6aWugdJ3MTgxTUre468q4nU=
X-Received: by 2002:a67:1947:: with SMTP id 68mr9416025vsz.145.1586182078158; 
 Mon, 06 Apr 2020 07:07:58 -0700 (PDT)
X-Google-Smtp-Source: APiQypKAreje+Dy5akOrdx8LPZbU7Tyn+/fLbnFLDExMSgAprhX6xF5m9MZK6LQ5Nq7ojMPOvaOtyY/RCqYL9nMDi9Q=
X-Received: by 2002:a67:1947:: with SMTP id 68mr9415992vsz.145.1586182077765; 
 Mon, 06 Apr 2020 07:07:57 -0700 (PDT)
MIME-Version: 1.0
References: <20200403172919.24621-1-philmd@redhat.com>
 <20200403172919.24621-4-philmd@redhat.com>
 <8c5017c2-d242-8437-60e3-3e28e2116d42@redhat.com>
In-Reply-To: <8c5017c2-d242-8437-60e3-3e28e2116d42@redhat.com>
From: Willian Rampazzo <wrampazz@redhat.com>
Date: Mon, 6 Apr 2020 11:07:47 -0300
Message-ID: <CAKJDGDb1EwZb_whT_+eFSbXzTt3hJuZ_JdWo7XSSfrmfWs8vwQ@mail.gmail.com>
Subject: Re: [PATCH-for-5.0 3/8] tests/acceptance/ppc_prep_40p: Use mirror for
 ftp.software.ibm.com
To: Wainer dos Santos Moschetta <wainersm@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: Fam Zheng <fam@euphon.net>, Kamil Rytarowski <kamil@netbsd.org>,
 Eduardo Habkost <ehabkost@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>, Fabien Chouteau <chouteau@adacore.com>,
 KONRAD Frederic <frederic.konrad@adacore.com>,
 =?UTF-8?Q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>,
 Cleber Rosa <crosa@redhat.com>, qemu-ppc@nongnu.org,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Apr 6, 2020 at 10:55 AM Wainer dos Santos Moschetta
<wainersm@redhat.com> wrote:
>
>
> On 4/3/20 2:29 PM, Philippe Mathieu-Daud=C3=A9 wrote:
> > To avoid regular failures on Travis-CI with ftp.software.ibm.com,
> > use a mirror.
> >
> > Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> > ---
> >   tests/acceptance/ppc_prep_40p.py | 3 ++-
> >   1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/tests/acceptance/ppc_prep_40p.py b/tests/acceptance/ppc_pr=
ep_40p.py
> > index 138064285a..1515561249 100644
> > --- a/tests/acceptance/ppc_prep_40p.py
> > +++ b/tests/acceptance/ppc_prep_40p.py
> > @@ -30,7 +30,8 @@ def test_factory_firmware_and_netbsd(self):
> >           :avocado: tags=3Dmachine:40p
> >           :avocado: tags=3Dslowness:high
> >           """
> > -        bios_url =3D ('ftp://ftp.boulder.ibm.com/rs6000/firmware/'
> > +        bios_url =3D ('http://ftpmirror.your.org/pub/misc/'
> > +                    'ftp.software.ibm.com/rs6000/firmware/'
> >                       '7020-40p/P12H0456.IMG')
>
> I checked the bios file can be downloaded from the mirror. I cannot
> judge the mirror is more reliable than ftp.boulder.ibm.com or not, though=
.
>

During the tests I did to debug Avocado I constantly got a timeout on
FTP. The HTTP URL seems to be more reliable. So far,

Tested-by: Willian Rampazzo <willianr@gmail.com>
Reviewed-by: Willian Rampazzo <willianr@gmail.com>

> Code-wise, looks good. So:
>
> Reviewed-by: Wainer dos Santos Moschetta <wainersm@redhat.com>
>
> >           bios_hash =3D '1775face4e6dc27f3a6ed955ef6eb331bf817f03'
> >           bios_path =3D self.fetch_asset(bios_url, asset_hash=3Dbios_ha=
sh)
>


