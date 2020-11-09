Return-Path: <SRS0=6joO=EP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BC4DC2D0A3
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 18:53:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B0B9A2064C
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 18:53:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bOaNcNmf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0B9A2064C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33214 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kcCIU-0001H9-Oi
	for qemu-devel@archiver.kernel.org; Mon, 09 Nov 2020 13:53:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57362)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kcCHj-0008RG-1s
 for qemu-devel@nongnu.org; Mon, 09 Nov 2020 13:52:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:21497)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kcCHh-0002xY-9P
 for qemu-devel@nongnu.org; Mon, 09 Nov 2020 13:52:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604947976;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CdzxM0vLHPWxsN2B5BEJBJlUPcBQebA/Q2IsxDh1nA4=;
 b=bOaNcNmfyWqkDWEsGOiZWgl0lrChGSGwHtcQhgF1xyzwlrsjFkbrPSrGINKQw/Y6fgijPR
 QxdiHQpA+jUmE4wsAFf5zewJH2ap6EWin1C2uj0znbe1IA5MOTmxz3+zn367G+LxLVBfC8
 ewhdJ6/NHUjSer6v2Pa+dKYRLORPcIo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-594-fKKj3t3XOVaEa9sk3Wc81g-1; Mon, 09 Nov 2020 13:52:54 -0500
X-MC-Unique: fKKj3t3XOVaEa9sk3Wc81g-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1ABE3835B49
 for <qemu-devel@nongnu.org>; Mon,  9 Nov 2020 18:52:53 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-103.ams2.redhat.com
 [10.36.112.103])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id DF51B5B4A7;
 Mon,  9 Nov 2020 18:52:52 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 602AC1132BD6; Mon,  9 Nov 2020 19:52:51 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v2 3/6] qemu-option: restrict qemu_opts_set to
 merge-lists QemuOpts
References: <20201109133931.979563-1-pbonzini@redhat.com>
 <20201109133931.979563-4-pbonzini@redhat.com>
 <87eel25xud.fsf@dusky.pond.sub.org>
 <0defd899-184d-549e-a799-7000f7b9c92d@redhat.com>
Date: Mon, 09 Nov 2020 19:52:51 +0100
In-Reply-To: <0defd899-184d-549e-a799-7000f7b9c92d@redhat.com> (Paolo
 Bonzini's message of "Mon, 9 Nov 2020 17:21:34 +0100")
Message-ID: <874kly4b24.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Received-SPF: pass client-ip=63.128.21.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/09 01:25:23
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Paolo Bonzini <pbonzini@redhat.com> writes:

> On 09/11/20 16:55, Markus Armbruster wrote:
>>>           QemuOptsList *net = qemu_find_opts("net");
>>> -        qemu_opts_set(net, NULL, "type", "nic", &error_abort);
>>> +        qemu_opts_parse(net, "nic", true, &error_abort);
>>>   #ifdef CONFIG_SLIRP
>>> -        qemu_opts_set(net, NULL, "type", "user", &error_abort);
>>> +        qemu_opts_parse(net, "user", true, &error_abort);
>>>   #endif
>>>       }
>>>   
>> Looks safe to me, but I don't quite get why you switch to
>> qemu_opts_parse().  The commit message explains it is "so that
>> qemu_opts_set is now only used on merge-lists QemuOptsList (for which it
>> makes the most sense indeed)..."  Is there anything wrong with using ot
>> on non-merge-lists QemuOptsList?
>
> I would *expect* a function named qemu_opts_set to do two things:
>
> 1. setting an option in a merge-lists QemuOptsList, such as -kernel.
>
> This is indeed what we mostly use qemu_opts_set for.
>
>
> 2. setting an option in a non-merge-lists QemuOptsList with non-NULL
> id, similar to -set.
>
> QEMU does not use qemu_opts_set for the latter (see qemu_set_option)
> because it wants to use qemu_opts_find rather than qemu_opts_create.
> In fact it wouldn't *work* to use qemu_opts_set for the latter because 
> qemu_opts_set uses fail_if_exists==1. So:
>
>    -> For non-merge-lists QemuOptsList and non-NULL id, it is
>       debatable that qemu_opts_set fails if the (QemuOptsList, id)
>       pair already exists
>
>
> On the other hand, I would not *expect* qemu_opts_set to create a
> non-merge-lists QemuOpts with a single option; which it does, though. 
> This leads us directly to:
>
>    -> For non-merge-lists QemuOptsList and NULL id, qemu_opts_set
>       hardly adds value over qemu_opts_parse.  It does skip some
>       parsing and unescaping, but its two call sites don't really care.
>
> So qemu_opts_set has warty behavior for non-merge-lists QemuOptsList
> if id is non-NULL, and it's mostly pointless if id is NULL.  My
> solution to keeping the API as simple as possible is to limit
> qemu_opts_set to merge-lists QemuOptsList.  For them, it's useful (we
> don't want comma-unescaping for -kernel) *and* has sane semantics.

Okay, makes sense.

Do you think working (some of) this into commit message would be worth
your while?

>>> +    g_assert(!QTAILQ_EMPTY(&list->head));
>>> +
>>> +    /* set it again */
>>> +    qemu_opts_set(list, "str3", "value", &error_abort);
>>>      g_assert(!QTAILQ_EMPTY(&list->head));
>> This one not.
>> What are you trying to accomplish?
>
> Improve the testcase, though I should have mentioned it in the commit
> message.  Basically emulating "-kernel bc -kernel def".

Worth testing.  But the case "-kernel bc" is also worth testing.
test_qemu_opts_get() tests both:

    /* haven't set anything to str2 yet */
    opt = qemu_opt_get(opts, "str2");
    g_assert(opt == NULL);

    qemu_opt_set(opts, "str2", "value", &error_abort);

    /* now we have set str2, should know about it */
    opt = qemu_opt_get(opts, "str2");
    g_assert_cmpstr(opt, ==, "value");

    qemu_opt_set(opts, "str2", "value2", &error_abort);

    /* having reset the value, the returned should be the reset one */
    opt = qemu_opt_get(opts, "str2");
    g_assert_cmpstr(opt, ==, "value2");

I'm okay with not improving the test in this patch, or with strictly
extending coverage, preferably in a separate patch that goes before this
one.


