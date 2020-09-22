Return-Path: <SRS0=0j61=C7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11063C4363D
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 15:04:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 645522395C
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 15:04:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W6Jwnb2c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 645522395C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35058 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKjqB-0002vj-3y
	for qemu-devel@archiver.kernel.org; Tue, 22 Sep 2020 11:04:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57216)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kKjmC-0000zM-Rw
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 11:00:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:40503)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kKjmA-000362-EJ
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 11:00:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600786812;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=29GqdKINYkxB8GZy9gUdnMmKqi/QIZlOo9JLTFvn2oU=;
 b=W6Jwnb2cOvibXI0vs1c8UBOuabZE2SjWirsOphKM3Qx0J5s32ZUGWtquzAAgnrvwK6qski
 Aq1iy5YDmAJkLj5IEdmi57g9jSEVt1RJkWvRPIXQtxEIPktFgYwinoD+FTTEidllNrfzCx
 rhU6vBIb9pmZhTP5LVQDW5P/1TV5x8A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-474-pnWjh_MgOi6HVhgusxRH5w-1; Tue, 22 Sep 2020 11:00:07 -0400
X-MC-Unique: pnWjh_MgOi6HVhgusxRH5w-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1DA161882FA8;
 Tue, 22 Sep 2020 15:00:05 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-114-66.ams2.redhat.com
 [10.36.114.66])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9EBB31A7D2;
 Tue, 22 Sep 2020 14:59:57 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 31E9C1132E9A; Tue, 22 Sep 2020 16:59:56 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH] PoC: Rust binding for QAPI (qemu-ga only, for now)
References: <20200910174850.716104-1-marcandre.lureau@redhat.com>
 <87mu1j8p7p.fsf@dusky.pond.sub.org>
 <33bf618f-9c0d-b34f-cc55-35f4c35e8296@redhat.com>
Date: Tue, 22 Sep 2020 16:59:56 +0200
In-Reply-To: <33bf618f-9c0d-b34f-cc55-35f4c35e8296@redhat.com> (Paolo
 Bonzini's message of "Mon, 21 Sep 2020 11:30:15 +0200")
Message-ID: <87blhxluvn.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Received-SPF: pass client-ip=63.128.21.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/22 02:07:04
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.455,
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
Cc: berrange@redhat.com, slp@redhat.com, stefanha@gmail.com,
 qemu-devel@nongnu.org, marcandre.lureau@redhat.com, jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Paolo Bonzini <pbonzini@redhat.com> writes:

> On 21/09/20 11:16, Markus Armbruster wrote:
>> QMP is an *external* interface.
>> 
>> It supports compatible evolution: we can make certain kinds of changes
>> without affecting clients.  These include:
>> 
>> * Adding optional arguments
>> 
>> * Adding results
>> 
>> * Adding values to an enumeration type, branches to a union or
>>   alternate
>> 
>> * Reordering members of enumerations, structs, unions
>> 
>> * Turning an argument type into an alternate with the old type as branch
>> 
>> We've made use of this extensively.  See also
>> docs/devel/qapi-code-gen.txt section "Compatibility considerations."
>> 
>> How do such changes affect clients of the proposed D-Bus interface?
>
> All this makes me think that Q{MP,OM,API} badly needs rationale
> documentation.

docs/devel/qapi-code-gen.txt is fairly thorough (>8000 words), but it
doesn't try to serve as rationale documentation.


