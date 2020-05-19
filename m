Return-Path: <SRS0=GK8b=7B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5461CC433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 23:25:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 10D1120825
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 23:25:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OiAFX4mp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10D1120825
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40584 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbBc9-0000vo-76
	for qemu-devel@archiver.kernel.org; Tue, 19 May 2020 19:25:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51490)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1jbBbZ-0000Ul-Hq
 for qemu-devel@nongnu.org; Tue, 19 May 2020 19:25:01 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:30574
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1jbBbX-0006II-NB
 for qemu-devel@nongnu.org; Tue, 19 May 2020 19:25:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589930698;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wfDRhHzgBUvaF76DV2xYmRRYn82kMkwql4QEL1scC5w=;
 b=OiAFX4mp47Cg9lssh31BpdElxeW+TFDM3Bh8vuDIcsqsXwesP5ZT4JD93mAwceWhjMBJ1h
 Ze2GWT4N+1IFrgbzvQX4nUD7lkO6mlghfifiWvFccmWmQ5cGghUV+p100r98n+PUwUv0rn
 qE41r699BdxigZfBFMW+pu/3nfH46so=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-10-wLVnkbsRPiePujDJrcFCwQ-1; Tue, 19 May 2020 19:24:54 -0400
X-MC-Unique: wLVnkbsRPiePujDJrcFCwQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 257B21800D42
 for <qemu-devel@nongnu.org>; Tue, 19 May 2020 23:24:53 +0000 (UTC)
Received: from lacos-laptop-7.usersys.redhat.com (ovpn-114-149.ams2.redhat.com
 [10.36.114.149])
 by smtp.corp.redhat.com (Postfix) with ESMTP id BF12360610;
 Tue, 19 May 2020 23:24:48 +0000 (UTC)
Subject: Re: [PATCH v6 4/5] crypto: Add tls-cipher-suites object
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20200519182024.14638-1-philmd@redhat.com>
 <20200519182024.14638-5-philmd@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <5fd0a248-c18f-69e3-d6fe-c1c98432f0c0@redhat.com>
