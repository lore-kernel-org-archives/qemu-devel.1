Return-Path: <SRS0=U3m5=5X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63164C2BA1A
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2020 16:56:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2EC5620730
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2020 16:56:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="1M5VAnnR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2EC5620730
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50896 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jLrWp-0001CO-9r
	for qemu-devel@archiver.kernel.org; Tue, 07 Apr 2020 12:56:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55492)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dan.j.williams@intel.com>) id 1jLrWE-0000nV-6T
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 12:56:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dan.j.williams@intel.com>) id 1jLrWB-0005XO-EJ
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 12:56:08 -0400
Received: from mail-ed1-x544.google.com ([2a00:1450:4864:20::544]:40660)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <dan.j.williams@intel.com>)
 id 1jLrWB-0005UZ-2Y
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 12:56:07 -0400
Received: by mail-ed1-x544.google.com with SMTP id w26so4915150edu.7
 for <qemu-devel@nongnu.org>; Tue, 07 Apr 2020 09:56:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=intel-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=mTczqT+kK6n3hmfu2zYAUvRuvEg4SvKcA2Drd/f9b9k=;
 b=1M5VAnnRdaFY24eIX4CInXyr3x7O+nuNHAOMdkul9Nhn4OCORHM67Di3bcvHXBctNa
 08M0tabLhmhrkAydtGdQCkZSytK9qFoWVsLDc0WeyvmKZ42m5NjTmG5XrOqksg3gPjkl
 Wh8sjH7wh2SxcLV29IpwAiTWpU0icBPDxNqo9hEymhCsWBEbeuI2VBrfwW7GZ4vtRAKV
 6szJuRutvlX6//r7hxvKsvn82qwLtJDm07vEn3aFU5LBttEL+qwCUcBGYjL897TC9Zsm
 yQqcPvjX6tFLE5nalTZvoOaQV7t3Ele1O/n5WSCSLDxTyjKGmbzHNW+L0ry26KLdniNF
 81JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=mTczqT+kK6n3hmfu2zYAUvRuvEg4SvKcA2Drd/f9b9k=;
 b=X/PbIaIntXqeheWGxys89V45boDYRMGu4K7tRW+g5qWb7kbegkEO91ly38onApZGWf
 WcT/lmnxduO9Ofe5E45lDkGBBcCg/wvJJAq73+7z0eproWE1+LcFqtoaia0eF/H/Rbdb
 kIMEpd+J8eON7tt9DJz25mU/lRoi4oKmoKEBhCbxpTnz/kMuGq9fdHzIdKBzDlRoLz5C
 QQ0GEgdOLrkehAUOEhBZE7XXLPhi0Nh9D7IcAx94Q8gv9XD2l7vbOTRpwtdOi87RiJ1x
 5x2bINnxfnPOCrzw0fsuhl46EQPV45QIgxt6DXRizleCzQexODDUXCY3Eecrf64SbDRt
 tgNA==
X-Gm-Message-State: AGi0PuabqyfbM441p6hCgFWyGnOAzdZDejp7XlD6d7X0tMLtu8iuz36b
 xOdzKK3bQU1VBCguNemGOIGqXaGmR8NteT9RL366Jw==
X-Google-Smtp-Source: APiQypIZ1IEshG3C6ZB0PZTUWpNupJO44MvzGukfUdPG4zKvoEFitm68Afr6jS6UNKaKoPlefJYC4VM0Yhlq4jJuQRg=
X-Received: by 2002:a05:6402:22b7:: with SMTP id
 cx23mr2747346edb.383.1586278562000; 
 Tue, 07 Apr 2020 09:56:02 -0700 (PDT)
MIME-Version: 1.0
References: <20200401031314.11592-1-jingqi.liu@intel.com>
 <c906a3ae-c9d2-5802-5988-3c1d0302109b@oracle.com>
