Return-Path: <SRS0=MAm8=C6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CE4FC43466
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 14:39:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD44F2220C
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 14:39:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E6cXUsr8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD44F2220C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48928 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKMyJ-0001fM-Jy
	for qemu-devel@archiver.kernel.org; Mon, 21 Sep 2020 10:39:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49932)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kKMv1-0007hA-V3
 for qemu-devel@nongnu.org; Mon, 21 Sep 2020 10:35:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:37308)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kKMuz-0004rq-Ih
 for qemu-devel@nongnu.org; Mon, 21 Sep 2020 10:35:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600698947;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2iXbH2X87LHTglFgYOwkdcUT1bvB5TmmjrpQjywet5U=;
 b=E6cXUsr8utMmN899Oplvk8Ni+Ps9I7K5inPool4fZ8wYOVCxiRVfpvz3XuEjKGrImn57WL
 zojwukzP7nomHnsTWQCguEcMOB6wFr8+twwlIPfYC3seORv9kJuTbXLccpRZewykbwS3M4
 cbRObMJ/vJKe74tgCaitIXZgJNn5m2c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-269-QAFPz1Y0Pk2-W1bEjlIK_w-1; Mon, 21 Sep 2020 10:35:43 -0400
X-MC-Unique: QAFPz1Y0Pk2-W1bEjlIK_w-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2062A8015A5;
 Mon, 21 Sep 2020 14:35:42 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-114-66.ams2.redhat.com
 [10.36.114.66])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E2A9F10013BD;
 Mon, 21 Sep 2020 14:35:41 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 6B8A41132E9A; Mon, 21 Sep 2020 16:35:40 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Peter Krempa <pkrempa@redhat.com>
Subject: Re: [PATCH v5 1/8] qemu-options: New -compat to set policy for
 deprecated interfaces
References: <20200914084802.4185028-1-armbru@redhat.com>
 <20200914084802.4185028-2-armbru@redhat.com>
 <20200914115038.GV2486@angien.pipo.sk>
Date: Mon, 21 Sep 2020 16:35:40 +0200
In-Reply-To: <20200914115038.GV2486@angien.pipo.sk> (Peter Krempa's message of
 "Mon, 14 Sep 2020 13:50:38 +0200")
Message-ID: <87pn6f19kz.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Received-SPF: pass client-ip=216.205.24.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/21 01:43:11
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
Cc: marcandre.lureau@gmail.com, qemu-devel@nongnu.org,
 mdroth@linux.vnet.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Peter Krempa <pkrempa@redhat.com> writes:

> On Mon, Sep 14, 2020 at 10:47:55 +0200, Markus Armbruster wrote:
>> Policy is separate for input and output.
>> 
>> Input policy can be "accept" (accept silently), or "reject" (reject
>> the request with an error).
>> 
>> Output policy can be "accept" (pass on unchanged), or "hide" (filter
>> out the deprecated parts).
>> 
>> Default is "accept".  Policies other than "accept" are implemented
>> later in this series.
>> 
>> For now, -compat covers only syntactic aspects of QMP, i.e. stuff
>> tagged with feature 'deprecated'.  We may want to extend it to cover
>> semantic aspects, CLI, and experimental features.
>> 
>> The option is experimental.
>> 
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>
> I wasn't able to find any good anchor point which would allow me to
> detect that this command line option/feature is present.
>
> Is there anything in e.g. in query-qmp-schema or query-command-line-options
> I could base this capability on?

You asked this in review of v4.  I didn't have a ready answer then, and
forgot to figure out a solution before I post v5.  Thanks for the
reminder!


