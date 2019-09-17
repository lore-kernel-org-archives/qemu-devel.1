Return-Path: <SRS0=ES4k=XM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60307C4CECD
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2019 19:33:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A7AC20578
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2019 19:33:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NBpp2ZEf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A7AC20578
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51638 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAJDp-0006wu-AT
	for qemu-devel@archiver.kernel.org; Tue, 17 Sep 2019 15:33:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46890)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iAJB4-00051d-Fm
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 15:30:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iAJB3-0008CW-0k
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 15:30:18 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:56282)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iAJB2-0008C9-OJ
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 15:30:16 -0400
Received: by mail-wm1-x344.google.com with SMTP id a6so124104wma.5
 for <qemu-devel@nongnu.org>; Tue, 17 Sep 2019 12:30:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=TahDyWwkYjkwjfJHQs/EoPTBh9s6o2ZJEPSiUbKFVDU=;
 b=NBpp2ZEff1v7Oo+TQkA05NeR0bnXNM+9eplXIGc03aUys1zWuyO8glb9s3dW7XUpJN
 pNyBzMjvSc6vObWktJD31D5FWhPyeRzqo3OWYjIlXRF+BdAKXVJingnKuIf1BCERsnv4
 qah2Asv4MYBiWGcWye8zjTf2+NMK1nz859B++uYtiTTV22K+NbSRYuYor3MYen3TQkcU
 No3/rnQHQdWNH4CMUhGpJ6L8XuP+AfTikMlBHAQ3ToD7s+vendNycMJRXTUsfgFpZBwR
 SIE6G58gjXdSjLUqQyePVoBzCQCNlc6dosgpayKyp7noTFlulLi93MzmagVbY0MBgwIM
 SqIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=TahDyWwkYjkwjfJHQs/EoPTBh9s6o2ZJEPSiUbKFVDU=;
 b=F0NZ7K88j0cOWEf5sKa2I0Cjui2m3rRlmpyY9MFUXAIelN902gnYxKY/cKtpFeVk3d
 URzNWwYfFYnyxZsPU0NKRUnypE85kEpJSQHw2volOm7iKSbsyb3+WZhriHtSQvQeq2On
 LrqwSU5t1iDsFtbhgwEQeeHyoipzBIBvdnKOUs2BBlrZhEXh86hn2CtkNr1ci3tIMN1N
 1poMykcjq9W9Q1F6H7BLt84rojrDWIVpFjh5rY2SfAsu4Kk8TgVe+skNATZ5LPt8J+KW
 TFDqxPG3K9LYUUdyQEKtWXvmZwWxN85psHzKPH73qm9rS04jNQQD7xmZkZXbt+MgtoM2
 BKRQ==
X-Gm-Message-State: APjAAAW6uH0Zj9Tv+OdYaVyZj9ARtu93H0U5o7VP46dEmd6QULV9Auqg
 N3wTBEFYeQf1jdWlTuf16BbN9g==
X-Google-Smtp-Source: APXvYqzxfze8nW+ozLRve/j61ZPjMpUKl7gIskh4tgVteUXm3WdZejalm2aAmRx9/AplqW7s4BqZFw==
X-Received: by 2002:a05:600c:118a:: with SMTP id
 i10mr4770136wmf.80.1568748615493; 
 Tue, 17 Sep 2019 12:30:15 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id c10sm5102683wrf.58.2019.09.17.12.30.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Sep 2019 12:30:14 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 201D31FF87;
 Tue, 17 Sep 2019 20:30:14 +0100 (BST)
References: <20190917184948.24627-1-jsnow@redhat.com>
 <87d0fy21j9.fsf@linaro.org>
 <8ab20bc7-5aa0-53c0-6508-46819566dc07@redhat.com>
