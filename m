Return-Path: <SRS0=SOuJ=D7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.2 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBC79C2D0A3
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Oct 2020 05:39:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B5C02225F
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Oct 2020 05:39:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I0o0X+hx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B5C02225F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38316 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kWCH7-0004ut-8r
	for qemu-devel@archiver.kernel.org; Sat, 24 Oct 2020 01:39:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41426)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kWCFX-0004N0-9U
 for qemu-devel@nongnu.org; Sat, 24 Oct 2020 01:37:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:56076)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kWCFV-0001fD-Jh
 for qemu-devel@nongnu.org; Sat, 24 Oct 2020 01:37:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603517872;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TPp7Vr+rB+tJ7YBUkQ1WwGo6Eu98H29kN7pocMACP4w=;
 b=I0o0X+hxo8qvKj6byqjUGobY2J4x/RE5fhI1NGz5qxKkGaIbGDNUHfV8jbNp6vGkwRxTzt
 pZW/Sf5Eek5R8x3IHA4ZAL6WcDXlZgue+Kly1r+bbKHZlNLvnUQTxUWHX/HvYWq6HTFDVq
 /ApAmMV06DAihVkx7YN675c2SW77cnU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-19-gOVV4toKOeueLDDMdRr3hg-1; Sat, 24 Oct 2020 01:37:50 -0400
X-MC-Unique: gOVV4toKOeueLDDMdRr3hg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CCC62804B83;
 Sat, 24 Oct 2020 05:37:49 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-112-13.ams2.redhat.com [10.36.112.13])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D2AED55774;
 Sat, 24 Oct 2020 05:37:44 +0000 (UTC)
Subject: Re: [PATCH 3/4] libqtest: fix memory leak in the qtest_qmp_event_ref
To: Maxim Levitsky <mlevitsk@redhat.com>, qemu-devel@nongnu.org
References: <20201019163702.471239-1-mlevitsk@redhat.com>
 <20201019163702.471239-4-mlevitsk@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <9cbca6ed-e5a7-8606-0714-5ef08f87693a@redhat.com>
Date: Sat, 24 Oct 2020 07:37:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20201019163702.471239-4-mlevitsk@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/24 01:17:57
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.108, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
Cc: Kevin Wolf <kwolf@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org,
 Max Reitz <mreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 19/10/2020 18.37, Maxim Levitsky wrote:
> The g_list_remove_link doesn't free the link element,
> opposed to what I thought.
> Switch to g_list_delete_link that does free it.
> 
> Also refactor the code a bit.
> Thanks for Max Reitz for helping me with this.
> 
> Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
> ---
>  tests/qtest/libqtest.c | 11 ++++-------
>  1 file changed, 4 insertions(+), 7 deletions(-)
> 
> diff --git a/tests/qtest/libqtest.c b/tests/qtest/libqtest.c
> index bd96cb6fdd..9ae052d566 100644
> --- a/tests/qtest/libqtest.c
> +++ b/tests/qtest/libqtest.c
> @@ -795,15 +795,12 @@ void qtest_qmp_send_raw(QTestState *s, const char *fmt, ...)
>  
>  QDict *qtest_qmp_event_ref(QTestState *s, const char *event)
>  {
> -    GList *next = NULL;
> -    QDict *response;
> -
> -    for (GList *it = s->pending_events; it != NULL; it = next) {
> +    while (s->pending_events) {
>  
> -        next = it->next;
> -        response = (QDict *)it->data;
> +        GList *first = s->pending_events;
> +        QDict *response = (QDict *)first->data;
>  
> -        s->pending_events = g_list_remove_link(s->pending_events, it);
> +        s->pending_events = g_list_delete_link(s->pending_events, first);
>  
>          if (!strcmp(qdict_get_str(response, "event"), event)) {
>              return response;
> 

Thanks, queued (together with patch 2) to qtest-next:

 https://gitlab.com/huth/qemu/-/commits/qtest-next/

 Thomas


