Return-Path: <SRS0=6DzB=ZD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3132EC43331
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Nov 2019 15:49:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E959B20679
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Nov 2019 15:49:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SQvMEeBB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E959B20679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54206 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iUBw5-0007oG-42
	for qemu-devel@archiver.kernel.org; Mon, 11 Nov 2019 10:49:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37280)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.weiyang@gmail.com>) id 1iUBum-00074c-Ip
 for qemu-devel@nongnu.org; Mon, 11 Nov 2019 10:47:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.weiyang@gmail.com>) id 1iUBul-0003Tq-5R
 for qemu-devel@nongnu.org; Mon, 11 Nov 2019 10:47:40 -0500
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:40956)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.weiyang@gmail.com>)
 id 1iUBui-0003SM-BJ; Mon, 11 Nov 2019 10:47:36 -0500
Received: by mail-wr1-x441.google.com with SMTP id i10so15163038wrs.7;
 Mon, 11 Nov 2019 07:47:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=xrjFd4lboQN9pgQimFc9b1Omw/VBERAakpCXUhdrh6s=;
 b=SQvMEeBB1Lm97xuuAAXRd+mfAuxqoBnghJWIHNf6z3RzCjg5Auo0TXKvfTGicDzv+7
 BQEAp5pWukNTvJDzF9y4Sm5mEaN+2QqMZMcL8+oNV7Zsz3PncPxWpu5C7iXfIZjwpGV9
 +URV7AQRgYhdIOtgBn1HXsqzWOEY1VwqY6YhA23UW54jnA1LNOWUThHZC5RYAKIwbw+h
 0wWWE2cxEt1pYtr7PjGs9UhI6uvLD4z5sn7bkh0y8doXD0C012qpa3M9RKTnWZ57NpI5
 u0jsHkWTqg/zJIdN0OOmaBRBTe35aMOgJWLKW0tGZ1qStitXiTRIoUX95r8wdPOi+urK
 m0fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
 :references:mime-version:content-disposition:in-reply-to:user-agent;
 bh=xrjFd4lboQN9pgQimFc9b1Omw/VBERAakpCXUhdrh6s=;
 b=kl9qWir2f+186fLInKuyjFMl3OW1uwZA3i8ZLxHVg+wXYSZY/iPwRMkEss55pQBdm4
 siI3ksIkz+Ms2A1qR/0hS1Gu+q/6SjA5FbdMt+5RTUUKzlTIOFdJVTnFI1Dkpcn0u079
 yO7ur4BoR6CdB/LRltGsTHt5Ne4YHVO/i/h99gI3X5DIhCLYXkMPv+t/3FtW1iI+j29z
 CdrvPXH5XW5X3r+jGMtJd3HsddYQdbwF1xSeHDJWeWR1RztEtc9CA7eHL5+Wvuw0QyUd
 QZpkvnYnDqJz0i4pBFPAHL5MEsgltxs07EvRkztHl43513Zd8iLCkZfoe6Ga1FGT2VaL
 tO6w==
X-Gm-Message-State: APjAAAUTP19F1jsdBWmWqIRAV0gfnPtkhkCDLVb/gR5hZuxvij1D/Mar
 7EiGrMRhhQpe3JOKpK4dcrk=
X-Google-Smtp-Source: APXvYqwxRDl8zAjpSUmGB5cOWRPzbThR0lUuRoJilsb2Ptin15CCNR7w+JhWqie6dQXGcjzMgJg0Sw==
X-Received: by 2002:a5d:4208:: with SMTP id n8mr19742765wrq.136.1573487255164; 
 Mon, 11 Nov 2019 07:47:35 -0800 (PST)
Received: from localhost ([185.92.221.13])
 by smtp.gmail.com with ESMTPSA id x8sm15709858wrm.7.2019.11.11.07.47.34
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 11 Nov 2019 07:47:34 -0800 (PST)
Date: Mon, 11 Nov 2019 15:47:33 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: Alex Benn??e <alex.bennee@linaro.org>
Subject: Re: [PATCH 1/2] tests/tcg/multiarch: fix code style in function main
 of test-mmap.c
Message-ID: <20191111154733.ssb3mcvb7rwkrob2@master>
References: <20191015031350.4345-1-richardw.yang@linux.intel.com>
 <20191015031350.4345-2-richardw.yang@linux.intel.com>
 <87bltiaevs.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87bltiaevs.fsf@linaro.org>
User-Agent: NeoMutt/20170113 (1.7.2)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
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
Reply-To: Wei Yang <richard.weiyang@gmail.com>
Cc: kwolf@redhat.com, qemu-block@nongnu.org, jasowang@redhat.com,
 richard.henderson@linaro.org, qemu-devel@nongnu.org, dgilbert@redhat.com,
 Wei Yang <richardw.yang@linux.intel.com>, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Nov 11, 2019 at 10:25:43AM +0000, Alex Benn??e wrote:
