Return-Path: <SRS0=PARU=US=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40F5CC31E51
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2019 03:37:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E4B0C20665
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2019 03:37:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZLZCN13h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4B0C20665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34898 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hdRQ6-0007Wq-6f
	for qemu-devel@archiver.kernel.org; Tue, 18 Jun 2019 23:37:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47125)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <pranith.foss@gmail.com>) id 1hdRNF-00058A-Mn
 for qemu-devel@nongnu.org; Tue, 18 Jun 2019 23:35:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pranith.foss@gmail.com>) id 1hdRNB-00061e-LM
 for qemu-devel@nongnu.org; Tue, 18 Jun 2019 23:34:59 -0400
Received: from mail-yw1-xc44.google.com ([2607:f8b0:4864:20::c44]:46826)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <pranith.foss@gmail.com>)
 id 1hdRN5-0005yF-Bb
 for qemu-devel@nongnu.org; Tue, 18 Jun 2019 23:34:54 -0400
Received: by mail-yw1-xc44.google.com with SMTP id z197so7318791ywd.13
 for <qemu-devel@nongnu.org>; Tue, 18 Jun 2019 20:34:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=g/RuPybrj0RuEI2jgSPQU7guGyIK4MjWITu5sMDR34U=;
 b=ZLZCN13hGZZiOVdU1JNMmoL477u6xV/Td/ywlM8Z5cGTWwgWSclJf1AncQNDpg31+s
 AjXJ6Mbc45QojHJngyd1IYhZC/aS+7RhAUa157rGNRdRYQye7mbd2QnwOBEu2one4aWJ
 fZacZj/RrkhODwpHE8m5/YMQaEVEjDTC2zKrnNPpA3l44u68XDiKO4pbT6eSHfaaCLXu
 BdiXmMOIYYERggeKH+f5njbmbUTbPv/ZTsSmME92mbeYqzhQ6+v+WYM140ofvX/udXGI
 az66qU2AkQ6aN+I7XDjKk/wYtUfiM/6uOd2/Iz9k7Ptx1o0o/RSuflsOcihegs9vvz3O
 XYtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=g/RuPybrj0RuEI2jgSPQU7guGyIK4MjWITu5sMDR34U=;
 b=pqa/wlbLKrq9QoIS6Y7ybif05VDSWDHTI2dB3ciMcODG7dFdmud0w3H9Ns7RH8s2h5
 Rx7reMf2PmdfRtZ/r5qkGhf3HrXHlLT4vzjZEdKJUt7segjeK8hglR47Z1O/6vrgkwl2
 U0zbo+9Qc7/gdHrtIA9ew0TknozIRVGNBb7gtkMkhynKaLyNi2VLQmx4B7Xb3TZwixWq
 5C/0ftT7DggQnIKwOhX5vHzeJD5tLr6B6UJzwGu8kgOU9aPvbHh4HxO6D3bBvz4F8ePn
 hkBjQMQgffpC8S6Jwe00YYtslXSi3yRe4dciGYyO2GAZPOau5N0hTiNS5WWG+3sqtVfg
 i3lg==
X-Gm-Message-State: APjAAAVhb6KqTZMpx6xPylUjZy5gh8RLvkO/qbYp1wpOes2jsiMg7wIy
 +XtlcO+OChlfNlQbDZ7qgXj/rhQcXaW+eHcZKko=
X-Google-Smtp-Source: APXvYqwEVoryd6Z1oJ2nOiu94adHrIxMYnWYxznjrIcAcsi7IwEAl7dtFvIdKOISxmG1lY3uugyty+1qMnFpdo0oXaY=
X-Received: by 2002:a81:9444:: with SMTP id l65mr44007824ywg.32.1560915285935; 
 Tue, 18 Jun 2019 20:34:45 -0700 (PDT)
MIME-Version: 1.0
References: <20190614171200.21078-1-alex.bennee@linaro.org>
 <20190614171200.21078-8-alex.bennee@linaro.org>
In-Reply-To: <20190614171200.21078-8-alex.bennee@linaro.org>
From: Pranith Kumar <pranith.foss@gmail.com>
Date: Tue, 18 Jun 2019 20:34:35 -0700
Message-ID: <CADYwmhHZWBmPHJ=HGDmDD9jrSwD_ufrmRVpLzTz9FYOY9E6nEA@mail.gmail.com>
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::c44
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