In-Reply-To: <c906a3ae-c9d2-5802-5988-3c1d0302109b@oracle.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Tue, 7 Apr 2020 09:55:50 -0700
Message-ID: <CAPcyv4igr9-DJx2ehoHj7sXk5g5GmgmivCqM3VpmJV7J4QM+kA@mail.gmail.com>
Subject: Re: [PATCH] exec: fetch the alignment of Linux devdax pmem character
 device nodes
To: Joao Martins <joao.m.martins@oracle.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::544
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
Cc: Jingqi Liu <jingqi.liu@intel.com>, Richard Henderson <rth@twiddle.net>,
 Qemu Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Apr 7, 2020 at 4:01 AM Joao Martins <joao.m.martins@oracle.com> wrote:
>
>
>
> On 4/1/20 4:13 AM, Jingqi Liu wrote:
> > If the backend file is devdax pmem character device, the alignment
> > specified by the option 'align=NUM' in the '-object memory-backend-file'
> > needs to match the alignment requirement of the devdax pmem character device.
> >
> > This patch fetches the devdax pmem file 'align', so that we can compare
> > it with the NUM of 'align=NUM'.
> > The NUM needs to be larger than or equal to the devdax pmem file 'align'.
> >
> > It also fixes the problem that mmap() returns failure in qemu_ram_mmap()
> > when the NUM of 'align=NUM' is less than the devdax pmem file 'align'.
> >
> > Cc: Dan Williams <dan.j.williams@intel.com>
> > Signed-off-by: Jingqi Liu <jingqi.liu@intel.com>
> > ---
> >  exec.c | 46 +++++++++++++++++++++++++++++++++++++++++++++-
> >  1 file changed, 45 insertions(+), 1 deletion(-)
> >
> > diff --git a/exec.c b/exec.c
> > index de9d949902..8221abffec 100644
> > --- a/exec.c
> > +++ b/exec.c
> > @@ -1736,6 +1736,42 @@ static int64_t get_file_size(int fd)
> >      return size;
> >  }
> >
> > +static int64_t get_file_align(int fd)
> > +{
> > +    int64_t align = -1;
> > +#if defined(__linux__)
> > +    struct stat st;
> > +
> > +    if (fstat(fd, &st) < 0) {
> > +        return -errno;
> > +    }
> > +
> > +    /* Special handling for devdax character devices */
> > +    if (S_ISCHR(st.st_mode)) {
> > +        g_autofree char *subsystem_path = NULL;
> > +        g_autofree char *subsystem = NULL;
> > +
> > +        subsystem_path = g_strdup_printf("/sys/dev/char/%d:%d/subsystem",
> > +                                         major(st.st_rdev), minor(st.st_rdev));
> > +        subsystem = g_file_read_link(subsystem_path, NULL);
> > +
> > +        if (subsystem && g_str_has_suffix(subsystem, "/dax")) {
> > +            g_autofree char *align_path = NULL;
> > +            g_autofree char *align_str = NULL;
> > +
> > +            align_path = g_strdup_printf("/sys/dev/char/%d:%d/device/align",
> > +                                    major(st.st_rdev), minor(st.st_rdev));
> > +
>
> Perhaps, you meant instead:
>
>         /sys/dev/char/%d:%d/align
>

Hmm, are you sure that's working? I expect the alignment to be found
in the region device:

/sys/class/dax:
/sys/devices/LNXSYSTM:00/LNXSYBUS:00/ACPI0012:00/ndbus1/region1/dax1.1/dax1.0
$(readlink -f /sys/dev/char/253\:263)/../align
$(readlink -f /sys/dev/char/253\:263)/device/align


/sys/bus/dax:
/sys/devices/LNXSYSTM:00/LNXSYBUS:00/ACPI0012:00/ndbus1/region1/dax1.0/dax1.0
$(readlink -f /sys/dev/char/253\:265)/../align
$(readlink -f /sys/dev/char/253\:265)/device/align <-- No such file

The use of the /sys/dev/char/%d:%d/device is only supported by the
deprecated /sys/class/dax. The current /sys/bus/dax device-model can
be a drop in replacement as long as software is not written to the
/sys/class sysfs layout, i.e. it uses ../ instead of device/ to walk
to the region properties.

