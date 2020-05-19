Return-Path: <SRS0=GK8b=7B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93448C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 14:53:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 54CBB207D8
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 14:53:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c7RaFTWA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54CBB207D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37248 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jb3cP-0005pO-If
	for qemu-devel@archiver.kernel.org; Tue, 19 May 2020 10:53:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44014)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jb3Yp-0001Aj-LQ
 for qemu-devel@nongnu.org; Tue, 19 May 2020 10:49:39 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:37826
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jb3Yo-00026f-2c
 for qemu-devel@nongnu.org; Tue, 19 May 2020 10:49:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589899776;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TMINj0/vZPDe4Rk3XKJQB3+IoZUi/4p432CuSfDqfso=;
 b=c7RaFTWAfk6ox7ySsD6LmIkb6M8/g53iu6KTm35hcvdJ6VLBzHuN6W+4R85HbPE6D+1IW+
 /xUHA/Bzhpt6N3WUeWyMYMYVQ1S1uXzmRcguvQIJsFILfeQ8y8Lqlo0r0DHorqeC0u/a5U
 ++sTlFho9BrjW4Wk6qpWGxkUwULk+TU=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-164-hIqA7F96O_iXhMZE4a6TyQ-1; Tue, 19 May 2020 10:49:34 -0400
X-MC-Unique: hIqA7F96O_iXhMZE4a6TyQ-1
Received: by mail-wm1-f69.google.com with SMTP id t82so1080129wmf.4
 for <qemu-devel@nongnu.org>; Tue, 19 May 2020 07:49:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=TMINj0/vZPDe4Rk3XKJQB3+IoZUi/4p432CuSfDqfso=;
 b=b4TorzAfL9iNu4jitbrraMQnSyo3Z9/h5/4OIDBjUI0xeQlA+prKrq00j72stVChFu
 rUItnD6gBBBaQ0scGhML+TBOgr31pfA0uqLEqwVjtWmaPR5tHvDxGj2cInS3POQ9S2t0
 OBM2tk+HlgGdZ/z5cNpKulRiADVI4dEfkeSU6fCH81D7bedAinqcy10DroHtd9bQMJ2n
 ePDZfI34HQa2BRw9HyngZuvUcTsdWyjoQzrnryOjPSYfjiKI353D7WbpLwd9sldb+AFI
 gG0safISmqhPcHSeIYnedgZgh9XKH2Lz0Vz+xrHjAQ54H4x9V+U3LvkRm5wLiUWJ9/2G
 rzDw==
X-Gm-Message-State: AOAM533S9KRpwj1FXtLQRf93FbQJ3gpvrCKFk76PTC9vGTHQC2wI9QKD
 gzZ++U5UHIdNy2G2UnTfUQk/e16muODbj5KGw+8InKAnGH1dOKtdlflTQfaB4UA3EYKBqW4yakS
 iRX8fUBDTDcMVR30=
X-Received: by 2002:adf:e582:: with SMTP id l2mr27940062wrm.392.1589899772811; 
 Tue, 19 May 2020 07:49:32 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJywnf9jAZQPCABrIXoTQnEtttw/DRrvUIRgZr1DalOHJppqDHRn5fayf8aWZhTlNbAmN86cJA==
X-Received: by 2002:adf:e582:: with SMTP id l2mr27940027wrm.392.1589899772418; 
 Tue, 19 May 2020 07:49:32 -0700 (PDT)
Received: from [192.168.1.38] (17.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.17])
 by smtp.gmail.com with ESMTPSA id r14sm4741821wmb.2.2020.05.19.07.49.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 19 May 2020 07:49:31 -0700 (PDT)
Subject: Re: [PATCH] virtio-crypto: Convert DPRINTF to trace event
To: teachk <teachk@foxmail.com>, qemu-devel@nongnu.org
References: <20200516140540.51-1-teachk@foxmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <44bccfbe-b082-260a-1be4-fe710c3218b8@redhat.com>
Date: Tue, 19 May 2020 16:49:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200516140540.51-1-teachk@foxmail.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/18 23:19:13
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Hou Weiying <weiying_hou@outlook.com>, arei.gonglei@huawei.com,
 mst@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,