>
>Wei Yang <richardw.yang@linux.intel.com> writes:
>
>> This file uses quite a different code style and changing just one line
>> would leads to some awkward appearance.
>>
>> This is a preparation for the following replacement of
>> sysconf(_SC_PAGESIZE).
>>
>> BTW, to depress ERROR message from checkpatch.pl, this patch replaces
>> strtoul with qemu_strtoul.
>
>
>NACK I'm afraid.
>
>The tests/tcg directory all build against glibc only to make them easier
>to cross-compile for the various targets. If you run check-tcg and have
>a non-native cross compiler setup you'll notice this fails to build:
>
>    BUILD   aarch64-linux-user guest-tests with aarch64-linux-gnu-gcc
>  /home/alex/lsrc/qemu.git/tests/tcg/multiarch/test-mmap.c: In function ???main???:
>  /home/alex/lsrc/qemu.git/tests/tcg/multiarch/test-mmap.c:467:9: warning: implicit declaration of function ???qemu_strtoul???; did you mean ???strtoul???? [-Wimplicit-function-declaration]
>           qemu_strtoul(argv[1], NULL, 0, &pagesize);
>           ^~~~~~~~~~~~
>           strtoul
>  /home/alex/lsrc/qemu.git/tests/tcg/multiarch/test-mmap.c:469:20: error: ???qemu_real_host_page_size??? undeclared (first use in this function)
>           pagesize = qemu_real_host_page_size;
>                      ^~~~~~~~~~~~~~~~~~~~~~~~
>  /home/alex/lsrc/qemu.git/tests/tcg/multiarch/test-mmap.c:469:20: note: each undeclared identifier is reported only once for each function it appears in
>  make[2]: *** [../Makefile.target:103: test-mmap] Error 1
>  make[1]: *** [/home/alex/lsrc/qemu.git/tests/tcg/Makefile.qemu:33: cross-build-guest-tests] Error 2
>  make: *** [/home/alex/lsrc/qemu.git/tests/Makefile.include:1094: build-tcg-tests-aarch64-linux-user] Error 2
>  make: *** Waiting for unfinished jobs....
>

This output is from "make test" ?

>>
>> Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
>> ---
>>  tests/tcg/multiarch/test-mmap.c | 67 ++++++++++++++++++---------------
>>  1 file changed, 36 insertions(+), 31 deletions(-)
>>
>> diff --git a/tests/tcg/multiarch/test-mmap.c b/tests/tcg/multiarch/test-mmap.c
>> index 11d0e777b1..9ea49e2307 100644
>> --- a/tests/tcg/multiarch/test-mmap.c
>> +++ b/tests/tcg/multiarch/test-mmap.c
>> @@ -456,49 +456,54 @@ void check_invalid_mmaps(void)
>>
>>  int main(int argc, char **argv)
>>  {
>> -	char tempname[] = "/tmp/.cmmapXXXXXX";
>> -	unsigned int i;
>> -
>> -	/* Trust the first argument, otherwise probe the system for our
>> -	   pagesize.  */
>> -	if (argc > 1)
>> -		pagesize = strtoul(argv[1], NULL, 0);
>> -	else
>> -		pagesize = sysconf(_SC_PAGESIZE);
>> +    char tempname[] = "/tmp/.cmmapXXXXXX";
>> +    unsigned int i;
>> +
>> +    /*
>> +     * Trust the first argument, otherwise probe the system for our
>> +     * pagesize.
>> +     */
>> +    if (argc > 1) {
>> +        qemu_strtoul(argv[1], NULL, 0, &pagesize);
>> +    } else {
>> +        pagesize = sysconf(_SC_PAGESIZE);
>> +    }
>>
>> -	/* Assume pagesize is a power of two.  */
>> -	pagemask = pagesize - 1;
>> -	dummybuf = malloc (pagesize);
>> -	printf ("pagesize=%u pagemask=%x\n", pagesize, pagemask);
>> +    /* Assume pagesize is a power of two.  */
>> +    pagemask = pagesize - 1;
>> +    dummybuf = malloc(pagesize);
>> +    printf("pagesize=%u pagemask=%x\n", pagesize, pagemask);
>>
>> -	test_fd = mkstemp(tempname);
>> -	unlink(tempname);
>> +    test_fd = mkstemp(tempname);
>> +    unlink(tempname);
>>
>> -	/* Fill the file with int's counting from zero and up.  */
>> +    /* Fill the file with int's counting from zero and up.  */
>>      for (i = 0; i < (pagesize * 4) / sizeof i; i++) {
>>          checked_write(test_fd, &i, sizeof i);
>>      }
>>
>> -	/* Append a few extra writes to make the file end at non
>> -	   page boundary.  */
>> +    /*
>> +     * Append a few extra writes to make the file end at non
>> +     * page boundary.
>> +     */
>>      checked_write(test_fd, &i, sizeof i); i++;
>>      checked_write(test_fd, &i, sizeof i); i++;
>>      checked_write(test_fd, &i, sizeof i); i++;
>>
>> -	test_fsize = lseek(test_fd, 0, SEEK_CUR);
>> +    test_fsize = lseek(test_fd, 0, SEEK_CUR);
>>
>> -	/* Run the tests.  */
>> -	check_aligned_anonymous_unfixed_mmaps();
>> -	check_aligned_anonymous_unfixed_colliding_mmaps();
>> -	check_aligned_anonymous_fixed_mmaps();
>> -	check_file_unfixed_mmaps();
>> -	check_file_fixed_mmaps();
>> -	check_file_fixed_eof_mmaps();
>> -	check_file_unfixed_eof_mmaps();
>> -	check_invalid_mmaps();
>> +    /* Run the tests.  */
>> +    check_aligned_anonymous_unfixed_mmaps();
>> +    check_aligned_anonymous_unfixed_colliding_mmaps();
>> +    check_aligned_anonymous_fixed_mmaps();
>> +    check_file_unfixed_mmaps();
>> +    check_file_fixed_mmaps();
>> +    check_file_fixed_eof_mmaps();
>> +    check_file_unfixed_eof_mmaps();
>> +    check_invalid_mmaps();
>>
>> -	/* Fails at the moment.  */
>> -	/* check_aligned_anonymous_fixed_mmaps_collide_with_host(); */
>> +    /* Fails at the moment.  */
>> +    /* check_aligned_anonymous_fixed_mmaps_collide_with_host(); */
>>
>> -	return EXIT_SUCCESS;
>> +    return EXIT_SUCCESS;
>>  }
>
>
>--
>Alex Benn??e

-- 
Wei Yang
Help you, Help me

