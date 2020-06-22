Return-Path: <SRS0=TEh4=AD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60102C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 08:20:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3085C206FA
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 08:20:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Jm4EIcve"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3085C206FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55402 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnHgw-0007Lp-FL
	for qemu-devel@archiver.kernel.org; Mon, 22 Jun 2020 04:20:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60150)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jnHg4-0006MD-PD
 for qemu-devel@nongnu.org; Mon, 22 Jun 2020 04:19:40 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:21145
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jnHg3-0007MS-1e
 for qemu-devel@nongnu.org; Mon, 22 Jun 2020 04:19:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592813977;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HBfNkhiLZwq94RrXGsptsFaKNi0i8m86p0ud9sgUBVs=;
 b=Jm4EIcves7zclHMDybar5+moYW6yNgp7FsqJ/fB2j4L9w8Eyrer0RBPU9O+NDOHUa1Idkf
 eoNJknDxASadnqMrLGJq4yV52dFB/AIZuRExmC/fIDleFLvWaPVl8M71fRKDkcQs85XWSR
 sRIImLIQYzTGd+Yocong+T5NqtUNMOc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-192-DcRYl1tBMwCgPksz9tb6Yg-1; Mon, 22 Jun 2020 04:19:35 -0400
X-MC-Unique: DcRYl1tBMwCgPksz9tb6Yg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B2ABE107ACCA;
 Mon, 22 Jun 2020 08:19:34 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-121.ams2.redhat.com
 [10.36.112.121])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6BCFD5D9DD;
 Mon, 22 Jun 2020 08:19:34 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 9759C113846D; Mon, 22 Jun 2020 10:19:31 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: Memory leak in spapr_machine_init()?
References: <874kr8uakm.fsf@dusky.pond.sub.org>
 <20200619041334.GI17085@umbus.fritz.box>
Date: Mon, 22 Jun 2020 10:19:31 +0200
In-Reply-To: <20200619041334.GI17085@umbus.fritz.box> (David Gibson's message
 of "Fri, 19 Jun 2020 14:13:34 +1000")
Message-ID: <87ftanpl64.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Received-SPF: pass client-ip=205.139.110.61; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/22 03:17:49
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: David Gibson <dgibson@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

David Gibson <david@gibson.dropbear.id.au> writes:

> On Thu, Jun 18, 2020 at 08:55:53AM +0200, Markus Armbruster wrote:
>> Either I'm confused (quite possible), or kvmppc_check_papr_resize_hpt()
>> can leak an Error object on failure.  Please walk through the code with
>> me:
>> 
>>         kvmppc_check_papr_resize_hpt(&resize_hpt_err);
>> 
>> This sets @resize_hpt_err on failure.
>> 
>>         if (spapr->resize_hpt == SPAPR_RESIZE_HPT_DEFAULT) {
>>             /*
>>              * If the user explicitly requested a mode we should either
>>              * supply it, or fail completely (which we do below).  But if
>>              * it's not set explicitly, we reset our mode to something
>>              * that works
>>              */
>>             if (resize_hpt_err) {
>>                 spapr->resize_hpt = SPAPR_RESIZE_HPT_DISABLED;
>>                 error_free(resize_hpt_err);
>>                 resize_hpt_err = NULL;
>> 
>> Case 1: failure and SPAPR_RESIZE_HPT_DEFAULT; we free @resize_hpt_err.
>> Good.
>> 
>>             } else {
>>                 spapr->resize_hpt = smc->resize_hpt_default;
>>             }
>>         }
>> 
>>         assert(spapr->resize_hpt != SPAPR_RESIZE_HPT_DEFAULT);
>> 
>>         if ((spapr->resize_hpt != SPAPR_RESIZE_HPT_DISABLED) && resize_hpt_err) {
>>             /*
>>              * User requested HPT resize, but this host can't supply it.  Bail out
>>              */
>>             error_report_err(resize_hpt_err);
>>             exit(1);
>> 
>> Case 2: failure and not SPAPR_RESIZE_HPT_DISABLED; fatal.  Good.
>> 
>>         }
>> 
>> What about case 3: failure and SPAPR_RESIZE_HPT_DISABLED?
>> 
>> Good if we get here via case 1 (we freed @resize_hpt_err).
>> 
>> Else, ???
>
> I think you're right, and we leak it in this case - I think I forgot
> that in the DISABLED case we still (unnecessarily) ask the kernel if
> it can do it.
>
> Of course, it will only happen once per run, so it's not like it's a
> particularly noticeable leak.

Understood.  I'll post a patch.  Thanks!


