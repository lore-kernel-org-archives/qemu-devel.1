Return-Path: <SRS0=QduX=3Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3656EC2D0B1
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 14:24:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 00C4020730
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 14:24:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NtFndqgK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00C4020730
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59498 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iyz7W-0001Rz-3l
	for qemu-devel@archiver.kernel.org; Tue, 04 Feb 2020 09:24:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55033)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pmathieu@redhat.com>) id 1iyz6v-0000ZW-VJ
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 09:23:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pmathieu@redhat.com>) id 1iyz6t-00023g-TO
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 09:23:28 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:28641
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pmathieu@redhat.com>) id 1iyz6t-0001vf-Mi
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 09:23:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580826206;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=05iYpSXIpboW0fXhguKtdnMO/evhW0CwRnn0UsIoHkk=;
 b=NtFndqgKSxvYftgSqJrU2/5MnvnThfSSNSDMK2u8VpPX/SkFTFKIln3hBnu+1ZFEoaCI0y
 9hJAC0ygkdGY2PIW5EKrvJk4Eub4nhbcLKeGuszDVkcin7rdYjIKdrJia+WPRsaZN+2sSB
 W84KpJ7bWGiN0lvlaKhEEMiRn/UnrQs=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-205-MwmYI3zONcKu9hnsYGG_iw-1; Tue, 04 Feb 2020 09:23:09 -0500
Received: by mail-wm1-f72.google.com with SMTP id p26so1415250wmg.5
 for <qemu-devel@nongnu.org>; Tue, 04 Feb 2020 06:23:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=iWKmHmrPGwTWiv6XORFA3vxBb4Jj2UJl1w1jHtWVjEs=;
 b=QQvwl1yJI952mo7EOWPcxa5QNBxW0o2ArEHaw7OwDhMbjS09mITn3tTzUarY/d7AxX
 L4dCdVvyBSDYJaKXpVWocM4lXGM5OKanCw0IiWz36ekJIZ4xyiqFQzNHUI1e3D6geU/0
 c2LVzsSitSHxbl1jkj6S6I8LikaGlAZAV0u/N0bculhGiAKCqg08IudQWyXOxCuww1Ps
 bbdPCMq0TjlyR6bDcIIhnV1erXu4AWz4HPFOBr/ULXa35rAz2LLNi2iqMa2qx+rn5juu
 xVc67eVGmFAFf+eijb7qT1uun6/IsFgsFDMdzCyILyEIUnUXXs1cpLe2gB35iTLZNrHC
 NnWg==
X-Gm-Message-State: APjAAAW2dcUHoStjfm7XuOROB/pawcyzCAHa8QLOQWYcN0TRknnOiTwq
 VrOSHPLEphbsNob24Uh3dQla/GybliMoMA8mjShU2b7DWY6Uqjnos+ysEGIUXskOseJSShmCmTc
 q68P0Z7nfEhEF4MVJzM7SO44dimRo5E0=
X-Received: by 2002:adf:f6c1:: with SMTP id y1mr21850449wrp.17.1580826188251; 
 Tue, 04 Feb 2020 06:23:08 -0800 (PST)
X-Google-Smtp-Source: APXvYqz5XJppfS8ij8IKMJktNRxrxt9hLPw8mLL6qfBpUK+jUYc9D5LBUtlZnb4luXf7PWojH0eUQTOmgo84SPBiwdg=
X-Received: by 2002:adf:f6c1:: with SMTP id y1mr21850434wrp.17.1580826188073; 
 Tue, 04 Feb 2020 06:23:08 -0800 (PST)
MIME-Version: 1.0
References: <1580142994-1836-1-git-send-email-liam.merwick@oracle.com>
 <1580142994-1836-6-git-send-email-liam.merwick@oracle.com>
 <20200130120506.mq6tejv5i2k776k5@steredhat>
 <f60513b8-b974-a46b-f829-993e45a0cff9@oracle.com>
 <d6bed079-9e79-5e64-f7e2-76499f24454c@redhat.com>
 <027bfff2-ff27-3fc6-05e6-aa5940e7fc04@oracle.com>
 <0902eab2-8ed2-9f44-4269-02f96d44fa76@oracle.com>
In-Reply-To: <0902eab2-8ed2-9f44-4269-02f96d44fa76@oracle.com>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Date: Tue, 4 Feb 2020 15:22:56 +0100
Message-ID: <CAP+75-UBCqxsUk68euhrWHtm0VaF3LtgY4FQq-NNaZ0ad_LbfA@mail.gmail.com>
Subject: Re: [PATCH 5/6] tests/boot_linux_console: add extract_from_rpm method
To: Liam Merwick <liam.merwick@oracle.com>
X-MC-Unique: MwmYI3zONcKu9hnsYGG_iw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
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
Cc: Fam Zheng <fam@euphon.net>, Sergio Lopez <slp@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 Stefano Garzarella <sgarzare@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Feb 4, 2020 at 2:34 PM Liam Merwick <liam.merwick@oracle.com> wrote=
:
> On 31/01/2020 15:02, Liam Merwick wrote:
>
> [... deleted ...]
>
> >>
> >>>>>
> >>>>> +        :returns: path of the extracted file
> >>>>> +        """
> >>>>> +        cwd =3D os.getcwd()
> >>>>> +        os.chdir(self.workdir)
> >>>>> +        process.run("rpm2cpio %s | cpio -id %s" % (rpm, path),
> >>>>> shell=3DTrue)
> >>>>> +        os.chdir(cwd)
> >>>>> +        return self.workdir + '/' + path
> >>>>                                    ^
> >>>>      Is the extra slash needed? (just because the extract_from_deb()
> >>>>      doesn't put it)
> >>>>
> >>>
> >>>
> >>> Yes, I needed to put it in there because the 'path' passed in for
> >>> processing by cpio is a relative patch unlike the deb arg so it
> >>> couldn't be just appended to 'self.workdir' which doesn't end in a '/=
'.
> >>
> >>
> >> It is a good practice use the `os.path` module methods when dealing
> >> with filesystem paths. So that can be replaced with:
> >>
> >>  >>> os.path.normpath(os.path.join('/path/to/workdir', './file/in/rpm'=
))
> >> '/path/to/workdir/file/in/rpm'
> >>
> >
> >
> > Will do.  I'll add a patch to fix extract_from_deb() too.
>
> Using the exact same code didn't work with extract_from_deb() because
> the callers set 'path' to an absolute path (so os.path.join() drops the
> self.workdir part).  I'll include a patch with the following change and
> it can be dropped if people think using os.path.relpath() is too much of
> a hack.
>
> --- a/tests/acceptance/boot_linux_console.py
> +++ b/tests/acceptance/boot_linux_console.py
> @@ -49,7 +49,12 @@ class BootLinuxConsole(Test):
>           process.run("ar x %s %s" % (deb, file_path))
>           archive.extract(file_path, self.workdir)
>           os.chdir(cwd)
> -        return self.workdir + path
> +        # Return complete path to extracted file.  We need to use
> +        # os.path.relpath() because callers specify 'path' with a leadin=
g
> +        # slash which causes os.path.join() to interpret it as an absolu=
te
> +        # path and to drop self.workdir part.
> +        return os.path.normpath(os.path.join(self.workdir,
> +                                             os.path.relpath(path, '/'))=
)

LGTM, so the next one modifying this code won't make a mistake.

>
>       def extract_from_rpm(self, rpm, path):
>           """
>
> Regards,
> Liam
>


