Return-Path: <SRS0=6DzB=ZD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE989C43331
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Nov 2019 10:27:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A5D74214DB
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Nov 2019 10:27:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="x/bBLXee"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5D74214DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50614 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iU6uV-0004iq-SR
	for qemu-devel@archiver.kernel.org; Mon, 11 Nov 2019 05:27:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48528)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iU6tN-00048z-Mp
 for qemu-devel@nongnu.org; Mon, 11 Nov 2019 05:25:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iU6tI-0003CX-9j
 for qemu-devel@nongnu.org; Mon, 11 Nov 2019 05:25:50 -0500
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:53771)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iU6tH-0003BL-V6
 for qemu-devel@nongnu.org; Mon, 11 Nov 2019 05:25:48 -0500
Received: by mail-wm1-x341.google.com with SMTP id u18so5043383wmc.3
 for <qemu-devel@nongnu.org>; Mon, 11 Nov 2019 02:25:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=vLOIaKOULkZITqE/PE4X2KOY0v8QriTnRhhkj9IK3Pk=;
 b=x/bBLXeeIEDSweg9B0E2dlJZEjvUENx9fhzy07+pBr8dUY4PVoZ2m1E9wVrge5CAjP
 /GWxtlENTwlqumH/a2RzW0jQtyoYVy04k6RZHOcrPGQ8PBQFU0QDlDPcvu28cYwmbMdg
 kwP96Z29mFq923jHkqCMVdOm76BMcN6p2obNW+NrNMwHwqaoIPLdrrN6h0KCzr0GzNFw
 sBLHpeJY17zu3VQGegCHgGcKugWpAMOK5lvF6UDktsewmKBLzUm0rV5ywKG7OKn7RUUB
 0QDNG+d5vWUqQJ09z0yrpr3OvkV2p0xlZArZp17m7wfZRJOyvOxLcig9TN5pexzMcKYj
 JZSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=vLOIaKOULkZITqE/PE4X2KOY0v8QriTnRhhkj9IK3Pk=;
 b=rbdUZeKQ+27yMH0sBfZFKItM78c/IbDaeRH2lvganBh8f6PWU/XDf5lcxEkoNK5uJ2
 trtjwZAhWeiXI+s3i7qg1y88gnuqCgB1gBkoBrst8+IeDCZw9MPBHLLPdyosK4BsAF6A
 HN61JsLoAf6g9ULqqldXwSc8hgo8YAsTu3WTCte80a3lfH66XhQoJnEsm8kN0pSBCeet
 UqIP6E+L4l0rOarI2P0mptf7oMG+dD3rIjRm8hmmqAoBirNkfJsVGG6rlb3JXhZ5WnTj
 udQr8PK0bPJ/S05JHKNjbifNrgQKz6U+M327WD7CNwRh0M2lhEJ5vHLDUPTcbgNUAEPq
 6mdQ==
X-Gm-Message-State: APjAAAXuCkFrGXiFeuyl7uwsFj5gMw7zoHjzZwJJ7E+A0boK1o41650T
 vy7N4dAugwVu8Pd3JNWh/NJipQ==
X-Google-Smtp-Source: APXvYqwFDn8J6TSqyeC7R2CxakM9kE6/CGp7hsSUMf8uMtDteu8bxpxdW5plqeFrNm9eLNffcRFRig==
X-Received: by 2002:a1c:e308:: with SMTP id a8mr19812975wmh.55.1573467945718; 
 Mon, 11 Nov 2019 02:25:45 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id m9sm14648478wro.66.2019.11.11.02.25.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Nov 2019 02:25:44 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 636CA1FF87;
 Mon, 11 Nov 2019 10:25:43 +0000 (GMT)
References: <20191015031350.4345-1-richardw.yang@linux.intel.com>
 <20191015031350.4345-2-richardw.yang@linux.intel.com>
User-agent: mu4e 1.3.5; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Wei Yang <richardw.yang@linux.intel.com>
Subject: Re: [PATCH 1/2] tests/tcg/multiarch: fix code style in function
 main of test-mmap.c
In-reply-to: <20191015031350.4345-2-richardw.yang@linux.intel.com>
Date: Mon, 11 Nov 2019 10:25:43 +0000
Message-ID: <87bltiaevs.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
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
Cc: kwolf@redhat.com, qemu-block@nongnu.org, qemu-devel@nongnu.org,
 jasowang@redhat.com, richard.henderson@linaro.org, dgilbert@redhat.com,
 mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Wei Yang <richardw.yang@linux.intel.com> writes:

> This file uses quite a different code style and changing just one line
> would leads to some awkward appearance.
>
> This is a preparation for the following replacement of
> sysconf(_SC_PAGESIZE).
>
> BTW, to depress ERROR message from checkpatch.pl, this patch replaces
> strtoul with qemu_strtoul.


NACK I'm afraid.

The tests/tcg directory all build against glibc only to make them easier
to cross-compile for the various targets. If you run check-tcg and have
a non-native cross compiler setup you'll notice this fails to build:

    BUILD   aarch64-linux-user guest-tests with aarch64-linux-gnu-gcc
  /home/alex/lsrc/qemu.git/tests/tcg/multiarch/test-mmap.c: In function =E2=
=80=98main=E2=80=99:
  /home/alex/lsrc/qemu.git/tests/tcg/multiarch/test-mmap.c:467:9: warning: =
