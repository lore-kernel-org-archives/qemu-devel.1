Return-Path: <SRS0=cfdO=BG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D94C0C433FC
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 14:36:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 98ED4206E7
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 14:36:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fxOStfay"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98ED4206E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48524 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k04F0-00023z-Tn
	for qemu-devel@archiver.kernel.org; Mon, 27 Jul 2020 10:36:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52962)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nsoffer@redhat.com>)
 id 1k04EL-0001Xv-CO
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 10:35:53 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:47722
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <nsoffer@redhat.com>)
 id 1k04EJ-0001kh-57
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 10:35:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595860549;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=d83cj2LPRwhgcj6x8+6QYcZRmsl/UBRQRjJoX6b281A=;
 b=fxOStfayHY658acE9ixIcDGMnve+Y0xpdoxDPcVMdpdRIfmGfKPVR/XjMcoKu/p1l3cpuW
 o+xRaam7qNlc8/AsJAEC3AjJ5kUaTLdAejOJ3rHXUK7BzdeZ6kthCLFivnAqgEYZZAJumk
 OjQU/zjS5Et8B0P5InuDK7QNehBgHCM=
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-271-p7aYU5dQN1SFBlu4TiL35Q-1; Mon, 27 Jul 2020 10:35:46 -0400
X-MC-Unique: p7aYU5dQN1SFBlu4TiL35Q-1
Received: by mail-oi1-f197.google.com with SMTP id j17so8807823oig.8
 for <qemu-devel@nongnu.org>; Mon, 27 Jul 2020 07:35:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=d83cj2LPRwhgcj6x8+6QYcZRmsl/UBRQRjJoX6b281A=;
 b=IjHFpzNKj6t3pwilmcbY82mhPHwguUTUVMRMtJ0IvSa5TOEJLJXI8S3ZdvPBuut7bS
 Io9ms62A7KEk/Eqycb/i69H1QnhoIUY1E8FxE/epJNgj554u9ILrOEEsgOhuUyZ4GYmu
 TfSktmRs5w2K5JpsfQcupHOSHP8NpvGlExaB1SyU2Wzyv54P4BLGpgvuC4UcMpWjotSL
 PWIbTtQVzqxDVLzbVCi+5P3hOhi148Ttw+u6+beLwrWiBB1kvgHimRFGvHfmrdonwaW3
 wKmEjR5tZEWJHH3xZvxDskpguQ7JgYdrmU3SA9UzsF23aCCk+xD0B2NTSOakeirw5Mj/
 BZPA==
X-Gm-Message-State: AOAM530RSY4yyN1M6obnauzIMPEp0y0ruHly2KhS0Ew0RJTOlMu/vzmc
 snrTIeJxSzeVpSw6KHweCbyUu/WNVJCTXH4FPehbVaxpOU6tPFst0f7f8kqzNi0b0feeMPrFXPr
 9nFyvZY0brLS4TRXZhX3lKwtOZ9VG8Ug=
X-Received: by 2002:a4a:5249:: with SMTP id d70mr8467632oob.16.1595860545456; 
 Mon, 27 Jul 2020 07:35:45 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyMBJspTpnYNdj4wzt5lRxz+iRLPbxxRvVXc62j6ZGwj0rfyKrUzN071uzdJQzTftvNHiVHg6Xju77UigCHspc=
X-Received: by 2002:a4a:5249:: with SMTP id d70mr8467602oob.16.1595860545144; 
 Mon, 27 Jul 2020 07:35:45 -0700 (PDT)
MIME-Version: 1.0
References: <20200726152532.256261-1-nsoffer@redhat.com>
 <20200726152532.256261-3-nsoffer@redhat.com>
 <b0e61f48-d272-0aa5-3698-5d17a1de0774@redhat.com>
 <b4c0408f-da30-259f-b175-15e709ee987c@redhat.com>
In-Reply-To: <b4c0408f-da30-259f-b175-15e709ee987c@redhat.com>
From: Nir Soffer <nsoffer@redhat.com>
Date: Mon, 27 Jul 2020 17:35:28 +0300
Message-ID: <CAMRbyytButqSyqAXVFgMzMKoaRUYfCYWAUAoFQs9TXS0PSrX0Q@mail.gmail.com>
Subject: Re: [PATCH 2/2] qemu-iotests: Test convert to qcow2 compressed to NBD
To: Eric Blake <eblake@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.81; envelope-from=nsoffer@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/27 03:37:14
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: QEMU Developers <qemu-devel@nongnu.org>, Kevin Wolf <kwolf@redhat.com>,
 qemu-block <qemu-block@nongnu.org>, Nir Soffer <nirsof@gmail.com>,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Jul 27, 2020 at 5:14 PM Eric Blake <eblake@redhat.com> wrote:
>
> On 7/27/20 5:04 AM, Max Reitz wrote:
> > On 26.07.20 17:25, Nir Soffer wrote:
> >> Add test for "qemu-img convert -O qcow2 -c" to NBD target. The use cas=
e
> >> is writing compressed disk content to OVA archive.
> >>
> >> Signed-off-by: Nir Soffer <nsoffer@redhat.com>
> >> ---
>
> >
> >> +# The use case is writing qcow2 image directly into a tar file. Code =
to create
> >> +# real tar file not included.
> >> +#
> >> +# offset    content
> >> +# -------------------------------
> >> +#      0    first memebr header
> >
> > *member

Sorry for the typos, I need to setup automated spelling check :-)

> >
> >> +#    512    first member data
> >> +#   1024    second memeber header
> >
> > *member
> >
> >> +#   1536    second member data
> >> +
> >> +tar_file =3D file_path("test.tar")
>
> I guess it's okay that you don't create a real tar file here, but
> listing the commands to create it (even as a comment) is better than
> just saying "trust me".  And it doesn't seem like that much more work -
> it looks like the key to your test is that you created a tar file
> containing two files, where the first file was less than 512 bytes and
> the second file is your target destination that you will be rewriting.

The real code is more complicated, something like:

    offset =3D tar.fileobj.tell() + BLOCK_SIZE

    with open(tar.name, "r+") as f:
        f.truncate(offset + measure["required"])

    convert_image(image, tar.name, offset)

    check =3D check_image(tar.name, offset)
    size =3D check["image-end-offset"]

    member =3D tarfile.TarInfo(name)
    member.size =3D size
    tar.addfile(member)

    tar_size =3D offset + round_up(size)

    tar.fileobj.seek(tar_size)
    with open(tar.name, "r+") as f:
        f.truncate(tar_size)

I'm not sure it helps qemu developers working on these tests.

> >> +out =3D qemu_img_pipe("measure", "-O", "qcow2", "--output", "json", s=
rc_disk)
> >> +measure =3D json.loads(out)
> >> +qemu_img_create("-f", "raw", tar_file, str(measure["required"]))
> >
> > Should this be measure["required"] + 1536?
>
> The test works without it (because of compression), but yes, if you are
> going to test writing into an offset, you should oversize your file by
> that same offset.

Right, in the real code using this I indeed use offset + required.

> >> +
> >> +nbd_sock =3D file_path("nbd-sock", base_dir=3Diotests.sock_dir)
> >> +nbd_uri =3D "nbd+unix:///exp?socket=3D" + nbd_sock
> >> +
> >> +# Use raw format to allow creating qcow2 directy into tar file.
> >> +qemu_nbd(
> >> +    "--socket", nbd_sock,
> >> +    "--persistent",
> >> +    "--export-name", "exp",
> >> +    "--format", "raw",
> >> +    "--offset", "1536",
> >> +    tar_file)
> >> +
> >> +iotests.log("=3D=3D=3D Target image info =3D=3D=3D")
> >> +qemu_img_log("info", nbd_uri)
> >> +
> >> +# Write image into the tar file. In a real applicatio we would write =
a tar
> >
> > *application
> >
>
> >> +=3D=3D=3D Converted image check =3D=3D=3D
> >> +No errors were found on the image.
> >> +1/160 =3D 0.62% allocated, 100.00% fragmented, 100.00% compressed clu=
sters
> >> +Image end offset: 393216
> >
> > I hope none of this is fs-dependant.  (I don=E2=80=99t think it is, but=
 who
> > knows.  I suppose we=E2=80=99ll find out.)
>
> Indeed - time to see what CI thinks of this.
>
> At any rate, given the urgency of getting pull requests for -rc2 in
> before slamming Peter tomorrow, I'll probably try to touch up the issues
> Max pointed out and queue it today.

Thanks Max and Eric.

Should I post a fixed version later today?


