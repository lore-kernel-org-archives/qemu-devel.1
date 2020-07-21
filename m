Return-Path: <SRS0=zL9l=BA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24844C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2020 14:37:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E33182065D
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2020 14:37:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W8jNtB8K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E33182065D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40168 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jxtOh-0007FP-5P
	for qemu-devel@archiver.kernel.org; Tue, 21 Jul 2020 10:37:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37776)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jxtMi-0004XF-Tc
 for qemu-devel@nongnu.org; Tue, 21 Jul 2020 10:35:32 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:33381
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jxtMh-0005i2-5V
 for qemu-devel@nongnu.org; Tue, 21 Jul 2020 10:35:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595342130;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aG1HeHWfKcQbTaYN7MLij83m2i9JG+PHFOsDQOLO824=;
 b=W8jNtB8KMXgQtjUNFb+CRSBoljCdEUcu4ot/8wIn4CpXqBQVI9B5+DDu2cBDSRu4Mvc80d
 PjNBF4pah+mUAdlJWJqsMyUZ7fob5Xuc3q6eXlpZe8jmprTfWDAbj4im+i8ZyMIwxW8VIj
 aAIvVUEyCQSymtGW0Jb/S1ikIoSY3R8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-120-71EemiotP3qk_CFG3-uWKA-1; Tue, 21 Jul 2020 10:35:28 -0400
X-MC-Unique: 71EemiotP3qk_CFG3-uWKA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 64F7B1006B10
 for <qemu-devel@nongnu.org>; Tue, 21 Jul 2020 14:35:27 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-143.ams2.redhat.com
 [10.36.112.143])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2A41961177;
 Tue, 21 Jul 2020 14:35:24 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id BCFB4111CA27; Tue, 21 Jul 2020 16:35:22 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Subject: Re: [PATCH v2 1/2] hw/nvram/fw_cfg: Simplify
 fw_cfg_add_from_generator() error propagation
References: <20200721131911.27380-1-philmd@redhat.com>
 <20200721131911.27380-2-philmd@redhat.com>
Date: Tue, 21 Jul 2020 16:35:22 +0200
In-Reply-To: <20200721131911.27380-2-philmd@redhat.com> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Tue, 21 Jul 2020 15:19:10
 +0200")
Message-ID: <875zah7x79.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.61; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/21 10:17:05
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Laszlo Ersek <lersek@redhat.com>,
 qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:

> Document FWCfgDataGeneratorClass::get_data() return NULL
> on error, and non-NULL on success. This allow us to simplify
> fw_cfg_add_from_generator(). Since we don't need a local
> variable to propagate the error, we can remove the ERRP_GUARD()
> macro.
>
> Suggested-by: Markus Armbruster <armbru@redhat.com>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>  include/hw/nvram/fw_cfg.h | 4 +++-
>  hw/nvram/fw_cfg.c         | 3 +--
>  2 files changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/include/hw/nvram/fw_cfg.h b/include/hw/nvram/fw_cfg.h
> index 11feae3177..bbcf405649 100644
> --- a/include/hw/nvram/fw_cfg.h
> +++ b/include/hw/nvram/fw_cfg.h
> @@ -32,7 +32,9 @@ typedef struct FWCfgDataGeneratorClass {
>       * @obj: the object implementing this interface
>       * @errp: pointer to a NULL-initialized error object
>       *
> -     * Returns: reference to a byte array containing the data.
> +     * Returns: reference to a byte array containing the data on success=
,
> +     *          or NULL on error.
> +     *
>       * The caller should release the reference when no longer
>       * required.
>       */

Thanks for clarifying the doc comment!

As far as I can tell, the only implementation is
qcrypto_tls_cipher_suites_fw_cfg_gen_data(), which is a trivial wrapper
around qcrypto_tls_cipher_suites_get_data().  I checked it conforms.

> diff --git a/hw/nvram/fw_cfg.c b/hw/nvram/fw_cfg.c
> index 3b1811d3bf..dfa1f2012a 100644
> --- a/hw/nvram/fw_cfg.c
> +++ b/hw/nvram/fw_cfg.c
> @@ -1035,7 +1035,6 @@ void *fw_cfg_modify_file(FWCfgState *s, const char =
*filename,
>  void fw_cfg_add_from_generator(FWCfgState *s, const char *filename,
>                                 const char *gen_id, Error **errp)
>  {
> -    ERRP_GUARD();
>      FWCfgDataGeneratorClass *klass;
>      GByteArray *array;
>      Object *obj;
> @@ -1053,7 +1052,7 @@ void fw_cfg_add_from_generator(FWCfgState *s, const=
 char *filename,
>      }
>      klass =3D FW_CFG_DATA_GENERATOR_GET_CLASS(obj);
>      array =3D klass->get_data(obj, errp);
> -    if (*errp) {
> +    if (!array) {
>          return;
>      }
>      size =3D array->len;

Reviewed-by: Markus Armbruster <armbru@redhat.com>


