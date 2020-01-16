Return-Path: <SRS0=QWrs=3F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4224EC33CB1
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 14:21:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF8C020748
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 14:21:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gdwz3UQf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF8C020748
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42834 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1is61e-00084r-Ji
	for qemu-devel@archiver.kernel.org; Thu, 16 Jan 2020 09:21:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50785)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlevitsk@redhat.com>) id 1is606-0006do-V2
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 09:20:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1is603-0002IM-Eo
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 09:19:58 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:44714
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>) id 1is603-0002I9-BL
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 09:19:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579184394;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mfGxQzDnWPMG0JR8I/UTAJjR2Z+tB27r07vLy3W3mvg=;
 b=gdwz3UQf1p9qfg8YHz3nYeuNEB6gOJj8zgICk+TbrA+qJR7ebsUt0MZlBRe1zQwM9emFve
 aAw6PvjutFR6QhJB8XbwVlExZ3RnivrEUywglM6niXPKK55Rwusv5tBLdWqQM7EnUGqTYA
 yWeah/z+DgIwjzOY024x9LgKfs08+Nc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-394-zD0YcHJ7PsWM9ZO3RT5snQ-1; Thu, 16 Jan 2020 09:19:51 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3D96E802C90;
 Thu, 16 Jan 2020 14:19:50 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.48])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6A49289D00;
 Thu, 16 Jan 2020 14:19:41 +0000 (UTC)
Message-ID: <58850d875073ebf10a6ca965d8cac3cebfcfab74.camel@redhat.com>
Subject: Re: [PATCH 00/13] LUKS: encryption slot management using amend
 interface
From: Maxim Levitsky <mlevitsk@redhat.com>
To: qemu-devel@nongnu.org
Date: Thu, 16 Jan 2020 16:19:40 +0200
In-Reply-To: <157903664410.1076.15150459157549852147@37313f22b938>
References: <157903664410.1076.15150459157549852147@37313f22b938>
Mime-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: zD0YcHJ7PsWM9ZO3RT5snQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
Cc: kwolf@redhat.com, berrange@redhat.com, qemu-block@nongnu.org,
 armbru@redhat.com, mreitz@redhat.com, jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 2020-01-14 at 13:17 -0800, no-reply@patchew.org wrote:
