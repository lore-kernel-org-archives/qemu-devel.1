Return-Path: <SRS0=UjLb=7L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1293C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2020 11:10:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B037E20663
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2020 11:10:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EGECFgMB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B037E20663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46922 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jecuM-0001gu-Sa
	for qemu-devel@archiver.kernel.org; Fri, 29 May 2020 07:10:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38618)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1jectM-0000rW-U7
 for qemu-devel@nongnu.org; Fri, 29 May 2020 07:09:36 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:55326
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1jectK-0005gN-WD
 for qemu-devel@nongnu.org; Fri, 29 May 2020 07:09:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590750573;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=58alfCdQNH5jHg0wcVj+gTBgsHDevylIgkHrdjD1z0U=;
 b=EGECFgMBlM82DgqX9updXKLkh5L9dADbBqeIFP67tGBhhDZqFSRyet9dPsrpEXOWb2Wc98
 Fc4TbOYN1DNx1NSqwLIDMWZLEpaKoPLN/udTXyw6QsDqNb72156V9K5zA9QN1mV/xarnO0
 YmlNCfhzZkgVEPkyJbpqdf8CX78Fnx4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-228-YAN8UQgLOQKJNtBP_e3kQQ-1; Fri, 29 May 2020 07:09:28 -0400
X-MC-Unique: YAN8UQgLOQKJNtBP_e3kQQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id ECC3784B8A4
 for <qemu-devel@nongnu.org>; Fri, 29 May 2020 11:09:27 +0000 (UTC)
Received: from lacos-laptop-7.usersys.redhat.com (ovpn-112-152.ams2.redhat.com
 [10.36.112.152])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 649717C081;
 Fri, 29 May 2020 11:09:23 +0000 (UTC)
Subject: Re: [PATCH v7 4/5] crypto: Add tls-cipher-suites object
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org, =?UTF-8?Q?Daniel_P._Berrang=c3=a9?=
 <berrange@redhat.com>
References: <20200528173141.17495-1-philmd@redhat.com>
 <20200528173141.17495-5-philmd@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <81c61004-cccc-2ece-91a7-de96012a8ebf@redhat.com>
