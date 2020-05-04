Return-Path: <SRS0=Vgkn=6S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1880CC3A5A9
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 15:32:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D8348206B9
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 15:32:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U6HrLAPY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8348206B9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38770 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVd5S-0000JF-TQ
	for qemu-devel@archiver.kernel.org; Mon, 04 May 2020 11:32:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60198)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1jVd2W-0004Nm-BF
 for qemu-devel@nongnu.org; Mon, 04 May 2020 11:29:52 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:34742
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1jVd2S-0003x2-IS
 for qemu-devel@nongnu.org; Mon, 04 May 2020 11:29:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588606187;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/H5UYLTRo9DhynH1mcRW1Piwc1wVgsu1NejML7yFThc=;
 b=U6HrLAPY3fiLmjmzpz8sHF7ZhjOrH5nTiBiNcLRdFKa30XHbaYrCxvi+Sr+eArMoKhq0KJ
 1nG+OaSMTkxHiCs6nVlQaG9gdUjvrCQRZI9MfUd2c9bKN8EtTdWCo3VEuXn3KSCMYPDyE0
 V9mOydBTCPksyGq6UEW6XmkbT5xOQUc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-302-_b7LuIkcNpSnkZgHM29y0w-1; Mon, 04 May 2020 11:29:45 -0400
X-MC-Unique: _b7LuIkcNpSnkZgHM29y0w-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8719F45F
 for <qemu-devel@nongnu.org>; Mon,  4 May 2020 15:29:44 +0000 (UTC)
Received: from gondolin (ovpn-112-215.ams2.redhat.com [10.36.112.215])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 28BDC60C80;
 Mon,  4 May 2020 15:29:40 +0000 (UTC)
Date: Mon, 4 May 2020 17:29:38 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH 03/11] s390x/cpumodel: Fix harmless misuse of
 visit_check_struct()
Message-ID: <20200504172938.00fba6de.cohuck@redhat.com>
In-Reply-To: <87pnbjzpro.fsf@dusky.pond.sub.org>
References: <20200424192027.11404-1-armbru@redhat.com>
 <20200424192027.11404-4-armbru@redhat.com>
 <57392357-7422-180f-d965-3f7bf3e657c2@redhat.com>
 <875zdix2k7.fsf@dusky.pond.sub.org>
 <20200504130957.517336fb.cohuck@redhat.com>
 <87pnbjzpro.fsf@dusky.pond.sub.org>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=cohuck@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/04 01:21:32
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
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
Cc: qemu-devel@nongnu.org, David Hildenbrand <david@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 04 May 2020 17:24:59 +0200
Markus Armbruster <armbru@redhat.com> wrote:

> Cornelia Huck <cohuck@redhat.com> writes:
> 
> > On Wed, 29 Apr 2020 07:51:04 +0200
> > Markus Armbruster <armbru@redhat.com> wrote:
> >  
> >> David Hildenbrand <david@redhat.com> writes:
> >>   
> >> > On 24.04.20 21:20, Markus Armbruster wrote:    
> >> >> Commit e47970f51d "s390x/cpumodel: Fix query-cpu-model-FOO error API
> >> >> violations" neglected to change visit_end_struct()'s Error ** argument
> >> >> along with the others.  If visit_end_struct() failed, we'd take the    
> >> >
> >> > s/visit_end_struct/visit_check_struct/ ?    
> >> 
> >> Will fix.
> >>   
> >> >> success path.  Fortunately, it can't fail here:
> >> >> qobject_input_check_struct() checks we consumed the whole dictionary,
> >> >> and to get here, we did.  Fix it anyway.    
> >> >
> >> > AFAIKs, if visit_check_struct() failed, we'd still do the memcopy, but
> >> > also report the error. Not nice, not bad.
> >> >
> >> > Reviewed-by: David Hildenbrand <david@redhat.com>    
> >> 
> >> Thanks!  
> >
> > Will you queue this, or shall I queue it?  
> 
> Me taking the complete series through my tree would be easiest for me.
> But I can cope with other maintainers picking up bits.

In that case, have my

Reviewed-by: Cornelia Huck <cohuck@redhat.com>

and feel free to pick up :)


