Return-Path: <SRS0=EQsI=67=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69420C433DF
	for <qemu-devel@archiver.kernel.org>; Sun, 17 May 2020 17:54:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2423C20758
	for <qemu-devel@archiver.kernel.org>; Sun, 17 May 2020 17:53:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Lhe3Nucd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2423C20758
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46020 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jaNU7-0001F1-5l
	for qemu-devel@archiver.kernel.org; Sun, 17 May 2020 13:53:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36232)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlevitsk@redhat.com>)
 id 1jaNTG-0000Mt-Dv
 for qemu-devel@nongnu.org; Sun, 17 May 2020 13:53:06 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:20541
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mlevitsk@redhat.com>)
 id 1jaNTF-0004NV-Ck
 for qemu-devel@nongnu.org; Sun, 17 May 2020 13:53:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589737984;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=APCK7N+qvDEJ0ffzvloxS4uB0YP2wYZpYf5E/zZi8kY=;
 b=Lhe3Nucd0Wm0dKfJHWDFAIYWBz/AE+/njIoDOPbHv6+dMBSB1huX4lYDOkFFIKeyS7MVRR
 lUS0t/QreDGf9KMVENC2362J0Nu5ewtybTHiSlWwGXk9lEmFv9GjqqzO8F+ffpHjM54cI/
 4LS4OCxkCLqjo56xAQW+gqi2UEo8uFc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-29-QmAYhO1mMFCI31vkpAtgtg-1; Sun, 17 May 2020 13:53:02 -0400
X-MC-Unique: QmAYhO1mMFCI31vkpAtgtg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 03FE41009600;
 Sun, 17 May 2020 17:53:02 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.150])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DEBCD5C1B2;
 Sun, 17 May 2020 17:52:59 +0000 (UTC)
Message-ID: <fc17897adb9429dd3e8c182cad973904164d11d0.camel@redhat.com>
Subject: Re: [PATCH v6 05/14] block/amend: refactor qcow2 amend options
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org
Date: Sun, 17 May 2020 20:52:58 +0300
In-Reply-To: <0a7e43b3-0404-92f4-feb0-389275791a7e@redhat.com>
References: <20200510134037.18487-1-mlevitsk@redhat.com>
 <20200510134037.18487-6-mlevitsk@redhat.com>
 <0a7e43b3-0404-92f4-feb0-389275791a7e@redhat.com>
Mime-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=mlevitsk@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/17 13:26:55
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 "Daniel P. =?ISO-8859-1?Q?Berrang=E9?=" <berrange@redhat.com>,
 qemu-block@nongnu.org, John Snow <jsnow@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 2020-05-14 at 15:36 +0200, Max Reitz wrote:
> On 10.05.20 15:40, Maxim Levitsky wrote:
> > Some qcow2 create options can't be used for amend.
> > Remove them from the qcow2 create options and add generic logic to detect
> > such options in qemu-img
> > 
> > Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
> > Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
> > ---
> >  block/qcow2.c              | 108 ++++++---------------
> >  qemu-img.c                 |  18 +++-
> >  tests/qemu-iotests/049.out | 102 ++++++++++----------
> >  tests/qemu-iotests/061.out |  12 ++-
> >  tests/qemu-iotests/079.out |  18 ++--
> >  tests/qemu-iotests/082.out | 149 ++++------------------------
> >  tests/qemu-iotests/085.out |  38 ++++----
> >  tests/qemu-iotests/087.out |   6 +-
> >  tests/qemu-iotests/115.out |   2 +-
> >  tests/qemu-iotests/121.out |   4 +-
> >  tests/qemu-iotests/125.out | 192 ++++++++++++++++++-------------------
> >  tests/qemu-iotests/134.out |   2 +-
> >  tests/qemu-iotests/144.out |   4 +-
> >  tests/qemu-iotests/158.out |   4 +-
> >  tests/qemu-iotests/182.out |   2 +-
> >  tests/qemu-iotests/185.out |   8 +-
> >  tests/qemu-iotests/188.out |   2 +-
> >  tests/qemu-iotests/189.out |   4 +-
> >  tests/qemu-iotests/198.out |   4 +-
> >  tests/qemu-iotests/243.out |  16 ++--
> >  tests/qemu-iotests/250.out |   2 +-
> >  tests/qemu-iotests/255.out |   8 +-
> >  tests/qemu-iotests/259.out |   2 +-
> >  tests/qemu-iotests/263.out |   4 +-
> >  tests/qemu-iotests/280.out |   2 +-
> 
> These reference output hunks need some rebasing due to the new
> compression_type option.
Done. I so hope to get it merged so I won't need to rebase it again :-)