On Fri, Jun 14, 2019 at 10:24 AM Alex Benn=C3=A9e <alex.bennee@linaro.org> =
wrote:
>
> From: "Emilio G. Cota" <cota@braap.org>
>
> Add the API first to ease review.
>
> Signed-off-by: Emilio G. Cota <cota@braap.org>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>
> ---
> v3
>   - merge in changes to plugin install/reset/uninstall
>   - split api file
> ---
>  include/qemu/qemu-plugin.h | 339 +++++++++++++++++++++++++++++++++++++
>  1 file changed, 339 insertions(+)
>  create mode 100644 include/qemu/qemu-plugin.h
>
> diff --git a/include/qemu/qemu-plugin.h b/include/qemu/qemu-plugin.h
> new file mode 100644
> index 0000000000..0db1ef9714
> --- /dev/null
> +++ b/include/qemu/qemu-plugin.h
> @@ -0,0 +1,339 @@
> +/*
> + * Copyright (C) 2017, Emilio G. Cota <cota@braap.org>
> + * Copyright (C) 2019, Linaro
> + *
> + * License: GNU GPL, version 2 or later.
> + *   See the COPYING file in the top-level directory.
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +#ifndef QEMU_PLUGIN_API_H
> +#define QEMU_PLUGIN_API_H
> +
> +#include <inttypes.h>
> +#include <stdbool.h>
> +
> +/*
> + * For best performance, build the plugin with -fvisibility=3Dhidden so =
that
> + * QEMU_PLUGIN_LOCAL is implicit. Then, just mark qemu_plugin_install wi=
th
> + * QEMU_PLUGIN_EXPORT. For more info, see
> + *   https://gcc.gnu.org/wiki/Visibility
> + */
> +#if defined _WIN32 || defined __CYGWIN__
> +  #ifdef BUILDING_DLL
> +    #define QEMU_PLUGIN_EXPORT __declspec(dllexport)
> +  #else
> +    #define QEMU_PLUGIN_EXPORT __declspec(dllimport)
> +  #endif
> +  #define QEMU_PLUGIN_LOCAL
> +#else
> +  #if __GNUC__ >=3D 4
> +    #define QEMU_PLUGIN_EXPORT __attribute__((visibility("default")))
> +    #define QEMU_PLUGIN_LOCAL  __attribute__((visibility("hidden")))
> +  #else
> +    #define QEMU_PLUGIN_EXPORT
> +    #define QEMU_PLUGIN_LOCAL
> +  #endif
> +#endif
> +
> +typedef uint64_t qemu_plugin_id_t;
> +
> +/**
> + * qemu_plugin_install() - Install a plugin
> + * @id: this plugin's opaque ID
> + * @argc: number of arguments
> + * @argv: array of arguments (@argc elements)
> + *
> + * All plugins must export this symbol.
> + *
> + * Note: Calling qemu_plugin_uninstall() from this function is a bug. To=
 raise
> + * an error during install, return !0.
> + *
> + * Note: @argv remains valid throughout the lifetime of the loaded plugi=
n.
> + */
> +QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id, int argc=
,
> +                                           char **argv);
> +
> +/*
> + * Prototypes for the various callback styles we will be registering
> + * in the following functions.
> + */
> +typedef void (*qemu_plugin_simple_cb_t)(qemu_plugin_id_t id);
> +
> +typedef void (*qemu_plugin_udata_cb_t)(qemu_plugin_id_t id, void *userda=
ta);
> +
> +typedef void (*qemu_plugin_vcpu_simple_cb_t)(qemu_plugin_id_t id,
> +                                             unsigned int vcpu_index);
> +
> +typedef void (*qemu_plugin_vcpu_udata_cb_t)(unsigned int vcpu_index,
> +                                            void *userdata);
> +
> +/**
> + * qemu_plugin_uninstall() - Uninstall a plugin
> + * @id: this plugin's opaque ID
> + * @cb: callback to be called once the plugin has been removed
> + *
> + * Do NOT assume that the plugin has been uninstalled once this function
> + * returns. Plugins are uninstalled asynchronously, and therefore the gi=
ven
> + * plugin receives callbacks until @cb is called.
> + *
> + * Note: Calling this function from qemu_plugin_install() is a bug.
> + */
> +void qemu_plugin_uninstall(qemu_plugin_id_t id, qemu_plugin_simple_cb_t =
cb);
> +
> +/**
> + * qemu_plugin_reset() - Reset a plugin
> + * @id: this plugin's opaque ID
> + * @cb: callback to be called once the plugin has been reset
> + *
> + * Unregisters all callbacks for the plugin given by @id.
> + *
> + * Do NOT assume that the plugin has been reset once this function retur=
ns.
> + * Plugins are reset asynchronously, and therefore the given plugin rece=
ives
> + * callbacks until @cb is called.
> + */
> +void qemu_plugin_reset(qemu_plugin_id_t id, qemu_plugin_simple_cb_t cb);
> +
> +/**
> + * qemu_plugin_register_vcpu_init_cb() - register a vCPU initialization =
callback
> + * @id: plugin ID
> + * @cb: callback function
> + *
> + * The @cb function is called every time a vCPU is initialized.
> + *
> + * See also: qemu_plugin_register_vcpu_exit_cb()
> + */
> +void qemu_plugin_register_vcpu_init_cb(qemu_plugin_id_t id,
> +                                       qemu_plugin_vcpu_simple_cb_t cb);
> +
> +/**
> + * qemu_plugin_register_vcpu_exit_cb() - register a vCPU exit callback
> + * @id: plugin ID
> + * @cb: callback function
> + *
> + * The @cb function is called every time a vCPU exits.
> + *
> + * See also: qemu_plugin_register_vcpu_init_cb()
> + */
> +void qemu_plugin_register_vcpu_exit_cb(qemu_plugin_id_t id,
> +                                       qemu_plugin_vcpu_simple_cb_t cb);
> +
> +/**
> + * qemu_plugin_register_vcpu_idle_cb() - register a vCPU idle callback
> + * @id: plugin ID
> + * @cb: callback function
> + *
> + * The @cb function is called every time a vCPU idles.
> + */
> +void qemu_plugin_register_vcpu_idle_cb(qemu_plugin_id_t id,
> +                                       qemu_plugin_vcpu_simple_cb_t cb);
> +
> +/**
> + * qemu_plugin_register_vcpu_resume_cb() - register a vCPU resume callba=
ck
> + * @id: plugin ID
> + * @cb: callback function
> + *
> + * The @cb function is called every time a vCPU resumes execution.
> + */
> +void qemu_plugin_register_vcpu_resume_cb(qemu_plugin_id_t id,
> +                                         qemu_plugin_vcpu_simple_cb_t cb=
);
> +
> +/*
> + * Opaque types that the plugin is given during the translation and
> + * instrumentation phase.
> + */
> +struct qemu_plugin_tb;
> +struct qemu_plugin_insn;
> +
> +enum qemu_plugin_cb_flags {
> +    QEMU_PLUGIN_CB_NO_REGS, /* callback does not access the CPU's regs *=
/
> +    QEMU_PLUGIN_CB_R_REGS,  /* callback reads the CPU's regs */
> +    QEMU_PLUGIN_CB_RW_REGS, /* callback reads and writes the CPU's regs =
*/
> +};
> +
> +enum qemu_plugin_mem_rw {
> +    QEMU_PLUGIN_MEM_R =3D 1,
> +    QEMU_PLUGIN_MEM_W,
> +    QEMU_PLUGIN_MEM_RW,
> +};

