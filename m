Return-Path: <SRS0=EQsI=67=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB207C433E0
	for <qemu-devel@archiver.kernel.org>; Sun, 17 May 2020 08:55:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7FDA0207EA
	for <qemu-devel@archiver.kernel.org>; Sun, 17 May 2020 08:55:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JtQhiSkm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FDA0207EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40012 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jaF4Z-0005KZ-MQ
	for qemu-devel@archiver.kernel.org; Sun, 17 May 2020 04:55:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35046)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlevitsk@redhat.com>)
 id 1jaF3x-0004qK-Gz
 for qemu-devel@nongnu.org; Sun, 17 May 2020 04:54:25 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:27296
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mlevitsk@redhat.com>)
 id 1jaF3v-0004Wg-MM
 for qemu-devel@nongnu.org; Sun, 17 May 2020 04:54:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589705662;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5+6Jw/HFDoXztaIyOyAXIImP8OwnaObTeqE02KWKEJY=;
 b=JtQhiSkmefHr+bPZL80RjWhNXbmgBrEhK9JsnSJv9Rc3BxdpLq4QFb1ndifujRw4dqZKSY
 xsEq4r9+rirkA4JDzLHiyzj+XsjDKxgQ7LIRATbq1UUoQfRuR/rtf0TCl15PANXfT/x1os
 N9P+cbIF6lDb366EEBzLYZGVIRNvogQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-291-TzwRWHe4PRq643GZ8XZdOA-1; Sun, 17 May 2020 04:54:20 -0400
X-MC-Unique: TzwRWHe4PRq643GZ8XZdOA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CE0AC464;
 Sun, 17 May 2020 08:54:19 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.150])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0694E60BF4;
 Sun, 17 May 2020 08:54:14 +0000 (UTC)
Message-ID: <0a942b6cdb32d4452a6000603eb0a2c4363799d4.camel@redhat.com>
Subject: Re: [PATCH v6 04/14] block/amend: separate amend and create options
 for qemu-img
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org
Date: Sun, 17 May 2020 11:54:13 +0300
In-Reply-To: <5b389390-eadb-e1d6-48f8-be99c2dfad99@redhat.com>
References: <20200510134037.18487-1-mlevitsk@redhat.com>
 <20200510134037.18487-5-mlevitsk@redhat.com>
 <5b389390-eadb-e1d6-48f8-be99c2dfad99@redhat.com>
Mime-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=mlevitsk@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/17 04:47:12
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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

