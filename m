Return-Path: <SRS0=PARU=US=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7495C31E49
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2019 11:42:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 93E3C2084A
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2019 11:42:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bJQpoeAk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93E3C2084A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37084 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hdYyV-0000So-MF
	for qemu-devel@archiver.kernel.org; Wed, 19 Jun 2019 07:41:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43455)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hdYvj-0007Tr-SP
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 07:39:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hdYpS-0002z4-FC
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 07:32:41 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:38603)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hdYpS-0002xk-0F
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 07:32:38 -0400
Received: by mail-wr1-x442.google.com with SMTP id d18so3005752wrs.5
 for <qemu-devel@nongnu.org>; Wed, 19 Jun 2019 04:32:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=ybDWdZQHY88znfAWknb2HSO38lGUHVCjDwy1SgqydJ8=;
 b=bJQpoeAkS6pNLdBY4HhqKm0H7GxM+BqyEHprVU0o+tJCfcoR4Gq7mbW7nnMWvj0y0O
 x0qSFJAGb1UbFEkeaP+cywjGP4bn0cDTfrotd6ZLBWdWkCR967n5S9PsVzKxFe7aFHr2
 qpmofe8KpjgnzL44wr5uUFW+wqy87Jr4kLZri3uHkTwM2CZAdVP8/CL4430D7e5bHE7y
 wAioIbRfvkUZa06rLZJ7yJHP1VmIZYKuyFFUEmcWCRYvgNjN5NP2olU/r9FtaUpKL6+w
 0pssKQDO/OxM/iGNOeKYtFqgXYgyRnu4fu19TUTiFneihGxzWo80bIa6A62DOj8r9QsE
 xVJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=ybDWdZQHY88znfAWknb2HSO38lGUHVCjDwy1SgqydJ8=;
 b=JTQokNuMBlNI4XVq0x6AhYvdYMEmfDeAb+ocD2mUAQk2n35KnclzWCT2KktgeeWqdL
 GmpZnNj8pGvqzIQSp0m8uDYMfOuvOIJNUZeBLNPqkjtnLdVBFBq5L1BywDqRTwNbaKQ7
 sLNvRSQVfZFJUVHUhcBJaAHp32XCDEKM6tOp55Qvqf/7xtqo1wahOsv1C+ztkCvVpgds
 sRxbON588ZGMOuIXyFA+h7ESV8Srvc0axmjd485gRp5MlaBfYvMUaZv1Q4+bQlhIHAjX
 jlv6m43gMvs/20W4Paw+bSerRqeJCvRWs7FkypohywBIRch6TmLFHlOsTlDJ7jzcu6Xz
 3lPA==
X-Gm-Message-State: APjAAAU+Ngx7NSyl9/HqgX89sDo4WpNXc9Jep/D7haSMm05Z2jciDyTw
 UdAuY4Xq6UU4WdVZ9GnVt75G6Q==
X-Google-Smtp-Source: APXvYqwtAi0IZBRbvzLlyR8QH4oUZnZfxk9kkxnMr0zGBLcUD3q78f7D82jzJzQib8nDP9JB3v5f2w==
X-Received: by 2002:a5d:56c1:: with SMTP id m1mr2761479wrw.26.1560943955791;
 Wed, 19 Jun 2019 04:32:35 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id a67sm1311071wmh.40.2019.06.19.04.32.34
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Wed, 19 Jun 2019 04:32:35 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 8136A1FF87;
 Wed, 19 Jun 2019 12:32:34 +0100 (BST)
References: <20190614171200.21078-1-alex.bennee@linaro.org>
 <20190614171200.21078-8-alex.bennee@linaro.org>
 <CADYwmhHZWBmPHJ=HGDmDD9jrSwD_ufrmRVpLzTz9FYOY9E6nEA@mail.gmail.com>
User-agent: mu4e 1.3.2; emacs 26.1
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Pranith Kumar <pranith.foss@gmail.com>
In-reply-to: <CADYwmhHZWBmPHJ=HGDmDD9jrSwD_ufrmRVpLzTz9FYOY9E6nEA@mail.gmail.com>
Date: Wed, 19 Jun 2019 12:32:34 +0100
Message-ID: <8736k5ajzh.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
Subject: Re: [Qemu-devel] [PATCH v3 07/50] plugin: add user-facing API
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
Cc: "Emilio G. Cota" <cota@braap.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Pranith Kumar <pranith.foss@gmail.com> writes:

