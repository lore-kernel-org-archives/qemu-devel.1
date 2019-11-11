Return-Path: <SRS0=6DzB=ZD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59488C43331
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Nov 2019 16:06:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 242012190F
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Nov 2019 16:06:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EXIEbYlZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 242012190F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54518 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iUCCW-0002OF-GZ
	for qemu-devel@archiver.kernel.org; Mon, 11 Nov 2019 11:06:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38609)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iUC76-0005yJ-9l
 for qemu-devel@nongnu.org; Mon, 11 Nov 2019 11:00:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iUC74-0001Gt-Lk
 for qemu-devel@nongnu.org; Mon, 11 Nov 2019 11:00:24 -0500
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:55220)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iUC74-0001Ff-E6
 for qemu-devel@nongnu.org; Mon, 11 Nov 2019 11:00:22 -0500
Received: by mail-wm1-x341.google.com with SMTP id z26so13881623wmi.4
 for <qemu-devel@nongnu.org>; Mon, 11 Nov 2019 08:00:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=swfh1DOP8Csnct6CodKeLM66wiAltk5xFhAmY8Px8zQ=;
 b=EXIEbYlZ1CUw3j1oDDOWG6N2BWMaRkMxoclRwNRCg5DXwURAsPIkG/E3kpEaz1NkP9
 L0v1Pkh4oy+w/E0UIh6EHhMgSZb3zSiBnSBgi82yhuh4fWZ7fvmezRQbygisX3PMzbZF
 G149V0GEhv/K6a2BJeU8CEEuh3Ja/+1/975cOcLgnL0vKXLsE7WL79Y6eMYMpsIt2nee
 y9s56pkr0AiSGmyphSAuo31iENWkubnjCERHnCt6ia6LxffUz974GbJ3vR9cWH2e5L9q
 uVhhe1mG/T4ysmqhETQXoWxLvAyaNC3KWd7PeyZfgMXgkOzTFk/1F3K6x1ZuD7aIN/Sh
 CVuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=swfh1DOP8Csnct6CodKeLM66wiAltk5xFhAmY8Px8zQ=;
 b=Ze0RMLhB2+nuQyVkfdye7C0dAVOqW7LkmMvvuccp1jGg2yGBCFcGdzTWLv+V29WU3P
 caQixmK8JfO7wFaac1G3bNfL8QUHzDeLBd3bJF7+6x1wVEMYQmHLScN+4xgf2qzoyrVd
 oYIhaQuZ5l6jrO2U2mMn338hvqtAnpJMHJeQx/SzT94bdUxnUY+XZH4MXylwfN38exCU
 0+NlZMyQxuFZ3i6ItqvK5wnk8P5zAbL433AzQaFjUsfO4XyV5cUn0VgRLmR7xXOcTxXk
 RfZaG09WFFmb/455uohrAr3zIf2XOVSenhGbphGf7E1KijNJ97+KicAwldvJARFrE5/K
 hcUw==
X-Gm-Message-State: APjAAAVz8IzgUHGmqDpWHdoFbqqSi8ggU15vh2x/CNEWryAfbCoH4sA5
 c1M0TxuukcMSTxIFpfq4PgGZTw==
X-Google-Smtp-Source: APXvYqw49c4xGFJCR81Iaa0bYoCoILMCzFAYUELJ+bAekUZWuSHKbB5dpS0AE2460AC9i+bEq51KEQ==
X-Received: by 2002:a7b:c1ca:: with SMTP id a10mr22730338wmj.161.1573488020498; 
 Mon, 11 Nov 2019 08:00:20 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id k4sm19327290wmk.26.2019.11.11.08.00.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Nov 2019 08:00:19 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id C76321FF87;
 Mon, 11 Nov 2019 16:00:18 +0000 (GMT)
References: <20191015031350.4345-1-richardw.yang@linux.intel.com>
 <20191015031350.4345-2-richardw.yang@linux.intel.com>
 <87bltiaevs.fsf@linaro.org> <20191111154733.ssb3mcvb7rwkrob2@master>
