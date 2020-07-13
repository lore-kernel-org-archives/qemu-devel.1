Return-Path: <SRS0=6r5r=AY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CA9AC433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 19:36:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 38B6D2067D
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 19:36:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QBiXa4HP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38B6D2067D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45494 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jv4Ff-0003C0-Gt
	for qemu-devel@archiver.kernel.org; Mon, 13 Jul 2020 15:36:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46492)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jv4E1-0008RD-Cw
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 15:34:53 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:38800)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jv4Dz-0008OE-L6
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 15:34:53 -0400
Received: by mail-wr1-x442.google.com with SMTP id z13so18010026wrw.5
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2020 12:34:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=rU4PKOpEwQvdB6xFnvx4pbAQ5KeoRYLI3QUiLzMWN58=;
 b=QBiXa4HPvHyO+h8CzGziTfnf4Njvjlrxn0B4Tb68VrM7bseBkzINrIXMKZBGOTER8b
 3XmvG2eC+knMfa66+1i4/iMrS1tvX6XXOsLVLdhjo2Wsrv6R0jV6t3NdBwnN0xupD5yg
 zHntsR70DiBWDmDOQafAYILyP/AqLg4pBYTqTUDmzI3tXRl7oQa5rG+0EUCAMJ0eSyBd
 eP8RCsXpyvnu4bmvfm9BE58GCEQgGzeZhJGbmP+XnJ9nwQE2L6LkrTd6MmWcVYmuEIBc
 gJ4H4DbLRVd2y38JSXYp/20pKJhvedv138mRt3WWF7mzVWnp8kjNjUx2Wp1M1BJScB0M
 WWXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=rU4PKOpEwQvdB6xFnvx4pbAQ5KeoRYLI3QUiLzMWN58=;
 b=rDsjhGtUQXfGaz4CByBxzWOnjSyNS8hJAfHXhvXYBHNZo/PVIpXY5TNx3wrV2kQnoR
 hO19AsbdtLCaaiuDBTYLZv7BleGJA8GgxAFsnyRtI+NGlTU97U6BScRoWaU4SB1gTIrX
 ImOK1H6zy7nh8GhDBn1I4qiLlckofNXOTtERArxUP15eMQRWpnUu9WKHXnG3GDLj5cru
 gjE9R3u7D1aK7soFm2LgBGy8/SQ9kTIITqTrjfjj3FaUma0MhXhFaFBDrPQiNMOaZSRj
 c69mRIhgQ7ToyE7lM2GosYYo60i1f76CgA0Spbq/BxgzAyZnBVl+cauRVdFgcG9iGMEd
 nfyg==
X-Gm-Message-State: AOAM531bSFv7X4BTIg/l2ORc7O0zKXdUDYjM8OekTIHHhvCIhR5+JUYL
 fW49ujAAhy8lOvr6MVhTEV2Dmw==
X-Google-Smtp-Source: ABdhPJwzdOCgYB9tS/+4jtTIvB5GxXt0b2GfChSbB0LoDWG+1ABPJ1p1juaETwj3upRilWcj9GILog==
X-Received: by 2002:a5d:6ac7:: with SMTP id u7mr1130571wrw.25.1594668890121;
 Mon, 13 Jul 2020 12:34:50 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id c25sm747295wml.18.2020.07.13.12.34.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Jul 2020 12:34:47 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 9297C1FF7E;
 Mon, 13 Jul 2020 20:34:46 +0100 (BST)
References: <20200709141327.14631-1-alex.bennee@linaro.org>
 <20200709141327.14631-11-alex.bennee@linaro.org>
 <9c736c87-34c7-375c-61b8-954aa70deab5@linaro.org>
 <87wo37z7vv.fsf@linaro.org>
 <6afbd8ef-9aa5-961d-975f-d26136989e26@redhat.com>
User-agent: mu4e 1.5.4; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH v1 10/13] tests/plugins: add -Wno-unknown-warning-option
 to handle -Wpsabi
In-reply-to: <6afbd8ef-9aa5-961d-975f-d26136989e26@redhat.com>
Date: Mon, 13 Jul 2020 20:34:46 +0100
Message-ID: <87tuybyzs9.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x442.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: fam@euphon.net, berrange@redhat.com, robert.foley@linaro.org,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 robhenry@microsoft.com, f4bug@amsat.org, aaron@os.amperecomputing.com,
 cota@braap.org, peter.puhov@linaro.org, kuhn.chenqun@huawei.com,
 aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Thomas Huth <thuth@redhat.com> writes:

> On 13/07/2020 18.39, Alex Benn=C3=A9e wrote:
>>=20
>> Richard Henderson <richard.henderson@linaro.org> writes:
>>=20
>>> On 7/9/20 7:13 AM, Alex Benn=C3=A9e wrote:
>>>> Not all compilers support the -Wpsabi (clang-9 in my case).
>>>>
>>>> Fixes: bac8d222a
>>>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>>>> ---
>>>>  tests/plugin/Makefile | 2 +-
>>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/tests/plugin/Makefile b/tests/plugin/Makefile
>>>> index 0cb8e35ae407..dcfbd99b15b8 100644
>>>> --- a/tests/plugin/Makefile
>>>> +++ b/tests/plugin/Makefile
>>>> @@ -18,7 +18,7 @@ NAMES +=3D hwprofile
>>>>=20=20
>>>>  SONAMES :=3D $(addsuffix .so,$(addprefix lib,$(NAMES)))
>>>>=20=20
>>>> -QEMU_CFLAGS +=3D -fPIC -Wpsabi
>>>> +QEMU_CFLAGS +=3D -fPIC -Wno-unknown-warning-option -Wpsabi
>>>
>>> Surely -Wno-unknown-warning-option is in the same boat?  E.g. I don't s=
ee any
>>> version of gcc that supports it.
>>=20
>> GCC doesn't seem to complain about it though.
>
> Both, GCC and Clang do not complain about unknown -Wno-somthing options
> as long as there are no other warnings. They only complain for options
> that do not have a "no-" after the "-W".

I've done a little minor surgery on the Makefile to both limit the
pollution of the plugin build from QEMU flags and to only enable the
check if we detect the compiler supports it:

--8<---------------cut here---------------start------------->8---
tests/plugins: don't unconditionally add -Wpsabi

Not all compilers support the -Wpsabi (clang-9 in my case). To handle
this gracefully we pare back the shared build machinery so the
Makefile is relatively "standalone". We still take advantage of
config-host.mak as configure has done a bunch of probing for us but
that is it.

Fixes: bac8d222a
Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

---
v2
  - separate from main build system and check probe

2 files changed, 21 insertions(+), 4 deletions(-)
configure             |  3 +++
tests/plugin/Makefile | 22 ++++++++++++++++++----

modified   configure
@@ -7115,6 +7115,9 @@ echo "GIT_UPDATE=3D$git_update" >> $config_host_mak
=20
 echo "ARCH=3D$ARCH" >> $config_host_mak
=20
+echo "GLIB_CFLAGS=3D$glib_cflags" >> $config_host_mak
+echo "GLIB_LDFLAGS=3D$glib_ldflags" >> $config_host_mak
+
 if test "$default_devices" =3D "yes" ; then
   echo "CONFIG_MINIKCONF_MODE=3D--defconfig" >> $config_host_mak
 else
modified   tests/plugin/Makefile
@@ -1,9 +1,16 @@
+# -*- Mode: makefile -*-
+#
+# This Makefile example is fairly independent from the main makefile
+# so users can take and adapt it for their build. We only really
+# include config-host.mak so we don't have to repeat probing for
+# cflags that the main configure has already done for us.
+#
+
 BUILD_DIR :=3D $(CURDIR)/../..
=20
 include $(BUILD_DIR)/config-host.mak
-include $(SRC_PATH)/rules.mak
=20
-$(call set-vpath, $(SRC_PATH)/tests/plugin)
+VPATH +=3D $(SRC_PATH)/tests/plugin
=20
 NAMES :=3D
 NAMES +=3D bb
@@ -18,11 +25,18 @@ NAMES +=3D hwprofile
=20
 SONAMES :=3D $(addsuffix .so,$(addprefix lib,$(NAMES)))
=20
-QEMU_CFLAGS +=3D -fPIC -Wpsabi
-QEMU_CFLAGS +=3D -I$(SRC_PATH)/include/qemu
+# The main QEMU uses Glib extensively so it's perfectly fine to use it
+# in plugins (which many example do).
+CFLAGS =3D $(GLIB_CFLAGS)
+CFLAGS +=3D -fPIC
+CFLAGS +=3D $(if $(findstring no-psabi,$(QEMU_CFLAGS)),-Wpsabi)
+CFLAGS +=3D -I$(SRC_PATH)/include/qemu
=20
 all: $(SONAMES)
=20
+%.o: %.c
+	$(CC) $(CFLAGS) -c -o $@ $<
+
 lib%.so: %.o
 	$(CC) -shared -Wl,-soname,$@ -o $@ $^ $(LDLIBS)
=20
--8<---------------cut here---------------end--------------->8---


--=20
Alex Benn=C3=A9e