> On Fri, Jun 14, 2019 at 10:24 AM Alex Benn=C3=A9e <alex.bennee@linaro.org=
> wrote:
>>
>> From: "Emilio G. Cota" <cota@braap.org>
>>
>> Add the API first to ease review.
>>
>> Signed-off-by: Emilio G. Cota <cota@braap.org>
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>>
>> ---
>> v3
>>   - merge in changes to plugin install/reset/uninstall
>>   - split api file
>> ---
>>  include/qemu/qemu-plugin.h | 339 +++++++++++++++++++++++++++++++++++++
>>  1 file changed, 339 insertions(+)
>>  create mode 100644 include/qemu/qemu-plugin.h
>>
>> diff --git a/include/qemu/qemu-plugin.h b/include/qemu/qemu-plugin.h
>> new file mode 100644
>> index 0000000000..0db1ef9714
>> --- /dev/null
>> +++ b/include/qemu/qemu-plugin.h
>> @@ -0,0 +1,339 @@
>> +/*
>> + * Copyright (C) 2017, Emilio G. Cota <cota@braap.org>
>> + * Copyright (C) 2019, Linaro
>> + *
>> + * License: GNU GPL, version 2 or later.
>> + *   See the COPYING file in the top-level directory.
>> + *
>> + * SPDX-License-Identifier: GPL-2.0-or-later
>> + */
>> +#ifndef QEMU_PLUGIN_API_H
>> +#define QEMU_PLUGIN_API_H
>> +
>> +#include <inttypes.h>
>> +#include <stdbool.h>
>> +
>> +/*
>> + * For best performance, build the plugin with -fvisibility=3Dhidden so=
 that
>> + * QEMU_PLUGIN_LOCAL is implicit. Then, just mark qemu_plugin_install w=
ith
>> + * QEMU_PLUGIN_EXPORT. For more info, see
>> + *   https://gcc.gnu.org/wiki/Visibility
>> + */
>> +#if defined _WIN32 || defined __CYGWIN__
>> +  #ifdef BUILDING_DLL
>> +    #define QEMU_PLUGIN_EXPORT __declspec(dllexport)
>> +  #else
>> +    #define QEMU_PLUGIN_EXPORT __declspec(dllimport)
>> +  #endif
>> +  #define QEMU_PLUGIN_LOCAL
>> +#else
>> +  #if __GNUC__ >=3D 4
>> +    #define QEMU_PLUGIN_EXPORT __attribute__((visibility("default")))
>> +    #define QEMU_PLUGIN_LOCAL  __attribute__((visibility("hidden")))
>> +  #else
>> +    #define QEMU_PLUGIN_EXPORT
>> +    #define QEMU_PLUGIN_LOCAL
>> +  #endif
>> +#endif
>> +
>> +typedef uint64_t qemu_plugin_id_t;
>> +
>> +/**
>> + * qemu_plugin_install() - Install a plugin
>> + * @id: this plugin's opaque ID
>> + * @argc: number of arguments
>> + * @argv: array of arguments (@argc elements)
>> + *
>> + * All plugins must export this symbol.
>> + *
>> + * Note: Calling qemu_plugin_uninstall() from this function is a bug. T=
o raise
>> + * an error during install, return !0.
>> + *
>> + * Note: @argv remains valid throughout the lifetime of the loaded plug=
in.
>> + */
>> +QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id, int arg=
c,
>> +                                           char **argv);
>> +
>> +/*
>> + * Prototypes for the various callback styles we will be registering
>> + * in the following functions.
>> + */
>> +typedef void (*qemu_plugin_simple_cb_t)(qemu_plugin_id_t id);
>> +
>> +typedef void (*qemu_plugin_udata_cb_t)(qemu_plugin_id_t id, void *userd=
ata);
>> +
>> +typedef void (*qemu_plugin_vcpu_simple_cb_t)(qemu_plugin_id_t id,
>> +                                             unsigned int vcpu_index);
>> +
>> +typedef void (*qemu_plugin_vcpu_udata_cb_t)(unsigned int vcpu_index,
>> +                                            void *userdata);
>> +
>> +/**
>> + * qemu_plugin_uninstall() - Uninstall a plugin
>> + * @id: this plugin's opaque ID
>> + * @cb: callback to be called once the plugin has been removed
>> + *
>> + * Do NOT assume that the plugin has been uninstalled once this function
>> + * returns. Plugins are uninstalled asynchronously, and therefore the g=
iven
>> + * plugin receives callbacks until @cb is called.
>> + *
>> + * Note: Calling this function from qemu_plugin_install() is a bug.
>> + */
>> +void qemu_plugin_uninstall(qemu_plugin_id_t id, qemu_plugin_simple_cb_t=
 cb);
