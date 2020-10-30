Return-Path: <SRS0=q+n2=EF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D756BC4741F
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 07:00:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D863021734
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 07:00:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iCzRJ4Ui"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D863021734
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46858 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kYOOL-0001Dm-Is
	for qemu-devel@archiver.kernel.org; Fri, 30 Oct 2020 03:00:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59104)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kYOMu-0000ma-1C
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 02:58:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:58106)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kYOMs-0000qa-4F
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 02:58:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604041110;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Do/ZhYm7vtYO1jR5EySMQYJcxgCmrpo6m89qdmse/oQ=;
 b=iCzRJ4UiXNyY09BfxnVwRtN6YjP75QzE2Qq3IrEPFMSNfZzDw44X/7VDDgWw493zyLOuts
 YYy0nVyY0c/bB3N7oR38VEoW1wGW7tIq/V1Z98RHoDVAMVTS+FflMkNfZ293HSeqeY8Z2T
 DFBCHDUvJzfoguOFS33dBkOlgUWuK9U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-517-l0SE7I1uN4qiycYXD2dUPw-1; Fri, 30 Oct 2020 02:58:26 -0400
X-MC-Unique: l0SE7I1uN4qiycYXD2dUPw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8DA6A64150;
 Fri, 30 Oct 2020 06:58:25 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-182.ams2.redhat.com
 [10.36.112.182])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 38B386EF62;
 Fri, 30 Oct 2020 06:58:19 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id C2CDC113865F; Fri, 30 Oct 2020 07:58:17 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 07/11] sockets: Fix default of UnixSocketAddress member
 @tight
References: <20201029133833.3450220-1-armbru@redhat.com>
 <20201029133833.3450220-8-armbru@redhat.com>
 <5d93ee2c-e041-6905-56cd-fc96205e37b8@redhat.com>
 <67c5fe06-c846-70d8-2ffc-761c80f95ef8@redhat.com>
Date: Fri, 30 Oct 2020 07:58:17 +0100
In-Reply-To: <67c5fe06-c846-70d8-2ffc-761c80f95ef8@redhat.com> (Paolo
 Bonzini's message of "Thu, 29 Oct 2020 19:05:04 +0100")
Message-ID: <87v9esyzcm.fsf@dusky.pond.sub.org>
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
 qemu-devel@nongnu.org, kraxel@redhat.com, marcandre.lureau@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Paolo Bonzini <pbonzini@redhat.com> writes:

> On 29/10/20 18:39, Paolo Bonzini wrote:
>>> When @tight was set to false as it should be, absent @tight defaults
>>> to false.  Wrong, it should default to true.  This is what breaks QMP.
>> When @has_tight...
>
> Ah, I see what you meant here.  Suggested reword:
>
> ---------
> An optional bool member of a QAPI struct can be false, true, or absent.
> The previous commit demonstrated that socket_listen() and
> socket_connect() are broken for absent @tight, and indeed QMP chardev-
> add also defaults absent member @tight to false instead of true.
>
> In C, QAPI members are represented by two fields, has_MEMBER and MEMBER.
> We have:
>
> 	    has_MEMBER    MEMBER
>     false         true	   false
>     true	  true	   false
>     absent	 false	false/ignore
>
> When has_MEMBER is false, MEMBER should be set to false on write, and
> ignored on read.
>
> For QMP, the QAPI visitors handle absent @tight by setting both
> @has_tight and @tight to false.  unix_listen_saddr() and
> unix_connect_saddr() however use @tight only, disregarding @has_tight.
> This is wrong and means that absent @tight defaults to false whereas it
> should default to true.
>
> The same is true for @has_abstract, though @abstract defaults to
> false and therefore has the same behavior for all of QMP, HMP and CLI.
> Fix unix_listen_saddr() and unix_connect_saddr() to check
> @has_abstract/@has_tight, and to default absent @tight to true.
>
> However, this is only half of the story.  HMP chardev-add and CLI
> -chardev so far correctly defaulted @tight to true, but defaults to
> false again with the above fix for HMP and CLI.  In fact, the "tight"
> and "abstract" options now break completely.
>
> Digging deeper, we find that qemu_chr_parse_socket() also ignores
> @has_tight, leaving it false when it sets @tight.  That is also wrong,
> but the two wrongs cancelled out.  Fix qemu_chr_parse_socket() to set
> @has_tight and @has_abstract; writing testcases for HMP and CLI is left
> for another day.
> ---------
>
> Apologies if the last sentence is incorrect. :)

Sold (with the table fixed as per Eric's review)!