Date: Wed, 20 May 2020 01:24:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20200519182024.14638-5-philmd@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=lersek@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/18 23:56:10
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 "=?UTF-8?Q?Daniel_P._Berrang=c3=a9?=" <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 05/19/20 20:20, Philippe Mathieu-Daudé wrote:
> Example of use to dump:
>
>   $ qemu-system-x86_64 -S \
>     -object tls-cipher-suites,id=mysuite,priority=@SYSTEM,verbose=yes
>   Cipher suites for @SYSTEM:
>   - TLS_AES_256_GCM_SHA384                                0x13, 0x02      TLS1.3
>   - TLS_CHACHA20_POLY1305_SHA256                          0x13, 0x03      TLS1.3
>   - TLS_AES_128_GCM_SHA256                                0x13, 0x01      TLS1.3
>   - TLS_AES_128_CCM_SHA256                                0x13, 0x04      TLS1.3
>   - TLS_ECDHE_RSA_AES_256_GCM_SHA384                      0xc0, 0x30      TLS1.2
>   - TLS_ECDHE_RSA_CHACHA20_POLY1305                       0xcc, 0xa8      TLS1.2
>   - TLS_ECDHE_RSA_AES_256_CBC_SHA1                        0xc0, 0x14      TLS1.0
>   - TLS_ECDHE_RSA_AES_128_GCM_SHA256                      0xc0, 0x2f      TLS1.2
>   - TLS_ECDHE_RSA_AES_128_CBC_SHA1                        0xc0, 0x13      TLS1.0
>   - TLS_ECDHE_ECDSA_AES_256_GCM_SHA384                    0xc0, 0x2c      TLS1.2
>   - TLS_ECDHE_ECDSA_CHACHA20_POLY1305                     0xcc, 0xa9      TLS1.2
>   - TLS_ECDHE_ECDSA_AES_256_CCM                           0xc0, 0xad      TLS1.2
>   - TLS_ECDHE_ECDSA_AES_256_CBC_SHA1                      0xc0, 0x0a      TLS1.0
>   - TLS_ECDHE_ECDSA_AES_128_GCM_SHA256                    0xc0, 0x2b      TLS1.2
>   - TLS_ECDHE_ECDSA_AES_128_CCM                           0xc0, 0xac      TLS1.2
>   - TLS_ECDHE_ECDSA_AES_128_CBC_SHA1                      0xc0, 0x09      TLS1.0
>   - TLS_RSA_AES_256_GCM_SHA384                            0x00, 0x9d      TLS1.2
>   - TLS_RSA_AES_256_CCM                                   0xc0, 0x9d      TLS1.2
>   - TLS_RSA_AES_256_CBC_SHA1                              0x00, 0x35      TLS1.0
>   - TLS_RSA_AES_128_GCM_SHA256                            0x00, 0x9c      TLS1.2
>   - TLS_RSA_AES_128_CCM                                   0xc0, 0x9c      TLS1.2
>   - TLS_RSA_AES_128_CBC_SHA1                              0x00, 0x2f      TLS1.0
>   - TLS_DHE_RSA_AES_256_GCM_SHA384                        0x00, 0x9f      TLS1.2
>   - TLS_DHE_RSA_CHACHA20_POLY1305                         0xcc, 0xaa      TLS1.2
>   - TLS_DHE_RSA_AES_256_CCM                               0xc0, 0x9f      TLS1.2
>   - TLS_DHE_RSA_AES_256_CBC_SHA1                          0x00, 0x39      TLS1.0
>   - TLS_DHE_RSA_AES_128_GCM_SHA256                        0x00, 0x9e      TLS1.2
>   - TLS_DHE_RSA_AES_128_CCM                               0xc0, 0x9e      TLS1.2
>   - TLS_DHE_RSA_AES_128_CBC_SHA1                          0x00, 0x33      TLS1.0
>   total: 29 ciphers
>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> ---
>  include/crypto/tls-cipher-suites.h |  39 +++++++++
>  crypto/tls-cipher-suites.c         | 133 +++++++++++++++++++++++++++++
>  crypto/Makefile.objs               |   1 +
>  3 files changed, 173 insertions(+)
>  create mode 100644 include/crypto/tls-cipher-suites.h
>  create mode 100644 crypto/tls-cipher-suites.c
>
> diff --git a/include/crypto/tls-cipher-suites.h b/include/crypto/tls-cipher-suites.h
> new file mode 100644
> index 0000000000..31e92916e1
> --- /dev/null
> +++ b/include/crypto/tls-cipher-suites.h
> @@ -0,0 +1,39 @@
> +/*
> + * QEMU TLS Cipher Suites
> + *
> + * Copyright (c) 2019 Red Hat, Inc.
> + *
> + * Author: Philippe Mathieu-Daudé <philmd@redhat.com>
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#ifndef QCRYPTO_TLSCIPHERSUITES_H
> +#define QCRYPTO_TLSCIPHERSUITES_H
> +
> +#include "qom/object.h"
> +#include "crypto/tlscreds.h"
> +
> +#define TYPE_QCRYPTO_TLS_CIPHER_SUITES "tls-cipher-suites"
> +#define QCRYPTO_TLS_CIPHER_SUITES(obj) \
> +    OBJECT_CHECK(QCryptoTLSCipherSuites, (obj), TYPE_QCRYPTO_TLS_CIPHER_SUITES)
> +
> +/*
> + * IANA registered TLS ciphers:
> + * https://www.iana.org/assignments/tls-parameters/tls-parameters.xhtml#tls-parameters-4
> + */
> +typedef struct {
> +    uint8_t data[2];
> +} IANA_TLS_CIPHER;

(1) I propose marking this as QEMU_PACKED, even if only for
documentation purposes.