> Patchew URL: https://patchew.org/QEMU/20200114193350.10830-1-mlevitsk@redhat.com/
> 
> 
> 
> Hi,
> 
> This series seems to have some coding style problems. See output below for
> more information:
> 
> Subject: [PATCH 00/13] LUKS: encryption slot management using amend interface
> Type: series
> Message-id: 20200114193350.10830-1-mlevitsk@redhat.com
> 
> === TEST SCRIPT BEGIN ===
> #!/bin/bash
> git rev-parse base > /dev/null || exit 0
> git config --local diff.renamelimit 0
> git config --local diff.renames True
> git config --local diff.algorithm histogram
> ./scripts/checkpatch.pl --mailback base..
> === TEST SCRIPT END ===
> 
> Switched to a new branch 'test'
> c97e00f iotests: add tests for blockdev-amend
> 005f7d8 block/qcow2: implement blockdev-amend
> fcfaaaa block/crypto: implement blockdev-amend
> 97610b5 block: add generic infrastructure for x-blockdev-amend qmp command
> b93e775 qemu-iotests: qemu-img tests for luks key management
> 9730684 iotests: filter few more luks specific create options
> f98c145 qcow2: extend qemu-img amend interface with crypto options
> dd5bc1c block/crypto: implement the encryption key management
> ad24636 block/crypto: rename two functions
> 88f372b block: amend: separate amend and create options for qemu-img
> e9720f3 block: amend: add 'force' option
> d96c666 qcrypto-luks: implement encryption key management
> c41fba3 qcrypto: add generic infrastructure for crypto options amendment
> 
> === OUTPUT BEGIN ===
> 1/13 Checking commit c41fba3b83a1 (qcrypto: add generic infrastructure for crypto options amendment)
> 2/13 Checking commit d96c6663e39d (qcrypto-luks: implement encryption key management)
> 3/13 Checking commit e9720f380038 (block: amend: add 'force' option)
> 4/13 Checking commit 88f372b238fc (block: amend: separate amend and create options for qemu-img)
> ERROR: Macros with multiple statements should be enclosed in a do - while loop
> #30: FILE: block/qcow2.c:5448:
> +#define QCOW_COMMON_OPTIONS                                         \
> +    {                                                               \
> +        .name = BLOCK_OPT_SIZE,                                     \
> +        .type = QEMU_OPT_SIZE,                                      \
> +        .help = "Virtual disk size"                                 \
> +    },                                                              \
> +    {                                                               \
> +        .name = BLOCK_OPT_COMPAT_LEVEL,                             \
> +        .type = QEMU_OPT_STRING,                                    \
> +        .help = "Compatibility level (v2 [0.10] or v3 [1.1])"       \
> +    },                                                              \
> +    {                                                               \
> +        .name = BLOCK_OPT_BACKING_FILE,                             \
> +        .type = QEMU_OPT_STRING,                                    \
> +        .help = "File name of a base image"                         \
> +    },                                                              \
> +    {                                                               \
> +        .name = BLOCK_OPT_BACKING_FMT,                              \
> +        .type = QEMU_OPT_STRING,                                    \
> +        .help = "Image format of the base image"                    \
> +    },                                                              \
> +    {                                                               \
> +        .name = BLOCK_OPT_DATA_FILE,                                \
> +        .type = QEMU_OPT_STRING,                                    \
> +        .help = "File name of an external data file"                \
> +    },                                                              \
> +    {                                                               \
> +        .name = BLOCK_OPT_DATA_FILE_RAW,                            \
> +        .type = QEMU_OPT_BOOL,                                      \
> +        .help = "The external data file must stay valid "           \
> +                "as a raw image"                                    \
> +    },                                                              \
> +    {                                                               \
> +        .name = BLOCK_OPT_ENCRYPT,                                  \
> +        .type = QEMU_OPT_BOOL,                                      \
> +        .help = "Encrypt the image with format 'aes'. (Deprecated " \
> +                "in favor of " BLOCK_OPT_ENCRYPT_FORMAT "=aes)",    \
> +    },                                                              \
> +    {                                                               \
> +        .name = BLOCK_OPT_ENCRYPT_FORMAT,                           \
> +        .type = QEMU_OPT_STRING,                                    \
> +        .help = "Encrypt the image, format choices: 'aes', 'luks'", \
> +    },                                                              \
> +    BLOCK_CRYPTO_OPT_DEF_KEY_SECRET("encrypt.",                     \
> +        "ID of secret providing qcow AES key or LUKS passphrase"),  \
> +    BLOCK_CRYPTO_OPT_DEF_LUKS_CIPHER_ALG("encrypt."),               \
> +    BLOCK_CRYPTO_OPT_DEF_LUKS_CIPHER_MODE("encrypt."),              \
> +    BLOCK_CRYPTO_OPT_DEF_LUKS_IVGEN_ALG("encrypt."),                \
> +    BLOCK_CRYPTO_OPT_DEF_LUKS_IVGEN_HASH_ALG("encrypt."),           \
> +    BLOCK_CRYPTO_OPT_DEF_LUKS_HASH_ALG("encrypt."),                 \
> +    BLOCK_CRYPTO_OPT_DEF_LUKS_ITER_TIME("encrypt."),                \
> +    {                                                               \
> +        .name = BLOCK_OPT_CLUSTER_SIZE,                             \
> +        .type = QEMU_OPT_SIZE,                                      \
> +        .help = "qcow2 cluster size",                               \
> +        .def_value_str = stringify(DEFAULT_CLUSTER_SIZE)            \
> +    },                                                              \
> +    {                                                               \
> +        .name = BLOCK_OPT_PREALLOC,                                 \
> +        .type = QEMU_OPT_STRING,                                    \
> +        .help = "Preallocation mode (allowed values: off, "         \
> +                "metadata, falloc, full)"                           \
> +    },                                                              \
> +    {                                                               \
> +        .name = BLOCK_OPT_LAZY_REFCOUNTS,                           \
> +        .type = QEMU_OPT_BOOL,                                      \
> +        .help = "Postpone refcount updates",                        \
> +        .def_value_str = "off"                                      \
> +    },                                                              \
> +    {                                                               \
> +        .name = BLOCK_OPT_REFCOUNT_BITS,                            \
> +        .type = QEMU_OPT_NUMBER,                                    \
> +        .help = "Width of a reference count entry in bits",         \
> +        .def_value_str = "16"                                       \
> +    }                                                               \
> +
> 
> total: 1 errors, 0 warnings, 231 lines checked
> 
> Patch 4/13 has style problems, please review.  If any of these errors
> are false positives report them to the maintainer, see
> CHECKPATCH in MAINTAINERS.
> 
> 5/13 Checking commit ad24636acdc5 (block/crypto: rename two functions)
> 6/13 Checking commit dd5bc1cc0be5 (block/crypto: implement the encryption key management)
> ERROR: Macros with complex values should be enclosed in parenthesis
> #253: FILE: block/crypto.h:116:
> +#define BLOCK_CRYPTO_OPT_DEF_LUKS_KEYSLOT_UPDATE(prefix)  \
> +    BLOCK_CRYPTO_OPT_DEF_LUKS_KEYSLOT(prefix),            \
> +    BLOCK_CRYPTO_OPT_DEF_LUKS_OLD_SECRET(prefix),         \
> +    BLOCK_CRYPTO_OPT_DEF_LUKS_NEW_SECRET(prefix),         \
> +    BLOCK_CRYPTO_OPT_DEF_LUKS_ITER_TIME(prefix)           \
> +
> 
> total: 1 errors, 0 warnings, 213 lines checked
> 
> Patch 6/13 has style problems, please review.  If any of these errors
> are false positives report them to the maintainer, see
> CHECKPATCH in MAINTAINERS.
> 
> 7/13 Checking commit f98c145c0ebc (qcow2: extend qemu-img amend interface with crypto options)
> ERROR: "foo* bar" should be "foo *bar"
> #44: FILE: block/qcow2.c:4648:
> +    QDict* crypto_opts_dict;
> 
> total: 1 errors, 0 warnings, 165 lines checked
> 
> Patch 7/13 has style problems, please review.  If any of these errors
> are false positives report them to the maintainer, see
> CHECKPATCH in MAINTAINERS.
> 
> 8/13 Checking commit 97306845f3fb (iotests: filter few more luks specific create options)
> 9/13 Checking commit b93e77524180 (qemu-iotests: qemu-img tests for luks key management)
> WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?
> #14: 
> new file mode 100755
> 
> total: 0 errors, 1 warnings, 432 lines checked
> 
> Patch 9/13 has style problems, please review.  If any of these errors
> are false positives report them to the maintainer, see
> CHECKPATCH in MAINTAINERS.
> 10/13 Checking commit 97610b546fea (block: add generic infrastructure for x-blockdev-amend qmp command)
> WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?
> #30: 
> new file mode 100644
> 
> total: 0 errors, 1 warnings, 215 lines checked
> 
> Patch 10/13 has style problems, please review.  If any of these errors
> are false positives report them to the maintainer, see
> CHECKPATCH in MAINTAINERS.
> 11/13 Checking commit fcfaaaa88585 (block/crypto: implement blockdev-amend)
> 12/13 Checking commit 005f7d83f052 (block/qcow2: implement blockdev-amend)
> 13/13 Checking commit c97e00f6078b (iotests: add tests for blockdev-amend)
> WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?
> #14: 
> new file mode 100644
> 
> total: 0 errors, 1 warnings, 598 lines checked
> 
> Patch 13/13 has style problems, please review.  If any of these errors
> are false positives report them to the maintainer, see
> CHECKPATCH in MAINTAINERS.
> === OUTPUT END ===
> 
> Test command exited with code: 1
> 
> 
> The full log is available at
> http://patchew.org/logs/20200114193350.10830-1-mlevitsk@redhat.com/testing.checkpatch/?type=message.

This time I did throughout manual check of all patches, since checkpatch.pl doesn't catch most
of coding style mistakes I automatically do, but for commit f98c145c0ebc, I somehow missed this.

The warnings about macro style are known to me, I tried to do this similar to rest of the luks code.

Best regards,
	Maxim Levitsky


> ---
> Email generated automatically by Patchew [https://patchew.org/].
> Please send your feedback to patchew-devel@redhat.com