Why is this structure different from qemu_plugin_cb_flags? I think
both of them could use a similar structure. Both of them can have
(_NO, _R, _W, _RW) I think.

> +
> +/**
> + * qemu_plugin_register_vcpu_tb_trans_cb() - register a translate cb
> + * @id: plugin ID
> + * @cb: callback function
> + *
> + * The @cb function is called every time a translation occurs. The @cb
> + * function is passed an opaque qemu_plugin_type which is can query

s/is/it/


> + * for additional information including the list of translated
> + * instructions. At this point the plugin can register further
> + * callbacks to be triggered when the block or individual instruction
> + * executes.
> + */
> +typedef void (*qemu_plugin_vcpu_tb_trans_cb_t)(qemu_plugin_id_t id,
> +                                               unsigned int vcpu_index,
> +                                               struct qemu_plugin_tb *tb=
);
> +
> +void qemu_plugin_register_vcpu_tb_trans_cb(qemu_plugin_id_t id,
> +                                           qemu_plugin_vcpu_tb_trans_cb_=
t cb);
> +
> +/**
> + * qemu_plugin_register_vcpu_tb_trans_exec_cb() - register execution cal=
lback
> + * @tb: the opaque qemu_plugin_tb handle for the translation
> + * @cb: callback function
> + * @flags: does the plugin read or write the CPU's registers?
> + * @userdata: any plugin data to pass to the @cb?
> + *
> + * The @cb function is called every time a translated unit executes.
> + */
> +void qemu_plugin_register_vcpu_tb_exec_cb(struct qemu_plugin_tb *tb,
> +                                          qemu_plugin_vcpu_udata_cb_t cb=
,
> +                                          enum qemu_plugin_cb_flags flag=
s,
> +                                          void *userdata);
> +
> +enum qemu_plugin_op {
> +    QEMU_PLUGIN_INLINE_ADD_U64,
> +};
> +
> +/**
> + * qemu_plugin_register_vcpu_tb_trans_exec_inline() - execution inline o=
p
> + * @tb: the opaque qemu_plugin_tb handle for the translation
> + * @op: the type of qemu_plugin_op (e.g. ADD_U64)
> + * @ptr: the target memory location for the op
> + * @imm: the op data (e.g. 1)
> + *
> + * Insert an inline op to every time a translated unit executes.
> + * Useful if you just want to increment a single counter somewhere in
> + * memory.
> + */
> +void qemu_plugin_register_vcpu_tb_exec_inline(struct qemu_plugin_tb *tb,
> +                                              enum qemu_plugin_op op,
> +                                              void *ptr, uint64_t imm);
> +
> +/**
> + * qemu_plugin_register_vcpu_insn_exec_cb() - register insn execution cb
> + * @insn: the opaque qemu_plugin_insn handle for an instruction
> + * @cb: callback function
> + * @flags: does the plugin read or write the CPU's registers?
> + * @userdata: any plugin data to pass to the @cb?
> + *
> + * The @cb function is called every time an instruction is executed
> + */
> +void qemu_plugin_register_vcpu_insn_exec_cb(struct qemu_plugin_insn *ins=
n,
> +                                            qemu_plugin_vcpu_udata_cb_t =
cb,
> +                                            enum qemu_plugin_cb_flags fl=
ags,
> +                                            void *userdata);
> +
> +/**
> + * qemu_plugin_register_vcpu_insn_exec_inline() - insn execution inline =
op
> + * @insn: the opaque qemu_plugin_insn handle for an instruction
> + * @cb: callback function
> + * @op: the type of qemu_plugin_op (e.g. ADD_U64)
> + * @ptr: the target memory location for the op
> + * @imm: the op data (e.g. 1)
> + *
> + * Insert an inline op to every time an instruction executes. Useful
> + * if you just want to increment a single counter somewhere in memory.
> + */
> +void qemu_plugin_register_vcpu_insn_exec_inline(struct qemu_plugin_insn =
*insn,
> +                                                enum qemu_plugin_op op,
> +                                                void *ptr, uint64_t imm)=
;
> +
> +/*
> + * Helpers to query information about the instructions in a block
> + */
> +size_t qemu_plugin_tb_n_insns(const struct qemu_plugin_tb *tb);
> +
> +uint64_t qemu_plugin_tb_vaddr(const struct qemu_plugin_tb *tb);
> +
> +struct qemu_plugin_insn *
> +qemu_plugin_tb_get_insn(const struct qemu_plugin_tb *tb, size_t idx);
> +
> +const void *qemu_plugin_insn_data(const struct qemu_plugin_insn *insn);
> +
> +size_t qemu_plugin_insn_size(const struct qemu_plugin_insn *insn);
> +
> +uint64_t qemu_plugin_insn_vaddr(const struct qemu_plugin_insn *insn);
> +void *qemu_plugin_insn_haddr(const struct qemu_plugin_insn *insn);
> +
> +/*
> + * Memory Instrumentation
> + */
> +typedef uint32_t qemu_plugin_meminfo_t;
> +
> +unsigned qemu_plugin_mem_size_shift(qemu_plugin_meminfo_t info);
> +bool qemu_plugin_mem_is_sign_extended(qemu_plugin_meminfo_t info);
> +bool qemu_plugin_mem_is_big_endian(qemu_plugin_meminfo_t info);
> +bool qemu_plugin_mem_is_store(qemu_plugin_meminfo_t info);
> +
> +typedef void
> +(*qemu_plugin_vcpu_mem_cb_t)(unsigned int vcpu_index,
> +                             qemu_plugin_meminfo_t info, uint64_t vaddr,
> +                             void *userdata);
> +
> +typedef void
> +(*qemu_plugin_vcpu_mem_haddr_cb_t)(unsigned int vcpu_index,
> +                                   qemu_plugin_meminfo_t info, uint64_t =
vaddr,
> +                                   void *haddr, void *userdata);
> +
> +void qemu_plugin_register_vcpu_mem_cb(struct qemu_plugin_insn *insn,
> +                                      qemu_plugin_vcpu_mem_cb_t cb,
> +                                      enum qemu_plugin_cb_flags flags,
> +                                      enum qemu_plugin_mem_rw rw,
> +                                      void *userdata);
> +
> +void qemu_plugin_register_vcpu_mem_haddr_cb(struct qemu_plugin_insn *ins=
n,
> +                                            qemu_plugin_vcpu_mem_haddr_c=
b_t cb,
> +                                            enum qemu_plugin_cb_flags fl=
ags,
> +                                            enum qemu_plugin_mem_rw rw,
> +                                            void *userdata);
> +
> +void qemu_plugin_register_vcpu_mem_inline(struct qemu_plugin_insn *insn,
> +                                          enum qemu_plugin_mem_rw rw,
> +                                          enum qemu_plugin_op op, void *=
ptr,
> +                                          uint64_t imm);
> +
> +uint64_t qemu_plugin_ram_addr_from_host(void *haddr);
> +
> +typedef void
> +(*qemu_plugin_vcpu_syscall_cb_t)(qemu_plugin_id_t id, unsigned int vcpu_=
index,
> +                                 int64_t num, uint64_t a1, uint64_t a2,
> +                                 uint64_t a3, uint64_t a4, uint64_t a5,
> +                                 uint64_t a6, uint64_t a7, uint64_t a8);
> +
> +void qemu_plugin_register_vcpu_syscall_cb(qemu_plugin_id_t id,
> +                                          qemu_plugin_vcpu_syscall_cb_t =
cb);
> +
> +typedef void
> +(*qemu_plugin_vcpu_syscall_ret_cb_t)(qemu_plugin_id_t id, unsigned int v=
cpu_idx,
> +                                     int64_t num, int64_t ret);
> +
> +void
> +qemu_plugin_register_vcpu_syscall_ret_cb(qemu_plugin_id_t id,
> +                                         qemu_plugin_vcpu_syscall_ret_cb=
_t cb);
> +
> +
> +/**
> + * qemu_plugin_vcpu_for_each() - iterate over the existing vCPU
> + * @id: plugin ID
> + * @cb: callback function
> + *
> + * The @cb function is called once for each existing vCPU.
> + *
> + * See also: qemu_plugin_register_vcpu_init_cb()
> + */
> +void qemu_plugin_vcpu_for_each(qemu_plugin_id_t id,
> +                               qemu_plugin_vcpu_simple_cb_t cb);
> +
> +void qemu_plugin_register_flush_cb(qemu_plugin_id_t id,
> +                                   qemu_plugin_simple_cb_t cb);
> +
> +void qemu_plugin_register_atexit_cb(qemu_plugin_id_t id,
> +                                    qemu_plugin_udata_cb_t cb, void *use=
rdata);
> +
> +/* returns -1 in user-mode */
> +int qemu_plugin_n_vcpus(void);
> +
> +/* returns -1 in user-mode */
> +int qemu_plugin_n_max_vcpus(void);
> +
> +#endif /* QEMU_PLUGIN_API_H */
> --
> 2.20.1
>
>


--
Pranith