> +
> +typedef struct QCryptoTLSCipherSuites {
> +    /* <private> */
> +    QCryptoTLSCreds parent_obj;
> +
> +    /* <public> */
> +    bool verbose;
> +    IANA_TLS_CIPHER *cipher_list;
> +    unsigned cipher_count;
> +} QCryptoTLSCipherSuites;
> +
> +#endif /* QCRYPTO_TLSCIPHERSUITES_H */
> diff --git a/crypto/tls-cipher-suites.c b/crypto/tls-cipher-suites.c
> new file mode 100644
> index 0000000000..c6c51359bd
> --- /dev/null
> +++ b/crypto/tls-cipher-suites.c
> @@ -0,0 +1,133 @@
> +/*
> + * QEMU TLS Cipher Suites
> + *
> + * Copyright (c) 2019 Red Hat, Inc.
> + *
> + * Author: Philippe Mathieu-Daudé <philmd@redhat.com>
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qapi/error.h"
> +#include "qom/object_interfaces.h"
> +#include "qemu/error-report.h"
> +#include "crypto/tlscreds.h"
> +#include "crypto/tls-cipher-suites.h"
> +
> +static void parse_cipher_suites(QCryptoTLSCipherSuites *s,
> +                                const char *priority_name, Error **errp)
> +{
> +#ifdef CONFIG_GNUTLS
> +    int ret;
> +    unsigned int idx;
> +    const char *name;
> +    const char *err;
> +    gnutls_protocol_t version;
> +    gnutls_priority_t pcache;
> +
> +    assert(priority_name);
> +    ret = gnutls_priority_init(&pcache, priority_name, &err);
> +    if (ret < 0) {
> +        error_setg(errp, "Syntax error using priority '%s': %s",
> +                   priority_name, gnutls_strerror(ret));
> +        return;
> +    }
> +
> +    if (s->verbose) {
> +        fprintf(stderr, "Cipher suites for %s:\n", priority_name);
> +    }
> +    for (size_t i = 0;; i++) {
> +        ret = gnutls_priority_get_cipher_suite_index(pcache, i, &idx);
> +        if (ret == GNUTLS_E_REQUESTED_DATA_NOT_AVAILABLE) {
> +            break;
> +        }
> +        if (ret == GNUTLS_E_UNKNOWN_CIPHER_SUITE) {
> +            continue;
> +        }
> +        s->cipher_list = g_renew(IANA_TLS_CIPHER,
> +                                 s->cipher_list, s->cipher_count + 1);
> +
> +        name = gnutls_cipher_suite_info(idx,
> +                                        s->cipher_list[s->cipher_count].data,
> +                                        NULL, NULL, NULL, &version);
> +        if (name != NULL) {
> +            if (s->verbose) {
> +                fprintf(stderr, "- %-50s\t0x%02x, 0x%02x\t%s\n", name,
> +                        s->cipher_list[s->cipher_count].data[0],
> +                        s->cipher_list[s->cipher_count].data[1],
> +                        gnutls_protocol_get_name(version));
> +            }
> +            s->cipher_count++;
> +       }
> +    }

(2) I propose turning this into two loops (in sequence), so that we
don't have to call g_renew() in any loop body. The first loop would just
filter & count, then we'd allocate once, and the second loop would
filter and populate.

Alternatively, I sometimes use the following pattern:

    unsigned mode;

    for (mode = 0; mode < 2; mode++) {
        size_t i;

        for (i = 0;; i++) {
            int ret;
            unsigned idx;
            const char *name;
            IANA_TLS_CIPHER cipher;
            gnutls_protocol_t version;

            ret = gnutls_priority_get_cipher_suite_index(pcache, i, &idx);
            if (ret == GNUTLS_E_REQUESTED_DATA_NOT_AVAILABLE) {
                break;
            }
            if (ret == GNUTLS_E_UNKNOWN_CIPHER_SUITE) {
               continue;
            }

            name = gnutls_cipher_suite_info(idx, &cipher, NULL, NULL, NULL,
                                            &version);
            if (name == NULL) {
              continue;
            }

            if (mode == 1) {
                if (s->verbose) {
                    /* ... log "name" and "cipher" ... */
                }
                s->cipher_list[s->cipher_count] = cipher;
            }
            s->cipher_count++;
        }

        if (mode == 0) {
            if (s->cipher_count == 0) {
                break;
            }
            s->cipher_list = g_new(IANA_TLS_CIPHER, s->cipher_count);
            s->cipher_count = 0;
        }
    }

