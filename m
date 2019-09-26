Return-Path: <SRS0=3xBk=XV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A963DC4360C
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2019 16:13:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 723B4222C7
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2019 16:13:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Voy3bqk3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 723B4222C7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40316 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDWOG-0002n2-3Z
	for qemu-devel@archiver.kernel.org; Thu, 26 Sep 2019 12:13:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35140)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iDWGk-0000ry-G8
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 12:05:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iDWGf-0006AG-DF
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 12:05:22 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:43145)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iDWGf-0005ys-6j
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 12:05:21 -0400
Received: by mail-wr1-f66.google.com with SMTP id q17so3120688wrx.10
 for <qemu-devel@nongnu.org>; Thu, 26 Sep 2019 09:05:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=DK9+0/aJPqrrM+iCrtMoyrk4NjLPtNIx0vWGTy+vbjY=;
 b=Voy3bqk3UCjGOQa4A7E+yVi5bU+/4fbBFPLWuuJlgECXxucq2PdV7xejaK9JbN6eMC
 xe6+zXnfgCHez8gVI9/CGfqVXadUQnbV8lHqg4gyYcw6p9daFGm8MFxYxisBFoUbXzBw
 1GAK+qThKRO1ksygCMMundo85QPjM4L0XWyPrCjGHnjU1BV2jKZL1LGSn+IAOCRYc18s
 lp6s7gsmSQ9xvXt6DIbVTy18FHh/G2kHWE8LFZlOpcjbx3LymPOWwpdSJ+2+MH1D7HaZ
 WM7f2n15QxJxr2czEC2nRIZahacnkqauPNTFfax4heS6REoxvXDtqtTYFxZpEqGmUzNA
 SL+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=DK9+0/aJPqrrM+iCrtMoyrk4NjLPtNIx0vWGTy+vbjY=;
 b=pjnKkv7LPvydmrYKBHG/vfOZaXwhwraatA1g11WBOw9+rWncsSvNbMF36bO1Pxwih9
 cIcvWw5fBi/zfEg7Ltr0qUF8/8LRWHu9YrAYfK2riEjhGjjsCHJ3ppicXoQeu0FrY1ps
 8WTlJ9+vDL84+U5tx+3p1n4XtzTbuKTXGpXQjjX92DgNGp/fLwz59owqOvit0hia3oWs
 bW7kbe3gDNhaCRioWQ6GLaaFYFzNKlEUSUgWXNC7EZvw9muI7unAJvJwpLVadbAn4XLi
 E64qxU1tGqjDWvnvbJ+uylN+VSw5vO0eaPIYD1TNHXtqgcxE6Bups/f9kd0Lss8vi/dg
 d7dQ==
X-Gm-Message-State: APjAAAVibnR1Wv0KRVzHZPE1/VXM+nQ2GOcSDYMkW3Sx6qmuWdlbYvbL
 WWqGmZLdgF1ktFzENFjUo4XYMg==
X-Google-Smtp-Source: APXvYqyEy40ZrJhnWkvcdGHMQ7GWX72dx0Q2VOFC1+qB+JudB814U+ZR3tGOuVlPNr69u50NzYjFjw==
X-Received: by 2002:adf:e951:: with SMTP id m17mr3575628wrn.154.1569513855123; 
 Thu, 26 Sep 2019 09:04:15 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id y12sm3466556wrn.74.2019.09.26.09.04.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Sep 2019 09:04:14 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 8FA901FF87;
 Thu, 26 Sep 2019 17:04:13 +0100 (BST)
References: <20190924210106.27117-1-alex.bennee@linaro.org>
 <20190924210106.27117-30-alex.bennee@linaro.org>
 <95fcc08f-d2f1-edf7-0203-d867d297ac9f@redhat.com>
 <87ftkk9ch0.fsf@linaro.org>
 <a3afe1d8-b621-ba0c-58c3-d049d6eac665@redhat.com>
User-agent: mu4e 1.3.4; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Subject: Re: [PATCH v3 29/33] docker: remove 'deprecated' image definitions
In-reply-to: <a3afe1d8-b621-ba0c-58c3-d049d6eac665@redhat.com>
Date: Thu, 26 Sep 2019 17:04:13 +0100
Message-ID: <87a7ar9h8i.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.66
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

