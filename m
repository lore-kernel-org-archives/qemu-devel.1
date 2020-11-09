Return-Path: <SRS0=6joO=EP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DC18C2D0A3
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 18:41:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD852206B2
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 18:41:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Wq9qaLKP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD852206B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43080 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kcC6x-0001PD-Oi
	for qemu-devel@archiver.kernel.org; Mon, 09 Nov 2020 13:41:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54612)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kcC3b-0008Dw-44
 for qemu-devel@nongnu.org; Mon, 09 Nov 2020 13:38:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:23463)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kcC3Y-0001Ej-Hp
 for qemu-devel@nongnu.org; Mon, 09 Nov 2020 13:38:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604947098;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Nc05G8cnmvItlUqI1zoO4jy/Jq3L+6aeiqAfExhU2s4=;
 b=Wq9qaLKPFLzPw3a3Fs/LAkXCS+3MoQ8VQrBAHc9AYwxI8deOJhHTZMm+mfgY2zAzBxTX8d
 aT7SWmjhxYsbu1uZFgFq7K8Qufn9ilAzTKMeq2qPoq7NdwNDXgAe4eLqQwDu1XFgXZOohd
 e9DTNwU+YxopPIMYOJ7YsihJccdkytc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-287-tGpzdc_LOkuoa_afzWknWQ-1; Mon, 09 Nov 2020 13:38:15 -0500
X-MC-Unique: tGpzdc_LOkuoa_afzWknWQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 41CF4809DDA
 for <qemu-devel@nongnu.org>; Mon,  9 Nov 2020 18:38:14 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-103.ams2.redhat.com
 [10.36.112.103])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 126BF6EF4A;
 Mon,  9 Nov 2020 18:38:14 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 8DC231132BD6; Mon,  9 Nov 2020 19:38:12 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v2 4/6] qemu-option: clean up id vs. list->merge_lists
References: <20201109133931.979563-1-pbonzini@redhat.com>
 <20201109133931.979563-5-pbonzini@redhat.com>
 <87wnyu4gf9.fsf@dusky.pond.sub.org>
 <736a0053-83b9-3510-82ad-99ea59ea00fe@redhat.com>
Date: Mon, 09 Nov 2020 19:38:12 +0100
In-Reply-To: <736a0053-83b9-3510-82ad-99ea59ea00fe@redhat.com> (Paolo
 Bonzini's message of "Mon, 9 Nov 2020 18:17:49 +0100")
Message-ID: <87a6vq4bqj.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Received-SPF: pass client-ip=216.205.24.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/09 00:04:29
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

> On 09/11/20 17:56, Markus Armbruster wrote:
>> Just like any other QemuOptsList, "machine" may have any number of
>> QemuOpts.  The ones with non-null ID happen to be ignored silently.
>> Known[*] trap for the unwary.
>> 
>> Are these all singletons?
>
> They are never qemu_opts_find'd with non-NULL id, so I'd say they are.

We also need to check qemu_opts_foreach().

>> If lists>merge_lists, you no longer check id_wellformed().  Easy enough
>> to fix: lift the check before this conditional.
>
> Intentional: we always error with INVALID_PARAMETER, so it's pointless 
> to check if the id is well-formed.

My head was about to explode, and then it farted instead.  Sorry fore
the noise!

>> After the patch:
>> 
>>     id        fail_if_exists  merge_lists  |  return
>>     non-null  don't care      true         |  fail
>>     null      don't care      true         |  existing or else new opts
>>     non-null  false           false        |  abort
>>     non-null  true            false        |  new opts / fail if exist
>>     null      don't care      false        |  new opts
>> 
>> Still too many 
>
> Discounting the case that aborts as it's not user-controlled (it's 
> "just" a matter of inspecting qemu_opts_create callers), the rest can be 
> summarized as:
>
> - merge_lists = false: singleton opts with NULL id; non-NULL id fails

Do you mean merge_lists = true here, and ...

> - merge_lists = true: always return new opts; non-NULL id fails if dup

... = false here?

>> [*] Known to the QemuOpts cognoscenti, whose number could be
>> embarrasingly close to one.
>
> Maybe not one, but a single hand certainly has a surplus of fingers.
>
> Paolo