Date: Fri, 29 May 2020 13:09:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20200528173141.17495-5-philmd@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=lersek@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/28 23:43:13
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 05/28/20 19:31, Philippe Mathieu-Daudé wrote:
> Example of use to dump:
>
>   $ qemu-system-x86_64 -S \
>     -object tls-cipher-suites,id=mysuite,priority=@SYSTEM \
>     -trace qcrypto\*
>   1590664444.197123:qcrypto_tls_cipher_suite_priority priority: @SYSTEM
>   1590664444.197219:qcrypto_tls_cipher_suite_info data:[0x13, 0x02] version:TLS1.3 name:TLS_AES_256_GCM_SHA384
>   1590664444.197228:qcrypto_tls_cipher_suite_info data:[0x13, 0x03] version:TLS1.3 name:TLS_CHACHA20_POLY1305_SHA256
>   1590664444.197233:qcrypto_tls_cipher_suite_info data:[0x13, 0x01] version:TLS1.3 name:TLS_AES_128_GCM_SHA256
>   1590664444.197236:qcrypto_tls_cipher_suite_info data:[0x13, 0x04] version:TLS1.3 name:TLS_AES_128_CCM_SHA256
>   1590664444.197240:qcrypto_tls_cipher_suite_info data:[0xc0, 0x30] version:TLS1.2 name:TLS_ECDHE_RSA_AES_256_GCM_SHA384
>   1590664444.197245:qcrypto_tls_cipher_suite_info data:[0xcc, 0xa8] version:TLS1.2 name:TLS_ECDHE_RSA_CHACHA20_POLY1305
>   1590664444.197250:qcrypto_tls_cipher_suite_info data:[0xc0, 0x14] version:TLS1.0 name:TLS_ECDHE_RSA_AES_256_CBC_SHA1
>   1590664444.197254:qcrypto_tls_cipher_suite_info data:[0xc0, 0x2f] version:TLS1.2 name:TLS_ECDHE_RSA_AES_128_GCM_SHA256
>   1590664444.197258:qcrypto_tls_cipher_suite_info data:[0xc0, 0x13] version:TLS1.0 name:TLS_ECDHE_RSA_AES_128_CBC_SHA1
>   1590664444.197261:qcrypto_tls_cipher_suite_info data:[0xc0, 0x2c] version:TLS1.2 name:TLS_ECDHE_ECDSA_AES_256_GCM_SHA384
>   1590664444.197266:qcrypto_tls_cipher_suite_info data:[0xcc, 0xa9] version:TLS1.2 name:TLS_ECDHE_ECDSA_CHACHA20_POLY1305
>   1590664444.197270:qcrypto_tls_cipher_suite_info data:[0xc0, 0xad] version:TLS1.2 name:TLS_ECDHE_ECDSA_AES_256_CCM
>   1590664444.197274:qcrypto_tls_cipher_suite_info data:[0xc0, 0x0a] version:TLS1.0 name:TLS_ECDHE_ECDSA_AES_256_CBC_SHA1
>   1590664444.197278:qcrypto_tls_cipher_suite_info data:[0xc0, 0x2b] version:TLS1.2 name:TLS_ECDHE_ECDSA_AES_128_GCM_SHA256
>   1590664444.197283:qcrypto_tls_cipher_suite_info data:[0xc0, 0xac] version:TLS1.2 name:TLS_ECDHE_ECDSA_AES_128_CCM
>   1590664444.197287:qcrypto_tls_cipher_suite_info data:[0xc0, 0x09] version:TLS1.0 name:TLS_ECDHE_ECDSA_AES_128_CBC_SHA1
>   1590664444.197291:qcrypto_tls_cipher_suite_info data:[0x00, 0x9d] version:TLS1.2 name:TLS_RSA_AES_256_GCM_SHA384
>   1590664444.197296:qcrypto_tls_cipher_suite_info data:[0xc0, 0x9d] version:TLS1.2 name:TLS_RSA_AES_256_CCM
>   1590664444.197300:qcrypto_tls_cipher_suite_info data:[0x00, 0x35] version:TLS1.0 name:TLS_RSA_AES_256_CBC_SHA1
>   1590664444.197304:qcrypto_tls_cipher_suite_info data:[0x00, 0x9c] version:TLS1.2 name:TLS_RSA_AES_128_GCM_SHA256
>   1590664444.197308:qcrypto_tls_cipher_suite_info data:[0xc0, 0x9c] version:TLS1.2 name:TLS_RSA_AES_128_CCM
>   1590664444.197312:qcrypto_tls_cipher_suite_info data:[0x00, 0x2f] version:TLS1.0 name:TLS_RSA_AES_128_CBC_SHA1
>   1590664444.197316:qcrypto_tls_cipher_suite_info data:[0x00, 0x9f] version:TLS1.2 name:TLS_DHE_RSA_AES_256_GCM_SHA384
>   1590664444.197320:qcrypto_tls_cipher_suite_info data:[0xcc, 0xaa] version:TLS1.2 name:TLS_DHE_RSA_CHACHA20_POLY1305
>   1590664444.197325:qcrypto_tls_cipher_suite_info data:[0xc0, 0x9f] version:TLS1.2 name:TLS_DHE_RSA_AES_256_CCM
>   1590664444.197329:qcrypto_tls_cipher_suite_info data:[0x00, 0x39] version:TLS1.0 name:TLS_DHE_RSA_AES_256_CBC_SHA1
>   1590664444.197333:qcrypto_tls_cipher_suite_info data:[0x00, 0x9e] version:TLS1.2 name:TLS_DHE_RSA_AES_128_GCM_SHA256
>   1590664444.197337:qcrypto_tls_cipher_suite_info data:[0xc0, 0x9e] version:TLS1.2 name:TLS_DHE_RSA_AES_128_CCM
>   1590664444.197341:qcrypto_tls_cipher_suite_info data:[0x00, 0x33] version:TLS1.0 name:TLS_DHE_RSA_AES_128_CBC_SHA1
>   1590664444.197345:qcrypto_tls_cipher_suite_count count: 29
>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> ---
> v7:
> - Use Laszlo's loop with enum mode (lersek)

Nice improvement with the enum, thanks!