> Hi Alex,
>
> On 9/26/19 1:34 AM, Alex Benn=C3=A9e wrote:
>> Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:
>>> On 9/24/19 11:01 PM, Alex Benn=C3=A9e wrote:
>>>> From: John Snow <jsnow@redhat.com>
>>>>
>>>> There isn't a debian.dockerfile anymore,
>>>> so perform some ghost-busting.
>>>
>>> Won't we deprecate other images in the future?
>>
>> Sure but we can just drop them from dockerfiles. It's not like we
>> allowed people to use them as we filtered them out.
>
> This patch isn't about removing a deprecated image, but about removing
> the handy DOCKER_DEPRECATED_IMAGES variable used to start a deprecation
> process.

But it wasn't really doing anything. Because adding the image to
DOCKER_DEPRECATED_IMAGES had the same effect as using
DOCKER_PARTIAL_IMAGES. You couldn't invoke the test from make and it was
dropped out from the dependencies for the do-X-on-all image rules. As it
was also hidden from the help you might as well just delete the thing
all together.

> Fam remembered once we should respect the QEMU deprecation policy even
> with docker images, because there might be users relying on them, so we
> want to give them time to adapt. I can not find a thread on the list, so
> we might have discussed that over IRC. The related commits are:
>
> $ git show bcaf457786c
>
>     docker: do not display deprecated images in 'make docker' help
>
>     the 'debian' base image is deprecated since 3e11974988d8
>
> $ git show 3e11974988d8
>
>     docker: warn users to use newer debian8/debian9 base image
>
>     to stay backward incompatible.
>
> I'd rather keep the DOCKER_DEPRECATED_IMAGES variable empty, maybe with
> a comment describing why it exists. What do you think?

I think deprecations are better handled by a noisy warning in the
dockerfile than the silent suppression of their existence by the make
system.

>
> Thanks,
>
> Phil.
>
>>>> Signed-off-by: John Snow <jsnow@redhat.com>
>>>> Message-Id: <20190923181140.7235-4-jsnow@redhat.com>
>>>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>>>> ---
>>>>  tests/docker/Makefile.include | 7 +++----
>>>>  1 file changed, 3 insertions(+), 4 deletions(-)
>>>>
>>>> diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.inc=
lude
>>>> index 82d5a8a5393..fd6f470fbf8 100644
>>>> --- a/tests/docker/Makefile.include
>>>> +++ b/tests/docker/Makefile.include
>>>> @@ -4,11 +4,10 @@
>>>>
>>>>  DOCKER_SUFFIX :=3D .docker
>>>>  DOCKER_FILES_DIR :=3D $(SRC_PATH)/tests/docker/dockerfiles
>>>> -DOCKER_DEPRECATED_IMAGES :=3D debian
>>>>  # we don't run tests on intermediate images (used as base by another =
image)
>>>> -DOCKER_PARTIAL_IMAGES :=3D debian debian9 debian10 debian-sid
>>>> +DOCKER_PARTIAL_IMAGES :=3D debian9 debian10 debian-sid
>>>>  DOCKER_PARTIAL_IMAGES +=3D debian9-mxe debian-ports debian-bootstrap
>>>> -DOCKER_IMAGES :=3D $(filter-out $(DOCKER_DEPRECATED_IMAGES),$(sort $(=
notdir $(basename $(wildcard $(DOCKER_FILES_DIR)/*.docker)))))
>>>> +DOCKER_IMAGES :=3D $(sort $(notdir $(basename $(wildcard $(DOCKER_FIL=
ES_DIR)/*.docker))))
>>>>  DOCKER_TARGETS :=3D $(patsubst %,docker-image-%,$(DOCKER_IMAGES))
>>>>  # Use a global constant ccache directory to speed up repetitive builds
>>>>  DOCKER_CCACHE_DIR :=3D $$HOME/.cache/qemu-docker-ccache
>>>> @@ -160,7 +159,7 @@ docker-image-debian-powerpc-user-cross: docker-bin=
fmt-image-debian-powerpc-user
>>>>  DOCKER_USER_IMAGES +=3D debian-powerpc-user
>>>>
>>>>  # Expand all the pre-requistes for each docker image and test combina=
tion
>>>> -$(foreach i,$(filter-out $(DOCKER_PARTIAL_IMAGES),$(DOCKER_IMAGES) $(=
DOCKER_DEPRECATED_IMAGES)), \
>>>> +$(foreach i,$(filter-out $(DOCKER_PARTIAL_IMAGES),$(DOCKER_IMAGES)), \
>>>>  	$(foreach t,$(DOCKER_TESTS) $(DOCKER_TOOLS), \
>>>>  		$(eval .PHONY: docker-$t@$i) \
>>>>  		$(eval docker-$t@$i: docker-image-$i docker-run-$t@$i) \
>>>>
>>
>>
>> --
>> Alex Benn=C3=A9e
>>


--
Alex Benn=C3=A9e