User-agent: mu4e 1.3.5; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Wei Yang <richard.weiyang@gmail.com>
Subject: Re: [PATCH 1/2] tests/tcg/multiarch: fix code style in function
 main of test-mmap.c
In-reply-to: <20191111154733.ssb3mcvb7rwkrob2@master>
Date: Mon, 11 Nov 2019 16:00:18 +0000
Message-ID: <875zjq9ze5.fsf@linaro.org>
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
Cc: kwolf@redhat.com, qemu-block@nongnu.org, jasowang@redhat.com,
 richard.henderson@linaro.org, qemu-devel@nongnu.org, dgilbert@redhat.com,
 Wei Yang <richardw.yang@linux.intel.com>, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Wei Yang <richard.weiyang@gmail.com> writes:

> On Mon, Nov 11, 2019 at 10:25:43AM +0000, Alex Benn??e wrote:
>>
>>Wei Yang <richardw.yang@linux.intel.com> writes:
>>
>>> This file uses quite a different code style and changing just one line
>>> would leads to some awkward appearance.
>>>
>>> This is a preparation for the following replacement of
>>> sysconf(_SC_PAGESIZE).
>>>
>>> BTW, to depress ERROR message from checkpatch.pl, this patch replaces
>>> strtoul with qemu_strtoul.
>>
>>
>>NACK I'm afraid.
>>
>>The tests/tcg directory all build against glibc only to make them easier
>>to cross-compile for the various targets. If you run check-tcg and have
>>a non-native cross compiler setup you'll notice this fails to build:
>>
>>    BUILD   aarch64-linux-user guest-tests with aarch64-linux-gnu-gcc
>>  /home/alex/lsrc/qemu.git/tests/tcg/multiarch/test-mmap.c: In function ?=
??main???:
>>  /home/alex/lsrc/qemu.git/tests/tcg/multiarch/test-mmap.c:467:9: warning=
: implicit declaration of function ???qemu_strtoul???; did you mean ???strt=
oul???? [-Wimplicit-function-declaration]
>>           qemu_strtoul(argv[1], NULL, 0, &pagesize);
>>           ^~~~~~~~~~~~
>>           strtoul
>>  /home/alex/lsrc/qemu.git/tests/tcg/multiarch/test-mmap.c:469:20: error:=
 ???qemu_real_host_page_size??? undeclared (first use in this function)
>>           pagesize =3D qemu_real_host_page_size;
>>                      ^~~~~~~~~~~~~~~~~~~~~~~~
>>  /home/alex/lsrc/qemu.git/tests/tcg/multiarch/test-mmap.c:469:20: note: =
each undeclared identifier is reported only once for each function it appea=
rs in
>>  make[2]: *** [../Makefile.target:103: test-mmap] Error 1
>>  make[1]: *** [/home/alex/lsrc/qemu.git/tests/tcg/Makefile.qemu:33: cros=
s-build-guest-tests] Error 2
>>  make: *** [/home/alex/lsrc/qemu.git/tests/Makefile.include:1094: build-=
tcg-tests-aarch64-linux-user] Error 2
>>  make: *** Waiting for unfinished jobs....
>>
>
> This output is from "make test" ?

make check-tcg