User-agent: mu4e 1.3.4; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: John Snow <jsnow@redhat.com>
In-reply-to: <8ab20bc7-5aa0-53c0-6508-46819566dc07@redhat.com>
Date: Tue, 17 Sep 2019 20:30:14 +0100
Message-ID: <87a7b2201l.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::344
Subject: Re: [Qemu-devel] [PATCH] tests/vm: remove unused --target-list
 option
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
Cc: Fam Zheng <fam@euphon.net>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


John Snow <jsnow@redhat.com> writes:

> On 9/17/19 2:58 PM, Alex Benn=C3=A9e wrote:
>>
>> John Snow <jsnow@redhat.com> writes:
>>
>>> It's not used; so remove the distraction.
>>
>> It's a developer feature so you can run specific builds against the VM
>> images. I certainly have used it, unless you are saying it's broken now?
>>
>
> What consumes it? I can't find where it *does* something:

It's past as the rest:

                -- \ <- all args after this
		$(if $(TARGET_LIST),--target-list=3D$(TARGET_LIST)) \
		$(if $(EXTRA_CONFIGURE_OPTS),$(EXTRA_CONFIGURE_OPTS)), \

Become argv in:

        args, argv =3D parse_args(vmcls)
        ...
                    cmd =3D [vm.BUILD_SCRIPT.format(
                   configure_opts =3D " ".join(argv),
                   jobs=3Dint(args.jobs),
                   target=3Dargs.build_target,
                   verbose =3D "V=3D1" if args.verbose else "")]


>
> jhuston@probe ~/s/q/t/vm (docker-partial-fixup)> git grep TARGET_LIST
> Makefile.include:       @echo "    TARGET_LIST=3Da,b,c             -
> Override target list in builds"
> Makefile.include:               $(if
> $(TARGET_LIST),--target-list=3D$(TARGET_LIST)) \
> jhuston@probe ~/s/q/t/vm (docker-partial-fixup)> git grep target-list
> Makefile.include:               $(if
> $(TARGET_LIST),--target-list=3D$(TARGET_LIST)) \
> jhuston@probe ~/s/q/t/vm (docker-partial-fixup)> git grep target_list
> jhuston@probe ~/s/q/t/vm (docker-partial-fixup) [1]>
>
>
> the VM script doesn't seem to pick it up or apply defaults, so I don't
> know where this was supposed to be routed to.
>
>
>>>
>>> Signed-off-by: John Snow <jsnow@redhat.com>
>>> ---
>>>  tests/vm/Makefile.include | 2 --
>>>  1 file changed, 2 deletions(-)
>>>
>>> diff --git a/tests/vm/Makefile.include b/tests/vm/Makefile.include
>>> index fea348e845..61758101fa 100644
>>> --- a/tests/vm/Makefile.include
>>> +++ b/tests/vm/Makefile.include
>>> @@ -28,7 +28,6 @@ vm-help vm-test:
>>>  	@echo
>>>  	@echo "Special variables:"
>>>  	@echo "    BUILD_TARGET=3Dfoo		 - Override the build target"
>>> -	@echo "    TARGET_LIST=3Da,b,c    	 - Override target list in builds"
>>>  	@echo '    EXTRA_CONFIGURE_OPTS=3D"..."'
>>>  	@echo "    J=3D[0..9]*            	 - Override the -jN parameter for =
make commands"
>>>  	@echo "    DEBUG=3D1              	 - Enable verbose output on host a=
nd interactive debugging"
>>> @@ -65,7 +64,6 @@ vm-build-%: $(IMAGES_DIR)/%.img
>>>  		$(if $(BUILD_TARGET),--build-target $(BUILD_TARGET)) \
>>>  		--snapshot \
>>>  		--build-qemu $(SRC_PATH) -- \
>>> -		$(if $(TARGET_LIST),--target-list=3D$(TARGET_LIST)) \
>>>  		$(if $(EXTRA_CONFIGURE_OPTS),$(EXTRA_CONFIGURE_OPTS)), \
>>>  		"  VM-BUILD $*")
>>
>>


--
Alex Benn=C3=A9e

