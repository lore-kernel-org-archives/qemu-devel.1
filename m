Return-Path: <SRS0=e3er=AV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BEBDC433E3
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 12:48:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CC06A2077D
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 12:48:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Kzc4ig+z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC06A2077D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49758 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtsSA-0003so-4G
	for qemu-devel@archiver.kernel.org; Fri, 10 Jul 2020 08:48:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43300)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jtsR3-0002XK-8O
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 08:47:25 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:24653
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jtsQz-0006tO-EA
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 08:47:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594385239;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TMbh7ncc7Pr71ciNJTLZOwujQPhrLUJWBXqlGt+Xalc=;
 b=Kzc4ig+zVgGNT0of7JASQWKT/43q1bbfK53yrkvT0xjOC5XEjYXCtb6kkbWQH6MFPWDF5B
 zYeiBTRwpKJzsQWgy8OM4qIcWS5ngw7aMgcmbtpm2M9qP9epi1sJ5H8u38k2UNXuXDc5nH
 ZV2/b6mqO23a0zRE/vewQbxxqHgnM70=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-408-1v_QbkIPPX6jxY9dB1EBLA-1; Fri, 10 Jul 2020 08:47:18 -0400
X-MC-Unique: 1v_QbkIPPX6jxY9dB1EBLA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 229E410059AF;
 Fri, 10 Jul 2020 12:47:17 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-143.ams2.redhat.com
 [10.36.112.143])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C2AC06111F;
 Fri, 10 Jul 2020 12:47:16 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 49B1B1132FD2; Fri, 10 Jul 2020 14:47:15 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PULL 00/53] Error reporting patches patches for 2020-07-07
References: <20200707212503.1495927-1-armbru@redhat.com>
Date: Fri, 10 Jul 2020 14:47:15 +0200
In-Reply-To: <20200707212503.1495927-1-armbru@redhat.com> (Markus Armbruster's
 message of "Tue, 7 Jul 2020 23:24:10 +0200")
Message-ID: <874kqfo7u4.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Received-SPF: pass client-ip=205.139.110.61; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/09 22:08:55
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This now conflicts with master (b6d7e9b66f5).

Conflict #1: include/hw/audio/pcspk.h

    2336172d9b "audio: set default value for pcspk.iobase property"

    2336172d9b audio: set default value for pcspk.iobase property
    diff --git a/include/hw/audio/pcspk.h b/include/hw/audio/pcspk.h
    index 8b48560267..06cba00b83 100644
    --- a/include/hw/audio/pcspk.h
    +++ b/include/hw/audio/pcspk.h
    @@ -33,11 +33,7 @@

     static inline void pcspk_init(ISADevice *isadev, ISABus *bus, ISADevice *pit)
     {
    -    DeviceState *dev;
    -
    -    dev = DEVICE(isadev);
    -    qdev_prop_set_uint32(dev, "iobase", 0x61);
    -    object_property_set_link(OBJECT(dev), OBJECT(pit), "pit", NULL);
    +    object_property_set_link(OBJECT(isadev), OBJECT(pit), "pit", NULL);
         isa_realize_and_unref(isadev, bus, &error_fatal);
     }

    9eb2af7743 qom: Put name parameter before value / visitor parameter
    diff --git a/include/hw/audio/pcspk.h b/include/hw/audio/pcspk.h
    index 7e7f5f49dc..6386491288 100644
    --- a/include/hw/audio/pcspk.h
    +++ b/include/hw/audio/pcspk.h
    @@ -39,7 +39,7 @@ static inline ISADevice *pcspk_init(ISABus *bus, ISADevice *pit)
         isadev = isa_new(TYPE_PC_SPEAKER);
         dev = DEVICE(isadev);
         qdev_prop_set_uint32(dev, "iobase", 0x61);
    -    object_property_set_link(OBJECT(dev), OBJECT(pit), "pit", NULL);
    +    object_property_set_link(OBJECT(dev), "pit", OBJECT(pit), NULL);
         isa_realize_and_unref(isadev, bus, &error_fatal);

         return isadev;

Resolution is trivial, just redo 9eb2af7743's swap of the arguments:

    static inline void pcspk_init(ISADevice *isadev, ISABus *bus, ISADevice *pit)
    {
        object_property_set_link(OBJECT(isadev), "pit", OBJECT(pit), NULL);
        isa_realize_and_unref(isadev, bus, &error_fatal);
    }

Conflict #2: qemu-img.c

    0b6786a9c1 block/amend: refactor qcow2 amend options
    diff --git a/qemu-img.c b/qemu-img.c
    index 1a0a85089b..7f4938a5ef 100644
    --- a/qemu-img.c
    +++ b/qemu-img.c
    [...]
    @@ -4219,7 +4218,22 @@ static int img_amend(int argc, char **argv)
         amend_opts = qemu_opts_append(amend_opts, bs->drv->amend_opts);
         opts = qemu_opts_create(amend_opts, NULL, 0, &error_abort);
         qemu_opts_do_parse(opts, options, NULL, &err);
    +
         if (err) {
    +        /* Try to parse options using the create options */
    +        Error *err1 = NULL;
    +        amend_opts = qemu_opts_append(amend_opts, bs->drv->create_opts);
    +        qemu_opts_del(opts);
    +        opts = qemu_opts_create(amend_opts, NULL, 0, &error_abort);
    +        qemu_opts_do_parse(opts, options, NULL, &err1);
    +
    +        if (!err1) {
    +            error_append_hint(&err,
    +                              "This option is only supported for image creation\n");
    +        } else {
    +            error_free(err1);
    +        }
    +
             error_report_err(err);
             ret = -1;
             goto out;

    0bc2a50e17 qemu-option: Use returned bool to check for failure
    diff --git a/qemu-img.c b/qemu-img.c
    index bdb9f6aa46..fc405ee171 100644
    --- a/qemu-img.c
    +++ b/qemu-img.c
    [...]
    @@ -4212,8 +4209,7 @@ static int img_amend(int argc, char **argv)

         create_opts = qemu_opts_append(create_opts, bs->drv->create_opts);
         opts = qemu_opts_create(create_opts, NULL, 0, &error_abort);
    -    qemu_opts_do_parse(opts, options, NULL, &err);
    -    if (err) {
    +    if (!qemu_opts_do_parse(opts, options, NULL, &err)) {
             error_report_err(err);
             ret = -1;
             goto out;

Simply rerunning latter commit' Coccinelle script on master's version
would be possible, but suboptimal, because the former commit adds an
awkward error ignore a rebase would clean up.  Manual resolution:

        amend_opts = qemu_opts_append(amend_opts, bs->drv->amend_opts);
        opts = qemu_opts_create(amend_opts, NULL, 0, &error_abort);
        if (!qemu_opts_do_parse(opts, options, NULL, &err)) {
            /* Try to parse options using the create options */
            amend_opts = qemu_opts_append(amend_opts, bs->drv->create_opts);
            qemu_opts_del(opts);
            opts = qemu_opts_create(amend_opts, NULL, 0, &error_abort);
            if (qemu_opts_do_parse(opts, options, NULL, NULL)) {
                error_append_hint(&err,
                                  "This option is only supported for image creation\n");
            }

            error_report_err(err);
            ret = -1;
            goto out;
        }

If you'd prefer a rebased pull request, let me know.

Tests are still running.