> 
> >  25 files changed, 284 insertions(+), 429 deletions(-)
> > 
> > diff --git a/block/qcow2.c b/block/qcow2.c
> > index fc494c7591..db86500839 100644
> > --- a/block/qcow2.c
> > +++ b/block/qcow2.c
> 
> [...]
> 
> > @@ -5552,37 +5506,6 @@ void qcow2_signal_corruption(BlockDriverState *bs, bool fatal, int64_t offset,
> >          .help = "The external data file must stay valid "           \
> >                  "as a raw image"                                    \
> >      },                                                              \
> > -    {                                                               \
> > -        .name = BLOCK_OPT_ENCRYPT,                                  \
> > -        .type = QEMU_OPT_BOOL,                                      \
> > -        .help = "Encrypt the image with format 'aes'. (Deprecated " \
> > -                "in favor of " BLOCK_OPT_ENCRYPT_FORMAT "=aes)",    \
> > -    },                                                              \
> > -    {                                                               \
> > -        .name = BLOCK_OPT_ENCRYPT_FORMAT,                           \
> > -        .type = QEMU_OPT_STRING,                                    \
> > -        .help = "Encrypt the image, format choices: 'aes', 'luks'", \
> > -    },                                                              \
> > -    BLOCK_CRYPTO_OPT_DEF_KEY_SECRET("encrypt.",                     \
> > -        "ID of secret providing qcow AES key or LUKS passphrase"),  \
> > -    BLOCK_CRYPTO_OPT_DEF_LUKS_CIPHER_ALG("encrypt."),               \
> > -    BLOCK_CRYPTO_OPT_DEF_LUKS_CIPHER_MODE("encrypt."),              \
> > -    BLOCK_CRYPTO_OPT_DEF_LUKS_IVGEN_ALG("encrypt."),                \
> > -    BLOCK_CRYPTO_OPT_DEF_LUKS_IVGEN_HASH_ALG("encrypt."),           \
> > -    BLOCK_CRYPTO_OPT_DEF_LUKS_HASH_ALG("encrypt."),                 \
> > -    BLOCK_CRYPTO_OPT_DEF_LUKS_ITER_TIME("encrypt."),                \
> > -    {                                                               \
> > -        .name = BLOCK_OPT_CLUSTER_SIZE,                             \
> > -        .type = QEMU_OPT_SIZE,                                      \
> > -        .help = "qcow2 cluster size",                               \
> > -        .def_value_str = stringify(DEFAULT_CLUSTER_SIZE)            \
> > -    },                                                              \
> > -    {                                                               \
> > -        .name = BLOCK_OPT_PREALLOC,                                 \
> > -        .type = QEMU_OPT_STRING,                                    \
> > -        .help = "Preallocation mode (allowed values: off, "         \
> > -                "metadata, falloc, full)"                           \
> > -    },                                                              \
> >      {                                                               \
> >          .name = BLOCK_OPT_LAZY_REFCOUNTS,                           \
> >          .type = QEMU_OPT_BOOL,                                      \
> > @@ -5600,6 +5523,37 @@ static QemuOptsList qcow2_create_opts = {
> >      .name = "qcow2-create-opts",
> >      .head = QTAILQ_HEAD_INITIALIZER(qcow2_create_opts.head),
> >      .desc = {
> > +        {                                                               \
> > +            .name = BLOCK_OPT_ENCRYPT,                                  \
> > +            .type = QEMU_OPT_BOOL,                                      \
> > +            .help = "Encrypt the image with format 'aes'. (Deprecated " \
> > +                    "in favor of " BLOCK_OPT_ENCRYPT_FORMAT "=aes)",    \
> > +        },                                                              \
> > +        {                                                               \
> > +            .name = BLOCK_OPT_ENCRYPT_FORMAT,                           \
> > +            .type = QEMU_OPT_STRING,                                    \
> > +            .help = "Encrypt the image, format choices: 'aes', 'luks'", \
> > +        },                                                              \
> > +        BLOCK_CRYPTO_OPT_DEF_KEY_SECRET("encrypt.",                     \
> > +            "ID of secret providing qcow AES key or LUKS passphrase"),  \
> > +        BLOCK_CRYPTO_OPT_DEF_LUKS_CIPHER_ALG("encrypt."),               \
> > +        BLOCK_CRYPTO_OPT_DEF_LUKS_CIPHER_MODE("encrypt."),              \
> > +        BLOCK_CRYPTO_OPT_DEF_LUKS_IVGEN_ALG("encrypt."),                \
> > +        BLOCK_CRYPTO_OPT_DEF_LUKS_IVGEN_HASH_ALG("encrypt."),           \
> > +        BLOCK_CRYPTO_OPT_DEF_LUKS_HASH_ALG("encrypt."),                 \
> > +        BLOCK_CRYPTO_OPT_DEF_LUKS_ITER_TIME("encrypt."),                \
> > +        {                                                               \
> > +            .name = BLOCK_OPT_CLUSTER_SIZE,                             \
> > +            .type = QEMU_OPT_SIZE,                                      \
> > +            .help = "qcow2 cluster size",                               \
> > +            .def_value_str = stringify(DEFAULT_CLUSTER_SIZE)            \
> > +        },                                                              \
> > +        {                                                               \
> > +            .name = BLOCK_OPT_PREALLOC,                                 \
> > +            .type = QEMU_OPT_STRING,                                    \
> > +            .help = "Preallocation mode (allowed values: off, "         \
> > +                    "metadata, falloc, full)"                           \
> > +        },                                                              \
> 
> compression_type should now be moved as well.
Done

> 
> >          QCOW_COMMON_OPTIONS,
> >          { /* end of list */ }
> >      }
> > diff --git a/qemu-img.c b/qemu-img.c
> > index 8f69366f03..b291081249 100644
> > --- a/qemu-img.c
> > +++ b/qemu-img.c
> > @@ -3939,9 +3939,8 @@ static int print_amend_option_help(const char *format)
> >      /* Every driver supporting amendment must have amend_opts */
> >      assert(drv->amend_opts);
> >  
> > -    printf("Creation options for '%s':\n", format);
> > +    printf("Amend options for '%s':\n", format);
> >      qemu_opts_print_help(drv->amend_opts, false);
> > -    printf("\nNote that not all of these options may be amendable.\n");
> >      return 0;
> 
> Hm, this hunk would make more sense in the previous patch, but in
> practice it’s better here, because it’s only in this patch that
> amend_opts is actually limited (compared to create_opts).
Agree. I can move this here, but I also agree that it doesn't matter.

> 
> >  }
> >  
> > @@ -4087,7 +4086,22 @@ static int img_amend(int argc, char **argv)
> >      amend_opts = qemu_opts_append(amend_opts, bs->drv->amend_opts);
> >      opts = qemu_opts_create(amend_opts, NULL, 0, &error_abort);
> >      qemu_opts_do_parse(opts, options, NULL, &err);
> > +
> >      if (err) {
> > +        /* Try to parse options using the create options*/
> 
> Missing a space before the closing asterisk.
Fixed
> 
> > +        Error *err1 = NULL;
> > +        amend_opts = qemu_opts_append(amend_opts, bs->drv->create_opts);
> > +        qemu_opts_del(opts);
> > +        opts = qemu_opts_create(amend_opts, NULL, 0, &error_abort);
> > +        qemu_opts_do_parse(opts, options, NULL, &err1);
> > +
> > +        if (!err1) {
> > +            error_append_hint(&err,
> > +                              "This option is only supported for image creation\n");
> > +        } else {
> > +            error_free(err1);
> > +        }
> 
> I’m not sure whether this is really that helpful, but, well, why not,
> now that you’ve already written the code for it.
Yep. It still better that nothing.

> 
> Max
> 
> > +
> >          error_report_err(err);
> >          ret = -1;
> >          goto out
> 
> 

Best regards,
	Maxim Levitsky