Feel free to ignore either point I've brought up.

No other comments from me for this patch.

Thanks,
Laszlo


> +    if (s->verbose) {
> +        fprintf(stderr, "total: %u ciphers\n", s->cipher_count);
> +    }
> +    gnutls_priority_deinit(pcache);
> +#else
> +    error_setg(errp, "GNU TLS not available");
> +#endif /* CONFIG_GNUTLS */
> +}
> +
> +static void qcrypto_tls_cipher_suites_complete(UserCreatable *uc, Error **errp)
> +{
> +    QCryptoTLSCreds *s = QCRYPTO_TLS_CREDS(uc);
> +
> +    if (!s->priority) {
> +        error_setg(errp, "'priority' property is not set");
> +        return;
> +    }
> +    parse_cipher_suites(QCRYPTO_TLS_CIPHER_SUITES(s), s->priority, errp);
> +}
> +
> +static void qcrypto_tls_cipher_suites_set_verbose(Object *obj, bool value,
> +                                                 Error **errp G_GNUC_UNUSED)
> +{
> +    QCRYPTO_TLS_CIPHER_SUITES(obj)->verbose = value;
> +}
> +
> +
> +static bool qcrypto_tls_cipher_suites_get_verbose(Object *obj,
> +                                                 Error **errp G_GNUC_UNUSED)
> +{
> +    return QCRYPTO_TLS_CIPHER_SUITES(obj)->verbose;
> +}
> +
> +static void qcrypto_tls_cipher_suites_finalize(Object *obj)
> +{
> +    QCryptoTLSCipherSuites *s = QCRYPTO_TLS_CIPHER_SUITES(obj);
> +
> +    g_free(s->cipher_list);
> +}
> +
> +static void qcrypto_tls_cipher_suites_class_init(ObjectClass *oc, void *data)
> +{
> +    UserCreatableClass *ucc = USER_CREATABLE_CLASS(oc);
> +
> +    ucc->complete = qcrypto_tls_cipher_suites_complete;
> +
> +    object_class_property_add_bool(oc, "verbose",
> +                                   qcrypto_tls_cipher_suites_get_verbose,
> +                                   qcrypto_tls_cipher_suites_set_verbose);
> +}
> +
> +static const TypeInfo qcrypto_tls_cipher_suites_info = {
> +    .parent = TYPE_QCRYPTO_TLS_CREDS,
> +    .name = TYPE_QCRYPTO_TLS_CIPHER_SUITES,
> +    .instance_size = sizeof(QCryptoTLSCipherSuites),
> +    .instance_finalize = qcrypto_tls_cipher_suites_finalize,
> +    .class_size = sizeof(QCryptoTLSCredsClass),
> +    .class_init = qcrypto_tls_cipher_suites_class_init,
> +    .interfaces = (InterfaceInfo[]) {
> +        { TYPE_USER_CREATABLE },
> +        { }
> +    }
> +};
> +
> +static void qcrypto_tls_cipher_suites_register_types(void)
> +{
> +    type_register_static(&qcrypto_tls_cipher_suites_info);
> +}
> +
> +type_init(qcrypto_tls_cipher_suites_register_types);
> diff --git a/crypto/Makefile.objs b/crypto/Makefile.objs
> index c2a371b0b4..ce706d322a 100644
> --- a/crypto/Makefile.objs
> +++ b/crypto/Makefile.objs
> @@ -13,6 +13,7 @@ crypto-obj-y += cipher.o
>  crypto-obj-$(CONFIG_AF_ALG) += afalg.o
>  crypto-obj-$(CONFIG_AF_ALG) += cipher-afalg.o
>  crypto-obj-$(CONFIG_AF_ALG) += hash-afalg.o
> +crypto-obj-y += tls-cipher-suites.o
>  crypto-obj-y += tlscreds.o
>  crypto-obj-y += tlscredsanon.o
>  crypto-obj-y += tlscredspsk.o
>