>
>>>
>>> Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
>>> ---
>>>  tests/tcg/multiarch/test-mmap.c | 67 ++++++++++++++++++---------------
>>>  1 file changed, 36 insertions(+), 31 deletions(-)
>>>
>>> diff --git a/tests/tcg/multiarch/test-mmap.c b/tests/tcg/multiarch/test=
-mmap.c
>>> index 11d0e777b1..9ea49e2307 100644
>>> --- a/tests/tcg/multiarch/test-mmap.c
>>> +++ b/tests/tcg/multiarch/test-mmap.c
>>> @@ -456,49 +456,54 @@ void check_invalid_mmaps(void)
>>>
>>>  int main(int argc, char **argv)
>>>  {
>>> -	char tempname[] =3D "/tmp/.cmmapXXXXXX";
>>> -	unsigned int i;
>>> -
>>> -	/* Trust the first argument, otherwise probe the system for our
>>> -	   pagesize.  */
>>> -	if (argc > 1)
>>> -		pagesize =3D strtoul(argv[1], NULL, 0);
>>> -	else
>>> -		pagesize =3D sysconf(_SC_PAGESIZE);
>>> +    char tempname[] =3D "/tmp/.cmmapXXXXXX";
>>> +    unsigned int i;
>>> +
>>> +    /*
>>> +     * Trust the first argument, otherwise probe the system for our
>>> +     * pagesize.
>>> +     */
>>> +    if (argc > 1) {
>>> +        qemu_strtoul(argv[1], NULL, 0, &pagesize);
>>> +    } else {
>>> +        pagesize =3D sysconf(_SC_PAGESIZE);
>>> +    }
>>>
>>> -	/* Assume pagesize is a power of two.  */
>>> -	pagemask =3D pagesize - 1;
>>> -	dummybuf =3D malloc (pagesize);
>>> -	printf ("pagesize=3D%u pagemask=3D%x\n", pagesize, pagemask);
>>> +    /* Assume pagesize is a power of two.  */
>>> +    pagemask =3D pagesize - 1;
>>> +    dummybuf =3D malloc(pagesize);
>>> +    printf("pagesize=3D%u pagemask=3D%x\n", pagesize, pagemask);
>>>
>>> -	test_fd =3D mkstemp(tempname);
>>> -	unlink(tempname);
>>> +    test_fd =3D mkstemp(tempname);
>>> +    unlink(tempname);
>>>
>>> -	/* Fill the file with int's counting from zero and up.  */
>>> +    /* Fill the file with int's counting from zero and up.  */
>>>      for (i =3D 0; i < (pagesize * 4) / sizeof i; i++) {
>>>          checked_write(test_fd, &i, sizeof i);
>>>      }
>>>
>>> -	/* Append a few extra writes to make the file end at non
>>> -	   page boundary.  */
>>> +    /*
>>> +     * Append a few extra writes to make the file end at non
>>> +     * page boundary.
>>> +     */
>>>      checked_write(test_fd, &i, sizeof i); i++;
>>>      checked_write(test_fd, &i, sizeof i); i++;
>>>      checked_write(test_fd, &i, sizeof i); i++;
>>>
>>> -	test_fsize =3D lseek(test_fd, 0, SEEK_CUR);
>>> +    test_fsize =3D lseek(test_fd, 0, SEEK_CUR);
>>>
>>> -	/* Run the tests.  */
>>> -	check_aligned_anonymous_unfixed_mmaps();
>>> -	check_aligned_anonymous_unfixed_colliding_mmaps();
>>> -	check_aligned_anonymous_fixed_mmaps();
>>> -	check_file_unfixed_mmaps();
>>> -	check_file_fixed_mmaps();
>>> -	check_file_fixed_eof_mmaps();
>>> -	check_file_unfixed_eof_mmaps();
>>> -	check_invalid_mmaps();
>>> +    /* Run the tests.  */
>>> +    check_aligned_anonymous_unfixed_mmaps();
>>> +    check_aligned_anonymous_unfixed_colliding_mmaps();
>>> +    check_aligned_anonymous_fixed_mmaps();
>>> +    check_file_unfixed_mmaps();
>>> +    check_file_fixed_mmaps();
>>> +    check_file_fixed_eof_mmaps();
>>> +    check_file_unfixed_eof_mmaps();
>>> +    check_invalid_mmaps();
>>>
>>> -	/* Fails at the moment.  */
>>> -	/* check_aligned_anonymous_fixed_mmaps_collide_with_host(); */
>>> +    /* Fails at the moment.  */
>>> +    /* check_aligned_anonymous_fixed_mmaps_collide_with_host(); */
>>>
>>> -	return EXIT_SUCCESS;
>>> +    return EXIT_SUCCESS;
>>>  }
>>
>>
>>--
>>Alex Benn??e


--
Alex Benn=C3=A9e

