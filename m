Return-Path: <SRS0=SZz4=XU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3203C432C2
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 23:37:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE3CC205F4
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 23:37:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ye2dW6KM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE3CC205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58428 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDGqB-00015M-QH
	for qemu-devel@archiver.kernel.org; Wed, 25 Sep 2019 19:36:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43286)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iDGpC-0000UN-1S
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 19:35:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iDGp9-0000FD-FG
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 19:35:56 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:37928)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iDGp8-0000Cu-Pp
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 19:35:55 -0400
Received: by mail-wr1-f67.google.com with SMTP id l11so551499wrx.5
 for <qemu-devel@nongnu.org>; Wed, 25 Sep 2019 16:35:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=i77jZr4CxkGLR4SMzgJMk63z/9wilwqJW52YWWlaF7I=;
 b=ye2dW6KMrtcfdzWyQIfEc+1AYJTaZF3A8DRQaV+IZn/aVY9FFJe6YZOmfa8215nnok
 wmLPhonQYvLTxqFqRR/oLlvI8Rt+kN0CqT+LIJiZ610riiiZw/z5o4emDCNjTma1N4ij
 dSzAnQjGPE+YWcJj2SzitpNhLs66TOoQJEs+lYX4FT3ByBWHh5iUvGkvcpvvvhiHRwnA
 HT+/z3Y+yrvbDidrrxYIwBTF4fHEgepd5eDGH4J7HWn9Gtc7BG+uj1V5FsACqgrE5bzh
 fU8Su8FIW5fcKSTi0ef2rjiSKiVcxoXdiGELGSD/+qsb97mI32hGrie5fxpRPSNGy1cz
 O5/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=i77jZr4CxkGLR4SMzgJMk63z/9wilwqJW52YWWlaF7I=;
 b=KL8z52BlrOc0E/ei62BYs/WAU/rEO4XRMbFsc9CHuz86ZZZ6e8R2ee8GteYihqKzgX
 iGgVGzewHJLTKatrrsvskHvKa1XhxkO8crE2yCmG6vqfx36lXPHAZfsSx3kwMbpUo2Fh
 rwNHnvfMmmd6tYMl+8zLUJRp6LlE4iVQML3Fptu/Xec1FjBY0m38MGUGpOBCO+hFQBm5
 X19z48zPw8XwVtJCdvC6XlFaptd22qtjdOwM6/8p6SrRR0lSYWgqS5CUGcE5jflirKTk
 wiUNQXbFuSKPm3ByaMATp/VdUtbYgaZWC2Q9Y0lM0PgY/HoAHYGzOAure47xWf1ZynRt
 SUxg==
X-Gm-Message-State: APjAAAW1yszLOSkSBOVSdOeUc8COx6tqjePx1H6SC7zTytXrO3s2K9Mf
 PpCYxdo5hIQo55Xf9MfUs1ThQJJLULeUdA==
X-Google-Smtp-Source: APXvYqwh44iITrSOVXbrhEDviCxlgljUhUd+NNKsfxQQ7Ofoz16kSuKhYJTAJR49WvzBbBDovg0siA==
X-Received: by 2002:adf:e390:: with SMTP id e16mr531857wrm.29.1569454493402;
 Wed, 25 Sep 2019 16:34:53 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id a71sm414561wme.11.2019.09.25.16.34.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Sep 2019 16:34:52 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id ECAE31FF87;
 Thu, 26 Sep 2019 00:34:51 +0100 (BST)
References: <20190924210106.27117-1-alex.bennee@linaro.org>
 <20190924210106.27117-30-alex.bennee@linaro.org>
 <95fcc08f-d2f1-edf7-0203-d867d297ac9f@redhat.com>
User-agent: mu4e 1.3.4; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Subject: Re: [PATCH v3 29/33] docker: remove 'deprecated' image definitions
In-reply-to: <95fcc08f-d2f1-edf7-0203-d867d297ac9f@redhat.com>
Date: Thu, 26 Sep 2019 00:34:51 +0100
Message-ID: <87ftkk9ch0.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.67
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
Cc: Fam Zheng <fam@euphon.net>, jsnow@redhat.com, qemu-devel@nongnu.org,
 f4bug@amsat.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:

> On 9/24/19 11:01 PM, Alex Benn=C3=A9e wrote:
>> From: John Snow <jsnow@redhat.com>
>>
>> There isn't a debian.dockerfile anymore,
>> so perform some ghost-busting.
>
> Won't we deprecate other images in the future?

Sure but we can just drop them from dockerfiles. It's not like we
allowed people to use them as we filtered them out.

>
>> Signed-off-by: John Snow <jsnow@redhat.com>
>> Message-Id: <20190923181140.7235-4-jsnow@redhat.com>
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> ---
>>  tests/docker/Makefile.include | 7 +++----
>>  1 file changed, 3 insertions(+), 4 deletions(-)
>>
>> diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.inclu=
de
>> index 82d5a8a5393..fd6f470fbf8 100644
>> --- a/tests/docker/Makefile.include
>> +++ b/tests/docker/Makefile.include
>> @@ -4,11 +4,10 @@
>>
>>  DOCKER_SUFFIX :=3D .docker
>>  DOCKER_FILES_DIR :=3D $(SRC_PATH)/tests/docker/dockerfiles
>> -DOCKER_DEPRECATED_IMAGES :=3D debian
>>  # we don't run tests on intermediate images (used as base by another im=
age)
>> -DOCKER_PARTIAL_IMAGES :=3D debian debian9 debian10 debian-sid
>> +DOCKER_PARTIAL_IMAGES :=3D debian9 debian10 debian-sid
>>  DOCKER_PARTIAL_IMAGES +=3D debian9-mxe debian-ports debian-bootstrap
>> -DOCKER_IMAGES :=3D $(filter-out $(DOCKER_DEPRECATED_IMAGES),$(sort $(no=
tdir $(basename $(wildcard $(DOCKER_FILES_DIR)/*.docker)))))
>> +DOCKER_IMAGES :=3D $(sort $(notdir $(basename $(wildcard $(DOCKER_FILES=
_DIR)/*.docker))))
>>  DOCKER_TARGETS :=3D $(patsubst %,docker-image-%,$(DOCKER_IMAGES))
>>  # Use a global constant ccache directory to speed up repetitive builds
>>  DOCKER_CCACHE_DIR :=3D $$HOME/.cache/qemu-docker-ccache
>> @@ -160,7 +159,7 @@ docker-image-debian-powerpc-user-cross: docker-binfm=
t-image-debian-powerpc-user
>>  DOCKER_USER_IMAGES +=3D debian-powerpc-user
>>
>>  # Expand all the pre-requistes for each docker image and test combinati=
on
>> -$(foreach i,$(filter-out $(DOCKER_PARTIAL_IMAGES),$(DOCKER_IMAGES) $(DO=
CKER_DEPRECATED_IMAGES)), \
>> +$(foreach i,$(filter-out $(DOCKER_PARTIAL_IMAGES),$(DOCKER_IMAGES)), \
>>  	$(foreach t,$(DOCKER_TESTS) $(DOCKER_TOOLS), \
>>  		$(eval .PHONY: docker-$t@$i) \
>>  		$(eval docker-$t@$i: docker-image-$i docker-run-$t@$i) \
>>


--
Alex Benn=C3=A9e