On 5/16/20 4:05 PM, teachk wrote:
> From: Hou Weiying <weiying_hou@outlook.com>
> 
> Signed-off-by: Hou Weiying <weiying_hou@outlook.com>
> ---
>   hw/virtio/trace-events            | 12 ++++++++++++
>   hw/virtio/virtio-crypto.c         | 26 ++++++++++++++------------
>   include/hw/virtio/virtio-crypto.h | 11 -----------
>   3 files changed, 26 insertions(+), 23 deletions(-)
> 
> diff --git a/hw/virtio/trace-events b/hw/virtio/trace-events
> index e83500bee9..f7c20f211a 100644
> --- a/hw/virtio/trace-events
> +++ b/hw/virtio/trace-events
> @@ -73,3 +73,15 @@ virtio_iommu_get_domain(uint32_t domain_id) "Alloc domain=%d"
>   virtio_iommu_put_domain(uint32_t domain_id) "Free domain=%d"
>   virtio_iommu_translate_out(uint64_t virt_addr, uint64_t phys_addr, uint32_t sid) "0x%"PRIx64" -> 0x%"PRIx64 " for sid=%d"
>   virtio_iommu_report_fault(uint8_t reason, uint32_t flags, uint32_t endpoint, uint64_t addr) "FAULT reason=%d flags=%d endpoint=%d address =0x%"PRIx64
> +
> +# virtio-crypto.c
> +virtio_crypto_cipher_session_helper_cipher_alg_and_direction(uint32_t cipher_alg, uint8_t direction) "cipher_alg=%" PRIu32 ", info->direction=%" PRIu32

