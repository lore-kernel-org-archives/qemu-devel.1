Return-Path: <SRS0=wjGh=DT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 774B3C433E7
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 11:16:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BBDDB2076E
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 11:16:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HaP08ggn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBDDB2076E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33154 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kRvof-0002s8-PG
	for qemu-devel@archiver.kernel.org; Mon, 12 Oct 2020 07:16:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36198)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kRvn3-0001mM-1r
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 07:14:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:23054)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kRvmy-0004Tm-FA
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 07:14:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602501287;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sS8MdiuZ6ByTm+Dz+JJ+U+xwR8tP0YU0nNmOC2b6c5g=;
 b=HaP08ggnUqnW4RZHBIS51TH6ZqOj1frwPga1Qo+vYvenEs0dPR+hemirNYn448znTNdYY4
 f4IFFszgGR1Tl0/Ik5tyWA3h4WQYiVYCtDtwDV6R+ewcika00XUyfxzvsw7P71inWlmdQ+
 j65DaAPftkETjHF2HlfTmQOVluS/V4s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-334-aA6kZ43bO6i8OhhOfpWwVA-1; Mon, 12 Oct 2020 07:14:43 -0400
X-MC-Unique: aA6kZ43bO6i8OhhOfpWwVA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9FBA61018F60;
 Mon, 12 Oct 2020 11:14:42 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-113-22.ams2.redhat.com [10.36.113.22])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 48E9410013BD;
 Mon, 12 Oct 2020 11:14:35 +0000 (UTC)
Subject: Re: [PATCH v7 02/13] qtest: Reintroduce qtest_qmp_receive
To: Maxim Levitsky <mlevitsk@redhat.com>, qemu-devel@nongnu.org
References: <20201006123904.610658-1-mlevitsk@redhat.com>
 <20201006123904.610658-3-mlevitsk@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <3dd3b467-6784-470c-cbfb-b7baf611abde@redhat.com>
Date: Mon, 12 Oct 2020 13:14:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20201006123904.610658-3-mlevitsk@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/12 02:58:41
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Fam Zheng <fam@euphon.net>, Laurent Vivier <lvivier@redhat.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>,
 Stefan Berger <stefanb@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 06/10/2020 14.38, Maxim Levitsky wrote:
> The new qtest_qmp_receive buffers all the received qmp events, allowing
> qtest_qmp_eventwait_ref to return them.
> 
> This is intended to solve the race in regard to ordering of qmp events
> vs qmp responses, as soon as the callers start using the new interface.
> 
> In addition to that, define qtest_qmp_event_ref a function which only scans
> the buffer that qtest_qmp_receive stores the events to.
> 
> This is intended for callers that are only interested in events that were
> received during the last call to the qtest_qmp_receive.
> 
> Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
> ---
>  tests/qtest/libqos/libqtest.h | 23 ++++++++++++++++
>  tests/qtest/libqtest.c        | 49 ++++++++++++++++++++++++++++++++++-
>  2 files changed, 71 insertions(+), 1 deletion(-)
> 
> diff --git a/tests/qtest/libqos/libqtest.h b/tests/qtest/libqos/libqtest.h
> index a41135fc92..19429a536d 100644
> --- a/tests/qtest/libqos/libqtest.h
> +++ b/tests/qtest/libqos/libqtest.h
> @@ -198,6 +198,16 @@ void qtest_qmp_vsend(QTestState *s, const char *fmt, va_list ap)
>   */
>  QDict *qtest_qmp_receive_dict(QTestState *s);
>  
> +/**
> + * qtest_qmp_receive:
> + * @s: #QTestState instance to operate on.
> + *
> + * Reads a QMP message from QEMU and returns the response.
> + * Buffers all the events received meanwhile, until a
> + * call to qtest_qmp_eventwait
> + */
> +QDict *qtest_qmp_receive(QTestState *s);

Re-introducing qtest_qmp_receive() with different behavior than before will
likely make backports of other later patches a pain, and might also break
other patches that use this function but are not merged yet. Could you
please use a different name for this function instead? Maye
qtest_qmp_receive_buffered() or something like that?

 Thomas


