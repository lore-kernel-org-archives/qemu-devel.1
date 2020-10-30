Return-Path: <SRS0=q+n2=EF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83C43C00A89
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 06:42:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF84A22202
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 06:42:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KIIZ8XYH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF84A22202
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41562 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kYO7R-0006JR-Ns
	for qemu-devel@archiver.kernel.org; Fri, 30 Oct 2020 02:42:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56912)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kYO66-0005lA-FP
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 02:41:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:59315)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kYO62-00038d-Iu
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 02:41:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604040069;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=OtwcZgwlBvukonv4n60ssfQjzURFxCU+gKlUNrrgPtE=;
 b=KIIZ8XYHy+pOD+tFMpMMx8yqRLznLT/b8bI/JXSPotscTojgB6XnoTH+iDTGrBcHLOb8hz
 AaweRNXTKAYvMTUgdlqtO0Qi1HuVfpxmBysp86QN5zdcAzh0NyqM/QcWwCBJVY9vUVR9Ta
 XCzR3aaYs8R1dCFiVNgmnz91V5jCesk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-465-6gjbxp0IMdmfIx0xxJN5Hg-1; Fri, 30 Oct 2020 02:41:06 -0400
X-MC-Unique: 6gjbxp0IMdmfIx0xxJN5Hg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 84D11107AFAE;
 Fri, 30 Oct 2020 06:41:05 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-182.ams2.redhat.com
 [10.36.112.182])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A03D65B4CD;
 Fri, 30 Oct 2020 06:40:59 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 25E59113865F; Fri, 30 Oct 2020 07:40:58 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH 05/11] test-util-sockets: Synchronize properly, don't
 sleep(1)
References: <20201029133833.3450220-1-armbru@redhat.com>
 <20201029133833.3450220-6-armbru@redhat.com>
 <bbac60a2-c4d9-f3c8-dcb4-2822b5b0b9ba@redhat.com>
Date: Fri, 30 Oct 2020 07:40:58 +0100
In-Reply-To: <bbac60a2-c4d9-f3c8-dcb4-2822b5b0b9ba@redhat.com> (Eric Blake's
 message of "Thu, 29 Oct 2020 13:54:51 -0500")
Message-ID: <875z6s1ait.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Received-SPF: pass client-ip=216.205.24.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/30 02:24:40
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
Cc: kwolf@redhat.com, berrange@redhat.com, zxq_yx_007@163.com,
 qemu-devel@nongnu.org, kraxel@redhat.com, marcandre.lureau@redhat.com,
 pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Eric Blake <eblake@redhat.com> writes:

> On 10/29/20 8:38 AM, Markus Armbruster wrote:
>> The abstract sockets test spawns a thread to listen and a accept, and
>
> s/and a/and/

Yes.

>> a second one to connect, with a sleep(1) in between to "ensure" the
>> former is listening when the latter tries to connect.  Review fail.
>> Risks spurious test failure, say when a heavily loaded machine doesn't
>> schedule the first thread quickly enough.  It's also slow.
>> 
>> Listen and accept in the main thread, and start the connect thread in
>> between.  Look ma, no sleep!  Run time drops from 2s wall clock to a
>> few milliseconds.
>> 
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>>  tests/test-util-sockets.c | 39 +++++++++++++--------------------------
>>  1 file changed, 13 insertions(+), 26 deletions(-)
>> 
>
> Reviewed-by: Eric Blake <eblake@redhat.com>

Thanks!