>> +
>> +/**
>> + * qemu_plugin_reset() - Reset a plugin
>> + * @id: this plugin's opaque ID
>> + * @cb: callback to be called once the plugin has been reset
>> + *
>> + * Unregisters all callbacks for the plugin given by @id.
>> + *
>> + * Do NOT assume that the plugin has been reset once this function retu=
rns.
>> + * Plugins are reset asynchronously, and therefore the given plugin rec=
eives
>> + * callbacks until @cb is called.
>> + */
>> +void qemu_plugin_reset(qemu_plugin_id_t id, qemu_plugin_simple_cb_t cb);
>> +
>> +/**
>> + * qemu_plugin_register_vcpu_init_cb() - register a vCPU initialization=
 callback
>> + * @id: plugin ID
>> + * @cb: callback function
>> + *
>> + * The @cb function is called every time a vCPU is initialized.
>> + *
>> + * See also: qemu_plugin_register_vcpu_exit_cb()
>> + */
>> +void qemu_plugin_register_vcpu_init_cb(qemu_plugin_id_t id,
>> +                                       qemu_plugin_vcpu_simple_cb_t cb);
>> +
>> +/**
>> + * qemu_plugin_register_vcpu_exit_cb() - register a vCPU exit callback
>> + * @id: plugin ID
>> + * @cb: callback function
>> + *
>> + * The @cb function is called every time a vCPU exits.
>> + *
>> + * See also: qemu_plugin_register_vcpu_init_cb()
>> + */
>> +void qemu_plugin_register_vcpu_exit_cb(qemu_plugin_id_t id,
>> +                                       qemu_plugin_vcpu_simple_cb_t cb);
>> +
>> +/**
>> + * qemu_plugin_register_vcpu_idle_cb() - register a vCPU idle callback
>> + * @id: plugin ID
>> + * @cb: callback function
>> + *
>> + * The @cb function is called every time a vCPU idles.
>> + */
>> +void qemu_plugin_register_vcpu_idle_cb(qemu_plugin_id_t id,
>> +                                       qemu_plugin_vcpu_simple_cb_t cb);
>> +
>> +/**
>> + * qemu_plugin_register_vcpu_resume_cb() - register a vCPU resume callb=
ack
>> + * @id: plugin ID
>> + * @cb: callback function
>> + *
>> + * The @cb function is called every time a vCPU resumes execution.
>> + */
>> +void qemu_plugin_register_vcpu_resume_cb(qemu_plugin_id_t id,
>> +                                         qemu_plugin_vcpu_simple_cb_t c=
b);
>> +
>> +/*
>> + * Opaque types that the plugin is given during the translation and
>> + * instrumentation phase.
>> + */
>> +struct qemu_plugin_tb;
>> +struct qemu_plugin_insn;
>> +
>> +enum qemu_plugin_cb_flags {
>> +    QEMU_PLUGIN_CB_NO_REGS, /* callback does not access the CPU's regs =
*/
>> +    QEMU_PLUGIN_CB_R_REGS,  /* callback reads the CPU's regs */
>> +    QEMU_PLUGIN_CB_RW_REGS, /* callback reads and writes the CPU's regs=
 */
>> +};
>> +
>> +enum qemu_plugin_mem_rw {
>> +    QEMU_PLUGIN_MEM_R =3D 1,
>> +    QEMU_PLUGIN_MEM_W,
>> +    QEMU_PLUGIN_MEM_RW,
>> +};
>
> Why is this structure different from qemu_plugin_cb_flags? I think
> both of them could use a similar structure. Both of them can have
> (_NO, _R, _W, _RW) I think.

They do refer to semantically different things. The plugin CB flags are
important for ensuring registers are synced or not before the callback.
The memory callbacks flags control where the callbacks are placed with
respect to the access.

>
>> +
>> +/**
>> + * qemu_plugin_register_vcpu_tb_trans_cb() - register a translate cb
>> + * @id: plugin ID
>> + * @cb: callback function
>> + *
>> + * The @cb function is called every time a translation occurs. The @cb
>> + * function is passed an opaque qemu_plugin_type which is can query
>
> s/is/it/

Fixed.

--
Alex Benn=C3=A9e