On Thu, 2020-05-14 at 14:28 +0200, Max Reitz wrote:
> On 10.05.20 15:40, Maxim Levitsky wrote:
> > Some options are only useful for creation
> > (or hard to be amended, like cluster size for qcow2), while some other
> > options are only useful for amend, like upcoming keyslot management
> > options for luks
> > 
> > Since currently only qcow2 supports amend, move all its options
> > to a common macro and then include it in each action option list.
> > 
> > In future it might be useful to remove some options which are
> > not supported anyway from amend list, which currently
> > cause an error message if amended.
> > 
> > Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
> > Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
> > ---
> >  block/qcow2.c             | 160 +++++++++++++++++++++-----------------
> >  include/block/block_int.h |   4 +
> >  qemu-img.c                |  18 ++---
> >  3 files changed, 100 insertions(+), 82 deletions(-)
> > 
> > diff --git a/block/qcow2.c b/block/qcow2.c
> > index 79fbad9d76..fc494c7591 100644
> > --- a/block/qcow2.c
> > +++ b/block/qcow2.c
> > @@ -5520,83 +5520,96 @@ void qcow2_signal_corruption(BlockDriverState *bs, bool fatal, int64_t offset,
> >      s->signaled_corruption = true;
> >  }
> >  
> > +#define QCOW_COMMON_OPTIONS                                         \
> > +    {                                                               \
> > +        .name = BLOCK_OPT_SIZE,                                     \
> > +        .type = QEMU_OPT_SIZE,                                      \
> > +        .help = "Virtual disk size"                                 \
> > +    },                                                              \
> > +    {                                                               \
> > +        .name = BLOCK_OPT_COMPAT_LEVEL,                             \
> > +        .type = QEMU_OPT_STRING,                                    \
> > +        .help = "Compatibility level (v2 [0.10] or v3 [1.1])"       \
> > +    },                                                              \
> > +    {                                                               \
> > +        .name = BLOCK_OPT_BACKING_FILE,                             \
> > +        .type = QEMU_OPT_STRING,                                    \
> > +        .help = "File name of a base image"                         \
> > +    },                                                              \
> > +    {                                                               \
> > +        .name = BLOCK_OPT_BACKING_FMT,                              \
> > +        .type = QEMU_OPT_STRING,                                    \
> > +        .help = "Image format of the base image"                    \
> > +    },                                                              \
> > +    {                                                               \
> > +        .name = BLOCK_OPT_DATA_FILE,                                \
> > +        .type = QEMU_OPT_STRING,                                    \
> > +        .help = "File name of an external data file"                \
> > +    },                                                              \
> > +    {                                                               \
> > +        .name = BLOCK_OPT_DATA_FILE_RAW,                            \
> > +        .type = QEMU_OPT_BOOL,                                      \
> > +        .help = "The external data file must stay valid "           \
> > +                "as a raw image"                                    \
> > +    },                                                              \
> > +    {                                                               \
> > +        .name = BLOCK_OPT_ENCRYPT,                                  \
> > +        .type = QEMU_OPT_BOOL,                                      \
> > +        .help = "Encrypt the image with format 'aes'. (Deprecated " \
> > +                "in favor of " BLOCK_OPT_ENCRYPT_FORMAT "=aes)",    \
> > +    },                                                              \
> > +    {                                                               \
> > +        .name = BLOCK_OPT_ENCRYPT_FORMAT,                           \
> > +        .type = QEMU_OPT_STRING,                                    \
> > +        .help = "Encrypt the image, format choices: 'aes', 'luks'", \
> > +    },                                                              \
> > +    BLOCK_CRYPTO_OPT_DEF_KEY_SECRET("encrypt.",                     \
> > +        "ID of secret providing qcow AES key or LUKS passphrase"),  \
> > +    BLOCK_CRYPTO_OPT_DEF_LUKS_CIPHER_ALG("encrypt."),               \
> > +    BLOCK_CRYPTO_OPT_DEF_LUKS_CIPHER_MODE("encrypt."),              \
> > +    BLOCK_CRYPTO_OPT_DEF_LUKS_IVGEN_ALG("encrypt."),                \
> > +    BLOCK_CRYPTO_OPT_DEF_LUKS_IVGEN_HASH_ALG("encrypt."),           \
> > +    BLOCK_CRYPTO_OPT_DEF_LUKS_HASH_ALG("encrypt."),                 \
> > +    BLOCK_CRYPTO_OPT_DEF_LUKS_ITER_TIME("encrypt."),                \
> > +    {                                                               \
> > +        .name = BLOCK_OPT_CLUSTER_SIZE,                             \
> > +        .type = QEMU_OPT_SIZE,                                      \
> > +        .help = "qcow2 cluster size",                               \
> > +        .def_value_str = stringify(DEFAULT_CLUSTER_SIZE)            \
> > +    },                                                              \
> > +    {                                                               \
> > +        .name = BLOCK_OPT_PREALLOC,                                 \
> > +        .type = QEMU_OPT_STRING,                                    \
> > +        .help = "Preallocation mode (allowed values: off, "         \
> > +                "metadata, falloc, full)"                           \
> > +    },                                                              \
> > +    {                                                               \
> > +        .name = BLOCK_OPT_LAZY_REFCOUNTS,                           \
> > +        .type = QEMU_OPT_BOOL,                                      \
> > +        .help = "Postpone refcount updates",                        \
> > +        .def_value_str = "off"                                      \
> > +    },                                                              \
> > +    {                                                               \
> > +        .name = BLOCK_OPT_REFCOUNT_BITS,                            \
> > +        .type = QEMU_OPT_NUMBER,                                    \
> > +        .help = "Width of a reference count entry in bits",         \
> > +        .def_value_str = "16"                                       \
> > +    }                                                               \
> 
> I think the last line should have a comma in it (otherwise the final
> backslash doesn’t make much sense, because whenever we’d add a new
> option, we would need to modify the line anyway to insert a comma).
As discussed with Eric Blake, lets leave it as is.

> 
> Speaking of adding option, this requires a rebase due to the
> compression_type option added (not trivial in the strict sense, but
> still straightforward to handle).
Done!
> 
> > +
> >  static QemuOptsList qcow2_create_opts = {
> >      .name = "qcow2-create-opts",
> >      .head = QTAILQ_HEAD_INITIALIZER(qcow2_create_opts.head),
> >      .desc = {
> > 
> 
> [...]
> 
> > +        QCOW_COMMON_OPTIONS,
> > +        { /* end of list */ }
> > +    }
> > +};
> > +
> > +static QemuOptsList qcow2_amend_opts = {
> > +    .name = "qcow2-amend-opts",
> > +    .head = QTAILQ_HEAD_INITIALIZER(qcow2_amend_opts.head),
> > +    .desc = {
> > +        QCOW_COMMON_OPTIONS,
> >          { /* end of list */ }
> 
> If QCOW_COMMON_OPTIONS were to already end in a comma (which I think it
> should), then it would become superfluous here.
> 
> >      }
> >  };
> 
> [...]
> 
> > diff --git a/include/block/block_int.h b/include/block/block_int.h
> > index 952b2f033a..0a71357b50 100644
> > --- a/include/block/block_int.h
> > +++ b/include/block/block_int.h
> > @@ -412,6 +412,10 @@ struct BlockDriver {
> >  
> >      /* List of options for creating images, terminated by name == NULL */
> >      QemuOptsList *create_opts;
> > +
> > +    /* List of options for image amend*/
> 
> I don’t suppose we have a coding style requirement for this, but I still
> think there should be a space before the closing asterisk.
Absolutely! Thanks!

> 
> With those things fixed:
> 
> Reviewed-by: Max Reitz <mreitz@redhat.com>
Thanks!
> 
> > +    QemuOptsList *amend_opts;
> > +
> 
> 

Best regards,
	Maxim Levitsky