implicit declaration of function =E2=80=98qemu_strtoul=E2=80=99; did you me=
an =E2=80=98strtoul=E2=80=99? [-Wimplicit-function-declaration]
           qemu_strtoul(argv[1], NULL, 0, &pagesize);
           ^~~~~~~~~~~~
           strtoul
  /home/alex/lsrc/qemu.git/tests/tcg/multiarch/test-mmap.c:469:20: error: =
=E2=80=98qemu_real_host_page_size=E2=80=99 undeclared (first use in this fu=
nction)
           pagesize =3D qemu_real_host_page_size;
                      ^~~~~~~~~~~~~~~~~~~~~~~~
  /home/alex/lsrc/qemu.git/tests/tcg/multiarch/test-mmap.c:469:20: note: ea=
ch undeclared identifier is reported only once for each function it appears=
 in
  make[2]: *** [../Makefile.target:103: test-mmap] Error 1
  make[1]: *** [/home/alex/lsrc/qemu.git/tests/tcg/Makefile.qemu:33: cross-=
build-guest-tests] Error 2
  make: *** [/home/alex/lsrc/qemu.git/tests/Makefile.include:1094: build-tc=
g-tests-aarch64-linux-user] Error 2
  make: *** Waiting for unfinished jobs....

>
> Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
> ---
>  tests/tcg/multiarch/test-mmap.c | 67 ++++++++++++++++++---------------
>  1 file changed, 36 insertions(+), 31 deletions(-)
>
> diff --git a/tests/tcg/multiarch/test-mmap.c b/tests/tcg/multiarch/test-m=
map.c
> index 11d0e777b1..9ea49e2307 100644
> --- a/tests/tcg/multiarch/test-mmap.c
> +++ b/tests/tcg/multiarch/test-mmap.c
> @@ -456,49 +456,54 @@ void check_invalid_mmaps(void)
>
>  int main(int argc, char **argv)
>  {
> -	char tempname[] =3D "/tmp/.cmmapXXXXXX";
> -	unsigned int i;
> -
> -	/* Trust the first argument, otherwise probe the system for our
> -	   pagesize.  */
> -	if (argc > 1)
> -		pagesize =3D strtoul(argv[1], NULL, 0);
> -	else
> -		pagesize =3D sysconf(_SC_PAGESIZE);
> +    char tempname[] =3D "/tmp/.cmmapXXXXXX";
> +    unsigned int i;
> +
> +    /*
> +     * Trust the first argument, otherwise probe the system for our
> +     * pagesize.
> +     */
> +    if (argc > 1) {
> +        qemu_strtoul(argv[1], NULL, 0, &pagesize);
> +    } else {
> +        pagesize =3D sysconf(_SC_PAGESIZE);
> +    }
>
> -	/* Assume pagesize is a power of two.  */
> -	pagemask =3D pagesize - 1;
> -	dummybuf =3D malloc (pagesize);
> -	printf ("pagesize=3D%u pagemask=3D%x\n", pagesize, pagemask);
> +    /* Assume pagesize is a power of two.  */
> +    pagemask =3D pagesize - 1;
> +    dummybuf =3D malloc(pagesize);
> +    printf("pagesize=3D%u pagemask=3D%x\n", pagesize, pagemask);
>
> -	test_fd =3D mkstemp(tempname);
> -	unlink(tempname);
> +    test_fd =3D mkstemp(tempname);
> +    unlink(tempname);
>
> -	/* Fill the file with int's counting from zero and up.  */
> +    /* Fill the file with int's counting from zero and up.  */
>      for (i =3D 0; i < (pagesize * 4) / sizeof i; i++) {
>          checked_write(test_fd, &i, sizeof i);
>      }
>
> -	/* Append a few extra writes to make the file end at non
> -	   page boundary.  */
> +    /*
> +     * Append a few extra writes to make the file end at non
> +     * page boundary.
> +     */
>      checked_write(test_fd, &i, sizeof i); i++;
>      checked_write(test_fd, &i, sizeof i); i++;
>      checked_write(test_fd, &i, sizeof i); i++;
>
> -	test_fsize =3D lseek(test_fd, 0, SEEK_CUR);
> +    test_fsize =3D lseek(test_fd, 0, SEEK_CUR);
>
> -	/* Run the tests.  */
> -	check_aligned_anonymous_unfixed_mmaps();
> -	check_aligned_anonymous_unfixed_colliding_mmaps();
> -	check_aligned_anonymous_fixed_mmaps();
> -	check_file_unfixed_mmaps();
> -	check_file_fixed_mmaps();
> -	check_file_fixed_eof_mmaps();
> -	check_file_unfixed_eof_mmaps();
> -	check_invalid_mmaps();
> +    /* Run the tests.  */
> +    check_aligned_anonymous_unfixed_mmaps();
> +    check_aligned_anonymous_unfixed_colliding_mmaps();
> +    check_aligned_anonymous_fixed_mmaps();
> +    check_file_unfixed_mmaps();
> +    check_file_fixed_mmaps();
> +    check_file_fixed_eof_mmaps();
> +    check_file_unfixed_eof_mmaps();
> +    check_invalid_mmaps();
>
> -	/* Fails at the moment.  */
> -	/* check_aligned_anonymous_fixed_mmaps_collide_with_host(); */
> +    /* Fails at the moment.  */
> +    /* check_aligned_anonymous_fixed_mmaps_collide_with_host(); */
>
> -	return EXIT_SUCCESS;
> +    return EXIT_SUCCESS;
>  }


--
Alex Benn=C3=A9e