> - Convert debug printf to trace events (danpb)
> - Use buildsys CONFIG_GNUTLS instead of C ifdef'ry (danpb)
> ---
>  include/crypto/tls-cipher-suites.h |  38 +++++++++
>  crypto/tls-cipher-suites.c         | 127 +++++++++++++++++++++++++++++
>  crypto/Makefile.objs               |   1 +
>  crypto/trace-events                |   5 ++
>  4 files changed, 171 insertions(+)
>  create mode 100644 include/crypto/tls-cipher-suites.h
>  create mode 100644 crypto/tls-cipher-suites.c
>
> diff --git a/include/crypto/tls-cipher-suites.h b/include/crypto/tls-cipher-suites.h
> new file mode 100644
> index 0000000000..20a7c74edf
> --- /dev/null
> +++ b/include/crypto/tls-cipher-suites.h
> @@ -0,0 +1,38 @@
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
> +} QEMU_PACKED IANA_TLS_CIPHER;
> +
> +typedef struct QCryptoTLSCipherSuites {
> +    /* <private> */
> +    QCryptoTLSCreds parent_obj;
> +
> +    /* <public> */
> +    IANA_TLS_CIPHER *cipher_list;
> +    unsigned cipher_count;
> +} QCryptoTLSCipherSuites;
> +
> +#endif /* QCRYPTO_TLSCIPHERSUITES_H */
> diff --git a/crypto/tls-cipher-suites.c b/crypto/tls-cipher-suites.c
> new file mode 100644
> index 0000000000..f02a041f9a
> --- /dev/null
> +++ b/crypto/tls-cipher-suites.c
> @@ -0,0 +1,127 @@
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
> +#include "trace.h"
> +
> +static void parse_cipher_suites(QCryptoTLSCipherSuites *s,
> +                                const char *priority_name, Error **errp)
> +{
> +    int ret;
> +    const char *err;
> +    gnutls_priority_t pcache;
> +    enum { M_ENUMERATE, M_GENERATE, M_DONE } mode;
> +
> +    assert(priority_name);
> +    trace_qcrypto_tls_cipher_suite_priority(priority_name);
> +    ret = gnutls_priority_init(&pcache, priority_name, &err);
> +    if (ret < 0) {
> +        error_setg(errp, "Syntax error using priority '%s': %s",
> +                   priority_name, gnutls_strerror(ret));
> +        return;
> +    }
> +
> +    for (mode = M_ENUMERATE; mode < M_DONE; mode++) {
> +        size_t i;
> +
> +        for (i = 0;; i++) {
> +            int ret;
> +            unsigned idx;
> +            const char *name;
> +            IANA_TLS_CIPHER cipher;
> +            gnutls_protocol_t protocol;
> +
> +            ret = gnutls_priority_get_cipher_suite_index(pcache, i, &idx);
> +            if (ret == GNUTLS_E_REQUESTED_DATA_NOT_AVAILABLE) {
> +                break;
> +            }
> +            if (ret == GNUTLS_E_UNKNOWN_CIPHER_SUITE) {
> +                continue;
> +            }
> +
> +            name = gnutls_cipher_suite_info(idx, (unsigned char *)&cipher,
> +                                            NULL, NULL, NULL, &protocol);
> +            if (name == NULL) {
> +                continue;
> +            }
> +
> +            if (mode == M_GENERATE) {
> +                const char *version;
> +
> +                version = gnutls_protocol_get_name(protocol);
> +                trace_qcrypto_tls_cipher_suite_info(cipher.data[0],
> +                                                    cipher.data[1],
> +                                                    version, name);
> +                s->cipher_list[s->cipher_count] = cipher;
> +            }
> +            s->cipher_count++;
> +        }
> +
> +        if (mode == M_ENUMERATE) {
> +            if (s->cipher_count == 0) {
> +                break;
> +            }
> +            s->cipher_list = g_new(IANA_TLS_CIPHER, s->cipher_count);
> +            s->cipher_count = 0;
> +        }
> +    }
> +    trace_qcrypto_tls_cipher_suite_count(s->cipher_count);
> +    gnutls_priority_deinit(pcache);
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
> index c2a371b0b4..1c1b5e21ff 100644
> --- a/crypto/Makefile.objs
> +++ b/crypto/Makefile.objs
> @@ -13,6 +13,7 @@ crypto-obj-y += cipher.o
>  crypto-obj-$(CONFIG_AF_ALG) += afalg.o
>  crypto-obj-$(CONFIG_AF_ALG) += cipher-afalg.o
>  crypto-obj-$(CONFIG_AF_ALG) += hash-afalg.o
> +crypto-obj-$(CONFIG_GNUTLS) += tls-cipher-suites.o
>  crypto-obj-y += tlscreds.o
>  crypto-obj-y += tlscredsanon.o
>  crypto-obj-y += tlscredspsk.o
> diff --git a/crypto/trace-events b/crypto/trace-events
> index 9e594d30e8..c07a752b50 100644
> --- a/crypto/trace-events
> +++ b/crypto/trace-events
> @@ -21,3 +21,8 @@ qcrypto_tls_creds_x509_load_cert_list(void *creds, const char *file) "TLS creds
>  # tlssession.c
>  qcrypto_tls_session_new(void *session, void *creds, const char *hostname, const char *authzid, int endpoint) "TLS session new session=%p creds=%p hostname=%s authzid=%s endpoint=%d"
>  qcrypto_tls_session_check_creds(void *session, const char *status) "TLS session check creds session=%p status=%s"
> +
> +# tls-cipher-suites.c
> +qcrypto_tls_cipher_suite_priority(const char *name) "priority: %s"
> +qcrypto_tls_cipher_suite_info(uint8_t data0, uint8_t data1, const char *version, const char *name) "data:[0x%02x, 0x%02x] version:%s name:%s"
> +qcrypto_tls_cipher_suite_count(unsigned count) "count: %u"
>

(1) It feels like we should insert one space character right after
"data:", and another space character right after "version:". I think
that makes things easier to read and possibly to parse. It also seems a
bit more idiomatic with the rest of the trace messages.

Anyway, I don't insist, up to you.

(2) We need an actual commit message for this patch. How about the
following -- I have liberally stolen and edited comments that Daniel
made earlier in the Red Hat Bugzilla:

---v--- ---v--- ---v--- ---v---
On the host OS, various aspects of TLS operation are configurable. In
particular it is possible for the sysadmin to control the TLS
cipher/protocol algorithms that applications are permitted to use.

* Any given crypto library has a built-in default priority list defined by
  the distro maintainer of the libary package (or by upstream).

* The "crypto-policies" RPM (or equivalent host OS package) provides a
  config file such as "/etc/crypto-policies/config", where the sysadmin
  can set a high level (library-independent) policy.

  The "update-crypto-policies --set" command (or equivalent) is used to
  translate the global policy to individual library representations,
  producing files such as "/etc/crypto-policies/back-ends/*.config". The
  generated files, if present, are loaded by the various crypto libraries
  to override their own built-in defaults.

  For example, the GNUTLS library may read
  "/etc/crypto-policies/back-ends/gnutls.config".

* A management application (or the QEMU user) may overide the system-wide
  crypto-policies config via their own config, if they need to diverge
  from the former.

Thus the priority order is "QEMU user config" > "crypto-policies system
config" > "library built-in config".

Introduce the "tls-cipher-suites" object for exposing the ordered list of
permitted TLS cipher suites from the host side to the firmware, via
fw_cfg. The list is represented as an array of IANA_TLS_CIPHER objects.
The firmware uses the IANA_TLS_CIPHER array for configuring guest-side
TLS, for example in UEFI HTTPS Boot.

The priority at which the host-side policy is retrieved is given by the
"priority" property of the new object type. For example,
"priority=@SYSTEM" may be used to refer to
"/etc/crypto-policies/back-ends/gnutls.config" (given that QEMU uses
GNUTLS).
---^--- ---^--- ---^--- ---^---

(3) I think I have now at least formed an idea about where we should
document -fw_cfg / "gen_id" in the *manual*.

The various -object types are already documented extensively; namely in
section "Generic object creation". Thus, I think we should document
"tls-cipher-suites" there -- near the already existent "-object tls-*"
ones.

I suggest including a manual update to that effect. I think we can mostly
copy the suggested commit message into the manual as well.

And then, we can include the new "-fw_cfg" command line option (with
"gen_id") *right there*. Consequently, we won't need to modify the
existent "-fw_cfg" documentation bits (about "file" and "string") under
section "Debug/Expert options".

Dan: please comment!

Thanks,
Laszlo


