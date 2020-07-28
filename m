Return-Path: <SRS0=L+nc=BH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0895C433E8
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 15:45:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C0B9920A8B
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 15:45:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fLJUuW24"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0B9920A8B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54134 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0RnA-0007UD-W5
	for qemu-devel@archiver.kernel.org; Tue, 28 Jul 2020 11:45:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53000)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1k0RmM-0006yj-Ly
 for qemu-devel@nongnu.org; Tue, 28 Jul 2020 11:44:34 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:58930
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1k0RmK-0005TH-Gh
 for qemu-devel@nongnu.org; Tue, 28 Jul 2020 11:44:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595951071;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oX0MDNmbez7Vo9omv9rLXT2ENPzORxiz9rHy2FeZttw=;
 b=fLJUuW24VPtsnjCbZZ6FDZ7aTqwlA7Le1w2b6N0OGwLPazNJbebEgVzFk4pRU+TWbbnrMj
 pIFl0zHBCnhiLKH0ueNpNw6SDVjCPNGBFU3fQMHNLOryuLMQo1Gsey2o/49TFGZxnmjAoR
 4Z1mp61EgtpbywIs3eMNqDis9As7YK0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-37-wNmlRL1SMDqTEZ87Sj-Mjw-1; Tue, 28 Jul 2020 11:44:27 -0400
X-MC-Unique: wNmlRL1SMDqTEZ87Sj-Mjw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 37D3D10CE790
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2020 15:44:26 +0000 (UTC)
Received: from [10.10.118.248] (ovpn-118-248.rdu2.redhat.com [10.10.118.248])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 27603726BE;
 Tue, 28 Jul 2020 15:44:22 +0000 (UTC)
Subject: Re: Missing qapi_free_Type in error case for qapi generated code?
To: Christophe de Dinechin <dinechin@redhat.com>, qemu-devel@nongnu.org
References: <ly4kprhd8e.fsf@redhat.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <fe8f0bd6-ed47-08b8-d7c9-fc40c32b0bb2@redhat.com>
Date: Tue, 28 Jul 2020 10:44:21 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <ly4kprhd8e.fsf@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=eblake@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=eblake@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/28 10:28:27
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/28/20 10:26 AM, Christophe de Dinechin wrote:
> The qapi generated code for qmp_marshal_query_spice seems to be missing a
> resource deallocation for "retval". For example, for SpiceInfo:
> 

>      retval = qmp_query_spice(&err);
>      error_propagate(errp, err);
>      if (err) {
> /* retval not freed here */

Because it should be NULL here.  Returning an error AND an object is 
frowned on.

> /* Missing: qapi_free_SpiceInfo(retval); */
>          goto out;
>      }
> 
>      qmp_marshal_output_SpiceInfo(retval, ret, errp);

And here, retval was non-NULL, but is cleaned as a side-effect of 
qmp_marshal_output_SpiceInfo.

> 
> out:

So no matter how you get to the label, retval is no longer valid memory 
that can be leaked.

>      visit_free(v);
>      v = qapi_dealloc_visitor_new();
>      visit_start_struct(v, NULL, NULL, 0, NULL);
>      visit_end_struct(v, NULL);
>      visit_free(v);
> }
> #endif /* defined(CONFIG_SPICE) */
> 
> Questions:
> 
> - Is the query code supposed to always return NULL in case of error?

Yes.  If not, that is a bug in qmp_query_spice.

> In the
>    case of hmp_info_spice, there is no check for info==NULL, so on the
>    contrary, it seems to indicate that a non-null result is always expected,
>    and that function does call qapi_free_SpiceInfo

Calling qapi_free_SpiceInfo(NULL) is a safe no-op.  Or if you expect the 
function to always succeed, you could pass &error_abort as the errp 
parameter.

> 
> - If not, is there an existing shortcut to generate the correct deallocation
>    code for return types that need it? You can't just use
>    qapi_free_%(c_type)s because that would generate an extra * character,
>    i.e. I get "SpiceInfo *" and not "SpiceInfo".

Ah, you're debating about editing scripts/qapi/commands.py.  If 
anything, an edit to add 'assert(!retval)' if qmp_COMMAND failed might 
be smarter than trying to add code to free retval.

> 
> - If not, is there any good way to know if the type is a pointer type?
>    (A quick look in cripts/qapi/types.py does not show anything obvious)

Look at scripts/qapi/schema.py; each QAPI metatype has implementations 
of .c_name and .c_type that determine how to represent that QAPI object 
in C.  You probably want c_name instead of c_type when constructing the 
name of a qapi_free_FOO function, but that goes back to my question of 
whether such a call is even needed.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