direction (last format) can be simply "%u" (the correct format is PRIu8, 
but we don't use it).

> +virtio_crypto_cipher_session_helper_keylen(uint32_t keylen) "keylen=%" PRIu32
> +virtio_crypto_create_sym_session_auth_keylen(uint32_t auth_keylen) "auth_keylen=%" PRIu32
> +virtio_crypto_create_sym_session_session_id(int64_t session_id) "create session_id=%" PRIu64 " successfully"

session_id is signed, so you would need PRIi64, but since session_id is 
positive on success, instead use 'uint64_t session_id' in trace event.

Otherwise patch looks good, thanks for removing this DPRINTF!

Regards,

Phil.

> +virtio_crypto_sym_op_helper_src_len(uint32_t src_len) "src_len=%" PRIu32
> +virtio_crypto_sym_op_helper_dst_len(uint32_t dst_len) "dst_len=%" PRIu32
> +virtio_crypto_sym_op_helper_hash_result_len(uint32_t hash_result_len) "hash_result_len=%" PRIu32
> +virtio_crypto_handle_close_session(uint64_t session_id) "close session id %" PRIu64

> +virtio_crypto_sym_op_helper_iv_len(uint32_t iv_len) "iv_len %" PRIu32
> +virtio_crypto_sym_op_helper_aad_len(uint32_t aad_len) "aad_len %" PRIu32
> diff --git a/hw/virtio/virtio-crypto.c b/hw/virtio/virtio-crypto.c
> index bd9165c565..676948a4dd 100644
> --- a/hw/virtio/virtio-crypto.c
> +++ b/hw/virtio/virtio-crypto.c
> @@ -24,6 +24,7 @@
>   #include "hw/virtio/virtio-access.h"
>   #include "standard-headers/linux/virtio_ids.h"
>   #include "sysemu/cryptodev-vhost.h"
> +#include "trace.h"
>   
>   #define VIRTIO_CRYPTO_VM_VERSION 1
>   
> @@ -49,8 +50,9 @@ virtio_crypto_cipher_session_helper(VirtIODevice *vdev,
>       info->cipher_alg = ldl_le_p(&cipher_para->algo);
>       info->key_len = ldl_le_p(&cipher_para->keylen);
>       info->direction = ldl_le_p(&cipher_para->op);
> -    DPRINTF("cipher_alg=%" PRIu32 ", info->direction=%" PRIu32 "\n",
> -             info->cipher_alg, info->direction);
> +    trace_virtio_crypto_cipher_session_helper_cipher_alg_and_direction(
> +            info->cipher_alg, info->direction);
> +
>   
>       if (info->key_len > vcrypto->conf.max_cipher_key_len) {
>           error_report("virtio-crypto length of cipher key is too big: %u",
> @@ -60,7 +62,7 @@ virtio_crypto_cipher_session_helper(VirtIODevice *vdev,
>       /* Get cipher key */
>       if (info->key_len > 0) {
>           size_t s;
> -        DPRINTF("keylen=%" PRIu32 "\n", info->key_len);
> +        trace_virtio_crypto_cipher_session_helper_keylen(info->key_len);
>   
>           info->cipher_key = g_malloc(info->key_len);
>           s = iov_to_buf(*iov, num, 0, info->cipher_key, info->key_len);
> @@ -130,7 +132,8 @@ virtio_crypto_create_sym_session(VirtIOCrypto *vcrypto,
>               }
>               /* get auth key */
>               if (info.auth_key_len > 0) {
> -                DPRINTF("auth_keylen=%" PRIu32 "\n", info.auth_key_len);
> +                trace_virtio_crypto_create_sym_session_auth_keylen(
> +                            info.auth_key_len);
>                   info.auth_key = g_malloc(info.auth_key_len);
>                   s = iov_to_buf(iov, out_num, 0, info.auth_key,
>                                  info.auth_key_len);
> @@ -165,8 +168,7 @@ virtio_crypto_create_sym_session(VirtIOCrypto *vcrypto,
>                                        vcrypto->cryptodev,
>                                        &info, queue_index, &local_err);
>       if (session_id >= 0) {
> -        DPRINTF("create session_id=%" PRIu64 " successfully\n",
> -                session_id);
> +        trace_virtio_crypto_create_sym_session_session_id(session_id);
>   
>           ret = session_id;
>       } else {
> @@ -193,7 +195,7 @@ virtio_crypto_handle_close_session(VirtIOCrypto *vcrypto,
>       Error *local_err = NULL;
>   
>       session_id = ldq_le_p(&close_sess_req->session_id);
> -    DPRINTF("close session, id=%" PRIu64 "\n", session_id);
> +    trace_virtio_crypto_handle_close_session(session_id);
>   
>       ret = cryptodev_backend_sym_close_session(
>                 vcrypto->cryptodev, session_id, queue_id, &local_err);
> @@ -474,7 +476,7 @@ virtio_crypto_sym_op_helper(VirtIODevice *vdev,
>       op_info->len_to_cipher = len_to_cipher;
>       /* Handle the initilization vector */
>       if (op_info->iv_len > 0) {
> -        DPRINTF("iv_len=%" PRIu32 "\n", op_info->iv_len);
> +        trace_virtio_crypto_sym_op_helper_iv_len(op_info->iv_len);
>           op_info->iv = op_info->data + curr_size;
>   
>           s = iov_to_buf(iov, out_num, 0, op_info->iv, op_info->iv_len);
> @@ -488,7 +490,7 @@ virtio_crypto_sym_op_helper(VirtIODevice *vdev,
>   
>       /* Handle additional authentication data if exists */
>       if (op_info->aad_len > 0) {
> -        DPRINTF("aad_len=%" PRIu32 "\n", op_info->aad_len);
> +        trace_virtio_crypto_sym_op_helper_aad_len(op_info->aad_len);
>           op_info->aad_data = op_info->data + curr_size;
>   
>           s = iov_to_buf(iov, out_num, 0, op_info->aad_data, op_info->aad_len);
> @@ -503,7 +505,7 @@ virtio_crypto_sym_op_helper(VirtIODevice *vdev,
>   
>       /* Handle the source data */
>       if (op_info->src_len > 0) {
> -        DPRINTF("src_len=%" PRIu32 "\n", op_info->src_len);
> +        trace_virtio_crypto_sym_op_helper_src_len(op_info->src_len);
>           op_info->src = op_info->data + curr_size;
>   
>           s = iov_to_buf(iov, out_num, 0, op_info->src, op_info->src_len);
> @@ -520,11 +522,11 @@ virtio_crypto_sym_op_helper(VirtIODevice *vdev,
>       op_info->dst = op_info->data + curr_size;
>       curr_size += op_info->dst_len;
>   
> -    DPRINTF("dst_len=%" PRIu32 "\n", op_info->dst_len);
> +    trace_virtio_crypto_sym_op_helper_dst_len(op_info->dst_len);
>   
>       /* Handle the hash digest result */
>       if (hash_result_len > 0) {
> -        DPRINTF("hash_result_len=%" PRIu32 "\n", hash_result_len);
> +        trace_virtio_crypto_sym_op_helper_hash_result_len(hash_result_len);
>           op_info->digest_result = op_info->data + curr_size;
>       }
>   
> diff --git a/include/hw/virtio/virtio-crypto.h b/include/hw/virtio/virtio-crypto.h
> index ffe2391ece..f59f91f11e 100644
> --- a/include/hw/virtio/virtio-crypto.h
> +++ b/include/hw/virtio/virtio-crypto.h
> @@ -19,17 +19,6 @@
>   #include "sysemu/iothread.h"
>   #include "sysemu/cryptodev.h"
>   
> -
> -#define DEBUG_VIRTIO_CRYPTO 0
> -
> -#define DPRINTF(fmt, ...) \
> -do { \
> -    if (DEBUG_VIRTIO_CRYPTO) { \
> -        fprintf(stderr, "virtio_crypto: " fmt, ##__VA_ARGS__); \
> -    } \
> -} while (0)
> -
> -
>   #define TYPE_VIRTIO_CRYPTO "virtio-crypto-device"
>   #define VIRTIO_CRYPTO(obj) \
>           OBJECT_CHECK(VirtIOCrypto, (obj), TYPE_VIRTIO_CRYPTO)
> 


