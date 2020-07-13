Return-Path: <SRS0=6r5r=AY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8B6DC433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 10:52:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A7BB420773
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 10:52:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VjWuJDka"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7BB420773
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57278 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1juw4I-0005gy-0R
	for qemu-devel@archiver.kernel.org; Mon, 13 Jul 2020 06:52:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59616)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1juw3d-0005F1-St
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 06:51:37 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:27844
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1juw3b-0003JI-TR
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 06:51:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594637494;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PT9R3dinlgAgKzo5U4/EjsIfvQBLnHvbcmwKLfF7jx0=;
 b=VjWuJDkak1y2O/R5Ic146yqLVFmRm3fIoVVdMChJLj/x7cuJNY8RqMZHnwOQttEm0rArhD
 rJ8oCCV2LQ4e/VMP4XIgRPzrLkTlcrOb6k94t7dr/NYY9TqHldzyF73rwpr+H5lZ2W+kW+
 ZoEzFXB66Mwhqci1CiNMHV26p1jeQ50=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-324-ye_PlQj6OPyY2-f0icquPQ-1; Mon, 13 Jul 2020 06:51:30 -0400
X-MC-Unique: ye_PlQj6OPyY2-f0icquPQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E6E8518FF669;
 Mon, 13 Jul 2020 10:51:28 +0000 (UTC)
Received: from gondolin (ovpn-113-13.ams2.redhat.com [10.36.113.13])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7447961469;
 Mon, 13 Jul 2020 10:51:25 +0000 (UTC)
Date: Mon, 13 Jul 2020 12:51:22 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: Claudio Fontana <cfontana@suse.de>
Subject: Re: [PATCH 3/3] cpu-timers, icount: new modules
Message-ID: <20200713125122.647232d0.cohuck@redhat.com>
In-Reply-To: <c834b040-2365-4c6a-a301-553a1ede3e14@suse.de>
References: <20200629093504.3228-1-cfontana@suse.de>
 <20200629093504.3228-4-cfontana@suse.de>
 <aa45a793-35b1-d3bd-18a8-4c52ad888029@redhat.com>
 <f89f249d-dbc4-779b-5b53-fc408461f072@suse.de>
 <ecf5f26b-ce86-3e13-5c5c-567919433acb@redhat.com>
 <e9dca3d1-f52d-13ce-2d7d-66958bc15765@suse.de>
 <d0bc3f23-98c0-eadb-55ed-3377f43c494a@suse.de>
 <20200710083356.4c6e9f78.cohuck@redhat.com>
 <c834b040-2365-4c6a-a301-553a1ede3e14@suse.de>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=cohuck@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/13 01:36:29
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
Cc: "Jason J. Herne" <jjherne@linux.ibm.com>,
 Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Colin Xu <colin.xu@intel.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 qemu-devel@nongnu.org, Roman Bolshakov <r.bolshakov@yadro.com>,
 haxm-team@intel.com, Wenchao Wang <wenchao.wang@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Sunil Muthuswamy <sunilmut@microsoft.com>,
 Alex =?UTF-8?B?QmVubsOpZQ==?= <alex.bennee@linaro.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, 11 Jul 2020 13:40:50 +0200
Claudio Fontana <cfontana@suse.de> wrote:

> I found out something that for me shows that more investigation here is warranted.
> 
> 
> Here is my latest workaround for the problem:
> 
> 
> 
> diff --git a/hw/s390x/s390-skeys.c b/hw/s390x/s390-skeys.c
> index 1e036cc602..47c9a015af 100644
> --- a/hw/s390x/s390-skeys.c
> +++ b/hw/s390x/s390-skeys.c
> @@ -252,6 +252,8 @@ static const TypeInfo qemu_s390_skeys_info = {
>      .class_size    = sizeof(S390SKeysClass),
>  };
>  
> +extern void qemu_fflush(QEMUFile *f);
> +
>  static void s390_storage_keys_save(QEMUFile *f, void *opaque)
>  {
>      S390SKeysState *ss = S390_SKEYS(opaque);
> @@ -302,6 +304,7 @@ static void s390_storage_keys_save(QEMUFile *f, void *opaque)
>      g_free(buf);
>  end_stream:
>      qemu_put_be64(f, eos);
> +    qemu_fflush(f);
>  }
>  
>  static int s390_storage_keys_load(QEMUFile *f, void *opaque, int version_id)
> ------------------------------------------------------------------------------------
> 
> 
> I think that this might imply that my patch changing the migration stream has only triggered an existing problem.

Looks a bit like it.

> 
> The sympthom is: the load keys code does not see the EOS (byte value 1).
> It does see the keys (which are all empty in the test, ie 32678 times the byte value 0). 

Yes, that (zero keys) is expected.

> 
> The workaround for the sympthom: flush the qemu file after putting the EOS in there.
> 
> 
> Any ideas on where to investigate next?

Do any other users of the SaveVMHandlers interface see errors as well
(or do they do the fflush dance)?


