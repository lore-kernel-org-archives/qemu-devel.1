Return-Path: <SRS0=2GMi=CD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59D9FC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 11:23:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2259720715
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 11:23:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cjujfBlr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2259720715
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43260 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAX3P-0003U7-CI
	for qemu-devel@archiver.kernel.org; Tue, 25 Aug 2020 07:23:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42454)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nsoffer@redhat.com>)
 id 1kAWxf-0000mc-NB
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 07:17:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:54740)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <nsoffer@redhat.com>)
 id 1kAWxd-0005FA-NP
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 07:17:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598354272;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=79SDo0gAeV3HH1nkwndEUf8atFayfwXC1+UtNrmbFXw=;
 b=cjujfBlrGc2LpbN+T403OgHg5hDMxm+gb5CCyOUq6+GgmIN+xfEyIkMP+exaP7hF7oFuHo
 vuNcHjXLWEEe5wf2CvmQapAAUXvdUvMfIAkkfiDPgTI8CHY47JtBcrfvphd2vrApKggvsk
 /uzkwo1iqzyyH2R+WL4oDA8UbSD7Mbo=
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com
 [209.85.161.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-322-f1M2k44GMCeD3j25gG1Pqg-1; Tue, 25 Aug 2020 07:17:50 -0400
X-MC-Unique: f1M2k44GMCeD3j25gG1Pqg-1
Received: by mail-oo1-f71.google.com with SMTP id x16so6999460ooc.4
 for <qemu-devel@nongnu.org>; Tue, 25 Aug 2020 04:17:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=79SDo0gAeV3HH1nkwndEUf8atFayfwXC1+UtNrmbFXw=;
 b=t50dr0sTK6FejowrmwqUJ7A6pdRlp+JTs4g7u4YWmpKxCjplwGXyy0gbiUunF11k5/
 69iH29AF2P6vEkBaCX7whmbwnbyDewv7HND8V5O7oWUF8U7ptqvUJQCk5FjtL8XJcGEZ
 pBLviqlfMlAOiSD7yyKhUn8pXtl8qodPOHwrzJs5qubCMQdweXk7L1pwLlciYVV7lz2v
 6lwhIKXy4vstqvmGcBCfwNEMQZqDwhjrxHkZibrgw40MhHcnsqur8paSWN3IQ1I9oh3g
 IXw/4gQlWKRQLB7xINgEqV+eMO531EKFHyrQHhUaPNmFMqdJVXLy9vkA7GcJIkgksGnr
 caJA==
X-Gm-Message-State: AOAM533ydELgZp9UexPuBOF0mRLuIqi+3bNcwiGX/SdBYcAbL0BNRybp
 919yKwRSanxfLVg++d3xVtyg74KF5L5qNcRVLT1wDI5aKtwA8+ZzOg3P/XSqPKqCIbI5jsbKuTq
 yz5T8jIHfL5dlSgo6PgZfbGSi16Q2aNw=
X-Received: by 2002:a9d:6b0c:: with SMTP id g12mr5044771otp.315.1598354269946; 
 Tue, 25 Aug 2020 04:17:49 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwMdS8bFQp8Nn+uTpQhA073Lwt7yJUiTfQY7CCzg74+HJf+3qn0UANJbS/UwAz1+osFly5+QsI0GVEMaqvKqas=
X-Received: by 2002:a9d:6b0c:: with SMTP id g12mr5044762otp.315.1598354269652; 
 Tue, 25 Aug 2020 04:17:49 -0700 (PDT)
MIME-Version: 1.0
References: <20200820235427.374645-1-nsoffer@redhat.com>
 <20200820235427.374645-3-nsoffer@redhat.com>
 <23efdc31-9715-ab6d-5a84-4ab412b4ed7b@redhat.com>
In-Reply-To: <23efdc31-9715-ab6d-5a84-4ab412b4ed7b@redhat.com>
From: Nir Soffer <nsoffer@redhat.com>
Date: Tue, 25 Aug 2020 14:17:33 +0300
Message-ID: <CAMRbyyui2n_VZs1QyFABGcQ0xaT+kUE_C+G_3ihYrNcQuotYCg@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] qemu-iotests: Fix FilePaths docstring
To: Max Reitz <mreitz@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=nsoffer@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=63.128.21.124; envelope-from=nsoffer@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/25 06:38:59
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.958,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>, Nir Soffer <nirsof@gmail.com>,
 qemu-block <qemu-block@nongnu.org>, John Snow <jsnow@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Aug 25, 2020 at 1:48 PM Max Reitz <mreitz@redhat.com> wrote:
>
> On 21.08.20 01:54, Nir Soffer wrote:
> > When this class was extracted from FilePath, the docstring was not
> > updated for generating multiple files, and the example usage was
> > referencing unrelated file.
> >
> > Fixes: de263986b5dc
> > Signed-off-by: Nir Soffer <nsoffer@redhat.com>
> > ---
> >  tests/qemu-iotests/iotests.py | 14 ++++++++------
> >  1 file changed, 8 insertions(+), 6 deletions(-)
> >
> > diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests=
.py
> > index 16a04df8a3..f34a1d7ef1 100644
> > --- a/tests/qemu-iotests/iotests.py
> > +++ b/tests/qemu-iotests/iotests.py
> > @@ -450,14 +450,16 @@ def file_pattern(name):
> >
> >  class FilePaths:
> >      """
> > -    FilePaths is an auto-generated filename that cleans itself up.
> > +    Context manager generating multiple file names. The generated file=
s are
> > +    removed when exiting the context.
> >
> > -    Use this context manager to generate filenames and ensure that the=
 file
> > -    gets deleted::
> > +    Example usage:
> > +
> > +        with FilePaths(['test.img', 'test.sock']) as (img_path, sock_p=
ath):
>
> On second thought, this isn=E2=80=99t a great example because image files=
 and
> sockets should go into different base directories.

Right, will improve it in v3.

>
> Max
>
> > +            # Use img_path and sock_path here...
> > +
> > +        # img_path and sock_path are automatically removed here.
> >
> > -        with FilePaths(['test.img']) as img_path:
> > -            qemu_img('create', img_path, '1G')
> > -        # migration_sock_path is automatically deleted
> >      """
> >      def __init__(self, names, base_dir=3Dtest_dir):
> >          self.paths =3D []
> >
>
>


